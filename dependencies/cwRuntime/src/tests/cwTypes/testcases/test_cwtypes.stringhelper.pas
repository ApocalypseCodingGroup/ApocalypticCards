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
unit test_cwTypes.StringHelper;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwTest.Standard
, cwTypes
;

type
  TTestStringHelper = class(TTestCase)
  published
    procedure SetAsPChar;
    procedure LeftPad;
    procedure RightPad;
    procedure Explode;
    procedure Combine;
    procedure Trim;
    procedure Uppercase;
    procedure UppercaseTrim;
    procedure Lowercase;
    procedure LowercaseTrim;
    procedure StringReplace;
    procedure LeftStr;
    procedure RightStr;
    procedure MidStr;
    procedure Pos;
    procedure PadLeft;
    procedure PadRight;
    procedure AsBoolean;
    procedure AsUInt8;
    procedure AsUInt16;
    procedure AsUint32;
    procedure AsUint64;
    procedure AsInt8;
    procedure AsInt16;
    procedure AsInt32;
    procedure AsInt64;
    procedure AsSingle;
    procedure AsDouble;
    procedure AsExtended;
    procedure AsAnsiString;
  end;

implementation

function Within(A,B: double; Precision: double ):boolean;
begin
  Result := (A>B-Precision) and (A<B+Precision);
end;

procedure TTestStringHelper.AsAnsiString;
var
  S: string;
  ToAnsi: ansistring;
  FromAnsi: string;
begin
  // Arrange:
  ToAnsi := '';
  FromAnsi := '';
  S := '[{6A5972B7-B7B8-478B-9970-F571021195A9}]';
  // Act:
  ToAnsi := S.AsAnsiString;
  FromAnsi.AsAnsiString := ToAnsi;
  // Assert:
  TTest.Expect(S,FromAnsi);
end;

procedure TTestStringHelper.AsBoolean;
var
  STrue: string;
  SFalse: string;
  T: boolean;
  F: boolean;
begin
  // Arrange:
  STrue := 'TRUE';
  SFALSE := 'FALSE';
  // Act:
  T := STrue.AsBoolean;
  F := SFalse.AsBoolean(TRUE);
  // Assert:
  TTest.Expect(TRUE,T);
  TTest.Expect(FALSE,F);
end;

procedure TTestStringHelper.AsDouble;
var
  F: double;
  S: string;
begin
  // Arrange:
  S := '16.431';
  // Act:
  F := S.AsDouble;
  // Assert:
  TTest.Expect(16.431,F,0.0001);
end;

procedure TTestStringHelper.AsExtended;
var
  F: Extended;
  S: string;
begin
  // Arrange:
  S := '16.431';
  // Act:
  F := S.AsExtended;
  // Assert:
  TTest.Expect(16.431,F,0.0001);
end;

procedure TTestStringHelper.AsInt16;
var
  V: int16;
  S: string;
begin
  // Arrange:
  S := '-16000';
  // Act:
  V := S.AsInt16;
  // Assert:
  TTest.Expect(TRUE,V=-16000);
end;

procedure TTestStringHelper.AsInt32;
var
  V: int32;
  S: string;
begin
  // Arrange:
  S := '-65530';
  // Act:
  V := S.AsInt32;
  // Assert:
  TTest.Expect(TRUE,V=-65530);
end;

procedure TTestStringHelper.AsInt64;
var
  V: int64;
  S: string;
begin
  // Arrange:
  S := '-165530';
  // Act:
  V := S.AsInt64;
  // Assert:
  TTest.Expect(TRUE,V=-165530);
end;

procedure TTestStringHelper.AsInt8;
var
  V: int8;
  S: string;
begin
  // Arrange:
  S := '-100';
  // Act:
  V := S.AsInt8;
  // Assert:
  TTest.Expect(TRUE,V=-100);
end;

procedure TTestStringHelper.AsSingle;
var
  F: single;
  S: string;
begin
  // Arrange:
  S := '16.431';
  // Act:
  F := S.AsSingle;
  // Assert:
  TTest.Expect(TRUE,Within(F,16.431,0.001));
end;

procedure TTestStringHelper.AsUInt16;
var
  V: uint16;
  S: string;
begin
  // Arrange:
  S := '16000';
  // Act:
  V := S.AsUInt16;
  // Assert:
  TTest.Expect(TRUE,V=16000);
end;

procedure TTestStringHelper.AsUint32;
var
  V: uint32;
  S: string;
begin
  // Arrange:
  S := '65530';
  // Act:
  V := S.AsUInt32;
  // Assert:
  TTest.Expect(TRUE,V=65530);
end;

procedure TTestStringHelper.AsUint64;
var
  V: uint64;
  S: string;
begin
  // Arrange:
  S := '165530';
  // Act:
  V := S.AsUInt64;
  // Assert:
  TTest.Expect(TRUE,V=165530);
end;

procedure TTestStringHelper.AsUInt8;
var
  V: uint8;
  S: string;
begin
  // Arrange:
  S := '200';
  // Act:
  V := S.AsUInt8;
  // Assert:
  TTest.Expect(TRUE,V=200);
end;

procedure TTestStringHelper.Combine;
var
  S: string;
  Arr: TArrayOfString;
begin
  // Arrange:
  {$hints off} SetLength(Arr,5); {$hints on} // hints that this is not initialized, this is initialization.
  S := '';
  Arr[0]:='Monday';
  Arr[1]:='Tuesday';
  Arr[2]:='Wednesday';
  Arr[3]:='Thursday';
  Arr[4]:='Friday';
  // Act:
  S.Combine(';',Arr);
  // Assert:
  TTest.Expect(TRUE,S='Monday;Tuesday;Wednesday;Thursday;Friday');
end;

procedure TTestStringHelper.Explode;
var
  S: string;
  Arr: TArrayOfString;
begin
  // Arrange:
  S := 'Monday;Tuesday;Wednesday;Thursday;Friday';
  // Act:
  Arr := S.Explode(';');
  // Assert:
  TTest.Expect('Monday',Arr[0]);
  TTest.Expect('Tuesday',Arr[1]);
  TTest.Expect('Wednesday',Arr[2]);
  TTest.Expect('Thursday',Arr[3]);
  TTest.Expect('Friday',Arr[4]);
end;

procedure TTestStringHelper.LeftPad;
var
  S: string;
  T: string;
begin
  // Arrange:
  S := 'Hello';
  // Act:
  T := S.LeftPad(11,'!');
  // Assert:
  TTest.Expect('!!!!!!'+S,T);
end;

procedure TTestStringHelper.LeftStr;
var
  S: string;
  T: string;
begin
  // Arrange:
  S := 'Left Middle Right';
  // Act:
  T := S.LeftStr(4);
  // Assert:
  TTest.Expect('Left',T);
end;

procedure TTestStringHelper.Lowercase;
var
  S: string;
  T: string;
begin
  // Arrange:
  S := 'HELLO CRUEL WORLD';
  // Act:
  T := S.Lowercase;
  // Assert:
  TTest.Expect('hello cruel world',T);
end;

procedure TTestStringHelper.LowercaseTrim;
var
  S: string;
  T: string;
begin
  // Arrange:
  S := ' HELLO CRUEL WORLD  ';
  // Act:
  T := S.LowercaseTrim;
  // Assert:
  TTest.Expect('hello cruel world',T);
end;

procedure TTestStringHelper.MidStr;
var
  S: string;
  T: string;
begin
  // Arrange:
  S := 'Left Middle Right';
  // Act:
  T := S.MidStr(6,6);
  // Assert:
  TTest.Expect('Middle',T);
end;

procedure TTestStringHelper.PadLeft;
var
  S: string;
  T: string;
begin
  // Arrange:
  S := 'Hello';
  // Act:
  T := S.PadLeft(6,'!');
  // Assert:
  TTest.Expect('!!!!!!'+S,T);
end;

procedure TTestStringHelper.PadRight;
var
  S: string;
  T: string;
begin
  // Arrange:
  S := 'Hello';
  // Act:
  T := S.PadRight(6,'!');
  // Assert:
  TTest.Expect(S+'!!!!!!',T);
end;

procedure TTestStringHelper.Pos;
var
  S: string;
  T: uint32;
begin
  // Arrange:
  S := 'Left Middle Right';
  // Act:
  T := S.Pos('Middle');
  // Assert:
  TTest.Expect(uint32(6),T);
end;

procedure TTestStringHelper.RightPad;
var
  S: string;
  T: string;
begin
  // Arrange:
  S := 'Hello';
  // Act:
  T := S.RightPad(11,'!');
  // Assert:
  TTest.Expect(S+'!!!!!!',T);
end;

procedure TTestStringHelper.RightStr;
var
  S: string;
  T: string;
begin
  // Arrange:
  S := 'Left Middle Right';
  // Act:
  T := S.RightStr(5);
  // Assert:
  TTest.Expect('Right',T);
end;

procedure TTestStringHelper.SetAsPChar;
var
  Data: array[0..17] of uint8;
  S: string;
begin
  // Arrange:
  S := '';
  Data[00] := ord('h');
  Data[01] := ord('e');
  Data[02] := ord('l');
  Data[03] := ord('l');
  Data[04] := ord('o');
  Data[05] := ord(' ');
  Data[06] := ord('c');
  Data[07] := ord('r');
  Data[08] := ord('u');
  Data[09] := ord('e');
  Data[10] := ord('l');
  Data[11] := ord(' ');
  Data[12] := ord('w');
  Data[13] := ord('o');
  Data[14] := ord('r');
  Data[15] := ord('l');
  Data[16] := ord('d');
  Data[17] := 0;
  // Act:
  S.SetAsPChar( @Data[0] );
  // Assert:
  TTest.Expect('hello cruel world',S);
end;

procedure TTestStringHelper.StringReplace;
var
  S: string;
  T: string;
begin
  // Arrange:
  S := 'hello replace world';
  // Act:
  T := S.StringReplace('replace','cruel',TRUE,TRUE);
  // Assert:
  TTest.Expect('hello cruel world',T);
end;

procedure TTestStringHelper.Trim;
var
  S: string;
  T: string;
begin
  // Arrange:
  S := ' hello cruel world  ';
  // Act:
  T := S.Trim;
  // Assert:
  TTest.Expect('hello cruel world',T);
end;

procedure TTestStringHelper.Uppercase;
var
  S: string;
  T: string;
begin
  // Arrange:
  S := 'hello cruel world';
  // Act:
  T := S.Uppercase;
  // Assert:
  TTest.Expect('HELLO CRUEL WORLD',T);
end;

procedure TTestStringHelper.UppercaseTrim;
var
  S: string;
  T: string;
begin
  // Arrange:
  S := ' hello cruel world  ';
  // Act:
  T := S.UppercaseTrim;
  // Assert:
  TTest.Expect('HELLO CRUEL WORLD',T);
end;

initialization
  TestSuite.RegisterTestCase(TTestStringHelper);

end.
