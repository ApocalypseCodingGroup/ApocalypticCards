unit Data.Main;

interface

uses
  System.SysUtils, System.Classes
, datamodel
, cwCollections
, Utils.Messages

;

type
  TMainData = class(TDataModule)
  private
    FCurrentGame: IGameData;
    FCurrentView: TAppView;
    FUserData: IUserData;
    FGameUsers: IList<IUserData>;
    procedure SetCurrentView(const Value: TAppView);
    procedure SetGameUsers(const Value: IList<IUserData>);
  protected
    procedure CurrentViewChanged;
  public
    constructor Create(AOwner: TComponent); override;

    property UserData: IUserData read FUserData write FUserData;
    property CurrentGame: IGameData read FCurrentGame write FCurrentGame;
    property GameUsers: IList<IUserData> read FGameUsers write SetGameUsers;

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
  TCurrentViewChanged.Create(CurrentView).Send(Self);
end;

procedure TMainData.SetCurrentView(const Value: TAppView);
begin
  if FCurrentView = Value then Exit;

  FCurrentView := Value;
  CurrentViewChanged;
end;

procedure TMainData.SetGameUsers(const Value: IList<IUserData>);
begin
  FGameUsers := Value;

  TGameUsersChanged.CreateAndSend(Self);
end;

end.
