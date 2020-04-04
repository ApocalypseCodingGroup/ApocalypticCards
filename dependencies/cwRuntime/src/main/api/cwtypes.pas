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
///   Chapmanworld Logging system library.
/// </summary>
/// <remarks>
///   NOTE: ** 16-bit half precision float type thanks to Marek Mauder <br/>
///   https://galfar.vevb.net/wp/2011/16bit-half-float-in-pascaldelphi/
/// </remarks>
unit cwTypes;
{$ifdef fpc}
  {$mode delphiunicode}
  {$ifdef CPU64}
  {$define CPU64BITS}
  {$endif}
{$endif}

interface
{$ifdef fpc}{$MODESWITCH ADVANCEDRECORDS}{$MODESWITCH TYPEHELPERS}{$endif}
uses
  sysutils //[RTL]
;

const
  /// <summary>
  ///   A constant representing a carriage return character from the ascii set.
  /// </summary>
  CR = #13;

  /// <summary>
  ///   A constant representing a line feed character from the ascii set. <br />
  /// </summary>
  LF = #10;

  /// <summary>
  ///   A constant representing a tab feed character from the ascii set.
  /// </summary>
  TAB = #9;

  /// <summary>
  ///   A constant representing a carrage return character followed by a line
  ///   feed character from the ascii set.
  /// </summary>
  CRLF: string = CR + LF;

{$region ' Supporting types.'}
type
  {$if defined(ANDROID) or defined(IOS)}
  AnsiChar = uint8;
  pAnsiChar = ^AnsiChar;
  {$endif}

  ///  <summary>
  ///    A simple alias for dynamic array of string.
  ///    This type is used as the return type for the TStringHelper.Explode()
  ///    method.
  ///  </summary>
  TArrayOfString = array of string;

{$endregion}
{$region ' Helper for string'}
type
  TStringHelper = record helper for string
  public

    ///  <summary>
    ///    Returns the length of the string.
    ///  </summary>
    function Len: nativeuint;

    ///  <summary>
    ///    Returns the string as an ansistring.
    ///    Getter for AsAnsiString property.
    ///  <summary>
    function getAsAnsiString: ansiString;

    ///  <summary>
    ///    Sets the string as an ansistring.
    ///    Setter for AsAnsiString property.
    ///  <summary>
    procedure setAsAnsiString( const value: ansistring );

    ///  <summary>
    ///    Sets the string using a pansichar / pchar.
    ///  </summary>
    procedure SetAsPChar( const value: pointer );

    ///  <summary>
    ///    Pads the left side of the string with the ch character until the
    ///    length of the string matches CharCount. (Unlike PadLeft which
    ///    pre-fixes the string).
    ///  </summary>
    function LeftPad( const CharCount: nativeuint; const ch: char ): string;

    ///  <summary>
    ///    Pads the right side of the string with the ch character until
    ///    the length of the string matches CharCount. (Unlike PadRight which
    ///    post-fixes the string).
    ///  </summary>
    function RightPad( const CharCount: nativeuint; const ch: char ): string;

    ///  <summary>
    ///    Separates the string for each instance of cDelimiter found.
    ///    The optional iCount parameter can be used to limit the number of
    ///    result strings.
    ///  </summary>
    function Explode( const cDelimiter: string; const iCount: uint32 = 0 ): TArrayOfString;

    ///  <summary>
    ///    Combines the 'Parts' into a single string, separated by cDelimiter.
    ///  </summary>
    function Combine( const cDelimiter: string; const Parts: TArrayOfString; const StartIdx: uint32 = 0): string;

    ///  <summary>
    ///    Trims white-space characters from the start of and end of the string.
    ///  </summary>
    function Trim: string;

    ///  <summary>
    ///    Replaces lower-case characters with upper-case characters.
    ///  </summary>
    function Uppercase: string;

    ///  <summary>
    ///    Performs both Uppercase() and Trim()
    ///  </summary>
    function UppercaseTrim: string;

    ///  <summary>
    ///    Replaces upper-case characters with lower-case charaacters
    ///  </summary>
    function Lowercase: string;

    ///  <summary>
    ///    Performs both Lowercase() and Trim()
    ///  </summary>
    function LowercaseTrim: string;

    ///  <summary>
    ///    Replaces instances of OldParttern with NewPattern.
    ///  </summary>
    function StringReplace(const OldPattern, NewPattern: string; const ReplaceAll: boolean = false; const IgnoreCase: boolean = false): string;

    ///  <summary>
    ///    Returns 'ACount' characters from the left of the string.
    ///  </summary>
    function LeftStr(const ACount: int32): string;

    ///  <summary>
    ///    Returns 'ACount' characters from the right of the string.
    ///  </summary>
    function RightStr(const ACount: int32): string;

    ///  <summary>
    ///    Returns 'ACount' characters from the position 'AStart' within
    ///    the string.
    ///  </summary>
    function MidStr(const AStart, ACount: uint32): string;

    ///  <summary>
    ///    Returns the poisition at which 'SubStr' is found within the string.
    ///    If 'SubStr' is not found, returns -1
    ///  </summary>
    function Pos(const SubStr: string): int32;

    ///  <summary>
    ///    Inserts 'Padding' instances of 'PaddingChar' at the left of the
    ///    string (prefix}
    ///  </summary>
    function Padleft(const Padding: uint32; const PaddingChar: char): string;

    ///  <summary>
    ///    Inserts 'Padding' instances of 'PaddignChar' at the right of the
    ///    string (postfix)
    ///  </summary>
    function PadRight(const Padding: uint32; const PaddingChar: char): string;

    ///  <summary>
    ///    Returns the string as a boolean.
    ///    The return of this funciton is true if the string matches the
    ///    positive parameter, otherwise returns false.
    ///  </summary>
    function AsBoolean(const CaseSensitive: boolean = False; const positive: string = 'TRUE' ): boolean;

    ///  <summary>
    ///    Returns the string as an unsigned int8
    ///  </summary>
    function AsUInt8: uint8;

    ///  <summary>
    ///    Returns the string as an unsigned int16
    ///  </summary>
    function AsUInt16: uint16;

    ///  <summary>
    ///    Returns the string as an unsigned int32
    ///  </summary>
    function AsUint32: uint32;

    ///  <summary>
    ///    Returns the string as an insigned int64
    ///  </summary>
    function AsUint64: uint64;

    ///  <summary>
    ///    Returns the string as a signed int8
    ///  </summary>
    function AsInt8: int8;

    ///  <summary>
    ///    Returns the string as a signed int16
    ///  </summary>
    function AsInt16: int16;

    ///  <summary>
    ///    Returns the string as a signed int32
    ///  </summary>
    function AsInt32: int32;

    ///  <summary>
    ///    Returns the string as a signed int64
    ///  </summary>
    function AsInt64: int64;

    ///  <summary>
    ///    Returns the string as a single-precision floating point.
    ///  </summary>
    function AsSingle: single;

    ///  <summary>
    ///    Returns the string as a double-precision floating point.
    ///  </summary>
    function AsDouble: double;

    ///  <summary>
    ///    Returns the string as an extended-precision floating point.
    ///  </summary>
    function AsExtended: extended;

    ///  <summary>
    ///    Get or Set this string as an ansi string, for compatibility with
    ///    older API's.
    ///  </summary>
    property AsAnsiString: ansistring read getAsAnsiString write setAsAnsiString;
  end;
{$endregion}
{$region ' Helper for ansistring'}
type
  TAnsiStringHelper = record helper for ansistring
    ///  <summary>
    ///    Returns the ansi string as a regular string for interation with
    ///    ansi API's.
    ///    Getter for AsString property.
    ///  </summary>
    function getAsString: string;

    ///  <summary>
    ///    Returns the ansi string as a regular string for interation with
    ///    ansi API's.
    ///  </summary>
    property AsString: string read getAsString;
  end;
{$endregion}
{$region ' Helper for char'}
  TCharHelper = record helper for char
  public

    ///  <summary>
    ///    Returns true if the ch char can be found in the char array.
    ///  </summary>
    function CharInArray( const Characters: array of char ): boolean;
  end;
{$endregion}
{$region ' Helper for nativeuint'}
  TNativeUIntHelper = record helper for nativeuint
  public

    ///  <summary>
    ///    Returns the nativeuint as a string.
    ///  </summary>
    function AsString: string;

    ///  <summary>
    ///    Casts the nativeuint as a pointer
    ///  </summary>
    function AsPointer: pointer;
  end;
{$endregion}
{$region ' Helper for pointer'}
  TPointerHelper = record helper for pointer
    ///  <summary>
    ///    Casts the pointer as a native uint
    ///  </summary>
    function AsNativeUint: nativeuint;

    ///  <summary>
    ///    Returns the length of a zero-terminated ansi string at the
    ///    pointer.
    ///  </summary>
    function PCharLen: nativeuint;
  end;
{$endregion}
{$region ' Helper for boolean'}
  TBooleanHelper = record helper for boolean
  private
    function getAsString: string;
    procedure setAsString(const Value: string);
  public

    property AsString: string read getAsString write setAsString;
  end;
{$endregion}
{$region ' Helper for uint8'}
  TUInt8Helper = record helper for uint8
  public

    ///  <summary>
    ///    Returns the uint8 as a string
    ///  </summary>
    function AsString: string;

    ///  <summary>
    ///    Returns the uint8 as a string of hex characters.
    ///  </summary>
    function AsHex( const Width: uint8 = 2 ): string;
  end;
{$endregion}
{$region ' Helper for uint16'}
  TUInt16Helper = record helper for uint16
  public

    ///  <summary>
    ///    Returns the uint16 as a string
    ///  </summary>
    function AsString: string;

    ///  <summary>
    ///    Returns the uint16 as a string of hex characters.
    ///  </summary>
    function AsHex( const Width: uint8 = 4 ): string;
  end;
{$endregion}
{$region ' Helper for uint32'}
  TUInt32Helper = record helper for uint32
  public

    ///  <summary>
    ///    Returns the uint32 as a string
    ///  </summary>
    function AsString: string;

    ///  <summary>
    ///    Returns the uint32 as a string of hex characters.
    ///  </summary>
    function AsHex( const Width: uint8 = 8 ): string;
  end;
{$endregion}
{$region ' Helper for uint64'}
  TUInt64Helper = record helper for uint64
  public

    ///  <summary>
    ///    Returns the int64 as a string
    ///  </summary>
    function AsString: string;

    ///  <summary>
    ///    Returns the int64 as a string of hex characters.
    ///  </summary>
    function AsHex( const Width: uint8 = 16 ): string;
  end;
{$endregion}
{$region ' Helper for int8'}
  TInt8Helper = record helper for int8
  public

    ///  <summary>
    ///    Returns the int8 as a string.
    ///  </summary>
    function AsString: string;

    ///  <summary>
    ///    Returns the int8 as a string of hex characters
    ///  </summary>
    function AsHex( const Width: uint8 = 2 ): string;
  end;
{$endregion}
{$region ' Helper for int16'}
  TInt16Helper = record helper for int16
  public

    ///  <summary>
    ///    Returns the int16 as a string.
    ///  </summary>
    function AsString: string;

    ///  <summary>
    ///    Returns the int16 as a string of hex characters
    ///  </summary>
    function AsHex( const Width: uint8 = 2 ): string;
  end;
{$endregion}
{$region ' Helper for int32'}
  TInt32Helper = record helper for int32
  public

    ///  <summary>
    ///    Returns the int32 as a string.
    ///  </summary>
    function AsString: string;

    ///  <summary>
    ///    Returns the int32 as a string of hex characters
    ///  </summary>
    function AsHex( const Width: uint8 = 8 ): string;
  end;
{$endregion}
{$region ' Helper for int64'}
  TInt64Helper = record helper for int64
  public

    ///  <summary>
    ///    Returns the int64 as a string.
    ///  </summary>
    function AsString: string;

    ///  <summary>
    ///    Returns the int64 as a string of hex characters.
    ///  </summary>
    function AsHex( const Width: uint8 = 16 ): string;
  end;
{$endregion}
{$region ' Helper for single'}
  TSingleHelper = record helper for single
  public

    ///  <summary>
    ///    Returns true if this single is equal to Value using
    ///    Precision as a margin for error both above and below
    ///    the value.
    ///  </summary>
    function Approximates( const Value: single; const Precision: single = 0.01 ): boolean;

    ///  <summary>
    ///    Returns the float as a string.
    ///  </summary>
    function AsString: string;
  end;
{$endregion}
{$region ' Helper for double'}
  TDoubleHelper = record helper for double
  public

    ///  <summary>
    ///    Returns true if this double is equal to Value using
    ///    Precision as a margin for error both above and below
    ///    the value.
    ///  </summary>
    function Approximates( const Value: double; const Precision: double = 0.01 ): boolean;

    ///  <summary>
    ///    Returns the float as a string.
    ///  </summary>
    function AsString: string;
  end;
{$endregion}
{$region ' Helper for extended'}
  TExtendedHelper = record helper for extended
  public

    ///  <summary>
    ///    Returns true if this extended is equal to Value using
    ///    Precision as a margin for error both above and below
    ///    the value.
    ///  </summary>
    function Approximates( const Value: extended; const Precision: extended = 0.01 ): boolean;

    ///  <summary>
    ///    Returns the float as a string.
    ///  </summary>
    function AsString: string;
  end;
{$endregion}
{$region ' Helper for datetime'}
  TDateTimeHelper = record helper for TDateTime
  public
    ///  <summary>
    ///    Sets the date and time using parameterized year, month, day, hour,
    ///    minute, second and millisecond values.
    ///  </summary>
    procedure Encode( const Year: uint16; const Month: uint8; const Day: uint16; const Hour: uint8; const Minute: uint8; const Second: uint8; const Millisecond: uint8 );

    ///  <summary>
    ///    Returns the date time as a string using the format
    ///    string provided to format the date-time.
    ///    See FormatDateTime() for format string options.
    ///  </summary>
    function AsString(const Format: string = 'YYYY-MM-DD HH:mm:SS'): string;
  end;
{$endregion}
{$region ' Helper for TArrayOfString'}
  TArrayOfStringHelper = record helper for TArrayOfString
  public
    procedure AssignArray(const value: array of string );
    function Find( const value: string; out FoundIdx: nativeuint; const CaseInsensitive: boolean = False ): boolean;
    function RemoveDuplicates( const CaseInsensitive: boolean = false ): TArrayOfString;
    procedure Remove( const item: string; const CaseInsensitive: boolean = false );
  end;
{$endregion}
{$region ' Half Type'}
type
  half = record
    value: word;
    class operator Implicit(const a: single): half;
    class operator Implicit(const a: half): single;
    class operator Implicit(const a: double): half;
    class operator Implicit(const a: half): double;
    {$if defined(LINUX) and defined(FPC)}
    class operator Implicit(const a: extended): half;
    class operator Implicit(const a: half): extended;
    {$endif}
    {$ifndef CPU64BITS}
    class operator Explicit(const a: single): half;
    class operator Explicit(const a: half): single;
    class operator Explicit(const a: double): half;
    class operator Explicit(const a: half): double;
    {$endif}
    class operator Add(const a, b: half): half;
    class operator Subtract(const a, b: half): half;
    class operator Multiply(const a, b: half): half;
    class operator Divide(const a, b: half): half;
    class operator GreaterThan(const a: half; const b: half): boolean;
    class operator GreaterThan(const a: half; const b: single): boolean;
    class operator GreaterThan(const a: half; const b: double): boolean;
    {$ifndef CPU64BITS}
    class operator GreaterThan(const a: half; const b: extended): boolean;
    {$endif}
    class operator GreaterThan(const a: single; const b: half): boolean;
    class operator GreaterThan(const a: double; const b: half): boolean;
    {$ifndef CPU64BITS}
    class operator GreaterThan(const a: extended; const b: half): boolean;
    {$endif}
    class operator LessThan(const a: half; const b: half): boolean;
    class operator LessThan(const a: half; const b: single): boolean;
    class operator LessThan(const a: half; const b: double): boolean;
    {$ifndef CPU64BITS}
    class operator LessThan(const a: half; const b: extended): boolean;
    {$endif}
    class operator LessThan(const a: single; const b: half): boolean;
    class operator LessThan(const a: double; const b: half): boolean;
    {$ifndef CPU64BITS}
    class operator LessThan(const a: extended; const b: half): boolean;
    {$endif}

  end;

const
  HalfMin:     Single = 5.96046448e-08; // Smallest positive half
  HalfMinNorm: Single = 6.10351562e-05; // Smallest positive normalized half
  HalfMax:     Single = 65504.0;        // Largest positive half
  // Smallest positive e for which half (1.0 + e) != half (1.0)
  HalfEpsilon: Single = 0.00097656;
  HalfNaN:     half = ( value: 65535 );
  HalfPosInf:  half = ( value: 31744 );
  HalfNegInf:  half = ( value: 64512 );
{$endregion}

implementation
uses
  cwUnicode
, cwUnicode.standard
, strutils
, dateutils
;

{$region ' Implementation of TBooleanHelper'}

function TBooleanHelper.getAsString: string;
begin
   if Self then begin
     Result := 'TRUE';
   end else begin
     Result := 'FALSE';
   end;
end;

procedure TBooleanHelper.setAsString(const Value: string);
begin
   if uppercase(trim(value))='TRUE' then begin
     Self := True;
   end else begin
     Self := False;
   end;
end;

{$endregion}
{$region ' Implementation of TStringHelper'}
function TStringHelper.AsBoolean(const CaseSensitive: boolean; const positive: string): boolean;
begin
  if CaseSensitive then begin
    Result := self = positive;
  end else begin
    Result := self.Uppercase = positive.Uppercase;
  end;
end;

function TStringHelper.AsDouble: double;
begin
  {$ifndef fpc}
  Result := SysUtils.StrToFloat(Self);
  {$else}
  Result := SysUtils.StrToFloat(UTF8Encode(Self));
  {$endif}
end;

function TStringHelper.AsExtended: extended;
begin
  {$ifndef fpc}
  Result := SysUtils.StrToFloat(Self);
  {$else}
  Result := SysUtils.StrToFloat(UTF8Encode(Self));
  {$endif}
end;

function TStringHelper.AsInt16: int16;
begin
  {$ifndef fpc}
  Result := SysUtils.StrToInt(Self);
  {$else}
  Result := SysUtils.StrToInt(UTF8Encode(Self));
  {$endif}
end;

function TStringHelper.AsInt32: int32;
begin
  {$ifndef fpc}
  Result := SysUtils.StrToInt(Self);
  {$else}
  Result := SysUtils.StrToInt(UTF8Encode(Self));
  {$endif}
end;

function TStringHelper.AsInt64: int64;
begin
  {$ifndef fpc}
  Result := SysUtils.StrToInt(Self);
  {$else}
  Result := SysUtils.StrToInt(UTF8Encode(Self));
  {$endif}
end;

function TStringHelper.AsInt8: int8;
begin
  {$ifndef fpc}
  Result := SysUtils.StrToInt(Self);;
  {$else}
  Result := SysUtils.StrToInt(UTF8Encode(Self));
  {$endif}
end;

function TStringHelper.AsSingle: single;
begin
  {$ifndef fpc}
  Result := SysUtils.StrToFloat(Self);
  {$else}
  Result := SysUtils.StrToFloat(UTF8Encode(Self));
  {$endif}
end;

function TStringHelper.AsUInt16: uint16;
var
  D: uint32;
begin
  {$ifndef fpc}
  D := SysUtils.StrToUInt(Self);
  Result := D;
  {$else}
  D := SysUtils.StrToDWord(UTF8Encode(Self));
  Result := D;
  {$endif}
end;

function TStringHelper.AsUint32: uint32;
begin
  {$ifndef fpc}
  Result := SysUtils.StrToUInt(Self);
  {$else}
  Result := SysUtils.StrToDWord(UTF8Encode(Self));
  {$endif}
end;

function TStringHelper.AsUint64: uint64;
begin
  {$ifndef fpc}
  Result := SysUtils.StrToUInt(Self);
  {$else}
  Result := SysUtils.StrToQWord(UTF8Encode(Self));
  {$endif}
end;

function TStringHelper.AsUInt8: uint8;
var
  D: uint32;
begin
  {$ifndef fpc}
  D := SysUtils.StrToUInt(Self);
  Result := D;
  {$else}
  D := SysUtils.StrToDWord(UTF8Encode(Self));
  Result := D;
  {$endif}
end;

function TStringHelper.Combine(const cDelimiter: string; const Parts: TArrayOfString; const StartIdx: uint32 = 0): string;
var
  idx: uint32;
  Len: uint32;
begin
  Self := '';
  Result := '';
  Len := Length(Parts);
  if Len=0 then begin
    Exit;
  end;
  if StartIdx>pred(Len) then begin
    Exit;
  end;
  for idx := StartIdx to pred(Len) do begin
    Self := Self + Parts[idx];
    if idx<pred(Len) then begin
      Self := Self + cDelimiter;
    end;
  end;
  Result := Self;
end;

function TStringHelper.Explode(const cDelimiter: string; const iCount : uint32 = 0 ): TArrayOfString;
var
  s: string;
  i,p: uint32;
begin
  s:= Self;
  i:= 0;
  while length(s) > 0 do begin
    inc(i);
    {$warnings off} SetLength(Result, i); {$warnings on} // warning that result is not initialized.
    p := s.Pos(cDelimiter);
    if (p>0) and ((i<iCount) OR (iCount = 0)) then begin
      result[pred(i)]:=copy(s,0,p-1);
      {$warnings off}s:=copy(s,p + length(cDelimiter),length(s));{$warnings on} //- Delphi warns about combining signed and unsigned types.
    end else begin
      result[pred(i)]:= s;
      s:='';
    end;
  end;
end;

function TStringHelper.getAsAnsiString: ansiString;
var
  Cursor: int32;
  Stop: int32;
  CP: TUnicodeCodepoint;
  B: uint8;
  S: uint8;
begin
  Result := '';
  if Length(Self)=0 then begin
    exit;
  end;
  Cursor := 1;
  Stop := succ(Length(Self));
  {$ifdef NEXTGEN}
  Cursor := 0;
  Stop := Length(Self));
  {$endif}
  CP := 0;
  S := 0;
  B := 0;
  while (Cursor<Stop) do begin
    if not Unicode.DecodeCodepointFromString(CP,Self,Cursor) then begin
      exit;
    end;
    if not Unicode.AnsiEncode(CP,B,S) then begin
      exit;
    end;
    Result := Result + ansichar(B);
  end;
end;

function TStringHelper.LeftPad( const CharCount: nativeuint; const ch: char ): string;
begin
  Result := Self;
  if CharCount<=Length(Result) then begin
    exit;
  end;
  while Length(Result)<CharCount do begin
    Result := ch + Result;
  end;
end;

function TStringHelper.LeftStr(const ACount: int32): string;
begin
  Result := strutils.leftstr(Self,aCount);
end;

function TStringHelper.Len: nativeuint;
begin
  REsult := Length(Self);
end;

function TStringHelper.Lowercase: string;
begin
  Result := SysUtils.LowerCase(Self);
end;

function TStringHelper.LowercaseTrim: string;
begin
  Result := Self.Lowercase.Trim;
end;

function TStringHelper.MidStr(const AStart, ACount: uint32): string;
var
  charPos: uint32;
  L: uint32;
begin
  Result := '';
  L := Length(Self);
  if L<AStart+ACount then begin
    exit;
  end;
  CharPos := AStart;
  while CharPos<(AStart+ACount) do begin
    Result := Result + Self[CharPos];
    inc(CharPos);
  end;
end;

function TStringHelper.Padleft(const Padding: uint32; const PaddingChar: char): string;
var
  StrPadding: string;
  idx: uint32;
begin
  if Padding=0 then begin
    Result := Self;
    Exit;
  end;
  StrPadding := '';
  for idx := 0 to pred(Padding) do begin
    StrPadding := StrPadding + PaddingChar;
  end;
  Result := StrPadding + Self;
end;

function TStringHelper.PadRight(const Padding: uint32; const PaddingChar: char): string;
var
  StrPadding: string;
  idx: uint32;
begin
  if Padding=0 then begin
    Result := Self;
    Exit;
  end;
  StrPadding := '';
  for idx := 0 to pred(Padding) do begin
    StrPadding := StrPadding + PaddingChar;
  end;
  Result := Self + StrPadding;
end;

function TStringHelper.Pos(const SubStr: string): int32;
begin
  Result := strutils.PosEx(Substr,Self);
end;

function TStringHelper.RightPad( const CharCount: nativeuint; const ch: char ): string;
begin
  Result := Self;
  if CharCount<=Length(Result) then begin
    exit;
  end;
  while Length(Result)<CharCount do begin
    Result := Result + ch;
  end;
end;


function TStringHelper.RightStr(const ACount: int32): string;
begin
  Result := strutils.RightStr(Self,ACount);
end;

procedure TStringHelper.setAsAnsiString(const value: ansistring);
var
  idx: uint32;
  CP: TUnicodeCodepoint;
  B: uint8;
  L: uint32;
begin
  Self := '';
  L := Length(Value);
  if L=0 then begin
    exit;
  end;
  CP := 0;
  for idx := 1 to L do begin
    B := ord(value[idx]);
    if not Unicode.AnsiDecode(B,CP) then begin
      exit;
    end;
    if not Unicode.EncodeCodepointToString(CP,Self) then begin
      exit;
    end;
  end;
end;

procedure TStringHelper.SetAsPChar(const value: pointer);
var
  p: ^byte;
  slen: uint64;
  CP: TUnicodeCodePoint;
begin
  if Value=nil then begin
    Self := '';
    exit;
  end;
  CP := 0;
  p := Value;
  slen := 0;
  while (slen<65535) and (p^<>0) do begin
    Unicode.AnsiDecode(p^,CP);
    Unicode.EncodeCodepointToString(CP,Self);
    inc(p);
    inc(slen);
  end;
end;

function TStringHelper.StringReplace(const OldPattern, NewPattern: string; const ReplaceAll: boolean = false; const IgnoreCase: boolean = false): string;
var
  Flags: TReplaceFlags;
begin
  Flags := [];
  if ReplaceAll then begin
    Flags := Flags + [rfReplaceAll];
  end;
  if IgnoreCase then begin
    Flags := Flags + [rfIgnoreCase];
  end;
  {$ifndef fpc}
  Result := sysutils.StringReplace(Self,OldPattern,NewPattern,Flags);
  {$else}
  Result := UTF8Decode(sysutils.StringReplace(UTF8Encode(Self),UTF8Encode(OldPattern),UTF8Encode(NewPattern),Flags));
  {$endif}
end;

function TStringHelper.Trim: string;
begin
  Result := SysUtils.Trim(Self);
end;

function TStringHelper.Uppercase: string;
begin
  Result := SysUtils.UpperCase(Self);
end;

function TStringHelper.UppercaseTrim: string;
begin
  Result := Self.Uppercase.Trim;
end;
{$endregion}
{$region ' Implementation of TAnsiStringHelper'}

function TAnsiStringHelper.getAsString: string;
begin
  Result := '';
  Result.AsAnsiString := Self;
end;

{$endregion}
{$region ' Implementation of TCharArrayHelper'}

function TCharHelper.CharInArray( const Characters: array of char ): boolean;
var
  idx: uint32;
begin
  Result := False;
  if Length(Characters)=0 then begin
    exit;
  end;
  for idx := 0 to pred(length(Characters)) do begin
    if self = Characters[idx] then begin
      Result := True;
      Exit;
    end;
  end;
end;

{$endregion}
{$region ' Implementation of TNativeUIntHelper'}

function TNativeUIntHelper.AsPointer: pointer;
begin
  {$hints off} Result := pointer(self); {$hints on} // FPC Compiler warns that conversion between pointers and ordinals is not portable, but this is intentional.
end;

function TNativeUIntHelper.AsString: string;
begin
  {$ifndef fpc}
  Result := UIntToStr(Self);
  {$else}
  Result := UTF8Decode(IntToStr(Self));
  {$endif}
end;


{$endregion}
{$region ' Implementation of TPointerHelper'}

function TPointerHelper.PCharLen: nativeuint;
var
  src: ^uint8;
begin
  src := Self;
  Result := 0;
  while src^<>0 do begin
    inc(Result);
    inc(src);
  end;
end;

function TPointerHelper.AsNativeUint: nativeuint;
begin
  {$hints off} Result := nativeuint(self); {$hints on} //- FPC Compiler warns that conversion between pointers and ordinals is not portable, but this is intentional.
end;

{$endregion}
{$region ' Implementation of TUInt32Helper'}

function TUInt32Helper.AsHex( const Width: uint8 = 8 ): string;
begin
  {$ifndef fpc}
  Result := sysutils.IntToHex(Self,width);
  {$else}
  Result := UTF8Decode(sysutils.IntToHex(Self,width));
  {$endif}
end;

function TUInt32Helper.AsString: string;
{$ifdef fpc}
var
  Q: QWord;
{$endif}
begin
  {$ifndef fpc}
  Result := UIntToStr(Self);
  {$else}
  Q := Self;
  Result := UTF8Decode(Sysutils.IntToStr(Q));
  {$endif}
end;

{$endregion}
{$region ' Implementation of TUInt64Helper'}

function TUInt64Helper.AsHex(const Width: uint8): string;
begin
  {$ifndef fpc}
  Result := sysutils.IntToHex(Self,width);
  {$else}
  Result := UTF8Decode(sysutils.IntToHex(Self,width));
  {$endif}
end;

function TUInt64Helper.AsString: string;
{$ifdef fpc}
var
  Q: QWord;
{$endif}
begin
  {$ifndef fpc}
  Result := UIntToStr(Self);
  {$else}
  Q := Self;
  Result := UTF8Decode(IntToStr(Q));
  {$endif}
end;

{$endregion}
{$region ' Implementation of TInt32Helper'}

function TInt32Helper.AsHex(const Width: uint8): string;
begin
  {$ifndef fpc}
  Result := sysutils.IntToHex(Self,width);
  {$else}
  Result := UTF8Decode(sysutils.IntToHex(Self,width));
  {$endif}
end;


function TInt32Helper.AsString: string;
begin
  {$ifdef fpc}
  Result := UTF8Decode(IntToStr(Self));
  {$else}
  {$warnings off} Result := UTF8ToWideString(IntToStr(Self)); {$warnings on}
  {$endif}
end;

{$endregion}
{$region ' Implementation of TInt64Helper'}

function TInt64Helper.AsHex(const Width: uint8): string;
begin
  {$ifndef fpc}
  Result := sysutils.IntToHex(Self,width);
  {$else}
  Result := UTF8Decode(sysutils.IntToHex(Self,width));
  {$endif}
end;


function TInt64Helper.AsString: string;
begin
  {$ifdef fpc}
  Result := UTF8Decode(IntToStr(Self));
  {$else}
  {$warnings off} Result := UTF8ToWideString(IntToStr(Self)); {$warnings on}
  {$endif}
end;

{$endregion}
{$region ' Implementation of TSingleHelper'}

function TSingleHelper.Approximates(const Value, Precision: single): boolean;
begin
  Result := (Self>(Value-Precision)) and (Self<(Value+Precision));
end;

function TSingleHelper.AsString: string;
begin
  {$ifdef fpc}
  Result := UTF8Decode(FloatToStr(Self));
  {$else}
  {$warnings off} Result := UTF8ToString(FloatToStr(Self)); {$warnings on}
  {$endif}
end;

{$endregion}
{$region ' Implementation of TDoubleHelper'}

function TDoubleHelper.Approximates(const Value, Precision: double): boolean;
begin
  Result := (Self>(Value-Precision)) and (Self<(Value+Precision));
end;

function TDoubleHelper.AsString: string;
begin
  {$ifdef fpc}
  Result := UTF8Decode(FloatToStr(Self));
  {$else}
  {$warnings off} Result := UTF8ToString(FloatToStr(Self)); {$warnings on}
  {$endif}
end;

{$endregion}
{$region ' Implementation of TExtendedHelper'}

function TExtendedHelper.Approximates(const Value, Precision: extended): boolean;
begin
  Result := (Self>(Value-Precision)) and (Self<(Value+Precision));
end;

function TExtendedHelper.AsString: string;
begin
  {$ifdef fpc}
  Result := UTF8Decode(FloatToStr(Self));
  {$else}
  {$warnings off} Result := UTF8Tostring(FloatToStr(Self)); {$warnings on}
  {$endif}
end;

{$endregion}
{$region ' Implementation of TDateTimeHelper'}

procedure TDateTimeHelper.Encode(const Year: uint16; const Month: uint8; const Day: uint16; const Hour, Minute, Second, Millisecond: uint8);
begin
  Self := EncodeDateTime( Year, Month, Day, Hour, Minute, Second, Millisecond );
end;

function TDateTimeHelper.AsString(const Format: string): string;
begin
  {$ifndef fpc}
  Result := sysutils.FormatDateTime(Format,Self);
  {$else}
  Result := UTF8Decode(sysutils.FormatDateTime(UTF8Encode(Format),Self));
  {$endif}
end;

{$endregion}
{$region ' Implementation of TUInt8Helper' }

function TUInt8Helper.AsHex(const Width: uint8): string;
begin
  {$ifndef fpc}
  Result := sysutils.IntToHex(Self,width);
  {$else}
  Result := UTF8Decode(sysutils.IntToHex(Self,width));
  {$endif}
end;

function TUInt8Helper.AsString: string;
{$ifdef fpc}
var
  Q: QWord;
{$endif}
begin
  {$ifndef fpc}
  Result := UIntToStr(Self);
  {$else}
  Q := Self;
  Result := UTF8Decode(IntToStr(Q));
  {$endif}
end;

{$endregion}
{$region ' Implementation of TUint16Helper'}

function TUInt16Helper.AsHex(const Width: uint8): string;
begin
  {$ifndef fpc}
  Result := sysutils.IntToHex(Self,width);
  {$else}
  Result := UTF8Decode(sysutils.IntToHex(Self,width));
  {$endif}
end;

function TUInt16Helper.AsString: string;
{$ifdef fpc}
var
  Q: QWORD;
{$endif}
begin
  {$ifndef fpc}
  Result := UIntToStr(Self);
  {$else}
  Q := Self;
  Result := UTF8Decode(IntToStr(Q));
  {$endif}
end;

{$endregion}
{$region ' Implementation of TInt8Helper'}

function TInt8Helper.AsHex(const Width: uint8): string;
begin
  {$ifndef fpc}
  Result := sysutils.IntToHex(Self,width);
  {$else}
  Result := UTF8Decode(sysutils.IntToHex(Self,width));
  {$endif}
end;

function TInt8Helper.AsString: string;
begin
  {$ifdef fpc}
  Result := UTF8Decode(IntToStr(Self));
  {$else}
  {$warnings off} Result := UTF8ToString(IntToStr(Self)); {$warnings on}
  {$endif}
end;

{$endregion}
{$region ' Implementation of TInt8Helper'}

function TInt16Helper.AsHex(const Width: uint8): string;
begin
  {$ifndef fpc}
  Result := sysutils.IntToHex(Self,width);
  {$else}
  Result := UTF8Decode(sysutils.IntToHex(Self,width));
  {$endif}
end;

function TInt16Helper.AsString: string;
begin
  {$ifdef fpc}
  Result := UTF8Decode(IntToStr(Self));
  {$else}
  {$warnings off} Result := UTF8Decode(IntToStr(Self)); {$warnings on}
  {$endif}
end;

{$endregion}
{$region ' Helper for TArrayOfString'}

procedure TArrayOfStringHelper.AssignArray(const value: array of string );
var
  idx: nativeuint;
begin
  SetLength(Self,Length(Value));
  if Length(Self)=0 then begin
    exit;
  end;
  for idx := 0 to pred(Length(Self)) do begin
    Self[idx] := Value[idx];
  end;
end;

function TArrayOfStringHelper.Find(const value: string; out FoundIdx: nativeuint; const CaseInsensitive: boolean): boolean;
var
  idx: nativeuint;
  SearchStr: string;
begin
  Result := False;
  if Length(Self)=0 then begin
    exit;
  end;
  SearchStr := value;
  if CaseInsensitive then begin
    SearchStr := Uppercase(SearchStr);
  end;
  for idx := 0 to pred(Length(self)) do begin
    if CaseInsensitive then begin
      if Uppercase(Self[idx])=SearchStr then begin
        Result := True;
        FoundIdx := Idx;
        exit;
      end;
    end else begin
      if Self[idx]=SearchStr then begin
        Result := True;
        FoundIdx := Idx;
        exit;
      end;
    end;
  end;
end;

function TArrayOfStringHelper.RemoveDuplicates( const CaseInsensitive: boolean = false ): TArrayOfString;
var
  idx: nativeuint;
  Counter: nativeuint;
  FoundIdx: nativeuint;
  InterMediate: TArrayOfString;
begin
  if Length(Self)=0 then begin
    {$warnings off}
    SetLength(Result,Length(Self));
    {$warnings on}
    exit;
  end;
  {$hints off}
  SetLength(InterMediate,Length(Self));
  {$hints on}
  try
    Counter := 0;
    for idx := 0 to pred(Length(Self)) do begin
      if not Intermediate.Find(Self[idx],FoundIdx,CaseInsensitive) then begin
        Intermediate[counter] := Self[idx];
        inc(Counter);
      end;
    end;
    SetLength(Result,Counter);
    if Counter>0 then begin
      for idx := 0 to pred(Counter) do begin
        Result[idx] := Intermediate[idx];
      end;
    end;
  finally
    SetLength(Intermediate,0);
  end;
end;

procedure TArrayOfStringHelper.Remove(const item: string; const CaseInsensitive: boolean);
var
  idx: nativeuint;
  Counter: nativeuint;
  InterMediate: TArrayOfString;
  utItem: string;
begin
  if Length(Self)=0 then begin
    exit;
  end;
  utItem := item.Uppercase;
  {$hints off}
  SetLength(InterMediate,Length(Self));
  {$hints on}
  try
    Counter := 0;
    for idx := 0 to pred(Length(Self)) do begin
      if not ((Self[idx]=item) or ((CaseInsensitive) and (self[idx].Uppercase=utItem))) then begin
        Intermediate[counter] := Self[idx];
        inc(Counter);
      end;
    end;
    SetLength(Self,Counter);
    if Counter>0 then begin
      for idx := 0 to pred(Counter) do begin
        Self[idx] := Intermediate[idx];
      end;
    end;
  finally
    SetLength(Intermediate,0);
  end;
end;
{$endregion}
{$region ' Implementation of Half Type'}

function FloatToHalf(Float: Single): word;
var
  Src: LongWord;
  Sign, Exp, Mantissa: LongInt;
begin
  Src := PLongWord(@Float)^;
  // Extract sign, exponent, and mantissa from Single number
  Sign := Src shr 31;
  Exp := LongInt((Src and $7F800000) shr 23) - 127 + 15;
  Mantissa := Src and $007FFFFF;

  if (Exp > 0) and (Exp < 30) then
  begin
    // Simple case - round the significand and combine it with the sign and exponent
    Result := (Sign shl 15) or (Exp shl 10) or ((Mantissa + $00001000) shr 13);
  end
  else if Src = 0 then
  begin
    // Input float is zero - return zero
    Result := 0;
  end
  else
  begin
    // Difficult case - lengthy conversion
    if Exp <= 0 then
    begin
      if Exp < -10 then
      begin
        // Input float's value is less than HalfMin, return zero
         Result := 0;
      end
      else
      begin
        // Float is a normalized Single whose magnitude is less than HalfNormMin.
        // We convert it to denormalized half.
        Mantissa := (Mantissa or $00800000) shr (1 - Exp);
        // Round to nearest
        if (Mantissa and $00001000) > 0 then
          Mantissa := Mantissa + $00002000;
        // Assemble Sign and Mantissa (Exp is zero to get denormalized number)
        Result := (Sign shl 15) or (Mantissa shr 13);
      end;
    end
    else if Exp = 255 - 127 + 15 then
    begin
      if Mantissa = 0 then
      begin
        // Input float is infinity, create infinity half with original sign
        Result := (Sign shl 15) or $7C00;
      end
      else
      begin
        // Input float is NaN, create half NaN with original sign and mantissa
        Result := (Sign shl 15) or $7C00 or (Mantissa shr 13);
      end;
    end
    else
    begin
      // Exp is > 0 so input float is normalized Single

      // Round to nearest
      if (Mantissa and $00001000) > 0 then
      begin
        Mantissa := Mantissa + $00002000;
        if (Mantissa and $00800000) > 0 then
        begin
          Mantissa := 0;
          Exp := Exp + 1;
        end;
      end;

      if Exp > 30 then
      begin
        // Exponent overflow - return infinity half
        Result := (Sign shl 15) or $7C00;
      end
      else
        // Assemble normalized half
        Result := (Sign shl 15) or (Exp shl 10) or (Mantissa shr 13);
    end;
  end;
end;

function HalfToFloat(Half: word): Single;
var
  Dst, Sign, Mantissa: LongWord;
  Exp: LongInt;
begin
  // Extract sign, exponent, and mantissa from half number
  Sign := Half shr 15;
  Exp := (Half and $7C00) shr 10;
  Mantissa := Half and 1023;

  if (Exp > 0) and (Exp < 31) then
  begin
    // Common normalized number
    Exp := Exp + (127 - 15);
    Mantissa := Mantissa shl 13;
    Dst := (Sign shl 31) or (LongWord(Exp) shl 23) or Mantissa;
    // Result := Power(-1, Sign) * Power(2, Exp - 15) * (1 + Mantissa / 1024);
  end
  else if (Exp = 0) and (Mantissa = 0) then
  begin
    // Zero - preserve sign
    Dst := Sign shl 31;
  end
  else if (Exp = 0) and (Mantissa <> 0) then
  begin
    // Denormalized number - renormalize it
    while (Mantissa and $00000400) = 0 do
    begin
      Mantissa := Mantissa shl 1;
      Dec(Exp);
    end;
    Inc(Exp);
    Mantissa := Mantissa and not $00000400;
    // Now assemble normalized number
    Exp := Exp + (127 - 15);
    Mantissa := Mantissa shl 13;
    Dst := (Sign shl 31) or (LongWord(Exp) shl 23) or Mantissa;
    // Result := Power(-1, Sign) * Power(2, -14) * (Mantissa / 1024);
  end
  else if (Exp = 31) and (Mantissa = 0) then
  begin
    // +/- infinity
    Dst := (Sign shl 31) or $7F800000;
  end
  else //if (Exp = 31) and (Mantisa <> 0) then
  begin
    // Not a number - preserve sign and mantissa
    Dst := (Sign shl 31) or $7F800000 or (Mantissa shl 13);
  end;

  // Reinterpret LongWord as Single
  Result := PSingle(@Dst)^;
end;

{$ifndef CPU64BITS}
class operator half.Explicit(const a: single): half;
begin
  Result.Value := FloatToHalf(a);
end;
{$endif}

class operator half.GreaterThan(const a: double; const b: half): boolean;
var
  sB: single;
begin
  sB := b;
  Result := a>sB;
end;

{$ifndef CPU64BITS}
class operator half.GreaterThan(const a: extended; const b: half): boolean;
var
  sB: single;
begin
  sB := b;
  Result := a>sB;
end;
{$endif}

class operator half.GreaterThan(const a: half; const b: double): boolean;
var
  sA: single;
begin
  sA := a;
  Result := sA>b;
end;

{$ifndef CPU64BITS}
class operator half.GreaterThan(const a: half; const b: extended): boolean;
var
  sA: single;
begin
  sA := a;
  Result := sA>b;
end;
{$endif}

class operator half.GreaterThan(const a: half; const b: half): boolean;
var
  sA: single;
  sB: single;
begin
  sA := a;
  sB := b;
  Result := sA>sB;
end;

class operator half.GreaterThan(const a: half; const b: single): boolean;
var
  sA: single;
begin
  sA := a;
  Result := sA>b;
end;

class operator half.GreaterThan(const a: single; const b: half): boolean;
var
  sB: single;
begin
  sB := b;
  Result := a>sB;
end;

class operator half.LessThan(const a: double; const b: half): boolean;
var
  sB: single;
begin
  sB := b;
  Result := a<sB;
end;


{$ifndef CPU64BITS}
class operator half.LessThan(const a: extended; const b: half): boolean;
var
  sB: single;
begin
  sB := b;
  Result := a<sB;
end;
{$endif}

class operator half.LessThan(const a: half; const b: double): boolean;
var
  sA: single;
begin
  sA := a;
  Result := sA<b;
end;

{$ifndef CPU64BITS}
class operator half.LessThan(const a: half; const b: extended): boolean;
var
  sA: single;
begin
  sA := a;
  Result := sA<b;
end;
{$endif}

class operator half.LessThan(const a: half; const b: half): boolean;
var
  sA: single;
  sB: single;
begin
  sA := a;
  sB := b;
  Result := sA<sB;
end;

class operator half.LessThan(const a: half; const b: single): boolean;
var
  sA: single;
begin
  sA := a;
  Result := sA<b;
end;

class operator half.LessThan(const a: single; const b: half): boolean;
var
  sB: single;
begin
  sB := b;
  Result := a<sB;
end;

{$ifndef CPU64BITS}
class operator half.Explicit(const a: half): single;
begin
  Result := HalfToFloat(a.Value);
end;
{$endif}

class operator half.Add(const a, b: half): half;
begin
  Result.value := FloatToHalf( HalfToFloat(a.value) + HalfToFloat(b.value) );
end;

class operator half.Divide(const a, b: half): half;
begin
  Result.value := FloatToHalf( HalfToFloat(a.value) / HalfToFloat(b.value) );
end;

{$ifndef CPU64BITS}
class operator half.Explicit(const a: half): double;
var
  s: single;
begin
  s := HalfToFloat(a.value);
  Result := S;
end;
{$endif}

{$ifndef CPU64BITS}
class operator half.Explicit(const a: double): half;
var
  s: single;
begin
  s := a;
  Result.value := FloatToHalf(s);
end;
{$endif}

class operator half.Implicit(const a: half): single;
begin
  Result := HalfToFloat(a.value);
end;

class operator half.Implicit(const a: single): half;
begin
  Result.value := FloatToHalf(a);
end;

class operator half.Implicit(const a: double): half;
var
  s: single;
begin
  s := a;
  Result.value := FloatToHalf(s);
end;

class operator half.Implicit(const a: half): double;
var
  s: single;
begin
  s := HalfToFloat(a.value);
  Result := s;
end;

{$if defined(LINUX) and defined(FPC)}
class operator half.Implicit(const a: extended): half;
var
  d: double;
begin
  d := a;
  Result.value := FloatToHalf(d);
end;

class operator half.Implicit(const a: half): extended;
var
  d: double;
begin
  d := HalfToFloat(a.value);
  Result := d;
end;
{$endif}

class operator half.Multiply(const a, b: half): half;
begin
  Result.value := FloatToHalf( HalfToFloat(a.value) * HalfToFloat(b.value) );
end;

class operator half.Subtract(const a, b: half): half;
begin
  Result.value := FloatToHalf( HalfToFloat(a.value) - HalfToFloat(b.value) );
end;

{$endregion}

end.
