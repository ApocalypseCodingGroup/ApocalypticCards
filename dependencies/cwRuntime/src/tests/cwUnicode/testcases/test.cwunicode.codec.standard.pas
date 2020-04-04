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
///  Unit tests for standard implementation of cwUnicode.IUnicodeCodec
/// </summary>
unit test.cwUnicode.Codec.Standard;
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
  TTest_IUnicodeCodec_Standard = class( TTestCase )
  private
    procedure Test_EncodeCodepointToString( const CodePoint: TUnicodeCodepoint; const s: string );
    procedure Test_DecodeCodepointFromString( const s: string; const CodePoint: TUnicodeCodepoint );
    procedure Test_UTF8CharacterLength( var Data: uint32; const ExpectedLen: uint8 );
    procedure Test_UTF16LECharacterLength( var Data: uint32; const ExpectedLen: uint8 );
    procedure Test_UTF16BECharacterLength( var Data: uint32; const ExpectedLen: uint8 );
    procedure Test_UTF8Decode( var Data: uint32; const Expected: TUnicodeCodepoint );
    procedure Test_UTF16LEDecode( var Data: uint32; const Expected: TUnicodeCodepoint );
    procedure Test_UTF16BEDecode( var Data: uint32; const Expected: TUnicodeCodepoint );
    procedure Test_UTF32LEDecode( var Data: uint32; const Expected: TUnicodeCodepoint );
    procedure Test_UTF32BEDecode( var Data: uint32; const Expected: TUnicodeCodepoint );
    procedure Test_UTF8Encode( const Expected: uint32; const Codepoint: TUnicodeCodepoint );
    procedure Test_UTF16LEEncode( const Expected: uint32; const Codepoint: TUnicodeCodepoint );
    procedure Test_UTF16BEEncode( const Expected: uint32; const Codepoint: TUnicodeCodepoint );
    procedure Test_UTF32LEEncode( const Expected: uint32; const Codepoint: TUnicodeCodepoint );
    procedure Test_UTF32BEEncode( const Expected: uint32; const Codepoint: TUnicodeCodepoint );
    procedure Test_AnsiDecode( var Data: uint32; const Expected: TUnicodeCodepoint );
    procedure Test_AnsiEncode( const Expected: uint32; const Codepoint: TUnicodeCodepoint );
    procedure Test_DecodeBOMUTF8( Data: uint32; const Size: uint8; const Expected: boolean );
    procedure Test_DecodeBOMUTF16LE( Data: uint32; const Size: uint8; const Expected: boolean );
    procedure Test_DecodeBOMUTF16BE( Data: uint32; const Size: uint8; const Expected: boolean );
    procedure Test_DecodeBOMUTF32LE( Data: uint32; const Size: uint8; const Expected: boolean );
    procedure Test_DecodeBOMUTF32BE( Data: uint32; const Size: uint8; const Expected: boolean );
    procedure Test_EncodeBOMUTF8( const Expected: uint32; const ExpectedSize: uint8 );
    procedure Test_EncodeBOMUTF16LE( const Expected: uint32; const ExpectedSize: uint8 );
    procedure Test_EncodeBOMUTF16BE( const Expected: uint32; const ExpectedSize: uint8 );
    procedure Test_EncodeBOMUTF32LE( const Expected: uint32; const ExpectedSize: uint8 );
    procedure Test_EncodeBOMUTF32BE( const Expected: uint32; const ExpectedSize: uint8 );
  published
    procedure EncodeCodepointToString;
    procedure DecodeCodepointFromString;
    procedure UTF8CharacterLength;
    procedure UTF16LECharacterLength;
    procedure UTF16BECharacterLength;
    procedure UTF8Decode;
    procedure UTF16LEDecode;
    procedure UTF16BEDecode;
    procedure UTF32LEDecode;
    procedure UTF32BEDecode;
    procedure UTF8Encode;
    procedure UTF16LEEncode;
    procedure UTF16BEEncode;
    procedure UTF32LEEncode;
    procedure UTF32BEEncode;
    procedure AnsiDecode;
    procedure AnsiEncode;
    procedure DecodeBOMUTF8;
    procedure DecodeBOMUTF16LE;
    procedure DecodeBOMUTF16BE;
    procedure DecodeBOMUTF32LE;
    procedure DecodeBOMUTF32BE;
    procedure EncodeBOMUTF8;
    procedure EncodeBOMUTF16LE;
    procedure EncodeBOMUTF16BE;
    procedure EncodeBOMUTF32LE;
    procedure EncodeBOMUTF32BE;
  end;

implementation

procedure TTest_IUnicodeCodec_Standard.AnsiDecode;
var
  Data: uint32;
begin
  Data := $65;
  Test_AnsiDecode(Data,$65);
  Data := $5A;
  Test_AnsiDecode(Data,$5A);
end;

procedure TTest_IUnicodeCodec_Standard.AnsiEncode;
begin
  Test_AnsiEncode($65,$65);
  Test_AnsiEncode($5A,$5A);
end;

procedure TTest_IUnicodeCodec_Standard.DecodeBOMUTF16BE;
begin
  Test_DecodeBOMUTF16BE($FFFE,2,True);
  Test_DecodeBOMUTF16BE($0000,2,False);
end;

procedure TTest_IUnicodeCodec_Standard.DecodeBOMUTF16LE;
begin
  Test_DecodeBOMUTF16LE($FEFF,2,True);
  Test_DecodeBOMUTF16LE($0000,2,False);
end;

procedure TTest_IUnicodeCodec_Standard.DecodeBOMUTF32BE;
begin
  Test_DecodeBOMUTF32BE($FFFE0000,4,True);
  Test_DecodeBOMUTF32BE($00000000,4,False);
end;

procedure TTest_IUnicodeCodec_Standard.DecodeBOMUTF32LE;
begin
  Test_DecodeBOMUTF32LE($0000FEFF,4,True);
  Test_DecodeBOMUTF32LE($00000000,4,False);
end;

procedure TTest_IUnicodeCodec_Standard.DecodeBOMUTF8;
begin
  Test_DecodeBOMUTF8($BFBBEF,3,True);
  Test_DecodeBOMUTF8($000000,3,False);
end;

procedure TTest_IUnicodeCodec_Standard.DecodeCodepointFromString;
begin
  //- Tests here differ for Deplhi vs FPC for the same
  //- reason as noted in EncodeCodepointToString.
  //- This is the best case testing scenario I currently have.
  Test_DecodeCodepointFromString('$',$0024);
  {$ifndef fpc}
  Test_DecodeCodepointFromString('€',$20AC);
  Test_DecodeCodepointFromString('𐐷',$10437);
  Test_DecodeCodepointFromString('𤭢',$24B62);
  {$else}
  Test_DecodeCodepointFromString(UnicodeString(#$20AC),$20AC);
  {$endif}
end;

procedure TTest_IUnicodeCodec_Standard.EncodeBOMUTF16BE;
begin
  Test_EncodeBOMUTF16BE($FFFE,2);
end;

procedure TTest_IUnicodeCodec_Standard.EncodeBOMUTF16LE;
begin
  Test_EncodeBOMUTF16LE($FEFF,2);
end;

procedure TTest_IUnicodeCodec_Standard.EncodeBOMUTF32BE;
begin
  Test_EncodeBOMUTF32BE($FFFE0000,4);
end;

procedure TTest_IUnicodeCodec_Standard.EncodeBOMUTF32LE;
begin
  Test_EncodeBOMUTF32LE($0000FEFF,4);
end;

procedure TTest_IUnicodeCodec_Standard.EncodeBOMUTF8;
begin
  Test_EncodeBOMUTF8($BFBBEF,3);
end;

procedure TTest_IUnicodeCodec_Standard.EncodeCodepointToString;
begin
  Test_EncodeCodepointToString($0024,'$');
  //- I've been unable to convince FPC to compile two of the following
  //- three tests. It seems that somewhere between FPC/Lazarus, it's not
  //- possible to compile surrogate based UTF-16 code-poins as literals in
  //- source. Tests pass in Delphi, and while stepping through the FPC code
  //- using gdb, I can confirm that EncodeCodepointToString does produce the
  //- correct character at runtime. This is the best case I have for unit
  //- testing this code.
  {$ifndef fpc}
  Test_EncodeCodepointToString($20AC,'€');
  Test_EncodeCodepointToString($10437,'𐐷');
  Test_EncodeCodepointToString($24B62,'𤭢');
  {$else}
  Test_EncodeCodepointToString($20AC,UnicodeString(#$20AC)); // '€' - works.
  {$endif}
end;

procedure TTest_IUnicodeCodec_Standard.Test_AnsiDecode(var Data: uint32; const Expected: TUnicodeCodepoint);
var
  Codepoint: TUnicodeCodepoint;
begin
  Codepoint := 0;
  if not (unicode.AnsiDecode(Data,Codepoint)) then begin
    TTest.Fail('ANSI Decode call failed.');
  end;
  if not (codepoint=Expected) then begin
    TTest.Fail('ANSI decode results do not match.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_AnsiEncode(const Expected: uint32; const Codepoint: TUnicodeCodepoint);
var
  Data: uint32;
  Size: uint8;
begin
  Data := 0;
  Size := 0;
  if not (unicode.AnsiEncode(Codepoint,Data,Size)) then begin
    TTest.Fail('ANSI Encode call failed.');
  end;
  if not (Expected=Data) then begin
    TTest.Fail('ANSI Encode results do not match.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_DecodeBOMUTF16BE(Data: uint32; const Size: uint8; const Expected: boolean);
begin
  if not (unicode.DecodeBOM(Data,TUnicodeFormat.utf16BE,Size)=Expected) then begin
    TTest.Fail('UTF-16BE Decode BOM failed.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_DecodeBOMUTF16LE(Data: uint32; const Size: uint8; const Expected: boolean);
begin
  if not (unicode.DecodeBOM(Data,TUnicodeFormat.utf16LE,Size)=Expected) then begin
    TTest.Fail('UTF-16LE Decode BOM failed.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_DecodeBOMUTF32BE(Data: uint32; const Size: uint8; const Expected: boolean);
begin
  if not (unicode.DecodeBOM(Data,TUnicodeFormat.utf32BE,Size)=Expected) then begin
    TTest.Fail('UTF-32BE Decode BOM failed.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_DecodeBOMUTF32LE(Data: uint32; const Size: uint8; const Expected: boolean);
begin
  if not (unicode.DecodeBOM(Data,TUnicodeFormat.utf32LE,Size)=Expected) then begin
    TTest.Fail('UTF-32LE Decode BOM failed.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_DecodeBOMUTF8(Data: uint32; const Size: uint8; const Expected: boolean);
begin
  if not (unicode.DecodeBOM(Data,TUnicodeFormat.utf8,Size)=Expected) then begin
    TTest.Fail('UTF-8 Decode BOM failed.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_DecodeCodepointFromString(const s: string; const CodePoint: TUnicodeCodepoint);
var
  c: TUnicodeCodepoint;
  Cursor: int32;
begin
  c := 0;
  Cursor := 1;
  {$ifndef fpc} {$ifdef NEXTGEN} Cursor := 0; {$endif} {$endif}
  if not Unicode.DecodeCodepointFromString(c,s,cursor) then begin
    TTest.Fail('Decode Codepoint from string call failed.');
  end;
  if not (c=codepoint) then begin
    TTest.Fail('Decode Codepoint from string results did not match.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_EncodeBOMUTF16BE(const Expected: uint32; const ExpectedSize: uint8);
var
  BOM: uint32;
  Size: uint8;
begin
  BOM := 0;
  Size := 0;
  if not unicode.EncodeBOM(BOM,TUnicodeFormat.utf16BE,Size) then begin
    TTest.Fail('UTF-16BE BOM Encode call failed.');
  end;
  if not (ExpectedSize=Size) then begin
    TTest.Fail('UTF-16BE BOM Encode size mismatch.');
  end;
  if not (Expected=BOM) then begin
    TTest.Fail('UTF-16BE BOM Encode incorrect.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_EncodeBOMUTF16LE(const Expected: uint32; const ExpectedSize: uint8);
var
  BOM: uint32;
  Size: uint8;
begin
  BOM := 0;
  Size := 0;
  if not unicode.EncodeBOM(BOM,TUnicodeFormat.utf16LE,Size) then begin
    TTest.Fail('UTF-16LE BOM Encode call failed.');
  end;
  if not (ExpectedSize=Size) then begin
    TTest.Fail('UTF-16LE BOM Encode size mismatch.');
  end;
  if not (Expected=BOM) then begin
    TTest.Fail('UTF-16LE BOM Encode incorrect.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_EncodeBOMUTF32BE(const Expected: uint32; const ExpectedSize: uint8);
var
  BOM: uint32;
  Size: uint8;
begin
  BOM := 0;
  Size := 0;
  if not Unicode.EncodeBOM(BOM,TUnicodeFormat.utf32BE,Size) then begin
    TTest.Fail('UTF-32BE BOM Encode call failed.');
  end;
  if not (ExpectedSize=Size) then begin
    TTest.Fail('UTF-32BE BOM Encode size mismatch.');
  end;
  if not (Expected=BOM) then begin
    TTest.Fail('UTF-32BE BOM Encode incorrect.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_EncodeBOMUTF32LE(const Expected: uint32; const ExpectedSize: uint8);
var
  BOM: uint32;
  Size: uint8;
begin
  BOM := 0;
  Size := 0;
  if not Unicode.EncodeBOM(BOM,TUnicodeFormat.utf32LE,Size) then begin
    TTest.Fail('UTF-32LE BOM Encode call failed.');
  end;
  if not (ExpectedSize=Size) then begin
    TTest.Fail('UTF-32LE BOM Encode size mismatch.');
  end;
  if not (Expected=BOM) then begin
    TTest.Fail('UTF-32LE BOM Encode incorrect.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_EncodeBOMUTF8(const Expected: uint32; const ExpectedSize: uint8);
var
  BOM: uint32;
  Size: uint8;
begin
  BOM := 0;
  Size := 0;
  if not Unicode.EncodeBOM(BOM,TUnicodeFormat.utf8,Size) then begin
    TTest.Fail('UTF-8 BOM Encode call failed.');
  end;
  if not (ExpectedSize=Size) then begin
    TTest.Fail('UTF-8 BOM Encode size mismatch.');
  end;
  if not (Expected=BOM) then begin
    TTest.Fail('UTF-8 BOM Encode incorrect.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_EncodeCodepointToString(const CodePoint: TUnicodeCodepoint; const s: string);
var
  t: string;
begin
  t := '';
  if not Unicode.EncodeCodepointToString(Codepoint,t) then begin
    TTest.Fail('Encode codepoint to string call failed.');
  end;
 if not (t=s) then begin
   TTest.Fail('Encode codepoint to string results are not equal.');
 end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_UTF16BECharacterLength( var Data: uint32; const ExpectedLen: uint8 );
var
  s: uint8;
begin
  s := 0;
  if not (unicode.UTF16BECharacterLength(Data,s)) then begin
    TTest.Fail('UTF-16BE Character Length call failed.');
  end;
  if not (s=ExpectedLen) then begin
    TTest.Fail('UTF-16BE Character Length results are not equal.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_UTF16BEDecode(var Data: uint32; const Expected: TUnicodeCodepoint);
var
  Codepoint: TUnicodeCodepoint;
begin
  Codepoint := 0;
  if not unicode.UTF16BEDecode(Data,Codepoint) then begin
    TTest.Fail('UTF-16BE Decode call failed.');
  end;
  if not (codepoint=Expected) then begin
    TTest.Fail('UTF-16BE Decode results are not equal.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_UTF16BEEncode(const Expected: uint32; const Codepoint: TUnicodeCodepoint);
var
  Data: uint32;
  Size: uint8;
begin
  Size := 0;
  Data := 0;
  if not unicode.UTF16BEEncode(Codepoint,Data,Size) then begin
    TTest.Fail('UTF-16BE Encode call failed');
  end;
  if not (Expected=Data) then begin
    TTest.Fail('UTF-16BE Encode results are not equal.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_UTF16LECharacterLength( var Data: uint32; const ExpectedLen: uint8 );
var
  s: uint8;
begin
  s := 0;
  if not unicode.UTF16LECharacterLength(Data,s) then begin
    TTest.Fail('UTF-16LE Character length call failed.');
  end;
  if not (s=ExpectedLen) then begin
    TTest.Fail('UTF-16LE Character length results not equal.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_UTF16LEDecode(var Data: uint32; const Expected: TUnicodeCodepoint);
var
  Codepoint: TUnicodeCodepoint;
begin
  Codepoint := 0;
  if not unicode.UTF16LEDecode(Data,Codepoint) then begin
    TTest.Fail('UTF-16LE Decode call failed.');
  end;
  if not (codepoint=Expected) then begin
    TTest.Fail('UTF-16LE Decode results are not equal.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_UTF16LEEncode(const Expected: uint32; const Codepoint: TUnicodeCodepoint);
var
  Data: uint32;
  Size: uint8;
begin
  Data := 0;
  Size := 0;
  if not unicode.UTF16LEEncode(Codepoint,Data,Size) then begin
    TTest.Fail('UTF-16LE Encode call failed.');
  end;
  if not (Expected=Data) then begin
    TTest.Fail('UTF-16LE Encode results are not equal.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_UTF32BEDecode(var Data: uint32; const Expected: TUnicodeCodepoint);
var
  Codepoint: TUnicodeCodepoint;
begin
  Codepoint := 0;
  if not unicode.UTF32BEDecode(Data,Codepoint) then begin
    TTest.Fail('UTF-32BE Decode call failed.');
  end;
  if not (codepoint=Expected) then begin
    TTest.Fail('UTF-32BE Decode results are not equal.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_UTF32BEEncode(const Expected: uint32; const Codepoint: TUnicodeCodepoint);
var
  Data: uint32;
  Size: uint8;
begin
  Size := 0;
  Data := 0;
  if not unicode.UTF32BEEncode(Codepoint,Data,Size) then begin
    TTest.Fail('UTF-32BE Encode call failed.');
  end;
  if not (Expected=Data) then begin
    TTest.Fail('UTF-32BE Encode results are not equal.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_UTF32LEDecode(var Data: uint32; const Expected: TUnicodeCodepoint);
var
  Codepoint: TUnicodeCodepoint;
begin
  Codepoint := 0;
  if not unicode.UTF32LEDecode(Data,Codepoint) then begin
    TTest.Fail('UTF-32LE Decode call failed.');
  end;
  if not (codepoint=Expected) then begin
    TTest.Fail('UTF-32LE Decode results are not equal.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_UTF32LEEncode(const Expected: uint32; const Codepoint: TUnicodeCodepoint);
var
  Data: uint32;
  Size: uint8;
begin
  Size := 0;
  Data := 0;
  if not unicode.UTF32LEEncode(Codepoint,Data,Size) then begin
    TTest.Fail('UTF-32LE Encode call failed.');
  end;
  if not (Expected=Data) then begin
    TTest.Fail('UTF-32LE Encode results are not equal');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_UTF8CharacterLength( var Data: uint32; const ExpectedLen: uint8 );
var
  s: uint8;
begin
  s := 0;
  if not unicode.UTF8CharacterLength(Data,s) then begin
    TTest.Fail('UTF-8 Character Length call failed.');
  end;
  if not (s=ExpectedLen) then begin
    TTest.Fail('UTF-8 Character Length results are not equal.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_UTF8Decode(var Data: uint32; const Expected: TUnicodeCodepoint);
var
  Codepoint: TUnicodeCodepoint;
begin
  Codepoint := 0;
  if not unicode.UTF8Decode(Data,Codepoint) then begin
    TTest.Fail('UTF-8 Decode call failed.');
  end;
  if not (codepoint=Expected) then begin
    TTest.Fail('UTF-8 Decode results are not equal.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.Test_UTF8Encode(const Expected: uint32; const Codepoint: TUnicodeCodepoint);
var
  Data: uint32;
  Size: uint8;
begin
  Data := 0;
  Size := 0;
  if not unicode.UTF8Encode(Codepoint,Data,Size) then begin
    TTest.Fail('UTF-8 Encode call failed.');
  end;
  if not Expected=Data then begin
    TTest.Fail('UTF-8 Encode results are not equal.');
  end;
end;

procedure TTest_IUnicodeCodec_Standard.UTF16BECharacterLength;
var
  Data: uint32;
begin
  Data := $2400;
  Test_UTF16BECharacterLength(Data,2);
  Data := $AC20;
  Test_UTF16BECharacterLength(Data,2);
  Data := $01D837DC;
  Test_UTF16BECharacterLength(Data,4);
  Data := $52D862DF;
  Test_UTF16BECharacterLength(Data,4);
end;

procedure TTest_IUnicodeCodec_Standard.UTF16BEDecode;
var
  Data: uint32;
begin
  Data := $2400;
  Test_UTF16BEDecode(Data,$0024);
  Data := $AC20;
  Test_UTF16BEDecode(Data,$20AC);
  Data := $37DC01D8;
  Test_UTF16BEDecode(Data,$10437);
  Data := $62DF52D8;
  Test_UTF16BEDecode(Data,$24B62);
end;

procedure TTest_IUnicodeCodec_Standard.UTF16BEEncode;
begin
  Test_UTF16BEEncode($2400,$0024);
  Test_UTF16BEEncode($AC20,$20AC);
  Test_UTF16BEEncode($37DC01D8,$10437);
  Test_UTF16BEEncode($62DF52D8,$24B62);
end;

procedure TTest_IUnicodeCodec_Standard.UTF16LECharacterLength;
var
  Data: uint32;
begin
  Data := $0024;
  Test_UTF16LECharacterLength(Data,2);
  Data := $20AC;
  Test_UTF16LECharacterLength(Data,2);
  Data := $DC37D801;
  Test_UTF16LECharacterLength(Data,4);
  Data := $DF62D852;
  Test_UTF16LECharacterLength(Data,4);
end;

procedure TTest_IUnicodeCodec_Standard.UTF16LEDecode;
var
  Data: uint32;
begin
  Data := $0024;
  Test_UTF16LEDecode(Data,$0024);
  Data := $20AC;
  Test_UTF16LEDecode(Data,$20AC);
  Data := $DC37D801;
  Test_UTF16LEDecode(Data,$10437);
  Data := $DF62D852;
  Test_UTF16LEDecode(Data,$24B62);
end;

procedure TTest_IUnicodeCodec_Standard.UTF16LEEncode;
begin
  Test_UTF16LEEncode($0024,$0024);
  Test_UTF16LEEncode($20AC,$20AC);
  Test_UTF16LEEncode($DC37D801,$10437);
  Test_UTF16LEEncode($DF62D852,$24B62);
end;

procedure TTest_IUnicodeCodec_Standard.UTF32BEDecode;
var
  Data: uint32;
begin
  Data := $24000000;
  Test_UTF32BEDecode(Data,$0024);
  Data := $AC200000;
  Test_UTF32BEDecode(Data,$20AC);
  Data := $37040100;
  Test_UTF32BEDecode(Data,$10437);
  Data := $624B0200;
  Test_UTF32BEDecode(Data,$24B62);
end;

procedure TTest_IUnicodeCodec_Standard.UTF32BEEncode;
begin
  Test_UTF32BEEncode($24000000,$0024);
  Test_UTF32BEEncode($AC200000,$20AC);
  Test_UTF32BEEncode($37040100,$10437);
  Test_UTF32BEEncode($624B0200,$24B62);
end;

procedure TTest_IUnicodeCodec_Standard.UTF32LEDecode;
var
  Data: uint32;
begin
  Data := $00000024;
  Test_UTF32LEDecode(Data,$0024);
  Data := $000020AC;
  Test_UTF32LEDecode(Data,$20AC);
  Data := $00010437;
  Test_UTF32LEDecode(Data,$10437);
  Data := $00024B62;
  Test_UTF32LEDecode(Data,$24B62);
end;

procedure TTest_IUnicodeCodec_Standard.UTF32LEEncode;
begin
  Test_UTF32LEEncode($00000024,$0024);
  Test_UTF32LEEncode($000020AC,$20AC);
  Test_UTF32LEEncode($00010437,$10437);
  Test_UTF32LEEncode($00024B62,$24B62);
end;

procedure TTest_IUnicodeCodec_Standard.UTF8CharacterLength;
var
  Data: uint32;
begin
  Data := $65;
  Test_UTF8CharacterLength(Data,1);
  Data := $1A;
  Test_UTF8CharacterLength(Data,1);
  Data := $AC82E2;
  Test_UTF8CharacterLength(Data,3);
  Data := $888D90F0;
  Test_UTF8CharacterLength(Data,4);
end;

procedure TTest_IUnicodeCodec_Standard.UTF8Decode;
var
  Data: uint32;
begin
  Data := $24;
  Test_UTF8Decode(Data,$0024);
  Data := $A2C2;
  Test_UTF8Decode(Data,$00A2);
  Data := $AC82E2;
  Test_UTF8Decode(Data,$20AC);
  Data := $888D90F0;
  Test_UTF8Decode(Data,$10348);
end;

procedure TTest_IUnicodeCodec_Standard.UTF8Encode;
begin
  Test_UTF8Encode($24,$0024);
  Test_UTF8Encode($A2C2,$00A2);
  Test_UTF8Encode($AC82E2,$20AC);
  Test_UTF8Encode($888D90F0,$10348);
end;

initialization
  TestSuite.RegisterTestCase(TTest_IUnicodeCodec_Standard);

end.

