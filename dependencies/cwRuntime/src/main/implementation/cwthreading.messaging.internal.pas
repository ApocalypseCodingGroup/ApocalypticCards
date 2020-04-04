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
unit cwThreading.Messaging.Internal;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwThreading;

type
  ///  Record structure used internally to transport messages on the message
  ///  bus.
  PtrBoolean = ^Boolean;
  PtrNativeUInt = ^NativeUInt;
  TInternalMessageRecord = record
    Handled: PtrBoolean;
    Return: PtrNativeUInt;
    aMessage: TMessage;
  end;

  // Duplicating IAtomicRingBuffer< TInternalMessageRecord > because fpc will
  // not compile  IPipeRing = specialize IAtomicRingBuffer< TInternalMessageRecord >;
  // giving an internal compiler error (without error code!).
  IPipeRing = interface
    function Push( item: TInternalMessageRecord ): boolean;
    function Pull( var item: TInternalMessageRecord ): boolean;
    function IsEmpty: boolean;
  end;

  // Duplicating TAtomicRingBuffer< TInternalMessageRecord > because fpc will
  // not compile  TPipeRing = specialize TAtomicRingBuffer< TInternalMessageRecord >;
  // giving an internal compiler error (without error code!).
  TPipeRing = class( TInterfacedObject, IPipeRing )
  private
    fPushIndex: uint32;
    fPullIndex: uint32;
    fItems: array of TInternalMessageRecord;
  strict private //- IPipeRing -//
    function Push( item: TInternalMessageRecord ): boolean;
    function Pull( var item: TInternalMessageRecord ): boolean;
    function IsEmpty: boolean;
  public
    constructor Create( ItemCount: uint32 = 128 ); reintroduce;
  end;


  ///    Provides access to the ring buffer for the message channel.
  ///    This is used internally, and should not be made public.
  IMessageRingBuffer = interface
    ['{9EFC4D5D-A4B7-49F8-8ED6-E4F21E72E819}']

    ///  Provides internal access to the ring buffer from the message pipe to
    ///  the message channel.
    function GetRingBuffer: IPipeRing;
  end;

implementation

{ TPipeRing }

function TPipeRing.Push(item: TInternalMessageRecord): boolean;
var
  NewIndex: uint32;
begin
  Result := False;
  NewIndex := succ(fPushIndex);
  if (NewIndex>=Length(fItems)) then begin
    NewIndex := 0;
  end;
  if NewIndex=fPullIndex then begin
    Exit;
  end;
  Move( item, fItems[fPushIndex], sizeof(TInternalMessageRecord) );
  fPushIndex := NewIndex;
  Result := True;
end;

function TPipeRing.Pull(var item: TInternalMessageRecord): boolean;
var
  NewIndex: uint32;
begin
  Result := False;
  if fPullIndex=fPushIndex then begin
    exit;
  end;
  Move( fItems[fPullIndex], item, sizeof(TInternalMessageRecord) );
  NewIndex := succ(fPullIndex);
  if NewIndex>=Length(fItems) then begin
    NewIndex := 0;
  end;
  fPullIndex := NewIndex;
  Result := True;
end;

function TPipeRing.IsEmpty: boolean;
begin
  Result := True;
  if fPullIndex=fPushIndex then begin
    exit;
  end;
  Result := False;
end;

constructor TPipeRing.Create(ItemCount: uint32);
begin
  inherited Create;
  fPushIndex := 0;
  fPullIndex := 0;
  SetLength(fItems,ItemCount);
end;

end.
