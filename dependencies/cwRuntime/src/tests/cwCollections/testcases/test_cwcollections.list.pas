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
unit test_cwCollections.List;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwCollections
, cwCollections.Standard
;

type
  TTest_cwCollectionsList = class(TTestCase)
  published
    procedure ForEach;
    procedure getCount;
    procedure getItem;
    procedure getAsReadOnly;
    procedure Clear;
    procedure Add;
    procedure setItem;
    procedure Remove;
    procedure RemoveItem;
    procedure RemoveItemOrdered;
  end;

implementation
uses
  cwTest.Standard
;

var
  Allocations: uint32 = 0;
  DisposedFlag: boolean;
  DisposedValue: uint32;

//------------------------------------------------------------------------------
// A simple collection item for testing the stack.
//------------------------------------------------------------------------------
type
  ICollectionItem = interface
    function getValue: uint32;
    procedure setValue( value: uint32 );
    property Value: uint32 read getValue write setValue;
  end;

  TCollectionItem = class( TInterfacedObject, ICollectionItem )
  private
    fValue: uint32;
  private
    function getValue: uint32;
    procedure setValue( value: uint32 );
  public
    constructor create( value: uint32 = 0 ); reintroduce;
    destructor destroy; override;
  end;

constructor TCollectionItem.create(value: uint32);
begin
  inherited create;
  fValue := Value;
  inc(Allocations);
end;

destructor TCollectionItem.destroy;
begin
  DisposedFlag := True;
  DisposedValue := fValue;
  Dec(Allocations);
  inherited destroy;
end;

function TCollectionItem.getValue: uint32;
begin
  Result := fValue;
end;

procedure TCollectionItem.setValue(value: uint32);
begin
  fValue := Value;
end;

function CompareICollectionItem( const AValue: ICollectionItem; const BValue: ICollectionItem ): TComparisonResult;
begin
  if AValue=BValue then begin
    Result := crAEqualToB;
  end else if nativeuint(pointer(AValue))>nativeuint(pointer(BValue)) then begin //- doesn't mean anything, but provides a sorting order should it be needed
    Result := crAGreaterThanB;
  end else begin
    Result := crBGreaterThanA;
  end;
end;

//------------------------------------------------------------------------------

var
  fSum: uint32; // for ForEach test.

procedure EnumerateHandler( const Item: ICollectionItem );
begin
  fSum := fSum + Item.Value;
end;

procedure TTest_cwCollectionsList.ForEach;
var
  CUT: IList<ICollectionItem>;
begin
  // Arrange:
  fSum := 0;
  CUT := TList<ICollectionItem>.Create;
  CUT.Add( TCollectionItem.Create(1) );
  CUT.Add( TCollectionItem.Create(2) );
  CUT.Add( TCollectionItem.Create(3) );
  CUT.Add( TCollectionItem.Create(4) );
  CUT.Add( TCollectionItem.Create(5) );
  // Act:
  CUT.ForEach(EnumerateHandler);
  // Assert:
  TTest.Expect(15,fSum);
end;

procedure TTest_cwCollectionsList.getCount;
var
  CUT: IList<ICollectionItem>;
  idx: nativeuint;
begin
  // Arrange:
  CUT := TList<ICollectionItem>.Create;
  // Act & Assert:
  // Add 1k items to list and ensure count remains consistent.
  for idx := 0 to 999 do begin
    CUT.Add( TCollectionItem.Create(idx) );
    TTest.Expect(succ(idx),CUT.getCount);
  end;
end;

procedure TTest_cwCollectionsList.getItem;
var
  CUT: IList<ICollectionItem>;
  idx: nativeuint;
begin
  // Arrange:
  CUT := TList<ICollectionItem>.Create;
  for idx := 0 to 999 do begin
    CUT.Add( TCollectionItem.Create(idx) );
  end;
  // Act & Assert:
  for idx := 0 to 999 do begin
    TTest.Expect( idx, CUT.Items[idx].Value );
  end;
end;

procedure TTest_cwCollectionsList.getAsReadOnly;
var
  CUT: IList<ICollectionItem>;
  ROCUT: IReadOnlyList<ICollectionItem>;
begin
  // Arrange:
  CUT := TList<ICollectionItem>.Create;
  // Act:
  ROCUT := CUT.getAsReadOnly;
  // Assert:
  TTest.Expect( nativeuint(pointer(ROCUT)), nativeuint(pointer(CUT)) );
end;

procedure TTest_cwCollectionsList.Clear;
var
  CUT: IList<ICollectionItem>;
  idx: nativeuint;
begin
  // Arrange:
  CUT := TList<ICollectionItem>.Create;
  // Add 1k items to list and ensure count remains consistent.
  for idx := 0 to 999 do begin
    CUT.Add( TCollectionItem.Create(idx) );
  end;
  //- Act
  CUT.Clear;
  //- Assert
  TTest.Expect(CUT.Count,0);
  TTest.Expect(Allocations,0); // Extra test to ensure everything is disposed.
end;

procedure TTest_cwCollectionsList.Add;
var
  CUT: IList<ICollectionItem>;
  idx: nativeuint;
begin
  //- same test as getCount.
  // Arrange:
  CUT := TList<ICollectionItem>.Create;
  // Act & Assert:
  // Add 1k items to list and ensure count remains consistent.
  for idx := 0 to 999 do begin
    CUT.Add( TCollectionItem.Create(idx) );
    TTest.Expect(succ(idx),CUT.getCount);
  end;
end;

procedure TTest_cwCollectionsList.setItem;
var
  Temp: ICollectionItem;
  CUT: IList<ICollectionItem>;
begin
  // Arrange:
  CUT := TList<ICollectionItem>.Create;
  CUT.Add( TCollectionItem.Create(0) );
  CUT.Add( TCollectionItem.Create(1) );
  // Act: swap items
  Temp := CUT.Items[0];
  CUT.Items[0] := CUT.Items[1];
  CUT.Items[1] := Temp;
  // Assert.
  TTest.Expect( 1, CUT.Items[0].Value );
  TTest.Expect( 0, CUT.Items[1].Value );
end;

procedure TTest_cwCollectionsList.Remove;
var
  Item: ICollectionItem;
  CUT: IList<ICollectionItem>;
  idx: nativeuint;
begin
  // Arrange:
  CUT := TList<ICollectionItem>.Create;
  // Add 1k items to list
  for idx := 0 to 999 do begin
    CUT.Add( TCollectionItem.Create(idx) );
  end;
  // Act & Assert:
  // Remove 1k items from list, checking that count decrements and that
  // the dispose flag is set for each.
  for idx := 999 downto 0 do begin
    DisposedFlag := False;
    DisposedValue := 10000;

    // Note: We remove the item from the list, but it is not immediately
    // disposed under the FPC compiler (Delphi may/may not be the same) because
    // the class is still referenced by the 'hidden variable' generated to call
    // the Remove() method, therefore the dispose method has not been called.
    // To work around this, we use an intermediate copy of the item being
    // removed for this test. By the time we set the intermediate item
    // reference to nil, the hidden reference has also been cleaned up and so
    // disposal occurs as expected.  In normal operation this should not have
    // impact on the use of the class, however, for the sake of testing this
    // extra reference is required in order that the test succeed.
    Item := Cut.Items[idx];
    CUT.Remove( Item {$ifndef fpc}, CompareICollectionItem{$endif} );
    Item := nil;

    TTest.Expect(TRUE,DisposedFlag);
    TTest.Expect(DisposedValue,idx);
    TTest.Expect(CUT.getCount,idx);
  end;
end;

procedure TTest_cwCollectionsList.RemoveItem;
var
  CUT: IList<ICollectionItem>;
  idx: nativeuint;
begin
  // Arrange:
  CUT := TList<ICollectionItem>.Create;
  // Add 1k items to list
  for idx := 0 to 999 do begin
    CUT.Add( TCollectionItem.Create(idx) );
  end;
  // Act & Assert:
  // Remove 1k items from list, checking that count decrements and that
  // the dispose flag is set for each.
  for idx := 999 downto 0 do begin
    DisposedFlag := False;
    DisposedValue := 10000;
    CUT.RemoveItem( idx );
    TTest.Expect(TRUE,DisposedFlag);
    TTest.Expect(DisposedValue,idx);
    TTest.Expect(CUT.getCount,idx);
  end;
end;

procedure TTest_cwCollectionsList.RemoveItemOrdered;
var
  CUT: IList<ICollectionItem>;
  idx: uint32;
begin
  CUT := TList<ICollectionItem>.Create(8,true,false);
  // Arrange:
  for idx := 0 to 12 do begin
    CUT.Add( TCollectionItem.Create(idx));
    CUT.Add( TCollectionItem.Create(succ(idx)));
  end;
  // Act:
  for idx := 0 to 12 do begin
    CUT.RemoveItem( succ(idx) );
  end;
  // Assert:
  for idx := 0 to 12 do begin
    TTest.Expect( idx, CUT.Items[idx].Value );
  end;
end;

initialization
  TestSuite.RegisterTestCase(TTest_cwCollectionsList)

end.


