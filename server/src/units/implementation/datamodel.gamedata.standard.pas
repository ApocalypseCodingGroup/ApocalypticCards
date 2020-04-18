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
  strict private
    function getSessionID: string;
    function getSessionName: string;
    function getLangID: string;
    function getMinUser: integer;
    function getMaxUser: integer;
    function getRunning: boolean;
    procedure setSessionID( const value: string );
    procedure setSessionName( const value: string );
    procedure setLangID( const value: string );
    procedure setMinUser( const value: integer );
    procedure setMaxUser( const value: integer );
    procedure setRunning( const value: boolean );
  public
    property SessionPassword: string read fSessionPassword;
    property SessionID: string       read fSessionID    write fSessionID;
    property SessionName: string     read fSessionName write fSessionName;
    property LangID: string          read fLangID      write fLangID;
    property MinUser: integer        read fMinUser     write fMinUser;
    property MaxUser: integer        read fMaxUser     write fMaxUser;
  public
    constructor Create; reintroduce; overload;
    constructor Create( const SessionName: string; const LangID: string; const IsPrivate: boolean ); overload;
  end;

implementation
uses
  SysUtils
;
const
  cPasswordLen = 9;

{ TGameData }

constructor TGameData.Create(const SessionName, LangID: string; const IsPrivate: boolean);
var
  idx: nativeuint;
  aGUID: TGUID;
begin
  Create;
  CreateGUID(aGUID);
  fSessionID := GuidToString( aGUID );
  fSessionName := SessionName;
  fLangID := LangId;
  fRunning := False;
  fSessionPassword := '';
  if IsPrivate then begin
    for idx := 0 to cPasswordLen do begin
      fSessionPassword := fSessionPassword + (Chr(Random(42)+60));
    end;
  end;
end;

constructor TGameData.Create;
begin
  inherited Create;
  fMinUser := 2;
end;

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

end.
