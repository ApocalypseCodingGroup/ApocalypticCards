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
unit cwtest.testsuite.custom;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwTest
;

type
  TArrayOfMethodName = array of string;
  TCustomTestSuite = class( TInterfacedObject, ITestSuite )
  private
    fRegisteredTestCases: array of TTestCaseClass;
    fTestCaseCount: nativeuint;
  private
    procedure ReportBeginTestSuite(const TestSuite: string; const TestReports: array of ITestReport);
    procedure ReportEndTestSuite(const TestReports: array of ITestReport);
    procedure ReportBeginTestCase(const TestCase: string; const TestReports: array of ITestReport);
    procedure ReportEndTestCase(const TestReports: array of ITestReport);
    procedure ReportTest(const Test: string; const TestResult: TTestResult; const Reason: string; const TestReports: array of ITestReport);
    function RunTest(const TestCaseClass: TTestCaseClass; const aMethodName: string; const WithSetup: boolean; const WithTearDown: boolean; out Reason: string ): TTestResult;
  protected //- ITestSuite -//
    procedure RegisterTestCase( const TestCase: TTestCaseClass );
    function Run( const SuiteName: string; const TestReports: array of ITestReport ): nativeuint;
  protected //- override -//
    function GetTestMethods( const TestCaseClass: TTestCaseClass; out HasSetup: boolean; out HasTearDown: boolean ): TArrayOfMethodName; virtual; abstract;
    function ExecuteTestMethod( const TestCaseClass: TTestCaseClass; const aMethodName: string; const WithSetup: boolean; const WithTeardown: boolean; out Reason: string ): TTestResult; virtual; abstract;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  sysutils
;

const
  cTestCaseGranularity = 32;

constructor TCustomTestSuite.Create;
begin
  inherited Create;
  fTestCaseCount := 0;
  SetLength(fRegisteredTestCases,cTestCaseGranularity)
end;

destructor TCustomTestSuite.Destroy;
begin
  SetLength(fRegisteredTestCases,0);
  inherited Destroy;
end;

procedure TCustomTestSuite.RegisterTestCase(const TestCase: TTestCaseClass);
begin
  if fTestCaseCount>=Length(fRegisteredTestCases) then begin
    SetLength(fRegisteredTestCases,Length(fRegisteredTestCases)+cTestCaseGranularity);
  end;
  fRegisteredTestCases[fTestCaseCount] := TestCase;
  inc(fTestCaseCount);
end;

procedure TCustomTestSuite.ReportBeginTestSuite( const TestSuite: string; const TestReports: array of ITestReport );
var
  idx: nativeuint;
begin
  if Length(TestReports)=0 then begin
    exit;
  end;
  for idx := 0 to pred(Length(TestReports)) do begin
    TestReports[idx].BeginTestSuite(TestSuite);
  end;
end;

procedure TCustomTestSuite.ReportEndTestSuite( const TestReports: array of ITestReport );
var
  idx: nativeuint;
begin
  if Length(TestReports)=0 then begin
    exit;
  end;
  for idx := 0 to pred(Length(TestReports)) do begin
    TestReports[idx].EndTestSuite;
  end;
end;

procedure TCustomTestSuite.ReportBeginTestCase( const TestCase: string; const TestReports: array of ITestReport );
var
  idx: nativeuint;
begin
  if Length(TestReports)=0 then begin
    exit;
  end;
  for idx := 0 to pred(Length(TestReports)) do begin
    TestReports[idx].BeginTestCase(TestCase);
  end;
end;

procedure TCustomTestSuite.ReportEndTestCase( const TestReports: array of ITestReport );
var
  idx: nativeuint;
begin
  if Length(TestReports)=0 then begin
    exit;
  end;
  for idx := 0 to pred(Length(TestReports)) do begin
    TestReports[idx].EndTestCase;
  end;
end;

procedure TCustomTestSuite.ReportTest( const Test: string; const TestResult: TTestResult; const Reason: string; const TestReports: array of ITestReport );
var
  idx: nativeuint;
begin
  if Length(TestReports)=0 then begin
    exit;
  end;
  for idx := 0 to pred(Length(TestReports)) do begin
    TestReports[idx].RecordTestResult(Test,TestResult,Reason);
  end;
end;

function TCustomTestSuite.RunTest(const TestCaseClass: TTestCaseClass; const aMethodName: string; const WithSetup: boolean; const WithTearDown: boolean; out Reason: string ): TTestResult;
begin
  try
    Result := ExecuteTestMethod( TestCaseClass, aMethodName, WithSetup, WithTearDown, Reason );
  except
    on E: Exception do begin
      Reason := string(E.Message);
      Result := TTestResult.trError;
    end else begin
      Result := TTestResult.trError;
    end;
  end;
end;

function TCustomTestSuite.Run(const SuiteName: string; const TestReports: array of ITestReport): nativeuint;
var
  TestCaseIndex: nativeuint;
  MethodIndex: nativeuint;
  MethodNames: TArrayOfMethodName;
  TestResult: TTestResult;
  HasSetup: boolean;
  HasTeardown: boolean;
  Reason: string;
begin
  Result := 0;
  TestResult := trError;
  // Report test suite name
  ReportBeginTestSuite( SuiteName, TestReports );
  try
    //- If there are no test cases to run, we exit with no reports.
    if fTestCaseCount=0 then begin
      exit;
    end;
    //- Loop the methos to run them
    for TestCaseIndex := 0 to pred(fTestCaseCount) do begin
      ReportBeginTestCase( string(fRegisteredTestCases[TestCaseIndex].ClassName), TestReports );
      try
        //- Get the test case and begin calling methods.
        MethodNames := GetTestMethods( fRegisteredTestCases[TestCaseIndex], HasSetup, HasTearDown );
        if Length(MethodNames)=0 then begin
          continue;
        end;
        //- Loop through methods to execute them
        for MethodIndex := 0 to pred(Length(MethodNames)) do begin
          try
            //- Run test method.
            Reason := '';
            TestResult := RunTest(fRegisteredTestCases[TestCaseIndex], MethodNames[MethodIndex], HasSetup, HasTearDown, Reason );
            if (TestResult=trFailed) or (TestResult=trError) then begin
              inc(result);
            end;
          finally
            ReportTest( MethodNames[MethodIndex], TestResult, Reason, TestReports );
          end;
        end;
      finally
        ReportEndTestCase( TestReports );
      end;
    end;
  finally
    ReportEndTestSuite( TestReports );
  end;
end;

end.
