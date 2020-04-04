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
unit cwThreading.ThreadedLoop.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwCollections
, cwThreading
, cwThreading.ThreadedLoop.Executor
;

type
  TThreadedLoop = class( TInterfacedObject, IThreadedLoop )
  private
    fUserOffset: nativeuint;
    fJobsAreRunning: boolean;
    fExecutors: IList<IThreadLoopExecutor>;
  private
    procedure WaitForThreads;
    procedure TerminateExecutors;
    procedure DistributeWork(const Work: nativeuint);
    procedure KillExecutors(const ThreadExecutor: IThreadLoopExecutor);
  strict private //- IThreadedLoop -//
    procedure Execute( const Method: TThreadedLoopMethod; const Work: nativeuint; const Offset: nativeuint ); overload;
    procedure Execute( const Method: TThreadedLoopMethodOfObject; const Work: nativeuint; const Offset: nativeuint ); overload;
    procedure ExecuteDebug( const Method: TThreadedLoopMethod; const Work: nativeuint; const Offset: nativeuint = 0 ); overload;
    procedure ExecuteDebug( const Method: TThreadedLoopMethodOfObject; const Work: nativeuint; const Offset: nativeuint = 0 ); overload;

  public
    constructor Create( const ThreadCount: uint32 = 0 ); reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  sysutils
, cwCollections.Standard
;

procedure TThreadedLoop.KillExecutors(const ThreadExecutor: IThreadLoopExecutor );
begin
  ThreadExecutor.TerminateExecutor;
end;

procedure TThreadedLoop.WaitForThreads;
var
  idx: nativeuint;
begin
  repeat
    fJobsAreRunning := False;
    for idx := 0 to pred(fExecutors.count) do begin
      if fExecutors[idx].IsJobRunning then begin
        fJobsAreRunning := True;
        Sleep(0);
        break;
      end;
    end;
  until not fJobsAreRunning;
end;


procedure TThreadedLoop.DistributeWork( const Work: nativeuint );
var
  ItemsPerThread: nativeuint;
  Remainder: nativeuint;
  idx,idy: nativeuint;
begin
  idy := 0;
  //- Now work out how much work to give to each thread.
  if Work<fExecutors.Count then begin
    for idx := 0 to pred(Work) do begin
      fExecutors[idx].SetWorkDimensions(idx,succ(idx),Work,fUserOffset);
    end;
  end else begin
    ItemsPerThread := Work div fExecutors.Count;
    Remainder := Work - (ItemsPerThread*fExecutors.Count);
    for idx := 0 to pred(fExecutors.Count) do begin
      fExecutors[idx].SetWorkDimensions( (idx * ItemsPerThread), (succ(idx) * ItemsPerThread), Work,fUserOffset );
    end;
    //- Distribute Remainder over threads
    if Remainder>0 then begin
      for idx := 0 to pred(fExecutors.Count) do begin
        if Remainder>0 then begin
          fExecutors[idx].SetWorkDimensions( fExecutors[idx].getWorkOffset+idx, fExecutors[idx].getWorkTop+succ(idx), Work,fUserOffset );
          dec(Remainder);
          idy := idx;
        end else begin
          fExecutors[idx].SetWorkDimensions( fExecutors[idx].getWorkOffset+succ(idy), fExecutors[idx].getWorkTop+succ(idy), Work,fUserOffset );
        end;
      end;
    end;
  end;
end;

procedure TThreadedLoop.Execute(const Method: TThreadedLoopMethod; const Work: nativeuint; const Offset: nativeuint);
var
  idx: nativeuint;
begin
  if Work=0 then begin
    exit;
  end;
  fUserOffset := Offset;
  DistributeWork( Work );
  for idx := 0 to pred(fExecutors.Count) do begin
    fExecutors[idx].Execute(Method);
  end;
  WaitForThreads;
end;

procedure TThreadedLoop.Execute( const Method: TThreadedLoopMethodOfObject; const Work: nativeuint; const Offset: nativeuint );
var
  idx: nativeuint;
begin
  if Work=0 then begin
    exit;
  end;
  fUserOffset := Offset;
  DistributeWork( Work );
  for idx := 0 to pred(fExecutors.Count) do begin
    fExecutors[idx].Execute(Method);
  end;
  WaitForThreads;
end;

procedure TThreadedLoop.ExecuteDebug(const Method: TThreadedLoopMethod; const Work: nativeuint; const Offset: nativeuint);
begin
  Method(Offset,Offset+Work);
end;

procedure TThreadedLoop.ExecuteDebug(const Method: TThreadedLoopMethodOfObject; const Work: nativeuint; const Offset: nativeuint);
begin
  Method(Offset,Offset+Work);
end;

constructor TThreadedLoop.Create(const ThreadCount: uint32);
var
  idx: uint32;
  DesiredThreads: uint32;
  NewExecutor: IThreadLoopExecutor;
begin
  inherited Create;
  //- Determine the number of threads that are required.
  if ThreadCount=0 then begin
    {$ifdef IOS}
    DesiredThreads := CPUCount;
    {$else}
    DesiredThreads := CPUCount;
    {$endif}
  end else begin
    DesiredThreads := ThreadCount;
  end;
  //- Create the thread executors
  fExecutors := TList<IThreadLoopExecutor>.Create;
  for idx := 0 to pred(DesiredThreads) do begin
    NewExecutor := TThreadLoopExecutor.Create(idx);
    fExecutors.Add(NewExecutor);
  end;
end;

procedure TThreadedLoop.TerminateExecutors;
begin
  //- Terminate executors
  fExecutors.ForEach(KillExecutors);
end;

destructor TThreadedLoop.Destroy;
begin
  TerminateExecutors;
  fExecutors := nil;
  inherited Destroy;
end;

end.

