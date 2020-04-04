unit gameviewmodel.gameview.standard;

interface
uses
  gameviewmodel;

type
  TGameView = class( TInterfacedObject, IGameView )
  private
    fLangID: string;
    fMaxUser: integer;
    fMinUser: integer;
    fSessionID: string;
    fSessionName: string;
  strict private
    function getSessionID: string;
    function getSessionName: string;
    function getLangID: string;
    function getMinUser: integer;
    function getMaxUser: integer;
    procedure setSessionID( const value: string );
    procedure setSessionName( const value: string );
    procedure setLangID( const value: string );
    procedure setMinUser( const value: integer );
    procedure setMaxUser( const value: integer );
  end;

implementation

{ TGameView }

function TGameView.getLangID: string;
begin
  Result := fLangID;
end;

function TGameView.getMaxUser: integer;
begin
  Result := fMaxUser;
end;

function TGameView.getMinUser: integer;
begin
  Result := fMinUser;
end;

function TGameView.getSessionID: string;
begin
  Result :=fSessionId;
end;

function TGameView.getSessionName: string;
begin
  Result := fSessionName;
end;

procedure TGameView.setLangID(const value: string);
begin
  fLangID := Value;
end;

procedure TGameView.setMaxUser(const value: integer);
begin
  fMaxUser := Value;
end;

procedure TGameView.setMinUser(const value: integer);
begin
  fMinUser := Value;
end;

procedure TGameView.setSessionID(const value: string);
begin
  fSessionID := Value;
end;

procedure TGameView.setSessionName(const value: string);
begin
  fSessionName := Value;
end;

end.
