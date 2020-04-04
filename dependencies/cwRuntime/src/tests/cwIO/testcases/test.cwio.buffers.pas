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
unit test.cwIO.Buffers;
{$ifdef fpc} {$mode delphiunicode} {$M+} {$endif}

interface
uses
  cwTest
;

type
  TTest_IBuffer_Standard = class(TTestCase)
  private
  published
    procedure FillMem;
    procedure LoadFromStream;
    procedure SaveToStream;
    procedure Assign;
    procedure InsertData;
    procedure AppendData;
    procedure AppendDataASCIIZ;
    procedure ExtractData;
    procedure getDataPointer;
    procedure getSize;
    procedure getByte;
    procedure setByte;
    procedure setSize;
  end;

implementation
uses
  cwTest.Standard
, cwIO
, cwIO.Standard
;

const
  cTestBufferSize = 512;

procedure TTest_IBuffer_Standard.FillMem;
var
  idx: nativeuint;
  CUT: IBuffer;
begin
  // Arrange:
  CUT := TBuffer.Create( cTestBufferSize );
  // Act:
  CUT.FillMem($FF);
  // Assert:
  for idx := 0 to pred( cTestBufferSize ) do begin
    TTest.Expect( $FF, CUT.getByte(idx) );
  end;
end;

procedure TTest_IBuffer_Standard.LoadFromStream;
var
  MS: IStream;
  CUT: IBuffer;
  B: uint8;
  idx: nativeuint;
begin
  // Arrange:
  B := $FE;
  MS := TMemoryStream.Create;
  for idx := 0 to pred(cTestBufferSize) do begin
    MS.Write(@B,1);
  end;
  MS.Position := 0;
  CUT := TBuffer.Create(cTestBufferSize);
  // Act:
  CUT.LoadFromStream(MS,MS.Size);
  // Assert:
  for idx := 0 to pred( cTestBufferSize ) do begin
    TTest.Expect( $FE, CUT.getByte(idx) );
  end;
end;

procedure TTest_IBuffer_Standard.SaveToStream;
var
  MS: IStream;
  CUT: IBuffer;
  B: uint8;
  idx: nativeuint;
begin
  // Arrange:
  CUT := TBuffer.Create(cTestBufferSize);
  CUT.FillMem($FD);
  MS := TMemoryStream.Create;
  // Act:
  CUT.SaveToStream(MS,cTestBufferSize);
  // Assert:
  MS.Position := 0;
  for idx := 0 to pred( cTestBufferSize ) do begin
    B := 0;
    MS.Read(@B,1);
    TTest.Expect( $FD, B );
  end;
end;

procedure TTest_IBuffer_Standard.Assign;
var
  idx: nativeuint;
  B: IBuffer;
  CUT: IBuffer;
begin
  // Arrange:
  B := TBuffer.Create(cTestBufferSize);
  B.FillMem($FB);
  CUT := TBuffer.Create;
  // Act:
  CUT.Assign(B);
  // Assert:
  for idx := 0 to pred( cTestBufferSize ) do begin
    TTest.Expect( $FB, CUT.getByte(idx) );
  end;
end;

procedure TTest_IBuffer_Standard.InsertData;
var
  idx: uint8;
  CUT: IBuffer;
begin
  // Arrange:
  CUT := TBuffer.Create($FF);
  // Act:
  for idx := 0 to $FE do begin
    CUT.InsertData(@idx,idx,1);
  end;
  // Assert:
  for idx := 0 to $FE do begin
    TTest.Expect( idx, CUT.getByte(idx) );
  end;
end;

procedure TTest_IBuffer_Standard.AppendData;
var
  idx: nativeuint;
  CUT: IBuffer;
  B: IBuffer;
begin
  // Arrange:
  CUT := TBuffer.Create(cTestBufferSize div 2);
  CUT.FillMem($FF);
  B := TBuffer.Create(cTestBufferSize div 2 );
  B.FillMem($FE);
  // Act:
  CUT.AppendData(B.getDataPointer,B.size);
  // Assert:
  TTest.Expect( CUT.Size, ((cTestBufferSize div 2)*2) );
  for idx := 0 to pred(cTestBufferSize) do begin
    if (idx<(cTestBuffersize div 2)) then begin
      TTest.Expect($FF,CUT.getByte(idx));
    end else begin
      TTest.Expect($FE,CUT.getByte(idx));
    end;
  end;
end;

procedure TTest_IBuffer_Standard.AppendDataASCIIZ;
var
  Data: array[0..5] of uint8;
  CUT: IBuffer;
begin
  // Arrange:
  CUT := TBuffer.Create(2);
  CUT.FillMem($FF);
  Data[0] := 67;
  Data[1] := 82;
  Data[2] := 65;
  Data[3] := 73;
  Data[4] := 71;
  Data[5] := 0;
  // Act:
  CUT.AppendData(@Data[0]);
  // Assert:
  TTest.Expect( 8, CUT.Size );
  TTest.Expect( $FF, CUT.getByte(0) );
  TTest.Expect( $FF, CUT.getByte(1) );
  TTest.Expect(  67, CUT.getByte(2) );
  TTest.Expect(  82, CUT.getByte(3) );
  TTest.Expect(  65, CUT.getByte(4) );
  TTest.Expect(  73, CUT.getByte(5) );
  TTest.Expect(  71, CUT.getByte(6) );
  TTest.Expect(   0, CUT.getByte(7) );
end;

procedure TTest_IBuffer_Standard.ExtractData;
var
  CUT: IBuffer;
  Two: array[0..1] of uint8;
begin
  // Arrange:
  CUT := TBuffer.Create(5);
  CUT.setByte(0,67);
  CUT.setByte(1,82);
  CUT.setByte(2,65);
  CUT.setByte(3,73);
  CUT.setByte(4,71);
  Two[0] := 0;
  Two[1] := 0;
  // Act:
  CUT.ExtractData(@Two[0],2,2);
  // Assert:
  TTest.Expect( 65, Two[0] );
  TTest.Expect( 73, Two[1] );
end;

procedure TTest_IBuffer_Standard.getDataPointer;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IBuffer_Standard.getSize;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IBuffer_Standard.getByte;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IBuffer_Standard.setByte;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

procedure TTest_IBuffer_Standard.setSize;
begin
  // Arrange:
  // Act:
  // Assert:
  TTest.Fail('Test not implemented yet.');
end;

initialization
  TestSuite.RegisterTestCase(TTest_IBuffer_Standard);

end.
