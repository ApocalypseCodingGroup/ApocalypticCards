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
unit cwCollections.RingBuffer.Standard;
{$ifdef fpc} {$mode delphiunicode} {$endif}

interface
uses
  cwCollections
;

type
  TStandardRingBuffer<T> = class( TInterfacedObject, IReadOnlyRingBuffer<T>, IRingBuffer<T> )
  private
    fPushIndex: nativeuint;
    fPullIndex: nativeuint;
    fItems: array of T;
  strict private //- IReadOnlyRingBuffer<T> -//
    function Pull( out item: T ): boolean;
    function IsEmpty: boolean;
    function getAsReadOnly: IReadOnlyRingBuffer<T>;
  strict private //- IRingBuffer<T> -//
    function Push( const item: T ): boolean;
  public
    constructor Create( ItemCount: nativeuint = 128 ); reintroduce;
  end;

implementation

constructor TStandardRingBuffer<T>.Create( ItemCount: nativeuint );
begin
  inherited Create;
  fPushIndex := 0;
  fPullIndex := 0;
  SetLength(fItems,ItemCount);
end;

function TStandardRingBuffer<T>.IsEmpty: boolean;
begin
  Result := True;
  if fPullIndex=fPushIndex then begin
    exit;
  end;
  Result := False;
end;

function TStandardRingBuffer<T>.Pull(out item: T): boolean;
var
  NewIndex: nativeuint;
begin
  Result := False;
  if fPullIndex=fPushIndex then begin
    exit;
  end;
  Item := Default(T);
  Move( fItems[fPullIndex], item, sizeof(T) );
  NewIndex := succ(fPullIndex);
  if NewIndex>=Length(fItems) then begin
    NewIndex := 0;
  end;
  fPullIndex := NewIndex;
  Result := True;
end;

function TStandardRingBuffer<T>.Push(const item: T): boolean;
var
  NewIndex: nativeuint;
begin
  Result := False;
  NewIndex := succ(fPushIndex);
  if (NewIndex>=Length(fItems)) then begin
    NewIndex := 0;
  end;
  if NewIndex=fPullIndex then begin
    Exit;
  end;
  Move( item, fItems[fPushIndex], sizeof(T) );
  fPushIndex := NewIndex;
  Result := True;
end;

function TStandardRingBuffer<T>.getAsReadOnly: IReadOnlyRingBuffer<T>;
begin
  Result := self as IReadOnlyRingBuffer<T>;
end;

end.

