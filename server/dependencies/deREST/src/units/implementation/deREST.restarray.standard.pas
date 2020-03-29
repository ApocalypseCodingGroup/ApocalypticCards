//------------------------------------------------------------------------------
// MIT License
//
//  Copyright (c) 2018 Craig Chapman
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//------------------------------------------------------------------------------
unit deREST.restarray.standard;

interface
uses
  system.generics.collections,
  System.JSON,
  deREST.types;

type
  TRESTArray = class( TInterfacedObject, IRESTArray )
  private
    fObjects: TList<IRESTObject>;
  private //- IRESTCollection -//
    function getCount: uint32;
    function getItem( idx: uint32 ): IRESTObject;
    function addItem: IRESTObject;
    procedure RemoveItem( idx: uint32 ); overload;
    procedure RemoveItem( aRestObject: IRESTObject ); overload;
    function Deserialize( JSONString: string ): boolean;
    function Serialize( var JSONString: string ): boolean;
    procedure DeserializeObject(o: TJSONObject );
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  deREST.restobject.standard;

{ TRESTCollection }

function TRESTArray.addItem: IRESTObject;
var
  NewObject: IRESTObject;
begin
  NewObject := TRESTObject.Create;
  fObjects.Add(NewObject);
  Result := NewObject;
end;

constructor TRESTArray.Create;
begin
  inherited Create;
  fObjects := TList<IRESTObject>.Create;
end;

procedure TRESTArray.DeserializeObject( o: TJSONObject );
var
  idx: uint32;
  NewObject: IRESTObject;
begin
  if o.Count=0 then begin
    exit;
  end;
  NewObject := addItem;
  for idx := 0 to pred(o.Count) do begin
    NewObject.AddValue( o.Pairs[idx].JsonString.Value, o.Pairs[idx].JsonValue.Value );
  end;
end;

function TRESTArray.Deserialize(JSONString: string): boolean;
var
  v: TJSONValue;
  a: TJSONArray;
  o: TJSONObject;
  idx: uint32;
begin
  Result := False;
  v := TJSONObject.ParseJSONValue(JSONString);
  //- If this is an object, deserialize it.
  if (v is TJSONObject) then begin
    o := v as TJSONObject;
    DeserializeObject(o);
    Result := True;
  end else if (v is TJSONArray) then begin
    a := v as TJSONArray;
    //- If it's an empty array, we're done.
    if a.Count=0 then begin
      Result := True;
      exit;
    end;
    //- Loop through array and deserialize each object
    for idx := 0 to pred(a.Count) do begin
      o := a.Items[idx] as TJSONObject;
      DeserializeObject(o);
    end;
    Result := True;
  end;
end;

destructor TRESTArray.Destroy;
begin
  fObjects.Clear;
  fObjects.DisposeOf;
  inherited Destroy;
end;

function TRESTArray.getCount: uint32;
begin
  Result := fObjects.Count;
end;

function TRESTArray.getItem(idx: uint32): IRESTObject;
begin
  Result := fObjects.Items[idx];
end;

procedure TRESTArray.RemoveItem(aRestObject: IRESTObject);
begin
  fObjects.Remove(aRestObject);
end;

procedure TRESTArray.RemoveItem(idx: uint32);
begin
  fObjects.Delete(idx);
end;

function TRESTArray.Serialize(var JSONString: string): boolean;
var
  idx: uint32;
  idy: uint32;
  item: IRESTObject;
begin
  Result := True;
  if getCount=0 then begin
    JSONString := '[]';
    exit;
  end;
  JSONString := '[';
  for idx := 0 to pred(getCount) do begin
    JSONString := JSONString + '{';
    Item := getItem(idx);
    if item.Count>0 then begin
      for idy := 0 to pred(item.Count) do begin
        JSONString := JSONString + '"' + Item.Name[idy] + '": "';
        JSONString := JSONString + Item.ValueByIndex[idy] +'"';
        if idy<pred(item.Count) then begin
          JSONString := JSONString + ',';
        end;
      end;
    end;
    JSONString := JSONString + '}';
    if idx<pred(getCount) then begin
      JSONString := JSONString + ',';
    end;
  end;
  JSONString := JSONString + ']';
end;

end.
