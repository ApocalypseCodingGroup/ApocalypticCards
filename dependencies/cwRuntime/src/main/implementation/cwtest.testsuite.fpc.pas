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
unit cwTest.TestSuite.Fpc;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
{$ifdef fpc}
uses
  cwTest
, cwTest.TestSuite.Custom
;

type
  TTestSuite = class( TCustomTestSuite, ITestSuite )
  private
    function RunMethod(const TestCase: TTestCase; const aMethodName: string; out Reason: string): boolean;
    function RunSetupMethod(const TestCase: TTestCase; out Reason: string): TTestResult;
    function RunTearDownMethod(const TestCase: TTestCase; out Reason: string): TTestResult;
    function RunTestMethod(const TestCase: TTestCase; const aMethodName: string; out Reason: string): TTestResult;
  protected
    function GetTestMethods( const TestCaseClass: TTestCaseClass; out HasSetup: boolean; out HasTearDown: boolean ): TArrayOfMethodName; override;
    function ExecuteTestMethod( const TestCaseClass: TTestCaseClass; const aMethodName: string; const WithSetup: boolean; const WithTeardown: boolean; out Reason: string ): TTestResult; override;
  end;

{$endif}
implementation
{$ifdef fpc}
uses
  sysutils
, typinfo
;

type
  TMethodNameRec = packed record
    name : pshortstring;
    addr : pointer;
  end;
  TMethodNameTable = packed record
    count : longword;
    entries : packed array[0..0] of TMethodNameRec;
  end;
  pMethodNameTable =  ^TMethodNameTable;
  TInvoke = procedure of object;

function TTestSuite.RunMethod( const TestCase: TTestCase; const aMethodName: string; out Reason: string ): boolean;
var
  Method: TMethod;
  Invoke: TInvoke;
begin
  Reason := '';
  Result := False;
  Method.Data := TestCase;
  Method.Code := TestCase.MethodAddress(shortstring(aMethodName));
  Invoke := TInvoke(Method);
  if not assigned(Invoke) then begin
    Reason := 'Method "'+aMethodName+'" not found.';
    exit;
  end;
  Result := True;
  Invoke;
end;

function TTestSuite.RunTestMethod( const TestCase: TTestCase; const aMethodName: string; out Reason: string ): TTestResult;
begin
  Result := TTestResult.trSucceeded;
  try
    if not RunMethod(TestCase,aMethodName,Reason) then begin
      Result := TTestResult.trError;
      exit;
    end;
  except
    on E: EFailedTest do begin
      Reason := string(E.Message);
      Result := TTestResult.trFailed;
      exit;
    end;
    on E: Exception do begin
      Reason := string(E.Message);
      Result := TTestResult.trError;
      exit;
    end else begin
      Reason := 'Unknown exception.';
      Result := TTestResult.trError;
      exit;
    end;
  end;
  Result := TTestResult.trSucceeded;
end;

function TTestSuite.RunTearDownMethod( const TestCase: TTestCase; out Reason: string ): TTestResult;
const
  cTearDown = 'TEARDOWN';
begin
  Reason := '';
  Result := TTestResult.trTearDownError;
  try
    if not RunMethod(TestCase,cTearDown,Reason) then begin
      exit;
    end;
  except
    on E: Exception do begin
      Reason := string(E.Message);
      exit;
    end else begin
      Reason := 'Unknown exception.';
      exit;
    end;
  end;
  Result := TTestResult.trSucceeded;
end;

function TTestSuite.RunSetupMethod( const TestCase: TTestCase; out Reason: string ): TTestResult;
const
  cSetup = 'SETUP';
var
  IgnoreStr: string;
begin
  Reason := '';
  Result := TTestResult.trSetupError;
  try
    if not RunMethod(TestCase,cSetup,Reason) then begin
      exit;
    end;
  except
    on E: Exception do begin
      Reason := string(E.Message);
      RunTearDownMethod(TestCase,IgnoreStr);
      exit;
    end else begin
      RunTearDownMethod(TestCase,IgnoreStr);
      exit;
    end;
  end;
  Result := TTestResult.trSucceeded;
end;


function TTestSuite.ExecuteTestMethod( const TestCaseClass: TTestCaseClass; const aMethodName: string; const WithSetup: boolean; const WithTeardown: boolean; out Reason: string ): TTestResult;
var
  TestCase: TTestCase;
  IgnoreStr: string;
begin
  Result := TTestResult.trError;
  TestCase := TestCaseClass.Create;
  try
    //- Run setup method.
    if WithSetup then begin
      Result := RunSetupMethod(TestCase,Reason);
      if Result<>TTestResult.trSucceeded then begin
        exit;
      end;
    end;

    //- Run test method.
    Result := RunTestMethod(TestCase,aMethodName,Reason);

    //- Run TearDown method.
    if WithTearDown then begin
      if Result=TTestResult.trSucceeded then begin
        Result := RunTearDownMethod(TestCase,Reason);
      end else begin
        RunTearDownMethod(TestCase,IgnoreStr);
      end;
    end;
  finally
    TestCase.Free;
  end;
end;

function TTestSuite.GetTestMethods(const TestCaseClass: TTestCaseClass; out HasSetup: boolean; out HasTearDown: boolean): TArrayOfMethodName;
const
  cSetup = 'SETUP';
  cTearDown = 'TEARDOWN';
var
  methodTablePtr: pMethodNameTable;
  utMethodName: string;
  Count: nativeuint;
  idx: nativeuint;
begin
  HasSetup := False;
  HasTearDown := False;
  methodTablePtr := pMethodNameTable((Pointer(TestCaseClass) + vmtMethodTable)^);
  if methodTablePtr^.Count = 0 then begin
    {$warnings off} SetLength(Result,0); {$warnings on}
    exit;
  end;
  //- Count the actual methods.
  Count := 0;
  for idx := 0 to pred(methodTablePtr^.Count) do begin
      {$R-} utMethodName := uppercase(trim(string(methodTablePtr^.entries[idx].name^))); {$R+}
      if utMethodName=cSetup then begin
        HasSetup := True;
        continue;
      end else if utMethodName=cTearDown then begin
        HasTearDown := True;
        continue;
      end else begin
        inc(Count);
      end;
  end;
  //- Get method names
  {$warnings off}SetLength(Result,Count);{$warnings on}
  if Count=0 then begin
    exit;
  end;
  Count := 0;
  for idx := 0 to pred(methodTablePtr^.Count) do begin
    {$R-} utMethodName := uppercase(trim(string(methodTablePtr^.entries[idx].name^))); {$R+}
    if utMethodName=cSetup then begin
      HasSetup := True;
      continue;
    end else if utMethodName=cTearDown then begin
      HasTearDown := True;
      continue;
    end else begin
      {$R-} Result[Count] := string(methodTablePtr^.entries[idx].name^); {$R+}
      inc(Count);
    end;
  end;
end;

{$endif}
end.
