program CardDebug;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  DebugForm in 'forms\DebugForm.pas' {Form4},
  WebMainModel in 'modules\WebMainModel.pas' {WebModule4: TWebModule},
  Dek in 'units\Dek.pas',
  GameService in 'units\GameService.pas',
  MariaDB in 'units\MariaDB.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
