{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )
  All Rights Reserved.
*)
{$endif}
/// <summary>
///   Chapmanworld Logging system library.
/// </summary>
library lib_cwLog;
{$ifdef fpc}{$mode delphiunicode}{$endif}
uses
  sysutils //[RTL] for exception
, cwLog
, cwlog.log.static
, cwUnicode
, cwUnicode.Standard
, cwTypes
, lib_cwLog.ProxyLogTarget
;

const
  cVersionMajor = 1;
  cVersionMinor = 0;

function getVersionMajor: nativeuint; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} export;
begin
  Result := cVersionMajor;
end;

function getVersionMinor: nativeuint; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} export;
begin
  Result := cVersionMinor;
end;

function RegisterLogEntry( const lpszEntryString: pointer ): TStatus; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} export;
var
  Str: TUnicodeString;
begin
  Result := TStatus.Unknown;
  try
    Str.AsPtr := lpszEntryString;
    Log.RegisterLogEntry(Str.AsString);
  except
    on E: Exception do begin
      exit;
    end;
    else exit;
  end;
  Result := TStatus.Success;
end;

function InsertLogEntryByString( const lpszLogEntry: pointer; const Severity: TLogSeverity; const lpszParameters: pointer ): TStatus; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} export;
var
  Str: TUnicodeString;
  ParamStr: TUnicodeString;
  Params: TArrayOfString;
begin
  Result := TStatus.Unknown;
  try
    Str.AsPtr := lpszLogEntry;
    ParamStr.AsPtr := lpszParameters;
    Params := ParamStr.AsString.Explode(LF);
    Result := Log.Insert(Str.AsString,Severity,Params);
  except
    on E: Exception do begin
      exit;
    end;
    else exit;
  end;
end;

function getLastEntry( const lpszBuffer: pointer; out szBuffer: nativeuint ): TStatus; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} export;
var
  Str: TUnicodeString;
begin
  Result := TStatus.Unknown;
  try
    Str.AsString := Log.getLastEntry;
    szBuffer := Str.Size;
    if not assigned(lpszBuffer) then begin
      Result := TStatus.Success;
      exit;
    end;
    Move( Str.AsPtr^, lpszBuffer^, szBuffer );
  except
    on E: Exception do begin
      exit;
    end;
    else exit;
  end;
  Result := TStatus.Success;
end;

/// Adds a proxy log target to the actual log.
/// When the proxy log target .Insert() method is called, it forwards
/// the log message to the provided Method.
function AddProxyLogTarget( const Obj: pointer; const Method: TProxyLogMethod ): TStatus; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} export;
begin
  Result := TStatus.Unknown;
  try
    Log.AddLogTarget(TProxyLogTarget.Create(Method,Obj));
  except
    on E: Exception do begin
      exit;
    end;
    else exit;
  end;
  Result := TStatus.Success;
end;

exports
  getVersionMajor
, getVersionMinor
, RegisterLogEntry
, InsertLogEntryByString
, getLastEntry
, AddProxyLogTarget
;

begin
end.
