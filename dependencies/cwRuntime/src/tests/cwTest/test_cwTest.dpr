{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )
  All Rights Reserved.
*)
{$endif}
program test_cwTest;
uses
  cwTest,
  cwTest.Standard,
  test_cwtest.sampletest;

var
  R: nativeuint;

begin
  R := TestSuite.Run( 'cwTest', [TConsoleReport.Create] );
  if ParamStr(1)='ide' then begin
    Readln;
  end;
  Halt(R);
end.
