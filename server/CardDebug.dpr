program CardDebug;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  DebugForm in 'DebugForm.pas' {Form4},
  WebMainModel in 'WebMainModel.pas' {WebModule4: TWebModule},
  Dek in 'Dek.pas',
  GameService in 'GameService.pas',
  MariaDB in 'MariaDB.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
