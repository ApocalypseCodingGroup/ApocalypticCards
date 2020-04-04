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
unit cwThreading.Criticalsection.Windows;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
{$ifdef MSWINDOWS}
uses
  cwWin32.Types,
  cwThreading;

type
  TWindowsCriticalSection = class( TInterfacedObject, ICriticalSection )
  private
    fMutex: TSRWLOCK;
  strict private //- ICriticalSection -//
    procedure Acquire;
    procedure Release;
  public
    constructor Create; reintroduce;
  end;

{$endif}
implementation
{$ifdef MSWINDOWS}
uses
  cwWin32.Kernel32;

{ TWindowsCriticalSection }

procedure TWindowsCriticalSection.Acquire;
begin
  AcquireSRWLockExclusive(fMutex);
end;

constructor TWindowsCriticalSection.Create;
begin
  inherited Create;
  InitializeSRWLock(fMutex);
end;

procedure TWindowsCriticalSection.Release;
begin
  ReleaseSRWLockExclusive(fMutex);
end;

{$endif}
end.
