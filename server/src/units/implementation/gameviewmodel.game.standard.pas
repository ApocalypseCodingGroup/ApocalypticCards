unit gameviewmodel.game.standard;

interface
uses
  gameviewmodel
;

type
  TGame = class(TInterfacedObject,IGame)
  private
    fGameData: IGameData;
  strict private
    function getGameData: IGameData;
  public
    constructor Create( const GameData: IGameData ); reintroduce;
  end;

implementation

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

end.
