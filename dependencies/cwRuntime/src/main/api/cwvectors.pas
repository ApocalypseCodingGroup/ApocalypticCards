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
///  <summary>
///    Library for handling vector/matrix operations in cpu.
///  </summary>
unit cwVectors;
{$ifdef fpc}
  {$mode delphiunicode}
  {$modeswitch arrayoperators-}
  {.$coperators on}
  {.$modeswitch advancedrecords+}
{$endif}

interface

{$region 'Supporting types.'}
type
  ///  <summary>
  ///    float aliases single, it may be altered later if higher precision
  ///    becomes necessary.
  ///  </summary>
  float = single;

  ///  <summary>
  ///    Used for the assignment of vectors from arrays of floats.
  ///  </summary>
  TArrayOfFloat = array of float;
{$endregion}

{$region ' Vector2'}

  ///  <summary>
  ///    Represents a vector with 2 elements (X,Y / U,V)
  ///  </summary>
  Vector2 = record

    ///  <summary>
    ///    Allows creation of a vector from an array of floats.
    ///    (Size of array must match size of vector)
    ///  </summary>
    class operator Implicit( a: TArrayOfFloat ): Vector2;

    ///  <summary>
    ///    Allows addition of a vector to an array, and returns the
    //     resulting vector.
    ///  </summary>
    class operator Add(a: Vector2; b: TArrayOfFloat): Vector2;

    ///  <summary>
    ///    Allows addition of a vector to an array, and returns the
    ///    resulting vector.
    ///  </summary>
    class operator Add(a: TArrayOfFloat; b: Vector2): Vector2;

    ///  <summary>
    ///    Allows subtraction of an array from a vector and returns
    ///    the resulting vector.
    ///  </summary>
    class operator Subtract(a: Vector2; b: TArrayOfFloat): Vector2;

    ///  <summary>
    ///    Allows subtraction of a vector from an array and returns
    ///    the resulting vector.
    ///  </summary>
    class operator Subtract(a: TArrayOfFloat; b: Vector2): Vector2;

    ///  <summary>
    ///    Allows the multiplication of a vector and an array, and returns
    ///    the resulting vector. (hadamard)
    ///  </summary>
    class operator Multiply(a: Vector2; b: TArrayOfFloat): Vector2;

    ///  <summary>
    ///    Allows the multiplication of an array and a vector, and returns
    ///    the resulting vector. (hadamard)
    ///  </summary>
    class operator Multiply(a: TArrayOfFloat; b: Vector2): Vector2;

    ///  <summary>
    ///    Allows the division of a vector by an array and returns the
    ///    resulting vector.
    ///  </summary>
    class operator Divide(a: Vector2; b: TArrayOfFloat): Vector2;

    ///  <summary>
    ///    Allows the division of an array by a vector and returns the
    ///    resulting vector.
    ///  </summary>
    class operator Divide(a: TArrayOfFloat; b: Vector2): Vector2;

    ///  <summary>
    ///    Operator overload provides for addition of one vector to another.
    ///  </summary>
    class operator Add(a, b: Vector2): Vector2;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a vector.
    ///  </summary>
    class operator Add(a: Vector2; b: float): Vector2;

    ///  <summary>
    ///    Operator overload provides for subtraction of one vector from
    ///    another.
    ///  </summary>
    class operator Subtract(a, b: Vector2): Vector2;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a vector.
    ///  </summary>
    class operator Subtract(a: Vector2; b: float): Vector2;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one vector by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply(a, b: Vector2): Vector2;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a vector by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply(a: Vector2; b: float): Vector2;

    ///  <summary>
    ///    Operator overload to provide for division of one vector by
    ///    another.
    ///  </summary>
    class operator Divide(a, b: Vector2): Vector2;

    ///  <summary>
    ///    Operator overload to provide for division of a vector by a
    ///    float.
    ///  </summary>
    class operator Divide(a: Vector2; b: float): Vector2;

    ///  <summary>
    ///    Creates a new vector based on X,Y values.
    ///  </summary>
    class function Create( X, Y: float ): Vector2; overload; static;

    ///  <summary>
    ///    Returns the dot product of this vector with another.
    ///  </summary>
    function dot(a: Vector2): float;

    ///  <summary>
    ///    Returns this vector normaized.
    ///  </summary>
    function normalized: Vector2;

    ///  <summary>
    ///    Returns the unit vector of this one.
    ///  </summary>
    function UnitVector: Vector2;

    ///  <summary>
    ///    Returns the magnitude of the vector.
    ///  </summary>
    function magnitude: float;

    case uint8 of
      0: (
        X: float;
        Y: float;
      );
      1: (
        U: float;
        V: float;
      );
      2: (
        S: float;
        T: float;
      );
  end;
{$endregion}

{$region ' Vector3'}

  ///  <summary>
  ///    Represents a vector with 3 elements (X,Y,Z), (R,G,B).
  ///  </summary>
  Vector3 = record

    ///  <summary>
    ///    Allows creation of a vector from an array of floats.
    ///    (Size of array must match size of vector)
    ///  </summary>
    class operator Implicit( a: TArrayOfFloat ): Vector3;

    ///  <summary>
    ///    Allows creation of a vector from an array of floats.
    ///    (Size of array must match size of vector)
    ///  </summary>
    class operator Explicit( a: TArrayOfFloat ): Vector3;

    ///  <summary>
    ///    Allows addition of a vector to an array, and returns the
    //     resulting vector.
    ///  </summary>
    class operator Add(a: Vector3; b: TArrayOfFloat): Vector3;

    ///  <summary>
    ///    Allows addition of a vector to an array, and returns the
    ///    resulting vector.
    ///  </summary>
    class operator Add(a: TArrayOfFloat; b: Vector3): Vector3;

    ///  <summary>
    ///    Allows subtraction of an array from a vector and returns
    ///    the resulting vector.
    ///  </summary>
    class operator Subtract(a: Vector3; b: TArrayOfFloat): Vector3;

    ///  <summary>
    ///    Allows subtraction of a vector from an array and returns
    ///    the resulting vector.
    ///  </summary>
    class operator Subtract(a: TArrayOfFloat; b: Vector3): Vector3;

    ///  <summary>
    ///    Allows the multiplication of a vector and an array, and returns
    ///    the resulting vector. (hadamard)
    ///  </summary>
    class operator Multiply(a: Vector3; b: TArrayOfFloat): Vector3;

    ///  <summary>
    ///    Allows the multiplication of an array and a vector, and returns
    ///    the resulting vector. (hadamard)
    ///  </summary>
    class operator Multiply(a: TArrayOfFloat; b: Vector3): Vector3;

    ///  <summary>
    ///    Allows the division of a vector by an array and returns the
    ///    resulting vector.
    ///  </summary>
    class operator Divide(a: Vector3; b: TArrayOfFloat): Vector3;

    ///  <summary>
    ///    Allows the division of an array by a vector and returns the
    ///    resulting vector.
    ///  </summary>
    class operator Divide(a: TArrayOfFloat; b: Vector3): Vector3;

    ///  <summary>
    ///    Operator overload provides for addition of one vector to another.
    ///  </summary>
    class operator Add(a, b: Vector3): Vector3;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a vector.
    ///  </summary>
    class operator Add(a: Vector3; b: float): Vector3;

    ///  <summary>
    ///    Operator overload provides for subtraction of one vector from
    ///    another.
    ///  </summary>
    class operator Subtract(a, b: Vector3): Vector3;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a vector.
    ///  </summary>
    class operator Subtract(a: Vector3; b: float): Vector3;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one vector by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply(a, b: Vector3): Vector3;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a vector by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply(a: Vector3; b: float): Vector3;

    ///  <summary>
    ///    Operator overload to provide for division of one vector by
    ///    another.
    ///  </summary>
    class operator Divide(a, b: Vector3): Vector3;

    ///  <summary>
    ///    Operator overload to provide for division of a vector by a
    ///    float.
    ///  </summary>
    class operator Divide(a: Vector3; b: float): Vector3;

    ///  <summary>
    ///    Allows assignment of a Vector2 to the Vector3, dropping the Z
    ///    element.
    ///  </summary>
    class operator Implicit(a: Vector2): Vector3;

    ///  <summary>
    ///    Allows assignment of a Vector2 to the Vector3, dropping the Z
    ///    element.
    ///  </summary>
    class operator Explicit(a: Vector2): Vector3;

    ///  <summary>
    ///    Allows assignment of a Vector3 to the Vector2, setting the Z
    ///    element to 0;
    ///  </summary>
    class operator Implicit(a: Vector3): Vector2;

    ///  <summary>
    ///    Allows assignment of a Vector3 to the Vector2, setting the Z
    ///    element to 0;
    ///  </summary>
    class operator Explicit(a: Vector3): Vector2;

    ///  <summary>
    ///    Creates a new vector from X,Y,Z values.
    ///  </summary>
    class function Create( X, Y, Z: float ): Vector3; overload; static;

    ///  <summary>
    ///    Returns the dot product of this vector with another.
    ///  </summary>
    function dot(a: Vector3): float;

    ///  <summary>
    ///    Returns the cross product of this vector with another.
    ///  </summary>
    function cross(a: Vector3): Vector3;

    ///  <summary>
    ///    Returns this vector normaized.
    ///  </summary>
    function normalized: Vector3;

    ///  <summary>
    ///    Returns the unit vector of this one.
    ///  </summary>
    function UnitVector: Vector3;

    ///  <summary>
    ///    Returns the magnitude of the vector.
    ///  </summary>
    function magnitude: float;

      case uint8 of
      0: (
          X: float;
          Y: float;
          Z: float;
      );
      1: (
          R: float;
          G: float;
          B: float;
      );
  end;

  ///  <summary>
  ///    An alias of Vector3 which represents a point in 3d space.
  ///  </summary>
  Vertex = Vector3;
{$endregion}

{$region ' Vector4'}
  ///  <summary>
  ///    Represents a vector with four elements.
  ///   (X,Y,Z,W or R,G,B,A or U1,V1,U2,V2)
  ///  </summary>
  Vector4 = record

    ///  <summary>
    ///    Allows creation of a vector from an array of floats.
    ///    (Size of array must match size of vector)
    ///  </summary>
    class operator Implicit( a: TArrayOfFloat ): Vector4;

    ///  <summary>
    ///    Allows creation of a vector from an array of floats.
    ///    (Size of array must match size of vector)
    ///  </summary>
    class operator Explicit( a: TArrayOfFloat ): Vector4;

    ///  <summary>
    ///    Allows addition of a vector to an array, and returns the
    //     resulting vector.
    ///  </summary>
    class operator Add(a: Vector4; b: TArrayOfFloat): Vector4;

    ///  <summary>
    ///    Allows addition of a vector to an array, and returns the
    ///    resulting vector.
    ///  </summary>
    class operator Add(a: TArrayOfFloat; b: Vector4): Vector4;

    ///  <summary>
    ///    Allows subtraction of an array from a vector and returns
    ///    the resulting vector.
    ///  </summary>
    class operator Subtract(a: Vector4; b: TArrayOfFloat): Vector4;

    ///  <summary>
    ///    Allows subtraction of a vector from an array and returns
    ///    the resulting vector.
    ///  </summary>
    class operator Subtract(a: TArrayOfFloat; b: Vector4): Vector4;

    ///  <summary>
    ///    Allows the multiplication of a vector and an array, and returns
    ///    the resulting vector. (hadamard)
    ///  </summary>
    class operator Multiply(a: Vector4; b: TArrayOfFloat): Vector4;

    ///  <summary>
    ///    Allows the multiplication of an array and a vector, and returns
    ///    the resulting vector. (hadamard)
    ///  </summary>
    class operator Multiply(a: TArrayOfFloat; b: Vector4): Vector4;

    ///  <summary>
    ///    Allows the division of a vector by an array and returns the
    ///    resulting vector.
    ///  </summary>
    class operator Divide(a: Vector4; b: TArrayOfFloat): Vector4;

    ///  <summary>
    ///    Allows the division of an array by a vector and returns the
    ///    resulting vector.
    ///  </summary>
    class operator Divide(a: TArrayOfFloat; b: Vector4): Vector4;

    ///  <summary>
    ///    Operator overload provides for addition of one vector to another.
    ///  </summary>
    class operator Add(a, b: Vector4): Vector4;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a vector.
    ///  </summary>
    class operator Add(a: Vector4; b: float): Vector4;

    ///  <summary>
    ///    Operator overload provides for subtraction of one vector from
    ///    another.
    ///  </summary>
    class operator Subtract(a, b: Vector4): Vector4;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a vector.
    ///  </summary>
    class operator Subtract(a: Vector4; b: float): Vector4;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one vector by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply(a, b: Vector4): Vector4;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a vector by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply(a: Vector4; b: float): Vector4;

    ///  <summary>
    ///    Operator overload to provide for division of one vector by
    ///    another.
    ///  </summary>
    class operator Divide(a, b: Vector4): Vector4;

    ///  <summary>
    ///    Operator overload to provide for division of a vector by a
    ///    float.
    ///  </summary>
    class operator Divide(a: Vector4; b: float): Vector4;

    ///  <summary>
    ///    Allows assignment of Vector3 to Vector4 in which W is set to 1.
    ///  </summary>
    class operator Implicit(a: Vector3): Vector4;

    ///  <summary>
    ///    Allows assignment of Vector3 to Vector4 in which W is set to 1.
    ///  </summary>
    class operator Explicit(a: Vector3): Vector4;

    ///  <summary>
    ///    Allows assignment of Vector2 to Vector4 in which Z is set 0 and W
    ///    is set to 1.
    ///  </summary>
    class operator Implicit(a: Vector2): Vector4;

    ///  <summary>
    ///    Allows assignment of Vector2 to Vector4 in which Z is set 0 and W
    ///    is set to 1.
    ///  </summary>
    class operator Explicit(a: Vector2): Vector4;

    ///  <summary>
    ///    Allows assignment of a Vector4 to a Vector3 in which the W
    ///    coordinate is dropped.
    ///  </summary>
    class operator Implicit(a: Vector4): Vector3;

    ///  <summary>
    ///    Allows assignment of a Vector4 to a Vector3 in which the W
    ///    coordinate is dropped.
    ///  </summary>
    class operator Explicit(a: Vector4): Vector3;

    ///  <summary>
    ///    Allows assignment of a Vector4 to a Vector2 in which the Z and W
    ///    coordinates are dropped.
    ///  </summary>
    class operator Implicit(a: Vector4): Vector2;

    ///  <summary>
    ///    Allows assignment of a Vector4 to a Vector2 in which the Z and W
    ///    coordinates are dropped.
    ///  </summary>
    class operator Explicit(a: Vector4): Vector2;

    ///  <summary>
    ///    Creates a new vector from X,Y,Z,W values.
    ///  </summary>
    class function Create( X, Y, Z, W: float ): Vector4; overload; static;

    ///  <summary>
    ///    Returns the dot product of this vector with another.
    ///  </summary>
    function dot(a: Vector4): float;

    ///  <summary>
    ///    Returns this vector normaized.
    ///  </summary>
    function normalized: Vector4;

    ///  <summary>
    ///    Returns the unit vector of this vector.
    ///  </summary>
    function UnitVector: Vector4;

    ///  <summary>
    ///    Returns the magnitude of the vector.
    ///  </summary>
    function magnitude: float;

      case uint8 of
      0: (
          X: float;
          Y: float;
          Z: float;
          W: float;
      );
      1: (
          R: float;
          G: float;
          B: float;
          A: float;
      );
      2: (
          U1: float;
          V1: float;
          U2: float;
          V2: float;
      );
  end;

{$endregion}

{$region ' Matrix2x2'}

  ///  <summary>
  ///    Represents a 2x2 matrix.
  ///    Addressed as xy (m21 = m.x=2 m.y=1)
  ///  </summary>
  Matrix2x2 = record

    m00, m10,
    m01, m11: float;

    ///  <summary>
    ///    Operator overload provides for addition of one Matrix to another.
    ///  </summary>
    class operator Add(a, b: Matrix2x2): Matrix2x2;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a Matrix.
    ///  </summary>
    class operator Add(a: Matrix2x2; b: float): Matrix2x2;

    ///  <summary>
    ///    Operator overload provides for subtraction of one Matrix from
    ///    another.
    ///  </summary>
    class operator Subtract(a, b: Matrix2x2): Matrix2x2;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a Matrix.
    ///  </summary>
    class operator Subtract(a: Matrix2x2; b: float): Matrix2x2;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one Matrix by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply(a, b: Matrix2x2): Matrix2x2;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a Matrix by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply(a: Matrix2x2; b: float): Matrix2x2;

    ///  <summary>
    ///    Operator overload to provide for division of one Matrix by
    ///    another.
    ///  </summary>
    class operator Divide(a, b: Matrix2x2): Matrix2x2;

    ///  <summary>
    ///    Operator overload to provide for division of a Matrix by a
    ///    float.
    ///  </summary>
    class operator Divide(a: Matrix2x2; b: float): Matrix2x2;

    ///  <summary>
    ///    Creates a new matrix based on the 16 floating point values provided.
    ///    Matrix addressed XxY
    ///  </summary>
    class function Create( _m00, _m10, _m01, _m11: float ): Matrix2x2; overload; static;

    ///  <summary>
    ///    The dot product of another matrix with this one.
    ///  </summary>
    function dot( a: Matrix2x2 ): Matrix2x2; overload;

    ///  <summary>
    ///    Provides the dot product of a vector with this matrix.
    ///  </summary>
    function dot( a: Vector2 ): Vector2; overload;

    ///  <summary>
    ///    Returns a matrix which is the transpose of this one.
    ///  </summary>
    function transpose: Matrix2x2;

    ///  <summary>
    ///    Returns the identity matrix.
    ///  </summary>
    class function identity: Matrix2x2; static;

    ///  <summary>
    ///    Returns a matrix to perform translation based on the vector t.
    ///  </summary>
    class function translation( t: Vector2 ): Matrix2x2; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation (around z) to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotation( degrees: float ): Matrix2x2; static;

    ///  <summary>
    ///    Returns a matrix to perform scaling in three dimensions based on
    ///    the vector s.
    ///  </summary>
    class function scale( s: Vector2 ): Matrix2x2; static;

    ///  <summary>
    ///    Returns the determinant of the matrix.
    ///  </summary>
    function determinant: float;

    ///  <summary>
    ///    Returns the cofactor of the matrix.
    ///  </summary>
    function cofactor: Matrix2x2;

    ///  <summary>
    ///    Returns the adjugate of the matrix.
    ///  </summary>
    function adjugate: Matrix2x2;

    ///  <summary>
    ///    Returns the inverse of the matrix.
    ///  </summary>
    function inverse: Matrix2x2;

  end;

{$endregion}

{$region ' Matrix3x3'}

  ///  <summary>
  ///    Represents a 3x3 matrix.
  ///    Addressed as xy (m21 = m.x=2 m.y=1)
  ///  </summary>
  Matrix3x3 = record

    m00, m10, m20,
    m01, m11, m21,
    m02, m12, m22: float;

    ///  <summary>
    ///    Operator overload provides for addition of one Matrix to another.
    ///  </summary>
    class operator Add(a, b: Matrix3x3): Matrix3x3;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a Matrix.
    ///  </summary>
    class operator Add(a: Matrix3x3; b: float): Matrix3x3;

    ///  <summary>
    ///    Operator overload provides for subtraction of one Matrix from
    ///    another.
    ///  </summary>
    class operator Subtract(a, b: Matrix3x3): Matrix3x3;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a Matrix.
    ///  </summary>
    class operator Subtract(a: Matrix3x3; b: float): Matrix3x3;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one Matrix by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply(a, b: Matrix3x3): Matrix3x3;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a Matrix by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply(a: Matrix3x3; b: float): Matrix3x3;

    ///  <summary>
    ///    Operator overload to provide for division of one Matrix by
    ///    another.
    ///  </summary>
    class operator Divide(a, b: Matrix3x3): Matrix3x3;

    ///  <summary>
    ///    Operator overload to provide for division of a Matrix by a
    ///    float.
    ///  </summary>
    class operator Divide(a: Matrix3x3; b: float): Matrix3x3;

    ///  <summary>
    ///    Creates a new matrix based on the 16 floating point values provided.
    ///    Matrix addressed XxY
    ///  </summary>
    class function Create( _m00, _m10, _m20, _m01, _m11, _m21, _m02, _m12, _m22: float ): Matrix3x3; overload; static;

    ///  <summary>
    ///    The dot product of another matrix with this one.
    ///  </summary>
    function dot( a: Matrix3x3 ): Matrix3x3; overload;

    ///  <summary>
    ///    Provides the dot product of a vector with this matrix.
    ///  </summary>
    function dot( a: Vector3 ): Vector3; overload;

    ///  <summary>
    ///    Returns a matrix which is the transpose of this one.
    ///  </summary>
    function transpose: Matrix3x3;

    ///  <summary>
    ///    Returns the identity matrix.
    ///  </summary>
    class function identity: Matrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform translation based on the vector t.
    ///  </summary>
    class function translation( t: Vector3 ): Matrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around x to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationX( degrees: float ): Matrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around y to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationY( degrees: float ): Matrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around z to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationZ( degrees: float ): Matrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform scaling in three dimensions based on
    ///    the vector s.
    ///  </summary>
    class function scale( s: Vector3 ): Matrix3x3; static;

    ///  <summary>
    ///    Returns the determinant of the matrix.
    ///  </summary>
    function determinant: float;

    ///  <summary>
    ///    Returns the cofactor of this matrix.
    ///  </summary>
    function cofactor: Matrix3x3;

    ///  <summary>
    ///    Returns the adjugate of this matrix.
    ///  </summary>
    function adjugate: Matrix3x3;

    ///  <summary>
    ///    Returns the inverse of this matrix.
    ///  </summary>
    function inverse: Matrix3x3;

  end;

{$endregion}

{$region ' Matrix4x4'}

  ///  <summary>
  ///    Represents a 4x4 matrix.
  ///    Addressed as xy (m21 = m.x=2 m.y=1)
  ///  </summary>
  Matrix4x4 = record

    m00, m10, m20, m30,
    m01, m11, m21, m31,
    m02, m12, m22, m32,
    m03, m13, m23, m33: float;

    ///  <summary>
    ///    Operator overload provides for addition of one Matrix to another.
    ///  </summary>
    class operator Add(a, b: Matrix4x4): Matrix4x4;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a Matrix.
    ///  </summary>
    class operator Add(a: Matrix4x4; b: float): Matrix4x4;

    ///  <summary>
    ///    Operator overload provides for subtraction of one Matrix from
    ///    another.
    ///  </summary>
    class operator Subtract(a, b: Matrix4x4): Matrix4x4;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a Matrix.
    ///  </summary>
    class operator Subtract(a: Matrix4x4; b: float): Matrix4x4;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one Matrix by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply(a, b: Matrix4x4): Matrix4x4;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a Matrix by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply(a: Matrix4x4; b: float): Matrix4x4;

    ///  <summary>
    ///    Operator overload to provide for division of one Matrix by
    ///    another.
    ///  </summary>
    class operator Divide(a, b: Matrix4x4): Matrix4x4;

    ///  <summary>
    ///    Operator overload to provide for division of a Matrix by a
    ///    float.
    ///  </summary>
    class operator Divide(a: Matrix4x4; b: float): Matrix4x4;

    ///  <summary>
    ///    Creates a new matrix based on the 16 floating point values provided.
    ///    Matrix addressed XxY
    ///  </summary>
    class function Create( _m00, _m10, _m20, _m30, _m01, _m11, _m21, _m31, _m02, _m12, _m22, _m32, _m03, _m13, _m23, _m33: float ): Matrix4x4; overload; static;

    ///  <summary>
    ///    Creates a new matrix from four row vectors of length 3.
    ///    Remaining space is filled with identity.
    ///  </summary>
    class function Create( Row0: Vector3; Row1: Vector3; Row2: Vector3; Row3: Vector3 ): Matrix4x4; overload; static;

    ///  <summary>
    ///    Creates a new matrix from four row vectors.
    ///  </summary>
    class function Create( Row0: Vector4; Row1: Vector4; Row2: Vector4; Row3: Vector4 ): Matrix4x4; overload; static;

    ///  <summary>
    ///    The dot product of another matrix with this one.
    ///  </summary>
    function dot( a: Matrix4x4 ): Matrix4x4; overload;

    ///  <summary>
    ///    Provides the dot product of a vector with this matrix.
    ///  </summary>
    function dot( a: Vector4 ): Vector4; overload;

    ///  <summary>
    ///    Returns a matrix which is the transpose of this one.
    ///  </summary>
    function transpose: Matrix4x4;

    ///  <summary>
    ///    Returns the identity matrix.
    ///  </summary>
    class function identity: Matrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform translation based on the vector t.
    ///  </summary>
    class function translation( t: Vector3 ): Matrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around x to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationX( degrees: float ): Matrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around y to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationY( degrees: float ): Matrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around z to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationZ( degrees: float ): Matrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform scaling in three dimensions based on
    ///    the vector s.
    ///  </summary>
    class function scale( s: Vector3 ): Matrix4x4; static;

    ///  <summary>
    ///    Returns the adjugate of this matrix.
    ///  </summary>
    function adjugate: Matrix4x4;

    ///  <summary>
    ///    Returns the cofactor of this matrix.
    ///  </summary>
    function cofactor: Matrix4x4;

    ///  <sumamry>
    ///    Returns the determinant of the matrix.
    ///  </summary>
    function determinant: float;

    ///  <summary>
    ///    Returns the inverse of this matrix.
    ///  </summary>
    function inverse: Matrix4x4;

    ///  <summary>
    ///    Creates a view matrix based on the eye position, target(look-at) and
    ///    the up-direction for the coordinate space.
    ///  </summary>
    class function CreateView( eye: Vector3; target: Vector3; Up: Vector3 ): Matrix4x4; static;

    ///  <summary>
    ///    Creates a perspective matrix based on the viewing angle, aspect ratio,
    ///    near and far clipping planes.
    ///  </summary>
    class function CreatePerspective( angleDeg: single; ratio: single; _near: single; _far: single ): Matrix4x4; static;

  end;

{$endregion}

{$region ' Ray'}

  ///  <summary>
  ///    Represents a ray in 3D space.
  ///  </summary>
  Ray = record
  private
    fDirection: Vector3;
  private
    procedure setDirection(const Value: Vector3);
  public
    ///  <summary>
    ///    A vertex representing the initial point of the ray in 3d space.
    ///  </summary>
    Origin: Vertex;

    ///  <summary>
    ///    The length of the ray.
    ///  </summmary>
    Length: float;

    ///  <summary>
    ///    A unit vector representing the direction that the ray is cast
    ///    away from the origin.
    ///  </summary>
    property Direction: Vector3 read fDirection write setDirection;

    ///  <summary>
    ///    Creates a new ray between two vertices representing the
    ///    start and end of the ray.
    ///  </summary>
    class function Create( aOrigin: Vertex; aDestination: Vertex ): Ray; overload; static;

    ///  <summary>
    ///    Creates a new ray given an origin, direction and length.
    ///  </summary>
    class function Create( aOrigin: Vertex; aDirection: Vector3; aLength: float ): Ray; overload; static;

    ///  <summary>
    ///    Performs Origin + (Direction * Length) to get the terminating
    ///    vertex for the ray. This will raise an exception if Length is
    ///    either INF (infinity) or NAN (not-a-number).
    ///  </summary>
    function Destination: Vertex;
  end;

{$endregion}

{$region ' Plane'}

  ///  <summary>
  ///    Represents a plane in 3D space as a pair of unit vectors.
  ///  </summary>
  Plane = record
  private
    fNormal: Vector3;
  private
    procedure setNormal(const Value: Vector3);
  public
    Origin: Vertex;
    property Normal: Vector3 read fNormal write setNormal;
  public
    ///  <summary>
    ///    Creates a plane when given an origin and a normal.
    ///  </summary>
    class function Create( aOrigin: Vertex; aNormal: Vector3 ): Plane; static;

    ///  <summary>
    ///    Returns the distance of vertex P from the plane.
    ///  </summary>
//    function distance( P: Vertex ): float;

    ///  <summary>
    ///    Returns true if the provided ray intersects with this plane.
    ///  </summary>
    function Intersect( const aRay: Ray ): boolean;

    ///  <summary>
    ///    Returns a vertex which represents the intersection of a ray
    ///    with this plane.
    ///  </summary>
    function Intersection( const aRay: Ray ): Vertex;
  end;

{$endregion}

{$region ' Sphere'}

  ///  <summary>
  ///    Represents a sphere as a vertex (as it's origin) and a radius.
  ///  </summary>
  Sphere = record

    ///  <summary>
    ///    A Vertex representing the location of the sphere.
    ///  </summary>
    Origin: Vertex;

    ///  <summary>
    ///    Represents the radius of the sphere about the origin.
    ///  </summary>
    Radius: float;

    ///  <summary>
    ///    Returns true of the provided ray intersects with this sphere.
    ///  </summary>
//    function Intersect( const aRay: Ray ): boolean;

    ///  <summary>
    ///    Returns a vertex which represents the intersection of a ray with
    ///    this sphere.
    ///  </summary>
//    function Intersection( const aRay: Ray ): Vertex;
  end;

{$endregion}

implementation
uses
  math,
  sysutils;

{$region ' Exceptions'}

type
  EInvalidArrayLength2 = class(Exception)
    constructor Create; reintroduce;
  end;

  EInvalidArrayLength3 = class(Exception)
    constructor Create; reintroduce;
  end;

  EInvalidArrayLength4 = class(Exception)
    constructor Create; reintroduce;
  end;

constructor EInvalidArrayLength2.Create;
begin
  inherited Create('Invalid array length for vector 2.');
end;

constructor EInvalidArrayLength3.Create;
begin
  inherited Create('Invalid array length for vector 3.');
end;

constructor EInvalidArrayLength4.Create;
begin
  inherited Create('Invalid array length for vector 4.');
end;

{$endregion}

{$region ' Vector2'}

class operator Vector2.Add(a, b: Vector2): Vector2;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
end;

class operator Vector2.Add(a: Vector2; b: float): Vector2;
begin
  Result.X := A.X + B;
  Result.Y := A.Y + B;
end;

class operator Vector2.Add(a: Vector2; b: TArrayOfFloat): Vector2;
begin
  if length(b)<>2 then begin
    raise
      EInvalidArrayLength2.Create;
  end;
  Result.X := a.X + b[0];
  Result.Y := a.Y + b[1];
end;

class operator Vector2.Add(a: TArrayOfFloat; b: Vector2): Vector2;
begin
  if length(a)<>2 then begin
    raise
      EInvalidArrayLength2.Create;
  end;
  Result.X := b.X + a[0];
  Result.Y := b.Y + a[1];
end;

class function Vector2.Create(X, Y: float): Vector2;
begin
  Result.X := X;
  Result.Y := Y;
end;

class operator Vector2.Divide(a, b: Vector2): Vector2;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
end;

class operator Vector2.Divide(a: Vector2; b: float): Vector2;
begin
  Result.X := A.X / B;
  Result.Y := A.Y / B;
end;

class operator Vector2.Divide(a: Vector2; b: TArrayOfFloat): Vector2;
begin
  if length(b)<>2 then begin
    raise
      EInvalidArrayLength2.Create;
  end;
  Result.X := a.X / b[0];
  Result.Y := a.Y / b[1];
end;

class operator Vector2.Divide(a: TArrayOfFloat; b: Vector2): Vector2;
begin
  if length(a)<>2 then begin
    raise
      EInvalidArrayLength2.Create;
  end;
  Result.X := a[0] / b.X;
  Result.Y := a[1] / b.Y;
end;

function Vector2.dot(a: Vector2): float;
begin
  Result := (Self.X * A.X) + (Self.Y * A.Y);
end;

class operator Vector2.Implicit(a: TArrayOfFloat): Vector2;
var
  L: uint32;
begin
  L := Length(a);
  if (L>2) or (L=0) then begin
    raise
      EInvalidArrayLength2.Create;
  end;
  {$hints off} Move(A[0],Result,sizeof(float)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

function Vector2.magnitude: float;
begin
  // = Sqrt of vector dot product with self.
  Result := Sqrt( (X*X)+(Y*Y) );
end;

class operator Vector2.Multiply(a, b: Vector2): Vector2;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
end;

class operator Vector2.Multiply(a: Vector2; b: float): Vector2;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
end;

class operator Vector2.Multiply(a: Vector2; b: TArrayOfFloat): Vector2;
begin
  if length(b)<>2 then begin
    raise
      EInvalidArrayLength2.Create;
  end;
  Result.X := a.X * b[0];
  Result.Y := a.Y * b[1];
end;

class operator Vector2.Multiply(a: TArrayOfFloat; b: Vector2): Vector2;
begin
  if length(a)<>2 then begin
    raise
      EInvalidArrayLength2.Create;
  end;
  Result.X := a[0] * b.X;
  Result.Y := a[1] * b.Y;
end;

function Vector2.normalized: Vector2;
var
  M: float;
begin
  M := Self.magnitude;
  if M=0 then begin
    Result := Self;
    exit;
  end;
  Result.X := X / M;
  Result.Y := Y / M;
end;

class operator Vector2.Subtract(a: Vector2; b: TArrayOfFloat): Vector2;
begin
  if length(b)<>2 then begin
    raise
      EInvalidArrayLength2.Create;
  end;
  Result.X := a.X - b[0];
  Result.Y := a.Y - b[1];
end;

class operator Vector2.Subtract(a: TArrayOfFloat; b: Vector2): Vector2;
begin
  if length(a)<>2 then begin
    raise
      EInvalidArrayLength2.Create;
  end;
  Result.X := a[0] - b.X;
  Result.Y := a[1] - b.Y;
end;

class operator Vector2.Subtract(a: Vector2; b: float): Vector2;
begin
  Result.X := A.X - B;
  Result.Y := A.Y - B;
end;

function Vector2.UnitVector: Vector2;
var
  fMagnitude: float;
begin
  fMagnitude := Sqrt( (X*X)+(Y*Y) );
  Result.X := X / fMagnitude;
  Result.Y := Y / fMagnitude;
end;

class operator Vector2.Subtract(a, b: Vector2): Vector2;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
end;

{$endregion}

{$region ' Vector3'}

class operator Vector3.Add(a, b: Vector3): Vector3;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
  Result.Z := A.Z + B.Z;
end;

class operator Vector3.Add(a: Vector3; b: float): Vector3;
begin
  Result.X := A.X + B;
  Result.Y := A.Y + B;
  Result.Z := A.Z + B;
end;

class operator Vector3.Add(a: Vector3; b: TArrayOfFloat): Vector3;
begin
  if length(b)<>3 then begin
    raise
      EInvalidArrayLength3.Create;
  end;
  Result.X := a.X + b[0];
  Result.Y := a.Y + b[1];
  Result.Z := a.Z + b[2];
end;

class operator Vector3.Add(a: TArrayOfFloat; b: Vector3): Vector3;
begin
  if length(a)<>3 then begin
    raise
      EInvalidArrayLength3.Create;
  end;
  Result.X := a[0] + b.X;
  Result.Y := a[1] + b.Y;
  Result.Z := a[2] + b.Z;
end;

class function Vector3.Create(X, Y, Z: float): Vector3;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
end;

function Vector3.cross(a: Vector3): Vector3;
begin
  Result.X := (Self.Y * A.Z) - (Self.Z * A.Y);
  Result.Y := (Self.Z * A.X) - (Self.X * A.Z);
  Result.Z := (Self.X * A.Y) - (Self.Y * A.X);
end;

class operator Vector3.Divide(a, b: Vector3): Vector3;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
  Result.Z := A.Z / B.Z;
end;

class operator Vector3.Divide(a: Vector3; b: float): Vector3;
begin
  Result.X := A.X / B;
  Result.Y := A.Y / B;
  Result.Z := A.Z / B;
end;

class operator Vector3.Divide(a: Vector3; b: TArrayOfFloat): Vector3;
begin
  if length(b)<>3 then begin
    raise
      EInvalidArrayLength3.Create;
  end;
  Result.X := a.X / b[0];
  Result.Y := a.Y / b[1];
  Result.Z := a.Z / b[2];
end;

class operator Vector3.Divide(a: TArrayOfFloat; b: Vector3): Vector3;
begin
  if length(a)<>3 then begin
    raise
      EInvalidArrayLength3.Create;
  end;
  Result.X := a[0] / b.X;
  Result.Y := a[1] / b.Y;
  Result.Z := a[2] / b.Z;
end;

function Vector3.dot(a: Vector3): float;
begin
  Result := (Self.X * A.X) + (Self.Y * A.Y) + (Self.Z * A.Z);
end;

class operator Vector3.Explicit(a: Vector2): Vector3;
begin
  {$hints off} Move(a,Result,sizeof(Vector2)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
end;

class operator Vector3.Explicit(a: Vector3): Vector2;
begin
  {$hints off} Move(a,Result,sizeof(Vector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator Vector3.Implicit(a: Vector2): Vector3;
begin
  {$hints off} Move(a,Result,sizeof(Vector2)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
end;

class operator Vector3.Implicit(a: Vector3): Vector2;
begin
  {$hints off} Move(a,Result,sizeof(Vector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator Vector3.Implicit(a: TArrayOfFloat): Vector3;
var
  L: uint32;
begin
  L := Length(a);
  if (L>3) or (L=0) then begin
    raise
      EInvalidArrayLength3.Create;
  end;
  {$hints off} Move(A[0],Result,sizeof(float)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator Vector3.Explicit(a: TArrayOfFloat): Vector3;
var
  L: uint32;
begin
  L := Length(a);
  if (L>3) or (L=0) then begin
    raise
      EInvalidArrayLength3.Create;
  end;
  {$hints off} Move(A[0],Result,sizeof(float)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

function Vector3.magnitude: float;
begin
  // = Sqrt of vector dot product with self.
  Result := Sqrt( (X*X)+(Y*Y)+(Z*Z) );
end;

class operator Vector3.Multiply(a: Vector3; b: TArrayOfFloat): Vector3;
begin
  if length(b)<>3 then begin
    raise
      EInvalidArrayLength3.Create;
  end;
  Result.X := a.X * b[0];
  Result.Y := a.Y * b[1];
  Result.Z := a.Z * b[2];
end;

class operator Vector3.Multiply(a: TArrayOfFloat; b: Vector3): Vector3;
begin
  if length(a)<>3 then begin
    raise
      EInvalidArrayLength3.Create;
  end;
  Result.X := a[0] * b.X;
  Result.Y := a[1] * b.Y;
  Result.Z := a[2] * b.Z;
end;

class operator Vector3.Multiply(a, b: Vector3): Vector3;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
  Result.Z := A.Z * B.Z;
end;

class operator Vector3.Multiply(a: Vector3; b: float): Vector3;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
  Result.Z := A.Z * B;
end;

function Vector3.normalized: Vector3;
var
  M: float;
begin
  M := Self.magnitude;
  if M=0 then begin
    Result := Self;
    exit;
  end;
  Result.X := X / M;
  Result.Y := Y / M;
  Result.Z := Z / M;
end;

class operator Vector3.Subtract(a: Vector3; b: TArrayOfFloat): Vector3;
begin
  if length(b)<>3 then begin
    raise
      EInvalidArrayLength3.Create;
  end;
  Result.X := a.X - b[0];
  Result.Y := a.Y - b[1];
  Result.Z := a.Z - b[2];
end;

class operator Vector3.Subtract(a: TArrayOfFloat; b: Vector3): Vector3;
begin
  if length(a)<>3 then begin
    raise
      EInvalidArrayLength3.Create;
  end;
  Result.X := a[0] - b.X;
  Result.Y := a[1] - b.Y;
  Result.Z := a[2] - b.Z;
end;

class operator Vector3.Subtract(a: Vector3; b: float): Vector3;
begin
  Result.X := A.X - B;
  Result.Y := A.Y - B;
  Result.Z := A.Z - B;
end;

function Vector3.UnitVector: Vector3;
var
   fMagnitude: float;
begin
  fMagnitude := Sqrt( (X*X)+(Y*Y)+(Z*Z) );
  Result.X := X / fMagnitude;
  Result.Y := Y / fMagnitude;
  Result.Z := Z / fMagnitude;
end;

class operator Vector3.Subtract(a, b: Vector3): Vector3;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
  Result.Z := A.Z - B.Z;
end;

{$endregion}

{$region ' Vector4'}

class operator Vector4.Add(a, b: Vector4): Vector4;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
  Result.Z := A.Z + B.Z;
  Result.W := A.W + B.W;
end;

class operator Vector4.Add(a: Vector4; b: float): Vector4;
begin
  Result.X := A.X + B;
  Result.Y := A.Y + B;
  Result.Z := A.Z + B;
  Result.W := A.W + B;
end;

class operator Vector4.Add(a: Vector4; b: TArrayOfFloat): Vector4;
begin
  if length(b)<>4 then begin
    raise
      EInvalidArrayLength4.Create;
  end;
  Result.X := a.X + b[0];
  Result.Y := a.Y + b[1];
  Result.Z := a.Z + b[2];
  Result.W := a.W + b[3];
end;

class operator Vector4.Add(a: TArrayOfFloat; b: Vector4): Vector4;
begin
  if length(a)<>4 then begin
    raise
      EInvalidArrayLength4.Create;
  end;
  Result.X := a[0] + b.X;
  Result.Y := a[1] + b.Y;
  Result.Z := a[2] + b.Z;
  Result.W := a[3] + b.W;
end;

class function Vector4.Create(X, Y, Z, W: float): Vector4;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
  Result.W := W;
end;

class operator Vector4.Divide(a, b: Vector4): Vector4;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
  Result.Z := A.Z / B.Z;
  Result.W := A.W / B.W;
end;

class operator Vector4.Divide(a: Vector4; b: float): Vector4;
begin
  Result.X := A.X / B;
  Result.Y := A.Y / B;
  Result.Z := A.Z / B;
  Result.W := A.W / B;
end;

class operator Vector4.Divide(a: Vector4; b: TArrayOfFloat): Vector4;
begin
  if length(b)<>4 then begin
    raise
      EInvalidArrayLength4.Create;
  end;
  Result.X := a.X / b[0];
  Result.Y := a.Y / b[1];
  Result.Z := a.Z / b[2];
  Result.W := a.W / b[3];
end;

class operator Vector4.Divide(a: TArrayOfFloat; b: Vector4): Vector4;
begin
  if length(a)<>4 then begin
    raise
      EInvalidArrayLength4.Create;
  end;
  Result.X := a[0] / b.X;
  Result.Y := a[1] / b.Y;
  Result.Z := a[2] / b.Z;
  Result.W := a[3] / b.W;
end;

function Vector4.dot(a: Vector4): float;
begin
  Result := (Self.X * A.X) + (Self.Y * A.Y) + (Self.Z * A.Z) + (Self.W * A.W);
end;

function Vector4.magnitude: float;
begin
  // = Sqrt of vector dot product with self.
  Result := Sqrt( (X*X)+(Y*Y)+(Z*Z)+(W*W) );
end;

class operator Vector4.Multiply(a: Vector4; b: TArrayOfFloat): Vector4;
begin
  if length(b)<>4 then begin
    raise
      EInvalidArrayLength4.Create;
  end;
  Result.X := a.X * b[0];
  Result.Y := a.Y * b[1];
  Result.Z := a.Z * b[2];
  Result.W := a.W * b[3];
end;

class operator Vector4.Multiply(a: TArrayOfFloat; b: Vector4): Vector4;
begin
  if length(a)<>4 then begin
    raise
      EInvalidArrayLength4.Create;
  end;
  Result.X := a[0] * b.X;
  Result.Y := a[1] * b.Y;
  Result.Z := a[2] * b.Z;
  Result.W := a[3] * b.W;
end;

class operator Vector4.Multiply(a, b: Vector4): Vector4;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
  Result.Z := A.Z * B.Z;
  Result.W := A.W * B.W;
end;

class operator Vector4.Multiply(a: Vector4; b: float): Vector4;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
  Result.Z := A.Z * B;
  Result.W := A.W * B;
end;

function Vector4.normalized: Vector4;
var
  M: float;
begin
  M := Self.magnitude;
  if M=0 then begin
    Result := Self;
    exit;
  end;
  Result.X := X / M;
  Result.Y := Y / M;
  Result.Z := Z / M;
  Result.W := W / M;
end;

class operator Vector4.Subtract(a: Vector4; b: TArrayOfFloat): Vector4;
begin
  if length(b)<>4 then begin
    raise
      EInvalidArrayLength4.Create;
  end;
  Result.X := a.X - b[0];
  Result.Y := a.Y - b[1];
  Result.Z := a.Z - b[2];
  Result.W := a.W - b[3];
end;

class operator Vector4.Subtract(a: TArrayOfFloat; b: Vector4): Vector4;
begin
  if length(a)<>4 then begin
    raise
      EInvalidArrayLength4.Create;
  end;
  Result.X := a[0] - b.X;
  Result.Y := a[1] - b.Y;
  Result.Z := a[2] - b.Z;
  Result.W := a[3] - b.W;
end;

class operator Vector4.Subtract(a: Vector4; b: float): Vector4;
begin
  Result.X := A.X - B;
  Result.Y := A.Y - B;
  Result.Z := A.Z - B;
  Result.W := A.W - B;
end;

function Vector4.UnitVector: Vector4;
var
   fMagnitude: float;
begin
  fMagnitude := Sqrt( (X*X)+(Y*Y)+(Z*Z)+(W*W) );
  Result.X := X / fMagnitude;
  Result.Y := Y / fMagnitude;
  Result.Z := Z / fMagnitude;
  Result.W := W / fMagnitude;
end;

class operator Vector4.Subtract(a, b: Vector4): Vector4;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
  Result.Z := A.Z - B.Z;
  Result.W := A.W - B.W;
end;

class operator Vector4.Explicit(a: Vector3): Vector4;
begin
  {$hints off} Move(a,Result,sizeof(Vector3)); {$hints on} //- FPC, Result not initialized (it is)
  Result.W := 1;
end;

class operator Vector4.Explicit(a: Vector2): Vector4;
begin
  {$hints off} Move(a,Result,Sizeof(Vector2)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
  Result.W := 1;
end;

class operator Vector4.Implicit(a: Vector3): Vector4;
begin
  {$hints off} Move(a,Result,sizeof(Vector3)); {$hints on} //- FPC, Result not initialized (it is)
  Result.W := 1;
end;

class operator Vector4.Implicit(a: Vector2): Vector4;
begin
  {$hints off} Move(a,Result,sizeof(Vector3)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
  Result.W := 1;
end;

class operator Vector4.Explicit(a: Vector4): Vector3;
begin
  {$hints off} Move(a,Result,sizeof(Vector3)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator Vector4.Explicit(a: Vector4): Vector2;
begin
  {$hints off} Move(a,Result,sizeof(Vector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator Vector4.Implicit(a: Vector4): Vector3;
begin
  {$hints off} Move(a,Result,sizeof(Vector3)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator Vector4.Implicit(a: Vector4): Vector2;
begin
  {$hints off} Move(a,Result,sizeof(Vector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator Vector4.Implicit(a: TArrayOfFloat): Vector4;
var
  L: uint32;
begin
  L := Length(a);
  if (L>4) or (L=0) then begin
    raise
      EInvalidArrayLength4.Create;
  end;
  {$hints off} Move(A[0],Result,sizeof(float)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator Vector4.Explicit(a: TArrayOfFloat): Vector4;
var
  L: uint32;
begin
  L := Length(a);
  if (L>4) or (L=0) then begin
    raise
      EInvalidArrayLength4.Create;
  end;
  {$hints off} Move(A[0],Result,sizeof(float)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

{$endregion}

{$region ' Matrix2x2'}

class operator Matrix2x2.Add(a, b: Matrix2x2): Matrix2x2;
begin
  Result.m00 := a.m00 + b.m00;
  Result.m10 := a.m10 + b.m10;
  Result.m01 := a.m01 + b.m01;
  Result.m11 := a.m11 + b.m11;
end;

class operator Matrix2x2.Add(a: Matrix2x2; b: float): Matrix2x2;
begin
  Result.m00 := a.m00 + b;
  Result.m10 := a.m10 + b;
  Result.m01 := a.m01 + b;
  Result.m11 := a.m11 + b;
end;

function Matrix2x2.adjugate: Matrix2x2;
begin
  Result.m00 := m11;
  Result.m01 := 0-m01;
  Result.m10 := 0-m10;
  Result.m11 := m00;
end;

function Matrix2x2.cofactor: Matrix2x2;
begin
  Result.m00 := m11;
  Result.m10 := 0-m01;
  Result.m01 := 0-m10;
  Result.m11 := m00;
end;

class function Matrix2x2.Create( _m00, _m10, _m01, _m11: float): Matrix2x2;
begin
  Result.m00 := _m00;
  Result.m10 := _m10;
  Result.m01 := _m01;
  Result.m11 := _m11;
end;

function Matrix2x2.determinant: float;
begin
  Result := (m00 * m11) - (m01 * m10);
end;

class operator Matrix2x2.Divide(a: Matrix2x2; b: float): Matrix2x2;
begin
  Result.m00 := a.m00 / b;
  Result.m10 := a.m10 / b;
  Result.m01 := a.m01 / b;
  Result.m11 := a.m11 / b;
end;

class operator Matrix2x2.Divide(a, b: Matrix2x2): Matrix2x2;
begin
  Result.m00 := a.m00 / b.m00;
  Result.m10 := a.m10 / b.m10;
  Result.m01 := a.m01 / b.m01;
  Result.m11 := a.m11 / b.m11;
end;

function Matrix2x2.dot(a: Matrix2x2): Matrix2x2;
begin
  Result.m00 := (m00 * A.m00) + (m10 * A.m01);
  Result.m10 := (m00 * A.m10) + (m10 * A.m11);
  Result.m01 := (m01 * A.m00) + (m11 * A.m01);
  Result.m11 := (m01 * A.m10) + (m11 * A.m11);
end;

function Matrix2x2.dot(a: Vector2): Vector2;
begin
  Result.X := (m00 * A.X) + (m10 * A.Y);
  Result.Y := (m01 * A.X) + (m11 * A.Y);
end;

class function Matrix2x2.identity: Matrix2x2;
begin
  Result := Matrix2x2.Create
  (
     1, 0,
     0, 1
  );
end;

function Matrix2x2.inverse: Matrix2x2;
var
  D: float;
begin
  // Get determinant.
  D := 1 / ((m00 * m11) - (m01 * m10));
  // Adjugate and inverse.
  Result.m00 := m11*D;
  Result.m01 := 0-m01*D;
  Result.m10 := 0-m10*D;
  Result.m11 := m00*D;
end;

class operator Matrix2x2.Multiply(a, b: Matrix2x2): Matrix2x2;
begin
  Result.m00 := a.m00 * b.m00;
  Result.m10 := a.m10 * b.m10;
  Result.m01 := a.m01 * b.m01;
  Result.m11 := a.m11 * b.m11;
end;

class operator Matrix2x2.Multiply(a: Matrix2x2; b: float): Matrix2x2;
begin
  Result.m00 := a.m00 * b;
  Result.m10 := a.m10 * b;
  Result.m01 := a.m01 * b;
  Result.m11 := a.m11 * b;
end;

class function Matrix2x2.rotation(degrees: float): Matrix2x2;
var
  d: single;
begin
  d := degrees*Pi/180;
  Result := Matrix2x2.Create(
    cos(d), -sin(d),
    sin(d), cos(d)
  );
end;

class function Matrix2x2.scale(s: Vector2): Matrix2x2;
begin
  Result := Matrix2x2.Create(
   s.X, 0,
   0,   s.Y
  );
end;

class operator Matrix2x2.Subtract(a: Matrix2x2; b: float): Matrix2x2;
begin
  Result.m00 := a.m00 - b;
  Result.m10 := a.m10 - b;
  Result.m01 := a.m01 - b;
  Result.m11 := a.m11 - b;
end;

class function Matrix2x2.translation(t: Vector2): Matrix2x2;
begin
  Result := Matrix2x2.Create(
    1, t.X,
    0, t.Y
  );
end;

function Matrix2x2.transpose: Matrix2x2;
begin
  Result := Matrix2x2.Create(
   m00, m01,
   m10, m11
  );
end;

class operator Matrix2x2.Subtract(a, b: Matrix2x2): Matrix2x2;
begin
  Result.m00 := a.m00 - b.m00;
  Result.m10 := a.m10 - b.m10;
  Result.m01 := a.m01 - b.m01;
  Result.m11 := a.m11 - b.m11;
end;

{$endregion}

{$region ' Matrix3x3'}

class operator Matrix3x3.Add(a, b: Matrix3x3): Matrix3x3;
begin
  Result.m00 := a.m00 + b.m00;
  Result.m10 := a.m10 + b.m10;
  Result.m20 := a.m20 + b.m20;
  Result.m01 := a.m01 + b.m01;
  Result.m11 := a.m11 + b.m11;
  Result.m21 := a.m21 + b.m21;
  Result.m02 := a.m02 + b.m02;
  Result.m12 := a.m12 + b.m12;
  Result.m22 := a.m22 + b.m22;
end;

class operator Matrix3x3.Add(a: Matrix3x3; b: float): Matrix3x3;
begin
  Result.m00 := a.m00 + b;
  Result.m10 := a.m10 + b;
  Result.m20 := a.m20 + b;
  Result.m01 := a.m01 + b;
  Result.m11 := a.m11 + b;
  Result.m21 := a.m21 + b;
  Result.m02 := a.m02 + b;
  Result.m12 := a.m12 + b;
  Result.m22 := a.m22 + b;
end;

function Matrix3x3.adjugate: Matrix3x3;
begin
  //- Calculate matrix of minors and co-factor and transpose.
  Result.m00 := ((m11*m22) - (m12*m21));
  Result.m01 := (0 - ((m01*m22) - (m21*m02)));
  Result.m02 := ((m01*m12) - (m11*m02));
  Result.m10 := (0 - ((m10*m22) - (m20*m12)));
  Result.m11 := ((m00*m22) - (m20*m02));
  Result.m12 := (0 - ((m00*m12) - (m10*m02)));
  Result.m20 := ((m10*m21) - (m20*m11));
  Result.m21 := (0 - ((m00*m21) - (m20*m01)));
  Result.m22 := ((m00*m11) - (m10*m01));
end;

function Matrix3x3.cofactor: Matrix3x3;
begin
  //- Calculate matrix of minors and co-factor.
  Result.m00 := ((m11*m22) - (m12*m21));
  Result.m10 := (0 - ((m01*m22) - (m21*m02)));
  Result.m20 := ((m01*m12) - (m11*m02));
  Result.m01 := (0 - ((m10*m22) - (m20*m12)));
  Result.m11 := ((m00*m22) - (m20*m02));
  Result.m21 := (0 - ((m00*m12) - (m10*m02)));
  Result.m02 := ((m10*m21) - (m20*m11));
  Result.m12 := (0 - ((m00*m21) - (m20*m01)));
  Result.m22 := ((m00*m11) - (m10*m01));
end;

class function Matrix3x3.Create( _m00, _m10, _m20, _m01, _m11, _m21, _m02, _m12, _m22: float): Matrix3x3;
begin
  Result.m00 := _m00;
  Result.m10 := _m10;
  Result.m20 := _m20;
  Result.m01 := _m01;
  Result.m11 := _m11;
  Result.m21 := _m21;
  Result.m02 := _m02;
  Result.m12 := _m12;
  Result.m22 := _m22;
end;

function Matrix3x3.determinant: float;
begin
  Result := ((m00*m11*m22) + (m10*m21*m02) + (m20*m01*m12)) -
            ((m02*m11*m20) + (m12*m21*m00) + (m22*m01*m10));
end;

class operator Matrix3x3.Divide(a: Matrix3x3; b: float): Matrix3x3;
begin
  Result.m00 := a.m00 / b;
  Result.m10 := a.m10 / b;
  Result.m20 := a.m20 / b;
  Result.m01 := a.m01 / b;
  Result.m11 := a.m11 / b;
  Result.m21 := a.m21 / b;
  Result.m02 := a.m02 / b;
  Result.m12 := a.m12 / b;
  Result.m22 := a.m22 / b;
end;

class operator Matrix3x3.Divide(a, b: Matrix3x3): Matrix3x3;
begin
  Result.m00 := a.m00 / b.m00;
  Result.m10 := a.m10 / b.m10;
  Result.m20 := a.m20 / b.m20;
  Result.m01 := a.m01 / b.m01;
  Result.m11 := a.m11 / b.m11;
  Result.m21 := a.m21 / b.m21;
  Result.m02 := a.m02 / b.m02;
  Result.m12 := a.m12 / b.m12;
  Result.m22 := a.m22 / b.m22;
end;

function Matrix3x3.dot(a: Matrix3x3): Matrix3x3;
begin
  Result.m00 := (m00 * A.m00) + (m10 * A.m01) + (m20 * A.m02);
  Result.m10 := (m00 * A.m10) + (m10 * A.m11) + (m20 * A.m12);
  Result.m20 := (m00 * A.m20) + (m10 * A.m21) + (m20 * A.m22);
  Result.m01 := (m01 * A.m00) + (m11 * A.m01) + (m21 * A.m02);
  Result.m11 := (m01 * A.m10) + (m11 * A.m11) + (m21 * A.m12);
  Result.m21 := (m01 * A.m20) + (m11 * A.m21) + (m21 * A.m22);
  Result.m02 := (m02 * A.m00) + (m12 * A.m01) + (m22 * A.m02);
  Result.m12 := (m02 * A.m10) + (m12 * A.m11) + (m22 * A.m12);
  Result.m22 := (m02 * A.m20) + (m12 * A.m21) + (m22 * A.m22);
end;

function Matrix3x3.dot(a: Vector3): Vector3;
begin
  Result.X := (m00 * A.X) + (m10 * A.Y) + (m20 * A.Z);
  Result.Y := (m01 * A.X) + (m11 * A.Y) + (m21 * A.Z);
  Result.Z := (m02 * A.X) + (m12 * A.Y) + (m22 * A.Z);
end;

class function Matrix3x3.identity: Matrix3x3;
begin
  Result := Matrix3x3.Create
  (
     1, 0, 0,
     0, 1, 0,
     0, 0, 1
  );
end;

function Matrix3x3.inverse: Matrix3x3;
var
  D: float;
begin
  //- Calculate determinant
  D := 1 / (((m00 * m11 * m22)    +
             (m10 * m21 * m02)    +
             ( m20 * m01 * m12 )) -
             ((m02 * m11 * m20)   +
             ( m12 * m21 * m00 )  +
             ( m22 * m01 * m10 )));
  //- Calculate matrix of minors and co-factor, transpose for adjugate, and
  //- multiply 1/determinant
  Result.m00 := ((m11*m22) - (m12*m21)) * D;
  Result.m01 := (0 - ((m01*m22) - (m21*m02))) * D;
  Result.m02 := ((m01*m12) - (m11*m02)) * D;
  Result.m10 := (0 - ((m10*m22) - (m20*m12))) * D;
  Result.m11 := ((m00*m22) - (m20*m02)) * D;
  Result.m12 := (0 - ((m00*m12) - (m10*m02))) * D;
  Result.m20 := ((m10*m21) - (m20*m11)) * D;
  Result.m21 := (0 - ((m00*m21) - (m20*m01))) * D;
  Result.m22 := ((m00*m11) - (m10*m01)) * D;
end;

class operator Matrix3x3.Multiply(a, b: Matrix3x3): Matrix3x3;
begin
  Result.m00 := a.m00 * b.m00;
  Result.m10 := a.m10 * b.m10;
  Result.m20 := a.m20 * b.m20;
  Result.m01 := a.m01 * b.m01;
  Result.m11 := a.m11 * b.m11;
  Result.m21 := a.m21 * b.m21;
  Result.m02 := a.m02 * b.m02;
  Result.m12 := a.m12 * b.m12;
  Result.m22 := a.m22 * b.m22;
end;

class operator Matrix3x3.Multiply(a: Matrix3x3; b: float): Matrix3x3;
begin
  Result.m00 := a.m00 * b;
  Result.m10 := a.m10 * b;
  Result.m20 := a.m20 * b;
  Result.m01 := a.m01 * b;
  Result.m11 := a.m11 * b;
  Result.m21 := a.m21 * b;
  Result.m02 := a.m02 * b;
  Result.m12 := a.m12 * b;
  Result.m22 := a.m22 * b;
end;

class function Matrix3x3.rotationX(degrees: float): Matrix3x3;
var
  d: single;
begin
  d := degrees*Pi/180;
  Result := Matrix3x3.Create(
    1,  0,             0,
    0,  cos(d),  -sin(d),
    0,  sin(d),   cos(d)
  );
end;

class function Matrix3x3.rotationY(degrees: float): Matrix3x3;
var
  d: single;
begin
  d := degrees*Pi/180;
  Result := Matrix3x3.Create(
    cos(d),   0,  sin(d),
    0,        1,       0,
    -sin(d),  0,  cos(d)
  );
end;

class function Matrix3x3.rotationZ(degrees: float): Matrix3x3;
var
  d: single;
begin
  d := degrees*Pi/180;
  Result := Matrix3x3.Create(
    cos(d), -sin(d),  0,
    sin(d), cos(d),   0,
    0,            0,  1
  );
end;

class function Matrix3x3.scale(s: Vector3): Matrix3x3;
begin
  Result := Matrix3x3.Create(
   s.X, 0,   0,
   0,   s.Y, 0,
   0,   0,   s.Z
  );
end;

class operator Matrix3x3.Subtract(a: Matrix3x3; b: float): Matrix3x3;
begin
  Result.m00 := a.m00 - b;
  Result.m10 := a.m10 - b;
  Result.m20 := a.m20 - b;
  Result.m01 := a.m01 - b;
  Result.m11 := a.m11 - b;
  Result.m21 := a.m21 - b;
  Result.m02 := a.m02 - b;
  Result.m12 := a.m12 - b;
  Result.m22 := a.m22 - b;
end;

class function Matrix3x3.translation(t: Vector3): Matrix3x3;
begin
  Result := Matrix3x3.Create(
    1, 0, t.X,
    0, 1, t.Y,
    0, 0, t.Z
  );
end;

function Matrix3x3.transpose: Matrix3x3;
begin
  Result := Matrix3x3.Create(
   m00, m01, m02,
   m10, m11, m12,
   m20, m21, m22
  );
end;

class operator Matrix3x3.Subtract(a, b: Matrix3x3): Matrix3x3;
begin
  Result.m00 := a.m00 - b.m00;
  Result.m10 := a.m10 - b.m10;
  Result.m20 := a.m20 - b.m20;
  Result.m01 := a.m01 - b.m01;
  Result.m11 := a.m11 - b.m11;
  Result.m21 := a.m21 - b.m21;
  Result.m02 := a.m02 - b.m02;
  Result.m12 := a.m12 - b.m12;
  Result.m22 := a.m22 - b.m22;
end;


{$endregion}

{$region ' Matrix4x4'}

class operator Matrix4x4.Add(a, b: Matrix4x4): Matrix4x4;
begin
  Result.m00 := a.m00 + b.m00;
  Result.m10 := a.m10 + b.m10;
  Result.m20 := a.m20 + b.m20;
  Result.m30 := a.m30 + b.m30;
  Result.m01 := a.m01 + b.m01;
  Result.m11 := a.m11 + b.m11;
  Result.m21 := a.m21 + b.m21;
  Result.m31 := a.m31 + b.m31;
  Result.m02 := a.m02 + b.m02;
  Result.m12 := a.m12 + b.m12;
  Result.m22 := a.m22 + b.m22;
  Result.m32 := a.m32 + b.m32;
  Result.m03 := a.m03 + b.m03;
  Result.m13 := a.m13 + b.m13;
  Result.m23 := a.m23 + b.m23;
  Result.m33 := a.m33 + b.m33;
end;

class operator Matrix4x4.Add(a: Matrix4x4; b: float): Matrix4x4;
begin
  Result.m00 := a.m00 + b;
  Result.m10 := a.m10 + b;
  Result.m20 := a.m20 + b;
  Result.m30 := a.m30 + b;
  Result.m01 := a.m01 + b;
  Result.m11 := a.m11 + b;
  Result.m21 := a.m21 + b;
  Result.m31 := a.m31 + b;
  Result.m02 := a.m02 + b;
  Result.m12 := a.m12 + b;
  Result.m22 := a.m22 + b;
  Result.m32 := a.m32 + b;
  Result.m03 := a.m03 + b;
  Result.m13 := a.m13 + b;
  Result.m23 := a.m23 + b;
  Result.m33 := a.m33 + b;
end;

function Matrix4x4.adjugate: Matrix4x4;
begin
  //- Calculate matrix of minors and co-factor and transpose
  Result.m00 :=   (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31)+(m23*m32*m11)+(m33*m12*m21)));
  Result.m01 := 0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31)+(m23*m32*m01)+(m33*m02*m21)));
  Result.m02 :=   (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31)+(m13*m32*m01)+(m33*m02*m11)));
  Result.m03 := 0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21)+(m13*m22*m01)+(m23*m02*m11)));
  Result.m10 := 0-(((m10*m22*m33)+(m20*m32*m13)+(m30*m12*m23)) - ((m13*m22*m30)+(m23*m32*m10)+(m33*m12*m20)));
  Result.m11 :=   (((m00*m22*m33)+(m20*m32*m03)+(m30*m02*m23)) - ((m03*m22*m30)+(m23*m32*m00)+(m33*m02*m20)));
  Result.m12 := 0-(((m00*m12*m33)+(m10*m32*m03)+(m30*m02*m13)) - ((m03*m12*m30)+(m13*m32*m00)+(m33*m02*m10)));
  Result.m13 :=   (((m00*m12*m23)+(m10*m22*m03)+(m20*m02*m13)) - ((m03*m12*m20)+(m13*m22*m00)+(m23*m02*m10)));
  Result.m20 :=   (((m10*m21*m33)+(m20*m31*m13)+(m30*m11*m23)) - ((m13*m21*m30)+(m23*m31*m10)+(m33*m11*m20)));
  Result.m21 := 0-(((m00*m21*m33)+(m20*m31*m03)+(m30*m01*m23)) - ((m03*m21*m30)+(m23*m31*m00)+(m33*m01*m20)));
  Result.m22 :=   (((m00*m11*m33)+(m10*m31*m03)+(m30*m01*m13)) - ((m03*m11*m30)+(m13*m31*m00)+(m33*m01*m10)));
  Result.m23 := 0-(((m00*m11*m23)+(m10*m21*m03)+(m20*m01*m13)) - ((m03*m11*m20)+(m13*m21*m00)+(m23*m01*m10)));
  Result.m30 := 0-(((m10*m21*m32)+(m20*m31*m12)+(m30*m11*m22)) - ((m12*m21*m30)+(m22*m31*m10)+(m32*m11*m20)));
  Result.m31 :=   (((m00*m21*m32)+(m20*m31*m02)+(m30*m01*m22)) - ((m02*m21*m30)+(m22*m31*m00)+(m32*m01*m20)));
  Result.m32 := 0-(((m00*m11*m32)+(m10*m31*m02)+(m30*m01*m13)) - ((m02*m11*m30)+(m13*m31*m00)+(m32*m01*m10)));
  Result.m33 :=   (((m00*m11*m22)+(m10*m21*m02)+(m20*m01*m12)) - ((m02*m11*m20)+(m12*m21*m00)+(m22*m01*m10)));
end;

function Matrix4x4.cofactor: Matrix4x4;
begin
  //- Calculate matrix of minors and co-factor.
  Result.m00 :=   (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31)+(m23*m32*m11)+(m33*m12*m21)));
  Result.m10 := 0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31)+(m23*m32*m01)+(m33*m02*m21)));
  Result.m20 :=   (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31)+(m13*m32*m01)+(m33*m02*m11)));
  Result.m30 := 0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21)+(m13*m22*m01)+(m23*m02*m11)));
  Result.m01 := 0-(((m10*m22*m33)+(m20*m32*m13)+(m30*m12*m23)) - ((m13*m22*m30)+(m23*m32*m10)+(m33*m12*m20)));
  Result.m11 :=   (((m00*m22*m33)+(m20*m32*m03)+(m30*m02*m23)) - ((m03*m22*m30)+(m23*m32*m00)+(m33*m02*m20)));
  Result.m21 := 0-(((m00*m12*m33)+(m10*m32*m03)+(m30*m02*m13)) - ((m03*m12*m30)+(m13*m32*m00)+(m33*m02*m10)));
  Result.m31 :=   (((m00*m12*m23)+(m10*m22*m03)+(m20*m02*m13)) - ((m03*m12*m20)+(m13*m22*m00)+(m23*m02*m10)));
  Result.m02 :=   (((m10*m21*m33)+(m20*m31*m13)+(m30*m11*m23)) - ((m13*m21*m30)+(m23*m31*m10)+(m33*m11*m20)));
  Result.m12 := 0-(((m00*m21*m33)+(m20*m31*m03)+(m30*m01*m23)) - ((m03*m21*m30)+(m23*m31*m00)+(m33*m01*m20)));
  Result.m22 :=   (((m00*m11*m33)+(m10*m31*m03)+(m30*m01*m13)) - ((m03*m11*m30)+(m13*m31*m00)+(m33*m01*m10)));
  Result.m32 := 0-(((m00*m11*m23)+(m10*m21*m03)+(m20*m01*m13)) - ((m03*m11*m20)+(m13*m21*m00)+(m23*m01*m10)));
  Result.m03 := 0-(((m10*m21*m32)+(m20*m31*m12)+(m30*m11*m22)) - ((m12*m21*m30)+(m22*m31*m10)+(m32*m11*m20)));
  Result.m13 :=   (((m00*m21*m32)+(m20*m31*m02)+(m30*m01*m22)) - ((m02*m21*m30)+(m22*m31*m00)+(m32*m01*m20)));
  Result.m23 := 0-(((m00*m11*m32)+(m10*m31*m02)+(m30*m01*m13)) - ((m02*m11*m30)+(m13*m31*m00)+(m32*m01*m10)));
  Result.m33 :=   (((m00*m11*m22)+(m10*m21*m02)+(m20*m01*m12)) - ((m02*m11*m20)+(m12*m21*m00)+(m22*m01*m10)));
end;

class function Matrix4x4.Create( _m00, _m10, _m20, _m30, _m01, _m11, _m21, _m31, _m02, _m12, _m22, _m32, _m03, _m13, _m23, _m33: float ): Matrix4x4;
begin
  Result.m00 := _m00;
  Result.m10 := _m10;
  Result.m20 := _m20;
  Result.m30 := _m30;
  Result.m01 := _m01;
  Result.m11 := _m11;
  Result.m21 := _m21;
  Result.m31 := _m31;
  Result.m02 := _m02;
  Result.m12 := _m12;
  Result.m22 := _m22;
  Result.m32 := _m32;
  Result.m03 := _m03;
  Result.m13 := _m13;
  Result.m23 := _m23;
  Result.m33 := _m33;
end;

class function Matrix4x4.Create(Row0, Row1, Row2, Row3: Vector4): Matrix4x4;
begin
  {$hints off} Move(Row0,Result.m00,sizeof(float)*4); {$hints on} //- FPC, Result not initialized (it is)
  Move(Row1,Result.m01,sizeof(float)*4);
  Move(Row2,Result.m02,sizeof(float)*4);
  Move(Row3,Result.m03,sizeof(float)*4);
end;

class function Matrix4x4.CreatePerspective(angleDeg, ratio, _near, _far: single): Matrix4x4;
var
  tan_half_angle: single;
begin
  tan_half_angle := tan(degtorad(angleDeg)/2);
  Result.m00 := 1 / (ratio*tan_half_angle);
  Result.m10 := 0;
  Result.m20 := 0;
  Result.m30 := 0;
  Result.m01 := 0;
  Result.m11 := 1 / tan_half_angle;
  Result.m21 := 0;
  Result.m31 := 0;
  Result.m02 := 0;
  Result.m12 := 0;
  Result.m22 := (_near+_far)/(_near-_far);
  Result.m32 := (2*_near-_far)/(_near-_far);
  Result.m03 := 0;
  Result.m13 := 0;
  Result.m23 := -1;
  Result.m33 := 0;
end;

class function Matrix4x4.Create(Row0, Row1, Row2, Row3: Vector3): Matrix4x4;
begin
  {$hints off} Move(Row0,Result.m00,sizeof(float)*3); {$hints on} //- FPC, Result not initialized (it is)
  Move(Row1,Result.m01,sizeof(float)*3);
  Move(Row2,Result.m02,sizeof(float)*3);
  Move(Row3,Result.m03,sizeof(float)*3);
  Result.m30 := 0;
  Result.m31 := 0;
  Result.m32 := 0;
  Result.m33 := 1;
end;

class function Matrix4x4.CreateView(eye, target, Up: Vector3): Matrix4x4;
var
  vz: Vector3;
  vx: Vector3;
  vy: Vector3;
begin
  vz := (eye-target).normalized;
  vx := up.cross(vz).normalized;
  vy := vz.cross(vx);
  Result := Matrix4x4.Create(
              vx.X,           VY.X,           vZ.X, 0,
              vx.Y,           VY.y,           VZ.y, 0,
              vx.Z,           VY.Z,           VZ.Z, 0,
    -(vx.dot(eye)), -(vy.dot(eye)), -(vz.dot(eye)), 1 ).transpose;
end;

function Matrix4x4.determinant: float;
begin
  Result :=
  (m00 *    (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31)+(m23*m32*m11)+(m33*m12*m21))))  +
  (m10 * (0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31)+(m23*m32*m01)+(m33*m02*m21))))) +
  (m20 *    (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31)+(m13*m32*m01)+(m33*m02*m11))))  +
  (m30 * (0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21)+(m13*m22*m01)+(m23*m02*m11)))));
end;

class operator Matrix4x4.Divide(a: Matrix4x4; b: float): Matrix4x4;
begin
  Result.m00 := a.m00 / b;
  Result.m10 := a.m10 / b;
  Result.m20 := a.m20 / b;
  Result.m30 := a.m30 / b;
  Result.m01 := a.m01 / b;
  Result.m11 := a.m11 / b;
  Result.m21 := a.m21 / b;
  Result.m31 := a.m31 / b;
  Result.m02 := a.m02 / b;
  Result.m12 := a.m12 / b;
  Result.m22 := a.m22 / b;
  Result.m32 := a.m32 / b;
  Result.m03 := a.m03 / b;
  Result.m13 := a.m13 / b;
  Result.m23 := a.m23 / b;
  Result.m33 := a.m33 / b;
end;

class operator Matrix4x4.Divide(a, b: Matrix4x4): Matrix4x4;
begin
  Result.m00 := a.m00 / b.m00;
  Result.m10 := a.m10 / b.m10;
  Result.m20 := a.m20 / b.m20;
  Result.m30 := a.m30 / b.m30;
  Result.m01 := a.m01 / b.m01;
  Result.m11 := a.m11 / b.m11;
  Result.m21 := a.m21 / b.m21;
  Result.m31 := a.m31 / b.m31;
  Result.m02 := a.m02 / b.m02;
  Result.m12 := a.m12 / b.m12;
  Result.m22 := a.m22 / b.m22;
  Result.m32 := a.m32 / b.m32;
  Result.m03 := a.m03 / b.m03;
  Result.m13 := a.m13 / b.m13;
  Result.m23 := a.m23 / b.m23;
  Result.m33 := a.m33 / b.m33;
end;

function Matrix4x4.dot(a: Matrix4x4): Matrix4x4;
begin
  Result.m00 := (m00 * A.m00) + (m10 * A.m01) + (m20 * A.m02) + (m30 * A.m03);
  Result.m10 := (m00 * A.m10) + (m10 * A.m11) + (m20 * A.m12) + (m30 * A.m13);
  Result.m20 := (m00 * A.m20) + (m10 * A.m21) + (m20 * A.m22) + (m30 * A.m23);
  Result.m30 := (m00 * A.m30) + (m10 * A.m31) + (m20 * A.m32) + (m30 * A.m33);
  Result.m01 := (m01 * A.m00) + (m11 * A.m01) + (m21 * A.m02) + (m31 * A.m03);
  Result.m11 := (m01 * A.m10) + (m11 * A.m11) + (m21 * A.m12) + (m31 * A.m13);
  Result.m21 := (m01 * A.m20) + (m11 * A.m21) + (m21 * A.m22) + (m31 * A.m23);
  Result.m31 := (m01 * A.m30) + (m11 * A.m31) + (m21 * A.m32) + (m31 * A.m33);
  Result.m02 := (m02 * A.m00) + (m12 * A.m01) + (m22 * A.m02) + (m32 * A.m03);
  Result.m12 := (m02 * A.m10) + (m12 * A.m11) + (m22 * A.m12) + (m32 * A.m13);
  Result.m22 := (m02 * A.m20) + (m12 * A.m21) + (m22 * A.m22) + (m32 * A.m23);
  Result.m32 := (m02 * A.m30) + (m12 * A.m31) + (m22 * A.m32) + (m32 * A.m33);
  Result.m03 := (m03 * A.m00) + (m13 * A.m01) + (m23 * A.m02) + (m33 * A.m03);
  Result.m13 := (m03 * A.m10) + (m13 * A.m11) + (m23 * A.m12) + (m33 * A.m13);
  Result.m23 := (m03 * A.m20) + (m13 * A.m21) + (m23 * A.m22) + (m33 * A.m23);
  Result.m33 := (m03 * A.m30) + (m13 * A.m31) + (m23 * A.m32) + (m33 * A.m33);
end;

function Matrix4x4.dot(a: Vector4): Vector4;
begin
  Result.X := (m00 * A.X) + (m10 * A.Y) + (m20 * A.Z) + (m30 * A.W);
  Result.Y := (m01 * A.X) + (m11 * A.Y) + (m21 * A.Z) + (m31 * A.W);
  Result.Z := (m02 * A.X) + (m12 * A.Y) + (m22 * A.Z) + (m32 * A.W);
  Result.W := (m03 * A.X) + (m13 * A.Y) + (m23 * A.Z) + (m33 * A.W);
end;

class function Matrix4x4.identity: Matrix4x4;
begin
  Result := Matrix4x4.Create
  (
     1, 0, 0, 0,
     0, 1, 0, 0,
     0, 0, 1, 0,
     0, 0, 0, 1
  );
end;

function Matrix4x4.inverse: Matrix4x4;
var
  D: float;
begin
  D := (
    (m00 *    (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31) + (m23*m32*m11)+(m33*m12*m21))))  +
    (m10 * (0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31) + (m23*m32*m01)+(m33*m02*m21))))) +
    (m20 *    (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31) + (m13*m32*m01)+(m33*m02*m11))))  +
    (m30 * (0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21) + (m13*m22*m01)+(m23*m02*m11)))))
  );
  if (D=0) then begin
    exit;    // ought not be necessary, but... life isn't always fair.
  end;
  D := 1/D;
  //- Calculate matrix of minors and co-factor, transpose for adjugate, and
  //- multiply 1/determinant
  //- Calculate matrix of minors and co-factor and transpose
  Result.m00 := D * (  (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31) + (m23*m32*m11)+(m33*m12*m21))));
  Result.m01 := D * (0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31) + (m23*m32*m01)+(m33*m02*m21))));
  Result.m02 := D * (  (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31) + (m13*m32*m01)+(m33*m02*m11))));
  Result.m03 := D * (0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21) + (m13*m22*m01)+(m23*m02*m11))));
  Result.m10 := D * (0-(((m10*m22*m33)+(m20*m32*m13)+(m30*m12*m23)) - ((m13*m22*m30) + (m23*m32*m10)+(m33*m12*m20))));
  Result.m11 := D * (  (((m00*m22*m33)+(m20*m32*m03)+(m30*m02*m23)) - ((m03*m22*m30) + (m23*m32*m00)+(m33*m02*m20))));
  Result.m12 := D * (0-(((m00*m12*m33)+(m10*m32*m03)+(m30*m02*m13)) - ((m03*m12*m30) + (m13*m32*m00)+(m33*m02*m10))));
  Result.m13 := D * (  (((m00*m12*m23)+(m10*m22*m03)+(m20*m02*m13)) - ((m03*m12*m20) + (m13*m22*m00)+(m23*m02*m10))));
  Result.m20 := D * (  (((m10*m21*m33)+(m20*m31*m13)+(m30*m11*m23)) - ((m13*m21*m30) + (m23*m31*m10)+(m33*m11*m20))));
  Result.m21 := D * (0-(((m00*m21*m33)+(m20*m31*m03)+(m30*m01*m23)) - ((m03*m21*m30) + (m23*m31*m00)+(m33*m01*m20))));
  Result.m22 := D * (  (((m00*m11*m33)+(m10*m31*m03)+(m30*m01*m13)) - ((m03*m11*m30) + (m13*m31*m00)+(m33*m01*m10))));
  Result.m23 := D * (0-(((m00*m11*m23)+(m10*m21*m03)+(m20*m01*m13)) - ((m03*m11*m20) + (m13*m21*m00)+(m23*m01*m10))));
  Result.m30 := D * (0-(((m10*m21*m32)+(m20*m31*m12)+(m30*m11*m22)) - ((m12*m21*m30) + (m22*m31*m10)+(m32*m11*m20))));
  Result.m31 := D * (  (((m00*m21*m32)+(m20*m31*m02)+(m30*m01*m22)) - ((m02*m21*m30) + (m22*m31*m00)+(m32*m01*m20))));
  Result.m32 := D * (0-(((m00*m11*m32)+(m10*m31*m02)+(m30*m01*m13)) - ((m02*m11*m30) + (m13*m31*m00)+(m32*m01*m10))));
  Result.m33 := D * (  (((m00*m11*m22)+(m10*m21*m02)+(m20*m01*m12)) - ((m02*m11*m20) + (m12*m21*m00)+(m22*m01*m10))));
end;

class operator Matrix4x4.Multiply(a, b: Matrix4x4): Matrix4x4;
begin
  Result.m00 := a.m00 * b.m00;
  Result.m10 := a.m10 * b.m10;
  Result.m20 := a.m20 * b.m20;
  Result.m30 := a.m30 * b.m30;
  Result.m01 := a.m01 * b.m01;
  Result.m11 := a.m11 * b.m11;
  Result.m21 := a.m21 * b.m21;
  Result.m31 := a.m31 * b.m31;
  Result.m02 := a.m02 * b.m02;
  Result.m12 := a.m12 * b.m12;
  Result.m22 := a.m22 * b.m22;
  Result.m32 := a.m32 * b.m32;
  Result.m03 := a.m03 * b.m03;
  Result.m13 := a.m13 * b.m13;
  Result.m23 := a.m23 * b.m23;
  Result.m33 := a.m33 * b.m33;
end;

class operator Matrix4x4.Multiply(a: Matrix4x4; b: float): Matrix4x4;
begin
  Result.m00 := a.m00 * b;
  Result.m10 := a.m10 * b;
  Result.m20 := a.m20 * b;
  Result.m30 := a.m30 * b;
  Result.m01 := a.m01 * b;
  Result.m11 := a.m11 * b;
  Result.m21 := a.m21 * b;
  Result.m31 := a.m31 * b;
  Result.m02 := a.m02 * b;
  Result.m12 := a.m12 * b;
  Result.m22 := a.m22 * b;
  Result.m32 := a.m32 * b;
  Result.m03 := a.m03 * b;
  Result.m13 := a.m13 * b;
  Result.m23 := a.m23 * b;
  Result.m33 := a.m33 * b;
end;

class function Matrix4x4.rotationX(degrees: float): Matrix4x4;
var
  d: single;
begin
  d := degrees*Pi/180;
  Result := Matrix4x4.Create(
    1,  0,             0,  0,
    0,  cos(d),  -sin(d),  0,
    0,  sin(d),   cos(d),  0,
    0,  0,             0,  1
  );
end;

class function Matrix4x4.rotationY(degrees: float): Matrix4x4;
var
  d: single;
begin
  d := degrees*Pi/180;
  Result := Matrix4x4.Create(
    cos(d),   0,  sin(d),  0,
    0,        1,       0,  0,
    -sin(d),  0,  cos(d),  0,
    0,           0,       0,            1
  );
end;

class function Matrix4x4.rotationZ(degrees: float): Matrix4x4;
var
  d: single;
begin
  d := degrees*Pi/180;
  Result := Matrix4x4.Create(
    cos(d), -sin(d),  0,  0,
    sin(d), cos(d),   0,  0,
    0,            0,  1,  0,
    0,            0,  0,  1
  );
end;

class function Matrix4x4.scale(s: Vector3): Matrix4x4;
begin
  Result := Matrix4x4.Create(
   s.X, 0,   0,   0,
   0,   s.Y, 0,   0,
   0,   0,   s.Z, 0,
   0,   0,   0,   1
  );
end;

class operator Matrix4x4.Subtract(a: Matrix4x4; b: float): Matrix4x4;
begin
  Result.m00 := a.m00 - b;
  Result.m10 := a.m10 - b;
  Result.m20 := a.m20 - b;
  Result.m30 := a.m30 - b;
  Result.m01 := a.m01 - b;
  Result.m11 := a.m11 - b;
  Result.m21 := a.m21 - b;
  Result.m31 := a.m31 - b;
  Result.m02 := a.m02 - b;
  Result.m12 := a.m12 - b;
  Result.m22 := a.m22 - b;
  Result.m32 := a.m32 - b;
  Result.m03 := a.m03 - b;
  Result.m13 := a.m13 - b;
  Result.m23 := a.m23 - b;
  Result.m33 := a.m33 - b;
end;

class function Matrix4x4.translation(t: Vector3): Matrix4x4;
begin
  Result := Matrix4x4.Create(
    1, 0, 0, t.X,
    0, 1, 0, t.Y,
    0, 0, 1, t.Z,
    0, 0, 0, 1
  );
end;

function Matrix4x4.transpose: Matrix4x4;
begin
  Result := Matrix4x4.Create(
   m00, m01, m02, m03,
   m10, m11, m12, m13,
   m20, m21, m22, m23,
   m30, m31, m32, m33
  );
end;

class operator Matrix4x4.Subtract(a, b: Matrix4x4): Matrix4x4;
begin
  Result.m00 := a.m00 - b.m00;
  Result.m10 := a.m10 - b.m10;
  Result.m20 := a.m20 - b.m20;
  Result.m30 := a.m30 - b.m30;
  Result.m01 := a.m01 - b.m01;
  Result.m11 := a.m11 - b.m11;
  Result.m21 := a.m21 - b.m21;
  Result.m31 := a.m31 - b.m31;
  Result.m02 := a.m02 - b.m02;
  Result.m12 := a.m12 - b.m12;
  Result.m22 := a.m22 - b.m22;
  Result.m32 := a.m32 - b.m32;
  Result.m03 := a.m03 - b.m03;
  Result.m13 := a.m13 - b.m13;
  Result.m23 := a.m23 - b.m23;
  Result.m33 := a.m33 - b.m33;
end;

{$endregion}

{$region ' Ray'}

class function Ray.Create( aOrigin: Vertex; aDirection: Vector3; aLength: float ): Ray;
begin
  Result.Origin := aOrigin;
  Result.Direction := aDirection.UnitVector;
  Result.Length := aLength;
end;

class function Ray.Create( aOrigin: Vertex; aDestination: Vertex ): Ray;
var
  V: Vector3;
begin
  Result.Origin := aOrigin;
  V := aDestination - aOrigin;
  Result.Direction := V;
  Result.Length := V.magnitude;
end;

function Ray.Destination: Vertex;
begin
  Result := Origin + (Vector3(Direction) * Length);
end;

procedure Ray.setDirection(const Value: Vector3);
begin
  fDirection := Value.UnitVector;
end;

{$endregion}

{$region ' Plane'}

class function Plane.Create( aOrigin: Vertex; aNormal: Vector3 ): Plane;
begin
  Result.Origin := aOrigin;
  Result.fNormal := aNormal.normalized;
end;


function Plane.Intersect(const aRay: Ray): boolean;
var
  k: float;
  v: vector3;
  w: vector3;
begin
  v := aRay.Destination;
  w := Origin - aRay.Origin;
  k := (w.dot(fNormal)/v.dot(fNormal));
  Result := (k>=0) and (k<=1);
end;

function Plane.Intersection(const aRay: Ray): Vertex;
var
  k: float;
  v: vector3;
  w: vector3;
begin
  v := aRay.Destination;
  w := Origin - aRay.Origin;
  k := (w.dot(fNormal)/v.dot(fNormal));
  Result := aRay.Origin + (v * k);
end;

procedure Plane.setNormal(const Value: Vector3);
begin
  fNormal := Value.normalized;
end;

{$endregion}

end.
