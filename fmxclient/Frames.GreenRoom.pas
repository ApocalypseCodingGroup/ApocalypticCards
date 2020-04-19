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
    procedure StartGameActionUpdate(Sender: TObject);
  private
  public
    [BeforeShow]
    procedure FrameOnShow;
  end;

implementation

{$R *.fmx}

uses Data.Main, Data.Remote;

{ TGreenRoomFrame }

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

procedure TGreenRoomFrame.StartGameActionUpdate(Sender: TObject);
begin
  StartGameAction.Enabled := False;
end;

end.
