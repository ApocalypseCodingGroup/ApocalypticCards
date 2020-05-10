unit Game.Model;

interface

Uses
  Game.Interfaces
;

type
  TGameDataObject = class( TInterfacedObject, IGameDataObject )
    strict private
      function AsObject: TObject;
      function ToJSON: string;
  end;

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

  TGameData = class(  TGameDataObject, IGameData )
  private
    fCurrentQuestion: string;
    fSessionPassword: string;
    fSessionName: string;
    fLangID: string;
    fMinUser: integer;
    fMaxUser: integer;
    fSessionID: string;
    fGameState: TGameState;
    fUserCount: integer;
  strict private
    function getUserCount: integer;
    function getSessionID: string;
    function getSessionName: string;
    function getLangID: string;
    function getMinUser: integer;
    function getMaxUser: integer;
    function getGameState: TGameState;
    function getPassword: string;
    function getCurrentQuestion: string;

    procedure setSessionID( const value: string );
    procedure setSessionName( const value: string );
    procedure setLangID( const value: string );
    procedure setMinUser( const value: integer );
    procedure setMaxUser( const value: integer );
    procedure setGameState( const value: TGameState );
    procedure setPassword( const value: string );
    procedure setUserCount( const value: integer );
    procedure setCurrentQuestion( const value: string );
  end;



implementation

Uses
  REST.JSON
;

function TGameDataObject.AsObject: TObject;
begin
  Result := Self;
end;

function TGameDataObject.ToJSON: string;
begin
  Result := TJSON.ObjectToJsonString( Self.AsObject );
end;

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

function TGameData.getCurrentQuestion: string;
begin
  Result := fCurrentQuestion;
end;

function TGameData.getGameState: TGameState;
begin
  Result := fGameState;
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

procedure TGameData.setCurrentQuestion(const value: string);
begin
  fCurrentQuestion := value;
end;

procedure TGameData.setGameState(const value: TGameState);
begin
  fGameState := Value;
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
