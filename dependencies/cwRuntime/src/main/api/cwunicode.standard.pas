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
/// </summary>
unit cwUnicode.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwUnicode
;

///  <summary>
///    Returns a singleton instance of IUnicodeCodec.
///  </summary>
function Unicode: IUnicodeCodec;

type
  ///  <summary>
  ///    TUnicodeString is a managed string type which may be used to represent,
  ///    and convert between, any of the supported unicode text formats. This
  ///    record uses pascal 'advanced-record' features to manage it's own
  ///    memory.
  ///    TUnicodeString defaults to UTF-8 format in order to be compatible with
  ///    ANSI. Assigning a string (unicode) or ansistring to a TUnicodeString
  ///    will revert it to UTF-8. You may then set a new format by altering
  ///    the UnicodeFormat property if required, however, such conversion
  ///    should not be necessary, as assignment to an appropriately typed
  ///    pointer will automatically convert the type also.
  ///  </summary>
  ///  <remarks>
  ///    Note that the strings stored within TUnicodeString are zero terminated.
  ///    When assigning strings to TUnicodeString using pointers, care must be
  ///    taken to ensure that the string has sufficient zero-termination
  ///    bytes in order to prevent buffer overrun. The number of bytes required
  ///    is reflected by the UTFFormat being used, i.e. utf8 = 1 byte,
  ///    utf16 = 2 bytes, utf32 = 4 bytes.
  ///  </remarks>
  TUnicodeString = record
  private
    {$region ' Record initialization'}
    //- The compiler (both Delphi and FPC) initializes interfaces to nil.
    //- We can therefore use an interface as an initialized variable for this
    //- record. When unassigned, the record is uninitialized. When the record
    //- goes out of scope, the initialized interface is cleaned up.
    //- All other methods will call 'EnsureInitialized' before performing their
    //- usual tasks.
    //- For translation to other compilers, this is a simple pointer and can
    //- thus be represented as f.x 'void *reserved;'
    fInitialized: IInterface;
    procedure EnsureInitialized; {$ifdef fpc} inline; {$endif}
    {$endregion}
  private
    //- When given a pointer to a unicode string, these methods measure
    //- the string up until the zero-terminator, returning the number of bytes
    //- required to store the string (without the terminator)
    class function MeasureUTF8String(const lpszUTF8: pointer): nativeuint; static;
    class function MeasureUTF16LEString(const lpszUTF16LE: pointer): nativeuint; static;
    class function MeasureUTF16BEString(const lpszUTF16BE: pointer): nativeuint; static;
    class function MeasureUTF32LEString(const lpszUTF32LE: pointer): nativeuint; static;
    class function MeasureUTF32BEString(const lpszUTF32BE: pointer): nativeuint; static;
    //- This function measures a unicode string provided in one format, to
    //- determine the number of bytes it would require to store the string
    //- in another format. The string must be zero terminated with an
    //- appropriate number of zero bytes.
    class function MeasureConvertedString(const lpszUTFString: pointer; const SourceFormat: TUnicodeFormat; const TargetFormat: TUnicodeFormat; out CodePoints: nativeuint ): nativeuint; overload; static; {$ifdef fpc} inline; {$endif}
    class function MeasureConvertedString(const value: string; const TargetFormat: TUnicodeFormat ): nativeuint; overload; static; {$ifdef fpc} inline; {$endif}
    //- Converts one unicode format string into another.
    //- Cares only about codepoints up until the terminator, the target buffer
    //- should be large enough to recieve the data including terminator, and
    //- already be initialized zero for the termination.
    class procedure ConvertUTFString( const srcPtr: pointer; const srcFormat: TUnicodeFormat; const tgtPtr: pointer; const tgtFormat: TUnicodeFormat ); overload; static; {$ifdef fpc} inline; {$endif}
    class function ConvertUTFString( const srcPtr: pointer; const srcFormat: TUnicodeFormat ): string; overload; static; {$ifdef fpc} inline; {$endif}
    class procedure ConvertUTFString( const value: string; const tgtPtr: pointer; const tgtFormat: TUnicodeFormat ); overload; static; {$ifdef fpc} inline; {$endif}
    //- Set from zero-terminated pointers to utf strings.
    procedure setAsPtrUTF8(const value: pointer); {$ifdef fpc} inline; {$endif}
    procedure setAsPtrUTF16BE(const value: pointer); {$ifdef fpc} inline; {$endif}
    procedure setAsPtrUTF16LE(const value: pointer); {$ifdef fpc} inline; {$endif}
    procedure setAsPtrUTF32BE(const value: pointer); {$ifdef fpc} inline; {$endif}
    procedure setAsPtrUTF32LE(const value: pointer); {$ifdef fpc} inline; {$endif}
    //- Getter / Setters
    function getDataSize: nativeuint;
    function getDataPtr: pointer;
    function getUnicodeFormat: TUnicodeFormat;
    procedure setDataPtr(Value: pointer);
    procedure setUnicodeFormat( const Format: TUnicodeFormat );
    function getAsString: string;
    procedure setAsString(const value: string);
  public
     ///  <summary>
     ///    Assign a string directly to a TUnicodeString record.
     ///    Note: This forces the TUnicodeString record back to UTF8
     ///  </summary>
     class operator Implicit(value: string): TUnicodeString;
     ///  <exclude/> // overload of the implicit
     class operator Explicit(value: string): TUnicodeString;
     ///  <summary>
     ///    Assign a pchar (UTF8 or ANSI) to TUnicodeString.
     ///    Note: This forces the TUnicodeString record back to UTF8
     ///  </summary>
     class operator Implicit(value: pointer): TUnicodeString;
     ///  <exclude/> // overload of the implicit
     class operator Explicit(value: pointer): TUnicodeString;
  public

    ///  <summary>
    ///    Returns the size of the data store in the TUnicodeString in bytes.
    ///  </summary>
    property Size: nativeuint read getDataSize;

    ///  <summary>
    ///    Get or Set the TUnicodeString using a pointer.
    ///    Reading this property returns a pointer to the internally stored
    ///    string data, which is stored in which-ever format the UnicodeFormat
    ///    property is set to. i.e. If UnicodeFormat is UTF8, this property
    ///    returns a pointer to a zero-terminated UTF8 string.
    ///    Writing to this property, copies the data from the assigned pointer
    ///    into the TUTF8String internal storage. The assigned pointer is
    ///    therefore expected to contain data in the appropriate format (as
    ///    determined by the UnicodeFormat property), and is expected to be
    ///    zero-terminated using sufficient bytes for that format. i.e.
    ///    If UnicodeFormat is utf8 a single zero-termination byte is required,
    ///    where-as two bytes are required for UTF16 formats, and four for
    ///    UTF32 formats.
    ///  </summary>
    property AsPtr: pointer read getDataPtr write setDataPtr;

    ///  <summary>
    ///    Get or Set the string as a string (type as determined by compiler).
    ///    If the
    ///  </summary>
    property AsString: string read getAsString write setAsString;

    ///  <summary>
    ///    Get or Set the current unicode format used for the TUnicodeString
    ///    internal format. When setting this property, any data already
    ///    stored in the TUFTString is converted to the newly specified
    ///    unicode format.
    ///  </summary>
    ///  <remarks>
    ///    Attempting to set this property to TUnicodeFormat.utfUnknown will
    ///    result in an EUTFUnknownNotSupported exception being raised.
    ///  </remarks>
    property UnicodeFormat: TUnicodeFormat read getUnicodeFormat write setUnicodeFormat;
  end;
  pUnicodeString = ^TUnicodeString;

implementation
uses
  cwUnicode.Codec.Standard
;

function Unicode: IUnicodeCodec;
begin
  Result := cwUnicode.Codec.Standard.Unicode;
end;

{$region ' TUTFStringDestructor '}

type
  IUTFStringData = interface
    ['{192CACF2-76B2-46C5-BACB-1714A256251B}']
    function getDataPtr: pointer;
    function getDataSize: nativeuint;
    function getUnicodeFormat: TUnicodeFormat;
    procedure setUnicodeFormat(const value: TUnicodeFormat);
    procedure FreeBuffer;
    procedure AllocBuffer(const size: nativeuint);
    property UnicodeFormat: TUnicodeFormat read getUnicodeFormat write setUnicodeFormat;
    property Data: pointer read getDataPtr;
    property DataSize: nativeuint read getDataSize;
  end;

  TUTFStringData = class( TInterfacedObject, IUTFStringData )
  private
    fData: pointer;
    fDataSize: nativeuint;
    fUnicodeFormat: TUnicodeFormat; //(4-bytes)
  strict private //- IUTFStringData -//
    function getDataPtr: pointer;
    function getDataSize: nativeuint;
    function getUnicodeFormat: TUnicodeFormat;
    procedure setUnicodeFormat(const value: TUnicodeFormat);
    procedure FreeBuffer;
    procedure AllocBuffer(const size: nativeuint);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

constructor TUTFStringData.Create;
begin
  inherited Create;
  //- Initialize a zero-terminated utf8 string.
  fUnicodeFormat := TUnicodeFormat.utf8;
  AllocBuffer(1);
  uint8(fData^) := 0;
end;

destructor TUTFStringData.Destroy;
begin
  FreeBuffer;
  inherited Destroy;
end;

function TUTFStringData.getDataPtr: pointer;
begin
  Result := fData;
end;

function TUTFStringData.getDataSize: nativeuint;
begin
  Result := fDataSize;
end;

function TUTFStringData.getUnicodeFormat: TUnicodeFormat;
begin
  Result := fUnicodeFormat;
end;

procedure TUTFStringData.setUnicodeFormat(const value: TUnicodeFormat);
begin
  fUnicodeFormat := value;
end;

procedure TUTFStringData.FreeBuffer;
begin
  FreeMem(fData,fDataSize);
  fData := nil;
  fDataSize := 0;
end;

procedure TUTFStringData.AllocBuffer(const size: nativeuint);
begin
  if assigned(fData) then begin
    FreeBuffer;
  end;
  fDataSize := Size;
  GetMem(fData,fDataSize);
end;

{$endregion}

{$region ' TUnicodeString'}

procedure TUnicodeString.EnsureInitialized; {$ifdef fpc} inline; {$endif}
begin
  if assigned(fInitialized) then begin
    exit;
  end;
  fInitialized := TUTFStringData.Create;
end;

class function TUnicodeString.MeasureConvertedString(const lpszUTFString: pointer; const SourceFormat: TUnicodeFormat; const TargetFormat: TUnicodeFormat; out CodePoints: nativeuint): nativeuint; {$ifdef fpc} inline; {$endif}
var
  lpSrc: pointer;
  CP: TUnicodeCodepoint;
  TempBuffer: uint32;
  CPSize: uint8;
  srcCPSize: uint8;
  BreakOut: boolean;
begin
  //- Ensure supported format
  if (SourceFormat = TUnicodeFormat.utfUnknown) or
     (TargetFormat = TUnicodeFormat.utfUnknown) then begin
    raise
      EUTFUnknownNotSupported.Create('MeasureConvertedString');
  end;
  //- Check for no format change.
  if SourceFormat=TargetFormat then begin
    case SourceFormat of
      utfANSI,
      utf8: Result := MeasureUTF8String( lpszUTFString );
      utf16LE: Result := MeasureUTF16LEString( lpszUTFString );
      utf16BE: Result := MeasureUTF16BEString( lpszUTFString );
      utf32LE: Result := MeasureUTF32LEString( lpszUTFString );
      utf32BE: Result := MeasureUTF32BEString( lpszUTFString );
      else begin
        raise EUnicodeConversion.Create('MeasureConvertedString');
      end;
    end;
    exit;
  end;
  //- Begin measuring.
  TempBuffer := 0;
  Result := 0;
  CodePoints := 0;
  lpSrc := lpszUTFString;
  BreakOut := False;
  repeat
    //- Break the loop when we find the terminator.
    case SourceFormat of
      utfANSI,
      utf8: if uint8(lpSrc^)=0 then BreakOut := True;
      utf16LE,
      utf16BE: if uint16(lpSrc^)=0 then BreakOut := True;
      utf32LE,
      utf32BE: if uint32(lpSrc^)=0 then BreakOut := True;
      else begin
        raise
          EUTFUnknownNotSupported.Create('MeasureConvertedString');
      end;
    end;
    if not BreakOut then begin
      inc(CodePoints);
      //- Decode the source code point
      case SourceFormat of
        utfANSI: if not Unicode.AnsiDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('MeasureConvertedString');
           utf8: if not Unicode.UTF8Decode(lpSrc^,CP) then raise EUnicodeConversion.Create('MeasureConvertedString');
        utf16LE: if not Unicode.UTF16LEDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('MeasureConvertedString');
        utf16BE: if not Unicode.UTF16BEDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('MeasureConvertedString');
        utf32LE: if not Unicode.UTF32LEDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('MeasureConvertedString');
        utf32BE: if not Unicode.UTF32BEDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('MeasureConvertedString');
        else raise EUnicodeConversion.Create('MeasureConvertedString');
      end;
      //- Encode the code-point in the target format to measure it.
      case TargetFormat of
        utfANSI: CPSize := sizeof(uint8); //- Ansi is always 1 byte.
           utf8: if not Unicode.UTF8Encode(CP,TempBuffer,CPSize) then raise EUnicodeConversion.Create('MeasureConvertedString');
        utf16LE: if not Unicode.UTF16LEEncode(CP,TempBuffer,CPSize) then raise EUnicodeConversion.Create('MeasureConvertedString');
        utf16BE: if not Unicode.UTF16BEEncode(CP,TempBuffer,CPSize) then raise EUnicodeConversion.Create('MeasureConvertedString');
        utf32LE,
        utf32BE: CPSize := sizeof(uint32); //- No point measuring utf32 formats, they are always 4 bytes.
        else raise EUnicodeConversion.Create('MeasureConvertedString');
      end;
      //- Encode the code-point in the source format to measure it.
      case SourceFormat of
        utfANSI: srcCPSize := sizeof(uint8); //- Ansi is always 1 byte.
           utf8: if not Unicode.UTF8Encode(CP,TempBuffer,srcCPSize) then raise EUnicodeConversion.Create('MeasureConvertedString');
        utf16LE: if not Unicode.UTF16LEEncode(CP,TempBuffer,srcCPSize) then raise EUnicodeConversion.Create('MeasureConvertedString');
        utf16BE: if not Unicode.UTF16BEEncode(CP,TempBuffer,srcCPSize) then raise EUnicodeConversion.Create('MeasureConvertedString');
        utf32LE,
        utf32BE: srcCPSize := sizeof(uint32); //- No point measuring utf32 formats, they are always 4 bytes.
        else raise EUnicodeConversion.Create('MeasureConvertedString');
      end;
      //- Accumulate and increment source pointer.
      Result := Result + CPSize;
      {$hints off} lpSrc := pointer( nativeuint(lpSrc) + srcCPSize ); {$hints on}
    end;
  until BreakOut;
end;

class function TUnicodeString.MeasureConvertedString(const value: string; const TargetFormat: TUnicodeFormat): nativeuint; {$ifdef fpc} inline; {$endif}
var
  Start: int32;
  Stop: int32;
  Cursor: int32;
  TempBuffer: uint32;
  CP: TUnicodeCodePoint;
  CPSize: uint8;
begin
  Result := 0;
  CP := 0;
  TempBuffer := 0;
  {$ifdef NEXTGEN} Start := 0; {$else} Start := 1; {$endif}
  {$ifdef NEXTGEN} Stop := pred(Length(value)); {$else} Stop := Length(Value); {$endif}
  Cursor := Start;
  repeat
    // Decode the code point
    if not Unicode.DecodeCodepointFromString(CP, Value, Cursor) then begin
      raise EUnicodeConversion.Create('MeasureConvertedString');
    end;
    // Measure the codepoint in new format
    case TargetFormat of
      utfANSI: CPSize := sizeof(uint8); //- Ansi is always 1 byte.
         utf8: if not Unicode.UTF8Encode(CP,TempBuffer,CPSize) then raise EUnicodeConversion.Create('MeasureConvertedString');
      utf16LE: if not Unicode.UTF16LEEncode(CP,TempBuffer,CPSize) then raise EUnicodeConversion.Create('MeasureConvertedString');
      utf16BE: if not Unicode.UTF16BEEncode(CP,TempBuffer,CPSize) then raise EUnicodeConversion.Create('MeasureConvertedString');
      utf32LE,
      utf32BE: CPSize := sizeof(uint32); //- No point measuring utf32 formats, they are always 4 bytes.
      else raise EUnicodeConversion.Create('MeasureConvertedString');
    end;
    Result := Result + CPSize;
  until Cursor>Stop;
end;

class procedure TUnicodeString.ConvertUTFString(const srcPtr: pointer; const srcFormat: TUnicodeFormat; const tgtPtr: pointer; const tgtFormat: TUnicodeFormat); {$ifdef fpc} inline; {$endif}
var
  lpSrc: pointer;
  lpTgt: pointer;
  CP: TUnicodeCodepoint;
  CPSize: uint8;
  srcCPSize: uint8;
  TempBuffer: uint32;
  BreakOut: boolean;
begin
  TempBuffer := 0;
  //- Ensure supported format
  if (srcFormat = TUnicodeFormat.utfUnknown) or
     (tgtFormat = TUnicodeFormat.utfUnknown) then begin
    raise
      EUTFUnknownNotSupported.Create('ConvertUTFString');
  end;
  //- Begin conversion
  lpSrc := srcPtr;
  lpTgt := tgtPtr;
  BreakOut := False;
  repeat
    //- Break the loop when we find the terminator.
    case srcFormat of
      utfANSI,
      utf8: if uint8(lpSrc^)=0 then BreakOut := True;
      utf16LE,
      utf16BE: if uint16(lpSrc^)=0 then BreakOut := True;
      utf32LE,
      utf32BE: if uint32(lpSrc^)=0 then BreakOut := True;
      else begin
        raise
          EUTFUnknownNotSupported.Create('ConvertUTFString');
      end;
    end;
    if not BreakOut then begin
      //- Decode the source code point
      case srcFormat of
        utfANSI: if not Unicode.AnsiDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('ConvertUTFString');
           utf8: if not Unicode.UTF8Decode(lpSrc^,CP) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf16LE: if not Unicode.UTF16LEDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf16BE: if not Unicode.UTF16BEDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf32LE: if not Unicode.UTF32LEDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf32BE: if not Unicode.UTF32BEDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('ConvertUTFString');
        else raise EUnicodeConversion.Create('MeasureConvertedString');
      end;
      //- Measure the code point in the source format.
      case srcFormat of
        utfANSI: srcCPSize := sizeof(uint8); //- Ansi is always 1 byte.
           utf8: if not Unicode.UTF8Encode(CP,TempBuffer,srcCPSize) then raise EUnicodeConversion.Create('MeasureConvertedString');
        utf16LE: if not Unicode.UTF16LEEncode(CP,TempBuffer,srcCPSize) then raise EUnicodeConversion.Create('MeasureConvertedString');
        utf16BE: if not Unicode.UTF16BEEncode(CP,TempBuffer,srcCPSize) then raise EUnicodeConversion.Create('MeasureConvertedString');
        utf32LE,
        utf32BE: srcCPSize := sizeof(uint32); //- No point measuring utf32 formats, they are always 4 bytes.
        else raise EUnicodeConversion.Create('MeasureConvertedString');
      end;
      //- Encode the code-point in the target format.
      case tgtFormat of
        utfANSI: if not Unicode.AnsiEncode(CP,lpTgt^,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
           utf8: if not Unicode.UTF8Encode(CP,lpTgt^,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf16LE: if not Unicode.UTF16LEEncode(CP,lpTgt^,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf16BE: if not Unicode.UTF16BEEncode(CP,lpTgt^,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf32LE: if not Unicode.UTF32LEEncode(CP,lpTgt^,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf32BE: if not Unicode.UTF32BEEncode(CP,lpTgt^,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
        else raise EUnicodeConversion.Create('MeasureConvertedString');
      end;
      //- Increment pointers
      {$hints off} lpSrc := pointer( nativeuint(lpSrc) + SrcCPSize ); {$hints on}
      {$hints off} lpTgt := pointer( nativeuint(lpTgt) + CPSize ); {$hints on}
    end;
  until BreakOut;
end;

class function TUnicodeString.ConvertUTFString(const srcPtr: pointer; const srcFormat: TUnicodeFormat): string; {$ifdef fpc} inline; {$endif}
var
  lpSrc: pointer;
  TempBuffer: uint32;
  CP: TUnicodeCodepoint;
  CPSize: uint8;
  BreakOut: boolean;
begin
  Result := '';
  TempBuffer := 0;
  //- Ensure supported format
  if (srcFormat = TUnicodeFormat.utfUnknown) then begin
    raise
      EUTFUnknownNotSupported.Create('ConvertUTFString');
  end;
  //- Begin conversion
  lpSrc := srcPtr;
  BreakOut := False;
  repeat
    //- Break the loop when we find the terminator.
    case srcFormat of
      utfANSI,
      utf8: if uint8(lpSrc^)=0 then BreakOut := True;
      utf16LE,
      utf16BE: if uint16(lpSrc^)=0 then BreakOut := True;
      utf32LE,
      utf32BE: if uint32(lpSrc^)=0 then BreakOut := True;
      else begin
        raise
          EUTFUnknownNotSupported.Create('ConvertUTFString');
      end;
    end;
    if not BreakOut then begin
      //- Decode the source code point
      case srcFormat of
        utfANSI: if not Unicode.AnsiDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('ConvertUTFString');
           utf8: if not Unicode.UTF8Decode(lpSrc^,CP) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf16LE: if not Unicode.UTF16LEDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf16BE: if not Unicode.UTF16BEDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf32LE: if not Unicode.UTF32LEDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf32BE: if not Unicode.UTF32BEDecode(lpSrc^,CP) then raise EUnicodeConversion.Create('ConvertUTFString');
        else raise EUnicodeConversion.Create('MeasureConvertedString');
      end;
      //- Measure the code-point
      case srcFormat of
        utfANSI: CPSize := sizeof(uint8);
           utf8: if not Unicode.UTF8Encode(CP,TempBuffer,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf16LE: if not Unicode.UTF16LEEncode(CP,TempBuffer,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf16BE: if not Unicode.UTF16BEEncode(CP,TempBuffer,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
        utf32LE,
        utf32BE: CPSize := sizeof(uint32);
        else raise EUnicodeConversion.Create('MeasureConvertedString');
      end;
      //- Encode the code-point in the target format.
      if not Unicode.EncodeCodepointToString(CP,Result) then begin
        raise EUnicodeConversion.Create('ConvertUTFString');
      end;
      //- Increment pointer
      {$hints off} lpSrc := pointer( nativeuint(lpSrc) + CPSize ); {$hints on}
    end;
  until BreakOut;
end;

class procedure TUnicodeString.ConvertUTFString( const value: string; const tgtPtr: pointer; const tgtFormat: TUnicodeFormat ); {$ifdef fpc} inline; {$endif}
var
  Start: int32;
  Stop: int32;
  Cursor: int32;
  CP: TUnicodeCodePoint;
  CPSize: uint8;
  lpTgt: pointer;
begin
  lpTgt := tgtPtr;
  CP := 0;
  {$ifdef NEXTGEN} Start := 0; {$else} Start := 1; {$endif}
  {$ifdef NEXTGEN} Stop := pred(Length(value)); {$else} Stop := Length(Value); {$endif}
  Cursor := Start;
  repeat
    // Decode the code point
    if not Unicode.DecodeCodepointFromString(CP, Value, Cursor) then begin
      raise EUnicodeConversion.Create('ConvertUTFString');
    end;
    // Encode the codepoint in new format
    case tgtFormat of
      utfANSI: if not Unicode.UTF8Encode(CP,lpTgt^,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
         utf8: if not Unicode.UTF8Encode(CP,lpTgt^,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
      utf16LE: if not Unicode.UTF16LEEncode(CP,lpTgt^,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
      utf16BE: if not Unicode.UTF16BEEncode(CP,lpTgt^,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
      utf32LE: if not Unicode.UTF32LEEncode(CP,lpTgt^,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
      utf32BE: if not Unicode.UTF32BEEncode(CP,lpTgt^,CPSize) then raise EUnicodeConversion.Create('ConvertUTFString');
      else raise EUnicodeConversion.Create('MeasureConvertedString');
    end;
    {$hints off} lpTgt := pointer( nativeuint( lpTgt )+CPSize ); {$hints on}
  until Cursor>Stop;
end;

class function TUnicodeString.MeasureUTF8String(const lpszUTF8: pointer): nativeuint;
var
  ptrUTF8: ^uint8;
  CPLen: uint8;
begin
  Result := 0;
  ptrUTF8 := lpszUTF8;
  while ptrUTF8^<>0 do begin
    if not Unicode.UTF8CharacterLength(ptrUTF8^,CPLen) then begin
      Result := 0;
      exit;
    end;
    Result := Result + CPLen;
    {$hints off} ptrUTF8 := pointer( nativeuint(ptrUTF8) + CPLen ); {$hints on}
  end;
end;

class function TUnicodeString.MeasureUTF16LEString(const lpszUTF16LE: pointer): nativeuint; {$ifdef fpc} inline; {$endif}
var
  ptrUTF16LE: ^uint16;
  CPLen: uint8;
begin
  Result := 0;
  ptrUTF16LE := lpszUTF16LE;
  while ptrUTF16LE^>0 do begin
    if not Unicode.UTF16LECharacterLength(ptrUTF16LE^,CPLen) then begin
      Result := 0;
      exit;
    end;
    Result := Result + CPLen;
    {$hints off} ptrUTF16LE := pointer( nativeuint(ptrUTF16LE) + CPLen ); {$hints on}
  end;
end;

class function TUnicodeString.MeasureUTF16BEString(const lpszUTF16BE: pointer): nativeuint; {$ifdef fpc} inline; {$endif}
var
  ptrUTF16BE: ^uint16;
  CPLen: uint8;
begin
  Result := 0;
  ptrUTF16BE := lpszUTF16BE;
  while ptrUTF16BE^>0 do begin
    if not Unicode.UTF16BECharacterLength(ptrUTF16BE^,CPLen) then begin
      Result := 0;
      exit;
    end;
    Result := Result + CPLen;
    {$hints off} ptrUTF16BE := pointer( nativeuint(ptrUTF16BE) + CPLen ); {$hints on}
  end;
end;

class function TUnicodeString.MeasureUTF32LEString(const lpszUTF32LE: pointer): nativeuint; {$ifdef fpc} inline; {$endif}
var
  ptrUTF32LE: ^uint32;
  CPLen: uint8;
begin
  Result := 0;
  ptrUTF32LE := lpszUTF32LE;
  while ptrUTF32LE^>0 do begin
    CPLen := sizeof(uint32);
    Result := Result + CPLen;
    {$hints off} ptrUTF32LE := pointer( nativeuint(ptrUTF32LE) + CPLen ); {$hints on}
  end;
end;

class function TUnicodeString.MeasureUTF32BEString(const lpszUTF32BE: pointer): nativeuint; {$ifdef fpc} inline; {$endif}
var
  ptrUTF32BE: ^uint32;
  CPLen: uint8;
begin
  Result := 0;
  ptrUTF32BE := lpszUTF32BE;
  while ptrUTF32BE^>0 do begin
    CPLen := sizeof(uint32);
    Result := Result + CPLen;
    {$hints off} ptrUTF32BE := pointer( nativeuint(ptrUTF32BE) + CPLen ); {$hints on}
  end;
end;

function TUnicodeString.getUnicodeFormat: TUnicodeFormat;
begin
  EnsureInitialized;
  Result := (fInitialized as IUTFStringData).UnicodeFormat;
end;

procedure TUnicodeString.setUnicodeFormat(const Format: TUnicodeFormat);
var
  CodePoints: nativeuint;
  ByteCount: nativeuint;
  fTempBuffer: pointer;
begin
  EnsureInitialized;
  if Format=(fInitialized as IUTFStringData).UnicodeFormat then begin
    exit;
  end;
  //- Convert from one format to another.
  //- Determine number of code-points and byte-count required.
  ByteCount := MeasureConvertedString((fInitialized as IUTFStringData).Data,(fInitialized as IUTFStringData).UnicodeFormat,Format,CodePoints);
  case Format of
    utfANSI,
    utf8: ByteCount := ByteCount + sizeof(uint8);
    utf16LE,
    utf16BE: ByteCount := ByteCount + sizeof(uint16);
    utf32LE,
    utf32BE: ByteCount := ByteCount + sizeof(uint32);
    else raise EUnicodeConversion.Create('MeasureConvertedString');
  end;
  //- If there are no code-points to convert, simply set to null-string in
  //- new format and end.
  if CodePoints=0 then begin
    (fInitialized as IUTFStringData).FreeBuffer;
    (fInitialized as IUTFStringData).UnicodeFormat := Format;
    case (fInitialized as IUTFStringData).UnicodeFormat of
      utfANSI,
      utf8: begin
        (fInitialized as IUTFStringData).AllocBuffer(sizeof(uint8));
        FillChar((fInitialized as IUTFStringData).Data^,Sizeof(uint8),0);
      end;
      utf16LE,
      utf16BE: begin
        (fInitialized as IUTFStringData).AllocBuffer(sizeof(uint16));
        FillChar((fInitialized as IUTFStringData).Data^,Sizeof(uint16),0);
      end;
      utf32LE,
      utf32BE: begin
        (fInitialized as IUTFStringData).AllocBuffer(sizeof(uint32));
        FillChar((fInitialized as IUTFStringData).Data^,Sizeof(uint32),0);
      end;
      else raise EUnicodeConversion.Create('MeasureConvertedString');
    end;
    exit;
  end;
  //- Allocate sufficient memory for the converted string.
  GetMem(fTempBuffer,ByteCount);
  try
    FillChar(fTempBuffer^,ByteCount,0);
    //- Perform conversion
    ConvertUTFString( (fInitialized as IUTFStringData).Data, (fInitialized as IUTFStringData).UnicodeFormat, fTempBuffer, Format );
    //- Copy the new data into place and set new format.
    (fInitialized as IUTFStringData).FreeBuffer;
    (fInitialized as IUTFStringData).AllocBuffer(ByteCount);
    Move(fTempBuffer^,(fInitialized as IUTFStringData).Data^,ByteCount);
    (fInitialized as IUTFStringData).UnicodeFormat := Format;
  finally
    FreeMem(fTempBuffer,ByteCount);
  end;
end;

function TUnicodeString.getAsString: string;
begin
  EnsureInitialized;
  Result := '';
  case (fInitialized as IUTFStringData).UnicodeFormat of
    utfAnsi,
       utf8: if (fInitialized as IUTFStringData).DataSize=sizeof(uint8) then exit;
    utf16LE,
    utf16BE: if (fInitialized as IUTFStringData).DataSize=sizeof(uint16) then exit;
    utf32LE,
    utf32BE: if (fInitialized as IUTFStringData).DataSize=sizeof(uint32) then exit;
    else raise EUnicodeConversion.Create('MeasureConvertedString');
  end;
  Result := ConvertUTFString((fInitialized as IUTFStringData).Data,(fInitialized as IUTFStringData).UnicodeFormat);
end;

procedure TUnicodeString.setAsString(const value: string);
var
  TmpSize: nativeuint;
begin
  EnsureInitialized;
  (fInitialized as IUTFStringData).FreeBuffer;
  if Value='' then begin
    case (fInitialized as IUTFStringData).UnicodeFormat of
      utfAnsi,
         utf8: TmpSize := sizeof(uint8);
      utf16LE,
      utf16BE: TmpSize := sizeof(uint16);
      utf32LE,
      utf32BE: TmpSize := sizeof(uint32);
      else raise EUnicodeConversion.Create('MeasureConvertedString');
    end;
    (fInitialized as IUTFStringData).AllocBuffer(TmpSize);
    FillChar((fInitialized as IUTFStringData).Data^,(fInitialized as IUTFStringData).DataSize,0);
    exit;
  end;
  case (fInitialized as IUTFStringData).UnicodeFormat of
    utfAnsi,
       utf8: TmpSize := MeasureConvertedString(value,(fInitialized as IUTFStringData).UnicodeFormat) + sizeof(uint8);
    utf16LE,
    utf16BE: TmpSize := MeasureConvertedString(value,(fInitialized as IUTFStringData).UnicodeFormat) + sizeof(uint16);
    utf32LE,
    utf32BE: TmpSize := MeasureConvertedString(value,(fInitialized as IUTFStringData).UnicodeFormat) + sizeof(uint32);
    else raise EUnicodeConversion.Create('MeasureConvertedString');
  end;
  (fInitialized as IUTFStringData).AllocBuffer(TmpSize);
  FillChar((fInitialized as IUTFStringData).Data^,(fInitialized as IUTFStringData).DataSize,0);
  ConvertUTFString(value,(fInitialized as IUTFStringData).Data,(fInitialized as IUTFStringData).UnicodeFormat);
end;

class operator TUnicodeString.Implicit(value: string): TUnicodeString;
begin
  Result.AsString := value;
end;

class operator TUnicodeString.Explicit(value: string): TUnicodeString;
begin
  Result.AsString := value;
end;

class operator TUnicodeString.Implicit(value: pointer): TUnicodeString;
begin
  Result.AsPtr := value;
end;

class operator TUnicodeString.Explicit(value: pointer): TUnicodeString;
begin
  Result.AsPtr := value;
end;

procedure TUnicodeString.setAsPtrUTF8(const value: pointer); {$ifdef fpc} inline; {$endif}
var
  Measure: nativeuint;
begin
  EnsureInitialized;
  Measure := MeasureUTF8String(value);
  (fInitialized as IUTFStringData).FreeBuffer;
  (fInitialized as IUTFStringData).AllocBuffer(Measure+sizeof(uint8));
  FillChar((fInitialized as IUTFStringData).Data^,(fInitialized as IUTFStringData).DataSize,0);
  Move(Value^,(fInitialized as IUTFStringData).Data^,Measure);
end;

procedure TUnicodeString.setAsPtrUTF16LE(const value: pointer); {$ifdef fpc} inline; {$endif}
var
  Measure: nativeuint;
begin
  EnsureInitialized;
  Measure := MeasureUTF16LEString(value);
  (fInitialized as IUTFStringData).FreeBuffer;
  (fInitialized as IUTFStringData).AllocBuffer(Measure+sizeof(uint16));
  FillChar((fInitialized as IUTFStringData).Data^,(fInitialized as IUTFStringData).DataSize,0);
  Move(Value^,(fInitialized as IUTFStringData).Data^,Measure);
end;

procedure TUnicodeString.setAsPtrUTF16BE(const value: pointer); {$ifdef fpc} inline; {$endif}
var
  Measure: nativeuint;
begin
  EnsureInitialized;
  Measure := MeasureUTF16BEString(value);
  (fInitialized as IUTFStringData).FreeBuffer;
  (fInitialized as IUTFStringData).AllocBuffer(Measure+sizeof(uint16));
  FillChar((fInitialized as IUTFStringData).Data^,(fInitialized as IUTFStringData).DataSize,0);
  Move(Value^,(fInitialized as IUTFStringData).Data^,Measure);
end;

procedure TUnicodeString.setAsPtrUTF32LE(const value: pointer); {$ifdef fpc} inline; {$endif}
var
  Measure: nativeuint;
begin
  EnsureInitialized;
  Measure := MeasureUTF32LEString(value);
  (fInitialized as IUTFStringData).FreeBuffer;
  (fInitialized as IUTFStringData).AllocBuffer(Measure+sizeof(uint32));
  FillChar((fInitialized as IUTFStringData).Data^,(fInitialized as IUTFStringData).DataSize,0);
  Move(Value^,(fInitialized as IUTFStringData).Data^,Measure);
end;

function TUnicodeString.getDataSize: nativeuint;
begin
  EnsureInitialized;
  Result := (fInitialized as IUTFStringData).DataSize;
end;

procedure TUnicodeString.setAsPtrUTF32BE(const value: pointer); {$ifdef fpc} inline; {$endif}
var
  Measure: nativeuint;
begin
  EnsureInitialized;
  Measure := Self.MeasureUTF32BEString(value);
  (fInitialized as IUTFStringData).FreeBuffer;
  (fInitialized as IUTFStringData).AllocBuffer(Measure+sizeof(uint32));
  FillChar((fInitialized as IUTFStringData).Data^,(fInitialized as IUTFStringData).DataSize,0);
  Move(Value^,(fInitialized as IUTFStringData).Data^,Measure);
end;

procedure TUnicodeString.setDataPtr(Value: pointer);
begin
  EnsureInitialized;
  if not assigned(value) then begin
    (fInitialized as IUTFStringData).FreeBuffer;
    (fInitialized as IUTFStringData).AllocBuffer(sizeof(uint8));
    FillChar((fInitialized as IUTFStringData).Data^,sizeof(uint8),0);
    exit;
  end;
  case (fInitialized as IUTFStringData).UnicodeFormat of
    TUnicodeFormat.utfANSI,
       TUnicodeFormat.utf8: setAsPtrUTF8(value);
    TUnicodeFormat.utf16LE: setAsPtrUTF16LE(value);
    TUnicodeFormat.utf16BE: setAsPtrUTF16BE(value);
    TUnicodeFormat.utf32LE: setAsPtrUTF32LE(value);
    TUnicodeFormat.utf32BE: setAsPtrUTF32BE(value);
    else begin
      raise EUTFUnknownNotSupported.Create('SetDataPtr');
    end;
  end;
end;

function TUnicodeString.getDataPtr: pointer;
begin
  EnsureInitialized;
  Result := (fInitialized as IUTFStringData).Data;
end;

{$endregion}

end.

