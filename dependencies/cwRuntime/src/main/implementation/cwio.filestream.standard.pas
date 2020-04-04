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
unit cwIO.FileStream.Standard;
{$ifdef fpc} {$mode delphiunicode} {$endif}

interface
uses
  Classes //[RTL]
, cwIO
, cwIO.UnicodeStream.Custom
;

type
  TFileStream = class( TCustomUnicodeStream, IStream, IUnicodeStream )
  private
    fFilePath: string;
    fSysFileStream: classes.TFileStream;
  protected
    procedure Clear; override;
    function Read( const p: pointer; const Count: nativeuint ): nativeuint; override;
    function Write( const p: pointer; const Count: nativeuint ): nativeuint; override;
    function getSize: nativeuint; override;
    function getPosition: nativeuint; override;
    procedure setPosition( const newPosition: nativeuint ); override;
  public
    constructor Create( const Filepath: string; const ReadOnly: boolean ); reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  sysutils //[RTL]
, cwTypes
;

procedure TFileStream.Clear;
begin
  {$ifdef fpc}
  fSysFileStream.Free;
  {$else}
  fSysFileStream.DisposeOf;
  {$endif}
  fSysFileStream := nil;
  if FileExists(fFilePath) then begin
    DeleteFile(fFilePath);
  end;
  fSysFileStream := classes.TFileStream.Create(fFilePath{$ifdef fpc}.AsAnsiString{$endif},fmCreate);
end;

constructor TFileStream.Create( const Filepath: string; const ReadOnly: boolean );
begin
  inherited Create;
  fFilepath := FilePath;
  if ReadOnly then begin
    fSysFileStream := classes.TFileStream.Create(fFilepath{$ifdef fpc}.AsAnsiString{$endif},fmOpenRead);
  end else begin
    if FileExists(FilePath) then begin
      fSysFileStream := classes.TFileStream.Create(fFilepath{$ifdef fpc}.AsAnsiString{$endif},fmOpenReadWrite);
    end else begin
      fSysFileStream := classes.TFileStream.Create(fFilepath{$ifdef fpc}.AsAnsiString{$endif},fmCreate);
    end;
  end;
end;

destructor TFileStream.Destroy;
begin
  {$ifdef fpc}
  fSysFileStream.Free;
  {$else}
  fSysFileStream.DisposeOf;
  {$endif}
  inherited;
end;

function TFileStream.getPosition: nativeuint;
begin
  Result := fSysFileStream.Position;
end;

function TFileStream.getSize: nativeuint;
begin
  Result := fSysFileStream.Size;
end;

function TFileStream.Read(const p: pointer; const Count: nativeuint): nativeuint;
begin
  Result := fSysfileStream.Read(p^,Count);
end;

procedure TFileStream.setPosition(const newPosition: nativeuint);
begin
  fSysFileStream.Position := newPosition;
end;

function TFileStream.Write(const p: pointer; const Count: nativeuint): nativeuint;
begin
  Result := fSysFileStream.Write(p^,Count);
end;

end.
