{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )
  All Rights Reserved.
*)
{$endif}
program test_static_cwLog;
uses
  cwTest,
  cwTest.Standard,
  test_cwlog.inserts.static;

var
  R: nativeuint;

begin
  R := TestSuite.Run( 'cwLog_Static', [TConsoleReport.Create] );
  if ParamStr(1)='ide' then begin
    Readln;
  end;
  Halt(R);
end.
