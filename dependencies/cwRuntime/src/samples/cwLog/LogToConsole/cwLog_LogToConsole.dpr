{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )
  All Rights Reserved.
*)
{$endif}
program cwLog_LogToConsole;
uses
  cwLog,
  cwLog.Standard,
  cwLog.Targets,
  cwLog.Console;

resourcestring
  le_test = '{A4ABC7F4-599E-4621-AE2A-5AC90F05A1CB} This is a test entry.';
  le_testWithParam = '{62576856-C1CF-450A-9A65-1A48F0F442E8} This is a test entry with a parameter (%param%).';

begin
  Log.AddLogTarget( TLogTarget.Console );
  Log.Insert(le_test,lsError);
  Log.Insert(le_testWithParam,lsError,['value']);
  Readln;
end.

