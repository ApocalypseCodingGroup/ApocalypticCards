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
///   Chapmanworld Collections Generics cwCollections.
/// </summary>
unit cwCollections;
{$ifdef fpc} {$mode delphiunicode} {$endif}

interface

type

{$region ' TEnumerate<T>'}
  {$ifdef fpc}
  /// <exclude/>
  TEnumerateGlobalHandler<T> = procedure( const item : T );
  /// <exclude/>
  TEnumerateOfObjectHandler<T> = procedure( const item : T ) of object;
  {$else}
  /// <excluide/>
  TEnumerateReferenceHandler<T> = reference to procedure( const item : T );
  {$endif}
{$endregion}

{$region ' TEnumeratePair<K,V>'}
  {$ifdef fpc}
  /// <excluide/>
  TEnumeratePairGlobalHandler<K,V> = procedure( const key: K; const value: V );
  /// <excluide/>
  TEnumeratePairOfObjectHandler<K,V> = procedure( const key: K; const value: V ) of object;
  {$else}
  /// <excluide/>
  TEnumeratePairReferenceHandler<K,V> = reference to procedure( const key: K; const value: V );
  {$endif}
{$endregion}

{$region ' TCompare<A,B>'}

  ///  <summary>
  ///    The value returned from a comparison call-back to indicate
  ///    the equality/inequality of the values compared.
  ///  </summary>
  TComparisonResult = (
    crErrorNotCompared,
    crAGreaterThanB,
    crBGreaterThanA,
    crAEqualToB
  );

  {$ifdef fpc}
  /// <excluide/>
  TCompareGlobalHandler<T> = function( const AValue: T; const BValue: T ): TComparisonResult;
  /// <excluide/>
  TCompareOfObjectHandler<T> = function( const AValue: T; const BValue: T ): TComparisonResult of object;
  {$else}
  /// <excluide/>
  TCompareReferenceHandler<T> = reference to function( const AValue: T; const BValue: T ): TComparisonResult;
  {$endif}
{$endregion}

{$region ' ICollection'}

  ///   This interface does nothing other than to provide an interface from
  ///   which other collection interfaces may be derrived.
  ///   <exclude/>
  ICollection = interface
    ['{B21B7438-044D-4D3A-8CD2-973DC7C5B1CA}']
  end;

{$endregion}

{$region ' IRingBuffer<T>'}

  /// <summary>
  ///   A ring buffer is a FIFO buffer of pre-determined size. This interface
  ///   represents a read-only ring buffer.
  /// </summary>
  /// <typeparam name="T">
  ///   The data-type of the items to be stored within the buffer.
  /// </typeparam>
  IReadOnlyRingBuffer<T> = interface( ICollection )
    ['{B26BFBD9-7293-48F0-9C04-CCF07E902924}']

    /// <summary>
    ///   Returns true if the buffer is empty, else returns false.
    /// </summary>
    /// <returns>
    ///   Returns true if the ring buffer not empty, else returns false.
    /// </returns>
    function IsEmpty: boolean;

    /// <summary>
    ///   Retrieves and removes an item from the ring buffer.
    /// </summary>
    /// <param name="Item">
    ///   out parameter to be populated with the item extracted from the
    ///   buffer.
    /// </param>
    /// <returns>
    ///   Returns true if the item was extracted from the buffer, else returns
    ///   false.
    /// </returns>
    function Pull( out Item: T ): boolean;

  end;

  /// <summary>
  ///   A ring buffer is a FIFO buffer of pre-determined size.
  /// </summary>
  /// <typeparam name="T">
  ///   The data-type of the items to be stored within the buffer.
  /// </typeparam>
  IRingBuffer<T> = interface( IReadOnlyRingBuffer<T> )
    ['{44A78B5E-440D-4BC1-97E7-3C3DAB74DBB8}']

    /// <summary>
    ///   Pushes a new item into the buffer, assuming there is space to do so.
    ///   If there is no space, returns false.
    /// </summary>
    /// <param name="Item">
    ///   The item to insert into the buffer.
    /// </param>
    /// <returns>
    ///   Returns true if the item was added, else returns false to indicate
    ///   that the buffer is full.
    /// </returns>
    function Push( const Item: T ): boolean;

    /// <summary>
    ///   Returns the ring buffer cast as IReadOnlyRingBuffer.
    /// </summary>
    function getAsReadOnly: IReadOnlyRingBuffer<T>;

  end;

{$endregion}

{$region ' IStack<T>'}

  /// <summary>
  ///   A stack is a FILO buffer of pre-determined size. <br />This interface
  ///   represents a read-only stack.
  /// </summary>
  /// <typeparam name="T">
  ///   The data-type of the items to be stored in the stack.
  /// </typeparam>
  IReadOnlyStack<T> = interface( ICollection )
    ['{8FB4DD73-3D52-4781-9C82-0B09721CDD16}']

    /// <summary>
    ///   Retrieves and removes an item from the top of the stack.
    /// </summary>
    /// <returns>
    ///   The item returned from the stack, or nil if no items remain.
    /// </returns>
    function Pull: T;

  end;

  /// <summary>
  ///   A stack is a FILO buffer of pre-determined size.
  /// </summary>
  /// <typeparam name="T">
  ///   The data-type of the items to be stored in the stack.
  /// </typeparam>
  IStack<T> = interface( IReadOnlyStack<T> )
    ['{36648989-4580-4003-B773-4563F186A2B1}']

    /// <summary>
    ///   Pushes an item onto the top of the stack.
    /// </summary>
    /// <param name="Item">
    ///   The item to push onto the stack.
    /// </param>
    procedure Push( const Item: T );

    /// <summary>
    ///   Returns the ring buffer cast as IReadOnlyStack.
    /// </summary>
    function getAsReadOnly: IReadOnlyStack<T>;

  end;
{$endregion}

{$region ' IDictionary<K,V>'}

  /// <summary>
  ///   A dictionary is a collection of key-value pairs. This interface
  ///   represents a read-only dictionary.
  /// </summary>
  /// <typeparam name="K">
  ///   Data type for the key part of each key/value pair.
  /// </typeparam>
  /// <typeparam name="V">
  ///   Data type for the value part of each key/value pair.
  /// </typeparam>
  IReadOnlyDictionary<K,V> = interface( ICollection )
    ['{3E208C75-6B22-4A1E-A788-B362D001B3AB}']

    ///  <summary>
    ///    Calls the Enumerate callback for each key-value pair in the
    ///    dictionary.
    ///  </summary>
    {$ifdef fpc}
    procedure ForEach( const Enumerate: TEnumeratePairGlobalHandler<K,V> ); overload;
    procedure ForEach( const Enumerate: TEnumeratePairOfObjectHandler<K,V> ); overload;
    {$else}
    procedure ForEach( const Enumerate: TEnumeratePairReferenceHandler<K,V> ); overload;
    {$endif}

    /// <summary>
    ///   Returns the total number of items in the dictionary.
    /// </summary>
    /// <returns>
    ///   The number of items in the dictionary.
    /// </returns>
    function getCount: nativeuint;

    /// <summary>
    ///   Returns the key part of an item by it's integer index.
    /// </summary>
    /// <param name="idx">
    ///   The index of the collection item for which the key string should be
    ///   returned.
    /// </param>
    function getKeyByIndex( const idx: nativeuint ): K;

    /// <summary>
    ///   Returns the value part of an item by its integer index.
    /// </summary>
    /// <param name="idx">
    ///   The index of the collection item for which the value part should be
    ///   returned.
    /// </param>
    function getValueByIndex( const idx: nativeuint ): V;

    /// <summary>
    ///   Returns true if there is an item with a key that matches the key
    ///   paramter, else returns false.
    /// </summary>
    /// <param name="key">
    ///   The key string of the item to return.
    /// </param>
    /// <returns>
    ///   True if the item is found by it's key string, else returns false.
    /// </returns>
    /// <remarks>
    ///   <b>Note</b> Duplicate values are always permitted. Duplicate keys are
    ///   not permitted in the dictionary. Keys are case insensitive.
    /// </remarks>
    function getKeyExists( const key: K ): boolean;

    /// <summary>
    ///   Returns the value part of an item which is identified by its string
    ///   key.
    /// </summary>
    /// <param name="key">
    ///   The key string used to identify which value to return.
    /// </param>
    /// <returns>
    ///   If the item with a matching key is found, it's value part is
    ///   returned. If the item is not found, this method will return nil.
    /// </returns>
    function getValueByKey( const key: K ): V;

    ///  <summary>
    ///    Returns the dictionmary as a read-only IReadOnlyDictionary.
    ///    (For use in derrived interfaces)
    ///  </summary>
    function getAsReadOnly: IReadOnlyDictionary<K,V>;

    /// <summary>
    ///   Returns the total number of items in the dictionary collection.
    /// </summary>
    /// <value>
    ///   Total number of items in dictionary.
    /// </value>
    property Count: nativeuint read getCount;

    /// <summary>
    ///   Returns true if the key string matches the key of an item already in
    ///   the dictionary.
    /// </summary>
    /// <param name="key">
    ///   The key to match in the dictionary.
    /// </param>
    /// <value>
    ///   Returns true if the key parameter matches the key of an item in the
    ///   dictionary, else returns false.
    /// </value>
    property KeyExists[ const key: K ]: boolean read getKeyExists;

    /// <summary>
    ///   Returns the value part of an item in the dictionary, identified by
    ///   it's key string.
    /// </summary>
    /// <param name="key">
    ///   The key of the item to find in the dictionary.
    /// </param>
    /// <value>
    ///   If an item exists in the dictionary with a key to match the 'key'
    ///   index parameter, then that value is returned. Otherwise, returns nil.
    /// </value>
    property ValueByKey[ const key: K ]: V read getValueByKey; default;

    /// <summary>
    ///   Returns the value part of an item in the dictionary, identified by
    ///   it's integer index.
    /// </summary>
    /// <param name="idx">
    ///   Integer index of the item within the dictionary to return.
    /// </param>
    /// <value>
    ///   If the index is valid, the value part of the item identified by the
    ///   index is returned, otherwise returns nil.
    /// </value>
    property ValueByIndex[ const idx: nativeuint ]: V read getValueByIndex;

    /// <summary>
    ///   Returns the key string of an item in the dictionary as identified by
    ///   it's integer index.
    /// </summary>
    /// <param name="idx">
    ///   Integer index of item to return.
    /// </param>
    /// <value>
    ///   If the index provided is valid, the key string for the item is
    ///   returned, else a null-string is returned.
    /// </value>
    property KeyByIndex[ const idx: nativeuint ]: K read getKeyByIndex;

  end;

  /// <summary>
  ///   A dictionary is a collection of key-value pairs.
  /// </summary>
  /// <typeparam name="K">
  ///   The data type for the key in each key/value pair.
  /// </typeparam>
  /// <typeparam name="V">
  ///   The data type for the value in each key/value pair.
  /// </typeparam>
  IDictionary<K,V> = interface( IReadOnlyDictionary<K,V> )
    ['{5D0EA611-6D3D-4495-B8CB-3F249AF59746}']

    /// <summary>
    ///   Sets a value by it's key within the dictionary.
    /// </summary>
    /// <param name="key">
    ///   The key used to identify the item for which the value should be set.
    /// </param>
    /// <param name="value">
    ///   The value to set against the item identified by the key parameter.
    /// </param>
    /// <remarks>
    ///   If the value does not exist in the dictionary it is added. <br />If
    ///   the value does exist in the dictionary, then it's value is set to
    ///   that of the value parameter. <br />(This prohibits duplication, as
    ///   there is no given means of setting the key for an existing value)
    /// </remarks>
    procedure setValueByKey( const key: K; const value: V );

    /// <summary>
    ///   Sets a value by it's index within the dictionary.
    /// </summary>
    /// <param name="idx">
    ///   The index of the value to set.
    /// </param>
    /// <param name="value">
    ///   The new value.
    /// </param>
    procedure setValueByIndex( const idx: nativeuint; const value: V );

    /// <summary>
    ///   Removes an item from the dictionary as identified by it's integer
    ///   index.
    /// </summary>
    /// <param name="idx">
    ///   Integer index of the item to remove.
    /// </param>
    /// <remarks>
    ///   If the integer indes is out of bounds, this method will silently
    ///   fail.
    /// </remarks>
    procedure removeByIndex( const idx: nativeuint );

    /// <summary>
    ///   Removes all items from the dictionary collection.
    /// </summary>
    /// <remarks>
    ///   All allocated memory is returned to the system.
    /// </remarks>
    procedure Clear;

    /// <summary>
    ///   Gets/Sets the value part of an item in the dictionary, identified by
    ///   it's key.
    /// </summary>
    /// <param name="key">
    ///   The key of the item to find in the dictionary.
    /// </param>
    /// <value>
    ///   If an item exists in the dictionary with a key to match the 'key'
    ///   index parameter, then that value is returned. Otherwise, returns nil.
    /// </value>
    property ValueByKey[ const key: K ]: V read getValueByKey write setValueByKey; default;

    /// <summary>
    ///   Gets/Sets the value part of an item in the dictionary, identified by
    ///   it's integer index.
    /// </summary>
    /// <param name="idx">
    ///   Integer index of the item within the dictionary to return.
    /// </param>
    /// <value>
    ///   If the index is valid, the value part of the item identified by the
    ///   index is returned, otherwise returns nil.
    /// </value>
    property ValueByIndex[ const idx: nativeuint ]: V read getValueByIndex write setValueByIndex;

  end;
{$endregion}

{$region ' IList<T>'}

  /// <summary>
  ///   Represents a list collection. <br />Lists provide array style access to
  ///   the items within the collection. This interface represents a read-only
  ///   list by providing only the methods for read access.
  /// </summary>
  /// <typeparam name="T">
  ///   The data type of the items stored within the list.
  /// </typeparam>
  IReadOnlyList<T> = interface( ICollection )
    ['{88A742C2-E45E-4B4D-826E-24EEF4CF0F18}']

    /// <summary>
    ///   Calls the Enumerate callback for each item in the list.
    /// </summary>
    /// <param name="Enumerate">
    ///   A method to be called for each item in the list.
    /// </param>
    /// <remarks>
    ///   When targeting the Delphi compiler, you may use an anonymous method
    ///   as the enumeration call back. As FPC does not currently support
    ///   anonymous methods however, doing so will break FPC compatibility.
    /// </remarks>
   {$ifdef fpc}
    procedure ForEach( const Enumerate: TEnumerateGlobalHandler<T> ); overload;
    /// <exclude/>
    procedure ForEach( const Enumerate: TEnumerateOfObjectHandler<T> ); overload;
    {$else}
    procedure ForEach( const Enumerate: TEnumerateReferenceHandler<T> ); overload;
    {$endif}

    /// <summary>
    ///   Returns the number of items currently stored in the list.
    /// </summary>
    /// <returns>
    ///   The number of items currently stored in the list.
    /// </returns>
    function getCount: nativeuint;

    /// <summary>
    ///   Returns an item from the list, specified by it's index.
    /// </summary>
    /// <param name="idx">
    ///   An index into the list of items, specifying which item should be
    ///   returned.
    /// </param>
    /// <returns>
    ///   Returns an item, or else nil if the index was out of range.
    /// </returns>
    function getItem( const idx: nativeuint ): T;

    /// <summary>
    ///   Returns the list as a read-only IReadOnlyList.
    /// </summary>
    /// <returns>
    ///   A reference to the list cast as an IReadOnlyList&lt;T&gt;
    /// </returns>
    function getAsReadOnly: IReadOnlyList<T>;

    //- Pascal only properties -//
    /// <summary>
    ///   Returns the number of items within the list.
    /// </summary>
    /// <value>
    ///   The number of items within the list.
    /// </value>
    property Count: nativeuint read getCount;


    /// <summary>
    ///   Array style access to the items within the list.
    /// </summary>
    /// <param name="idx">
    ///   The index of the list item to be returned.
    /// </param>
    /// <value>
    ///   The requested item from the list, or else nil if something goes wrong
    ///   (such as index out of bounds)
    /// </value>
    property Items[ const idx: nativeuint ]: T read getItem; default;

  end;

  /// <summary>
  ///   Represents a list collection. <br />Lists provide array style access to
  ///   the items within the collection.
  /// </summary>
  /// <typeparam name="T">
  ///   The data-type of the items within the list, must be interface.
  /// </typeparam>
  IList<T> = interface( IReadOnlyList<T> )
    ['{2F7708B6-39A9-41CC-980A-AA653AF016D8}']

    ///  <summary>
    ///    Removes all items from the list.
    ///  </summary>
    procedure Clear;

    /// <summary>
    ///   Adds an item to the list and returns it's index within the list.
    /// </summary>
    /// <param name="item">
    ///   The item to add to the list.
    /// </param>
    /// <returns>
    ///   The index of the item now added to the list.
    /// </returns>
    function Add( const item: T ): nativeuint;

    /// <summary>
    ///   Replaces the item at idx with the new item.
    /// </summary>
    /// <param name="idx">
    ///   The index of the item to be replaced.
    /// </param>
    /// <param name="item">
    ///   The new item to replace the existing item in the list.
    /// </param>
    procedure setItem( const idx: nativeuint; const item: T );

    ///  <summary>
    ///    Removes and item from the list by reference.
    ///  </summary>
    {$ifdef fpc}
    procedure Remove( const Item: T );
    {$else}
    procedure Remove( const Item: T; const Compare: TCompareReferenceHandler<T> );
    {$endif}

    /// <summary>
    ///   Removes an item from the list as specified by it's index.
    /// </summary>
    /// <param name="idx">
    ///   The index of the item to remove from the list.
    /// </param>
    function RemoveItem( const idx: nativeuint ): boolean;

    //- Pascal only properties -//
    /// <summary>
    ///   Returns the number of items currently stored in the list.
    /// </summary>
    /// <value>
    ///   The number of items in the list.
    /// </value>
    property Count: nativeuint read getCount;

    /// <summary>
    ///   Provides array style access to the items in the list.
    /// </summary>
    /// <param name="idx">
    ///   The index of an item in the list.
    /// </param>
    /// <value>
    ///   The requested item in the list, or nil if an error state occurs (such
    ///   as index out of bounds).
    /// </value>
    property Items[ const idx: nativeuint ]: T read getItem write setItem; default;

  end;

{$endregion}

{$region ' Specializations'}

  /// <summary>
  ///   A list collection of strings. <br />This interface represents a list
  ///   collection of strings with only methods and properties for reading from
  ///   the list.
  /// </summary>
  IReadOnlyStringList = interface( ICollection )
    ['{2AF147B3-916C-47EF-AF30-3176826A256E}']

    /// <summary>
    ///   Calls the Enumerate callback for each string in the list.
    /// </summary>
    /// <param name="Enumerate">
    ///   A method to be called for each string in the list.
    /// </param>
    /// <remarks>
    ///   When targeting the Delpjhi compiler, an anonymous method may be used
    ///   as the enumerate callback. As the FPC compiler does not currently
    ///   support anonymous methods, doing so will break FPC compatibility.
    /// </remarks>
    {$ifdef fpc}
    procedure ForEach( const Enumerate: TEnumerateGlobalHandler<string> ); overload;
    /// <exclude/>
    procedure ForEach( const Enumerate: TEnumerateOfObjectHandler<string> ); overload;
    {$else}
    procedure ForEach( const Enumerate: TEnumerateReferenceHandler<string> ); overload;
    {$endif}

    /// <summary>
    ///   Returns the number of strings currently stored in the list.
    /// </summary>
    /// <returns>
    ///   The number of strings currently stored in the list.
    /// </returns>
    function getCount: nativeuint;

    /// <summary>
    ///   Returns a string from the list, specified by it's index.
    /// </summary>
    /// <param name="idx">
    ///   An index into the list of string, specifying which string should be
    ///   returned.
    /// </param>
    /// <returns>
    ///   Returns the string specified by idx.
    /// </returns>
    function getString( const idx: nativeuint ): string;

    /// <summary>
    ///   Returns true if 'Search' is found in the list. <br />(Defaults to
    ///   case-insensitive)
    /// </summary>
    /// <param name="Search">
    ///   The string to search for within the list.
    /// </param>
    /// <param name="CaseInsensitive">
    ///   (Optional) If set TRUE the search will require that the case of a
    ///   found string match that of the search string. Defaults to FALSE for
    ///   case-insensitive search.
    /// </param>
    /// <returns>
    ///   Returns TRUE if the search string is found within the list, else
    ///   returns false.
    /// </returns>
    function Contains( const Search: string; const CaseInsensitive: boolean = FALSE ): boolean;

    //- Pascal only properties -//

    /// <summary>
    ///   Returns the number of strings currently stored in the list.
    /// </summary>
    property Count: nativeuint read getCount;

    /// <summary>
    ///   Array style access to the strings in the list.
    /// </summary>
    /// <param name="idx">
    ///   Index of a string within the list.
    /// </param>
    /// <value>
    ///   The string as specified by the index (idx).
    /// </value>
    property Items[ const idx: nativeuint ]: string read getString; default;

  end;

  ///  <summary>
  ///    A list collection of strings
  ///  </summary>
  IStringList = interface( IReadOnlyStringList )
    ['{F2CB6B26-6B20-4788-9F9E-AD634FBC4979}']

    /// <summary>
    ///   Returns the list cast as IReadOnlyStringList.
    /// </summary>
    function getAsReadOnly: IReadOnlyStringList;

    ///  <summary>
    ///    Removes all string from the list.
    ///  </summary>
    procedure Clear;

    /// <summary>
    ///   Adds a string to the list and returns it's index within the list.
    /// </summary>
    /// <param name="value">
    ///   The string to be added to the list.
    /// </param>
    function Add( const value: string ): nativeuint;

    /// <summary>
    ///   Replaces the string specified by index with a new string value.
    /// </summary>
    /// <param name="idx">
    ///   The index of the string to be replaced.
    /// </param>
    /// <param name="value">
    ///   The new value to set for the specified string in the list.
    /// </param>
    procedure setString( const idx: nativeuint; const value: string );

    /// <summary>
    ///   Removes a string from the list as specified by it's index.
    /// </summary>
    /// <param name="idx">
    ///   The index of the string to remove from the list.
    /// </param>
    /// <returns>
    ///   Should always return TRUE unless idx is out of bounds.
    /// </returns>
    function RemoveString( const idx: nativeuint ): boolean;

    //- Pascal only properties -//

    /// <summary>
    ///   Returns the number of strings currently stored in the list.
    /// </summary>
    property Count: nativeuint read getCount;

    /// <summary>
    ///   Array style access to the strings in the list.
    /// </summary>
    /// <param name="idx">
    ///   The index of a string within the list.
    /// </param>
    /// <value>
    ///   The string specifed by idx.
    /// </value>
    property Strings[ const idx: nativeuint ]: string read getString write setString; default;
  end;

{$endregion}

implementation

end.
