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
unit cwIO.Buffer.Standard;
{$ifdef fpc} {$mode delphiunicode} {$endif}

interface
uses
  cwUnicode
, cwIO
, cwLog
;

type
  TBuffer = class( TInterfacedObject, IBuffer, IUnicodeBuffer )
  private
    fAlign16: boolean;
    fActualDataWhenAligned: pointer;
    fData: pointer;
    fSize: nativeuint;
    fLog: ILog;
  private  //- IBuffer -//
    procedure FillMem( const value: uint8 );
    function LoadFromStream( const Stream: IStream; const Bytes: nativeuint ): nativeuint;
    function SaveToStream( const Stream: IStream; const Bytes: nativeuint ): nativeuint;
    procedure Assign( const Buffer: IBuffer );
    procedure InsertData( const Buffer: Pointer; const Offset: nativeuint; const Bytes: nativeuint );
    function AppendData( const Buffer: Pointer; const Bytes: nativeuint ): pointer; overload;
    function AppendData( const Buffer: pointer ): pointer; overload;
    procedure ExtractData( const Buffer: Pointer; const Offset: nativeuint; const Bytes: nativeuint );
    function getDataPointer: pointer;
    function getSize: nativeuint;
    function getByte( const idx: nativeuint ): uint8;
    procedure setByte( const idx: nativeuint; const value: uint8 );
    procedure setSize( const aSize: nativeuint );
  private //- IUnicodeBuffer -//
    function ReadBOM( const Format: TUnicodeFormat ): boolean;
    procedure WriteBOM( const Format: TUnicodeFormat );
    function DetermineUnicodeFormat: TUnicodeFormat;
    function WriteString( const aString: string; const Format: TUnicodeFormat; ZeroTerm: boolean = FALSE ): nativeuint;
    function ReadString( const Format: TUnicodeFormat; const ZeroTerm: boolean = False; const Max: int32 = -1 ): string;
    function getAsString: string;
    procedure setAsString( const value: string );
    procedure AllocateBuffer( const NewSize: nativeuint );
    procedure DeallocateBuffer;
    procedure ResizeBuffer( const NewSize: nativeuint );
  public
    constructor Create( const aSize: nativeuint = 0; const Align16: boolean = FALSE; const Log: ILog = nil ); reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  cwUnicode.Standard
, cwRuntime.LogEntries
;

procedure TBuffer.AllocateBuffer(const NewSize: nativeuint);
begin
  if (fSize>0) then begin
    DeallocateBuffer;
  end;
  if NewSize>0 then begin
    fSize := NewSize;
    if fAlign16 then begin
      GetMem(fActualDataWhenAligned,fSize+$0F);
      {$ifdef CPU64}
      {$hints off}fData := pointer(((nativeuint(fActualDataWhenAligned) and $FFFFFFFFFFFFFFF0)+$0F));{$hints on}
      {$else}
      {$hints off}fData := pointer(((nativeuint(fActualDataWhenAligned) and $FFFFFFF0)+$0F));{$hints on}
      {$endif}
    end;
    GetMem(fData,fSize);
  end;
end;

procedure TBuffer.DeallocateBuffer;
begin
  if (fSize>0) then begin
    if assigned(fData) then begin
      if fAlign16 then begin
        FreeMem(fActualDataWhenAligned);
      end else begin
        FreeMem(fData);
      end;
    end;
    fSize := 0;
    fData := nil;
  end;
end;

function TBuffer.GetDataPointer: pointer;
begin
  Result := fData;
end;

function TBuffer.GetSize: nativeuint;
begin
  Result := fSize;
end;

function TBuffer.ReadBOM(const Format: TUnicodeFormat): boolean;
var
  BomSize: uint8;
begin
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
    Result := Unicode.DecodeBOM(fData^,Format,BomSize);
  end else begin
    Result := False;
  end;
end;

function TBuffer.ReadString(const Format: TUnicodeFormat; const ZeroTerm: boolean; const Max: int32): string;
var
  TotalSize: nativeuint;
  bytecount: uint8;
  ptr: pointer;
  CH: uint32;
  CP: TUnicodeCodePoint;
  S: string;
  StopOnError: boolean;
begin
  CH:=0;
  if fSize=0 then begin
    Result := '';
    Exit;
  end;
  // This must happen one 'character' (code-point) at a time.
  S := '';
  bytecount := 0;
  CP := 0;
  TotalSize := 0;
  ptr := fData;
  StopOnError := False;
  while (TotalSize<GetSize) and ((Max<0) or (Length(S)<Max)) and (not StopOnError) do begin
    // decode the character from the buffer.
    Move(ptr^,CH,sizeof(CH));
    {$warnings off}
    case Format of

      TUnicodeFormat.utfANSI: begin
        bytecount := sizeof(uint8);
        if not Unicode.AnsiDecode(CH,CP) then begin
          StopOnError := True;
          Continue;
        end;
      end;

      TUnicodeFormat.utf8: begin
        if Unicode.UTF8CharacterLength(CH, bytecount) then begin
          if not Unicode.UTF8Decode(CH, CP) then begin
            StopOnError := True;
            Continue;
          end;
          end else begin
            StopOnError := True;
            Continue;
          end;
      end;

      TUnicodeFormat.utf16LE: begin
        if Unicode.UTF16LECharacterLength(CH, bytecount) then begin
          if not Unicode.UTF16LEDecode(CH, CP) then begin
            StopOnError := True;
            Continue;
          end;
        end else begin
          StopOnError := True;
          Continue;
        end;
      end;

      TUnicodeFormat.utf16BE: begin
        if Unicode.UTF16BECharacterLength(CH,bytecount) then begin
          if not Unicode.UTF16BEDecode(CH, CP) then begin
            StopOnError := True;
            Continue;
          end;
        end else begin
          StopOnError := True;
          Continue;
        end;
      end;

      TUnicodeFormat.utf32LE: begin
        bytecount := sizeof(uint32);
        if not Unicode.UTF32LEDecode(CH, CP) then begin
          StopOnError := True;
          Continue;
        end;
      end;

      TUnicodeFormat.utf32BE: begin
        bytecount := sizeof(uint32);
        if not Unicode.UTF32BEDecode(CH,CP) then begin
          StopOnError := True;
          Continue;
        end;
      end;

    end;
    {$warnings on} // Warns that not all cases are covered, utfUnknown does not need to be covered
    if (CP=0) and (ZeroTerm) then begin
      Break; // drop the loop
    end;
    Unicode.EncodeCodepointToString(CP,S);
    {$ifdef fpc} {$hints off} {$endif}
    ptr := pointer(nativeuint(ptr)+bytecount);
    {$ifdef fpc} {$hints on} {$endif}
    TotalSize := TotalSize + bytecount;
  end;
  Result := S;
end;

procedure TBuffer.ResizeBuffer(const NewSize: nativeuint);
var
  fNewBuffer: pointer;
begin
  if NewSize=fSize then begin
    Exit;
  end else if fSize=0 then begin
    AllocateBuffer(NewSize);
  end else if NewSize=0 then begin
  	DeallocateBuffer;
  end else begin
    // Create the new buffer and copy old data to it.
    GetMem(fNewBuffer,NewSize);
    FillChar(fNewBuffer^,NewSize,0);
    if NewSize>fSize then begin
    	Move(fData^,fNewBuffer^,fSize);
    end else begin
      Move(fData^,fNewBuffer^,NewSize);
    end;
    DeallocateBuffer;
    fData := fNewBuffer;
    fSize := NewSize;
  end;
end;

procedure TBuffer.setAsString(const value: string);
begin
  SetSize( Length(value) * 4 ); // max length of utf16 character is 32-bit, therefore 4-bytes, 4*characters in string should be sufficient.
  SetSize( WriteString(value,TUnicodeFormat.utf16LE) );
end;

procedure TBuffer.setByte(const idx: nativeuint; const value: uint8);
var
  ptr: ^uint8;
begin
  if (idx<fSize) then begin
    {$ifdef fpc} {$hints off} {$endif}
    ptr := pointer(nativeuint(fData)+idx);
    {$ifdef fpc} {$hints on} {$endif}
    ptr^ := value;
  end;
end;

function TBuffer.LoadFromStream(const Stream: IStream; const Bytes: nativeuint): nativeuint;
begin
  if getSize<=Bytes then begin
    Stream.Read(getDataPointer,getSize);
    Result := getSize;
  end else begin
    Stream.Read(getDataPointer,Bytes);
    Result := Bytes;
  end;
end;

function TBuffer.SaveToStream( const Stream: IStream; const Bytes: nativeuint ): nativeuint;
begin
  if Bytes>getSize then begin
    Stream.Write(getDataPointer,getSize);
    Result := getSize;
  end else begin
    Stream.Write(getDataPointer,Bytes);
    Result := Bytes;
  end;
end;

procedure TBuffer.setSize( const aSize: nativeuint );
begin
  if fSize=aSize then Exit;
  ResizeBuffer(aSize);
end;

procedure TBuffer.WriteBOM( const Format: TUnicodeFormat );
var
  size: uint8;
begin
  size := 0;
  Unicode.EncodeBOM(fData^,Format,size);
end;

function TBuffer.WriteString( const aString: string; const Format: TUnicodeFormat; ZeroTerm: boolean = FALSE ): nativeuint;
var
  ptr: ^char;
  CH: uint32;
  StrLen: int32;
  CP: TUnicodeCodepoint;
  Cursor: int32;
  L: uint8;
begin
  CP := 0;
  CH := 0;
  L := 0;
  Result := 0;
  // Loop each character
  {$ifdef NEXTGEN}
  StrLen := Pred(Length(aString));
  {$else}
  StrLen := Length(aString);
  {$endif}
  //- Pass one, measure string length.
  {$ifdef NEXTGEN}
  Cursor := 0;
  {$else}
  Cursor := 1;
  {$endif}
  //- Pass one, measure string length.
  while (Cursor<=StrLen) do begin
    Unicode.DecodeCodepointFromString(CP,aString,Cursor);
    case Format of

      TUnicodeFormat.utfUnknown: begin
        if assigned(fLog) then begin
          fLog.Insert(le_CannotEncodeUnknownUnicodeFormat,TLogSeverity.lsError);
        end;
        exit;
      end;

      TUnicodeFormat.utfANSI: begin
        L := 1;
      end;

      TUnicodeFormat.utf8: begin
        Unicode.UTF8Encode(CP,CH,L);
      end;

      TUnicodeFormat.utf16LE: begin
        Unicode.UTF16LEEncode(CP,CH,L);
      end;

      TUnicodeFormat.utf16BE: begin
        Unicode.UTF16BEEncode(CP,CH,L);
      end;

      TUnicodeFormat.utf32LE: begin
        Unicode.UTF32LEEncode(CP,CH,L);
      end;

      TUnicodeFormat.utf32BE: begin
        Unicode.UTF32BEEncode(CP,CH,L);
      end;

    end;
    Result := Result + L;
  end;
  if ZeroTerm then begin
    inc(Result);
  end;
  //- Set buffer size.
  Self.AllocateBuffer(Result);
  //- Pass two, put data into buffer
  {$ifdef NEXTGEN}
  Cursor := 0;
  {$else}
  Cursor := 1;
  {$endif}
  ptr := fData;
  while (Cursor<=StrLen) do begin
    Unicode.DecodeCodepointFromString(CP,aString,Cursor);
    {$warnings off}
    case Format of
      TUnicodeFormat.utfANSI: begin
        Unicode.ANSIEncode(CP,CH,L);
      end;

      TUnicodeFormat.utf8: begin
        Unicode.UTF8Encode(CP,CH,L);
      end;

      TUnicodeFormat.utf16LE: begin
        Unicode.UTF16LEEncode(CP,CH,L);
      end;

      TUnicodeFormat.utf16BE: begin
        Unicode.UTF16BEEncode(CP,CH,L);
      end;

      TUnicodeFormat.utf32LE: begin
        Unicode.UTF32LEEncode(CP,CH,L);
      end;

      TUnicodeFormat.utf32BE: begin
        Unicode.UTF32BEEncode(CP,CH,L);
      end;

    end;
    {$warnings on} // warns that not all cases are covered, cases such as uftUnknown do not need to be covered
    Move(CH,ptr^,L);
    {$ifdef fpc} {$hints off} {$endif}
    ptr := pointer(nativeuint(pointer(Ptr)) + L);
    {$ifdef fpc} {$hints on} {$endif}
  end;
  if ZeroTerm then begin
    uint8(pointer(ptr)^) := 0;
  end;
end;

constructor TBuffer.Create( const aSize: nativeuint = 0; const Align16: boolean = FALSE; const Log: ILog = nil );
begin
  inherited Create;
  fData := nil;
  fSize := aSize;
  fLog := Log;
  fAlign16 := Align16;
  //- Dependencies
  //- Allocate an initial amount.
  AllocateBuffer(fSize);
end;

destructor TBuffer.Destroy;
begin
  DeallocateBuffer;
  inherited Destroy;
end;

function TBuffer.DetermineUnicodeFormat: TUnicodeFormat;
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

function TBuffer.AppendData(const Buffer: pointer): pointer;
var
  count: nativeuint;
  measurePtr: ^uint8;
begin
  // First measure the buffer.
  count := 0;
  measurePtr := Buffer;
  while measurePtr^<>0 do begin
    inc(count);
    inc(measurePtr);
  end;
  Result := AppendData(Buffer,succ(Count));
end;

procedure TBuffer.Assign(const Buffer: IBuffer);
begin
  if Buffer.Size=0 then begin
    fSize := 0;
    Exit;
  end;
  SetSize( Buffer.Size );
  Move(Buffer.getDataPointer^,fData^,fSize);
end;

procedure TBuffer.InsertData( const Buffer: Pointer; const Offset: nativeuint; const Bytes: nativeuint );
var
  DataPtr: pointer;
begin
  {$ifdef fpc} {$hints off} {$endif}
  DataPtr := pointer(nativeuint(fData) + Offset );
  {$ifdef fpc} {$hints on} {$endif}
  Move(Buffer^,DataPtr^,Bytes);
end;

function TBuffer.AppendData( const Buffer: Pointer; const Bytes: nativeuint ): pointer;
var
  Target: NativeInt;
  TargetPtr: Pointer;
  OldSize: Longword;
begin
  Result := nil;
  if bytes>0 then begin
    OldSize := fSize;
    SetSize( OldSize + Bytes );
    {$HINTS OFF} Target := NativeInt(fData); {$HINTS ON}
    inc(Target,OldSize);
    {$HINTS OFF} TargetPtr := Pointer(Target); {$HINTS ON}
    Move(Buffer^,TargetPtr^,Bytes);
    Result := TargetPtr;
  end;
end;

procedure TBuffer.ExtractData( const Buffer: Pointer; const Offset: nativeuint; const Bytes: nativeuint );
var
  DataPtr: pointer;
begin
  if not assigned(Buffer) then begin
    exit;
  end;
  if Bytes=0 then begin
    exit;
  end;
  {$ifdef fpc} {$hints off} {$endif}
  DataPtr := pointer(nativeuint(fData) + Offset);
  {$ifdef fpc} {$hints on} {$endif}
  if Bytes>(fSize-Offset) then begin
    Move(DataPtr^,Buffer^,(fSize-Offset));
  end else begin
    Move(DataPtr^,Buffer^,Bytes);
  end;
end;

procedure TBuffer.FillMem(const value: uint8);
begin
  FillChar(getDataPointer^,getSize,value);
end;

function TBuffer.getAsString: string;
begin
  Result := ReadString(TUnicodeFormat.utf16LE);
end;

function TBuffer.getByte(const idx: nativeuint): uint8;
var
  ptr: ^uint8;
begin
  if (idx<fSize) then begin
    {$ifdef fpc} {$hints off} {$endif}
    ptr := pointer(nativeuint(fData)+idx);
    {$ifdef fpc} {$hints on} {$endif}
    Result := ptr^;
  end else begin
    Result := 0;
  end;
end;


end.




