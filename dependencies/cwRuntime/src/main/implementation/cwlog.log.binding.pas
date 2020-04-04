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
unit cwLog.Log.Binding;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwLog
, cwDynLib
;

type
  TProxyLogMethod = procedure( const _Obj: pointer; const LogEntry: TGUID; const lpszTranslatedText: pointer; const TS: TDateTime; const Severity: TLogSeverity; const lpszParameters: pointer ); {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

type
  TLogBinding = record
    DynLib: IDynLib;
    //- Binds
    getVersionMajor: function: nativeuint; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}
    getVersionMinor: function: nativeuint; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}
    RegisterLogEntry: function( const lpszEntryString: pointer ): TStatus; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}
    InsertLogEntryByString: function( const lpszLogEntry: pointer; const Severity: TLogSeverity; const Parameters: pointer ): TStatus; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}
    getLastEntry: function( const lpszBuffer: pointer; out szBuffer: nativeuint ): TStatus; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}
    AddProxyLogTarget: function( const Obj: pointer; const Method: TProxyLogMethod ): TStatus; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}
    //- factory
    class function Create( out LogBinding: TLogBinding ): TStatus; static;
  end;

type
  TProxyLogTarget = class( TInterfacedObject, IInterface )
  private
    fProxyLogTarget: ILogTarget;
    fLogBinding: TLogBinding;
  public
    procedure Insert( const LogEntry: TGUID; const lpszTranslatedText: pointer; const TS: TDateTime; const Severity: TLogSeverity; const lpszParameters: pointer );
  public
    constructor Create(const LogTarget: ILogTarget; const LogBinding: TLogBinding); reintroduce;
  end;

implementation
uses
  cwTypes
, cwUnicode.Standard
, cwDynLib.Standard
;

{$region ' Shared object library filename (used when using dynamic binding)'}
const
  {$ifdef MSWINDOWS}
   cLibName = 'lib_cwLog.dll';
  {$else}
    {$ifdef MACOS}
      cLibName = 'lib_cwLog.dynlib';
    {$else}
      cLibName = 'lib_cwLog.so';
    {$endif}
  {$endif}
{$endregion}

procedure ProxyMethod( const _Obj: pointer; const LogEntry: TGUID; const lpszTranslatedText: pointer; const TS: TDateTime; const Severity: TLogSeverity; const lpszParameters: pointer ); {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}
begin
  TProxyLogTarget(_Obj).Insert( LogEntry, lpszTranslatedText, TS, Severity, lpszParameters );
end;

class function TLogBinding.Create(out LogBinding: TLogBinding): TStatus;
  function GetProcAddress( var DynLib: IDynLib; const MethodName: string; var MethodPtr: pointer ): boolean;
  begin
    Result := False;
    if not DynLib.GetProcAddress(MethodName,MethodPtr) then begin
      DynLib := nil;
      MethodPtr := nil;
      exit;
    end;
    Result := True;
  end;
begin
  Result := TStatus.Unknown;
  LogBinding.DynLib := TDynLib.Create;
  if not LogBinding.DynLib.LoadLibrary(cLibName) then begin
    LogBinding.DynLib := nil;
    exit;
  end;
  if not GetProcAddress( LogBinding.DynLib, 'getVersionMajor',        @LogBinding.getVersionMajor )        then exit;
  if not GetProcAddress( LogBinding.DynLib, 'getVersionMinor',        @LogBinding.getVersionMinor )        then exit;
  if not GetProcAddress( LogBinding.DynLib, 'RegisterLogEntry',       @LogBinding.RegisterLogEntry )       then exit;
  if not GetProcAddress( LogBinding.DynLib, 'InsertLogEntryByString', @LogBinding.InsertLogEntryByString ) then exit;
  if not GetProcAddress( LogBinding.DynLib, 'getLastEntry',           @LogBinding.getLastEntry )           then exit;
  if not GetProcAddress( LogBinding.DynLib, 'AddProxyLogTarget',      @LogBinding.AddProxyLogTarget )      then exit;
  Result := TStatus.Success;
end;

procedure TProxyLogTarget.Insert(const LogEntry: TGUID; const lpszTranslatedText: pointer; const TS: TDateTime; const Severity: TLogSeverity; const lpszParameters: pointer);
var
  TextUTF: TUnicodeString;
  ParamUTF: TUnicodeString;
  ParamStr: string;
  Parameters: TArrayOfString;
begin
  TextUTF.AsPtr := lpszTranslatedText;
  ParamUTF.AsPtr := lpszParameters;
  ParamStr := ParamUTF.AsString;
  Parameters := ParamStr.Explode(LF);
  fProxyLogTarget.Insert(LogEntry,TextUTF.AsString,TS,Severity,Parameters);
end;

constructor TProxyLogTarget.Create(const LogTarget: ILogTarget; const LogBinding: TLogBinding);
begin
  inherited Create;
  fProxyLogTarget := LogTarget;
  fLogBinding := LogBinding;
  fLogBinding.AddProxyLogTarget(Self,@ProxyMethod);
end;


end.

