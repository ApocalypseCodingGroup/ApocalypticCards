unit Data.Remote;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope
, datamodel
;

type
  TErrorProc = reference to procedure (const AMessage: string);

  TRemoteData = class(TDataModule)
    RESTClient1: TRESTClient;
    GameRequest: TRESTRequest;
    GameResponse: TRESTResponse;
    UsersRequest: TRESTRequest;
    UsersResponse: TRESTResponse;
  private
  public
    procedure CreateGame(const AGameData: IGameData; const AOnSuccess: TProc;
      const AOnError: TErrorProc);

    procedure JoinGame(const AUserName: string; const ASessionID: string;
      const AOnSuccess: TProc; const AOnError: TErrorProc);
  end;

var
  RemoteData: TRemoteData;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  System.JSON, REST.JSON
, datamodel.standard
, Data.Main
;

{ TRemoteData }

procedure TRemoteData.CreateGame(const AGameData: IGameData;
  const AOnSuccess: TProc; const AOnError: TErrorProc);
var
  LGameJSON: string;
begin
  LGameJSON := TJson.ObjectToJsonString(AGameData.AsObject);

  GameRequest.Body.Add(LGameJSON, ctAPPLICATION_JSON);
  GameRequest.ExecuteAsync(
    procedure
    begin
      MainData.CurrentGame := TJson.JsonToObject<TGameData>(GameResponse.Content);

      if Assigned(AOnSuccess) then
        AOnSuccess();
    end
   , True, True
   , procedure(AObj: TObject)
     begin
      if Assigned(AOnError) then
        AOnError('ERROR! ' + AObj.ToString);
     end
  );

end;

procedure TRemoteData.JoinGame(const AUserName, ASessionID: string;
  const AOnSuccess: TProc; const AOnError: TErrorProc);
var
  LUserData: IUserData;
begin
  LUserData := TUserData.Create;
  LUserData.Name := AUserName;
  LUserData.GameID := ASessionID;

  UsersRequest.Body.Add(LUserData.ToJSON, ctAPPLICATION_JSON);
  UsersRequest.ExecuteAsync(
    procedure
    begin
      MainData.UserData := TJson.JsonToObject<TUserData>(UsersResponse.Content);

      if Assigned(AOnSuccess) then
        AOnSuccess();
    end
  , True, True
  , procedure(AObj: TObject)
    begin
      if Assigned(AOnError) then
        AOnError(AObj.ToString)
      else
        raise Exception.Create(AObj.ToString);
    end
  );
end;

end.
