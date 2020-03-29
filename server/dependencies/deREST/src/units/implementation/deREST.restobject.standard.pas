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
unit deREST.restobject.standard;

interface
uses
  classes,
  deREST.types;

type
  TRESTObject = class( TInterfacedObject, IRESTObject )
  private
    fValues: TStringList;
  private //- IRESTObject -//
    procedure Assign( SourceObject: IRESTObject );
    function getCount: uint32;
    function getNameByIndex( idx: uint32 ): string;
    function getValueByIndex( idx: uint32 ): string;
    function getValueByName( aname: string ): string;
    procedure setNameByIndex( idx: uint32; aname: string );
    procedure setValueByIndex( idx: uint32; avalue: string );
    procedure setValueByName( aname: string; avalue: string );
    procedure AddValue( aname: string; avalue: string );
    procedure RemoveValue( aname: string ); overload;
    procedure RemoveValue( idx: uint32 ); overload;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TRESTObject }

procedure TRESTObject.AddValue(aname, avalue: string);
begin
  fValues.Add(aName+'='+aValue);
end;

procedure TRESTObject.Assign(SourceObject: IRESTObject);
var
  idx: uint32;
begin
  fValues.Clear;
  if SourceObject.Count=0 then begin
    exit;
  end;
  for idx := 0 to pred(SourceObject.Count) do begin
    AddValue( SourceObject.Name[idx], SourceObject.ValueByIndex[idx] );
  end;
end;

constructor TRESTObject.Create;
begin
  inherited Create;
  fValues := TStringList.Create;
end;

destructor TRESTObject.Destroy;
begin
  fValues.DisposeOf;
  inherited Destroy;
end;

function TRESTObject.getCount: uint32;
begin
  Result := fValues.Count;
end;

function TRESTObject.getNameByIndex(idx: uint32): string;
begin
  Result := fValues.Names[idx];
end;

function TRESTObject.getValueByIndex(idx: uint32): string;
begin
  Result := fValues.ValueFromIndex[idx];
end;

function TRESTObject.getValueByName(aname: string): string;
begin
  Result := fValues.Values[aname];
end;

procedure TRESTObject.RemoveValue(aname: string);
begin
  fValues.Delete( fValues.IndexOf(aname) );
end;

procedure TRESTObject.RemoveValue(idx: uint32);
begin
  fValues.Delete(idx);
end;

procedure TRESTObject.setNameByIndex(idx: uint32; aname: string);
var
  NewString: string;
begin
  NewString := aName + '=' + fValues.ValueFromIndex[idx];
  fValues.Add(NewString);
  fValues.Delete(idx);
end;

procedure TRESTObject.setValueByIndex(idx: uint32; avalue: string);
begin
  fValues.ValueFromIndex[idx] := aValue;
end;

procedure TRESTObject.setValueByName(aname, avalue: string);
begin
  fValues.Values[aname] := aValue;
end;

end.
