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
/// <exclude/>
unit cwCollections.Stack.Standard;
{$ifdef fpc} {$mode delphiunicode} {$endif}

interface
uses
  cwCollections
;

type
  TStandardStack<T> = class( TInterfacedObject, IReadOnlyStack<T>, IStack<T> )
  private
    fItems: array of T;
    fCount: nativeuint;
    fCapacity: nativeuint;
    fGranularity: nativeuint;
    fPruned: boolean;
  private //- IReadOnlyStack -//
    function Pull: T;
    function getAsReadOnly: IReadOnlyStack<T>;
  private //- IStack<T> -//
    procedure Push( const Item: T );
  public
    constructor Create( const Granularity: nativeuint = 0; const IsPruned: boolean = false ); reintroduce;
    destructor Destroy; override;
  end;

implementation

constructor TStandardStack<T>.Create( const Granularity: nativeuint; const IsPruned: boolean );
const
  cDefaultGranularity = 32;
begin
  inherited Create;
  //- Determine memory usage granularity.
  if Granularity>0 then begin
    fGranularity := Granularity;
  end else begin
    fGranularity := cDefaultGranularity; //-default granularity
  end;
  fPruned := IsPruned;
  fCapacity := 0;
  fCount := 0;
  SetLength( fItems, fCapacity );
end;

destructor TStandardStack<T>.Destroy;
begin
  SetLength( fItems, 0 );
  inherited;
end;

function TStandardStack<T>.Pull: T;
begin
  Result := Default(T);
  if fCount>0 then begin
    Result := fItems[pred(fCount)];
    fItems[pred(fCount)] := Default(T);
    dec(fCount);
    if fPruned then begin
      if fCount<(fCapacity-fGranularity) then begin
        fCapacity := fCapacity - fGranularity;
        SetLength( fItems, fCapacity );
      end;
    end;
  end;
end;

procedure TStandardStack<T>.Push( const Item: T );
begin
  //- Test that there is sufficient memory to add the item.
  if (fCount=fCapacity) then begin
    fCapacity := fCapacity + fGranularity;
    SetLength( fItems, fCapacity );
  end;
  //- Add the item
  fItems[fCount] := Item;
  inc(fCount);
end;

function TStandardStack<T>.getAsReadOnly: IReadOnlyStack<T>;
begin
  Result := Self as IReadOnlyStack<T>;
end;

end.

