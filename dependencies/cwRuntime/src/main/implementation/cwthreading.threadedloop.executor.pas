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
unit cwThreading.ThreadedLoop.Executor;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwThreading
;


type
  IThreadLoopExecutor = interface
    ['{28C414FF-79E1-4243-916C-59BC1F8442DD}']
    function IsJobRunning: boolean;
    function getWorkOffset: nativeuint;
    function getWorkTop: nativeuint;
    procedure SetWorkDimensions( const Offset: nativeuint; const Top: nativeuint; const Total: nativeuint; const UserOffset: nativeuint );
    procedure TerminateExecutor;
    procedure Execute( Method: TThreadedLoopMethod ); overload;
    procedure Execute( Method: TThreadedLoopMethodOfObject ); overload;
  end;

  TThreadLoopExecutor = class( TInterfacedObject, IThreadLoopExecutor )
  private
    fUserOffset: nativeuint;
    fTerminateFlag: boolean;
    fThreadIndex: nativeuint;
    fThreadMethod: IThreadMethod;
    fSleepCS: ISignaledCriticalSection;
  private //- Per Thread -//
    fJobRunning: boolean;
    fWorkOffset: nativeuint;
    fWorkTop: nativeuint;
    fWorkTotal: nativeuint;
    fThreadLoopMethod: TThreadedLoopMethod;
    fThreadLoopMethodOfObject: TThreadedLoopMethodOfObject;
  private //- IThreadLoopExecutor -//
    function IsJobRunning: boolean;
    function getWorkOffset: nativeuint;
    function getWorkTop: nativeuint;
    procedure SetWorkDimensions( const Offset: nativeuint; const Top: nativeuint; const Total: nativeuint; const UserOffset: nativeuint );
    procedure TerminateExecutor;
    procedure Execute( Method: TThreadedLoopMethod ); overload;
    procedure Execute( Method: TThreadedLoopMethodOfObject ); overload;
  private
    function ThreadExecute: boolean;
  strict private //- IThreadLoopExecutor -//
  public
    constructor Create( const ThreadIndex: uint32 ); reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  sysutils
  {$ifdef MSWINDOWS}
, cwThreading.ThreadMethod.Windows
, cwThreading.SignaledCriticalSection.Windows
  {$else}
, cwThreading.threadmethod.Posix
, cwThreading.SignaledCriticalSection.Posix
  {$endif}
;

function TThreadLoopExecutor.IsJobRunning: boolean;
begin
  Result := fJobRunning;
end;

function TThreadLoopExecutor.getWorkOffset: nativeuint;
begin
  Result := fWorkOffset;
end;

function TThreadLoopExecutor.getWorkTop: nativeuint;
begin
  Result := fWorkTop;
end;


procedure TThreadLoopExecutor.SetWorkDimensions(const Offset: nativeuint; const Top: nativeuint; const Total: nativeuint; const UserOffset: nativeuint);
begin
  fUserOffset := UserOffset;
  fWorkTotal := Total;
  fWorkOffset := Offset;
  fWorkTop := Top;
end;

procedure TThreadLoopExecutor.TerminateExecutor;
begin
  fTerminateFlag := True;
  fSleepCS.Wake;
end;

procedure TThreadLoopExecutor.Execute( Method: TThreadedLoopMethod );
begin
  fThreadLoopMethod := Method;
  fThreadLoopMethodOfObject := nil;
  fJobRunning := True;
  fSleepCS.Wake;
end;

procedure TThreadLoopExecutor.Execute(Method: TThreadedLoopMethodOfObject);
begin
  fThreadLoopMethod := nil;
  fThreadLoopMethodOfObject := Method;
  fJobRunning := True;
  fSleepCS.Wake;
end;

function TThreadLoopExecutor.ThreadExecute: boolean;

  function WorkToDo: boolean; inline;
  begin
    Result := (fWorkTop>0);
  end;

begin
  Result := True; // Unless
  fSleepCS.Acquire;
  try
    repeat
      //- Should the executor be terminated?
      if fTerminateFlag then begin
        Result := False;
        exit;
      end;

      //- Should the executor sleep?
      if (not WorkToDo) then begin
        fJobRunning := False;
        fSleepCS.Sleep;
      end;
    until WorkToDo = True;

    {$region ' Do work'}
    if assigned(fThreadLoopMethodOfObject) then begin
      fThreadLoopMethodOfObject( fWorkOffset+fUserOffset, pred(fWorkTop)+fUserOffset );
    end else if assigned(fThreadLoopMethod) then begin
      fThreadLoopMethod( fWorkOffset+fUserOffset, pred(fWorkTop)+fUserOffset );
    end;

    //- We're done with this job.
    fWorkTop := 0;
    fWorkOffset := 0;
    fWorkTotal := 0;
    fJobRunning := False;
    {$endregion}

  finally
    fSleepCS.Release;
  end;
end;

constructor TThreadLoopExecutor.Create(const ThreadIndex: uint32);
begin
  inherited Create;
  fWorkOffset := 0;
  fWorkTop := 0;
  fWorkTotal := 0;
  fThreadIndex := ThreadIndex;
  fTerminateFlag := False;
  fJobRunning := False;
  fSleepCS := TSignaledCriticalSection.Create;
  {$ifdef MSWINDOWS}
  fThreadMethod := TWindowsThreadMethod.Create;
  {$else}
  fThreadMethod := TPosixThreadMethod.Create;
  {$endif}
  fThreadMethod.ExecuteMethod := ThreadExecute;
end;

destructor TThreadLoopExecutor.Destroy;
begin
  fThreadMethod.Terminate;
  fThreadMethod := nil;
  fSleepCS := nil;
  inherited Destroy;
end;

end.

