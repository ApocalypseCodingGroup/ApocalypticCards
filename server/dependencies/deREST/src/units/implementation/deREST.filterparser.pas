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
unit deREST.filterparser;

interface
uses
  deREST.types;

type
  TRESTFilterParser = class
  private
    fFilterString: string;
    fCursor: uint32;
    fEOFPos: uint32;
  private
    function Peek: char;
    function Poke: char;
    function EOF: boolean;
    function ParseIdentifier( var Identifier: string ): boolean;
    function ParseConstraint(var Constraint: TConstraint): boolean;
    function ParseQuotedString(var Value: string; Terminator: char): boolean;
    function ParseValue(var Value: string): boolean;
    function URLDecode(SourceStr: string): string;
    function ParseGroup(Parent: IRESTFilterGroup): boolean;
    function ParseTerm: IRESTFilterItem;
    function ParseOperator( LeftTerm: IRESTFilterItem = nil ): IRESTFilterItem;

  public
    function Parse( FilterString: string; Filters: IRESTFilterGroup ): boolean;
  end;

implementation
uses
  deREST.restfilter.standard,
  Sysutils;

const
  setAlpha = ['a'..'z','A'..'Z'];
  setDigits = ['0'..'9','.'];
  setIdentifier = ['a'..'z','A'..'Z','0'..'9','_'];

{ TRESTFilterParser }

function TRESTFilterParser.EOF: boolean;
begin
  Result := fCursor > fEOFPos;
end;

function TRESTFilterParser.ParseIdentifier( var Identifier: string ): boolean;
begin
  Result := False;
  // Read identifier
  if not CharInSet(Peek,setAlpha) then begin
    exit;
  end;
  //- Collect identifier.
  Identifier := '';
  while (not EOF) and (CharInSet(Peek,setIdentifier)) do begin
    Identifier := Identifier + Poke;
  end;
  if Trim(Identifier)='' then begin
    exit;
  end;
  Result := True;
end;

function TRESTFilterParser.ParseConstraint( var Constraint: TConstraint ): boolean;
var
  ConstraintStr: string;
begin
  Result := False;
  Constraint := TConstraint.csUnknown;
  if Peek='=' then begin
    ConstraintStr := poke;
  end else begin
    if Peek<>'[' then begin
      exit;
    end;
    poke;
    ConstraintStr := '';
    while (not EOF) and (Peek<>']') do begin
      ConstraintStr := ConstraintStr + Poke;
    end;
    if EOF then begin
      exit;
    end;
    Poke; // remove the ]
    if Peek<>'=' then begin
      exit;
    end;
    Poke; // remove the =
  end;
  //- Determine which constraint this is.
  ConstraintStr := Uppercase(Trim(ConstraintStr));
  if ConstraintStr='=' then begin
    Constraint := TConstraint.csEqual;
  end else if ConstraintStr='<>' then begin
    Constraint := TConstraint.csNotEqual;
  end else if ConstraintStr='<=' then begin
    Constraint := TConstraint.csLessOrEqual;
  end else if ConstraintStr='<' then begin
    Constraint := TConstraint.csLessThan;
  end else if ConstraintStr='>=' then begin
    Constraint := TConstraint.csGreaterOrEqual;
  end else if ConstraintStr='>' then begin
    Constraint := TConstraint.csGreaterThan;
  end else if ConstraintStr='LIKE' then begin
    Constraint := TConstraint.csLike;
  end else begin
    exit;
  end;
  Result := True;
end;

function TRESTFilterParser.ParseQuotedString( var Value: string; Terminator: char ): boolean;
var
  CH: char;
begin
  Result := False;
  while (not EOF) and (Peek<>Terminator) do begin
    if Peek='\' then begin
      CH := Poke;
      if EOF then begin
        Value := Value + CH;
        continue;
      end;
      if Peek=Terminator then begin
        Poke;
        Value := Value + Terminator;
        continue;
      end;
      Value := Value + CH;
    end;
    Value := Value + Poke;
  end;
  if EOF then begin
    exit;
  end;
  Poke;
  Result := True;
end;

function TRESTFilterParser.ParseValue( var Value: string ): boolean;
begin
  Result := False;
  Value := '';
  if EOF then begin
    exit;
  end;
  if Peek='''' then begin
    Poke;
    Result := ParseQuotedString( value, '''' );
    exit;
  end;
  if Peek='"' then begin
    Poke;
    Result := ParseQuotedString( value, '"' );
    exit;
  end;
  if Peek='`' then begin
    Poke;
    Result := ParseQuotedString( value, '`' );
    exit;
  end;
  while (not EOF) and (CharInSet(Peek,setDigits)) do begin
    Value := Value + poke;
  end;
  Result := True;
end;

function TRESTFilterParser.URLDecode( SourceStr: string ): string;
var
  Cursor: uint32;
  EOFPos: uint32;
  Hex: string;
  ByteArray: array of uint8;
begin
{$ifdef nextgen}
  Cursor := 0;
  EOFPos := pred(Length(SourceStr));
{$else}
  Cursor := 1;
  EOFPos :=  Length(SourceStr);
{$endif}
  Result := '';
  while Cursor<=EOFPos do begin
    if SourceStr[Cursor]='%' then begin
      SetLength(ByteArray,0);
      while SourceStr[Cursor]='%' do begin
        inc(Cursor);
        Hex := '$';
        Hex := Hex + SourceStr[Cursor];
        inc(Cursor);
        Hex := Hex + SourceStr[Cursor];
        inc(Cursor);
        SetLength(ByteArray, succ(Length(ByteArray)));
        ByteArray[pred(Length(ByteArray))] := StrToInt(Hex);
      end;
      Result := Result + UTF8ToString(RawByteString(ByteArray));
    end else begin
      Result := Result + SourceStr[Cursor];
      inc(Cursor);
    end;
  end;
end;

function TRESTFilterParser.ParseTerm: IRESTFilterItem;
var
  Identifier: string;
  Constraint: TConstraint;
  Value: string;
begin
  Result := nil;
  if Peek='(' then begin
    poke;
    Result := TRESTFilterGroup.Create;
    Result.AsGroup.GroupOperator := TGroupOperator.opGroup;
    if not ParseGroup( Result.AsGroup ) then begin
      Result := nil;
      exit;
    end;
    if Peek<>')' then begin
      Result := nil;
      exit;
    end;
    poke;
    exit;
  end;
  //- Get Identifier.
  if not ParseIdentifier(Identifier) then begin
    exit;
  end;
  // Collect Constraint
  if not ParseConstraint(Constraint) then begin
    exit;
  end;
  // collect the value.
  if not ParseValue( Value ) then begin
    exit;
  end;
  Result := TRESTFilter.Create;
  Result.AsFilter.Identifier := Identifier;
  Result.AsFilter.Constraint := Constraint;
  Result.AsFilter.AsString := Value;
end;

function TRESTFilterParser.ParseOperator( LeftTerm: IRESTFilterItem = nil ): IRESTFilterItem;
var
  Term: IRESTFilterItem;
  Group: IRESTFilterItem;
begin
  Result := nil;
  if EOF then begin
    exit;
  end;
  if Peek=')' then begin
    exit;
  end;
  //- Make sure we have a left side term.
  if assigned(LeftTerm) then begin
    Term := LeftTerm;
  end else begin
    //- Parse the left term.
    Term := ParseTerm;
    if not assigned(Term) then begin
      exit;
    end;
  end;
  //- If there is an operator, we're going to create a group and return it.
  if Peek='&' then begin
    poke;
    Group := TRESTFilterGroup.Create;
    Group.AsGroup.GroupOperator := TGroupOperator.opAND;
    Group.AsGroup.AddItem(Term);
    Term := ParseTerm;
    if not assigned(Term) then begin
      exit;
    end;
    Group.AsGroup.AddItem(Term);
    Result := Group;
  end else if Peek='|' then begin
    poke;
    Group := TRESTFilterGroup.Create;
    Group.AsGroup.GroupOperator := TGroupOperator.opOR;
    Group.AsGroup.AddItem(Term);
    Term := ParseTerm;
    if not assigned(Term) then begin
      exit;
    end;
    Group.AsGroup.AddItem(Term);
    Result := Group;
  end else begin
    Result := Term;
  end;
end;

function TRESTFilterParser.ParseGroup(Parent: IRESTFilterGroup): boolean;
var
  anOperator: IRestFilterItem;
  NewOperator: IRESTFilterItem;
  KeepGoing: boolean;
begin
  Result := False;
  //- If we're at EOF, we're done.
  if EOF then begin
    Result := True;
    exit;
  end;
  //- Parse the first operator (either a single term, or an operator group).
  anOperator := ParseOperator;
  if not assigned(anOperator) then begin
    exit;
  end;
  if EOF or (Peek=')') then begin
    Parent.AddItem(anOperator);
    Result := True;
    exit;
  end;
  //- If there is no operator here, and we are not EOF, something is wrong.
  if not ((Peek='&') or (Peek='|')) then begin
    exit;
  end;
  //- Repeatedly parse new opperators until there are new new operators.
  KeepGoing := True;
  NewOperator := anOperator;
  repeat
    NewOperator := ParseOperator(NewOperator);
    if not assigned(NewOperator) then begin
     NewOperator := anOperator;
     KeepGoing := False;
    end else begin
     anOperator := NewOperator;
    end;
  until not KeepGoing;
  Parent.AddItem(NewOperator);
  Result := True;
end;

function TRESTFilterParser.Parse(FilterString: string; Filters: IRESTFilterGroup): boolean;
begin
  //- Initialize string cursor and EOFPos
  fFilterString := URLDecode(FilterString);
  {$ifdef nextgen}
  fCursor := 0;
  fEOFPos := pred(Length(fFilterString));
  {$else}
  fCursor := 1;
  fEOFPos := Length(fFilterString);
  {$endif}
  //- Parse the group of filters.
  Result := ParseGroup( Filters );
end;

function TRESTFilterParser.Peek: char;
begin
  Result := fFilterString[fCursor];
end;

function TRESTFilterParser.Poke: char;
begin
  Result := Peek;
  inc(fCursor);
end;

end.
