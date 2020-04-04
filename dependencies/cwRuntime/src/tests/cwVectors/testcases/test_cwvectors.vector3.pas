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
unit test_cwVectors.Vector3;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwVectors
;

type
  TTestVector3 = class(TTestCase)
  published

    ///  <summary>
    ///    Tests addition in which the left term is a vector and the right
    ///    term is an array of float. (Returns result as a vector)
    ///  </summary>
    procedure AddVA;

    ///  <summary>
    ///    Tests addition in which the left term is an array of float and the
    ///    right term is a vector. (Returns result as a vector)
    ///  </summary>
    procedure AddAV;

    ///  <summary>
    ///    Tests addition in which the left term is a vector and the right
    ///    term is an array of float. (Returns result as a vector)
    ///  </summary>
    procedure SubtractVA;

    ///  <summary>
    ///    Tests addition in which the left term is an array of float and the
    ///    right term is a vector. (Returns result as a vector)
    ///  </summary>
    procedure SubtractAV;

    ///  <summary>
    ///    Tests addition in which the left term is a vector and the right
    ///    term is an array of float. (Returns result as a vector)
    ///  </summary>
    procedure MultiplyVA;

    ///  <summary>
    ///    Tests addition in which the left term is an array of float and the
    ///    right term is a vector. (Returns result as a vector)
    ///  </summary>
    procedure MultiplyAV;

    ///  <summary>
    ///    Tests addition in which the left term is a vector and the right
    ///    term is an array of float. (Returns result as a vector)
    ///  </summary>
    procedure DivideVA;

    ///  <summary>
    ///    Tests addition in which the left term is an array of float and the
    ///    right term is a vector. (Returns result as a vector)
    ///  </summary>
    procedure DivideAV;

    ///  <summary>
    ///    Tests the assignment of an array of floats to a vector.
    ///  </summary>
    procedure ArrayAssign;

    ///  <summary>
    ///    Test the addition of a TVector3 to another TVector3.
    ///  </summary>
    procedure Add;

    ///  <summary>
    ///    Test the addition of a float to a TVector3 (element-wise)
    ///  </summary>
    procedure AddF;

    ///  <summary>
    ///    Test the subtraction of a TVector3 from another TVector3.
    ///  </summary>
    procedure Subtract;

    ///  <summary>
    ///    Test the subtraction of a float from a TVector3
    ///  </summary>
    procedure SubtractF;

    ///  <summary>
    ///    Test the multiplication of a TVector3 with another TVector3.
    ///    (Hadamard, element-wise)
    ///  </summary>
    procedure Multiply;

    ///  <summary>
    ///    Test the multiplication of a TVector3 with a float.
    ///    (element-wise)
    ///  </summary>
    procedure MultiplyF;

    ///  <summary>
    ///    Test the division of a TVector3 by another TVector3.
    ///  </summary>
    procedure Divide;

    ///  <summary>
    ///    Test the division of a TVector3 by a float (element-wise).
    ///  </summary>
    procedure DivideF;

    ///  <summary>
    ///    Test the implicit assignment of a TVector2 to a TVector3 where
    ///    the third element of the TVector3 is set to zero.
    ///  </summary>
    procedure ImplicitV2V3;

    ///  <summary>
    ///    Test the explicit assignment of a TVector2 to a TVector3 where
    ///    the third element of the TVector3 is set to zero.
    ///  </summary>
    procedure ExplicitV2V3;

    ///  <summary>
    ///    Test the implicit assignment of a TVector3 to a TVector2 where the
    ///    third element of the TVector3 is dropped.
    ///  </summary>
    procedure ImplicitV3V2;

    ///  <summary>
    ///    Test the explicit assignment of a TVector3 to a TVector2 where the
    ///    third element of the TVector3 is dropped.
    ///  </summary>
    procedure ExplicitV3V2;

    ///  <summary>
    ///    Test the creation of a TVector3 from three discreet float parameters.
    ///  </summary>
    procedure CreateXYZ;

    ///  <summary>
    ///    Test the dot product calculation of one TVector3 with
    ///    another TVector3
    ///  </summary>
    procedure dot;

    ///  <summary>
    ///    Test the cross product calculation of one TVector3 with
    ///    another TVector3
    ///  </summary>
    procedure cross;

    ///  <summary>
    ///    Test the normalize calculation on a TVector3.
    ///  </summary>
    procedure normalized;

    ///  <summary>
    ///    Test the magnitude calculation on a TVector3.
    ///  </summary>
    procedure magnitude;

  end;


implementation
uses
  cwTest.Standard
;

{ TTestVector3 }

procedure TTestVector3.Add;
var
  V1, V2, V3: Vector3;
begin
  // Arrange:
  V1 := Vector3.Create( 2, 4, 6 );
  V2 := Vector3.Create( 3, 6, 9 );
  // Act:
  V3 := V1 + V2;
  // Assert:
  TTest.IsTrue((V3.X > 4.99) and (V3.X < 5.01));
  TTest.IsTrue((V3.Y > 9.99) and (V3.Y < 10.01));
  TTest.IsTrue((V3.Z > 14.99) and (V3.Z < 15.01));
end;

procedure TTestVector3.AddAV;
var
  V: Vector3;
  R: Vector3;
begin
  // Arrange:
  V := [ 2, 3, 4 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R :=  [ 1, 2, 3 ] + V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 2.99 ) and (R.X < 3.01)) );
  TTest.IsTrue( ((R.Y > 4.99 ) and (R.Y < 5.01)) );
  TTest.IsTrue( ((R.Z > 6.99 ) and (R.Y < 7.01)) );
end;

procedure TTestVector3.AddF;
var
  V1, V2: Vector3;
begin
  // Arrange:
  V1 := Vector3.Create( 2, 4, 6 );
  // Act:
  V2 := V1 + 2;
  // Assert:
  TTest.IsTrue((V2.X > 3.99) and (V2.X < 4.01));
  TTest.IsTrue((V2.Y > 5.99) and (V2.Y < 6.01));
  TTest.IsTrue((V2.Z > 7.99) and (V2.Z < 8.01));
end;

procedure TTestVector3.AddVA;
var
  V: Vector3;
  R: Vector3;
begin
  // Arrange:
  V := [ 2, 3, 4 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := V + [ 1, 2, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 2.99 ) and (R.X < 3.01)) );
  TTest.IsTrue( ((R.Y > 4.99 ) and (R.Y < 5.01)) );
  TTest.IsTrue( ((R.Z > 6.99 ) and (R.Y < 7.01)) );
end;

procedure TTestVector3.ArrayAssign;
var
  V: Vector3;
begin
  // Arrange:
  // Act:
  V := [1,2,3]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((V.X > 0.99 ) and (V.X < 1.01)) );
  TTest.IsTrue( ((V.Y > 1.99 ) and (V.Y < 2.01)) );
  TTest.IsTrue( ((V.Z > 2.99 ) and (V.Y < 3.01)) );
end;


procedure TTestVector3.CreateXYZ;
var
  V1: Vector3;
begin
  // Arrange:
  // Act:
  V1 := Vector3.Create( 2, 4, 6 );
  // Assert:
  TTest.IsTrue((V1.X > 1.99) and (V1.X < 2.01));
  TTest.IsTrue((V1.Y > 3.99) and (V1.Y < 4.01));
  TTest.IsTrue((V1.Z > 5.99) and (V1.Z < 6.01));
end;

procedure TTestVector3.cross;
var
  V1, V2, V3: Vector3;
begin
  // Arrange:
  V1 := Vector3.Create( 1, -7, 1 );
  V2 := Vector3.Create( 5, 2, 4 );
  // Act:
  V3 := V1.cross(V2);
  // Assert:
  TTest.IsTrue((V3.X > -30.01) and (V3.X < -29.99));
  TTest.IsTrue((V3.Y >   0.99) and (V3.Y < 1.01));
  TTest.IsTrue((V3.Z >  36.99) and (V3.Z < 37.01));
end;

procedure TTestVector3.Divide;
var
  V1, V2, V3: Vector3;
begin
  // Arrange:
  V1 := Vector3.Create( 3, 6, 9 );
  V2 := Vector3.Create( 2, 4, 6 );
  // Act:
  V3 := V1 / V2;
  // Assert:
  TTest.IsTrue((V3.X > 1.49) and (V3.X < 1.51));
  TTest.IsTrue((V3.Y > 1.49) and (V3.Y < 1.51));
  TTest.IsTrue((V3.Z > 1.49) and (V3.Z < 1.51));
end;

procedure TTestVector3.DivideAV;
var
  V: Vector3;
  R: Vector3;
begin
  // Arrange:
  V := [ 1, 2, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 2, 3, 4 ] / V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 1.99 ) and (R.X < 2.01)) );
  TTest.IsTrue( ((R.Y > 1.49 ) and (R.Y < 1.51)) );
  TTest.IsTrue( ((R.Z > 1.29 ) and (R.Z < 1.34)) );
end;

procedure TTestVector3.DivideF;
var
  V1, V2: Vector3;
begin
  // Arrange:
  V1 := Vector3.Create( 2, 4, 6 );
  // Act:
  V2 := V1 / 2;
  // Assert:
  TTest.IsTrue((V2.X > 0.99) and (V2.X < 1.01));
  TTest.IsTrue((V2.Y > 1.99) and (V2.Y < 2.01));
  TTest.IsTrue((V2.Z > 2.99) and (V2.Z < 3.01));
end;

procedure TTestVector3.DivideVA;
var
  V: Vector3;
  R: Vector3;
begin
  // Arrange:
  V := [ 2, 3, 4 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := V / [ 1, 2, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 1.99 ) and (R.X < 2.01)) );
  TTest.IsTrue( ((R.Y > 1.49 ) and (R.Y < 1.51)) );
  TTest.IsTrue( ((R.Z > 1.29 ) and (R.Z < 1.34)) );
end;


procedure TTestVector3.dot;
var
  V1, V2: Vector3;
  F: float;
begin
  // Arrange:
  V1 := Vector3.Create(5,6,3);
  V2 := Vector3.Create(2,3,5);
  // Act:
  F := V1.dot(V2);
  // Assert:
  TTest.IsTrue( ((F > 42.99 ) and (F < 43.01)) );
end;

procedure TTestVector3.ExplicitV2V3;
var
  V2: Vector2;
  V3: Vector3;
begin
  // Arrange:
  V2 := Vector2.Create( 10, 12 );
  // Act:
  V3 := Vector3( V2 );
  // Assert:
  TTest.IsTrue((V3.X > 9.99) and (V3.X < 10.01));
  TTest.IsTrue((V3.Y > 11.99) and (V3.Y < 12.01));
  TTest.IsTrue((V3.Z > -0.01) and (V3.Z < 0.01));
end;

procedure TTestVector3.ExplicitV3V2;
var
  V2: Vector2;
  V3: Vector3;
begin
  // Arrange:
  V3 := Vector3.Create( 2, 4, 6 );
  // Act:
  V2 := Vector2( V3 );
  // Assert:
  TTest.IsTrue((V2.X > 1.99) and (V2.X < 2.01));
  TTest.IsTrue((V2.Y > 3.99) and (V2.Y < 4.01));
end;

procedure TTestVector3.ImplicitV2V3;
var
  V2: Vector2;
  V3: Vector3;
begin
  // Arrange:
  V2 := Vector2.Create( 10, 12 );
  // Act:
  V3 := V2;
  // Assert:
  TTest.IsTrue((V3.X > 9.99) and (V3.X < 10.01));
  TTest.IsTrue((V3.Y > 11.99) and (V3.Y < 12.01));
  TTest.IsTrue((V3.Z > -0.01) and (V3.Z < 0.01));
end;

procedure TTestVector3.ImplicitV3V2;
var
  V2: Vector2;
  V3: Vector3;
begin
  // Arrange:
  V3 := Vector3.Create( 2, 4, 6 );
  // Act:
  V2 := V3;
  // Assert:
  TTest.IsTrue((V2.X > 1.99) and (V2.X < 2.01));
  TTest.IsTrue((V2.Y > 3.99) and (V2.Y < 4.01));
end;

procedure TTestVector3.magnitude;
var
  V1: Vector3;
  F: float;
begin
  // Arrange:
  V1 := Vector3.Create( 2, 4, 6 );
  // Act:
  F := V1.magnitude; //  7.483314
  // Assert:
  TTest.IsTrue((F > 7.47) and (F < 7.49));
end;

procedure TTestVector3.Multiply;
var
  V1, V2, V3: Vector3;
begin
  // Arrange:
  V1 := Vector3.Create( 2, 4, 6 );
  V2 := Vector3.Create( 3, 6, 9 );
  // Act:
  V3 := V1 * V2;
  // Assert:
  TTest.IsTrue((V3.X > 5.99) and (V3.X < 6.01));
  TTest.IsTrue((V3.Y > 23.99) and (V3.Y < 24.01));
  TTest.IsTrue((V3.Z > 53.99) and (V3.Z < 54.01));
end;

procedure TTestVector3.MultiplyAV;
var
  V: Vector3;
  R: Vector3;
begin
  // Arrange:
  V := [ 1, 2, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 2, 3, 4 ] * V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 1.99 )  and (R.X < 2.01)) );
  TTest.IsTrue( ((R.Y > 5.99 )  and (R.Y < 6.01)) );
  TTest.IsTrue( ((R.Z > 11.99 ) and (R.Z < 12.01)) );
end;


procedure TTestVector3.MultiplyF;
var
  V1, V2: Vector3;
begin
  // Arrange:
  V1 := Vector3.Create( 2, 4, 6 );
  // Act:
  V2 := V1 * 2;
  // Assert:
  TTest.IsTrue((V2.X > 3.99) and (V2.X < 4.01));
  TTest.IsTrue((V2.Y > 7.99) and (V2.Y < 8.01));
  TTest.IsTrue((V2.Z > 11.99) and (V2.Z < 12.01));
end;

procedure TTestVector3.MultiplyVA;
var
  V: Vector3;
  R: Vector3;
begin
  // Arrange:
  V := [ 1, 2, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := V * [ 2, 3, 4 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 1.99 )  and (R.X < 2.01)) );
  TTest.IsTrue( ((R.Y > 5.99 )  and (R.Y < 6.01)) );
  TTest.IsTrue( ((R.Z > 11.99 ) and (R.Z < 12.01)) );
end;

procedure TTestVector3.normalized;
var
  V1, V2: Vector3;
begin
  // Arrange:
  V1 := Vector3.Create( 2, 4, 6 );
  // Act:
  V2 := V1.normalized; // Magnitude = 7.483314
  // Assert:
  TTest.IsTrue((V2.X > 0.266) and (V2.X < 0.268));
  TTest.IsTrue((V2.Y > 0.533) and (V2.Y < 0.535));
  TTest.IsTrue((V2.Z > 0.800) and (V2.Z < 0.802));
end;

procedure TTestVector3.Subtract;
var
  V1, V2, V3: Vector3;
begin
  // Arrange:
  V1 := Vector3.Create( 3, 6, 9 );
  V2 := Vector3.Create( 2, 4, 6 );
  // Act:
  V3 := V1 - V2;
  // Assert:
  TTest.IsTrue((V3.X > 0.99) and (V3.X < 1.01));
  TTest.IsTrue((V3.Y > 1.99) and (V3.Y < 2.01));
  TTest.IsTrue((V3.Z > 2.99) and (V3.Z < 3.01));
end;

procedure TTestVector3.SubtractAV;
var
  V: Vector3;
  R: Vector3;
begin
  // Arrange:
  V := [ 1, 2, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R :=  [ 2, 3, 4 ] - V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 0.99 ) and (R.X < 1.01)) );
  TTest.IsTrue( ((R.Y > 0.99 ) and (R.Y < 1.01)) );
  TTest.IsTrue( ((R.Z > 0.99 ) and (R.Z < 1.01)) );
end;

procedure TTestVector3.SubtractF;
var
  V1, V2: Vector3;
begin
  // Arrange:
  V1 := Vector3.Create( 2, 4, 6 );
  // Act:
  V2 := V1 - 2;
  // Assert:
  TTest.IsTrue((V2.X > -0.01) and (V2.X < 0.01));
  TTest.IsTrue((V2.Y > 1.99) and (V2.Y < 2.01));
  TTest.IsTrue((V2.Z > 3.99) and (V2.Z < 4.01));
end;

procedure TTestVector3.SubtractVA;
var
  V: Vector3;
  R: Vector3;
begin
  // Arrange:
  V := [ 2, 3, 4 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := V - [ 1, 2, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 0.99 ) and (R.X < 1.01)) );
  TTest.IsTrue( ((R.Y > 0.99 ) and (R.Y < 1.01)) );
  TTest.IsTrue( ((R.Z > 0.99 ) and (R.Y < 1.01)) );
end;

initialization
  TestSuite.RegisterTestCase(TTestVector3);

end.
