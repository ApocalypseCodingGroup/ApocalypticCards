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
unit cwCollections.Dictionary.Standard;
{$ifdef fpc} {$mode delphiunicode} {$endif}

interface
uses
  cwCollections
;

type
  TStandardDictionary<K,V> = class( TInterfacedObject, ICollection, IReadOnlyDictionary<K,V>, IDictionary<K,V> )
  private
    {$ifdef fpc}
    fKeyCompareG: TCompareGlobalHandler<K>;
    fKeyCompareO: TCompareOfObjectHandler<K>;
    {$else}
    fKeyCompareR: TCompareReferenceHandler<K>;
    {$endif}
    fKeys: array of K;
    fItems: array of V;
    fCapacity: nativeuint;
    fCount: nativeuint;
    fGranularity: nativeuint;
    fPruned: boolean;
    fOrdered: boolean;
  private
    function OrderedRemoveItem( const idx: nativeuint ): boolean;
    function UnorderedRemoveItem( const idx: nativeuint ): boolean;
    procedure PruneCapacity;
    function CompareKeys( const KeyA: K; const KeyB: K ): TComparisonResult;
    procedure Initialize(const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false);
  private //- IReadOnlyDictionary<K,V> -//
    function getCount: nativeuint;
    function getKeyByIndex( const idx: nativeuint ): K;
    function getValueByIndex( const idx: nativeuint ): V;
    function getKeyExists( const key: K ): boolean;
    function getValueByKey( const key: K ): V;
    procedure setValueByIndex( const idx: nativeuint; const value: V );
    {$ifdef fpc}
    procedure ForEach( const Enumerate: TEnumeratePairGlobalHandler<K,V> ); overload;
    procedure ForEach( const Enumerate: TEnumeratePairOfObjectHandler<K,V> ); overload;
    {$else}
    procedure ForEach( const Enumerate: TEnumeratePairReferenceHandler<K,V> ); overload;
    {$endif}
    function getAsReadOnly: IReadOnlyDictionary<K,V>;
  strict private //- IDictionary<K,V> -//
    procedure setValueByKey( const key: K; const value: V );
    procedure removeByIndex( const idx: nativeuint );
    procedure clear;
  public
    {$ifdef fpc}
    constructor Create( const KeyCompare: TCompareGlobalHandler<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ); reintroduce; overload;
    constructor Create( const KeyCompare: TCompareOfObjectHandler<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ); reintroduce; overload;
    {$else}
    constructor Create( const KeyCompare: TCompareReferenceHandler<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ); reintroduce; overload;
    {$endif}
    destructor Destroy; override;
  end;

implementation

procedure TStandardDictionary<K,V>.Initialize(const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false);
begin
  // Set granularity control
  if Granularity>0 then begin
    fGranularity := Granularity;
  end;
  // Set granularity pruning.
  fPruned := isPruned;
  // Set order maintenance flag
  fOrdered := isOrdered;
  // Initialize the array.
  fCount := 0;
  fCapacity := 0;
  SetLength( fKeys, fCapacity );
  SetLength( fItems, fCapacity );
end;

{$ifdef fpc}
constructor TStandardDictionary<K,V>.Create( const KeyCompare: TCompareGlobalHandler<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false );
begin
  inherited Create;
  fKeyCompareG := KeyCompare;
  fKeyCompareO := nil;
  Initialize(Granularity,isOrdered,isPruned);
end;
{$endif}

{$ifdef fpc}
constructor TStandardDictionary<K,V>.Create( const KeyCompare: TCompareOfObjectHandler<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false );
begin
  inherited Create;
  fKeyCompareO := KeyCompare;
  fKeyCompareG := nil;
  Initialize(Granularity,isOrdered,isPruned);
end;
{$endif}

{$ifndef fpc}
constructor TStandardDictionary<K,V>.Create( const KeyCompare: TCompareReferenceHandler<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false );
begin
  inherited Create;
  fKeyCompareR := KeyCompare;
  Initialize(Granularity,isOrdered,isPruned);
end;
{$endif}

destructor TStandardDictionary<K,V>.Destroy;
begin
  SetLength( fKeys, 0 );
  SetLength( fItems, 0 );
  inherited Destroy;
end;

function TStandardDictionary<K,V>.getCount: nativeuint;
begin
  Result := fCount;
end;

{$ifdef fpc}
procedure TStandardDictionary<K,V>.ForEach( const Enumerate: TEnumeratePairGlobalHandler<K,V> );
var
  idx: nativeuint;
begin
  if getCount=0 then begin
    exit;
  end;
  for idx := 0 to pred(getCount) do begin
    Enumerate(getKeyByIndex(idx),getValueByIndex(idx));
  end;
end;
{$endif}

{$ifdef fpc}
procedure TStandardDictionary<K,V>.ForEach( const Enumerate: TEnumeratePairOfObjectHandler<K,V> );
var
  idx: nativeuint;
begin
  if getCount=0 then begin
    exit;
  end;
  for idx := 0 to pred(getCount) do begin
    Enumerate(getKeyByIndex(idx),getValueByIndex(idx));
  end;
end;
{$endif}

{$ifndef fpc}
procedure TStandardDictionary<K,V>.ForEach( const Enumerate: TEnumeratePairReferenceHandler<K,V> );
var
  idx: nativeuint;
begin
  if getCount=0 then begin
    exit;
  end;
  for idx := 0 to pred(getCount) do begin
    Enumerate(getKeyByIndex(idx),getValueByIndex(idx));
  end;
end;
{$endif}

function TStandardDictionary<K,V>.getKeyByIndex( const idx: nativeuint ): K;
begin
  Result := Default(K);
  if idx<getCount then begin
    Result := fKeys[idx];
  end;
end;

function TStandardDictionary<K,V>.CompareKeys( const KeyA: K; const KeyB: K ): TComparisonResult;
begin
  Result := TComparisonResult.crErrorNotCompared;
  {$ifdef fpc}
  if (not assigned(fKeyCompareG)) and (not assigned(fKeyCompareO)) then begin
    exit;
  end;
  if assigned(fKeyCompareG) then begin
    Result := fKeyCompareG( KeyA, KeyB );
  end else begin
    Result := fKeyCompareO( KeyA, KeyB );
  end;
  {$else}
  if not assigned(fKeyCompareR) then begin
    exit;
  end;
  Result := fKeyCompareR( KeyA, KeyB );
  {$endif}
end;

function TStandardDictionary<K,V>.getKeyExists( const key: K ): boolean;
var
  idx: nativeuint;
begin
  Result := False;
  if getCount=0 then begin
    exit;
  end;
  for idx := 0 to pred(getCount) do begin
    if CompareKeys(fKeys[idx],key)=crAEqualToB then begin
      Result := True;
      Exit;
    end;
  end;
end;

function TStandardDictionary<K,V>.getValueByIndex( const idx: nativeuint ): V;
begin
  Result := Default(V);
  if idx<getCount then begin
    Result := fItems[idx];
  end;
end;

procedure TStandardDictionary<K,V>.setValueByIndex( const idx: nativeuint; const value: V );
begin
  fItems[idx] := value;
end;

function TStandardDictionary<K,V>.getValueByKey( const key: K ): V;
var
  idx: nativeuint;
begin
  Result := Default(V);
  if getCount=0 then begin
    exit;
  end;
  for idx := 0 to pred(getCount) do begin
    if CompareKeys(fKeys[idx],key)=crAEqualToB then begin
      Result := fItems[idx];
      Exit;
    end;
  end;
end;

function TStandardDictionary<K,V>.OrderedRemoveItem( const idx: nativeuint ): boolean;
var
  idy: nativeuint;
begin
  Result := False; // unless..
  if fCount=0 then begin
    exit;
  end;
  if idx<pred(fCount) then begin
    for idy := idx to pred(pred(fCount)) do begin
      fItems[idy] := fItems[succ(idy)];
      fKeys[idy] := fKeys[succ(idy)];
    end;
    fItems[pred(fCount)] := Default(V);
    fKeys[pred(fCount)] := Default(K);
    dec(fCount);
    Result := True;
  end else if idx=pred(fCount) then begin
    //- Item is last on list, no need to move-down items above it.
    fItems[idx] := Default(V);
    fKeys[idx] := Default(K);
    dec(fCount);
    Result := True;
  end;
end;

function TStandardDictionary<K,V>.UnorderedRemoveItem( const idx: nativeuint ): boolean;
begin
  Result := False; // unless..
  if fCount=0 then begin
    exit;
  end;
  if idx<pred(fCount) then begin
    //- Move last item into place of that being removed.
    fItems[idx] := fItems[pred(fCount)];
    fKeys[idx] := fKeys[pred(fCount)];
    //- Clear last item
    fItems[pred(fCount)] := Default(V);
    fKeys[pred(fCount)] := Default(K);
    dec(fCount);
    Result := True;
  end else if idx=pred(fCount) then begin
    //- if idx=fCount then simply remove the top item and decrement
    fItems[idx] := Default(V);
    fKeys[idx] := Default(K);
    dec(fCount);
    Result := True;
  end;
end;

procedure TStandardDictionary<K,V>.PruneCapacity;
var
  Blocks: nativeuint;
  Remainder: nativeuint;
  TargetSize: nativeuint;
begin
  Blocks := fCount div fGranularity;
  Remainder := fCount - Blocks;
  if Remainder>0 then begin
    inc(Blocks);
  end;
  TargetSize := Blocks*fGranularity;
  //- Total number of required blocks has been determined.
  if fCapacity>TargetSize then begin
    fCapacity := TargetSize;
    SetLength( fItems, fCapacity );
    SetLength( fKeys, fCapacity );
  end;
end;

procedure TStandardDictionary<K,V>.removeByIndex( const idx: nativeuint );
begin
  // If the list is ordered, perform slow removal, else fast removal
  if fOrdered then begin
    OrderedRemoveItem( idx );
  end else begin
    UnorderedRemoveItem( idx );
  end;
  // If the list is pruning memory (to save memory space), do the prune.
  if fPruned then begin
    PruneCapacity;
  end;
end;

procedure TStandardDictionary<K,V>.Clear;
begin
  fCount := 0;
  if fPruned then begin
    fCapacity := 0;
    SetLength( fKeys, fCapacity );
    SetLength( fItems, fCapacity );
  end;
end;

procedure TStandardDictionary<K,V>.setValueByKey( const key: K; const value: V );
var
  idx: nativeuint;
begin
  if getCount>0 then begin //- Craig! Don't change this!
    for idx := 0 to pred(getCount) do begin
      if CompareKeys(fKeys[idx],key)=crAEqualToB then begin
        fItems[idx] := value;
        exit;
      end;
    end;
  end;
  //- If we made it here, add the item.
  if (fCount=fCapacity) then begin
    fCapacity := fCapacity + fGranularity;
    SetLength(fKeys,fCapacity);
    SetLength(fItems,fCapacity);
  end;
  fKeys[fCount] := key;
  fItems[fCount] := value;
  inc(fCount);
end;

function TStandardDictionary<K,V>.getAsReadOnly: IReadOnlyDictionary<K,V>;
begin
  Result := Self as IReadOnlyDictionary<K,V>;
end;

end.

