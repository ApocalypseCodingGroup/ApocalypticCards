{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )

  Redistribution and use in source and binary forms, with or without modification,
  are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice,
     this list of conditions and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation and/or
     other materials provided with the distribution.

  3. Neither the name of the copyright holder nor the names of its contributors may be
     used to endorse or promote products derived from this software without specific prior
     written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
  IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)
{$endif}
unit test_cwlog.inserts.dynamic;
{$ifdef fpc}{$mode delphiunicode}{$endif}
{$M+}

interface
uses
  cwTest
;

type
  TTest_cwLog_Insert = class( TTestCase )
  private
  published

    //- Tests that a log entry is inserted with 'info' level severity.
    procedure Test_InsertLogEntry_Info;

    //- Tests that a log entry is inserted with 'hint' level severity.
    procedure Test_InsertLogEntry_Hint;

    //- Tests that a log entry is inserted with 'warning' level severity.
    procedure Test_InsertLogEntry_Warning;

    //- Tests that a log entry is inserted with 'error' level severity.
    procedure Test_InsertLogEntry_Error;

    //- Tests that a log entry is inserted with 'fata' level severity, and that an exception is
    //- raised to reflect the fatal severity level.
    procedure Test_InsertLogEntry_Fatal;

    //- Tests that many placeholders are correctly replaced in the log string when inserting
    //- an 'info' level severity entry. Also checks that placeholders need be provided only
    //- once, but that substitutions may be re-used in the entry.
    procedure Test_InsertLogEntry_Info_Substitution;

    //- Tests that many placeholders are correctly replaced in the log string when inserting
    //- an 'hint' level severity entry. Also checks that placeholders need be provided only
    //- once, but that substitutions may be re-used in the entry.
    procedure Test_InsertLogEntry_Hint_Substitution;

    //- Tests that many placeholders are correctly replaced in the log string when inserting
    //- an 'warning' level severity entry. Also checks that placeholders need be provided only
    //- once, but that substitutions may be re-used in the entry.
    procedure Test_InsertLogEntry_Warning_Substitution;

    //- Tests that many placeholders are correctly replaced in the log string when inserting
    //- an 'error' level severity entry. Also checks that placeholders need be provided only
    //- once, but that substitutions may be re-used in the entry.
    procedure Test_InsertLogEntry_Error_Substitution;

    //- Tests that many placeholders are correctly replaced in the log string when inserting
    //- an 'fatal' level severity entry. Also checks that placeholders need be provided only
    //- once, but that substitutions may be re-used in the entry. Also tests for exception
    //- being raised to reflect fatal severity.
    procedure Test_InsertLogEntry_Fatal_Substitution;
  end;

implementation
uses
  sysutils
, cwTest.Standard
, cwLog
, cwLog.Dynamic
;

resourcestring
  le_TestLogEntry = '{68D3D83C-4109-4EB5-AB8E-F5F9EDE5E540} This is a test log entry.';
  le_Alphabet = '{4CAC6378-7500-4BAB-B0C8-8F15BB051B1A} (%a%) (%b%) (%c%) (%d%) (%e%) (%f%) (%g%) (%h%) (%i%) (%j%) (%k%) (%l%) (%m%) (%n%) (%o%) (%p%) (%q%) (%r%) (%s%) (%t%) (%u%) (%v%) (%w%) (%x%) (%y%) (%z%) (%a%) (%b%) (%c%).';

const
  cle_TestLogEntryGUID = '{68D3D83C-4109-4EB5-AB8E-F5F9EDE5E540}';
  cle_TestLogEntryText = 'This is a test log entry.';
  cle_AlphabetGUID = '{4CAC6378-7500-4BAB-B0C8-8F15BB051B1A}';
  cle_AlphabetText = 'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z A B C.';


procedure TTest_cwLog_Insert.Test_InsertLogEntry_Info;
var
  R: TStatus;
begin
  // Act
  R := Log.Insert(le_TestLogEntry,lsInfo);
  // Assert
  TTest.Expect( cle_TestLogEntryGUID, string(GUIDToString(R.Value)) );
  TTest.Expect( '[INFO] '+cle_TestLogEntryText, Log.getLastEntry );
end;

procedure TTest_cwLog_Insert.Test_InsertLogEntry_Hint;
var
  R: TStatus;
begin
  // Act
  R := Log.Insert(le_TestLogEntry,lsHint);
  // Assert
  TTest.Expect( cle_TestLogEntryGUID, string(GUIDToString(R.Value)) );
  TTest.Expect( '[HINT] '+cle_TestLogEntryText, Log.getLastEntry );
end;

procedure TTest_cwLog_Insert.Test_InsertLogEntry_Warning;
var
  R: TStatus;
begin
  // Act
  R := Log.Insert(le_TestLogEntry,lsWarning);
  // Assert
  TTest.Expect( cle_TestLogEntryGUID, string(GUIDToString(R.Value)) );
  TTest.Expect( '[WARNING] '+cle_TestLogEntryText, Log.getLastEntry );
end;

procedure TTest_cwLog_Insert.Test_InsertLogEntry_Error;
var
  R: TStatus;
begin
  // Act
  R := Log.Insert(le_TestLogEntry,lsError);
  // Assert
  TTest.Expect( cle_TestLogEntryGUID, string(GUIDToString(R.Value)) );
  TTest.Expect( '[ERROR] '+cle_TestLogEntryText, Log.getLastEntry );
end;

procedure TTest_cwLog_Insert.Test_InsertLogEntry_Fatal;
var
  R: TStatus;
begin
  // Act
  R := Log.Insert(le_TestLogEntry,lsFatal);
  // Assert
  TTest.Expect( cle_TestLogEntryGUID, string(GUIDToString(R.Value)) );
  TTest.Expect( '[FATAL] '+cle_TestLogEntryText, Log.getLastEntry );
end;

procedure TTest_cwLog_Insert.Test_InsertLogEntry_Info_Substitution;
var
  R: TStatus;
begin
  // Act
  R := Log.Insert(le_Alphabet,lsInfo,['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']);
  // Assert
  TTest.Expect( cle_AlphabetGUID, string(GUIDToString(R.Value)) );
  TTest.Expect( '[INFO] '+cle_AlphabetText, Log.getLastEntry );
end;

procedure TTest_cwLog_Insert.Test_InsertLogEntry_Hint_Substitution;
var
  R: TStatus;
begin
  // Act
  R := Log.Insert(le_Alphabet,lsHint,['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']);
  // Assert
  TTest.Expect( cle_AlphabetGUID, string(GUIDToString(R.Value)) );
  TTest.Expect( '[HINT] '+cle_AlphabetText, Log.getLastEntry );
end;

procedure TTest_cwLog_Insert.Test_InsertLogEntry_Warning_Substitution;
var
  R: TStatus;
begin
  // Act
  R := Log.Insert(le_Alphabet,lsWarning,['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']);
  // Assert
  TTest.Expect( cle_AlphabetGUID, string(GUIDToString(R.Value)) );
  TTest.Expect( '[WARNING] '+cle_AlphabetText, Log.getLastEntry );
end;

procedure TTest_cwLog_Insert.Test_InsertLogEntry_Error_Substitution;
var
  R: TStatus;
begin
  // Act
  R := Log.Insert(le_Alphabet,lsError,['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']);
  // Assert
  TTest.Expect( cle_AlphabetGUID, string(GUIDToString(R.Value)) );
  TTest.Expect( '[ERROR] '+cle_AlphabetText, Log.getLastEntry );
end;

procedure TTest_cwLog_Insert.Test_InsertLogEntry_Fatal_Substitution;
var
  R: TStatus;
begin
  // Act
  R := Log.Insert(le_Alphabet,lsFatal,['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']);
  // Assert
  TTest.Expect( cle_AlphabetGUID, string(GUIDToString(R.Value)) );
  TTest.Expect( '[FATAL] '+cle_AlphabetText, Log.getLastEntry );
end;

initialization
  TestSuite.RegisterTestCase( TTest_cwLog_Insert );

end.

