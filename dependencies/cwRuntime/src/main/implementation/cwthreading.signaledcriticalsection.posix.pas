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
unit cwThreading.SignaledCriticalSection.Posix;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
{$ifndef MSWINDOWS}
uses
  unixtype
, deThreading
;

type
  TSignaledCriticalSection = class( TInterfacedObject, ISignaledCriticalSection )
  private
    fMutex: pthread_mutex_t;
    fCondition: pthread_cond_t;
  strict private //- ISignaledCriticalSection -//
    procedure Acquire;
    procedure Release;
    procedure Sleep;
    procedure Wake;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

{$endif}
implementation
{$ifndef MSWINDOWS}
uses
  pthreads
, deLog
, deLog.Standard
, deRTL.LogEntries
, BaseUnix
, deTypes
;

procedure TSignaledCriticalSection.Acquire;
begin
  pthread_mutex_lock(@fMutex);
end;

constructor TSignaledCriticalSection.Create;
begin
  inherited Create;
  if pthread_mutex_init(@fMutex, nil)<>0 then begin
    Log.Insert(le_OSAPIError,lsFatal,['pthread_mutex_init',errno.AsString]);
  end;
  if pthread_cond_init(@fCondition,nil)<>0 then begin
    Log.Insert(le_OSAPIError,lsFatal,['pthread_cond_init',errno.AsString]);
  end;
end;

destructor TSignaledCriticalSection.Destroy;
begin
  pthread_mutex_destroy(@fMutex);
  pthread_cond_destroy(@fCondition);
  inherited Destroy;
end;

procedure TSignaledCriticalSection.Release;
begin
  pthread_mutex_unlock(@fMutex);
end;

procedure TSignaledCriticalSection.Sleep;
begin
  if pthread_cond_wait(@fCondition,@fMutex)<>0 then begin
    Log.Insert(le_OSAPIError,lsFatal,['pthread_cond_wait',errno.AsString]);
  end;
end;

procedure TSignaledCriticalSection.Wake;
begin
  pthread_cond_signal(@fCondition);
end;

{$endif}
end.

