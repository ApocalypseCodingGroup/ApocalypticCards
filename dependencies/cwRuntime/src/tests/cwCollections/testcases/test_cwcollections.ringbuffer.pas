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
unit test_cwCollections.RingBuffer;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwCollections
, cwCollections.Standard
;

type
  TTest_cwCollectionsRingBuffer = class(TTestCase)
  private
    procedure internal_Push( vCUT: ICollection );
    procedure internal_Peek( vCUT: ICollection );
    procedure internal_Pull( vCUT: ICollection );
  published
    procedure Push;
    procedure Peek;
    procedure Pull;
  end;

implementation
uses
  cwTest.Standard
;

procedure TTest_cwCollectionsRingBuffer.internal_Peek( vCUT: ICollection );
var
  CUT: IRingBuffer<uint32>;
  x: uint32;
begin
  CUT := (vCUT as IRingBuffer<uint32>);
  TTest.Expect(True,CUT.IsEmpty);
  CUT.Push(3);
  TTest.Expect(False,CUT.IsEmpty);
  CUT.Push(2);
  TTest.Expect(False,CUT.IsEmpty);
  CUT.Pull(x);
  TTest.Expect(False,CUT.IsEmpty);
  CUT.Pull(x);
  TTest.Expect(True,CUT.IsEmpty);
end;

procedure TTest_cwCollectionsRingBuffer.internal_Pull( vCUT: ICollection );
var
  CUT: IRingBuffer<uint32>;
  x: uint32;
begin
  CUT := (vCUT as IRingBuffer<uint32>);
  CUT.Push(3);
  CUT.Push(2);
  TTest.Expect(True,CUT.Pull(x));
  TTest.Expect(True,CUT.Pull(x));
  TTest.Expect(False,CUT.Pull(x));
end;

procedure TTest_cwCollectionsRingBuffer.internal_Push( vCUT: ICollection );
var
  CUT: IRingBuffer<uint32>;
begin
  CUT := (vCUT as IRingBuffer<uint32>);
  TTest.Expect(True,CUT.Push(3));
  TTest.Expect(True,CUT.Push(2));
  TTest.Expect(False,CUT.Push(5));
end;

procedure TTest_cwCollectionsRingBuffer.Push;
var
  CUT: IRingBuffer<uint32>;
begin
  CUT := TRingBuffer<uint32>.Create(3);
  internal_Push(CUT);
end;

procedure TTest_cwCollectionsRingBuffer.Peek;
var
  CUT: IRingBuffer<uint32>;
begin
  CUT := TRingBuffer<uint32>.Create(3);
  internal_Peek(CUT);
end;

procedure TTest_cwCollectionsRingBuffer.Pull;
var
  CUT: IRingBuffer<uint32>;
begin
  CUT := TRingBuffer<uint32>.Create(3);
  internal_Pull(CUT);
end;


initialization
  TestSuite.RegisterTestCase(TTest_cwCollectionsRingBuffer)

end.


