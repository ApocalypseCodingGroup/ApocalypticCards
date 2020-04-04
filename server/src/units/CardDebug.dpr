program CardDebug;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  DebugForm in '..\forms\DebugForm.pas' {Form4},
  WebMainModel in '..\modules\WebMainModel.pas' {WebModule4: TWebModule},
  datamodel.database.standard in 'implementation\datamodel.database.standard.pas',
  FireDAC.VCLUI.Wait in 'FireDAC.VCLUI.Wait.pas',
  Requests in 'Requests.pas',
  datamodel in 'api\datamodel.pas',
  gameviewmodel in 'api\gameviewmodel.pas',
  gameviewmodel.game.standard in 'implementation\gameviewmodel.game.standard.pas',
  gameviewmodel.gameview.standard in 'implementation\gameviewmodel.gameview.standard.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
