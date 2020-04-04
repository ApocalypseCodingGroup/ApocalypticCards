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
unit test_cwTest.SampleTest;
{$ifdef fpc}{$mode delphiunicode}{$M+}{$endif}

interface
uses
  cwTest
, cwTest.Standard
;

type
  TSampleTest = class( TTestCase )
  published

    /// <summary>
    ///   This sample test succeeds. <br />The method executes and completes
    ///   without raising a failure or error state.
    /// </summary>
    procedure SucceedSample;

    /// <summary>
    ///   This test fails. <br />The method raises a fail state resembling a
    ///   failure to meet test criteria.
    /// </summary>
    procedure FailSample;

    /// <summary>
    ///   This sample test enters an error state (throws exception).
    /// </summary>
    procedure ErrorSample;
  end;

implementation

{$hints off}
procedure TSampleTest.ErrorSample;
var
  R: single;
begin
  //- Attempt to divide by zero to raise an exception.
  R := 3;
  R := R / 0;
end;
{$hints on}

procedure TSampleTest.FailSample;
begin
  TTest.Fail('Sample method "FailSample" failed.');
end;

procedure TSampleTest.SucceedSample;
begin
  //- Do nothing and this test succeeds.
end;

initialization
  TestSuite.RegisterTestCase( TSampleTest );

end.
