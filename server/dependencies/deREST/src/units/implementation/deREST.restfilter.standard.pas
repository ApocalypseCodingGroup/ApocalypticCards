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
unit deREST.restfilter.standard;

interface
uses
  system.generics.collections,
  deREST.types;

type
  TRESTFilterGroup = class( TInterfacedObject, IRESTFilterGroup, IRESTFilterItem )
  private
    fChildren: TList<IRESTFilterItem>;
    fGroupOperator: TGroupOperator;
  private //- IRESTFilterItem -//
    function AsFilter: IRESTFilter;
    function ASGroup: IRESTFilterGroup;
    function IsFilter: boolean;
    function IsGroup: boolean;
    function ToWhereClause: string;
    function ParamValue( ParamName: string ): IRestFilterItem;
  private //- IRESTFilterGroup -//
    procedure AssignParameterNames( var counter: uint32 );
    function getCount: uint32;
    function getItem( Index: uint32 ): IRESTFilterItem;
    function getGroupOperator: TGroupOperator;
    procedure setGroupOperator( value: TGroupOperator );
    function AddFilter( Identifier: string; Constraint: TConstraint; Value: string ): IRESTFilter;
    function AddGroup( GroupOperator: TGroupOperator ): IRESTFilterGroup;
    function AddItem( Item: IRESTFilterItem ): IRestFilterItem;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

  TRESTFilter = class( TInterfacedObject, IRESTFilter, IRESTFilterItem )
  private
    fParameterName: string;
    fIdentifier: string;
    fConstraint: TConstraint;
    fValue: string;
  private //- IRESTFilterItem -//
    function AsFilter: IRESTFilter;
    function ASGroup: IRESTFilterGroup;
    function IsFilter: boolean;
    function IsGroup: boolean;
    function ParamValue( ParamName: string ): IRestFilterItem;
    procedure AssignParameterNames( var counter: uint32 );
    function ToWhereClause: string;
  private //- IRESTFilter -//
    function getIdentifier: string;
    procedure setIdentifier( value: string );
    function getConstraint: TConstraint;
    procedure setConstraint( value: TConstraint );
    function getValueAsString: string;
    procedure setValueAsString( value: string );
    function getValueAsInteger: int32;
    procedure setValueAsInteger( value: int32 );
    function getValueAsFloat: double;
    procedure setValueAsFloat( value: double );
    function getValueAsBoolean: boolean;
    procedure setValueAsBoolean( value: boolean );
    function getValueAsDateTime: TDateTime;
    procedure setValueAsDateTime( value: TDateTime );
  end;


implementation
uses
  sysutils;

{ TRESTFilter }

function TRESTFilter.AsFilter: IRESTFilter;
begin
  Result := (Self as IRESTFilter);
end;

function TRESTFilter.ASGroup: IRESTFilterGroup;
begin
  Result := nil;
end;

procedure TRESTFilter.AssignParameterNames(var counter: uint32);
begin
  fParameterName := 'PARAM_'+IntToStr(counter);
  inc(counter);
end;

function TRESTFilter.getConstraint: TConstraint;
begin
  Result := fConstraint;
end;

function TRESTFilter.getIdentifier: string;
begin
  Result := fIdentifier;
end;

function TRESTFilter.getValueAsBoolean: boolean;
var
  utValue: string;
begin
  utValue := Uppercase(Trim(fValue));
  Result := (utValue='YES') or (utValue='TRUE');
end;

function TRESTFilter.getValueAsDateTime: TDateTime;
begin
  Result := StrToDateTime(fValue);
end;

function TRESTFilter.getValueAsFloat: double;
begin
  Result := StrToFloat(fValue);
end;

function TRESTFilter.getValueAsInteger: int32;
begin
  Result := StrToInt(fValue);
end;

function TRESTFilter.getValueAsString: string;
begin
  Result := fValue;
end;

function TRESTFilter.IsFilter: boolean;
begin
  Result := True;
end;

function TRESTFilter.IsGroup: boolean;
begin
  Result := False;
end;

function TRESTFilter.ParamValue(ParamName: string): IRestFilterItem;
begin
  Result := nil;
  if ParamName=fParameterName then begin
    Result := Self;
  end;
end;

procedure TRESTFilter.setConstraint(value: TConstraint);
begin
  fConstraint := value;
end;

procedure TRESTFilter.setIdentifier(value: string);
begin
  fIdentifier := value;
end;

procedure TRESTFilter.setValueAsBoolean(value: boolean);
begin
  if Value then begin
    fValue := 'TRUE';
  end else begin
    fValue := 'FALSE';
  end;
end;

procedure TRESTFilter.setValueAsDateTime(value: TDateTime);
begin
  fValue := FormatDateTime('YYYY:MM:DD HH:nn:SS:nnnn',Value);
end;

procedure TRESTFilter.setValueAsFloat(value: double);
begin
  fValue := FloatToStr(Value);
end;

procedure TRESTFilter.setValueAsInteger(value: int32);
begin
  fValue := IntToStr(Value);
end;

procedure TRESTFilter.setValueAsString(value: string);
begin
  fValue := value;
end;

function TRESTFilter.ToWhereClause: string;
begin
  Result := getIdentifier;
  case getConstraint of
    csUnknown: Result := Result + '??';
    csGreaterThan: Result := Result + '>';
    csLessThan: Result := Result + '<';
    csGreaterOrEqual: Result := Result + '>=';
    csLessOrEqual: Result := Result + '<=';
    csEqual: Result := Result + '=';
    csNotEqual: Result := Result + '<>';
    csLike: Result := Result + ' LIKE ';
  end;
  Result := Result + ':'+fParameterName;
end;

{ TRESTFilterGroup }

function TRESTFilterGroup.AddFilter(Identifier: string; Constraint: TConstraint; Value: string): IRESTFilter;
var
  NewFilter: IRESTFilter;
begin
  NewFilter := TRESTFilter.Create;
  NewFilter.Identifier := Identifier;
  NewFilter.Constraint := Constraint;
  NewFilter.AsString := Value;
  fChildren.Add(NewFilter);
  Result := NewFilter;
end;

function TRESTFilterGroup.AddGroup(GroupOperator: TGroupOperator): IRESTFilterGroup;
var
  NewGroup: IRESTFilterGroup;
begin
  NewGroup := TRESTFilterGroup.Create;
  NewGroup.GroupOperator := GroupOperator;
  fChildren.Add(NewGroup);
  Result := NewGroup;
end;

function TRESTFilterGroup.AddItem(Item: IRESTFilterItem): IRestFilterItem;
begin
  fChildren.Add(Item);
  Result := Item;
end;

function TRESTFilterGroup.AsFilter: IRESTFilter;
begin
  Result := nil;
end;

function TRESTFilterGroup.ASGroup: IRESTFilterGroup;
begin
  Result := (Self as IRESTFilterGroup);
end;

procedure TRESTFilterGroup.AssignParameterNames(var counter: uint32);
var
  idx: uint32;
begin
  if getCount=0 then begin
    exit;
  end;
  for idx := 0 to pred(getCount) do begin
    getItem(idx).AssignParameterNames(Counter);
  end;
end;

constructor TRESTFilterGroup.Create;
begin
  inherited Create;
  fChildren := TList<IRESTFilterItem>.Create;
  fGroupOperator := opAND;
end;

destructor TRESTFilterGroup.Destroy;
begin
  fChildren.Clear;
  fChildren.DisposeOf;
  inherited Destroy;
end;

function TRESTFilterGroup.getCount: uint32;
begin
  Result := fChildren.Count;
end;

function TRESTFilterGroup.getGroupOperator: TGroupOperator;
begin
  Result := fGroupOperator;
end;

function TRESTFilterGroup.getItem(Index: uint32): IRESTFilterItem;
begin
  Result := fChildren[index];
end;

function TRESTFilterGroup.IsFilter: boolean;
begin
  Result := False;
end;

function TRESTFilterGroup.IsGroup: boolean;
begin
  Result := True;
end;

function TRESTFilterGroup.ParamValue(ParamName: string): IRestFilterItem;
var
  idx: uint32;
  V: IRestFilterItem;
begin
  Result := nil;
  if getCount=0 then begin
    exit;
  end;
  for idx := 0 to pred(getCount) do begin
    V := getItem(idx).ParamValue(ParamName);
    if assigned(V) then begin
      Result := V;
      exit;
    end;
  end;
end;

procedure TRESTFilterGroup.setGroupOperator(value: TGroupOperator);
begin
  fGroupOperator := Value;
end;

function TRESTFilterGroup.ToWhereClause: string;
var
  idx: uint32;
begin
  if getGroupOperator=opGroup then begin
    Result := '(';
  end;
  if getCount=0 then begin
    Result := '';
    exit;
  end;
  //- Loop the child groups and filters and output them.
  for idx := 0 to pred(getCount) do begin
    Result := Result + getItem(idx).ToWhereClause;
    if idx<pred(getCount) then begin
      case getGroupOperator of
        opGroup: Result := Result + ' AND ';
        opAND: Result := Result + ' AND ';
        opOR: Result := Result + ' OR ';
      end;
    end;
  end;
  if getGroupOperator=opGroup then begin
    Result := Result + ')';
  end;
end;

end.
