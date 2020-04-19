unit Data.Main;

interface

uses
  System.SysUtils, System.Classes
, datamodel
, Utils.Messages
;

type
  TMainData = class(TDataModule)
  private
    FCurrentGame: IGameData;
    FCurrentView: TAppView;
    procedure SetCurrentView(const Value: TAppView);
  protected
    procedure CurrentViewChanged;
  public
    constructor Create(AOwner: TComponent); override;

    property CurrentGame: IGameData read FCurrentGame write FCurrentGame;
    property CurrentView: TAppView read FCurrentView write SetCurrentView;
  end;

var
  MainData: TMainData;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses System.Messaging;

{ TMainData }

constructor TMainData.Create(AOwner: TComponent);
begin
  inherited;
  FCurrentView := Init;
end;

procedure TMainData.CurrentViewChanged;
begin
  TMessageManager.DefaultManager.SendMessage(Self
  , TCurrentViewChanged.Create(CurrentView)
  );
end;

procedure TMainData.SetCurrentView(const Value: TAppView);
begin
  if FCurrentView = Value then Exit;

  FCurrentView := Value;
  CurrentViewChanged;
end;

end.
