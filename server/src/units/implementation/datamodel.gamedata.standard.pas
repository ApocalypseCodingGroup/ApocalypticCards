unit datamodel.gamedata.standard;

interface
uses
  DataModel
, DataModel.GameDataObject.Custom
;

type
  TGameData = class(  TGameDataObject, IGameData )
  private
    fSessionName: string;
    fLangID: string;
    fMinUser: integer;
    fMaxUser: integer;
    fSessionID: string;
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
  public
    property SessionID: string read fSessionID write fSessionID;
    property SessionName: string read fSessionName write fSessionName;
    property LangID: string read fLangID write fLangID;
    property MinUser: integer read fMinUser write fMinUser;
    property MaxUser: integer read fMaxUser write fMaxUser;
  end;

implementation

{ TGameData }

function TGameData.getLangID: string;
begin
  Result := fLangID;
end;

function TGameData.getMaxUser: integer;
begin
  Result := fMaxUser;
end;

function TGameData.getMinUser: integer;
begin
  Result := fMinUser;
end;

function TGameData.getSessionID: string;
begin
  Result := fSessionID;
end;

function TGameData.getSessionName: string;
begin
  Result := fSessionName;
end;

procedure TGameData.setLangID(const value: string);
begin
  fSessionID := value;
end;

procedure TGameData.setMaxUser(const value: integer);
begin
  fMaxUser := value;
end;

procedure TGameData.setMinUser(const value: integer);
begin
  fMinUser := value;
end;

procedure TGameData.setSessionID(const value: string);
begin
  fSessionID := value;
end;

procedure TGameData.setSessionName(const value: string);
begin
  fSessionName := value;
end;

end.
