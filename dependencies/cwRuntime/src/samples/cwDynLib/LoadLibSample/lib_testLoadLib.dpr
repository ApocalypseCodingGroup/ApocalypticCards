{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )
  All Rights Reserved.
*)
{$endif}
/// <summary>
///   Sample library for testing cwDynlib.
/// </summary>
library lib_testLoadLib;
{$ifdef fpc}
  {$mode delphiunicode}
{$else}
   {$R *.res}
{$endif}

function Add( const A: nativeuint; const B: nativeuint ): nativeuint; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} export;
begin
  Result := A + B;
end;

exports
  Add;

begin
end.

