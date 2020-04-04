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
/// <exclude/>
unit cwTest.TestCase.Console;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwTest
;

type
 TStandardConsoleReport = class( TInterfacedObject, ITestReport )
 private
   fCurrentTestSuite: string;
   fCurrentTestCase: string;
   fCurrentDepth: nativeuint;
 private
   procedure WriteDepth;
 strict private //- ITestReport -//
   procedure BeginTestSuite( const TestSuite: string );
   procedure EndTestSuite;
   procedure BeginTestCase( const TestCase: string );
   procedure EndTestCase;
   procedure RecordTestResult( const TestName: string; const TestResultState: TTestResult; const Reason: string );
 public
   constructor Create; reintroduce;
 end;

implementation

procedure TStandardConsoleReport.BeginTestCase(const TestCase: string);
begin
  fCurrentTestCase := TestCase;
  WriteDepth;
  Writeln('<TestCase name="',fCurrentTestCase,'">');
  inc(fCurrentDepth);
end;

procedure TStandardConsoleReport.BeginTestSuite(const TestSuite: string);
begin
  fCurrentTestSuite := TestSuite;
  fCurrentTestCase := '';
  WriteDepth;
  Writeln('<TestSuite name="',fCurrentTestSuite,'">');
  inc(fCurrentDepth);
end;

constructor TStandardConsoleReport.Create;
begin
  inherited Create;
  fCurrentTestCase := '';
  fCurrentTestSuite := '';
  fCurrentDepth := 0;
end;

procedure TStandardConsoleReport.EndTestCase;
begin
  WriteDepth;
  Writeln('<TestCase/>');
  fCurrentTestCase := '';
  dec(fCurrentDepth);
end;

procedure TStandardConsoleReport.EndTestSuite;
begin
  WriteDepth;
  Writeln('<TestSuite/>');
  fCurrentTestSuite := '';
  fCurrentTestCase := '';
  dec(fCurrentDepth);
end;

procedure TStandardConsoleReport.RecordTestResult(const TestName: string; const TestResultState: TTestResult; const Reason: string);
var
  TestResultStr: string;
begin
  case TestResultState of
    trSucceeded: TestResultStr := 'SUCCESS';
       trFailed: TestResultStr := 'FAILED';
        trError: TestResultStr := 'ERROR';
        else begin
          TestResultStr := '';
        end;
  end;
  WriteDepth;
  if TestResultState<>trSucceeded then begin
    Writeln('<Test name="',TestName,'" Result="',TestResultStr,'" Reason="'+Reason+'"/>');
  end else begin
    Writeln('<Test name="',TestName,'" Result="',TestResultStr,'"/>');
  end;
end;

procedure TStandardConsoleReport.WriteDepth;
var
  idx: nativeuint;
begin
  if fCurrentDepth=0 then begin
    exit;
  end;
  for idx := 0 to pred(fCurrentDepth) do begin
    Write(chr($09));
  end;
end;

end.
