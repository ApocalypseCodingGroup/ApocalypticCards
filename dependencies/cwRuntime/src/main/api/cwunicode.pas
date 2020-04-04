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
unit cwUnicode;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  sysutils //[RTL] for Exception.
;

type
  /// <summary>
  ///   Specifies a supported unicode text format.
  /// </summary>
  TUnicodeFormat = (

    /// <summary>
    ///   An undetermined text format.
    /// </summary>
    utfUnknown,

    /// <summary>
    ///   Ansi format (UTF-8 compatible)
    /// </summary>
    utfANSI,

    /// <summary>
    ///   UTF-8
    /// </summary>
    utf8,

    /// <summary>
    ///   UTF-16 Little Endian
    /// </summary>
    utf16LE,

    /// <summary>
    ///   UTF-16 Big Endian
    /// </summary>
    utf16BE,

    /// <summary>
    ///   UTF-32 Little Endian
    /// </summary>
    utf32LE,

    /// <summary>
    ///   UTF-32 Big Endian
    /// </summary>
    utf32BE
  );

  /// <summary>
  ///   Canonical representation of a code point, will never exceed 32-bits.
  /// </summary>
  TUnicodeCodePoint = uint32;

  /// <summary>
  ///   An implementation of IUnicodeCodec provides routines for encoding and
  ///   decoding unicode code-points.
  /// </summary>
  IUnicodeCodec = interface
    ['{FDE5359D-9C06-4559-A99A-7D5DA94FEB07}']

    /// <summary>
    ///   Appends a given code-point to the end of the string.
    /// </summary>
    /// <param name="CodePoint">
    ///   The unicode code-point to be appended to the string.
    /// </param>
    /// <param name="Str">
    ///   A string parameter (passed by reference) which will be appended with
    ///   the new unicode code-point.
    /// </param>
    /// <returns>
    ///   Returns true if the operation completed successfully, otherwise
    ///   false. A false return value here is an encoding failure, the
    ///   code-point value may be outside the accepted range.
    /// </returns>
    function EncodeCodepointToString(const CodePoint: TUnicodeCodePoint; var Str: string): boolean;

    /// <summary>
    ///   Decodes a single character from the string as a code-point.
    /// </summary>
    /// <param name="CodePoint">
    ///   A variable passed by reference, to receive the code-point.
    /// </param>
    /// <param name="Source">
    ///   The source string from which to extract a code-point.
    /// </param>
    /// <param name="Cursor">
    ///   The index of the character within the string to decode. For Delphi NextGen
    ///   platforms, this cursor is indexed from zero, but for desktop platforms it remains
    ///   indexed from one.
    /// </param>
    /// <returns>
    ///   Returns true if the code point was decoded, otherwise false. A False
    ///   return is likely to be an out-of-bounds cursor.
    /// </returns>
    function DecodeCodepointFromString(var CodePoint: TUnicodeCodePoint; const Source: string; var Cursor: int32): boolean;

    /// <summary>
    ///   Determines the length (in bytes) of a UTF-8 code-point.
    /// </summary>
    /// <param name="Bytes">
    ///   A buffer containing the character to be measured. (Can be a
    ///   dereferened pointer into a buffer of code points.
    /// </param>
    /// <param name="size">
    ///   An int32 to be populated with the number of bytes.
    /// </param>
    /// <returns>
    ///   Retrns true if the operation was successful. If unsuccessful, the
    ///   character buffer likely contained an invalid code-point.
    /// </returns>
    function UTF8CharacterLength(var Bytes; out size: uint8): boolean;

    /// <summary>
    ///   Determines the length (in bytes) of a UTF-16LE code-point.
    /// </summary>
    /// <param name="Bytes">
    ///   A buffer containing the character to be measured. (Can be a
    ///   dereferened pointer into a buffer of code points.
    /// </param>
    /// <param name="size">
    ///   An int32 to be populated with the number of bytes.
    /// </param>
    /// <returns>
    ///   Retrns true if the operation was successful. If unsuccessful, the
    ///   character buffer likely contained an invalid code-point.
    /// </returns>
    function UTF16LECharacterLength(var Bytes; out size: uint8): boolean;

    /// <summary>
    ///   Determines the length (in bytes) of a UTF-16BE code-point.
    /// </summary>
    /// <param name="Bytes">
    ///   A buffer containing the character to be measured. (Can be a
    ///   dereferened pointer into a buffer of code points.
    /// </param>
    /// <param name="size">
    ///   An int32 to be populated with the number of bytes.
    /// </param>
    /// <returns>
    ///   Retrns true if the operation was successful. If unsuccessful, the
    ///   character buffer likely contained an invalid code-point.
    /// </returns>
    function UTF16BECharacterLength(var Bytes; out size: uint8): boolean;

    /// <summary>
    ///   Decodes a unicode UTF-8 code-point.
    /// </summary>
    /// <param name="Bytes">
    ///   A buffer containing the character to be decoded. (Can be a
    ///   dereferened pointer into a buffer of code points.
    /// </param>
    /// <param name="CodePoint">
    ///   A TUnicodeCodePoint to receive the decoded value.
    /// </param>
    /// <returns>
    ///   Returns true if successful. If unsuccessful, it is likely the
    ///   code-point in the bytes parameter is invalid.
    /// </returns>
    function UTF8Decode(var Bytes; out CodePoint: TUnicodeCodePoint): boolean;

    /// <summary>
    ///   Decodes a unicode UTF-16LE code-point.
    /// </summary>
    /// <param name="Bytes">
    ///   A buffer containing the character to be decoded. (Can be a
    ///   dereferened pointer into a buffer of code points.
    /// </param>
    /// <param name="CodePoint">
    ///   A TUnicodeCodePoint to receive the decoded value.
    /// </param>
    /// <returns>
    ///   Returns true if successful. If unsuccessful, it is likely the
    ///   code-point in the bytes parameter is invalid.
    /// </returns>
    function UTF16LEDecode(var Bytes; out CodePoint: TUnicodeCodePoint ): boolean;

    /// <summary>
    ///   Decodes a unicode UTF-16BE code-point.
    /// </summary>
    /// <param name="Bytes">
    ///   A buffer containing the character to be decoded. (Can be a
    ///   dereferened pointer into a buffer of code points.
    /// </param>
    /// <param name="CodePoint">
    ///   A TUnicodeCodePoint to receive the decoded value.
    /// </param>
    /// <returns>
    ///   Returns true if successful. If unsuccessful, it is likely the
    ///   code-point in the bytes parameter is invalid.
    /// </returns>
    function UTF16BEDecode(var Bytes; out CodePoint: TUnicodeCodePoint): boolean;

    /// <summary>
    ///   Decodes a unicode UTF-32LE code-point.
    /// </summary>
    /// <param name="Bytes">
    ///   A buffer containing the character to be decoded. (Can be a
    ///   dereferened pointer into a buffer of code points.
    /// </param>
    /// <param name="CodePoint">
    ///   A TUnicodeCodePoint to receive the decoded value.
    /// </param>
    /// <returns>
    ///   Returns true if successful. If unsuccessful, it is likely the
    ///   code-point in the bytes parameter is invalid.
    /// </returns>
    /// <remarks>
    ///   For Little Endian targets, this method may be irrelevant as the
    ///   code-point data is not encoded. However, it does provide a consistent
    ///   interface across Little Endian and Big Endian targets.
    /// </remarks>
    function UTF32LEDecode(var Bytes; out CodePoint: TUnicodeCodePoint): boolean;

    /// <summary>
    ///   Decodes a unicode UTF-32BE code-point.
    /// </summary>
    /// <param name="Bytes">
    ///   A buffer containing the character to be decoded. (Can be a
    ///   dereferened pointer into a buffer of code points.
    /// </param>
    /// <param name="CodePoint">
    ///   A TUnicodeCodePoint to receive the decoded value.
    /// </param>
    /// <returns>
    ///   Returns true if successful. If unsuccessful, it is likely the
    ///   code-point in the bytes parameter is invalid.
    /// </returns>
    /// <remarks>
    ///   For Big Endian targets, this method may be irrelevant as the
    ///   code-point data is not encoded. However, it does provide a consistent
    ///   interface across Little Endian and Big Endian targets.
    /// </remarks>
    function UTF32BEDecode(var Bytes; out CodePoint: TUnicodeCodePoint): boolean;

    /// <summary>
    ///   Decodes an ANSI character as a code-point.
    /// </summary>
    /// <param name="Bytes">
    ///   A buffer containing the character to be decoded. (Can be a
    ///   dereferened pointer into a buffer of code points.
    /// </param>
    /// <param name="CodePoint">
    ///   A TUnicodeCodePoint to receive the decoded value.
    /// </param>
    /// <returns>
    ///   Returns true if successful. If unsuccessful, it is likely the
    ///   code-point in the bytes parameter is invalid.
    /// </returns>
    /// <remarks>
    ///   The decoded value is simply a 32-bit representation of the first byte
    ///   passed in the 'byte' paramter.
    /// </remarks>
    function AnsiDecode(var Bytes; out CodePoint: TUnicodeCodePoint): boolean;

    /// <summary>
    ///   Encodes a UTF-8 code-point.
    /// </summary>
    /// <param name="CodePoint">
    ///   The code point to be encoded.
    /// </param>
    /// <param name="Bytes">
    ///   A buffer to store the resulting encoded data into.
    /// </param>
    /// <param name="Size">
    ///   Is populated with the size of the code-point after encoding, in
    ///   bytes.
    /// </param>
    /// <returns>
    ///   Returns true if successful. If unsuccessful, it is likely the
    ///   code-point is not a valid unicode code-point.
    /// </returns>
    function UTF8Encode(const CodePoint: TUnicodeCodePoint; var Bytes; out Size: uint8): boolean;

    /// <summary>
    ///   Encodes a UTF-16LE code-point.
    /// </summary>
    /// <param name="CodePoint">
    ///   The code point to be encoded.
    /// </param>
    /// <param name="Bytes">
    ///   A buffer to store the resulting encoded data into.
    /// </param>
    /// <param name="size">
    ///   Is populated with the size of the code-point after encoding, in
    ///   bytes.
    /// </param>
    /// <returns>
    ///   Returns true if successful. If unsuccessful, it is likely the
    ///   code-point is not a valid unicode code-point.
    /// </returns>
    function UTF16LEEncode(const CodePoint: TUnicodeCodePoint; var Bytes; out size: uint8 ): boolean;

    /// <summary>
    ///   Encodes a UTF-16BE code-point.
    /// </summary>
    /// <param name="CodePoint">
    ///   The code point to be encoded.
    /// </param>
    /// <param name="Bytes">
    ///   A buffer to store the resulting encoded data into.
    /// </param>
    /// <param name="size">
    ///   Is populated with the size of the code-point after encoding, in
    ///   bytes.
    /// </param>
    /// <returns>
    ///   Returns true if successful. If unsuccessful, it is likely the
    ///   code-point is not a valid unicode code-point.
    /// </returns>
    function UTF16BEEncode(const CodePoint: TUnicodeCodePoint; var Bytes; out size: uint8): boolean;

    /// <summary>
    ///   Encodes a UTF-32LE code-point.
    /// </summary>
    /// <param name="CodePoint">
    ///   The code point to be encoded.
    /// </param>
    /// <param name="Bytes">
    ///   A buffer to store the resulting encoded data into.
    /// </param>
    /// <param name="size">
    ///   Is populated with the size of the code-point after encoding, in
    ///   bytes.
    /// </param>
    /// <returns>
    ///   Returns true if successful. If unsuccessful, it is likely the
    ///   code-point is not a valid unicode code-point.
    /// </returns>
    function UTF32LEEncode(const CodePoint: TUnicodeCodePoint; var Bytes; out size: uint8): boolean;

    /// <summary>
    ///   Encodes a UTF-32BE code-point.
    /// </summary>
    /// <param name="CodePoint">
    ///   The code point to be encoded.
    /// </param>
    /// <param name="Bytes">
    ///   A buffer to store the resulting encoded data into.
    /// </param>
    /// <param name="size">
    ///   Is populated with the size of the code-point after encoding, in
    ///   bytes.
    /// </param>
    /// <returns>
    ///   Returns true if successful. If unsuccessful, it is likely the
    ///   code-point is not a valid unicode code-point.
    /// </returns>
    function UTF32BEEncode(const CodePoint: TUnicodeCodePoint; var Bytes; out size: uint8): boolean;

    /// <summary>
    ///   Encodes an code-point as an ANSI character. The code-point must match
    ///   an ANSI character in order to be valid.
    /// </summary>
    /// <param name="CodePoint">
    ///   The code point to be encoded.
    /// </param>
    /// <param name="Bytes">
    ///   A buffer to store the resulting encoded data into.
    /// </param>
    /// <param name="size">
    ///   Is populated with the size of the code-point after encoding, in
    ///   bytes. *Should always be 1 for AnsiEncode.
    /// </param>
    /// <returns>
    ///   Returns true if successful. If unsuccessful, it is likely the
    ///   code-point is not a valid unicode code-point.
    /// </returns>
    function AnsiEncode(const CodePoint: TUnicodeCodePoint; var Bytes; out size: uint8): boolean;

    /// <summary>
    ///   Detects a BOM (byte-order-mark).
    /// </summary>
    /// <param name="Bytes">
    ///   A buffer containing the bytes to decode as a BOM.
    /// </param>
    /// <param name="Format">
    ///   The expected unicode format for the BOM.
    /// </param>
    /// <param name="BomSize">
    ///   The size of the BOM in bytes to be decoded.
    /// </param>
    /// <returns>
    ///   Returns true if the BOM contained in the bytes parameter matches the
    ///   specified unicode format in the Format parameter. Otherwise returns
    ///   false.
    /// </returns>
    function DecodeBOM(var Bytes; const Format: TUnicodeFormat; const BomSize: uint8): boolean;

    /// <summary>
    ///   Encodes a BOM (Byte-Order-Mark).
    /// </summary>
    /// <param name="Bytes">
    ///   A buffer passed by reference to encode the BOM into.
    /// </param>
    /// <param name="Format">
    ///   The unicode format for which a BOM is required.
    /// </param>
    /// <param name="size">
    ///   A uint8  to be populated with the size of the BOM in bytes.
    /// </param>
    function EncodeBOM(var Bytes; const Format: TUnicodeFormat; out size: uint8): boolean;
  end;

type
  ///  <summary>
  ///    Exception raised if conversion to or from a unicode code-point should
  ///    fail due to corrupted data.
  ///  </summary>
  EUnicodeConversion = class(Exception);

  /// <summary>
  ///   This exception will be raised if the TUTFString record is ever set to
  ///   represent the TUnicodeFormat.utfUnknown format. This should not be
  ///   possible, as the TUFTString record has been designed ensure it never
  ///   gets into this state, however, the exception is included as a
  ///   precaution. If you encounter this exception, please first ensure that
  ///   you are not corrupting the memory space of the TUTFString record, and
  ///   then report the issue to ChapmanWorld LLC.
  /// </summary>
  EUTFUnknownNotSupported = class(Exception);

implementation

end.

