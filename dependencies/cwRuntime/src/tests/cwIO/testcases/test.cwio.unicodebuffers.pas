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
unit test.cwIO.UnicodeBuffers;
{$ifdef fpc} {$mode delphiunicode} {$M+} {$endif}

interface
uses
  cwTest
;

type
  TTest_IUnicodeBuffer_Standard = class(TTestCase)
  private
  published
    procedure getAsString;
    procedure setAsString;
    procedure ReadBOM;
    procedure WriteBOM;
    procedure DetermineUnicodeFormat;
    procedure WriteString;
    procedure ReadString;
  end;

implementation
uses
  cwTest.Standard
, cwIO
, cwIO.Standard
;

procedure TTest_IUnicodeBuffer_Standard.getAsString;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IUnicodeBuffer_Standard.setAsString;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IUnicodeBuffer_Standard.ReadBOM;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IUnicodeBuffer_Standard.WriteBOM;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IUnicodeBuffer_Standard.DetermineUnicodeFormat;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IUnicodeBuffer_Standard.WriteString;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IUnicodeBuffer_Standard.ReadString;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

initialization
  TestSuite.RegisterTestCase(TTest_IUnicodeBuffer_Standard);

end.
