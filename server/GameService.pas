unit GameService;

interface

Uses
  Dek
;

Type
  TCardGameWeb = Class(TInterfacedObject,ICardgame)
    strict private
      Function CreateNewSessionKey : String;
      Function JoinSession(Const aSessionID : String) : String;
    private
      fDataBase : IDataBase;
    public
      Constructor Create(Const aDataBase : IDataBase);
  end;

  TCardGameJSON = Class(TInterfacedObject,ICardgame)
    strict private
      Function CreateNewSessionKey : String;
      Function JoinSession(Const aSessionID : String) : String;
    private
      fDataBase : IDataBase;
    public
      Constructor Create(Const aDataBase : IDataBase);
  end;

implementation

Uses
  System.SysUtils
;

{ TCardGame }

constructor TCardGameWeb.Create(const aDataBase: IDataBase);
begin
  inherited Create;

  fDataBase := aDataBase;
end;

function TCardGameWeb.CreateNewSessionKey: String;
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

function TCardGameWeb.JoinSession(const aSessionID: String): String;
var
  lError      : String;
begin
  Result := 'You are not joined into a session';
  try
    // Check if Key is in DB
    Result := 'ass527Shjd';
    // Save me to game stat
    if not(fDataBase.CreateNewGame(Result,lError)) then
      Result := lError;
  except
    On E : Exception do
      begin
        Result := 'EXCEPTION:'+E.Message;
      end;
  end;
end;

{ TCardGameJSON }

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

function TCardGameJSON.JoinSession(const aSessionID: String): String;
begin
  Result := '{ERROR : "Not-Joined"}';
end;

end.
