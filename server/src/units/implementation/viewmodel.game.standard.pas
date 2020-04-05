unit ViewModel.Game.Standard;

interface
uses
  ViewModel
, DataModel
, ViewModel.GameObject.Custom
;

type
  TGame = class(TGameObject,IGame,IGameObject)
  private
    fGameData: IGameData;
  strict private
    function getGameData: IGameData;
  protected
    function ToJSON: string; override;

  public
    constructor Create( const GameData: IGameData ); reintroduce;
  end;

implementation
uses
  DataModel.GameData.Standard
, System.JSON
, REST.JSON
;

{ TGame }

constructor TGame.Create(const GameData: IGameData);
begin
  inherited Create;
  fGameData := GameData;
end;

function TGame.getGameData: IGameData;
begin
  Result := fGameData;
end;

function TGame.ToJSON: string;
begin
  Result := TJSON.ObjectToJsonString(fGameData.AsObject);
end;

end.
