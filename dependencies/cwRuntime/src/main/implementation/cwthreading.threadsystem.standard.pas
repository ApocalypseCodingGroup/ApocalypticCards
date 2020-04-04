{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )

  Redistribution and use in source and binary forms, with or without modification,
  are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice,
     this list of conditions and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation and/or
     other materials provided with the distribution.

  3. Neither the name of the copyright holder nor the names of its contributors may be
     used to endorse or promote products derived from this software without specific prior
     written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
  IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)
{$endif}
unit cwThreading.ThreadSystem.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwCollections
, cwThreading
;

type
  /// Used internally to install sub-systems into the available pool threads.
  IThreadExecutor = interface
    ['{62101CBD-F657-42F0-A46B-4D22FF453FAE}']
    ///  <summary>
    ///    Returns true if the executor is dedicated to a sub-system already.
    ///  </summary>
    function isDedicated: boolean;
    ///  <summary>
    ///    Set dedicated to prevent additional sub-systems being added.
    ///  </summary>
    procedure setDedicated;
    function getSubSystemCount: uint32;
    function InstallSubSystem( aSubSystem: IThreadSubSystem ): boolean;
  end;

type
  TThreadSystem = class( TInterfacedObject, IThreadSystem )
  private
    fRunning: boolean;
    fMainInitialized: boolean;
    fMessageBus: IMessageBus;
    fThreadPool: IThreadPool;
    fMainThread: IPoolThread;
  strict private //- IThreadSystem -//
    function MessageBus: IMessageBus;
    function InstallSubSystem( aSubSystem: IThreadSubsystem; Into: TInstallInto; ThreadIndex: uint64 = 0 ): boolean;
    procedure Start;
    procedure Stop;
    function Progress: boolean;
    procedure Run;
    function getThreadCount: uint32;
  private
    function FirstEmptyExecutor: IThreadExecutor;
    function LeastUsedExecutor: IThreadExecutor;
  public
    constructor Create( ThreadCount: uint32 = 0 ); reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  SysUtils // [RTL]
, cwThreading.ThreadPool.Standard
, cwThreading.MessageBus.Standard
, cwCollections.Standard
, cwLog
, cwLog.Standard
, cwRuntime.LogEntries
;

type
  IThreadSystemList = IList<IThreadSubSystem>;
  TThreadSystemList = TList<IThreadSubSystem>;

type
  TThreadExecutor = class( TInterfacedObject, IPoolThread, IThreadExecutor )
  private
    fDedicated: boolean;
    fMessageBus: IMessageBus;
    fSubSystems: IThreadSystemList;
  protected
    function IsDedicated: boolean;
    procedure setDedicated;
    function getSubSystemCount: uint32;
    function InstallSubSystem( aSubSystem: IThreadSubSystem ): boolean;
  private
    function Initialize: boolean;
    function Execute: boolean;
    procedure Finalize;
  public
    constructor Create( MessageBus: IMessageBus ); reintroduce;
    destructor Destroy; override;
  end;

type
  IThreadExecutorList = IList<IThreadExecutor>;
  TThreadExecutorList = TList<IThreadExecutor>;

constructor TThreadSystem.Create(ThreadCount: uint32);
var
  idx: uint32;
  DesiredThreads: uint32;
begin
  inherited Create;
  fRunning := False;
  fMainInitialized := False;
  fThreadPool := nil; //- unless required...
  fMessageBus := TMessageBus.Create;
  //- Determine the number of threads that are required.
  if ThreadCount=0 then begin
    {$ifdef IOS}
    DesiredThreads := CPUCount;
    {$else}
    DesiredThreads := CPUCount * 2;
    {$endif}
  end else begin
    DesiredThreads := ThreadCount;
  end;
  //- Install ThreadExecutors for each of the threads.
  if DesiredThreads>1 then begin
    fThreadPool := TThreadPool.Create;
    for idx := 1 to pred(DesiredThreads) do begin
      fThreadPool.InstallThread(TThreadExecutor.Create(fMessageBus));
    end;
  end;
  //- Install a Thread executor for the main thread.
  fMainThread := TThreadExecutor.Create(fMessageBus);
end;

destructor TThreadSystem.Destroy;
begin
  if fRunning then begin
    Stop;
  end;
  fMainThread := nil;
  fThreadPool := nil;
  fMessageBus := nil;
  inherited Destroy;
end;

function TThreadSystem.FirstEmptyExecutor: IThreadExecutor;
var
  Executor: IThreadExecutor;
  idx: uint32;
begin
  Result := nil;
  //- Find first empty auxhiliary thread.
  if assigned(fThreadPool) and (fThreadPool.ThreadCount>0) then begin
    for idx := 0 to pred(fThreadPool.ThreadCount) do begin
      Executor := (fThreadPool.Threads[idx] as IThreadExecutor);
      if Executor.getSubSystemCount=0 then begin
        Result := Executor;
        exit;
      end;
    end;
  end;
end;

function TThreadSystem.getThreadCount: uint32;
begin
  Result := fThreadPool.ThreadCount;
end;

function TThreadSystem.InstallSubSystem( aSubSystem: IThreadSubsystem; Into: TInstallInto; ThreadIndex: uint64 = 0 ): boolean;
var
  Executor: IThreadExecutor;
begin
  Result := False;
  case Into of

    iiMainThreadDedicated: begin
      Executor := (fMainThread as IThreadExecutor);
      if Executor.getSubSystemCount>0 then begin
        exit;
      end;
      if Executor.InstallSubSystem(aSubSystem) then begin
        Executor.setDedicated;
        Result := True;
      end;
    end;

    iiMainThreadShared: begin
      Executor := (fMainThread as IThreadExecutor);
      if Executor.isDedicated then begin
        exit;
      end;
      Result := Executor.InstallSubSystem(aSubSystem);
    end;

    iiAuxThreadDedicated: begin
      //- Find the first empty auxhillary thread and install.
      Executor := FirstEmptyExecutor;
      if not assigned(Executor) then begin
        exit;
      end;
      if Executor.InstallSubsystem(aSubSystem) then begin
        Executor.setDedicated;
        Result := True;
      end;
    end;

    iiAuxThreadShared: begin
      Executor := LeastUsedExecutor;
      if not assigned(Executor) then begin
        exit;
      end;
      Result := Executor.InstallSubSystem(aSubSystem);
    end;

    iiSpecifiedDedicated: begin
      Executor := fThreadPool.Threads[ ThreadIndex ] as IThreadExecutor;
      if (Executor.isDedicated) or (Executor.getSubSystemCount>0) then begin
        exit;
      end;
      if Executor.InstallSubSystem(aSubSystem) then begin
        Executor.setDedicated;
        Result := True;
      end;
    end;

    iiSpecifiedShared: begin
      Executor := fThreadPool.Threads[ ThreadIndex ] as IThreadExecutor;
      Result := Executor.InstallSubSystem(aSubSystem);
    end;

  end;
end;

function TThreadSystem.LeastUsedExecutor: IThreadExecutor;
var
  Executor: IThreadExecutor;
  ExecutorList: IThreadExecutorList;
  LeastUsedIndex: uint32;
  idx: uint32;
begin
  Result := nil;
  //- Build a list of executors which are available and not already dedicated
  ExecutorList := TThreadExecutorList.Create;
  if assigned(fThreadPool) and (fThreadPool.ThreadCount>0) then begin
    for idx := 0 to pred(fThreadPool.ThreadCount) do begin
      Executor := (fThreadPool.Threads[idx] as IThreadExecutor);
      if not Executor.isDedicated then begin
        ExecutorList.Add(Executor);
      end;
    end;
  end;
  //- If there are no executors, this method will fail.
  if ExecutorList.Count=0 then begin
    exit;
  end;
  //- Now find the index of the least used executor.
  LeastUsedIndex := 0;
  if ExecutorList.Count>1 then begin
    for idx := 1 to pred(ExecutorList.Count) do begin
      if ExecutorList.Items[idx].getSubSystemCount<ExecutorList.Items[LeastUsedIndex].getSubSystemCount then begin
        LeastUsedIndex := idx;
      end;
    end;
  end;
  //- Install the new subsystem into the least used executor.
  Result := ExecutorList.Items[LeastUsedIndex];
end;


function TThreadSystem.MessageBus: IMessageBus;
begin
  Result := fMessageBus;
end;

function TThreadSystem.Progress: boolean;
begin
  Result := False;
  if not assigned(fMainThread) then begin
    exit;
  end;
  //- If the main thread has not yet been initialized.
  if not fMainInitialized then begin
    if not fMainThread.Initialize then begin
      exit;
    end;
    fMainInitialized := True;
    Result := True;
    exit;
  end;
  //- Execute one cycle of the main loop.
  Result := fMainThread.Execute;
end;

procedure TThreadSystem.Run;
begin
  Start;
  try
    while Progress do;
  finally
    Stop;
  end;
end;

procedure TThreadSystem.Start;
begin
  if fRunning then begin
    Log.Insert(le_ThreadAlreadyStarted,lsFatal);
  end;
  fRunning := True;
  //- Start auxhillary threads.
  fMessageBus.Enabled := True;
  if assigned(fThreadPool) then begin
    fThreadPool.Start;
  end;
end;

procedure TThreadSystem.Stop;
begin
  if not fRunning then begin
    exit;
  end;
  fRunning := False;
  //- Ensure the message bus is not blocking channels.
  fMessageBus.Enabled := False;
  //- Terminate the auxhillary threads.
  if assigned(fThreadPool) then begin
    fThreadPool.Stop;
  end;
  //- If the main thread was initialized, it must be finalized.
  if fMainInitialized then begin
    if not assigned(fMainThread) then begin
      exit;
    end;
    fMainThread.Finalize;
  end;
end;

{ TThreadExecutor }

constructor TThreadExecutor.Create(MessageBus: IMessageBus);
begin
  inherited Create;
  fDedicated := False;
  fMessageBus := MessageBus;
  fSubSystems := TThreadSystemList.Create;
end;

destructor TThreadExecutor.Destroy;
begin
  fMessageBus := nil;
  inherited Destroy;
end;

function TThreadExecutor.Execute: boolean;
var
  idx: uint64;
  SubSystem: IThreadSubSystem;
begin
  Result := False;
  if fSubSystems.Count=0 then begin
    exit;
  end;
  //- Loop through and execute the subsystems.
  idx := fSubSystems.Count;
  while idx>0 do begin
    SubSystem := fSubSystems[pred(idx)];
    if assigned(SubSystem) then begin
      if not SubSystem.Execute then begin
        //- remove this subsystem.
        SubSystem.Finalize;
        fSubSystems.RemoveItem(pred(idx));
      end;
    end;
    dec(idx);
  end;
  Result := True;
end;

procedure TThreadExecutor.Finalize;
var
  idx: uint32;
begin
  if fSubSystems.Count=0 then begin
    exit;
  end;
  for idx := pred(fSubSystems.Count) downto 0 do begin
    fSubSystems[idx].Finalize;
    fSubSystems.RemoveItem(idx);
  end;
end;

function TThreadExecutor.getSubSystemCount: uint32;
begin
  Result := fSubSystems.Count;
end;

function TThreadExecutor.Initialize: boolean;
var
  idx: uint32;
begin
  Result := True;
  if fSubSystems.Count=0 then begin
    exit;
  end;
  for idx := pred(fSubSystems.Count) downto 0 do begin
    if not fSubSystems[idx].Initialize( fMessageBus ) then begin
      Result := False;
      fSubSystems.RemoveItem(idx);
    end;
  end;
end;

function TThreadExecutor.InstallSubSystem(aSubSystem: IThreadSubSystem): boolean;
begin
  Result := False;
  if not assigned(aSubSystem) then begin
    exit;
  end;
  if not aSubSystem.Install(fMessageBus) then begin
    exit;
  end;
  fSubSystems.Add(aSubSystem);
  Result := True;
end;

function TThreadExecutor.IsDedicated: boolean;
begin
  Result := fDedicated;
end;

procedure TThreadExecutor.setDedicated;
begin
  fDedicated := True;
end;

end.
