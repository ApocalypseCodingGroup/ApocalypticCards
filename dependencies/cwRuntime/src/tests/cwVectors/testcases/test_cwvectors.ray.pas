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
unit test_cwVectors.Ray;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwVectors
;

type
  TTestRay = class(TTestCase)
  published
    ///  <summary>
    ///    Tests the create method which takes an origin and a destination
    ///    as parameters.
    ///  </summary>
    procedure CreateOriginDesination;

    ///  <summary>
    ///    Tests the create method which takes origin, direction and length
    ///    as parameters.
    ///  </summary>
    procedure CreateOriginDirectionLength;

    ///  <summary>
    ///    Tests that the Destination method produces an appropriate destination
    ///    vertex for the ray.
    ///  </summary>
    procedure Destination;
  end;


implementation
uses
  cwTest.Standard
;

{ TTestRay }

procedure TTestRay.CreateOriginDesination;
var
  P1, P2: Vector3;
  aRay: Ray;
begin
  // Arrange:
  P1 := Vector3.Create(0,0,0);
  P2 := Vector3.Create(1,1,1);
  // Act:
  aRay := Ray.Create(P1,P2);
  // Assert:
  TTest.IsTrue( (aRay.Length>1.7319) and (aRay.Length<1.7321) );
  TTest.IsTrue( (aRay.Direction.X>0.57734) and (aRay.Direction.X<0.57736) );
  TTest.IsTrue( (aRay.Direction.Y>0.57734) and (aRay.Direction.Y<0.57736) );
  TTest.IsTrue( (aRay.Direction.Z>0.57734) and (aRay.Direction.Z<0.57736) );
  TTest.IsTrue( ((aRay.Direction.X * aRay.Length)>0.99) and ((aRay.Direction.X * aRay.Length)<1.01) );
  TTest.IsTrue( ((aRay.Direction.Y * aRay.Length)>0.99) and ((aRay.Direction.Y * aRay.Length)<1.01) );
  TTest.IsTrue( ((aRay.Direction.Z * aRay.Length)>0.99) and ((aRay.Direction.Z * aRay.Length)<1.01) );
end;

procedure TTestRay.CreateOriginDirectionLength;
var
  Origin: Vector3;
  Direction: Vector3;
  Length: float;
  aRay: Ray;
begin
  // Arrange:
  Origin := Vector3.Create(0,0,0);
  Direction := Vector3.Create(1,1,1);
  Length := 1.7320;
  // Act:
  aRay := Ray.Create(Origin,Direction,Length);
  // Assert:
  TTest.IsTrue( (aRay.Length>1.7319) and (aRay.Length<1.7321) );
  TTest.IsTrue( (aRay.Direction.X>0.57734) and (aRay.Direction.X<0.57736) );
  TTest.IsTrue( (aRay.Direction.Y>0.57734) and (aRay.Direction.Y<0.57736) );
  TTest.IsTrue( (aRay.Direction.Z>0.57734) and (aRay.Direction.Z<0.57736) );
  TTest.IsTrue( ((aRay.Direction.X * aRay.Length)>0.99) and ((aRay.Direction.X * aRay.Length)<1.01) );
  TTest.IsTrue( ((aRay.Direction.Y * aRay.Length)>0.99) and ((aRay.Direction.Y * aRay.Length)<1.01) );
  TTest.IsTrue( ((aRay.Direction.Z * aRay.Length)>0.99) and ((aRay.Direction.Z * aRay.Length)<1.01) );
end;

procedure TTestRay.Destination;
var
  Origin: Vector3;
  Direction: Vector3;
  Length: float;
  aRay: Ray;
  Destination: Vertex;
begin
  // Arrange:
  Origin := Vector3.Create(0,0,0);
  Direction := Vector3.Create(1,1,1);
  Length := 1.7320;
  // Act:
  aRay := Ray.Create(Origin,Direction,Length);
  Destination := aRay.Destination;
  // Assert:
  TTest.IsTrue( (Destination.X>0.99) and (Destination.X<1.01) );
  TTest.IsTrue( (Destination.X>0.99) and (Destination.X<1.01) );
  TTest.IsTrue( (Destination.X>0.99) and (Destination.X<1.01) );
end;

initialization
  TestSuite.RegisterTestCase(TTestRay);

end.
