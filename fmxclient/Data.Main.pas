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
    FGames: IList<IGameData>;
    FTurnData: ITurnData;
    procedure SetCurrentView(const Value: TAppView);
    procedure SetGameUsers(const Value: IList<IUserData>);
    procedure SetGames(const Value: IList<IGameData>);
    procedure SetTurnData(const Value: ITurnData);
  protected
    procedure CurrentViewChanged;
  public
    constructor Create(AOwner: TComponent); override;

    property UserData: IUserData read FUserData write FUserData;
    property TurnData: ITurnData read FTurnData write SetTurnData;
    property CurrentGame: IGameData read FCurrentGame write FCurrentGame;
    property GameUsers: IList<IUserData> read FGameUsers write SetGameUsers;
    property Games: IList<IGameData> read FGames write SetGames;

    property CurrentView: TAppView read FCurrentView write SetCurrentView;
  end;

var
  MainData: TMainData;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  System.Messaging, Data.Remote
  , CodeSiteLogging
;

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

procedure TMainData.SetGames(const Value: IList<IGameData>);
begin
  FGames := Value;

  TGamesChanged.CreateAndSend(Self);
end;

procedure TMainData.SetGameUsers(const Value: IList<IUserData>);
var
  LUser: IUserData;
  LIndex: Integer;
begin
  FGameUsers := Value;

  TGameUsersChanged.CreateAndSend(Self);

  if Assigned(UserData)
     and Assigned(GameUsers)
     and (CurrentView = TAppView.GreenRoom)
  then
  begin
    // check if my PlayerState changed and update the current view
    for LIndex := 0 to GameUsers.Count-1 do
    begin
      LUser := GameUsers.Items[LIndex];

      if (LUser.UserID = UserData.UserID) // it's me
         and (LUser.PlayerState <> TPlayerState.psInGreenRoom)
      then
      begin
        RemoteData.StopPollingForUsers;
        CodeSite.SendMsg('MainData: Judging or Submitting');
        if LUser.PlayerState = TPlayerState.psJudgeWaitingForSubmit then
          CurrentView := TAppView.Judging
        else if LUser.PlayerState = TPlayerState.psPlayerSubmitting then
          CurrentView := TAppView.Submitting;
      end;
    end;

  end;
end;

procedure TMainData.SetTurnData(const Value: ITurnData);
begin
  CodeSite.SendMsg('MainData: SetTurnData');
  FTurnData := Value;

  if Assigned(FTurnData) then
  begin
    // it would be probably better to refresh userData and check PlayerState here
    if FTurnData.Cards[0].CardID = ''  then
      CurrentView := TAppView.Judging
    else
      CurrentView := TAppView.Submitting;
  end;

  TTurnDataChanged.CreateAndSend(Self);
end;

end.
