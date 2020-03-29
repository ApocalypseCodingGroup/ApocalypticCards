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
unit deREST.restresponse.standard;

interface
uses
  deREST.types;

type
  TRESTResponse = class( TInterfacedObject, IRESTResponse )
  private
    fComplete: boolean;
    fResponseCode: THTTPResponseCode;
    fResponseMessage: string;
    fResponseArray: IRESTArray;
  private //- IRESTResponse -//
    function getComplete: boolean;
    procedure setComplete( value: boolean );
    function getResponseArray: IRESTArray;
    function getResponseCode: THTTPResponseCode;
    procedure setResponseCode( Code: THTTPResponseCode );
    function getResponseMessage: string;
    procedure setResponseMessage( value: string );
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  deREST.restarray.standard;

{ TRESTResponse }

constructor TRESTResponse.Create;
begin
  inherited Create;
  fResponseArray := TRestArray.Create;
  fComplete := False;
end;

destructor TRESTResponse.Destroy;
begin
  fResponseArray := nil;
  inherited Destroy;
end;

function TRESTResponse.getComplete: boolean;
begin
  Result := fComplete;
end;

function TRESTResponse.getResponseCode: THTTPResponseCode;
begin
  Result := fResponseCode;
end;

function TRESTResponse.getResponseArray: IRestArray;
begin
  Result := fResponseArray;
end;

function TRESTResponse.getResponseMessage: string;
begin
  Result := fResponseMessage;
end;

procedure TRESTResponse.setComplete(value: boolean);
begin
  fComplete := Value;
end;

procedure TRESTResponse.setResponseCode(Code: THTTPResponseCode);
begin
  fResponseCode := Code;
end;

procedure TRESTResponse.setResponseMessage(value: string);
begin
  fResponseMessage := Value;
end;

end.
