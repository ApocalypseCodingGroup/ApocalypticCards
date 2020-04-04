{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )
  All Rights Reserved.
*)
{$endif}
program test_cwCollections;
uses
  cwTest
, cwTest.Standard
, test_cwCollections.RingBuffer
, test_cwCollections.Stack
, test_cwCollections.Dictionary
, test_cwCollections.List
;

var
  R: nativeuint;

begin
  R := TestSuite.Run( 'cwCollections', [TConsoleReport.Create] );
  if ParamStr(1)='ide' then begin
    Readln;
  end;
  Halt(R);
end.
