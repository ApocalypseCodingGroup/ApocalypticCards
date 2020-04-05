program CardDebug;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  DebugForm in 'forms\DebugForm.pas' {Form4},
  WebMainModel in 'modules\WebMainModel.pas' {WebModule4: TWebModule},
  FireDAC.VCLUI.Wait in 'units\FireDAC.VCLUI.Wait.pas',
  Requests in 'units\Requests.pas',
  datamodel in 'units\api\datamodel.pas',
  viewmodel in 'units\api\viewmodel.pas',
  viewmodel.game.standard in 'units\implementation\viewmodel.game.standard.pas',
  datamodel.gamedata.standard in 'units\implementation\datamodel.gamedata.standard.pas',
  viewmodel.viewmodel.standard in 'units\implementation\viewmodel.viewmodel.standard.pas',
  viewmodel.standard in 'units\api\viewmodel.standard.pas',
  viewmodel.gameobject.custom in 'units\implementation\viewmodel.gameobject.custom.pas',
  datamodel.gamedataobject.custom in 'units\implementation\datamodel.gamedataobject.custom.pas',
  datamodel.standard in 'units\api\datamodel.standard.pas',
  datamodel.datamodel.standard in 'units\implementation\datamodel.datamodel.standard.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
