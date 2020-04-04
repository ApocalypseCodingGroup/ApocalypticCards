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
unit cwIO;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwUnicode
;

type
  //-- Imported from deUnicode
  /// <exclude/>
  TUnicodeFormat          = cwUnicode.TUnicodeFormat;

{$region ' IStream'}
  /// <summary>
  ///   IStream is an abstract interface from which other stream interfaces
  ///   are derrived.
  /// </summary>
  IStream = interface
    ['{08852882-39D7-4CC1-8E1E-D5F323E47421}']

    ///  <summary>
    ///    For streams which support the method, clear will empty all content
    ///    from the stream and reset the position to zero.
    ///    For streams which do not support clear, an error is inserted into
    ///    the log. (lsFatal)
    ///  </summary>
    procedure Clear;

    /// <summary>
    ///   Returns true if the cursor is currently positioned at the end of the
    ///   stream.
    /// </summary>
    /// <returns>
    ///   True if the cursor is currently positioned at the end of the stream,
    ///   otherwise returns false.
    /// </returns>
    function getEndOfStream: boolean;

    /// <summary>
    ///   Get the current cursor position within the stream.
    /// </summary>
    /// <returns>
    ///   index of the cursor within the stream from zero, in bytes.
    /// </returns>
    function getPosition: nativeuint;

    /// <summary>
    ///   Set the cursor position within the stream.
    /// </summary>
    /// <param name="newPosition">
    ///   The index from zero at which to position the cursor, in bytes.
    /// </param>
    /// <remarks>
    ///   Some streams do not support setting the cursor position. In such
    ///   cases, the cursor position will remain unchanged. You should test
    ///   getPosition() to confirm that the move was successful.
    /// </remarks>
    procedure setPosition( const newPosition: nativeuint );

    ///  <summary>
    ///    Returns the number of bytes remaining on the stream.
    ///  </summary>
    ///  <remarks>
    ///    Some streams do not support reporting the cursor position, and so,
    ///    the remaining number of bytes may be unknown. In such cases, this
    ///    method will return zero.
    ///  </remarks>
    function getRemainingBytes: nativeuint;

    /// <summary>
    ///   Reads an arbritrary number of bytes from the stream. <br />
    /// </summary>
    /// <param name="p">
    ///   Pointer to a buffer with sufficient space to store the bytes read
    ///   from the stream.
    /// </param>
    /// <param name="Count">
    ///   The maximum number of bytes to read from the stream (size of the
    ///   buffer).
    /// </param>
    /// <returns>
    ///   The number of bytes actually read from the stream, which may differ
    ///   from the number requested in the count parameter. See remarks.
    /// </returns>
    /// <remarks>
    ///   <para>
    ///     When reading from streams, a number of conditions may prevent the
    ///     read operation from returning the number of bytes requested.
    ///   </para>
    ///   <para>
    ///     Examples Include:
    ///   </para>
    ///   <list type="bullet">
    ///     <item>
    ///       Request is for more bytes than remain in the datasource of
    ///       the stream. In this case, the remaining data bytes are
    ///       returned, and the return value of the Read() method will
    ///       reflect the number of bytes actually returned. <br /><br />
    ///     </item>
    ///     <item>
    ///       The stream does not support read operations. Some streams are
    ///       unidirectional. If this stream does not support reading
    ///       operations, the read() method will return zero.
    ///     </item>
    ///   </list>
    /// </remarks>
    function Read( const p: pointer; const Count: nativeuint ): nativeuint;

    /// <summary>
    ///   Writes an arbritrary number of bytes to the stream.
    /// </summary>
    /// <param name="p">
    ///   A pointer to a buffer from which bytes will be written onto the
    ///   stream.
    /// </param>
    /// <param name="Count">
    ///   The number of bytes to write onto the stream.
    /// </param>
    /// <returns>
    ///   Returns the number of bytes actually written to the stream, which may
    ///   differ from the number specified in the Count parameter. See remarks.
    /// </returns>
    /// <remarks>
    ///   <para>
    ///     A number of conditions can prevent writing data to a stream, in
    ///     which case, the number of bytes written may differ from the
    ///     number specified in the count parameter.
    ///   </para>
    ///   <para>
    ///     Examples include:
    ///   </para>
    ///   <list type="bullet">
    ///     <item>
    ///       There is insufficient space left in the stream target for
    ///       additional data. In this case, the maximum amount of data
    ///       that can be written, will be written, and the return value of
    ///       the Write() method reflects the number of bytes actually
    ///       written. <br /><br />
    ///     </item>
    ///     <item>
    ///       The stream does not support writing. Some streams are
    ///       unidirectional and therefore may not support writing
    ///       operations. In this case, the Write() method will return
    ///       zero.
    ///     </item>
    ///   </list>
    /// </remarks>
    function Write( const p: pointer; const Count: nativeuint ): nativeuint;

    /// <summary>
    ///   Copies the contents of another stream to this one.
    /// </summary>
    /// <param name="Source">
    ///   The stream to copy data from.
    /// </param>
    /// <returns>
    ///   <para>
    ///     Returns the number of bytes copied from the source stream to this
    ///     one. A number of conditions could prevent successful copying of
    ///     one stream to another.
    ///   </para>
    ///   <para>
    ///     Examples include
    ///   </para>
    ///   <list type="bullet">
    ///     <item>
    ///       The target stream is not writable. In this case, the
    ///       CopyFrom() method will return zero. <br /><br />
    ///     </item>
    ///     <item>
    ///       The source stream is not readable. In this case the
    ///       CopyFrom() method will return zero. <br /><br />
    ///     </item>
    ///     <item>
    ///       The target stream has insufficient storage space for the data
    ///       being copied from the source stream. In this case, the
    ///       maximum number of bytes that can be copied will be copied,
    ///       and the return value of the CopyFrom() method will reflect
    ///       the number of bytes actually copied.
    ///     </item>
    ///   </list>
    /// </returns>
    function CopyFrom( const Source: IStream ): nativeuint;

    /// <summary>
    ///   Get the size of the stream in bytes.
    /// </summary>
    /// <returns>
    ///   Returns the number of bytes stored on the stream in bytes.
    /// </returns>
    function getSize: nativeuint;

    ///  <summary>
    ///    Returns the name of the stream.
    ///    Naming the stream is optional, and if the stream has not been
    ///    named, this method will return a null string.
    ///  </summary>
    function getName: string;

    ///  <summary>
    ///    Optionally, this stream may be given a name.
    ///    This optional parameter is not used by the stream functionality,
    ///    but may be useful for labeling streams in mult-stream applications.
    ///  </summary>
    procedure setName( const value: string );

    ///  <summary>
    ///    Writes a single byte to the stream.
    ///  </summary>
    procedure WriteByte( const value: uint8 );

    ///  <summary>
    ///    Reads a single byte from the stream.
    ///  </summary>
    function ReadByte: uint8;

    ///  <summary>
    ///    Writes an array of bytes to the stream.
    ///  </summary>
    procedure WriteBytes( const value: array of uint8 );

    //- Pascal only, properties -//
    property Name: string read getName write setName;
    property Size: nativeuint read getSize;
    property Position: nativeuint read getPosition write setPosition;
  end;
{$endregion}

{$region ' IUnicodeStream'}
  /// <summary>
  ///   A stream which supports the IUnicodeStream is able to read data from
  ///   a stream in one unicode format, and translate it on-the-fly into
  ///   another unicode format.
  /// </summary>
  IUnicodeStream = interface( IStream )
    ['{BA3588F0-32A4-4039-A212-389C630BB2E4}']

    /// <summary>
    ///   <para>
    ///     This method attempts to read the unicode BOM (byte-order-mark) of
    ///     the specified unicode format, and returns TRUE if the BOM is
    ///     found or else returns FALSE. <br />
    ///     Warning, the BOM for UTF16-LE will match when the BOM for UTF32-LE
    ///     is present, because the first two bytes of the UTF32-LE BOM match
    ///     those of the UTF-16LE BOM.  Similarly the UTF32-BE BOM will match
    ///     for UTF16-BE. In order to determine the unicode format from the BOM
    ///     values, these values must be tested in order of length, starting
    ///     with the highest. i.e. Test of UTF32-LE and only if that fails to
    ///     match, test for UTF-16LE.
    ///     The Determine unicode format tests BOM's in order to determine the
    ///     unicode format from the BOM.
    ///   </para>
    ///   <para>
    ///     If the BOM is found, the stream position is advanced, but if the
    ///     BOM is not found, the stream position does not change.
    ///   </para>
    /// </summary>
    /// <param name="Format">
    ///   Specifies the unicode format for which a byte-order-mark is expected
    ///   on the stream.
    /// </param>
    /// <returns>
    ///   Returns TRUE if the BOM is discovered on the stream at the current
    ///   position, otherwise returns FALSE.
    /// </returns>
    function ReadBOM( const Format: TUnicodeFormat ): boolean;

    /// <summary>
    ///   <para>
    ///     This method will write the Byte-Order-Mark of the specified
    ///     unicode text format onto the stream.
    ///   </para>
    ///   <para>
    ///     Formats of unknown and ansi will do nothing as there is no BOM
    ///     for these formats.
    ///   </para>
    /// </summary>
    /// <param name="Format">
    ///   Format The unicode format to write a BOM for.
    /// </param>
    procedure WriteBOM( const Format: TUnicodeFormat );

    /// <summary>
    ///   This method looks for a unicode BOM (byte-order-mark), and if one is
    ///   found, the appropriate unicode format enumeration is returned. <br />
    ///   If no unicode BOM is found, this function returns utfUnknown and you
    ///   should default to the most appropriate format. In most cases UTF-8 is
    ///   a good default option due to it's compatability with ANSI. <br />
    /// </summary>
    /// <returns>
    ///   The TdeUnicodeFormat enum which indicates the BOM which was
    ///   discovered, or else utfUnknown is returned if no appropriate BOM is
    ///   found.
    /// </returns>
    function DetermineUnicodeFormat: TUnicodeFormat;

    ///  <summary>
    ///    This method writes a character to the stream in the specified
    ///    unicode format.
    ///  </summary>
    ///  <param name="aChar">
    ///    The character to write to the stream.
    ///  </param>
    ///  <param name="Format">
    ///    The unicode format used to encode the character onto the stream.
    ///  </param>
    procedure WriteChar( const aChar: char; const Format: TUnicodeFormat );

    ///  <summary>
    ///    This method reads a single character from the stream using the
    ///    specified unicode format.
    ///  </summary>
    ///  <param name="Format">
    ///    The unicode format to use to decode the character being read from
    ///    the stream.
    ///  </param>
    ///  <returns>
    ///    Returns the next character from the unicode encoded stream.
    ///  </returns>
    function ReadChar( const Format: TUnicodeFormat ): char;

    /// <summary>
    ///   This method writes the string of characters to the stream in <br />
    ///   the specified unicode format.
    /// </summary>
    /// <param name="aString">
    ///   The string of characters to write to the stream.
    /// </param>
    /// <param name="Format">
    ///   The unicode format to use when writing the characters to the stream.
    /// </param>
    procedure WriteString( const aString: string; const Format: TUnicodeFormat );

    /// <summary>
    ///   This method reads a string of characters from the stream in the
    ///   specified unicode format, translating them to a TString UTF-16LE. <br />
    /// </summary>
    /// <param name="Format">
    ///   The unicode format to use when reading the characters <br />from the
    ///   stream.
    /// </param>
    /// <param name="ZeroTerm">
    ///   Optional parameter. Terminate reading characters from the stream when
    ///   a zero character is found?
    /// </param>
    /// <param name="Max">
    ///   Optional parameter. The maximum number of unicode characters to read
    ///   from the stream.
    /// </param>
    /// <returns>
    ///   The string of characters read from the stream, converted to <br />
    ///   TdeString (UTF-16LE)
    /// </returns>
    /// <remarks>
    ///   <para>
    ///     This method, by default, will read characters from the stream
    ///     until the stream has been exhausted.
    ///   </para>
    ///   <para>
    ///     You can tell the stream to terminate early using the two optional
    ///     parameters. <br /><br />
    ///   </para>
    ///   <para>
    ///     Setting ZeroTerm to true causes the method to stop reading when a
    ///     code-point is discovered with the value of zero. This is useful
    ///     for reading zero terminated strings from the stream. The zero
    ///     will be removed from the stream, but not added to the string.
    ///   </para>
    ///   <para>
    ///     Alternatively, you can set the Max parameter to limit the number
    ///     of characters that will be read from the stream.
    ///   </para>
    /// </remarks>
    function ReadString( const Format: TUnicodeFormat; const ZeroTerm: boolean = False; const Max: int32 = -1 ): string;

    //- Pascal Only, Properties -//
    property Size: nativeuint read getSize;
    property Position: nativeuint read getPosition write setPosition;
  end;

{$endregion}

{$region ' IBuffer'}
  /// <summary>
  ///   IBuffer provides methods for manipulating the data content of a buffer.
  /// </summary>
  /// <seealso cref="de.buffers|TBuffer">
  ///   TBuffer
  /// </seealso>
  IBuffer = interface
    ['{115CCCF5-4F51-425E-9A00-3CEB8E6E19E6}']

    ///  <summary>
    ///    Fills the entire buffer with the value passed in the 'value' parameter.
    ///    Useful for clearing the buffer for example.
    ///  </summary>
    ///  <param name="value">
    ///    The value to fill the buffer with.
    ///  </param>
    procedure FillMem( const value: uint8 );

    /// <summary>
    ///   Loads 'Bytes' bytes of data from the stream into the buffer.
    /// </summary>
    /// <param namme="Stream">
    ///   The stream to load data from.
    /// </param>
    /// <param name="Bytes">
    ///   The number of bytes to load from the stream.
    /// </param>
    /// <returns>
    ///   The number of bytes actually read from the stream.
    /// </returns>
    function LoadFromStream( const Stream: IStream; const Bytes: nativeuint ): nativeuint;

    /// <summary>
    ///   Saves 'Bytes' bytes of data from the buffer into the stream.
    /// </summary>
    /// <param name="Stream">
    ///   The stream to save bytes into.
    /// </param>
    /// <param name="Bytes">
    ///   The number of bytes to write into the stream.
    /// </param>
    /// <returns>
    ///   The number of bytes actually written to the stream.
    /// </returns>
    function SaveToStream( const Stream: IStream; const Bytes: nativeuint ): nativeuint;

    /// <summary>
    ///   Copy the data from another buffer to this one. <br />The size of the
    ///   buffer will be appropriately altered to match that of the buffer
    ///   being copied.
    /// </summary>
    /// <param name="Buffer">
    ///   The buffer to copy data from.
    /// </param>
    /// <remark>
    ///   This method is destructive to existing data in the buffer.
    /// </remark>
    procedure Assign( const Buffer: IBuffer );

    /// <summary>
    ///   Insert data from another memory location into this buffer.
    ///   There must be sufficient space in the buffer to store the inserted
    ///   data at the specified offset.
    /// </summary>
    /// <param name="Buffer">
    ///   This is a pointer to the memory location that data should be copied
    ///   from.
    /// </param>
    /// <param name="Bytes">
    ///   Specifies the number of bytes to read from the memory location.
    /// </param>
    /// <remarks>
    ///   This method is destructive to existing data in the buffer.
    /// </remarks>
    procedure InsertData( const Buffer: Pointer; const Offset: nativeuint; const Bytes: nativeuint );

    /// <summary>
    ///   Appends data from another memory location to the end of this buffer.
    /// </summary>
    /// <param name="Buffer">
    ///   A pointer to the memory location that data should be copied from.
    /// </param>
    /// <param name="Bytes">
    ///   Specifies the number of bytes to add to the buffer from the memory
    ///   location specified in the buffer parameter.
    /// </param>
    /// <returns>
    ///   Pointer to the newly appended data.
    /// </returns>
    function AppendData( const Buffer: Pointer; const Bytes: nativeuint ): pointer; overload;

    ///  <summary>
    ///    Appends data from another memory location to the end of this buffer.
    ///    The data to be appended must be zero-terminated.
    ///    If the size of the buffer to be appended is known, see the other
    ///    overload of AppendData().
    ///  </summary>
    function AppendData( const Buffer: pointer ): pointer; overload;

    /// <summary>
    ///   Extract data to another memory location from this buffer.
    /// </summary>
    /// <param name="Buffer">
    ///   This is a pointer to the memory location that data should be copied
    ///   to
    /// </param>
    /// <param name="Bytes">
    ///   This is the number of bytes that should be copied from this buffer.
    /// </param>
    procedure ExtractData( const Buffer: Pointer; const Offset: nativeuint; const Bytes: nativeuint );

    /// <summary>
    ///   Returns a void pointer to the buffer data.
    /// </summary>
    function getDataPointer: pointer;

    /// <summary>
    ///   Returns the size of the buffer in bytes.
    /// </summary>
    function getSize: nativeuint;

    /// <summary>
    ///    Returns the value of the byte specified by index (offset within the buffer)
    ///  </summary>
    ///  <param name="idx">
    ///    An offset into the buffer.
    ///  </param>
    function getByte( const idx: nativeuint ): uint8;

    /// <summary>
    ///    Sets the value of the byte specified by index (offset within the buffer)
    ///  </summary>
    ///  <param name="idx">
    ///    An offset into the buffer.
    ///  </param>
    ///  <param>
    ///    The value to set.
    ///  </param>
    procedure setByte( const idx: nativeuint; const value: uint8 );

    /// <summary>
    ///   Sets the size of the buffer in bytes.
    /// </summary>
    /// <param name="aSize">
    ///   The new buffer size in bytes.
    /// </param>
    /// <remarks>
    ///   This function will retain any existing data, up-to the new size of
    ///   the buffer.
    /// </remarks>
    procedure setSize( const aSize: nativeuint );

    /// <summary>
    ///   Get the size of the data in this buffer, in bytes.
    /// </summary>
    property Size: nativeuint read getSize write setSize;
    property DataPtr: pointer read getDataPointer;
    property Bytes[ const idx: nativeuint ]: uint8 read getByte write setByte;
  end;
{$endregion}

{$region ' IUnicodeBuffer'}
  ///  <summary>
  ///    Provides methods for working with buffers containing unicode text.
  ///  </summary>
  IUnicodeBuffer = interface( IBuffer )
    ['{E0472DB1-CDE7-4FD1-BB02-00291C0342F6}']

    ///  <summary>
    ///    Returns the entire buffer as a string, assuming that the data in
    ///    the buffer is encoded as UTF16-LE (the default string type).
    ///  </summary>
    function getAsString: string;

    ///  <summary>
    ///    Sets the buffer length to be sufficient to store the string in
    ///    UTF16-LE format internally.
    ///  </summary>
    procedure setAsString( const value: string );

    ///  <summary>
    ///    Attempts to read the byte-order-mark of the specified unicode format.
    ///    Returns true if the requested BOM is present at the beginning of
    ///    the buffer, else returns false.
    ///  </summary>
    function ReadBOM( const Format: TUnicodeFormat ): boolean;

    ///  <summary>
    ///    Writes the specified unicode byte-order-mark to the beginning of the
    ///    buffer.
    ///  </summary>
    procedure WriteBOM( const Format: TUnicodeFormat );

    ///  <summary>
    ///    Attempts to identify the unicode format of the data in the buffer
    ///    by inspecting the byte-order-mark or other attributes of the data.
    ///  </summary>
    function DetermineUnicodeFormat: TUnicodeFormat;

    ///  Returns length of string written to buffer, in bytes.
    ///  The buffer size is set to match the length of the string after encoding.
    ///  If the optional ZeroTerm parameter is set true, a zero terminator is
    ///  added to the string and returned byte-count. This may only be useful
    ///  when writing ANSI or UTF8 format strings as other formats do not
    ///  typically use zero termination.
    function WriteString( const aString: string; const Format: TUnicodeFormat; ZeroTerm: boolean = FALSE ): nativeuint;

    ///  Max when not -1, is lenght of TString in characters
    function ReadString( const Format: TUnicodeFormat; const ZeroTerm: boolean = False; const Max: int32 = -1 ): string;

    //- Pascal only properties -//

    ///  <summary>
    ///    When setting, will set the length of the buffer to the required number
    ///    of bytes to contain the string in UTF16-LE format internally.
    ///    When getting, the entire buffer will be returned as a string.
    ///  </summary>
    property AsString: string read getAsString write setAsString;
  end;
{$endregion}

{$region ' ICyclicBuffer'}
  ICyclicBuffer = interface
    ['{42C239B3-36F7-4618-B4BD-929C53DFF75C}']

    /// <summary>
    ///   Simply resets the buffer pointers.
    /// </summary>
    procedure Clear;

    /// <summary>
    ///   Write 'Count' bytes into the buffer. If there is insufficient space in
    ///   the buffer, this method will return a <0 error code. Otherwise the
    ///   number of bytes added is returned.
    /// </summary>
    function Write( const DataPtr: Pointer; const Count: nativeuint ): nativeuint;

    /// <summary>
    ///   Read 'Count' bytes from the buffer. If there is insufficient data to
    ///   return the number of bytes requested, the maximum available bytes
    ///   will be read. This method returns the number of bytes read from
    ///   the buffer.
    /// </summary>
    function Read( const DataPtr: Pointer; const Count: nativeuint ): nativeuint;

    ///  <summary>
    ///    Reads 'Size' bytes from the buffer, but doesn't remove that data from
    ///    the buffer as Read does.
    ///  </summary>
    function Peek( const DataPtr: Pointer; const Count: nativeuint ): nativeuint;

    /// <summary>
    ///   Loads 'Bytes' bytes of data from the stream into the buffer.
    /// </summary>
    function LoadFromStream( const Stream: IStream; const Bytes: nativeuint ): nativeuint;

    /// <summary>
    ///   Saves 'Bytes' bytes of data from the buffer into the stream.
    /// </summary>
    function SaveToStream( const Stream: IStream; const Bytes: nativeuint ): nativeuint;

    /// <summary>
    ///   Returns the number of bytes that are freely available in the buffer.
    /// </summary>
    function GetFreeBytes: nativeuint;

    /// <summary>
    ///   Returns the number of bytes that are currently occupied in the buffer.
    /// </summary>
    function GetUsedBytes: nativeuint;
  end;
{$endregion}


implementation

end.
