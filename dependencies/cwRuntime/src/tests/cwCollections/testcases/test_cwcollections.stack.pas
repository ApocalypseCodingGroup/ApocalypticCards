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
unit test_cwCollections.Stack;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwCollections
, cwCollections.standard
;

type
  TTest_cwCollectionsStack = class(TTestCase)
  private
    procedure internal_Push( vCUT: ICollection );
    procedure internal_Pull( vCUT: ICollection );

  published
    procedure Push;
    procedure Pull;
  end;

implementation
uses
  cwTest.Standard
;

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
  end;

constructor TCollectionItem.create(value: uint32);
begin
  inherited create;
  fValue := Value;
end;

function TCollectionItem.getValue: uint32;
begin
  Result := fValue;
end;

procedure TCollectionItem.setValue(value: uint32);
begin
  fValue := Value;
end;
//------------------------------------------------------------------------------

procedure TTest_cwCollectionsStack.internal_Pull( vCUT: ICollection );
var
  CUT: IStack<ICollectionItem>;
begin
  CUT := (vCUT as IStack<ICollectionItem>);
  CUT.Push(TCollectionItem.create(0));
  CUT.Push(TCollectionItem.create(1));
  CUT.Push(TCollectionItem.create(2));
  TTest.Expect(True,CUT.Pull.Value=2);
  TTest.Expect(True,CUT.Pull.Value=1);
  TTest.Expect(True,CUT.Pull.Value=0);
  TTest.Expect(False,assigned(CUT.Pull));
end;

procedure TTest_cwCollectionsStack.internal_Push( vCUT: ICollection );
begin
  internal_Pull( vCUT ); //- Same test as Pull!
end;

procedure TTest_cwCollectionsStack.Push;
var
  CUT: IStack<ICollectionItem>;
begin
  CUT := TStack<ICollectionItem>.Create(2,FALSE);
  internal_Push(CUT);
  CUT := TStack<ICollectionItem>.Create(2,TRUE);
  internal_Push(CUT);
  CUT := TStack<ICollectionItem>.Create(32,FALSE);
  internal_Push(CUT);
  CUT := TStack<ICollectionItem>.Create(32,TRUE);
  internal_Push(CUT);
end;

procedure TTest_cwCollectionsStack.Pull;
var
  CUT: IStack<ICollectionItem>;
begin
  CUT := TStack<ICollectionItem>.Create(2,FALSE);
  internal_Pull(CUT);
  CUT := TStack<ICollectionItem>.Create(2,TRUE);
  internal_Pull(CUT);
  CUT := TStack<ICollectionItem>.Create(32,FALSE);
  internal_Pull(CUT);
  CUT := TStack<ICollectionItem>.Create(32,TRUE);
  internal_Pull(CUT);
end;


initialization
  TestSuite.RegisterTestCase(TTest_cwCollectionsStack)

end.


