unit datamodel.userdata.standard;

interface
uses
  datamodel
, datamodel.gamedataobject.custom
;

type
  TUserData = class( TGameDataObject, IUserData )
  private
    fDeleted: boolean;
    fUserID: string;
    fName: string;
    fGameID: string;
    fIsCurrentUser: boolean;
    fScore: Integer;
    fPlayerState: TPlayerState;
  strict private //- IUserData -//
    function getIsCurrentUser: boolean;
    function getUserID: string;
    function getName: string;
    function getGameID: string;
    function getDeleted: boolean;
    function getPlayerState: TPlayerState;
    function getScore: integer;

    procedure setIsCurrentUser( const value: boolean );
    procedure setUserID( const value: string );
    procedure setName( const value: string );
    procedure setGameID( const value: string );
    procedure setDeleted( const value: boolean );
    procedure setPlayerState( const value: TPlayerState );
    procedure setScore( const value: integer );
  end;

implementation

{ TUserData }

function TUserData.getDeleted: boolean;
begin
  Result := fDeleted;
end;

function TUserData.getGameID: string;
begin
  Result := fGameID;
end;

function TUserData.getIsCurrentUser: boolean;
begin
  Result := fIsCurrentUser;
end;

function TUserData.getName: string;
begin
  Result := fName;
end;

function TUserData.getPlayerState: TPlayerState;
begin
  Result := fPlayerState;
end;

function TUserData.getScore: integer;
begin
  Result := fScore;
end;

function TUserData.getUserID: string;
begin
  Result := fUserID;
end;

procedure TUserData.setDeleted(const value: boolean);
begin
  fDeleted := Value;
end;

procedure TUserData.setGameID(const value: string);
begin
  fGameID := Value;
end;

procedure TUserData.setIsCurrentUser(const value: boolean);
begin
  fIsCurrentUser := value;
end;

procedure TUserData.setName(const value: string);
begin
  fName := Value;
end;

procedure TUserData.setPlayerState(const value: TPlayerState);
begin
  fPlayerState := value;
end;

procedure TUserData.setScore(const value: integer);
begin
  fScore := value;
end;

procedure TUserData.setUserID(const value: string);
begin
  fUserID := Value;
end;

end.
