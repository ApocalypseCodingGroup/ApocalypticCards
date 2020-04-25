unit Frames.CreateGame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListBox, FMX.EditBox, FMX.SpinBox
, DataModel, System.Actions, FMX.ActnList
, FrameStand, SubjectStand
;

type
  TCreateGameFrame = class(TFrame)
    NameEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    LangComboBox: TComboBox;
    Label3: TLabel;
    MinUsersSpinBox: TSpinBox;
    Label4: TLabel;
    Label5: TLabel;
    MaxUsersSpinBox: TSpinBox;
    IsPrivateCheckBox: TCheckBox;
    Label6: TLabel;
    YourNameEdit: TEdit;
    CreateButton: TButton;
    CancelButton: TButton;
    ActionList1: TActionList;
    CreateGameAction: TAction;
    procedure CreateGameActionExecute(Sender: TObject);
    procedure CreateGameActionUpdate(Sender: TObject);
    procedure MinUsersSpinBoxChange(Sender: TObject);
    procedure MaxUsersSpinBoxChange(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    function GetMaxUsers: Integer;
    function GetMinUsers: Integer;
    procedure SetMaxUsers(const Value: Integer);
    procedure SetMinUsers(const Value: Integer);
    { Private declarations }

    property MinUsers: Integer read GetMinUsers write SetMinUsers;
    property MaxUsers: Integer read GetMaxUsers write SetMaxUsers;
  protected
    [FrameInfo] FI: TFrameInfo<TCreateGameFrame>;
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses
  datamodel.standard, Data.Remote, Data.Main, Utils.Messages;


procedure TCreateGameFrame.CancelButtonClick(Sender: TObject);
begin
  FI.HideAndClose();
  MainData.CurrentView := Home;
end;

procedure TCreateGameFrame.CreateGameActionExecute(Sender: TObject);
var
  LGameData: IGameData;
begin
  LGameData := TGameData.Create();

  LGameData.SessionName := NameEdit.Text;
  LGameData.LangID := LangComboBox.Selected.Text;
  if IsPrivateCheckBox.IsChecked then
    LGameData.SessionPassword := 'Generate'; // use constant here
  LGameData.MinUser := MinUsers;
  LGameData.MaxUser := MaxUsers;

  // start wait
  RemoteData.CreateGame(LGameData
  , procedure
    begin
      // game created
//      ShowMessage('Done! ' + MainData.CurrentGame.SessionID);

      // add user to the newly created game
      RemoteData.JoinGame(YourNameEdit.Text, MainData.CurrentGame.SessionID
      , procedure
        begin
//          ShowMessage('User joined game!');

          MainData.CurrentView := GreenRoom;
        end
      , procedure(const AErrorMessage: string)
        begin
          ShowMessage(AErrorMessage);
        end
      );

      // stop wait
    end
  , procedure(const AErrorMessage: string)
    begin
      ShowMessage(AErrorMessage);
      // Error!
      // stop wait
    end
  );
end;

procedure TCreateGameFrame.CreateGameActionUpdate(Sender: TObject);
begin
  CreateGameAction.Enabled :=
      (NameEdit.Text.Length > 3)
  and (YourNameEdit.Text.Length > 3)
  and (MaxUsers >= MinUsers);
end;

function TCreateGameFrame.GetMaxUsers: Integer;
begin
  Result := Trunc(MaxUsersSpinBox.Value);
end;

function TCreateGameFrame.GetMinUsers: Integer;
begin
  Result := Trunc(MinUsersSpinBox.Value);
end;

procedure TCreateGameFrame.MaxUsersSpinBoxChange(Sender: TObject);
begin
  if MaxUsers < MinUsers then
    MinUsers := MaxUsers;
end;

procedure TCreateGameFrame.MinUsersSpinBoxChange(Sender: TObject);
begin
  if MinUsers > MaxUsers then
    MaxUsers := MinUsers;
end;

procedure TCreateGameFrame.SetMaxUsers(const Value: Integer);
begin
  MaxUsersSpinBox.Value := Value;
end;

procedure TCreateGameFrame.SetMinUsers(const Value: Integer);
begin
  MinUsersSpinBox.Value := Value;
end;

end.
