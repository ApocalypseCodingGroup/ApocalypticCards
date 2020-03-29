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
unit deREST.pathinfo;

interface

type
  TPathInfo = record
    Endpoint: string;
    Item: string;
    Filters: string;
    function ParsePathInfo( SourceStr: string ): TPathInfo;
  end;

implementation

{ TPathInfo }

function TPathInfo.ParsePathInfo(SourceStr: string): TPathInfo;
type
  TParsePart = ( ppEndpoint, ppItem, ppFilters );
var
  idx: uint32;
  Part: TParsePart;
begin
  Result.Endpoint := '';
  Result.Item := '';
  Result.Filters := '';
  Part := ppEndpoint;
  //- Ensure we have at least a category.
  if Length(SourceStr)<2 then begin
    exit;
  end;
  //- Start 1 character in, to avoid the first forward slash.
  {$ifdef nextgen}
  for idx := 1 to length(SourceStr) do begin
  {$else}
  for idx := 2 to Length(SourceStr) do begin
  {$endif}
    case Part of
      ppEndpoint: begin
        if SourceStr[idx]='/' then begin
          Part := ppItem;
          continue;
        end else if SourceStr[idx]='?' then begin
          Part := ppFilters;
          continue;
        end else begin
          Result.Endpoint := Result.Endpoint + SourceStr[idx];
        end;
      end;
      ppItem: begin
        if SourceStr[idx]='?' then begin
          Part := ppFilters;
          continue;
        end else begin
          Result.Item := Result.Item + SourceStr[idx];
        end;
      end;
      ppFilters: begin
        Result.Filters := Result.Filters + SourceStr[idx];
      end;
    end;
  end;
end;

end.
