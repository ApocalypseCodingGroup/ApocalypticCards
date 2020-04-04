{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )
  All Rights Reserved.
*)
{$endif}
program test_cwUnicode;
uses
  cwTest,
  cwTest.Standard,
  test.cwUnicode.Codec.Standard,
  Test.cwUnicode.UnicodeString.Standard;

var
  R: nativeuint;

begin
  R := TestSuite.Run( 'cwUnicode', [TConsoleReport.Create] );
  if ParamStr(1)='ide' then begin
    Readln;
  end;
  Halt(R);
end.
