{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )
  All Rights Reserved.
*)
{$endif}
program test_cwTypes;
uses
  cwTest,
  cwTest.Standard,
  test_cwTypes.ExtendedHelper,
  test_cwTypes.DoubleHelper,
  test_cwTypes.DateTimeHelper,
  test_cwTypes.CharHelper,
  test_cwTypes.BooleanHelper,
  test_cwTypes.Uint64Helper,
  test_cwTypes.Uint32Helper,
  test_cwTypes.Uint16Helper,
  test_cwTypes.Uint8Helper,
  test_cwTypes.StringHelper,
  test_cwTypes.SingleHelper,
  test_cwTypes.PointerHelper,
  test_cwTypes.NativeUintHelper,
  test_cwTypes.Int64Helper,
  test_cwTypes.Int32Helper,
  test_cwTypes.Int16Helper,
  test_cwTypes.Int8Helper;

var
  R: nativeuint;

begin
  R := TestSuite.Run( 'cwUnicode', [TConsoleReport.Create] );
  if ParamStr(1)='ide' then begin
    Readln;
  end;
  Halt(R);
end.
