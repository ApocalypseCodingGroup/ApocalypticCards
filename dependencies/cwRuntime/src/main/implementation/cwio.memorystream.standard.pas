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
unit cwIO.MemoryStream.Standard;
{$ifdef fpc} {$mode delphiunicode} {$endif}

interface
uses
  cwIO
, cwIO.UnicodeStream.Custom
;

type
  TMemoryStream = class( TCustomUnicodeStream, IStream, IUnicodeStream )
  private
    fBuffer: IUnicodeBuffer;
    fGranularity: nativeuint;
    fSize: nativeuint;
    fPosition: nativeuint;
  protected
    function getPosition: nativeuint; override;
    procedure setPosition( const newPosition: nativeuint ); override;
    function getSize: nativeuint; override;
    function Read( const p: pointer; const Count: nativeuint ): nativeuint; override;
    function Write( const p: pointer; const Count: nativeuint ): nativeuint; override;
    procedure Clear; override;
  public

    /// <summary>
    ///   The constructor accepts a granularity parameter, which sets the
    ///   granularity with which memory is allocated on the buffer. For
    ///   example, with a granularity of 512 (the default) when writing to the
    ///   stream, should the memory buffer become full, an additional 512 bytes
    ///   will be allocated.
    /// </summary>
    /// <param name="BufferGranularity">
    ///   sOptional parameter, The allocation granularity of the memory buffer,
    ///   in bytes.
    /// </param>
    constructor Create(const BufferGranularity: nativeuint = 0 ); reintroduce;
    destructor Destroy; override;

  public
    property EndOfStream;
    property Position;
    property Size;
  end;

implementation
uses
  cwIO.Buffer.Standard
;

const
  cDefaultGranularity = 256; //- One quater kilobyte!

procedure TMemoryStream.Clear;
begin
  fBuffer.Size := fGranularity;
  fSize := 0;
  fPosition := 0;
end;

constructor TMemoryStream.Create(const BufferGranularity: nativeuint);
begin
  inherited Create;
  fBuffer := TBuffer.Create();
  if BufferGranularity>0 then begin
    fGranularity := BufferGranularity;
  end else begin
    fGranularity := cDefaultGranularity;
  end;
  //- Clear buffer
  Clear;
end;

destructor TMemoryStream.Destroy;
begin
  fBuffer := nil;
  inherited Destroy;
end;

function TMemoryStream.getPosition: nativeuint;
begin
  Result := fPosition;
end;

function TMemoryStream.getSize: nativeuint;
begin
  Result := fSize;
end;

function TMemoryStream.Read(const p: pointer; const Count: nativeuint): nativeuint;
var
  ActualBytesToRead: nativeuint;
begin
  ActualBytesToRead := Count;
  if ActualBytesToRead > Size-Position then begin
    ActualBytesToRead := Size-Position;
  end;
  if ActualBytesToRead<=0 then begin
    Result := 0;
    Exit;
  end;
  fBuffer.ExtractData(P,Position,ActualBytesToRead);
  fPosition := fPosition + ActualBytesToRead;
  Result := ActualBytesToRead;
end;

procedure TMemoryStream.setPosition(const newPosition: nativeuint);
begin
  if newPosition<fSize then begin
    fPosition := NewPosition;
  end else begin
    fPosition := fSize;
  end;
end;

function TMemoryStream.Write(const p: pointer; const Count: nativeuint): nativeuint;
begin
  //- If the buffer is not big enough to add this data.
  while (Count>fBuffer.Size-Position) do begin
    fBuffer.Size := fBuffer.Size + fGranularity;
  end;
  fBuffer.InsertData(p,position,count);
  if (Position+Count)>fSize then begin
    fSize := fSize + ((Position+Count)-fSize);
  end;
  fPosition := fPosition + Count;
  Result := Count;
end;

end.


