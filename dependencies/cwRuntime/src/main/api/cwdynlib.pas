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
///   Cross platform dynamic library loader.
/// </summary>
unit cwDynLib;
{$ifdef fpc} {$mode delphiunicode} {$endif}

interface

type
  /// <summary>
  ///   An instance of IDynlib represents a dynamic library, such as a .dll or
  ///   .so file.
  /// </summary>
  IDynlib = interface
    ['{AA731CC2-8779-4F83-8117-F481DDD2B48D}']

    /// <summary>
    ///   Loads a library from disk into memory.
    /// </summary>
    /// <param name="filepath">
    ///   Specifies the full path and filename of the library to be loaded.
    ///   (Relative paths permitted based on target implementation).
    /// </param>
    /// <returns>
    /// </returns>
    function LoadLibrary( const filepath: string ): boolean;

    /// <summary>
    ///   Unloads the library (previously loaded using the LoadLibrary()
    ///   method) from memory.
    /// </summary>
    /// <returns>
    /// </returns>
    function FreeLibrary: boolean;

    /// <summary>
    ///   Locates a symbol within a library (previously loaded using the
    ///   LoadLibrary() method), and returns a pointer to it.
    /// </summary>
    /// <param name="funcName">
    ///   The name of the function or symbol to locate.
    /// </param>
    /// <returns>
    ///   If successful, returns a pointer to the requested symbol. Otherwise
    ///   returns false. Typically a failure is caused either by not having
    ///   first loaded the library using the LoadLibrary() method, or because
    ///   of an incorrect symbol name specified in the funcName parameter.
    ///   Symbol names may be case sensitive, depending upon the implementation
    ///   and target.
    /// </returns>
    function GetProcAddress( const funcName: string; out ptrProc: pointer ): boolean; overload;
  end;


implementation

end.

