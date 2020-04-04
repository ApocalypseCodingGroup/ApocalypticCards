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
unit test_cwTypes.PointerHelper;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwTest.Standard
, cwTypes
;

type
  TTestPointerHelper = class(TTestCase)
  private
  published
    procedure AsNativeUint;
    procedure PCharLen;
  end;

implementation

procedure TTestPointerHelper.AsNativeUint;
var
  P: pointer;
begin
  // Arrange:
  P := Self;
  // Act:
  // Assert:
  TTest.Expect(TRUE,P.AsNativeUint=nativeuint(Self));
end;

procedure TTestPointerHelper.PCharLen;
var
  Data: array[0..17] of uint8;
  P: pointer;
begin
  // Arrange:
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
  P := @Data[0];
  // Act:
  // Assert:
  TTest.Expect(TRUE,P.PCharLen=Pred(Length(Data)));
end;

initialization
  TestSuite.RegisterTestCase(TTestPointerHelper);

end.
