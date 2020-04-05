unit modules.datamodule;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Modules, WEBLib.REST;

type
  TmainDataModule = class(TWebDataModule)
    httpGetGames: TWebHttpRequest;
    procedure httpGetGamesResponse(Sender: TObject; AResponse: string);
  private
  public
    function GetGames: string;
  end;

var
  mainDataModule: TmainDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses modules.clientconstants, WEBLib.WebTools;

{$R *.dfm}

{ TmainDataModule }

function TmainDataModule.GetGames: string;
begin
  httpGetGames.URL := cServerURL + cAPI_Games;
  httpGetGames.Execute;
end;

procedure TmainDataModule.httpGetGamesResponse(Sender: TObject; AResponse: string);
begin
  //
  OutputDebugString('httpGetGamesResponse: "' + AResponse + '"');
end;

end.
