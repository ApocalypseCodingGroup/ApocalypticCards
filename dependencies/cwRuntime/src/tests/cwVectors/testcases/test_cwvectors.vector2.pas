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
unit test_cwVectors.Vector2;
{$ifdef fpc}
  {$mode delphiunicode}
  {$modeswitch advancedrecords+}
  {$modeswitch ArrayOperators-}
{$endif}
{$M+}

interface
uses
  cwTest
, cwVectors
;

type
  TTestVector2 = class(TTestCase)
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
    ///    Test addition of two Vector2 vectors.
    ///  </summary>
    procedure Add;

    ///  <summary>
    ///    Test the addition of a float to a Vector2
    ///  </summary>
    procedure AddF;

    ///  <summary>
    ///    Test subtraction of a Vector2 from a Vector2
    ///  </summary>
    procedure Subtract;

    ///  <summary>
    ///    Test subtraction of a float from a Vector2
    ///  </summary>
    procedure SubtractF;

    ///  <summary>
    ///    Test the multiplication of a Vector2 by another Vector2
    ///    (Hadamard multiplication)
    ///  </summary>
    procedure Multiply;

    ///  <summary>
    ///    Test the multiplication of a Vector2 by a float.
    ///  </summary>
    procedure MultiplyF;

    ///  <summary>
    ///    Test the division of a Vector2 by another Vector2.
    ///    (element-wise)
    ///  </summary>
    procedure Divide;

    ///  <summary>
    ///    Test the division of a Vector2 by a float.
    ///  </summary>
    procedure DivideF;

    ///  <summary>
    ///    Test the create method to create a Vector2 assigned from two
    ///    floats passed as X and Y.
    ///  </summary>
    procedure CreateXY;

    ///  <summary>
    ///    Test the dotProduct calculation of a Vector2 with a Vector2.
    ///  </summary>
    procedure dot;

    ///  <summary>
    ///    Test the Normalized calculation of a Vector2 (create unit vector)
    ///  </summary>
    procedure Normalized;

    ///  <summary>
    ///    Test the magnitude calculation of a Vector2.
    ///  </summary>
    procedure Magnitude;
  end;


implementation
uses
  cwTest.Standard
;

{ TTestVector2 }

procedure TTestVector2.Add;
var
  V1, V2, V3: Vector2;
begin
  // Arrange:
  V1 := Vector2.Create(5,6);
  V2 := Vector2.Create(2,3);
  // Act:
  V3 := V1 + V2;
  // Assert:
  TTest.IsTrue( ((V3.X > 6.99 ) and (V3.X < 7.01)) );
  TTest.IsTrue( ((V3.Y > 8.99 ) and (V3.Y < 9.01)) );
end;

procedure TTestVector2.AddAV;
var
  V: Vector2;
  R: Vector2;
begin
  // Arrange:
  V := [ 2, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 4, 6 ] + V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 5.99 ) and (R.X < 6.01)) );
  TTest.IsTrue( ((R.Y > 8.99 ) and (R.Y < 9.01)) );
end;

procedure TTestVector2.AddF;
var
  V1, V2: Vector2;
begin
  // Arrange:
  V1 := Vector2.Create(5,6);
  // Act:
  V2 := V1 + 2;
  // Assert:
  TTest.IsTrue( ((V2.X > 6.99 ) and (V2.X < 7.01)) );
  TTest.IsTrue( ((V2.Y > 7.99 ) and (V2.Y < 8.01)) );
end;

procedure TTestVector2.AddVA;
var
  V: Vector2;
  R: Vector2;
begin
  // Arrange:
  V := [ 2, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := V + [ 4, 6 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 5.99 ) and (R.X < 6.01)) );
  TTest.IsTrue( ((R.Y > 8.99 ) and (R.Y < 9.01)) );
end;

procedure TTestVector2.ArrayAssign;
var
  V: Vector2;
begin
  // Arrange:
  // Act:
  V := [1,2]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((V.X > 0.99 ) and (V.X < 1.01)) );
  TTest.IsTrue( ((V.Y > 1.99 ) and (V.Y < 2.01)) );
end;

procedure TTestVector2.CreateXY;
var
  V1: Vector2;
begin
  // Arrange:
  // Act:
  V1 := Vector2.Create(5,6);
  // Assert:
  TTest.IsTrue( ((V1.X > 4.99 ) and (V1.X < 5.01)) );
  TTest.IsTrue( ((V1.Y > 5.99 ) and (V1.Y < 6.01)) );
end;

procedure TTestVector2.Divide;
var
  V1, V2, V3: Vector2;
begin
  // Arrange:
  V1 := Vector2.Create(5,6);
  V2 := Vector2.Create(2,3);
  // Act:
  V3 := V1 / V2;
  // Assert:
  TTest.IsTrue( ((V3.X > 2.49 ) and (V3.X < 2.51)) );
  TTest.IsTrue( ((V3.Y > 1.99 ) and (V3.Y < 2.01)) );
end;

procedure TTestVector2.DivideAV;
var
  V: Vector2;
  R: Vector2;
begin
  // Arrange:
  V := [ 2, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 4, 3 ] / V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 1.99 ) and (R.X < 2.01)) );
  TTest.IsTrue( ((R.Y > 0.99 ) and (R.Y < 1.01)) );
end;

procedure TTestVector2.DivideF;
var
  V1, V2: Vector2;
begin
  // Arrange:
  V1 := Vector2.Create(5,6);
  // Act:
  V2 := V1 / 2;
  // Assert:
  TTest.IsTrue( ((V2.X > 2.49 ) and (V2.X < 2.51)) );
  TTest.IsTrue( ((V2.Y > 2.99 ) and (V2.Y < 3.01)) );
end;

procedure TTestVector2.DivideVA;
var
  V: Vector2;
  R: Vector2;
begin
  // Arrange:
  V := [ 4, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := V / [ 2, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 1.99 ) and (R.X < 2.01)) );
  TTest.IsTrue( ((R.Y > 0.99 ) and (R.Y < 1.01)) );
end;

procedure TTestVector2.dot;
var
  V1, V2: Vector2;
  F: float;
begin
  // Arrange:
  V1 := Vector2.Create(5,6);
  V2 := Vector2.Create(2,3);
  // Act:
  F := V1.dot(V2);
  // Assert:
  TTest.IsTrue((F > 27.99 ) and (F < 28.01));
end;

procedure TTestVector2.Magnitude;
var
  V1: Vector2;
  F: float;
begin
  // Arrange:
  V1 := Vector2.Create(2,5);
  // Act:
  F := V1.magnitude;
  // Assert:
   TTest.IsTrue((F > 5.37) and (F < 5.39));
end;

procedure TTestVector2.Multiply;
var
  V1, V2, V3: Vector2;
begin
  // Arrange:
  V1 := Vector2.Create(5,6);
  V2 := Vector2.Create(7,2);
  // Act:
  V3 := V1 * V2;
  // Assert:
  TTest.IsTrue((V3.X > 34.99) and  (V3.X < 35.01));
  TTest.IsTrue((V3.Y > 11.99) and  (V3.Y < 12.01));
end;

procedure TTestVector2.MultiplyAV;
var
  V: Vector2;
  R: Vector2;
begin
  // Arrange:
  V := [ 4, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 2, 3 ] * V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 7.99 ) and (R.X < 8.01)) );
  TTest.IsTrue( ((R.Y > 8.99 ) and (R.Y < 9.01)) );
end;

procedure TTestVector2.MultiplyF;
var
  V1, V2: Vector2;
begin
  // Arrange:
  V1 := Vector2.Create( 5, 6 );
  // Act:
  V2 := V1 * 3;
  // Assert:
  TTest.IsTrue((V2.X > 14.99) and  (V2.X < 15.01));
  TTest.IsTrue((V2.Y > 17.99) and  (V2.Y < 18.01));
end;

procedure TTestVector2.MultiplyVA;
var
  V: Vector2;
  R: Vector2;
begin
  // Arrange:
  V := [ 4, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := V * [ 2, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 7.99 ) and (R.X < 8.01)) );
  TTest.IsTrue( ((R.Y > 8.99 ) and (R.Y < 9.01)) );
end;


procedure TTestVector2.Normalized;
var
  V1, V2: Vector2;
begin
  // Arrange:
  V1 := Vector2.Create( 2, 5 );
  // Act:
  V2 := V1.normalized;
  // Assert:
  TTest.IsTrue((V2.X > 0.36) and  (V2.X < 0.372));
  TTest.IsTrue((V2.Y > 0.91) and  (V2.Y < 0.930));
end;

procedure TTestVector2.Subtract;
var
  V1, V2, V3: Vector2;
begin
  // Arrange:
  V1 := Vector2.Create( 8, 6 );
  V2 := Vector2.Create( 4, 2 );
  // Act:
  V3 := V1 - V2;
  // Assert:
  TTest.IsTrue((V3.X > 3.99) and  (V3.X < 4.01));
  TTest.IsTrue((V3.Y > 3.99) and  (V3.Y < 4.01));
end;

procedure TTestVector2.SubtractAV;
var
  V: Vector2;
  R: Vector2;
begin
  // Arrange:
  V := [ 2, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 4, 6 ] - V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 1.99 ) and (R.X < 2.01)) );
  TTest.IsTrue( ((R.Y > 2.99 ) and (R.Y < 3.01)) );
end;


procedure TTestVector2.SubtractF;
var
  V1, V2: Vector2;
begin
  // Arrange:
  V1 := Vector2.Create( 8, 6 );
  // Act:
  V2 := V1 - 2;
  // Assert:
  TTest.IsTrue((V2.X > 5.99) and  (V2.X < 6.01));
  TTest.IsTrue((V2.Y > 3.99) and  (V2.Y < 4.01));
end;

procedure TTestVector2.SubtractVA;
var
  V: Vector2;
  R: Vector2;
begin
  // Arrange:
  V := [ 4, 6 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := V - [ 2, 3 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 1.99 ) and (R.X < 2.01)) );
  TTest.IsTrue( ((R.Y > 2.99 ) and (R.Y < 3.01)) );
end;


initialization
  TestSuite.RegisterTestCase(TTestVector2);

end.
