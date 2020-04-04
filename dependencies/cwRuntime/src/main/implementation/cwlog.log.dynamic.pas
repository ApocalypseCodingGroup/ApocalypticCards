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
unit cwlog.log.dynamic;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwLog
, cwTypes
, cwCollections
, cwLog.Log.Binding
;

type
  TLog = class( TInterfacedObject, ILog )
  private
    fLogBinding: TLogBinding;
    fProxyLogTargets: IList<IInterface>;
  strict private //- ILog -//
    function RegisterLogEntry( const EntryString: string ): boolean;
    procedure AddLogTarget( const LogTarget: ILogTarget );
    function ExportTranslationFile( const FilePath: string ): TStatus;
    function ImportTranslationFile( const FilePath: string ): TStatus;
    function Insert( const LogEntry: AnsiString; const Severity: TLogSeverity ): TStatus; overload;
    function Insert( const LogEntry: AnsiString; const Severity: TLogSeverity; const Parameters: array of string ): TStatus; overload;
    function Insert( const LogEntry: string; const Severity: TLogSeverity; const Parameters: array of string ): TStatus; overload;
    function Insert( const LogEntry: string; const Severity: TLogSeverity ): TStatus; overload;
    function getLastEntry: string;
  public
    constructor Create( const LogBinding: TLogBinding ); reintroduce;
    destructor Destroy; override;
  end;

function Log: ILog;

implementation
uses
  cwUnicode.Standard
, cwCollections.Standard
;

var
  SingletonLog: ILog = nil;

function Log: ILog;
var
  LogBinding: TLogBinding;
begin
  if not assigned(SingletonLog) then begin
    if not TLogBinding.Create( LogBinding ).IsSuccess then begin
      Result := nil;
      exit;
    end;
    SingletonLog := TLog.Create(LogBinding);
  end;
  Result := SingletonLog;
end;

function TLog.RegisterLogEntry(const EntryString: string): boolean;
var
  Str: TUnicodeString;
begin
  Result := False;
  Str.AsString := EntryString;
  if not fLogBinding.RegisterLogEntry( Str.AsPtr ).IsSuccess then begin
    exit;
  end;
  Result := True;
end;

procedure TLog.AddLogTarget(const LogTarget: ILogTarget);
begin
  fProxyLogTargets.Add( TProxyLogTarget.Create( LogTarget, fLogBinding ) );
end;

function TLog.ExportTranslationFile(const FilePath: string): TStatus;
begin
  //-
end;

function TLog.ImportTranslationFile(const FilePath: string): TStatus;
begin
  //-
end;

function TLog.Insert(const LogEntry: AnsiString; const Severity: TLogSeverity): TStatus;
var
  Str: TUnicodeString;
begin
  Str.AsString := LogEntry.AsString;
  Result := fLogBinding.InsertLogEntryByString(Str.AsPtr,Severity,nil);
end;

function TLog.Insert(const LogEntry: AnsiString; const Severity: TLogSeverity; const Parameters: array of string): TStatus;
var
  Str: TUnicodeString;
  ParamStr: TUnicodeString;
  ParamArray: TArrayOfString;
  StrParameters: string;
begin
  Str.AsString := LogEntry.AsString;
  {$warnings off} ParamArray.AssignArray(Parameters); {$warnings on}
  StrParameters.Combine(LF,ParamArray);
  ParamStr.AsString := StrParameters;
  Result := fLogBinding.InsertLogEntryByString(Str.AsPtr,Severity,ParamStr.AsPtr);
end;

function TLog.Insert(const LogEntry: string; const Severity: TLogSeverity; const Parameters: array of string): TStatus;
var
  Str: TUnicodeString;
  ParamStr: TUnicodeString;
  ParamArray: TArrayOfString;
begin
  Str.AsString := LogEntry;
  {$warnings off} ParamArray.AssignArray(Parameters); {$warnings on}
  ParamStr.AsString.Combine(LF,ParamArray);
  Result := fLogBinding.InsertLogEntryByString(Str.AsPtr,Severity,ParamStr.AsPtr);
end;

function TLog.Insert(const LogEntry: string; const Severity: TLogSeverity): TStatus;
var
  Str: TUnicodeString;
begin
  Str.AsString := LogEntry;
  Result := fLogBinding.InsertLogEntryByString(Str.AsPtr,Severity,nil);
end;

function TLog.getLastEntry: string;
var
  Buffer: array of uint8;
  Size: nativeuint;
  Str: TUnicodeString;
begin
  Result := '';
  if not fLogBinding.getLastEntry(nil,Size).IsSuccess then begin
    exit;
  end;
  {$hints off} SetLength(Buffer,Size); {$hints on}
  try
    if not fLogBinding.getLastEntry(@Buffer[0],Size).IsSuccess then begin
      exit;
    end;
    Str.AsPtr := @Buffer[0];
    Result := Str.AsString;
  finally
    SetLength(Buffer,0);
  end;
end;

constructor TLog.Create( const LogBinding: TLogBinding );
begin
  inherited Create;
  fProxyLogTargets := TList<IInterface>.Create;
  fLogBinding := LogBinding;
end;

destructor TLog.Destroy;
begin
  fProxyLogTargets := nil;
  inherited Destroy;
end;

{$endregion}

{$ifdef fpc}
{$hints off}
function IterateResourceStrings( Name, Value: AnsiString; Hash: Longint; arg: pointer ): AnsiString;
var
  ValueStr: string;
begin
  Result := Value;
  if not assigned(SingletonLog) then begin
    Log();
  end;
  if not assigned(SingletonLog) then begin
    exit;
  end;
  ValueStr := string(Value);
  SingletonLog.RegisterLogEntry(ValueStr);
end;
{$hints on}
{$endif}

initialization
  {$ifdef fpc}SetResourceStrings(IterateResourceStrings,nil);{$endif}

finalization
  SingletonLog := nil;

end.

