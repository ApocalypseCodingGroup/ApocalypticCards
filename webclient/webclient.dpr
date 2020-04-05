program webclient;

uses
  Vcl.Forms,
  WEBLib.Forms,
  forms.baseform in 'forms.baseform.pas' {BaseForm: TWebForm} {*.html},
  forms.welcome in 'forms.welcome.pas' {WelcomeForm: TWebForm},
  forms.creategameform in 'forms.creategameform.pas' {CreateGameForm: TWebForm},
  modules.datamodule in 'modules.datamodule.pas' {mainDataModule: TWebDataModule},
  modules.clientconstants in 'modules.clientconstants.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TmainDataModule, mainDataModule);
  Application.CreateForm(TWelcomeForm, WelcomeForm);
  Application.Run;
end.
