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
unit cwIO.CyclicBuffer.Standard;
{$ifdef fpc} {$mode delphiunicode} {$endif}

interface
uses
  cwIO
;

type
  TCyclicBuffer = class( TInterfacedObject, ICyclicBuffer )
  private
    fBuffer: IBuffer;
    fBottom: nativeuint;
    fTop: nativeuint;

  private
    function OffsetPointer( const P: pointer; const Offset: nativeuint ): pointer; overload;
    function OffsetPointer( const Offset: nativeuint ): pointer; overload;

  protected
    //- Implement IdeCyclicBuffer -//
    procedure Clear;
    function Write( const DataPtr: Pointer; const Count: nativeuint ): nativeuint;
    function Read( const DataPtr: Pointer; const Count: nativeuint ): nativeuint;
    function Peek( const DataPtr: Pointer; const Count: nativeuint ): nativeuint;
    function LoadFromStream( const Stream: IStream; const Bytes: nativeuint ): nativeuint;
    function SaveToStream( const Stream: IStream; const Bytes: nativeuint ): nativeuint;
    function getFreeBytes: nativeuint;
    function getUsedBytes: nativeuint;

  public
    /// <summary>
    ///   Creates a buffer of 'Size' bytes.
    /// </summary>
    constructor Create( const Size: nativeuint = 0 ); reintroduce;

    /// <summary>
    ///   Frees all memory used.
    /// </summary>
    destructor Destroy; override;
  end;

implementation
uses
  cwIO.Buffer.Standard
;

procedure TCyclicBuffer.Clear;
begin
  fBottom := 0;
  fTop := 0;
end;

constructor TCyclicBuffer.Create( const Size: nativeuint = 0 );
begin
  inherited Create;
  //- Create internal buffer (coax and heap dependencies).
  fBuffer := TBuffer.Create(Size);
  Clear;
end;

destructor TCyclicBuffer.Destroy;
begin
  fBuffer := nil; // dispose interface.
  inherited Destroy;
end;

function TCyclicBuffer.GetFreeBytes: nativeuint;
begin
  if fBottom<fTop then begin
    Result := (fBuffer.Size - fTop) + (fBottom); // distance from buffer borders.
  end else if fTop<fBottom then begin
    Result := fBottom-fTop; // distance between the pointers
  end else begin
    Result := fBuffer.Size;
  end;
end;

function TCyclicBuffer.GetUsedBytes: nativeuint;
begin
  if fTop>fBottom then begin
    Result := fTop-fBottom;
  end else if fBottom>fTop then begin
    Result := (fBuffer.Size - fBottom) + fTop;
  end else begin
    Result := 0;
  end;
end;

function TCyclicBuffer.LoadFromStream(const Stream: IStream; const Bytes: nativeuint): nativeuint;
var
  Buffer: IBuffer;
  BytesToLoad: nativeuint;
  BytesLoaded: nativeuint;
begin
  Buffer := TBuffer.Create();
  try
    // Find out the number of bytes we can safely load in.
    BytesToLoad := Bytes;
    if getFreeBytes<BytesToLoad then begin
      BytesToLoad := getFreeBytes;
    end;
    if (Stream.getSize-Stream.getPosition)<BytesToLoad then begin
      BytesToLoad := (Stream.getSize-Stream.getPosition);
    end;
    // Size the buffer to load data from the stream
    Buffer.setSize(BytesToLoad);
    BytesLoaded := Buffer.LoadFromStream(Stream, BytesToLoad);
    // Write the data into the cyclic buffer
    Result := Write(Buffer.getDataPointer,BytesLoaded);
  finally
    Buffer := nil; // interface
  end;
end;

function TCyclicBuffer.OffsetPointer(const P: pointer; const Offset: nativeuint): pointer;
begin
  {$ifdef fpc} {$hints off} {$endif}
  Result := pointer(nativeuint(P)+Offset);
  {$ifdef fpc} {$hints on} {$endif}
end;

function TCyclicBuffer.OffsetPointer(const Offset: nativeuint): pointer;
begin
  Result := OffsetPointer(fBuffer.getDataPointer,Offset);
end;

function TCyclicBuffer.Peek(const DataPtr: Pointer; const Count: nativeuint): nativeuint;
var
  SizeToRead: nativeuint;
  Remaining: nativeuint;
  NewPtr: pointer;
begin
  Result := 0;
  // Which is closest? The top of data or the top of the buffer.
  if fTop>fBottom then begin
    SizeToRead := fTop-fBottom;
    if SizeToRead>Count then begin
      SizeToRead := Count;
    end;
    Move( OffsetPointer(fBottom)^, DataPtr^, SizeToRead );
    Result := SizeToRead;
  end else if fBottom>=fTop then begin
    SizeToRead := fBuffer.Size - fBottom;
    if SizeToRead>Count then begin
      SizeToRead := Count;
    end;
    Move( OffsetPointer(fBottom)^, DataPtr^, SizeToRead );
    inc(Result,SizeToRead);
    NewPtr := OffsetPointer( DataPtr, SizeToRead );
    Remaining := Count-SizeToRead;
    if Remaining>0 then begin
      SizeToRead := fTop;
      if SizeToRead>Remaining then begin
        SizeToRead := Remaining;
      end;
      Move( OffsetPointer(fBottom)^, NewPtr^, SizeToRead );
      Result := Result + SizeToRead;
    end;
  end;
end;

function TCyclicBuffer.Read(const DataPtr: Pointer; const Count: nativeuint): nativeuint;
var
  SizeToRead: nativeuint;
  Remaining: nativeuint;
  NewPtr: pointer;
begin
  Result := 0;
  // Which is closest? The top of data or the top of the buffer.
  if fTop>fBottom then begin
    SizeToRead := fTop-fBottom;
    if SizeToRead>Count then begin
      SizeToRead := Count;
    end;
    Move( OffsetPointer(fBottom)^, DataPtr^, SizeToRead );
    inc(fBottom,SizeToRead);
    Result := SizeToRead;
  end else if fBottom>=fTop then begin
    SizeToRead := fBuffer.Size - fBottom;
    if SizeToRead>Count then begin
      SizeToRead := Count;
    end;
    Move( OffsetPointer(fBottom)^, DataPtr^, SizeToRead );
    inc(Result,SizeToRead);
    NewPtr := OffsetPointer( DataPtr, SizeToRead );
    Remaining := Count-SizeToRead;
    fBottom := 0; // we've read to the top of the buffer.
    if Remaining>0 then begin
      SizeToRead := fTop;
      if SizeToRead>Remaining then begin
        SizeToRead := Remaining;
      end;
      Move( OffsetPointer(fBottom)^, NewPtr^, SizeToRead );
      Result := Result + SizeToRead;
    end;
  end;
end;

function TCyclicBuffer.SaveToStream(const Stream: IStream; const Bytes: nativeuint): nativeuint;
var
  BytesToWrite: nativeuint;
  Buffer: IBuffer;
begin
  BytesToWrite := Bytes;
  if BytesToWrite>getUsedBytes then begin
    BytesToWrite := getUsedBytes;
  end;
  Buffer := TBuffer.Create();
  try
    Buffer.setSize(Bytes);
    BytesToWrite := Read(Buffer.getDataPointer,BytesToWrite);
    Result := Buffer.SaveToStream(Stream,BytesToWrite);
  finally
    Buffer := nil; // interface
  end;
end;

function TCyclicBuffer.Write(const DataPtr: Pointer; const Count: nativeuint): nativeuint;
var
  SizeToWrite: nativeuint;
  Remaining: nativeuint;
  Space: nativeuint;
  NewPtr: pointer;
  P: pointer;
begin
  // Calculate how many bytes of those provided can be written to the buffer.
  SizeToWrite := getFreeBytes;
  if SizeToWrite>Count then begin
    SizeToWrite := Count;
  end;
  // Set a remainder to calcuate how much of the buffer we've written.
  Remaining := SizeToWrite;
  // If the buffer top is above the buffer bottom, then there may be
  // space above the top, and there may be space below the bottom.
  // If the buffer top is below the buffer bottom, then there is only
  // space between the buffer top and the buffer bottom. Start with the simplest.
  if fTop<fBottom then begin
    // There is only space between fTop and fBottom.
    // Move the data into fTop, and increment fTop.
    P := OffsetPointer(fTop);
    Move( DataPtr^, P^, Remaining );
    inc(fTop,Remaining);
  end else if fBottom<fTop then begin
    // There may be space above fTop and below fBottom.
    // Start by writing whatever can be written to the space above fTop.
    Space := fBuffer.Size - fTop;
    if Space>Remaining then begin
      Space := Remaining;
    end;
    p := OffsetPointer(fTop);
    Move( DataPtr^, P^, Space );
    NewPtr := OffsetPointer( DataPtr, Space ); // pointer for remaining data.
    dec(Remaining,Space);
    inc(fTop,Space);
    // If there is remaining data, it will fit between zero and fBottom
    if Remaining>0 then begin
      P := fBuffer.getDataPointer;
      Move( NewPtr^, P^, Remaining );
      fTop := Remaining;
    end;
  end else begin
    // fTop and fBottom are the same.
    SizeToWrite := fBuffer.Size;
    if SizeToWrite>Count then begin
      SizeToWrite := Count;
    end;
    P := OffsetPointer(fTop);
    Move( DataPtr^, P^, SizeToWrite );
    inc( fTop, SizeToWrite );
  end;
  Result := SizeToWrite;
end;

end.


