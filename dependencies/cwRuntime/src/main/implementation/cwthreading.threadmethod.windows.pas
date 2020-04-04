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
unit cwThreading.ThreadMethod.Windows;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
{$ifdef MSWINDOWS}
uses
  Windows,
  cwThreading;

type
  TWindowsThreadMethod = class( TInterfacedObject, IThreadMethod )
  private
    fThreadHandle: THandle;
    fRunning: boolean;
    fTerminated: Boolean;
    fThreadedMethod: TThreadExecuteMethod;
  private
    function getExecuteMethod: TThreadExecuteMethod;
    function Terminate( Timeout: uint32 = 25 ): boolean;
  protected
    procedure setExecuteMethod( const value: TThreadExecuteMethod );
    function doExecute: uint32;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;

  end;

{$endif}
implementation
{$ifdef MSWINDOWS}
uses
  cwLog
, cwLog.Standard
, cwRuntime.LogEntries
;

function InternalHandler( threadmethod: pointer ): uint32; stdcall;
begin
  Result := TWindowsThreadMethod(threadmethod).doExecute;
end;

constructor TWindowsThreadMethod.Create;
var
  ThreadID: uint32;
begin
  inherited Create;
  fTerminated := False;
  fThreadedMethod := nil;
  ThreadID := 0;
  fThreadHandle := Windows.CreateThread(nil,0,@InternalHandler,Self,0,ThreadID);
end;

function TWindowsThreadMethod.Terminate( Timeout: uint32 ): boolean;
const
  cMS = 100;
var
  Counter: uint32;
begin
  Result := True;
  if not fRunning then begin
    exit;
  end;
  fTerminated := True;
  Counter := Timeout div cMS;
  while (fRunning) and (Counter>0) do begin
    sleep(cMS);
    dec(Counter);
  end;
  fThreadedMethod := nil;
  Result := not fRunning;
end;

destructor TWindowsThreadMethod.Destroy;
begin
  if not Terminate( 500 ) then begin
    Log.Insert(le_FailedThreadTerminate,lsFatal,['?']);
  end;
  Windows.CloseHandle(fThreadHandle);
  inherited Destroy;
end;

function TWindowsThreadMethod.doExecute: uint32;
var
  fTempThreadedMethod: TThreadExecuteMethod;
begin
  fRunning := True;
  while not fTerminated do begin
    fTempThreadedMethod := fThreadedMethod;
    if assigned(fTempThreadedMethod) then begin
      if not fTempThreadedMethod() then begin
        fTerminated := True;
      end;
    end;
  end;
  fRunning := False;
  Result := 0;
end;

function TWindowsThreadMethod.getExecuteMethod: TThreadExecuteMethod;
begin
  Result := fThreadedMethod;
end;

procedure TWindowsThreadMethod.setExecuteMethod(const value: TThreadExecuteMethod);
begin
  fThreadedMethod := value;
end;

{$endif}
end.
