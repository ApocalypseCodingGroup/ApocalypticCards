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
unit cwThreading.MessagePipe.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwThreading.Messaging.Internal
, cwThreading
;

type
  TMessagePipe = class( TInterfacedObject, IMessagePipe, IMessageRingBuffer )
  private
    fEnabled: boolean;
    fPipeRing: IPipeRing;
    {$ifndef fpc} [weak] {$endif}
    fPullCS: ISignaledCriticalSection;
    {$ifndef fpc} [weak] {$endif}
    fPushCS: ISignaledCriticalSection;
  private //- IMessageRingBuffer -//
    function GetRingBuffer: IPipeRing;
  private //- IMessagePipe -//
    function getEnabled: boolean;
    procedure setEnabled( value: boolean );
    function SendMessageWait( MessageValue: uint64; ParamA: uint64 = 0; ParamB: uint64 = 0; ParamC: uint64 = 0; ParamD: uint64 = 0 ): uint64;
    function SendMessage( MessageValue: uint64; ParamA: uint64 = 0; ParamB: uint64 = 0; ParamC: uint64 = 0; ParamD: uint64 = 0 ): boolean;
  public
    constructor Create( PushCS: ISignaledCriticalSection; PullCS: ISignaledCriticalSection ); reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  sysutils;


{ TMessagePipe }

constructor TMessagePipe.Create( PushCS: ISignaledCriticalSection; PullCS: ISignaledCriticalSection );
begin
  inherited Create;
  fEnabled := True;
  fPushCS := PushCS;
  fPullCS := PullCS;
  fPipeRing := TPipeRing.Create;
end;

destructor TMessagePipe.Destroy;
begin
  fPipeRing := nil;
  fPushCS := nil;
  inherited Destroy;
end;

function TMessagePipe.getEnabled: boolean;
begin
  Result := fEnabled;
end;

function TMessagePipe.GetRingBuffer: IPipeRing;
begin
  Result := fPipeRing;
end;

function TMessagePipe.SendMessage(MessageValue: uint64; ParamA: uint64 = 0; ParamB: uint64 = 0; ParamC: uint64 = 0; ParamD: uint64 = 0): boolean;
var
  aMessageRec: TInternalMessageRecord;
begin
  Result := False;
  if not fEnabled then begin
    exit;
  end;
  aMessageRec.Handled := nil;
  aMessageRec.Return := nil;
  aMessageRec.aMessage.Value := MessageValue;
  aMessageRec.aMessage.ParamA := ParamA;
  aMessageRec.aMessage.ParamB := ParamB;
  aMessageRec.aMessage.ParamC := ParamC;
  aMessageRec.aMessage.ParamD := ParamD;
  Result := fPipeRing.Push(aMessageRec);
  fPushCS.Wake;
  Result := True;
end;

function TMessagePipe.SendMessageWait(MessageValue: uint64; ParamA: uint64 = 0; ParamB: uint64 = 0; ParamC: uint64 = 0; ParamD: uint64 = 0): uint64;
var
  aMessageRec: TInternalMessageRecord;
  Handled: boolean;
begin
  if not fEnabled then begin
    exit;
  end;
  Result := 0;
  Handled := False;
  aMessageRec.Handled := @Handled;
  aMessageRec.Return := @Result;
  aMessageRec.aMessage.Value := MessageValue;
  aMessageRec.aMessage.ParamA := ParamA;
  aMessageRec.aMessage.ParamB := ParamB;
  aMessageRec.aMessage.ParamC := ParamC;
  aMessageRec.aMessage.ParamD := ParamD;
  while (not fPipeRing.Push(aMessageRec)) and (fEnabled) do Sleep(0);
  if not fEnabled then begin
    exit;
  end;
  fPushCS.Wake;
  fPullCS.Acquire;
  try
    while not Handled do begin
      fPullCS.Sleep;
    end;
  finally
    fPullCS.Release;
  end;
end;

procedure TMessagePipe.setEnabled(value: boolean);
begin
  if fEnabled=Value then begin
    exit;
  end;
  fEnabled := Value;
end;

end.
