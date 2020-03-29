unit Requests;

interface
uses
  Dek
, Web.HTTPApp
;

type

  THandleRequest = reference to procedure( Response: TWebResponse; var Handled: Boolean; const aWebCall: ICardgame );

  TGameRequest = class
  public
    class function PrepareResponse( var Response: TWebResponse ): boolean; static;
    class procedure PrepareException( var Response: TWebResponse; const Message: string ); static;
    class procedure HandleRequest(Request: TWebRequest; Response: TWebResponse; var Handled: Boolean; const RequestHandler: THandleRequest ); static;
  end;

implementation
uses
  SysUtils
, Classes
, GameService
, MariaDB
;

{ TGameRequest }

class procedure TGameRequest.HandleRequest(Request: TWebRequest; Response: TWebResponse; var Handled: Boolean; const RequestHandler: THandleRequest);
var
  lWebCall : ICardgame;
  Str: string;
begin
  PrepareResponse(Response);
  lWebCall := TCardGameJSON.Create(TMariaDB.Construct);
  try
    RequestHandler(Response,Handled,lWebCall);
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
