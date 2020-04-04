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
unit test_cwVectors.Matrix2x2;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwVectors
;

type
  TTestMatrix = class(TTestCase)
  published

    ///  <summary>
    ///    Test the element-wise addition of one Matrix to another.
    ///  </summary>
    procedure Add;

    ///  <summary>
    ///    Test the element-wise addition of a float to a Matrix.
    ///  </summary>
    procedure AddF;

    ///  <summary>
    ///    Test the element-wise subtraction of a Matrix from another Matrix.
    ///  </summary>
    procedure Subtract;

    ///  <summary>
    ///    Test the element-wise subtraction of a float from a Matrix.
    ///  </summary>
    procedure SubtractF;

    ///  <summary>
    ///    Test the element-wise multiplication of one Matrix with another.
    ///  </summary>
    procedure Multiply;

    ///  <summary>
    ///    Test the element-wise addition of a float to a Matrix.
    ///  </summary>
    procedure MultiplyF;

    ///  <summary>
    ///    Test the element-wise division of a Matrix by another.
    ///  </summary>
    procedure Divide;

    ///  <summary>
    ///    Test the element-wise division of a Matrix by a float.
    ///  </summary>
    procedure DivideF;

    ///  <summary>
    ///    Test the creation of a Matrix from 16 discreet floats.
    ///  </summary>
    procedure CreateParameterized;

    ///  <summary>
    ///    Test the calculation of the dot product of a Matrix with another
    ///    Matrix.
    ///  </summary>
    procedure dotMM;

    ///  <summary>
    ///    Test the calculation of the dot product of a TVector2 with a Matrix.
    ///  </summary>
    procedure dotVM;

    ///  <summary>
    ///    Test the calculation of a transposed Matrix.
    ///  </summary>
    procedure transpose;

    ///  <summary>
    ///    Test the creation of a Matrix representing the identity matrix.
    ///  </summary>
    procedure identity;

    ///  <summary>
    ///    Test the creation of a Matrix for translating vectors.
    ///  </summary>
    procedure translation;

    ///  <summary>
    ///    Test the creation of a Matrix for rotating vectors (around Z).
    ///  </summary>
    procedure rotation;

    ///  <summary>
    ///    Test the creation of a Matrix for scaling vectors.
    ///  </summary>
    procedure scale;

    ///  <summary>
    ///    Test the determinant of the matrix.
    ///  </summary>
    procedure determinant;

    ///  <summary>
    ///    Test the cofactor of the matrix.
    ///  </summary>
    procedure cofactor;

    ///  <summary>
    ///    Test the adjugate of the matrix.
    ///  </summary>
    procedure adjugate;

    ///  <summary>
    ///    Test the inverse of a matrix.
    ///  </summary>
    procedure inverse;
  end;


implementation
uses
  cwTest.Standard
;

{ TTestMatrix }
function CheckMatrix( M: Matrix2x2; m00, m10, m01, m11: float ): boolean;
begin
  Result := True;
  Result := Result and (M.m00 > (m00-0.01)) and (M.m00 < (m00+0.01));
  Result := Result and (M.m01 > (m01-0.01)) and (M.m01 < (m01+0.01));
  Result := Result and (M.m10 > (m10-0.01)) and (M.m10 < (m10+0.01));
  Result := Result and (M.m11 > (m11-0.01)) and (M.m11 < (m11+0.01));
end;

procedure TTestMatrix.Add;
var
  M1, M2, M3: Matrix2x2;
begin
  // Arrange:
  M1 := Matrix2x2.Create(
    2, 4,
    1, 3
  );

  M2 := Matrix2x2.Create(
    0, 2,
    3, 5
  );

  // Act:
  M3 := M1 + M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2+0, 4+2,
    1+3, 3+5
  ));
end;

procedure TTestMatrix.AddF;
var
  M1, M2: Matrix2x2;
  F: Float;
begin
  // Arrange:
  M1 := Matrix2x2.Create(
    2, 4,
    1, 3
  );
  F := 5;

  // Act:
  M2 := M1 + F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2+F, 4+F,
    1+F, 3+F
  ));
end;

procedure TTestMatrix.adjugate;
var
  M: Matrix2x2;
begin
  // Arrange:
  M := Matrix2x2.Create(
    3, 5,
    -7, 2
  );
  // Act:
  M := M.adjugate;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    2, -5,
    7, 3
  ));
end;


procedure TTestMatrix.cofactor;
var
  M: Matrix2x2;
begin
  // Arrange:
  M := Matrix2x2.Create(
    3, 5,
    -7, 2
  );
  // Act:
  M := M.cofactor;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    2, 7,
    -5, 3
  ));
end;


procedure TTestMatrix.CreateParameterized;
var
  M: Matrix2x2;
begin
  // Arrange:
  // Act:
  M := Matrix2x2.Create(
    01, 02,
    05, 06
  );
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    01, 02,
    05, 06
  ));
end;


procedure TTestMatrix.determinant;
var
  M: Matrix2x2;
  F: float;
begin
  // Arrange:
  M := Matrix2x2.Create(
   3,  5,
   -7, 2
  );
  // Act:
  F := M.determinant;
  // Assert:
  TTest.IsTrue( (F>40.99) and (F<41.01) );
end;

procedure TTestMatrix.Divide;
var
  M1, M2, M3: Matrix2x2;
begin
  // Arrange:
  M1 := Matrix2x2.Create(
    2, 4,
    1, 3
  );

  M2 := Matrix2x2.Create(
    1, 2,
    3, 5
  );

  // Act:
  M3 := M1 / M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2/1, 4/2,
    1/3, 3/5
  ));
end;

procedure TTestMatrix.DivideF;
var
  M1, M2: Matrix2x2;
  F: Float;
begin
  // Arrange:
  M1 := Matrix2x2.Create(
    2, 4,
    1, 3
  );
  F := 5;

  // Act:
  M2 := M1 / F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2/F, 4/F,
    1/F, 3/F
  ));
end;

procedure TTestMatrix.dotMM;
var
  M1, M2, M3: Matrix2x2;
begin
  // Arrange:
  M1 := Matrix2x2.Create(
    2, 4,
    1, 3
  );

  M2 := Matrix2x2.Create(
    1, 2,
    3, 5
  );

  // Act:
  M3 := M1.dot(M2);
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    14, 24,
    10, 17
  ));
end;

procedure TTestMatrix.dotVM;
var
  M1: Matrix2x2;
  V1,V2: Vector2;
begin
  // Arrange:
  M1 := Matrix2x2.Create(
    -03, 00,
     01, 07
  );
  V1 := Vector2.Create( 2, -3 );
  // Act:
  V2 := M1.dot(V1);
  // Assert:
  TTest.IsTrue((V2.X > -6.01)  and (V2.X < -05.99));
  TTest.IsTrue((V2.Y > -19.01) and (V2.Y < -18.99));
end;

procedure TTestMatrix.identity;
var
  M: Matrix2x2;
begin
  // Arrange:
  // Act:
  M := Matrix2x2.Identity;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    1, 0,
    0, 1
  ));
end;

procedure TTestMatrix.inverse;
var
  M: Matrix2x2;
  M1: Matrix2x2;
  M2: Matrix2x2;
begin
  // Arrange:
  M := Matrix2x2.Create(
    3, 5,
    -7, 2
  );
  // Act:
  M1 := M.inverse;
  M2 := M1.dot(M);
  // Assert:
  TTest.IsTrue( CheckMatrix( M1,
    2/41, -5/41,
    7/41, 3/41
  ));
  //- Any matrix multiplied by it's own inverse should be identity.
  TTest.IsTrue( CheckMatrix( M2,
    1, 0,
    0, 1
  ));
end;


procedure TTestMatrix.Multiply;
var
  M1, M2, M3: Matrix2x2;
begin
  // Arrange:
  M1 := Matrix2x2.Create(
    2, 4,
    1, 3
  );

  M2 := Matrix2x2.Create(
    0, 2,
    3, 5
  );

  // Act:
  M3 := M1 * M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2*0, 4*2,
    1*3, 3*5
  ));
end;

procedure TTestMatrix.MultiplyF;
var
  M1, M2: Matrix2x2;
  F: Float;
begin
  // Arrange:
  M1 := Matrix2x2.Create(
    2, 4,
    1, 3
  );
  F := 5;

  // Act:
  M2 := M1 * F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2*F, 4*F,
    1*F, 3*F
  ));
end;

procedure TTestMatrix.rotation;
var
  M: Matrix2x2;
begin
  // Arrange:
  // Act:
  M := Matrix2x2.rotation(53.1);
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    0.6, -0.8,
    0.8,  0.6
  ));
end;

procedure TTestMatrix.scale;
var
  V: Vector2;
  M: Matrix2x2;
begin
  // Arrange:
  V := Vector2.Create( 2, 3 );
  // Act:
  M := Matrix2x2.scale( V );
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    V.X,   0,
      0, V.Y
  ));
end;

procedure TTestMatrix.Subtract;
var
  M1, M2, M3: Matrix2x2;
begin
  // Arrange:
  M1 := Matrix2x2.Create(
    2, 4,
    1, 3
  );

  M2 := Matrix2x2.Create(
    0, 2,
    3, 5
  );

  // Act:
  M3 := M1 - M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2-0, 4-2,
    1-3, 3-5
  ));
end;

procedure TTestMatrix.SubtractF;
var
  M1, M2: Matrix2x2;
  F: Float;
begin
  // Arrange:
  M1 := Matrix2x2.Create(
    2, 4,
    1, 3
  );
  F := 5;

  // Act:
  M2 := M1 - F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2-F, 4-F,
    1-F, 3-F
  ));
end;

procedure TTestMatrix.translation;
var
  V: Vector2;
  M: Matrix2x2;
begin
  // Arrange:
  V := Vector2.Create( 2, 3 );
  // Act:
  M := Matrix2x2.translation( V );
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
      1,   V.X,
      0,   V.Y
  ));
end;

procedure TTestMatrix.transpose;
var
  M: Matrix2x2;
begin
  // Arrange:
  M := Matrix2x2.Create(
    01, 02,
    05, 06
  );
  // Act:
  M := M.transpose;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    01, 05,
    02, 06
  ));
end;

initialization
  TestSuite.RegisterTestCase(TTestMatrix);

end.

