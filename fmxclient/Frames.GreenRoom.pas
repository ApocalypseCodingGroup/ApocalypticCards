unit Frames.GreenRoom;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FrameStand, SubjectStand,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  System.Actions, FMX.ActnList, FMX.ListView;

type
  TGreenRoomFrame = class(TFrame)
    WaitLayout: TLayout;
    WaitMessageLabel: TLabel;
    CodeOrHostLayout: TLayout;
    CodeOrHostLabel: TLabel;
    UsersListView: TListView;
    Layout1: TLayout;
    StartGameButton: TButton;
    ActionList1: TActionList;
    StartGameAction: TAction;
    LastCheckLabel: TLabel;
    procedure StartGameActionUpdate(Sender: TObject);
  private
  protected
    procedure RenderUsers;
  public
    [BeforeShow]
    procedure FrameOnShow;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.fmx}

uses
  System.Messaging
, datamodel
, Data.Main, Data.Remote, Utils.Messages;

{ TGreenRoomFrame }

procedure TGreenRoomFrame.AfterConstruction;
begin
  inherited;
  TGameUsersChanged.Subscribe(
    procedure (const Sender: TObject; const M: TMessage)
    begin
      RenderUsers;

      LastCheckLabel.Text := TimeToStr(Now);
    end
  );
end;

procedure TGreenRoomFrame.FrameOnShow;
var
  LPassword: string;
begin
  if MainData.UserData.IsCurrentUser then
  begin
    LPassword := MainData.CurrentGame.SessionPassword;
    if LPassword <> '' then
      CodeOrHostLabel.Text := 'Give out your game code: ' + QuotedStr(LPassword)
    else
      CodeOrHostLabel.Visible := False;
  end
  else
  begin
    CodeOrHostLabel.Text := 'Waiting for the host to start the game';
    StartGameAction.Visible := False;
  end;

  RemoteData.StartPollingForUsers();
end;

procedure TGreenRoomFrame.RenderUsers;
var
  LCurrentUser: string;
begin
  UsersListView.BeginUpdate;
  try
    UsersListView.Items.Clear;

    LCurrentUser := '';
    MainData.GameUsers.ForEach(
      procedure (const user: IUserData)
      var
        LItem: TListViewItem;
      begin
        LItem := UsersListView.Items.Add;
        LItem.Text := user.Name;
        if user.IsCurrentUser then
          LCurrentUser := user.Name;
      end
    );

    if MainData.GameUsers.Count >= MainData.CurrentGame.MinUser then
      WaitMessageLabel.Text :=
          'Waiting for ' + LCurrentUser
        + ' to start ' + MainData.CurrentGame.SessionName.QuotedString
        + ', ' + (MainData.CurrentGame.MaxUser - MainData.GameUsers.Count).ToString
        + ' open slots remaining'
    else // waiting users to join
      WaitMessageLabel.Text :=
          'Waiting for ' + (MainData.CurrentGame.MinUser - MainData.GameUsers.Count).ToString
        + ' players to join ' + MainData.CurrentGame.SessionName.QuotedString;


  finally
    UsersListView.EndUpdate;
  end;
end;

procedure TGreenRoomFrame.StartGameActionUpdate(Sender: TObject);
begin
  StartGameAction.Enabled := False;
end;

end.
