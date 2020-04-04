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
/// <summary>
///  Unit tests for standard implementation of cwUnicode.TUnicodeString
/// </summary>
unit test.cwunicode.unicodestring.standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}
{$M+}

interface
uses
  cwTest
, cwTest.Standard
, cwUnicode
, cwUnicode.Standard
;

type
  test_TUnicodeString = class( TTestCase )
  private
    procedure iSetAsString( const UnicodeFormat: TUnicodeFormat );
    procedure iSetAsPtr( const UnicodeFormat: TUnicodeFormat );
    procedure iGetDataSize(const UnicodeFormat: TUnicodeFormat );
    procedure iSetUnicodeFormat( const StartFormat: TUnicodeFormat; const EndFormat: TUnicodeFormat );
  published
    procedure SetAsString;
    procedure SetAsStringAssign;
    procedure SetAsPtr;
    procedure SetAsPtrAssign;
    procedure getDataSize;
    procedure setUnicodeFormat;
  end;

implementation

const
  cString: string = 'Encodethisteststringtounicode.';
  cUTF8String: array[0..30] of uint8 = (
    $45, $6e, $63, $6f, $64, $65, $74, $68, $69, $73,
    $74, $65, $73, $74, $73, $74, $72, $69, $6e, $67,
    $74, $6f, $75, $6e, $69, $63, $6f, $64, $65, $2e,
    $00
  );

  cUTF16LEString: array[0..30] of uint16 = (
    $0045, $006e, $0063, $006f, $0064, $0065, $0074, $0068, $0069, $0073,
    $0074, $0065, $0073, $0074, $0073, $0074, $0072, $0069, $006e, $0067,
    $0074, $006f, $0075, $006e, $0069, $0063, $006f, $0064, $0065, $002e,
    $0000
  );

  cUTF16BEString: array[0..30] of uint16 = (
    $4500, $6e00, $6300, $6f00, $6400, $6500, $7400, $6800, $6900, $7300,
    $7400, $6500, $7300, $7400, $7300, $7400, $7200, $6900, $6e00, $6700,
    $7400, $6f00, $7500, $6e00, $6900, $6300, $6f00, $6400, $6500, $2e00,
    $0000
  );

  cUTF32LEString: array[0..30] of uint32 = (
    $00000045, $0000006e, $00000063, $0000006f, $00000064, $00000065,
    $00000074, $00000068, $00000069, $00000073, $00000074, $00000065,
    $00000073, $00000074, $00000073, $00000074, $00000072, $00000069,
    $0000006e, $00000067, $00000074, $0000006f, $00000075, $0000006e,
    $00000069, $00000063, $0000006f, $00000064, $00000065, $0000002e,
    $00000000
  );

  cUTF32BEString: array[0..30] of uint32 = (
    $45000000, $6e000000, $63000000, $6f000000, $64000000, $65000000,
    $74000000, $68000000, $69000000, $73000000, $74000000, $65000000,
    $73000000, $74000000, $73000000, $74000000, $72000000, $69000000,
    $6e000000, $67000000, $74000000, $6f000000, $75000000, $6e000000,
    $69000000, $63000000, $6f000000, $64000000, $65000000, $2e000000,
    $00000000
  );

procedure test_TUnicodeString.iSetAsString(const UnicodeFormat: TUnicodeFormat);
var
  Str: TUnicodeString;
begin
  // Arrange:
  Str.UnicodeFormat := UnicodeFormat;
  // Act:
  Str.AsString := cString;
  // Assert:
  case UnicodeFormat of
    TUnicodeFormat.utfUnknown: exit;
    TUnicodeFormat.utfANSI: TTest.Compare( Str.AsPtr, @cUTF8String[0], Length(cUTF8String)-sizeof(uint8), 'Encoded string does not match format.' );
       TUnicodeFormat.utf8: TTest.Compare( Str.AsPtr, @cUTF8String[0], Length(cUTF8String)-sizeof(uint8), 'Encoded string does not match format.' );
    TUnicodeFormat.utf16LE: TTest.Compare( Str.AsPtr, @cUTF16LEString[0], Length(cUTF16LEString)-sizeof(uint16), 'Encoded string does not match format.' );
    TUnicodeFormat.utf16BE: TTest.Compare( Str.AsPtr, @cUTF16BEString[0], Length(cUTF16BEString)-sizeof(uint16), 'Encoded string does not match format.' );
    TUnicodeFormat.utf32LE: TTest.Compare( Str.AsPtr, @cUTF32LEString[0], Length(cUTF32LEString)-sizeof(uint32), 'Encoded string does not match format.' );
    TUnicodeFormat.utf32BE: TTest.Compare( Str.AsPtr, @cUTF32BEString[0], Length(cUTF32BEString)-sizeof(uint32), 'Encoded string does not match format.' );
  end;
  TTest.Expect( cString, Str.AsString );
end;

procedure test_TUnicodeString.iSetAsPtr(const UnicodeFormat: TUnicodeFormat);
var
  Str: TUnicodeString;
begin
  // Arrange:
  Str.UnicodeFormat := UnicodeFormat;
  // Act:
  case UnicodeFormat of
    TUnicodeFormat.utfUnknown: exit;
    TUnicodeFormat.utfANSI: Str.AsPtr := @cUTF8String[0];
       TUnicodeFormat.utf8: Str.AsPtr := @cUTF8String[0];
    TUnicodeFormat.utf16LE: Str.AsPtr := @cUTF16LEString[0];
    TUnicodeFormat.utf16BE: Str.AsPtr := @cUTF16BEString[0];
    TUnicodeFormat.utf32LE: Str.AsPtr := @cUTF32LEString[0];
    TUnicodeFormat.utf32BE: Str.AsPtr := @cUTF32BEString[0];
  end;
  // Assert:
  TTest.Expect(cString, Str.AsString);
end;

procedure test_TUnicodeString.iGetDataSize(const UnicodeFormat: TUnicodeFormat);
var
  Str: TUnicodeString;
begin
  // Arrange:
  Str.UnicodeFormat := UnicodeFormat;
  // Act:
  Str.AsString := cString;
  // Assert:
  case UnicodeFormat of
    TUnicodeFormat.utfUnknown: exit;
    TUnicodeFormat.utfANSI: TTest.Expect( Length(cUTF8String)*sizeof(uint8),  Str.Size );
       TUnicodeFormat.utf8: TTest.Expect( Length(cUTF8String)*sizeof(uint8),  Str.Size );
    TUnicodeFormat.utf16LE: TTest.Expect( Length(cUTF8String)*sizeof(uint16), Str.Size );
    TUnicodeFormat.utf16BE: TTest.Expect( Length(cUTF8String)*sizeof(uint16), Str.Size );
    TUnicodeFormat.utf32LE: TTest.Expect( Length(cUTF8String)*sizeof(uint32), Str.Size );
    TUnicodeFormat.utf32BE: TTest.Expect( Length(cUTF8String)*sizeof(uint32), Str.Size );
  end;
end;

procedure test_TUnicodeString.iSetUnicodeFormat( const StartFormat: TUnicodeFormat; const EndFormat: TUnicodeFormat );
var
  Str: TUnicodeString;
begin
  if StartFormat = TUnicodeFormat.utfUnknown then begin
    exit;
  end;
  if EndFormat = TUnicodeFormat.utfUnknown then begin
    exit;
  end;
  // Arrange:
  Str.UnicodeFormat := StartFormat;
  case StartFormat of
    TUnicodeFormat.utfUnknown: exit;
    TUnicodeFormat.utfANSI,
       TUnicodeFormat.utf8: Str.AsPtr := @cUTF8String[0];
    TUnicodeFormat.utf16LE: Str.AsPtr := @cUTF16LEString[0];
    TUnicodeFormat.utf16BE: Str.AsPtr := @cUTF16BEString[0];
    TUnicodeFormat.utf32LE: Str.AsPtr := @cUTF32LEString[0];
    TUnicodeFormat.utf32BE: Str.AsPtr := @cUTF32BEString[0];
  end;
  // Act:
  Str.UnicodeFormat := EndFormat;
  // Assert:
  case EndFormat of
    TUnicodeFormat.utfUnknown: exit;
    TUnicodeFormat.utfANSI: TTest.Compare( Str.AsPtr, @cUTF8String[0], Length(cUTF8String)-sizeof(uint8), 'Encoded string does not match format.' );
       TUnicodeFormat.utf8: TTest.Compare( Str.AsPtr, @cUTF8String[0], Length(cUTF8String)-sizeof(uint8), 'Encoded string does not match format.' );
    TUnicodeFormat.utf16LE: TTest.Compare( Str.AsPtr, @cUTF16LEString[0], Length(cUTF16LEString)-sizeof(uint16), 'Encoded string does not match format.' );
    TUnicodeFormat.utf16BE: TTest.Compare( Str.AsPtr, @cUTF16BEString[0], Length(cUTF16BEString)-sizeof(uint16), 'Encoded string does not match format.' );
    TUnicodeFormat.utf32LE: TTest.Compare( Str.AsPtr, @cUTF32LEString[0], Length(cUTF32LEString)-sizeof(uint32), 'Encoded string does not match format.' );
    TUnicodeFormat.utf32BE: TTest.Compare( Str.AsPtr, @cUTF32BEString[0], Length(cUTF32BEString)-sizeof(uint32), 'Encoded string does not match format.' );
  end;
  TTest.Expect( cString, Str.AsString );
end;

procedure test_TUnicodeString.SetAsString;
begin
  iSetAsString( TUnicodeFormat.utfANSI );
  iSetAsString( TUnicodeFormat.utf8 );
  iSetAsString( TUnicodeFormat.utf16LE );
  iSetAsString( TUnicodeFormat.utf16BE );
  iSetAsString( TUnicodeFormat.utf32LE );
  iSetAsString( TUnicodeFormat.utf32BE );
end;

procedure test_TUnicodeString.SetAsStringAssign;
var
  Str: TUnicodeString;
begin
  // Arrange:
  // Act:
  Str := cString;
  // Assert:
  TTest.Compare( Str.AsPtr, @cUTF8String[0], Length(cUTF8String)-sizeof(uint8), 'Encoded string does not match format.' );
  TTest.Expect( cString, Str.AsString );
end;

procedure test_TUnicodeString.SetAsPtr;
begin
  iSetAsPtr( TUnicodeFormat.utfANSI );
  iSetAsPtr( TUnicodeFormat.utf8 );
  iSetAsPtr( TUnicodeFormat.utf16LE );
  iSetAsPtr( TUnicodeFormat.utf16BE );
  iSetAsPtr( TUnicodeFormat.utf32LE );
  iSetAsPtr( TUnicodeFormat.utf32BE );
end;

procedure test_TUnicodeString.SetAsPtrAssign;
var
  Str: TUnicodeString;
begin
  // Arrange:
  // Act:
  Str := @cUTF8String[0];
  // Assert:
  TTest.Expect(cString, Str.AsString);
end;

procedure test_TUnicodeString.getDataSize;
begin
  iGetDataSize( TUnicodeFormat.utfANSI );
  iGetDataSize( TUnicodeFormat.utf8 );
  iGetDataSize( TUnicodeFormat.utf16LE );
  iGetDataSize( TUnicodeFormat.utf16BE );
  iGetDataSize( TUnicodeFormat.utf32LE );
  iGetDataSize( TUnicodeFormat.utf32BE );
end;

procedure test_TUnicodeString.setUnicodeFormat;
var
  StartFormat: TUnicodeFormat;
  EndFormat: TUnicodeFormat;
begin
  for StartFormat := Low(TUnicodeFormat) to High(TUnicodeFormat) do begin
    for EndFormat := Low(TUnicodeFormat) to High(TUnicodeFormat) do begin
      if (StartFormat=utfUnknown) or (EndFormat=utfUnknown) then begin
        continue;
      end;
      iSetUnicodeFormat( StartFormat, EndFormat );
    end;
  end;
end;

initialization
  TestSuite.RegisterTestCase(test_TUnicodeString);

end.

