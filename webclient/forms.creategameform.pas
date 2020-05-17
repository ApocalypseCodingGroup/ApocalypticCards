unit forms.creategameform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, forms.baseform, WEBLib.Controls,
  WEBLib.ExtCtrls, Vcl.StdCtrls, WEBLib.StdCtrls, VCL.TMSFNCTypes,
  VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes,
  VCL.TMSFNCCustomControl, VCL.TMSFNCTrackBar, VCL.TMSFNCSpinEdit;

type
  TCreateGameForm = class(TBaseForm)
    WebLabel1: TWebLabel;
    GameNameEdit: TWebEdit;
    WebLabel2: TWebLabel;
    WebComboBox1: TWebComboBox;
    WebLabel3: TWebLabel;
    WebLabel4: TWebLabel;
    PrivateGameCheckbox: TWebCheckBox;
    BackButton: TWebButton;
    CreateButton: TWebButton;
    SpinMinUsers: TTMSFNCSpinEdit;
    SpinMaxUsers: TTMSFNCSpinEdit;
    procedure BackButtonClick(Sender: TObject);
    procedure SpinMinUsersValueChanged(Sender: TObject; AValue: Single);
    procedure SpinMaxUsersValueChanged(Sender: TObject; AValue: Single);
    procedure WebFormCreate(Sender: TObject);
    procedure GameNameEditChange(Sender: TObject);
    procedure GameNameEditExit(Sender: TObject);
    procedure YourNameEditChange(Sender: TObject);
    procedure YourNameEditExit(Sender: TObject);
  private
    procedure CheckButtons;
  end;

var
  CreateGameForm: TCreateGameForm;

implementation

{$R *.dfm}

{ TCreateGameForm }

procedure TCreateGameForm.BackButtonClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
  Close;
end;

procedure TCreateGameForm.CheckButtons;
begin
  CreateButton.Visible := (Length(GameNameEdit.Text) > 0);
end;

procedure TCreateGameForm.GameNameEditChange(Sender: TObject);
begin
  inherited;
  CheckButtons;
end;

procedure TCreateGameForm.GameNameEditExit(Sender: TObject);
begin
  inherited;
  CheckButtons;
end;

procedure TCreateGameForm.SpinMaxUsersValueChanged(Sender: TObject; AValue: Single);
begin
  inherited;
  if (SpinMaxUsers.Value < SpinMinUsers.Value) then
  begin
    SpinMinUsers.Value := SpinMaxUsers.Value;
  end;
end;

procedure TCreateGameForm.SpinMinUsersValueChanged(Sender: TObject; AValue: Single);
begin
  inherited;
  if (SpinMinUsers.Value > SpinMaxUsers.Value) then
  begin
    SpinMaxUsers.Value := SpinMinUsers.Value;
  end;
end;

procedure TCreateGameForm.WebFormCreate(Sender: TObject);
begin
  inherited;
  SpinMinUsers.Value := 3;
  SpinMaxUsers.Value := 6;
end;

procedure TCreateGameForm.YourNameEditChange(Sender: TObject);
begin
  inherited;
  CheckButtons;
end;

procedure TCreateGameForm.YourNameEditExit(Sender: TObject);
begin
  inherited;
  CheckButtons;
end;

end.
