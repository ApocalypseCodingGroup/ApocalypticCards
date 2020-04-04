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
unit cwThreading.MessageChannel.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwThreading
, cwCollections
, cwThreading.Messaging.Internal
;

type
  TMessageChannel = class( TInterfacedObject, IMessageChannel )
  private
    fEnabled: boolean;
    fMessagePipes: ICollection;
    fPushCS: ISignaledCriticalSection;
    fPullCS: ISignaledCriticalSection;
  private //- IMessageChannel -//
    function getEnabled: boolean;
    procedure setEnabled( value: boolean );
    function GetMessagePipe: IMessagePipe;
    procedure InternalGetMessage(var aMessageRec: TInternalMessageRecord );
    procedure GetMessage( Handler: TMessageHandler );
    function MessagesWaiting: boolean;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  cwCollections.standard
  {$ifdef MSWINDOWS}
, cwThreading.SignaledCriticalSection.Windows
  {$else}
, cwThreading.SignaledCriticalSection.Posix
  {$endif}
, cwThreading.MessagePipe.Standard
;

type
  IMessagePipeList = IList<IMessagePipe>;
  TMessagePipeList = TList<IMessagePipe>;

{ TMessageChannel }

constructor TMessageChannel.Create;
begin
  inherited Create;
  fEnabled := True;
  fPushCS := TSignaledCriticalSection.Create;
  fPullCS := TSignaledCriticalSection.Create;
  fMessagePipes := TMessagePipeList.Create(16);
end;

destructor TMessageChannel.Destroy;
begin
  fMessagePipes := nil;
  fPushCS := nil;
  fPullCS := nil;
  inherited Destroy;
end;

function TMessageChannel.getEnabled: boolean;
begin
  Result := fEnabled;
end;

function TMessageChannel.GetMessagePipe: IMessagePipe;
var
  NewPipe: IMessagePipe;
begin
  NewPipe := TMessagePipe.Create(fPushCS,fPullCS);
  IMessagePipeList(fMessagePipes).Add(NewPipe);
  Result := NewPipe;
end;

procedure TMessageChannel.GetMessage( Handler: TMessageHandler );
var
  aMessageRec: TInternalMessageRecord;
  ReturnValue: nativeuint;
begin
  if not fEnabled then begin
    exit;
  end;
  if (getEnabled) and (not MessagesWaiting) then begin
    fPushCS.Acquire;
    try
      while (not MessagesWaiting) and (getEnabled) do begin
        fPushCS.Sleep;
      end;
    finally
      fPushCS.Release;
    end;
  end;
  if (not getEnabled) then begin
    exit;
  end;
  {$HINTS OFF} InternalGetMessage(aMessageRec); {$HINTS ON} // FPC hints this is uninitialized.
  if not assigned(Handler) then begin
    exit;
  end;
  ReturnValue := Handler( aMessageRec.aMessage );
  if assigned(aMessageRec.Return) then begin
    aMessageRec.Return^ := ReturnValue;
  end;
  if assigned(aMessageRec.Handled) then begin
    aMessageRec.Handled^ := True;
  end;
  fPullCS.Wake;
end;

procedure TMessageChannel.InternalGetMessage(var aMessageRec: TInternalMessageRecord);
var
  Count: uint32;
  idx: uint32;
  CurrentPipe: IMessagePipe;
  PipeRing: IPipeRing;
begin
  if not fEnabled then begin
    exit;
  end;
  Count := IMessagePipeList(fMessagePipes).Count;
  if Count=0 then begin
    exit;
  end;
  //- Loop through pipes.
  for idx := 0 to pred(Count) do begin
    CurrentPipe := IMessagePipeList(fMessagePipes).Items[idx];
    PipeRing := (CurrentPipe as IMessageRingBuffer).GetRingBuffer;
    if PipeRing.Pull(aMessageRec) then begin
      exit;
    end;
  end;
end;

function TMessageChannel.MessagesWaiting: boolean;
var
  Count: uint64;
  idx: uint64;
  CurrentPipe: IMessagePipe;
  PipeRing: IPipeRing;
begin
  Result := False;
  if not fEnabled then begin
    exit;
  end;
  Count := IMessagePipeList(fMessagePipes).Count;
  if Count=0 then begin
    exit;
  end;
  //- Loop through pipes.
  for idx := 0 to pred(Count) do begin
    CurrentPipe := IMessagePipeList(fMessagePipes).Items[idx];
    PipeRing := (CurrentPipe as IMessageRingBuffer).GetRingBuffer;
    if not PipeRing.IsEmpty then begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure TMessageChannel.setEnabled(value: boolean);
var
  idx: uint64;
begin
  if fEnabled=Value then begin
    exit;
  end;
  fEnabled := Value;
  if IMessagePipeList(fMessagePipes).Count>0 then begin
    for idx := 0 to pred(IMessagePipeList(fMessagePipes).Count) do begin
      IMessagePipeList(fMessagePipes)[idx].Enabled := Value;
    end;
  end;
  if not fEnabled then begin
    fPullCS.Wake;
    fPushCS.Wake;
  end;
end;

end.
