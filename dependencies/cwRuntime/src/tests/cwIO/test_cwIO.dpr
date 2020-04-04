{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )
  All Rights Reserved.
*)
{$endif}
program test_cwIO;
uses
  cwTest
, cwTest.Standard
;

var
  R: nativeuint;

begin
  R := TestSuite.Run( 'cwIO', [TConsoleReport.Create] );
  if ParamStr(1)='ide' then begin
    Readln;
  end;
  Halt(R);
end.
