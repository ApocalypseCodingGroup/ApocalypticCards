unit datamodel.gamedata.standard;

interface
uses
  DataModel
, DataModel.GameDataObject.Custom
;

type
  TGameData = class(  TGameDataObject, IGameData )
  private
    fSessionPassword: string;
    fSessionName: string;
    fLangID: string;
    fMinUser: integer;
    fMaxUser: integer;
    fSessionID: string;
    fRunning: boolean;
    fUserCount: integer;
  strict private
    function getUserCount: integer;
    function getSessionID: string;
    function getSessionName: string;
    function getLangID: string;
    function getMinUser: integer;
    function getMaxUser: integer;
    function getRunning: boolean;
    function getPassword: string;

    procedure setSessionID( const value: string );
    procedure setSessionName( const value: string );
    procedure setLangID( const value: string );
    procedure setMinUser( const value: integer );
    procedure setMaxUser( const value: integer );
    procedure setRunning( const value: boolean );
    procedure setPassword( const value: string );
    procedure setUserCount( const value: integer );
  public
  end;

implementation
uses
  SysUtils
;

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

function TGameData.getPassword: string;
begin
  Result := fSessionPassword;
end;

function TGameData.getRunning: boolean;
begin
  Result := fRunning;
end;

function TGameData.getSessionID: string;
begin
  Result := fSessionID;
end;

function TGameData.getSessionName: string;
begin
  Result := fSessionName;
end;

function TGameData.getUserCount: integer;
begin
  Result := fUserCount;
end;

procedure TGameData.setLangID(const value: string);
begin
  fLangID := value;
end;

procedure TGameData.setMaxUser(const value: integer);
begin
  fMaxUser := value;
end;

procedure TGameData.setMinUser(const value: integer);
begin
  fMinUser := value;
end;

procedure TGameData.setPassword(const value: string);
begin
  fSessionPassword := Value;
end;

procedure TGameData.setRunning(const value: boolean);
begin
  fRunning := Value;
end;

procedure TGameData.setSessionID(const value: string);
begin
  fSessionID := value;
end;

procedure TGameData.setSessionName(const value: string);
begin
  fSessionName := value;
end;

procedure TGameData.setUserCount(const value: integer);
begin
  fUserCount := Value;
end;

end.
