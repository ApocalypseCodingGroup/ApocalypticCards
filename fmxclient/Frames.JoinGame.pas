unit Frames.JoinGame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts,
  System.Actions, FMX.ActnList
, FrameStand, SubjectStand
;

type
  TJoinFrame = class(TFrame)
    Layout1: TLayout;
    YourNameEdit: TEdit;
    Label6: TLabel;
    Layout2: TLayout;
    Layout3: TLayout;
    Label1: TLabel;
    GamesListView: TListView;
    JoinGameButton: TButton;
    GameKeyEdit: TEdit;
    Label2: TLabel;
    ActionList1: TActionList;
    JoinGameAction: TAction;
    LastCheckLabel: TLabel;
    ClearGameKeyButton: TButton;
    procedure JoinGameActionUpdate(Sender: TObject);
    procedure GameKeyEditChangeTracking(Sender: TObject);
    procedure JoinGameActionExecute(Sender: TObject);
    procedure ClearGameKeyButtonClick(Sender: TObject);
  private
    [FrameInfo] FI: TFrameInfo<TJoinFrame>;
    procedure RenderGames;
  public
    [BeforeShow]
    procedure FrameOnShow;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.fmx}

uses
  datamodel
, Data.Remote, Data.Main, Utils.Messages, System.Messaging;

{ TJoinFrame }

procedure TJoinFrame.AfterConstruction;
begin
  inherited;
  GameKeyEdit.MaxLength := cPasswordLen;

  TGamesChanged.Subscribe(
    procedure (const Sender: TObject; const M: TMessage)
    begin
      RenderGames;

      LastCheckLabel.Text := TimeToStr(Now);
    end
  );
end;

procedure TJoinFrame.ClearGameKeyButtonClick(Sender: TObject);
begin
  GameKeyEdit.Text := '';
end;

procedure TJoinFrame.FrameOnShow;
begin
  RemoteData.StartPollingForGames();
end;

procedure TJoinFrame.GameKeyEditChangeTracking(Sender: TObject);
begin
  GamesListView.Enabled := not (GameKeyEdit.Text.Trim.Length = cPasswordLen);
end;

procedure TJoinFrame.JoinGameActionExecute(Sender: TObject);
var
  LSessionID: string;
  LSelected: TListViewItem;
begin
//  LSessionID := GameKeyEdit.Text.Trim;

  LSelected := GamesListView.Selected as TListViewItem;
  if GamesListView.Enabled and Assigned(LSelected) then
    LSessionID := LSelected.Data['SessionID'].AsString;

  if LSessionID = '' then
    Exit;

  RemoteData.JoinGame(YourNameEdit.Text.Trim, LSessionID
  , procedure
    begin
      MainData.CurrentView := GreenRoom;
    end
  , procedure(const AErrorMessage: string)
    begin
      ShowMessage(AErrorMessage);
      FI.HideAndClose();
      MainData.CurrentView := Home;
    end
  );
end;

procedure TJoinFrame.JoinGameActionUpdate(Sender: TObject);
begin
  JoinGameAction.Enabled :=
        (YourNameEdit.Text.Trim.Length > 3)
    and (
       (GameKeyEdit.Text.Trim.Length = cPasswordLen)
    or (GamesListView.Selected <> nil)
    );
end;

procedure TJoinFrame.RenderGames;
var
  LPreviouslySelectedSessionID: string;
  LPreviouslySelected: TListViewItem;
begin
  GamesListView.BeginUpdate;
  try
    LPreviouslySelected := GamesListView.Selected as TListViewItem;
    LPreviouslySelectedSessionID := '';
    if Assigned(LPreviouslySelected) then
      LPreviouslySelectedSessionID :=
        LPreviouslySelected.Data['SessionID'].AsString;

    GamesListView.Items.Clear;

    LPreviouslySelected := nil;
    MainData.Games.ForEach(
      procedure (const game: IGameData)
      var
        LItem: TListViewItem;
      begin
        LItem := GamesListView.Items.Add;
        LItem.Text := game.SessionName;
        LItem.Data['SessionID'] := game.SessionID; // borderline

        if game.SessionID = LPreviouslySelectedSessionID then
          LPreviouslySelected := LItem;
      end
    );

    GamesListView.Selected := LPreviouslySelected;
  finally
    GamesListView.EndUpdate;
  end;
end;

end.
