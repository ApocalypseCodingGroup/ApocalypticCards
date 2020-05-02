unit ViewModel.ViewModel.Standard;

interface
uses
  cwCollections
, ViewModel
, DataModel
;

type
  TViewModel = class( TInterfacedObject, IViewModel )
  private
    fDataModel: IDataModel;
  strict private
    procedure CleanUp;
    procedure UpdateUserPing( const UserID: string );
    function getPublicGames: string;
    function CreateGame( const json: string ): string;
    function JoinGame( const json: string ): string;
    function getUsers( const AuthToken: string ): string;
    function setGameState( AuthToken: string; const json: string ): string;
  private
    function ListToJSON( const value: IList<IGameDataObject> ): string;
    procedure ValidateUserCount(const GameData: IGameData);
  public
    constructor Create( DataModel: IDataModel ); reintroduce;
  end;

implementation
uses
  StrUtils
, SysUtils
, cwCollections.Standard
, DataModel.Standard
, System.JSON
, REST.JSON
;

{ TViewModel }

procedure TViewModel.CleanUp;
begin
  fDataModel.CleanUp;
end;

constructor TViewModel.Create(DataModel: IDataModel);
begin
  inherited Create;
  fDataModel := DataModel;
end;

procedure TViewModel.ValidateUserCount( const GameData: IGameData );
begin
  if GameData.MaxUser<GameData.MinUser then begin
    GameData.MinUser := GameData.MaxUser;
  end;
  if GameData.MinUser>GameData.MaxUser then begin
    GameData.MaxUser := GameData.MinUser;
  end;
  if GameData.MinUser<cMinUserCount then begin
    raise
      Exception.Create('Minimum users required is '+IntToStr(cMinUserCount)+' or greater.');
  end;
  if GameData.MaxUser>cMaxUserCount then begin
    raise
      Exception.Create('The maximum number of users permitted in a game is '+IntToStr(cMaxUserCount)+'.');
  end;
end;

function TViewModel.CreateGame(const json: string): string;
var
  NewGame: IGameData;
  NewSessionID: TGUID;
  idx: nativeuint;
begin
  NewGame := TJSON.JsonToObject<TGameData>(json);
  CreateGUID(NewSessionID);
  NewGame.SessionID := GUIDToString(NewSessionID);
  if NewGame.SessionPassword=cGeneratePasswordFlag then begin
    NewGame.SessionPassword := cNullString;
    for idx := 0 to pred(cPasswordLen) do begin
      NewGame.SessionPassword := NewGame.SessionPassword + chr( cStartPasswordChar+Random(cPasswordCharRange) );
    end;
  end;
  NewGame.GameState := gsGreenRoom;
  //- Load and validate min/max user
  ValidateUserCount(NewGame);
  //- Return game
  fDataModel.CreateGame(NewGame);
  Result := NewGame.ToJSON;
end;

function TViewModel.getPublicGames: string;
var
  PublicGames: IList<IGameData>;
begin
  PublicGames := fDataModel.getGames;
  Result := ListToJSON(PublicGames as IList<IGameDataObject>);
end;

function TViewModel.getUsers(const AuthToken: string): string;
var
  UserList: IList<IUserData>;
begin
  UserList := fDataModel.getUsers( AuthToken );
  Result := ListToJSON(UserList as IList<IGameDataObject>);
end;

function TViewModel.JoinGame(const json: string): string;
var
  NewUser: IUserData;
  NewUserID: TGUID;
  SelectedGame: IGameData;
begin
  NewUser := TJSON.JsonToObject<TUserData>(json);
  CreateGUID(NewUserID);
  NewUser.UserID := GuidToString(NewUserID);
  //- Look up the requested game
  SelectedGame := fDataModel.FindGameByID(NewUser.GameID);
  if not assigned(SelectedGame) then begin
    raise
      Exception.Create('Requested game not found.');
  end;
  fDataModel.CreateUser( NewUser );
  Result := NewUser.ToJSON;
end;

function TViewModel.ListToJSON(const value: IList<IGameDataObject>): string;
var
  _Result: string;
begin
  Result := '[]';
  _Result := '';
  if Value.Count=0 then begin
    exit;
  end;
  try
    _Result := '[';
    Value.ForEach(
      procedure( const item: IGameDataObject )
      begin
        _Result := _Result + Item.ToJSON;
        _Result := _Result + ',';
      end
    );
    _Result := LeftStr(_Result,pred(Length(_Result)));
    _Result := _Result + ']';
  finally
    Result := _Result;
  end;
end;

function TViewModel.setGameState(AuthToken: string; const json: string): string;
var
  GameData: IGameData;
begin
  GameData := TJSON.JsonToObject<TGameData>(json);
  Result := fDataModel.setGameState(AuthToken,GameData);
end;

procedure TViewModel.UpdateUserPing(const UserID: string);
begin
  fDataModel.UpdateUserPing(UserID);
end;

end.
