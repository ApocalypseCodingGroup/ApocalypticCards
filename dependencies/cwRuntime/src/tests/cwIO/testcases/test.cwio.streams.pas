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
unit test.cwIO.Streams;
{$ifdef fpc} {$mode delphiunicode} {$M+} {$endif}

interface
uses
  cwTest
;

type
  TTest_IStream_Standard = class(TTestCase)
  private
  published
    procedure Clear;
    procedure getEndOfStream;
    procedure getPosition;
    procedure setPosition;
    procedure getRemainingBytes;
    procedure Read;
    procedure Write;
    procedure CopyFrom;
    procedure getSize;
    procedure getName;
    procedure setName;
    procedure WriteByte;
    procedure ReadByte;
    procedure WriteBytes;
  end;

implementation
uses
  cwTest.Standard
, cwIO
, cwIO.Standard
;

procedure TTest_IStream_Standard.Clear;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IStream_Standard.getEndOfStream;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IStream_Standard.getPosition;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IStream_Standard.setPosition;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IStream_Standard.getRemainingBytes;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IStream_Standard.Read;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IStream_Standard.Write;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IStream_Standard.CopyFrom;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IStream_Standard.getSize;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IStream_Standard.getName;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IStream_Standard.setName;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IStream_Standard.WriteByte;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IStream_Standard.ReadByte;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IStream_Standard.WriteBytes;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;


initialization
  TestSuite.RegisterTestCase(TTest_IStream_Standard);

end.


