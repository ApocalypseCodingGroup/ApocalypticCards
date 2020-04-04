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
unit cwIO.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwIO
;

type
  ///  <summary>
  ///    Factory record to create instances of IStream / IUnicodeStream in memory.
  ///  </summary>
  TMemoryStream = record
    class function Create( const BufferGranularity: uint64 = 0 ): IUnicodeStream; static;
  end;

  ///  <summary>
  ///    Factory record to create instances of IStream / IUnicodeStream to disk file.
  ///  </summary>
  TFileStream = record
    class function Create( const Filepath: string; const ReadOnly: boolean ): IUnicodeStream; static;
  end;

  ///  <summary>
  ///    Factory record to create instances of ICyclicBuffer in memory.
  ///  </summary>
  TCyclicBuffer = record
    class function Create( const Size: uint64 = 0 ): ICyclicBuffer; static;
  end;

  ///  <summary>
  ///    Factory record to create instances of IBuffer / IUnicodeBuffer in memory.
  ///  </summary>
  TBuffer = record
    class function Create( const aSize: uint64 = 0; const Align16: boolean = FALSE ): IUnicodeBuffer; static;
  end;


implementation
uses
  cwIO.MemoryStream.Standard
, cwIO.FileStream.Standard
, cwIO.CyclicBuffer.Standard
, cwIO.Buffer.Standard
;

class function TFileStream.Create(const Filepath: string; const ReadOnly: boolean): IUnicodeStream;
begin
  Result := cwIO.FileStream.Standard.TFileStream.Create( Filepath, ReadOnly );
end;

class function TCyclicBuffer.Create(const Size: uint64): ICyclicBuffer;
begin
  Result := cwIO.CyclicBuffer.Standard.TCyclicBuffer.Create( Size );
end;

class function TBuffer.Create(const aSize: uint64; const Align16: boolean = FALSE ): IUnicodeBuffer;
begin
  Result := cwIO.Buffer.Standard.TBuffer.Create( aSize, Align16 );
end;

class function TMemoryStream.Create(const BufferGranularity: uint64): IUnicodeStream;
begin
  Result := cwIO.MemoryStream.Standard.TMemoryStream.Create(BufferGranularity);
end;

end.

