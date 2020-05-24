unit modules.datamodule;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Modules, WEBLib.REST,
  interfaces.callbacks, classes.gamedata;

type
  TmainDataModule = class(TWebDataModule)
    httpGetGames: TWebHttpRequest;
    BasicRequest: TWebHttpRequest;
    httpCreateGame: TWebHttpRequest;
    procedure httpGetGamesResponse(Sender: TObject; AResponse: string);
    procedure BasicRequestResponse(Sender: TObject; AResponse: string);
    procedure httpCreateGameRequestResponse(Sender: TObject; ARequest: TJSXMLHttpRequest; AResponse: string);
  private
    FGameGuid:                TGameGuid;
    FUserGuid:                TUserGuid;
    FCreateGameCallback:      TCreateGameCallback;
    FGetGamesCallback:        TGetGamesCallback;
    FGetSpecificGameCallback: TGetSpecificGameCallback;
    FGetUserCallback:         TGetUserCallback;
  public
    function GetGames(TheGamesCallback: TGetGamesCallback): boolean;
    function CreateGame(TheGame: TGameData; TheCreateGameCallback: TCreateGameCallback): boolean;
  end;

var
  mainDataModule: TmainDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses modules.clientconstants, WEBLib.WebTools, models.gamedata;

{$R *.dfm}

{ TmainDataModule }

procedure TmainDataModule.BasicRequestResponse(Sender: TObject; AResponse: string);
begin
  OutputDebugString('BasicRequestResponse: "' + AResponse + '"');
end;

function TmainDataModule.CreateGame(TheGame: TGameData; TheCreateGameCallback: TCreateGameCallback): boolean;
begin
  FCreateGameCallback     := TheCreateGameCallback;
  httpCreateGame.URL      := cServerURL + cAPI_Games;
  httpCreateGame.PostData := TheGame.ToJSON;
  httpCreateGame.Execute;
end;

function TmainDataModule.GetGames(TheGamesCallback: TGetGamesCallback): boolean;
begin
  FGetGamesCallback := TheGamesCallback;
  httpGetGames.URL  := cServerURL + cAPI_Games;
  httpGetGames.Execute;
end;

procedure TmainDataModule.httpCreateGameRequestResponse(Sender: TObject; ARequest: TJSXMLHttpRequest; AResponse: string);
var
  bSuccess: boolean;
begin
  if ARequest.Status = 200 then
    begin
      CurrentGame := TGameData.FromJSON(AResponse);
      bSuccess := True;
    end
  else
    begin
      OutputDebugString('TmainDataModule.httpCreateGameRequestResponse: Error "' + AResponse + '"');
      bSuccess := False;
    end;
  if Assigned(FCreateGameCallback) then FCreateGameCallback(bSuccess);
end;

procedure TmainDataModule.httpGetGamesResponse(Sender: TObject; AResponse: string);
begin
{ TODO :
Process the AResponse and load the games object/list
and validate the AResponse }

// if the validation is valid then
    if assigned(FGetGamesCallback) then FGetGamesCallback(True);

  OutputDebugString('httpGetGamesResponse: "' + AResponse + '"');
end;

end.
