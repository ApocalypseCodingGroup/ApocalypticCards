{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )
  All Rights Reserved.
*)
{$endif}
program test_dynamic_cwLog;
uses
  cwTest
, cwTest.Standard
, test_cwlog.inserts.dynamic
;

var
  R: nativeuint;

begin
  R := TestSuite.Run( 'cwLog_Dynamic', [TConsoleReport.Create] );
  if ParamStr(1)='ide' then begin
    Readln;
  end;
  Halt(R);
end.
