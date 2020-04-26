unit Requests;

interface
uses
  Web.HTTPApp
, ViewModel
;

type
  THandleRequest = reference to procedure( const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel );

  TGameRequest = class
  private
    class function ExtractAuthToken(Request: TWebRequest): string; static;
  public
    class function PrepareResponse( var Response: TWebResponse ): boolean; static;
    class procedure PrepareException( var Response: TWebResponse; const Message: string ); static;
    class procedure HandleRequest( Request: TWebRequest; Response: TWebResponse; var Handled: Boolean; const _Create, _Read, _Update, _Delete: THandleRequest ); static;
  end;

implementation
uses
  SysUtils
, Classes
, NetEncoding
, ViewModel.Standard
;

{ TGameRequest }
class function TGameRequest.ExtractAuthToken( Request: TWebRequest ): string;
var
  AuthToken: string;
begin
  AuthToken := TNetEncoding.URL.Decode(Request.GetFieldByName('authentication-string'));
  Result := AuthToken;
end;

class procedure TGameRequest.HandleRequest( Request: TWebRequest; Response: TWebResponse; var Handled: Boolean; const _Create, _Read, _Update, _Delete: THandleRequest );
var
  Str: string;
  ViewModel: IViewModel;
  AuthToken: string;
begin
  PrepareResponse(Response);
  AuthToken := ExtractAuthToken( Request );

  ViewModel := TViewModel.Create;
  try
    try
      ViewModel.UpdateUserPing(AuthToken);

      if not assigned(ViewModel) then begin
        raise
          Exception.Create('Game failed to initialize.');
      end;

      case Request.MethodType of

        mtGet: begin
          _Read(AuthToken, Response,Handled,ViewModel);
        end; // read

        mtPut: begin
          _Update(AuthToken, Response,Handled,ViewModel);
        end; // update

        mtPost: begin
          _Create(AuthToken, Response,Handled,ViewModel);
        end;
        mtDelete: begin
          _Delete(AuthToken, Response,Handled,ViewModel);
        end; // take a guess
      end;
    finally
      ViewModel.CleanUp;
    end;
  except
    on E: Exception do begin
      PrepareException( Response, E.Message );
    end;
  end;
  Response.SendResponse;
end;


class procedure TGameRequest.PrepareException(var Response: TWebResponse; const Message: string);
begin
  Response.ContentType := 'application/text';
  Response.ReasonString := Message;
  Response.Content := Message;
  Response.StatusCode := 500;
end;

class function TGameRequest.PrepareResponse( var Response: TWebResponse ): boolean;
begin
  Response.StatusCode := 200;
  Response.ContentType := 'application/json';
end;

end.
