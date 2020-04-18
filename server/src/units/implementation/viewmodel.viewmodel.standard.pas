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
    function getPublicGames: string;
    function CreateGame( const json: string ): string;
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
, DataModel.GameData.Standard
, System.JSON
, REST.JSON
;

{ TViewModel }

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
  NewGameData: IGameData;
  NewSessionID: TGUID;
  idx: nativeuint;
begin
  NewGameData := TJSON.JsonToObject<TGameData>(json);
  CreateGUID(NewSessionID);
  NewGameData.SessionID := GUIDToString(NewSessionID);
  if NewGameData.SessionPassword=cGeneratePasswordFlag then begin
    NewGameData.SessionPassword := cNullString;
    for idx := 0 to pred(cPasswordLen) do begin
      NewGameData.SessionPassword := NewGameData.SessionPassword + chr( cStartPasswordChar+Random(cPasswordCharRange) );
    end;
  end;
  NewGameData.Running := False;
  //- Load and validate min/max user
  ValidateUserCount(NewGameData);
  //- Return game
  fDataModel.CreateGame(NewGameData);
  Result := NewGameData.ToJSON;
end;

function TViewModel.getPublicGames: string;
var
  PublicGames: IList<IGameData>;
begin
  PublicGames := fDataModel.getGames;
  Result := ListToJSON(PublicGames as IList<IGameDataObject>);
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

end.
