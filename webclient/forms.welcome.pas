unit forms.welcome;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, forms.baseform, WEBLib.Controls,
  WEBLib.ExtCtrls, Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TWelcomeForm = class(TBaseForm)
    StartButton: TWebButton;
    JoinGameButton: TWebButton;
    procedure StartButtonClick(Sender: TObject);
    procedure JoinGameButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WelcomeForm: TWelcomeForm;

implementation
uses WEBLib.WebTools, forms.creategameform, modules.datamodule;

{$R *.dfm}

procedure TWelcomeForm.JoinGameButtonClick(Sender: TObject);
begin
  inherited;
  ShowMessage('Not yet implemented');
  mainDataModule.GetGames;
end;

procedure TWelcomeForm.StartButtonClick(Sender: TObject);
var
  TheForm: TCreateGameForm;

  procedure AfterCreate(AForm: TObject);
  begin
    //
  end;

  procedure AfterShowModal(AValue: TModalResult);
  begin
    if AValue = mrCancel then
    begin
      ShowMessage('You canceled the game');
    end;
  end;


begin
  inherited;
  TheForm := TCreateGameForm.CreateNew(@AfterCreate);
  TheForm.ShowModal(@AfterShowModal);
end;

end.
