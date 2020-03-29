unit GameService;

interface

Uses
  Dek
;

Type
  TCardGameJSON = Class(TInterfacedObject,ICardgame)
    strict private
      Function CreateNewSessionKey : String;
      Function JoinSession(Const aSessionID,aUserName : String) : String;
      function Read_Games( out Response: string ): boolean;
      function Create_Games(out Response: string; const RequestJSON: string ): boolean;
    private
      fDataBase : IDataBase;
    public
      Constructor Create(Const aDataBase : IDataBase);
  end;

implementation
Uses
  System.SysUtils
, System.JSON
, Rest.JSON
;

constructor TCardGameJSON.Create(const aDataBase: IDataBase);
begin
  inherited Create;

  fDataBase := aDataBase;
end;

function TCardGameJSON.CreateNewSessionKey: String;
var
  lSessionID,
  lError      : String;
begin
  Result := '{ERROR : "BAD-Session-ID"}';
  try
    // Create Key
    lSessionID := 'ass527Shjd';
    // Save me to game stat
    if fDataBase.CreateNewGame(Result,lError)
     then Result := '{ID : "'+lSessionID+'"}'
     else Result := '{ERROR : "'+lError+'"}';
  except
    On E : Exception do
      begin
        Result := '{ERROR : "EXCEPTION:'+E.Message+'"}';
      end;
  end;
end;

function TCardGameJSON.Create_Games(out Response: string; const RequestJSON: string): boolean;
var
  o: TJSONObject;
  GO: TGameObject;
begin
  Result := False;
  GO := TJSON.JSONToObject<TGameObject>( RequestJSON );
  Response := GO.SessionName;
  Result := True;
end;

Function TCardGameJSON.JoinSession(Const aSessionID,aUserName : String) : String;
begin
  Result := '{ERROR : "Not-Joined"}';
end;

function TCardGameJSON.Read_Games(out Response: string): boolean;
begin
  Result := False;
  if not fDataBase.ReadGames(Response) then begin
    exit;
  end;
  Result := True;
end;

end.
