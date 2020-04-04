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
unit cwIO.UnicodeStream.Custom;
{$ifdef fpc} {$mode delphiunicode} {$endif}

interface
uses
  cwUnicode
, cwUnicode.Standard
, cwIO
, cwIO.Stream.Custom
;

type
  TCustomUnicodeStream = class( TCustomStream, IStream )
  protected
    function ReadBOM( const Format: TUnicodeFormat ): boolean;
    procedure WriteBOM( const Format: TUnicodeFormat );
    function DetermineUnicodeFormat: TUnicodeFormat;
    procedure WriteString( const aString: string; const Format: TUnicodeFormat );
    function ReadString( const Format: TUnicodeFormat; const ZeroTerm: boolean = False; const Max: int32 = -1 ): string;
    procedure WriteChar( const aChar: char; const Format: TUnicodeFormat );
    function ReadChar( const Format: TUnicodeFormat ): char;
  public
    property EndOfStream;
    property Position;
    property Size;
  end;

implementation

function TCustomUnicodeStream.DetermineUnicodeFormat: TUnicodeFormat;
begin
  Result := TUnicodeFormat.utfUnknown;
  if ReadBOM(TUnicodeFormat.utf32LE) then begin
    Result := TUnicodeFormat.utf32LE;
  end else if ReadBOM(TUnicodeFormat.utf32BE) then begin
    Result := TUnicodeFormat.utf32BE;
  end else if ReadBOM(TUnicodeFormat.utf16LE) then begin
    Result := TUnicodeFormat.utf16LE
  end else if ReadBOM(TUnicodeFormat.utf16BE) then begin
    Result := TUnicodeFormat.utf16BE;
  end else if ReadBOM(TUnicodeFormat.utf8) then begin
    Result := TUnicodeFormat.utf8;
  end;
end;

function TCustomUnicodeStream.ReadBOM(const Format: TUnicodeFormat): boolean;
var
  p: uint64;
  BomSize: uint8;
  Buffer32: uint32;
  Buffer16: uint16;
begin
  Result := False;
  Buffer16 := 0;
  Buffer32 := 0;
  P := Self.Position;
  try
    BomSize := 0;
    // Determine BOM size.
    case Format of
      TUnicodeFormat.utfUnknown: BomSize := 0;
         TUnicodeFormat.utfANSI: BomSize := 0;
            TUnicodeFormat.utf8: BomSize := 3;
         TUnicodeFormat.utf16LE: BomSize := 2;
         TUnicodeFormat.utf16BE: BomSize := 2;
         TUnicodeFormat.utf32LE: BomSize := 4;
         TUnicodeFormat.utf32BE: BomSize := 4;
    end;
    if BomSize>0 then begin
      if BomSize>2 then begin
        if Read(@Buffer32,BOMSize)=BOMSize then begin
          Result := Unicode.DecodeBOM(Buffer32,Format,BOMSize);
        end;
      end else begin
        Read(@Buffer16,BomSize);
        Result := Unicode.DecodeBOM(Buffer16,Format,BomSize);
      end;
    end;
  finally
    if not Result then begin
      Self.Position := P;
    end;
  end;
end;

function TCustomUnicodeStream.ReadString(const Format: TUnicodeFormat; const ZeroTerm: boolean = False; const Max: int32 = -1): string;
var
  count: int32;
  CP: uint32;
  bytecount: uint8;
  Buffer: uint64;
  BufferPtr: pointer;
begin
  Result := '';
  CP := 0;
  ByteCount := 0;
  if Format<>TUnicodeFormat.utfUnknown then begin
    count := 0;
    while ((not getEndOfStream) and (Max<0)) or ((Max>=0) and (count<Max)) do begin
      BufferPtr := @Buffer;
      // decode a codepoint
      {$warnings off}
      case Format of

        TUnicodeFormat.utfANSI: begin
          Read(BufferPtr,sizeof(uint8));
          Unicode.AnsiDecode(Buffer,CP);
        end;

        TUnicodeFormat.utf8: begin
          Read(BufferPtr,sizeof(uint8));
          Unicode.UTF8CharacterLength(Buffer, bytecount);
          if bytecount>1 then begin
            {$ifdef fpc} {$hints off} {$endif}
            BufferPtr := pointer(nativeuint(BufferPtr) + sizeof(uint8));
            {$ifdef fpc} {$hints on} {$endif}
            Read(BufferPtr,pred(bytecount));
          end;
          Unicode.UTF8Decode(Buffer,CP);
        end;

        TUnicodeFormat.utf16LE: begin
          Read(BufferPtr,sizeof(uint16));
          Unicode.UTF16LECharacterLength(Buffer, bytecount);
          if bytecount>2 then begin
            {$ifdef fpc} {$hints off} {$endif}
            BufferPtr := pointer(nativeuint(BufferPtr) + sizeof(uint16));
            {$ifdef fpc} {$hints on} {$endif}
            Read(BufferPtr,sizeof(uint16)); // read the extra 2
          end;
          Unicode.UTF16LEDecode(Buffer,CP);
        end;

        TUnicodeFormat.utf16BE: begin
          Read(BufferPtr,sizeof(uint16));
          Unicode.UTF16BECharacterLength(Buffer,bytecount);
          if bytecount>2 then begin
            {$ifdef fpc} {$hints off} {$endif}
            BufferPtr := pointer(nativeuint(BufferPtr) + sizeof(uint16));
            {$ifdef fpc} {$hints on} {$endif}
            Read(BufferPtr,sizeof(uint16)); // read the extra 2
          end;
          Unicode.UTF16BEDecode(Buffer,CP);
        end;

        TUnicodeFormat.utf32LE: begin
          Read(BufferPtr,Sizeof(uint32));
          Unicode.UTF32LEDecode(Buffer,CP);
        end;

        TUnicodeFormat.utf32BE: begin
          Read(BufferPtr,Sizeof(uint32));
          Unicode.UTF32BEDecode(Buffer,CP);
        end;

      end;
      // Check for zero terminator
      if (CP=0) and (ZeroTerm) then begin
        Exit;
      end;
      // add the codepoint to the string
      Unicode.EncodeCodepointToString(CP,Result);
      inc(count);
    end;
    {$warnings on} // Warns that not all cases are covered, utfUnknown is covered in external predicate.
  end;
end;

procedure TCustomUnicodeStream.WriteChar(const aChar: char; const Format: TUnicodeFormat);
var
  Cursor: int32;
  Buffer: uint64;
  CP: uint32;
  L: uint8;
  aString: string;
begin
  aString := ''+aChar;
  Cursor := 1;
  // decode a character
  CP := 0;
  L := 0;
  Unicode.DecodeCodepointFromString(CP,aString,Cursor);
  Buffer := 0;
  {$warnings off}
  case Format of

    TUnicodeFormat.utfANSI: begin
      Unicode.ANSIEncode(CP,Buffer,L);
    end;

    TUnicodeFormat.utf8: begin
      Unicode.UTF8Encode(CP,Buffer,L);
    end;

    TUnicodeFormat.utf16LE: begin
      Unicode.UTF16LEEncode(CP,Buffer,L);
    end;

    TUnicodeFormat.utf16BE: begin
      Unicode.UTF16BEEncode(CP,Buffer,L);
    end;

    TUnicodeFormat.utf32LE: begin
      Unicode.UTF32LEEncode(CP,Buffer,L);
    end;

    TUnicodeFormat.utf32BE: begin
      Unicode.UTF32BEEncode(CP,Buffer,L);
    end;

  end;
  {#warnings on} // warns that not all cases are covered, utfUnknown does not need to be included.
  Self.Write(@Buffer,L);
end;

function TCustomUnicodeStream.ReadChar(const Format: TUnicodeFormat): char;
var
  CP: uint32;
  bytecount: uint8;
  Buffer: uint64;
  BufferPtr: pointer;
  aString: string;
begin
  CP := 0;
  Result := chr($0);
  ByteCount := 0;
  if Format<>TUnicodeFormat.utfUnknown then begin
    if (not getEndOfStream) then begin
      BufferPtr := @Buffer;
      // decode a codepoint
      {$warnings off}
      case Format of

        TUnicodeFormat.utfANSI: begin
          Read(BufferPtr,sizeof(uint8));
          Unicode.AnsiDecode(Buffer,CP);
        end;

        TUnicodeFormat.utf8: begin
          Read(BufferPtr,sizeof(uint8));
          Unicode.UTF8CharacterLength(Buffer, bytecount);
          if bytecount>1 then begin
            {$ifdef fpc} {$hints off} {$endif}
            BufferPtr := pointer(nativeuint(BufferPtr) + sizeof(uint8));
            {$ifdef fpc} {$hints on} {$endif}
            Read(BufferPtr,pred(bytecount));
          end;
          Unicode.UTF8Decode(Buffer,CP);
        end;

        TUnicodeFormat.utf16LE: begin
          Read(BufferPtr,sizeof(uint16));
          Unicode.UTF16LECharacterLength(Buffer, bytecount);
          if bytecount>2 then begin
            {$ifdef fpc} {$hints off} {$endif}
            BufferPtr := pointer(nativeuint(BufferPtr) + sizeof(uint16));
            {$ifdef fpc} {$hints on} {$endif}
            Read(BufferPtr,sizeof(uint16)); // read the extra 2
          end;
          Unicode.UTF16LEDecode(Buffer,CP);
        end;

        TUnicodeFormat.utf16BE: begin
          Read(BufferPtr,sizeof(uint16));
          Unicode.UTF16BECharacterLength(Buffer,bytecount);
          if bytecount>2 then begin
            {$ifdef fpc} {$hints off} {$endif}
            BufferPtr := pointer(nativeuint(BufferPtr) + sizeof(uint16));
            {$ifdef fpc} {$hints on} {$endif}
            Read(BufferPtr,sizeof(uint16)); // read the extra 2
          end;
          Unicode.UTF16BEDecode(Buffer,CP);
        end;

        TUnicodeFormat.utf32LE: begin
          Read(BufferPtr,Sizeof(uint32));
          Unicode.UTF32LEDecode(Buffer,CP);
        end;

        TUnicodeFormat.utf32BE: begin
          Read(BufferPtr,Sizeof(uint32));
          Unicode.UTF32BEDecode(Buffer,CP);
        end;

      end;
      {$warnings on} // warns that not all cases are covered, utfUnknown does not need to be covered.
      // add the codepoint to the string
      aString := '';
      Unicode.EncodeCodepointToString(CP,aString);
      {$ifdef NEXTGEN}
        {$ifndef Linux} //- Doesn't make sense that Linux compiler is not zero-based, despite being nextgen
          result := aString[0];
        {$else}
          result := aString[1];
        {$endif}
      {$else}
      result := aString[1];
      {$endif}
    end;
  end;
end;

procedure TCustomUnicodeStream.WriteBOM(const Format: TUnicodeFormat);
var
  Buffer: uint64;
  L: uint8;
begin
  Unicode.EncodeBOM(Buffer{%H-},Format,L{%H-});
  Self.Write(@Buffer,L);
end;

procedure TCustomUnicodeStream.WriteString(const aString: string; const Format: TUnicodeFormat);
var
  Cursor: int32;
  Buffer: uint64;
  CP: uint32;
  L: uint8;
begin
  Cursor := 1;
  // decode a character
    while (Cursor<=Length(aString)) do begin
      CP := 0;
      L := 0;
      Unicode.DecodeCodepointFromString(CP,aString,Cursor);
      Buffer := 0;
      {$warnings off}
      case Format of

        TUnicodeFormat.utfANSI: begin
          Unicode.ANSIEncode(CP,Buffer,L);
        end;

        TUnicodeFormat.utf8: begin
          Unicode.UTF8Encode(CP,Buffer,L);
        end;

        TUnicodeFormat.utf16LE: begin
          Unicode.UTF16LEEncode(CP,Buffer,L);
        end;

        TUnicodeFormat.utf16BE: begin
          Unicode.UTF16BEEncode(CP,Buffer,L);
        end;

        TUnicodeFormat.utf32LE: begin
          Unicode.UTF32LEEncode(CP,Buffer,L);
        end;

        TUnicodeFormat.utf32BE: begin
          Unicode.UTF32BEEncode(CP,Buffer,L);
        end;

      end;
      {$warnings on} // warns that not all cases are covered, utfUnknown does not need to be covered.
      Self.Write(@Buffer,L);
    end;
end;



end.


