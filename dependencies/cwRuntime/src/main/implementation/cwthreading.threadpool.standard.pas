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
unit cwThreading.ThreadPool.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwCollections
, cwThreading
;


type
  TThreadPool = class( TInterfacedObject, IThreadPool )
  private
    fRunning: boolean;
    fThreads: ICollection;
    fThreadMethods: array of IThreadMethod;
  private
    procedure CreateThreadMethods;
    procedure DisposeThreadMethods;
  private //- IThreadPool -//
    function getThreadCount: uint64;
    function getThread( idx: uint64 ): IPoolThread;
    function InstallThread( aThread: IPoolThread ): boolean;
    function Start: boolean;
    procedure Stop;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  cwRuntime.LogEntries
, cwCollections.standard
{$ifdef MSWINDOWS}
, cwThreading.threadmethod.windows
{$else}
, cwThreading.threadmethod.posix
{$endif}
, cwTypes
, cwLog
, cwLog.Standard
;

type
{$ifdef MSWINDOWS}
  TThreadMethod = TWindowsThreadMethod;
{$else}
  TThreadMethod = TPosixThreadMethod;
{$endif}

type
  IPoolThreadList = IList<IPoolThread>;
  TPoolThreadList = TList<IPoolThread>;

type
  TPoolThread = class( TThreadMethod )
  private
    fSubSystem: IPoolThread;
  private
    function InternalExecute: boolean;
  public
    constructor Create( SubSystem: IPoolThread ); reintroduce;
  end;

constructor TPoolThread.Create(SubSystem: IPoolThread);
begin
  inherited Create;
  fSubSystem := SubSystem;
  inherited setExecuteMethod(InternalExecute);
end;

function TPoolThread.InternalExecute: boolean;
begin
  Result := False;
  if not assigned(fSubSystem) then begin
    exit;
  end;
  Result := fSubSystem.Execute;
end;

constructor TThreadPool.Create;
begin
  inherited Create;
  fThreads := TPoolThreadList.Create;
  fRunning := False;
  SetLength(fThreadMethods,0);
end;

procedure TThreadPool.CreateThreadMethods;
var
  idx: uint64;
begin
  if fRunning then begin
    exit;
  end;
  if IPoolThreadList(fThreads).Count=0 then begin
    exit;
  end;
  SetLength(fThreadMethods,IPoolThreadList(fThreads).Count);
  for idx := 0 to pred(IPoolThreadList(fThreads).Count) do begin
    fThreadMethods[idx] := TPoolThread.Create( IPoolThreadList(fThreads).Items[idx] );
  end;
  fRunning := True;
end;

destructor TThreadPool.Destroy;
begin
  if fRunning then begin
    Stop;
  end;
  fRunning := False;
  fThreads := nil;
  SetLength(fThreadMethods,0);
  inherited Destroy;
end;

procedure TThreadPool.DisposeThreadMethods;
var
  idx: int64;
begin
  if not fRunning then begin
    exit;
  end;
  if Length(fThreadMethods)=0 then begin
    exit;
  end;
  for idx := pred(Length(fThreadMethods)) downto 0 do begin
    if not fThreadMethods[idx].Terminate(3000) then begin
      Log.Insert(le_FailedThreadTerminate,lsFatal,[idx.AsString]);
    end;
  end;
end;

function TThreadPool.getThread(idx: uint64): IPoolThread;
begin
  Result := IPoolThreadList(fThreads).Items[idx];
end;

function TThreadPool.getThreadCount: uint64;
begin
  Result := IPoolThreadList(fThreads).Count;
end;

function TThreadPool.InstallThread(aThread: IPoolThread): boolean;
begin
  Result := False;
  if fRunning then begin
    exit;
  end;
  IPoolThreadList(fThreads).Add(aThread);
end;

function TThreadPool.Start: boolean;
var
  idx: int32;
  InitializeFailed: boolean;
begin
  Result := False;
  InitializeFailed := False;
  for idx := 0 to pred(IPoolThreadList(fThreads).Count) do begin
    if not IPoolThreadList(fThreads).Items[idx].Initialize then begin
      InitializeFailed := True;
    end;
  end;
  if InitializeFailed then begin
    Exit;
  end;
   Result := True;
  CreateThreadMethods;
end;

procedure TThreadPool.Stop;
var
  idx: int32;
begin
  DisposeThreadMethods;
  if IPoolThreadList(fThreads).Count=0 then begin
    exit;
  end;
  for idx := 0 to pred(IPoolThreadList(fThreads).Count) do begin
    IPoolThreadList(fThreads).Items[idx].Finalize;
  end;
end;

end.
