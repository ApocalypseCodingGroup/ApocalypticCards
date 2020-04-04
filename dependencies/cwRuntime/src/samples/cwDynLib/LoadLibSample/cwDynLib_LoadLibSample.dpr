{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )
  All Rights Reserved.
*)
{$endif}
/// <summary>
///   Sample application to demonstrate loading a dynamic library with cwDynLib.
/// </summary>
program cwDynLib_LoadLibSample;
uses
  cwDynLib,
  cwDynLib.Standard;

{$ifdef fpc}
  {$mode delphiunicode}
{$else}
  {$APPTYPE CONSOLE}
  {$R *.res}
{$endif}

const
  {$ifdef MSWINDOWS}
  cLibName = 'lib_testLoadLib.dll';
  {$else}
  {$ifdef MACOS}
  {$else}
  cLibName = 'lib_testLoadLib.so';
  {$endif}
  {$endif}

var
  DynLib: IDynLib;
  Add: function ( const A: nativeuint; const B: nativeuint ): nativeuint; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif}

begin
  DynLib := TDynLib.Create;
  try
    if not DynLib.LoadLibrary( cLibName ) then begin
      Writeln('Failed to load library');
      exit;
    end;
    if not DynLib.GetProcAddress('Add',pointer(@Add)) then begin
      Writeln('Failed to load ''Add'' entry point');
      exit;
    end;
    Writeln( Add(5,2) , ' should = 7' );
  finally
    DynLib := nil;
    Readln;
  end;
end.

