unit Data.Main;

interface

uses
  System.SysUtils, System.Classes
, datamodel
;

type
  TMainData = class(TDataModule)
  private
    FCurrentGame: IGameData;
  public

    property CurrentGame: IGameData read FCurrentGame write FCurrentGame;
  end;

var
  MainData: TMainData;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
