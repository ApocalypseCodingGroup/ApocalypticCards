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
/// <summary>
///   The standard implementation of cwTest.
/// </summary>
unit cwTest.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwTest
;

/// <summary>
///   Returns the singleton instance of ITestSuite which may be used to
///   register and execute test cases.
/// </summary>
function TestSuite(): ITestSuite;

type
  /// <summary>
  ///   Provides utility methods for checking the results of operations
  ///   performed during testing. For example, in order to fail a test you may
  ///   call TTest.Fail( ' &lt;reason string&gt; '); from within the test
  ///   procedure.
  /// </summary>
  TTest = record

    ///  <summary>
    ///    Causes the test to fail with the provided reason string.
    ///  </summary>
    class procedure Fail( const ReasonString: string ); static;

    ///  <summary>
    ///    If the boolean value passed in is not TRUE, the test will
    ///    fail. If a reason string is provided in the optional parameter it
    ///    will be given as the reason for failure, otherwise a generic
    ///    'Expected True' message is used.
    ///  </summary>
    class procedure IsTrue( const Value: boolean; const ReasonString: string = '' ); static;

    ///  <summary>
    ///    If the boolean value passed in is not FALSE, the test will
    ///    fail. If a reason string is provided in the optional parameter it
    ///    will be given as the reason for failure, otherwise a generic
    ///    'Expected False' message is used.
    ///  </summary>
    class procedure IsFalse( const Value: boolean; const ReasonString: string = '' ); static;

    ///  <summary>
    ///    Compares the expected value to the got value and fails the test if the
    ///    two values do not match.  There are many overloads of this method for
    ///    comparison of different types. Each overload has the same two parameters
    ///    except for those which compare floating-points, which add a third parameter
    ///    to indicate the level of precision to be used in the comparison.
    ///  </summary>
    class procedure Expect( const ExpectedValue: string;   const GotValue: string ); overload; static;
    ///  <exclude/>
    class procedure Expect( const ExpectedValue: char;     const GotValue: char ); overload; static;
    ///  <exclude/>
    class procedure Expect( const ExpectedValue: boolean;  const GotValue: boolean ); overload; static;
    ///  <exclude/>
    class procedure Expect( const ExpectedValue: uint8;    const GotValue: uint8 ); overload; static;
    ///  <exclude/>
    class procedure Expect( const ExpectedValue: uint16;   const GotValue: uint16 ); overload; static;
    ///  <exclude/>
    class procedure Expect( const ExpectedValue: uint32;   const GotValue: uint32 ); overload; static;
    ///  <exclude/>
    class procedure Expect( const ExpectedValue: uint64;   const GotValue: uint64 ); overload; static;
    ///  <exclude/>
    class procedure Expect( const ExpectedValue: int8;     const GotValue: int8 ); overload; static;
    ///  <exclude/>
    class procedure Expect( const ExpectedValue: int16;    const GotValue: int16 ); overload; static;
    ///  <exclude/>
    class procedure Expect( const ExpectedValue: int32;    const GotValue: int32 ); overload; static;
    ///  <exclude/>
    class procedure Expect( const ExpectedValue: int64;    const GotValue: int64 ); overload; static;
    ///  <exclude/>
    class procedure Expect( const ExpectedValue: single;   const GotValue: single;   const precision: single ); overload; static;
    ///  <exclude/>
    class procedure Expect( const ExpectedValue: double;   const GotValue: double;   const precision: double ); overload; static;
    ///  <exclude/>
    class procedure Compare( const SourceData: pointer; const TargetData: pointer; const ByteCount: nativeuint; const FailMessage: string = '' ); static;
  end;

  /// <summary>
  ///   A factory record for creating instances of ITestReport using the
  ///   standard console implementation. <br />(Test results are printed to the
  ///   console)
  /// </summary>
  TConsoleReport = record

    /// <summary>
    ///   Factory method for creating instances of ITestReport, to appear as a
    ///   constructor and may be used in place of a constructor for the console
    ///   implementation.
    /// </summary>
    class function Create: ITestReport; static;
  end;

implementation
uses
  sysutils //[RTL] for Format()
{$ifdef fpc}
, cwTest.TestSuite.Fpc
{$else}
, cwTest.TestSuite.Delphi
{$endif}
, cwTest.TestReport.Console
;

const
  cExpected = 'Expected %s but got %s';

var
  SingletonTestSuite: ITestSuite = nil;

function TestSuite(): ITestSuite;
begin
  if not assigned(SingletonTestSuite) then begin
    SingletonTestSuite := TTestSuite.Create;
  end;
  Result := SingletonTestSuite;
end;

{ TConsoleReport }

class function TConsoleReport.Create: ITestReport;
begin
  Result := TStandardConsoleReport.Create;
end;

{ TTest }

class procedure TTest.Fail(const ReasonString: string);
begin
  raise
    {$ifdef fpc}
    EFailedTest.Create(AnsiString(ReasonString));
    {$else}
    EFailedTest.Create(ReasonString);
    {$endif}
end;

class procedure TTest.IsTrue(const Value: boolean; const ReasonString: string);
begin
  if Value then begin
    exit;
  end;
  if ReasonString='' then begin
    Fail('Expected True.');
  end else begin
    Fail(ReasonString);
  end;
end;

class procedure TTest.IsFalse(const Value: boolean; const ReasonString: string);
begin
  if not Value then begin
    exit;
  end;
  if ReasonString='' then begin
    Fail('Expected False.');
  end else begin
    Fail(ReasonString);
  end;
end;

class procedure TTest.Expect(const ExpectedValue: string; const GotValue: string);
begin
  if ExpectedValue=GotValue then begin
    exit;
  end;
  Fail( string(Format(cExpected,[ExpectedValue,GotValue])) );
end;

class procedure TTest.Expect(const ExpectedValue: char; const GotValue: char);
begin
  if ExpectedValue=GotValue then begin
    exit;
  end;
  Fail( string(Format(cExpected,[ExpectedValue,GotValue])) );
end;

class procedure TTest.Expect(const ExpectedValue: boolean; const GotValue: boolean);
begin
  if ExpectedValue=GotValue then begin
    exit;
  end;
  Fail( string(Format(cExpected,[ExpectedValue,GotValue])) );
end;

class procedure TTest.Expect(const ExpectedValue: uint8; const GotValue: uint8);
begin
  if ExpectedValue=GotValue then begin
    exit;
  end;
  Fail( string(Format(cExpected,[ExpectedValue,GotValue])) );
end;

class procedure TTest.Expect(const ExpectedValue: uint16; const GotValue: uint16);
begin
  if ExpectedValue=GotValue then begin
    exit;
  end;
  Fail( string(Format(cExpected,[ExpectedValue,GotValue])) );
end;

class procedure TTest.Expect(const ExpectedValue: uint32; const GotValue: uint32);
begin
  if ExpectedValue=GotValue then begin
    exit;
  end;
  Fail( string(Format(cExpected,[ExpectedValue,GotValue])) );
end;

class procedure TTest.Expect(const ExpectedValue: uint64; const GotValue: uint64);
begin
  if ExpectedValue=GotValue then begin
    exit;
  end;
  Fail( string(Format(cExpected,[ExpectedValue,GotValue])) );
end;

class procedure TTest.Expect(const ExpectedValue: int8; const GotValue: int8);
begin
  if ExpectedValue=GotValue then begin
    exit;
  end;
  Fail( string(Format(cExpected,[ExpectedValue,GotValue])) );
end;

class procedure TTest.Expect(const ExpectedValue: int16; const GotValue: int16);
begin
  if ExpectedValue=GotValue then begin
    exit;
  end;
  Fail( string(Format(cExpected,[ExpectedValue,GotValue])) );
end;

class procedure TTest.Expect(const ExpectedValue: int32; const GotValue: int32);
begin
  if ExpectedValue=GotValue then begin
    exit;
  end;
  Fail( string(Format(cExpected,[ExpectedValue,GotValue])) );
end;

class procedure TTest.Expect(const ExpectedValue: int64; const GotValue: int64);
begin
  if ExpectedValue=GotValue then begin
    exit;
  end;
  Fail( string(Format(cExpected,[ExpectedValue,GotValue])) );
end;

class procedure TTest.Expect(const ExpectedValue: single; const GotValue: single; const precision: single);
begin
  if (GotValue>(ExpectedValue-Precision)) or (GotValue<(ExpectedValue+Precision)) then begin
    exit;
  end;
  Fail( string(Format(cExpected,[ExpectedValue,GotValue])) );
end;

class procedure TTest.Expect(const ExpectedValue: double; const GotValue: double; const precision: double);
begin
  if (GotValue>(ExpectedValue-Precision)) or (GotValue<(ExpectedValue+Precision)) then begin
    exit;
  end;
  Fail( string(Format(cExpected,[ExpectedValue,GotValue])) );
end;

class procedure TTest.Compare(const SourceData: pointer; const TargetData: pointer; const ByteCount: nativeuint; const FailMessage: string);
var
  Counter: nativeuint;
  ptrSource: ^uint8;
  ptrTarget: ^uint8;
begin
  Counter := ByteCount;
  ptrSource := SourceData;
  ptrTarget := TargetData;
  while Counter>0 do begin
    if ptrSource^<>ptrTarget^ then begin
      Fail(FailMessage);
      exit;
    end;
    inc(ptrSource);
    inc(ptrTarget);
    dec(Counter);
  end;
end;

initialization
  SingletonTestSuite := nil;

finalization
  SingletonTestSuite := nil;

end.
