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
unit deREST.authenticator;

interface
uses
  HttpApp,
  classes;

type
  ///  <summary>
  ///    Enumeration representing the CRUD operation to be authenticated by
  ///    an authenticator component.
  ///  </summary>
  TCRUDMethod = ( cmCreate, cmRead, cmUpdate, cmDelete );

  ///  <summary>
  ///    Callback for the event fired when authentication is requested.
  ///  </summary>
  TOnRequestAuthentication = function ( Operation: TCRUDMethod; Endpoint: string; Request: TWebRequest ): boolean of object;

  /// <exclude/>
  /// Used internally to forward authentication requests to an authenticator.
  IRequestAuthentication = interface
    ['{C7745404-7CA4-4081-B6AD-6547B2A956F4}']
    function Authenticate( Operation: TCRUDMethod; Endpoint: string; Request: TWebRequest ): boolean;
  end;

  ///  <summary>
  ///    Component for handling the authentication of a request.
  ///  </summary>
  TRESTAuthenticator = class(TComponent,IRequestAuthentication)
  private
    fOnRequestAuthentication: TOnRequestAuthentication;
  protected
    function Authenticate( Operation: TCRUDMethod; Endpoint: string; Request: TWebRequest ): boolean;
  public
    constructor Create( aOwner: TComponent ); override;
  published
    property OnRequestAuthentication: TOnRequestAuthentication read fOnRequestAuthentication write fOnRequestAuthentication;
  end;

implementation

{ TRESTAuthenticator }

function TRESTAuthenticator.Authenticate(Operation: TCRUDMethod; Endpoint: string; Request: TWebRequest): boolean;
begin
  Result := False;
  if assigned(fOnRequestAuthentication) then begin
    Result := fOnRequestAuthentication( Operation, Endpoint, Request );
  end;
end;

constructor TRESTAuthenticator.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  fOnRequestAuthentication := nil;
end;

end.
