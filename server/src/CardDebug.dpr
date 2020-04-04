program CardDebug;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  DebugForm in 'forms\DebugForm.pas' {Form4},
  WebMainModel in 'modules\WebMainModel.pas' {WebModule4: TWebModule},
  datamodel.database.standard in 'units\implementation\datamodel.database.standard.pas',
  FireDAC.VCLUI.Wait in 'units\FireDAC.VCLUI.Wait.pas',
  Requests in 'units\Requests.pas',
  datamodel in 'units\api\datamodel.pas',
  gameviewmodel in 'units\api\gameviewmodel.pas',
  gameviewmodel.game.standard in 'units\implementation\gameviewmodel.game.standard.pas',
  gameviewmodel.gameview.standard in 'units\implementation\gameviewmodel.gameview.standard.pas',
  datamodel.game.standard in 'units\implementation\datamodel.game.standard.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
