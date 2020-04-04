{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )
  All Rights Reserved.
*)
{$endif}
unit lib_cwLog.ProxyLogTarget;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwLog
;

type
  TProxyLogMethod = procedure( const _Obj: pointer; const LogEntry: TGUID; const lpszTranslatedText: pointer; const TS: TDateTime; const Severity: TLogSeverity; const lpszParameters: pointer ); {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

  TProxyLogTarget = class( TInterfacedObject, ILogTarget )
  private
    fObj: pointer;
    fMethod: TProxyLogMethod;
  strict private //- ILogTarget -//
    procedure Insert( const LogEntry: TGUID; const TranslatedText: string; const TS: TDateTime; const Severity: TLogSeverity; const Parameters: array of string );
  public
    constructor Create( const Method: TProxyLogMethod; const _obj: pointer ); reintroduce;
  end;

implementation
uses
  cwTypes
, cwUnicode
, cwUnicode.Standard
;

procedure TProxyLogTarget.Insert(const LogEntry: TGUID; const TranslatedText: string; const TS: TDateTime; const Severity: TLogSeverity; const Parameters: array of string);
var
  ParamArray: TArrayOfString;
  ParamStr: string;
  ParamUTF: TUnicodeString;
  TextUTF: TUnicodeString;
begin
  ParamArray.AssignArray(Parameters);
  ParamStr.Combine(LF,ParamArray);
  ParamUTF := ParamStr;
  TextUTF := TranslatedText;
  fMethod(fObj,LogEntry,TextUTF.AsPtr,TS,Severity,ParamUTF.AsPtr);
end;

constructor TProxyLogTarget.Create(const Method: TProxyLogMethod; const _obj: pointer);
begin
  inherited Create;
  fObj := _obj;
  fMethod := Method;
end;

end.

