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
///   Standard implementation for cwCollections.
/// </summary>
unit cwCollections.Standard;
{$ifdef fpc} {$mode delphiunicode} {$endif}

interface
uses
  cwCollections
;

type

{$region ' TList<T>'}
  /// <summary>
  ///   Factory record for creating instances of IList&lt;T&gt;
  /// </summary>
  /// <typeparam name="T">
  ///   The desired storage type for the list.
  /// </typeparam>
  TList<T> = record

    /// <summary>
    ///   Returns an instance if IList&lt;T&gt;.
    /// </summary>
    /// <param name="Granularity">
    ///   (Optional) <br />The number of items to pre-allocate space for with
    ///   each size increase to the list. Defaults to 32.
    /// </param>
    /// <param name="isOrdered">
    ///   (Optional) <br />Retains the order of the list when removing
    ///   items.When set false, performance is slightly improved.
    /// </param>
    /// <param name="isPruned">
    ///   (Optional) <br />When set true, memory is freed in blocks of
    ///   "Granularity" as items are removed from the list.If set false, any
    ///   memory allocated is retained until the list is freed.
    /// </param>
    /// <returns>
    ///   An instance of IList&lt;T&gt;
    /// </returns>
    class function Create(const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false): IList<T>; static;
  end;
{$endregion}

{$region ' TDictionary<K,V>'}
  /// <summary>
  ///   Fractory record for creating instances of IDictionary&lt;K,V&gt;
  /// </summary>
  /// <typeparam name="K">
  ///   The data-type used to represent the key part of each pair.
  /// </typeparam>
  /// <typeparam name="V">
  ///   The data-type used to represent the value part of each pair.
  /// </typeparam>
  TDictionary<K,V> = record

    /// <summary>
    ///   Returns an instance of IDictionary&lt;K,V&gt; for storing Key/Value
    ///   pairs.
    /// </summary>
    /// <param name="KeyCompare">
    ///   Provide a method that compares keys to see if they are equal.
    ///   See TCompare<T> for more detail.
    /// </param>
    /// <param name="Granularity">
    ///   (Optional) <br />Specify the number of key/value pairs to
    ///   pre-allocate space for with each size increase to the dictionary.
    /// </param>
    /// <param name="isOrdered">
    ///   <para>
    ///     (Optional)
    ///   </para>
    ///   <para>
    ///     If set true, the order of key/value pairs in the dictionary is
    ///     retained when pairs are removed. Set false for minor performance
    ///     gain.
    ///   </para>
    /// </param>
    /// <param name="isPruned">
    ///   (Optional) <br />If set true, memory is freed in blocks of
    ///   "Granularity" key/value pairs as pairs are removed from the
    ///   dictionary. If set false, all memory allocated is retained until the
    ///   dictionary is disposed.
    /// </param>
    {$ifdef fpc}
    class function Create( const KeyCompare: TCompareGlobalHandler<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ): IDictionary<K,V>; static; overload;
    class function Create( const KeyCompare: TCompareOfObjectHandler<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ): IDictionary<K,V>; static; overload;
    {$else}
    class function Create( const KeyCompare: TCompareReferenceHandler<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ): IDictionary<K,V>; static;
    {$endif}
  end;

{$endregion}

{$region ' TRingBuffer<T>'}
  /// <summary>
  ///   Factory record for creating instances of IRingBuffer&lt;T&gt;.
  /// </summary>
  /// <typeparam name="T">
  ///   The data-type of the items to store in the ring buffer.s
  /// </typeparam>
  TRingBuffer<T> = record

    /// <summary>
    ///   Returns an instance if IRingBuffeR&lt;T&gt;.
    /// </summary>
    /// <param name="ItemCount">
    ///   (Optional) <br />The number of items to pre-allocate space for within
    ///   the buffer.
    /// </param>
    class function Create( ItemCount: nativeuint = 128 ): IRingBuffer<T>; static;
  end;
{$endregion}

{$region ' TStack<T>'}
  /// <summary>
  ///   Factory record for creating instances of IStack&lt;T&gt;
  /// </summary>
  /// <typeparam name="T">
  ///   The data-type of the items to store in the stack.s
  /// </typeparam>
  TStack<T> = record
    /// <summary>
    ///   Returns an instance of IStack&lt;T&gt;.
    /// </summary>
    /// <param name="Granularity">
    ///   (Optional) <br />The number of items to allocate space for on the
    ///   stack each time it grows for newly added items.
    /// </param>
    /// <param name="IsPruned">
    ///   (Optional) <br />If set true, pre-allocated memory is freed in blocks
    ///   of "granularity" items as items are pulled off of the stack. If set
    ///   false, any memory allocated is retained until the stack is disposed.
    /// </param>
    class function Create( Granularity: nativeuint = 0; IsPruned: boolean = false ): IStack<T>; static;
  end;
{$endregion}

{$region ' TStringList'}
  /// <summary>
  ///   Factory record for creating instances of IStringList&lt;&gt;
  /// </summary>
  TStringList = record
    /// <summary>
    ///   Creates an instance of IStringList&lt;&gt;
    /// </summary>
    /// <param name="Granularity">
    ///   (Optional) Determines the number of strings to pre-allocate memory
    ///   for in the string list. Defaults to 32.
    /// </param>
    /// <param name="isOrdered">
    ///   (Optional) Determines if the items in the list should remain in order
    ///   when removing strings from the list. <br />Defaults to false.
    /// </param>
    /// <param name="isPruned">
    ///   (Optional) Determines if the memory used to store strings should be
    ///   freed when items are removed from the list, or retained until the
    ///   list is disposed. <br />Defaults to false.
    /// </param>
    class function Create( const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ): IStringList; static;
  end;

  ///  <summary>
  ///    Namespace of pre-defined comparison functions for use
  ///    with dictionary / list.remove().
  ///  </summary>
  TCompare = record
    class function CompareStrings( const AValue: string; const BValue: string ): TComparisonResult; static;
  end;

{$endregion}

implementation
uses
  sysutils
, cwCollections.List.standard
, cwCollections.StringList.standard
, cwCollections.Dictionary.standard
, cwCollections.RingBuffer.standard
, cwCollections.Stack.standard
;

{$region ' TList<T>'}
class function TList<T>.Create(const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false): IList<T>;
begin
  Result := TStandardList<T>.Create( Granularity, isOrdered, isPruned );
end;

class function TCompare.CompareStrings(const AValue: string; const BValue: string): TComparisonResult;
begin
  Result := TComparisonResult.crErrorNotCompared;
  if AValue=BValue then begin
    Result := TComparisonResult.crAEqualToB;
  end else if AValue>BValue then begin
    Result := TComparisonResult.crAGreaterThanB;
  end else begin
    Result := TComparisonResult.crBGreaterThanA;
  end;
end;

{$endregion}

{$region ' TStringList'}
class function TStringList.Create( const Granularity: nativeuint; const isOrdered: boolean; const isPruned: boolean ): IStringList;
begin
  Result := TStandardStringList.Create( Granularity, isOrdered, isPruned );
end;
{$endregion}

{$region ' TDictionary<K,V>'}

{$ifdef fpc}
class function TDictionary<K,V>.Create( const KeyCompare: TCompareGlobalHandler<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ): IDictionary<K,V>; static; overload;
begin
  Result := TStandardDictionary<K,V>.Create( KeyCompare, Granularity, isOrdered, isPruned );
end;
{$endif}

{$ifdef fpc}
class function TDictionary<K,V>.Create( const KeyCompare: TCompareOfObjectHandler<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ): IDictionary<K,V>; static; overload;
begin
  Result := TStandardDictionary<K,V>.Create( KeyCompare, Granularity, isOrdered, isPruned );
end;
{$endif}

{$ifndef fpc}
class function TDictionary<K,V>.Create( const KeyCompare: TCompareReferenceHandler<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ): IDictionary<K,V>;
begin
  Result := TStandardDictionary<K,V>.Create( KeyCompare, Granularity, isOrdered, isPruned );
end;
{$endif}

{$endregion}

{$region ' TRingBuffer<T>'}
class function TRingBuffer<T>.Create(ItemCount: nativeuint): IRingBuffer<T>;
begin
  Result := TStandardRingBuffer<T>.Create( ItemCount );
end;
{$endregion}

{$region ' TStack<T>'}
class function TStack<T>.Create( Granularity: nativeuint = 0; IsPruned: boolean = false ): IStack<T>;
begin
  Result := TStandardStack<T>.Create( Granularity, isPruned );
end;
{$endregion}

end.
