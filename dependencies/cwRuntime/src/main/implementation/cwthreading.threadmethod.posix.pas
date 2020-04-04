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
unit cwThreading.ThreadMethod.Posix;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
{$ifndef MSWINDOWS}
uses
  pthreads
, unixtype
, dethreading
;

type
  TPosixThreadMethod = class( TInterfacedObject, IThreadMethod )
  private
    fHandle: pthread_t;
    fRunning: boolean;
    fTerminated: Boolean;
    fThreadedMethod: TThreadExecuteMethod;
  strict private //- IThreadMethod -//
    function getExecuteMethod: TThreadExecuteMethod;
    function Terminate( Timeout: uint32 = 25 ): boolean;
  protected
    procedure setExecuteMethod( value: TThreadExecuteMethod );
    function doExecute: uint32;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

{$endif}
implementation
{$ifndef MSWINDOWS}
uses
  SysUtils
, BaseUnix
, deTypes
, deLog
, deLog.Standard
, deRTL.LogEntries
;

const
  cDefaultStackSize = 2097152; // 2MB;

function InternalHandler( threadmethod: pointer ): nativeuint; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}
begin
  Result := TPosixThreadMethod(threadmethod).doExecute;
end;

constructor TPosixThreadMethod.Create;
var
  Attr: pthread_attr_t;
begin
  inherited Create;
  fTerminated := False;
  fThreadedMethod := nil;
  //- Define and create thread.
  if pthread_attr_init(@attr)<>0 then begin
    Log.Insert(le_OSAPIError,lsFatal,['pthread_attr_init',errno.AsString]);
  end;
  if pthread_attr_setstacksize(@attr,cDefaultStackSize)<>0 then begin
    Log.Insert(le_OSAPIError,lsFatal,['pthread_attr_setstacksize',errno.AsString]);
  end;
  if pthread_create(@fHandle,@attr,@InternalHandler,Self)<>0 then begin
    Log.Insert(le_OSAPIError,lsFatal,['pthread_create',errno.AsString]);
  end;
  if pthread_attr_destroy(@attr)<>0 then begin
    Log.Insert(le_OSAPIError,lsFatal,['pthread_attr_destroy',errno.AsString]);
  end;
end;

function TPosixThreadMethod.Terminate( Timeout: uint32 = 25 ): boolean;
var
  Counter: uint32;
begin
  Result := True;
  if not fRunning then begin
    exit;
  end;
  fTerminated := True;
  fThreadedMethod := nil;
  Counter := Timeout div 1;
  while (fRunning) and (Counter>0) do begin
    sleep(1);
    dec(Counter);
  end;
  Result := not fRunning;
end;

destructor TPosixThreadMethod.Destroy;
begin
  if not Terminate( 500 ) then begin
    Log.Insert(le_FailedThreadTerminate,lsFatal,['?']);
  end;
  inherited Destroy;
end;

function TPosixThreadMethod.doExecute: uint32;
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

function TPosixThreadMethod.getExecuteMethod: TThreadExecuteMethod;
begin
  Result := fThreadedMethod;
end;

procedure TPosixThreadMethod.setExecuteMethod(value: TThreadExecuteMethod);
begin
  fThreadedMethod := value;
end;

{$endif}
end.
