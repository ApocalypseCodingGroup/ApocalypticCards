{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )
  All Rights Reserved.
*)
{$endif}
program cwTest_SampleTests;
uses
  cwTest,
  cwTest.Standard,
  TestCase.SetupFails,
  TestCase.TearDownFails,
  TestCase.SampleTest;

{$ifdef fpc}
  {$mode delphiunicode}
{$else}
  {$APPTYPE CONSOLE}
  {$R *.res}
{$endif}

var
  R: nativeuint;
begin
  R := TestSuite.Run( 'Sample Tests', TConsoleReport.Create );
  if ParamStr(1)='ide' then begin
    Readln;
  end;
  Halt(R);
end.




