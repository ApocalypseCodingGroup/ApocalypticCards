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
unit test_cwVectors.Matrix4x4;
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
    ///    Test the element-wise addition of one TMatrix to another.
    ///  </summary>
    procedure Add;

    ///  <summary>
    ///    Test the element-wise addition of a float to a TMatrix.
    ///  </summary>
    procedure AddF;

    ///  <summary>
    ///    Test the element-wise subtraction of a TMatrix from another TMatrix.
    ///  </summary>
    procedure Subtract;

    ///  <summary>
    ///    Test the element-wise subtraction of a float from a TMatrix.
    ///  </summary>
    procedure SubtractF;

    ///  <summary>
    ///    Test the element-wise multiplication of one TMatrix with another.
    ///  </summary>
    procedure Multiply;

    ///  <summary>
    ///    Test the element-wise addition of a float to a TMatrix.
    ///  </summary>
    procedure MultiplyF;

    ///  <summary>
    ///    Test the element-wise division of a TMatrix by another.
    ///  </summary>
    procedure Divide;

    ///  <summary>
    ///    Test the element-wise division of a TMatrix by a float.
    ///  </summary>
    procedure DivideF;

    ///  <summary>
    ///    Test the creation of a TMatrix from 16 discreet floats.
    ///  </summary>
    procedure CreateParameterized;

    ///  <summary>
    ///    Test the creation of a matrix from four row vectors (length 4)
    ///  </summary>
    procedure CreateVectors;

    ///  <summary>
    ///    Test the creation of a matrix from four row vectors (length 3)
    ///    Remaining space in the matrix is filled with identity.
    ///  </summary>
    procedure CreateVectors3;

    ///  <summary>
    ///    Test the calculation of the dot product of a TMatrix with another
    ///    TMatrix.
    ///  </summary>
    procedure dotMM;

    ///  <summary>
    ///    Test the calculation of the dot product of a TVector4 with a TMatrix.
    ///  </summary>
    procedure dotVM;

    ///  <summary>
    ///    Test the calculation of a transposed TMatrix.
    ///  </summary>
    procedure transpose;

    ///  <summary>
    ///    Test the creation of a TMatrix representing the identity matrix.
    ///  </summary>
    procedure identity;

    ///  <summary>
    ///    Test the creation of a TMatrix for translating vectors.
    ///  </summary>
    procedure translation;

    ///  <summary>
    ///    Test the creation of a TMatrix for rotating vectors around X.
    ///  </summary>
    procedure rotationX;

    ///  <summary>
    ///    Test the creation of a TMatrix for rotating vectors around Y.
    ///  </summary>
    procedure rotationY;

    ///  <summary>
    ///    Test the creation of a TMatrix for rotating vectors around Z.
    ///  </summary>
    procedure rotationZ;

    ///  <summary>
    ///    Test the creation of a TMatrix for scaling vectors.
    ///  </summary>
    procedure scale;

    ///  <summary>
    ///    Test the adjugate of a matrix.
    ///  </summary>
    procedure adjugate;

    ///  <summary>
    ///    Test the cofactor of a matrix.
    ///  </summary>
    procedure cofactor;

    ///  <summary>
    ///    Test the determinate of a matrix.
    ///  </summary>
    procedure determinant;

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
function CheckMatrix( M: Matrix4x4; m00, m10, m20, m30, m01, m11, m21, m31, m02, m12, m22, m32, m03, m13, m23, m33: float ): boolean;
begin
  Result := True;
  Result := Result and (M.m00 > (m00-0.01)) and (M.m00 < (m00+0.01));
  Result := Result and (M.m01 > (m01-0.01)) and (M.m01 < (m01+0.01));
  Result := Result and (M.m02 > (m02-0.01)) and (M.m02 < (m02+0.01));
  Result := Result and (M.m03 > (m03-0.01)) and (M.m03 < (m03+0.01));
  Result := Result and (M.m10 > (m10-0.01)) and (M.m10 < (m10+0.01));
  Result := Result and (M.m11 > (m11-0.01)) and (M.m11 < (m11+0.01));
  Result := Result and (M.m12 > (m12-0.01)) and (M.m12 < (m12+0.01));
  Result := Result and (M.m13 > (m13-0.01)) and (M.m13 < (m13+0.01));
  Result := Result and (M.m20 > (m20-0.01)) and (M.m20 < (m20+0.01));
  Result := Result and (M.m21 > (m21-0.01)) and (M.m21 < (m21+0.01));
  Result := Result and (M.m22 > (m22-0.01)) and (M.m22 < (m22+0.01));
  Result := Result and (M.m23 > (m23-0.01)) and (M.m23 < (m23+0.01));
  Result := Result and (M.m30 > (m30-0.01)) and (M.m30 < (m30+0.01));
  Result := Result and (M.m31 > (m31-0.01)) and (M.m31 < (m31+0.01));
  Result := Result and (M.m32 > (m32-0.01)) and (M.m32 < (m32+0.01));
  Result := Result and (M.m33 > (m33-0.01)) and (M.m33 < (m33+0.01));
end;

procedure TTestMatrix.Add;
var
  M1, M2, M3: Matrix4x4;
begin
  // Arrange:
  M1 := Matrix4x4.Create(
    2, 4, 6, 8,
    1, 3, 5, 7,
    8, 4, 6, 2,
    7, 5, 3, 1
  );

  M2 := Matrix4x4.Create(
    0, 2, 4, 6,
    3, 5, 7, 9,
    6, 4, 2, 0,
    9, 7, 5, 3
  );

  // Act:
  M3 := M1 + M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2+0, 4+2, 6+4, 8+6,
    1+3, 3+5, 5+7, 7+9,
    8+6, 4+4, 6+2, 2+0,
    7+9, 5+7, 3+5, 1+3
  ));
end;

procedure TTestMatrix.AddF;
var
  M1, M2: Matrix4x4;
  F: Float;
begin
  // Arrange:
  M1 := Matrix4x4.Create(
    2, 4, 6, 8,
    1, 3, 5, 7,
    8, 4, 6, 2,
    7, 5, 3, 1
  );
  F := 5;

  // Act:
  M2 := M1 + F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2+F, 4+F, 6+F, 8+F,
    1+F, 3+F, 5+F, 7+F,
    8+F, 4+F, 6+F, 2+F,
    7+F, 5+F, 3+F, 1+F
  ));
end;

procedure TTestMatrix.adjugate;
var
  M: Matrix4x4;
begin
  // Arrange:
  M := Matrix4x4.Create(
    2, 1, 3, 4,
    3, 2, 1, 4,
    5, 2, 4, 1,
    8, 2, 5, 1
    );
  // Act:
  M := M.adjugate;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
      6,  -7,  31, -27,
     28, -21, -77,  49,
    -18,  21, -23,  11,
    -14,  -7,  21,  -7
   ));
end;


procedure TTestMatrix.cofactor;
var
  M: Matrix4x4;
begin
  // Arrange:
  M := Matrix4x4.Create(
    2, 1, 3, 4,
    3, 2, 1, 4,
    5, 2, 4, 1,
    8, 2, 5, 1
    );
  // Act:
  M := M.cofactor;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
      6,   28,  -18, -14,
     -7,  -21,   21,  -7,
     31,  -77,  -23,  21,
    -27,   49,   11,  -7
   ));
end;

procedure TTestMatrix.CreateParameterized;
var
  M: Matrix4x4;
begin
  // Arrange:
  // Act:
  M := Matrix4x4.Create(
    01, 02, 03, 04,
    05, 06, 07, 08,
    09, 10, 11, 12,
    13, 14, 15, 16
  );
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    01, 02, 03, 04,
    05, 06, 07, 08,
    09, 10, 11, 12,
    13, 14, 15, 16
  ));
end;


procedure TTestMatrix.CreateVectors;
var
  M: Matrix4x4;
begin
  // Arrange:
  // Act:
  M := Matrix4x4.Create(
    Vector4.Create(01, 02, 03, 04),
    Vector4.Create(05, 06, 07, 08),
    Vector4.Create(09, 10, 11, 12),
    Vector4.Create(13, 14, 15, 16)
  );
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    01, 02, 03, 04,
    05, 06, 07, 08,
    09, 10, 11, 12,
    13, 14, 15, 16
  ));
end;


procedure TTestMatrix.CreateVectors3;
var
  M: Matrix4x4;
begin
  // Arrange:
  // Act:
  M := Matrix4x4.Create(
    Vector3.Create(01, 02, 03),
    Vector3.Create(05, 06, 07),
    Vector3.Create(09, 10, 11),
    Vector3.Create(13, 14, 15)
  );
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    01, 02, 03, 00,
    05, 06, 07, 00,
    09, 10, 11, 00,
    13, 14, 15, 01
  ));
end;

procedure TTestMatrix.determinant;
var
  M: Matrix4x4;
  F: float;
begin
  // Arrange:
  M := Matrix4x4.Create(
    2, 3,  2,  1,
    5, 4,  1, -4,
   12, 5, -2,  1,
    6, 2, -3,  1
  );
  // Act:
  F := M.determinant;
  // Assert:
  TTest.IsTrue( (F>-200.01) and (F<-199.99) );
end;

procedure TTestMatrix.Divide;
var
  M1, M2, M3: Matrix4x4;
begin
  // Arrange:
  M1 := Matrix4x4.Create(
    2, 4, 6, 8,
    1, 3, 5, 7,
    8, 4, 6, 2,
    7, 5, 3, 1
  );

  M2 := Matrix4x4.Create(
    1, 2, 4, 6,
    3, 5, 7, 9,
    6, 4, 2, 1,
    9, 7, 5, 3
  );

  // Act:
  M3 := M1 / M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2/1, 4/2, 6/4, 8/6,
    1/3, 3/5, 5/7, 7/9,
    8/6, 4/4, 6/2, 2/1,
    7/9, 5/7, 3/5, 1/3
  ));
end;

procedure TTestMatrix.DivideF;
var
  M1, M2: Matrix4x4;
  F: Float;
begin
  // Arrange:
  M1 := Matrix4x4.Create(
    2, 4, 6, 8,
    1, 3, 5, 7,
    8, 4, 6, 2,
    7, 5, 3, 1
  );
  F := 5;

  // Act:
  M2 := M1 / F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2/F, 4/F, 6/F, 8/F,
    1/F, 3/F, 5/F, 7/F,
    8/F, 4/F, 6/F, 2/F,
    7/F, 5/F, 3/F, 1/F
  ));
end;

procedure TTestMatrix.dotMM;
var
  M1, M2, M3: Matrix4x4;
begin
  // Arrange:
  M1 := Matrix4x4.Create(
    2, 4, 6, 8,
    1, 3, 5, 7,
    8, 4, 6, 2,
    7, 5, 3, 1
  );

  M2 := Matrix4x4.Create(
    1, 2, 4, 6,
    3, 5, 7, 9,
    6, 4, 2, 1,
    9, 7, 5, 3
  );

  // Act:
  M3 := M1.dot(M2);
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    122, 104, 088, 078,
    103, 086, 070, 059,
    074, 074, 082, 096,
    049, 058, 074, 093
  ));
end;

procedure TTestMatrix.dotVM;
var
  M1: Matrix4x4;
  V1,V2: Vector4;
begin
  // Arrange:
  M1 := Matrix4x4.Create(
    -03, 000, 003, 002,
    001, 007, -01, 009,
    -03, 000, 003, 002,
    001, 007, -01, 009
  );
  V1 := Vector4.Create( 2, -3, 4, -1 );
  // Act:
  V2 := M1.dot(V1);
  // Assert:
  TTest.IsTrue((V2.X > 03.99)  and (V2.X < 04.01));
  TTest.IsTrue((V2.Y > -32.01) and (V2.Y < -31.99));
  TTest.IsTrue((V2.Z > 03.99)  and (V2.Z < 04.01));
  TTest.IsTrue((V2.W > -32.01) and (V2.W < -31.99));
end;

procedure TTestMatrix.identity;
var
  M: Matrix4x4;
begin
  // Arrange:
  // Act:
  M := Matrix4x4.Identity;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    1, 0, 0, 0,
    0, 1, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1
  ));
end;

procedure TTestMatrix.inverse;
var
  M: Matrix4x4;
  M1: Matrix4x4;
  M2: Matrix4x4;
begin
  // Arrange:
  M := Matrix4x4.Create(
    2, 1, 3, 4,
    3, 2, 1, 4,
    5, 2, 4, 1,
    8, 2, 5, 1
    );
  // Act:
  M1 := M.inverse;
  M2 := M1.dot(M);
  // Assert:
  TTest.IsTrue( CheckMatrix( M1,
    -3/35,   1/10,  -31/70,   27/70,
     -2/5,   3/10,   11/10,   -7/10,
     9/35,  -3/10,   23/70,  -11/70,
      1/5,   1/10,   -3/10,    1/10
  ));
  //- Any matrix multiplied by it's own inverse should be identity.
  TTest.IsTrue( CheckMatrix( M2,
    1, 0, 0, 0,
    0, 1, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1
  ));
end;

procedure TTestMatrix.Multiply;
var
  M1, M2, M3: Matrix4x4;
begin
  // Arrange:
  M1 := Matrix4x4.Create(
    2, 4, 6, 8,
    1, 3, 5, 7,
    8, 4, 6, 2,
    7, 5, 3, 1
  );

  M2 := Matrix4x4.Create(
    0, 2, 4, 6,
    3, 5, 7, 9,
    6, 4, 2, 0,
    9, 7, 5, 3
  );

  // Act:
  M3 := M1 * M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2*0, 4*2, 6*4, 8*6,
    1*3, 3*5, 5*7, 7*9,
    8*6, 4*4, 6*2, 2*0,
    7*9, 5*7, 3*5, 1*3
  ));
end;

procedure TTestMatrix.MultiplyF;
var
  M1, M2: Matrix4x4;
  F: Float;
begin
  // Arrange:
  M1 := Matrix4x4.Create(
    2, 4, 6, 8,
    1, 3, 5, 7,
    8, 4, 6, 2,
    7, 5, 3, 1
  );
  F := 5;

  // Act:
  M2 := M1 * F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2*F, 4*F, 6*F, 8*F,
    1*F, 3*F, 5*F, 7*F,
    8*F, 4*F, 6*F, 2*F,
    7*F, 5*F, 3*F, 1*F
  ));
end;

procedure TTestMatrix.rotationX;
var
  M: Matrix4x4;
begin
  // Arrange:
  // Act:
  M := Matrix4x4.rotationX(30);
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    1,     0,     0,  0,
    0, 0.866,  -0.5,  0,
    0,   0.5, 0.866,  0,
    0,     0,     0,  1
  ));
end;

procedure TTestMatrix.rotationY;
var
  M: Matrix4x4;
begin
  // Arrange:
  // Act:
  M := Matrix4x4.rotationY(45);
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    0.7071,  0,  0.7071,  0,
         0,  1,       0,  0,
   -0.7071,  0,  0.7071,  0,
         0,  0,       0,  1
  ));
end;

procedure TTestMatrix.rotationZ;
var
  M: Matrix4x4;
begin
  // Arrange:
  // Act:
  M := Matrix4x4.rotationZ(53.1);
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    0.6, -0.8, 0, 0,
    0.8,  0.6, 0, 0,
    0,      0, 1, 0,
    0,      0, 0, 1
  ));
end;

procedure TTestMatrix.scale;
var
  V: Vector3;
  M: Matrix4x4;
begin
  // Arrange:
  V := Vector3.Create( 2, 3, 4 );
  // Act:
  M := Matrix4x4.scale( V );
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    V.X,   0,   0, 0,
      0, V.Y,   0, 0,
      0,   0, V.Z, 0,
      0,   0,   0, 1
  ));
end;

procedure TTestMatrix.Subtract;
var
  M1, M2, M3: Matrix4x4;
begin
  // Arrange:
  M1 := Matrix4x4.Create(
    2, 4, 6, 8,
    1, 3, 5, 7,
    8, 4, 6, 2,
    7, 5, 3, 1
  );

  M2 := Matrix4x4.Create(
    0, 2, 4, 6,
    3, 5, 7, 9,
    6, 4, 2, 0,
    9, 7, 5, 3
  );

  // Act:
  M3 := M1 - M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2-0, 4-2, 6-4, 8-6,
    1-3, 3-5, 5-7, 7-9,
    8-6, 4-4, 6-2, 2-0,
    7-9, 5-7, 3-5, 1-3
  ));
end;

procedure TTestMatrix.SubtractF;
var
  M1, M2: Matrix4x4;
  F: Float;
begin
  // Arrange:
  M1 := Matrix4x4.Create(
    2, 4, 6, 8,
    1, 3, 5, 7,
    8, 4, 6, 2,
    7, 5, 3, 1
  );
  F := 5;

  // Act:
  M2 := M1 - F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2-F, 4-F, 6-F, 8-F,
    1-F, 3-F, 5-F, 7-F,
    8-F, 4-F, 6-F, 2-F,
    7-F, 5-F, 3-F, 1-F
  ));
end;

procedure TTestMatrix.translation;
var
  V: Vector3;
  M: Matrix4x4;
begin
  // Arrange:
  V := Vector3.Create( 2, 3, 4 );
  // Act:
  M := Matrix4x4.translation( V );
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
      1,   0,   0, V.X,
      0,   1,   0, V.Y,
      0,   0,   1, V.Z,
      0,   0,   0, 1
  ));
end;

procedure TTestMatrix.transpose;
var
  M: Matrix4x4;
begin
  // Arrange:
  M := Matrix4x4.Create(
    01, 02, 03, 04,
    05, 06, 07, 08,
    09, 10, 11, 12,
    13, 14, 15, 16
  );
  // Act:
  M := M.transpose;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    01, 05, 09, 13,
    02, 06, 10, 14,
    03, 07, 11, 15,
    04, 08, 12, 16
  ));
end;

initialization
  TestSuite.RegisterTestCase(TTestMatrix);

end.

