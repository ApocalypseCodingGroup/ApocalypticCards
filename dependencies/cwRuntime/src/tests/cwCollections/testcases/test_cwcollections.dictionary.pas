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
unit test_cwCollections.Dictionary;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwCollections
, cwCollections.Standard
;

type
  TTest_cwCollectionsDictionary = class(TTestCase)
  private
    procedure HandleForEach(const Key: string; const Value: string);
    procedure internal_ForEach( vCUT: ICollection );
    procedure internal_getCount( vCUT: ICollection );
    procedure internal_getKeyByIndex( vCUT: ICollection );
    procedure internal_getValueByIndex( vCUT: ICollection );
    procedure internal_getKeyExists( vCUT: ICollection );
    procedure internal_getValueByKey( vCUT: ICollection );
    procedure internal_setValueByKey( vCUT: ICollection );
    procedure internal_removeByIndex( vCUT: ICollection );
    procedure internal_clear( vCUT: ICollection );
  published
    procedure ForEach;
    procedure getCount;
    procedure getKeyByIndex;
    procedure getValueByIndex;
    procedure getKeyExists;
    procedure getValueByKey;
    procedure setValueByKey;
    procedure removeByIndex;
    procedure clear;
  end;

implementation
uses
  cwTest.Standard
;

procedure TTest_cwCollectionsDictionary.internal_clear( vCUT: ICollection );
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := (vCUT as IDictionary<string,uint32>);
  CUT.setValueByKey('A',1);
  CUT.setValueByKey('B',2);
  CUT.setValueByKey('C',3);
  TTest.Expect(True,CUT.Count>0);
  CUT.clear;
  TTest.Expect(True,CUT.Count=0);
end;

procedure TTest_cwCollectionsDictionary.ForEach;
var
  CUT: IDictionary<string,string>;
begin
  CUT := TDictionary<string,string>.Create(@TCompare.CompareStrings,2,FALSE,FALSE);
  internal_ForEach(CUT);
  CUT := TDictionary<string,string>.Create(@TCompare.CompareStrings,2,FALSE,TRUE);
  internal_ForEach(CUT);
  CUT := TDictionary<string,string>.Create(@TCompare.CompareStrings,2,TRUE,FALSE);
  internal_ForEach(CUT);
  CUT := TDictionary<string,string>.Create(@TCompare.CompareStrings,2,TRUE,TRUE);
  internal_ForEach(CUT);
  CUT := TDictionary<string,string>.Create(@TCompare.CompareStrings,32,FALSE,FALSE);
  internal_ForEach(CUT);
  CUT := TDictionary<string,string>.Create(@TCompare.CompareStrings,32,FALSE,TRUE);
  internal_ForEach(CUT);
  CUT := TDictionary<string,string>.Create(@TCompare.CompareStrings,32,TRUE,FALSE);
  internal_ForEach(CUT);
  CUT := TDictionary<string,string>.Create(@TCompare.CompareStrings,32,TRUE,TRUE);
  internal_ForEach(CUT);
end;

var
  LoopString: string;

procedure TTest_cwCollectionsDictionary.HandleForEach( const Key: string; const Value: string );
begin
  LoopString := LoopString + Key + Value;
end;

procedure TTest_cwCollectionsDictionary.internal_ForEach( vCUT: ICollection );
var
  CUT: IDictionary<string,string>;
begin
  // Arrange:
  CUT := (vCUT as IDictionary<string,string>);
  LoopString := '';
  CUT['A'] := '1';
  CUT['B'] := '2';
  CUT['C'] := '3';
  // Act:
  CUT.ForEach(HandleForEach);
  // Assert:
  TTest.Expect('A1B2C3',LoopString);
end;

procedure TTest_cwCollectionsDictionary.internal_getCount( vCUT: ICollection );
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := (vCUT as IDictionary<string,uint32>);
  CUT.setValueByKey('A',1);
  CUT.setValueByKey('B',2);
  CUT.setValueByKey('C',3);
  TTest.Expect(True,CUT.Count=3);
end;

procedure TTest_cwCollectionsDictionary.internal_getKeyByIndex( vCUT: ICollection );
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := (vCUT as IDictionary<string,uint32>);
  CUT.setValueByKey('A',1);
  CUT.setValueByKey('B',2);
  CUT.setValueByKey('C',3);
  TTest.Expect(True,CUT.Count=3);
  TTest.Expect(True,CUT.getKeyByIndex(0)='A');
  TTest.Expect(True,CUT.getKeyByIndex(1)='B');
  TTest.Expect(True,CUT.getKeyByIndex(2)='C');
end;


procedure TTest_cwCollectionsDictionary.internal_getKeyExists( vCUT: ICollection );
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := (vCUT as IDictionary<string,uint32>);
  CUT.setValueByKey('A',1);
  CUT.setValueByKey('B',2);
  CUT.setValueByKey('C',3);
  TTest.Expect(True,CUT.Count=3);
  TTest.Expect(True,CUT.KeyExists['A']);
  TTest.Expect(True,CUT.KeyExists['B']);
  TTest.Expect(True,CUT.KeyExists['C']);
  TTest.Expect(False,CUT.KeyExists['D']);
end;

procedure TTest_cwCollectionsDictionary.internal_getValueByIndex( vCUT: ICollection );
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := (vCUT as IDictionary<string,uint32>);
  CUT.setValueByKey('A',1);
  CUT.setValueByKey('B',2);
  CUT.setValueByKey('C',3);
  TTest.Expect(True,CUT.Count=3);
  TTest.Expect(True,CUT.getValueByIndex(0)=1);
  TTest.Expect(True,CUT.getValueByIndex(1)=2);
  TTest.Expect(True,CUT.getValueByIndex(2)=3);
end;

procedure TTest_cwCollectionsDictionary.internal_getValueByKey( vCUT: ICollection );
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := (vCUT as IDictionary<string,uint32>);
  CUT.setValueByKey('A',1);
  CUT.setValueByKey('B',2);
  CUT.setValueByKey('C',3);
  TTest.Expect(True,CUT.Count=3);
  TTest.Expect(True,CUT.ValueByKey['A']=1);
  TTest.Expect(True,CUT.ValueByKey['B']=2);
  TTest.Expect(True,CUT.ValueByKey['C']=3);
end;

procedure TTest_cwCollectionsDictionary.internal_removeByIndex( vCUT: ICollection );
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := (vCUT as IDictionary<string,uint32>);
  CUT.setValueByKey('A',1);
  CUT.setValueByKey('B',2);
  CUT.setValueByKey('C',3);
  TTest.Expect(True,CUT.Count=3);
  TTest.Expect(True,CUT.getValueByIndex(0)=1);
  TTest.Expect(True,CUT.getValueByIndex(1)=2);
  TTest.Expect(True,CUT.getValueByIndex(2)=3);
  CUT.removeByIndex(1);
  TTest.Expect(True,CUT.Count=2);
  TTest.Expect(True,CUT.getValueByIndex(0)=1);
  TTest.Expect(True,CUT.getValueByIndex(1)=3);
  TTest.Expect(True,CUT.getKeyByIndex(0)='A');
  TTest.Expect(True,CUT.getKeyByIndex(1)='C');
end;

procedure TTest_cwCollectionsDictionary.internal_setValueByKey( vCUT: ICollection );
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := (vCUT as IDictionary<string,uint32>);
  CUT.setValueByKey('A',1);
  CUT.setValueByKey('B',2);
  CUT.setValueByKey('C',3);
  TTest.Expect(True,CUT.Count=3);
  TTest.Expect(True,CUT.ValueByKey['A']=1);
  TTest.Expect(True,CUT.ValueByKey['B']=2);
  TTest.Expect(True,CUT.ValueByKey['C']=3);
  CUT.setValueByKey('B',66);
  TTest.Expect(True,CUT.Count=3);
  TTest.Expect(True,CUT.ValueByKey['A']=1);
  TTest.Expect(True,CUT.ValueByKey['B']=66);
  TTest.Expect(True,CUT.ValueByKey['C']=3);
end;

procedure TTest_cwCollectionsDictionary.getCount;
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,FALSE);
  internal_getCount(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,TRUE);
  internal_getCount(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,FALSE);
  internal_getCount(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,TRUE);
  internal_getCount(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,FALSE);
  internal_getCount(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,TRUE);
  internal_getCount(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,FALSE);
  internal_getCount(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,TRUE);
  internal_getCount(CUT);
end;

procedure TTest_cwCollectionsDictionary.getKeyByIndex;
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,FALSE);
  internal_getKeyByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,TRUE);
  internal_getKeyByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,FALSE);
  internal_getKeyByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,TRUE);
  internal_getKeyByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,FALSE);
  internal_getKeyByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,TRUE);
  internal_getKeyByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,FALSE);
  internal_getKeyByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,TRUE);
  internal_getKeyByIndex(CUT);
end;

procedure TTest_cwCollectionsDictionary.getValueByIndex;
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,FALSE);
  internal_getValueByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,TRUE);
  internal_getValueByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,FALSE);
  internal_getValueByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,TRUE);
  internal_getValueByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,FALSE);
  internal_getValueByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,TRUE);
  internal_getValueByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,FALSE);
  internal_getValueByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,TRUE);
  internal_getValueByIndex(CUT);
end;

procedure TTest_cwCollectionsDictionary.getKeyExists;
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,FALSE);
  internal_getKeyExists(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,TRUE);
  internal_getKeyExists(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,FALSE);
  internal_getKeyExists(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,TRUE);
  internal_getKeyExists(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,FALSE);
  internal_getKeyExists(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,TRUE);
  internal_getKeyExists(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,FALSE);
  internal_getKeyExists(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,TRUE);
  internal_getKeyExists(CUT);
end;

procedure TTest_cwCollectionsDictionary.getValueByKey;
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,FALSE);
  internal_getValueByKey(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,TRUE);
  internal_getValueByKey(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,FALSE);
  internal_getValueByKey(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,TRUE);
  internal_getValueByKey(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,FALSE);
  internal_getValueByKey(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,TRUE);
  internal_getValueByKey(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,FALSE);
  internal_getValueByKey(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,TRUE);
  internal_getValueByKey(CUT);
end;

procedure TTest_cwCollectionsDictionary.setValueByKey;
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,FALSE);
  internal_setValueByKey(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,TRUE);
  internal_setValueByKey(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,FALSE);
  internal_setValueByKey(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,TRUE);
  internal_setValueByKey(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,FALSE);
  internal_setValueByKey(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,TRUE);
  internal_setValueByKey(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,FALSE);
  internal_setValueByKey(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,TRUE);
  internal_setValueByKey(CUT);
end;

procedure TTest_cwCollectionsDictionary.removeByIndex;
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,FALSE);
  internal_removeByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,TRUE);
  internal_removeByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,FALSE);
  internal_removeByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,TRUE);
  internal_removeByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,FALSE);
  internal_removeByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,TRUE);
  internal_removeByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,FALSE);
  internal_removeByIndex(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,TRUE);
  internal_removeByIndex(CUT);
end;

procedure TTest_cwCollectionsDictionary.clear;
var
  CUT: IDictionary<string,uint32>;
begin
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,FALSE);
  internal_clear(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,FALSE,TRUE);
  internal_clear(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,FALSE);
  internal_clear(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,2,TRUE,TRUE);
  internal_clear(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,FALSE);
  internal_clear(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,FALSE,TRUE);
  internal_clear(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,FALSE);
  internal_clear(CUT);
  CUT := TDictionary<string,uint32>.Create(@TCompare.CompareStrings,32,TRUE,TRUE);
  internal_clear(CUT);
end;

initialization
  TestSuite.RegisterTestCase(TTest_cwCollectionsDictionary)

end.


