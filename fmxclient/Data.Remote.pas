unit Data.Remote;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.Types
, datamodel, cwCollections
;

type
  TErrorProc = reference to procedure (const AMessage: string);

  TRemoteData = class(TDataModule)
    RESTClient1: TRESTClient;
    GameRequest: TRESTRequest;
    GameResponse: TRESTResponse;
    UsersRequest: TRESTRequest;
    UsersResponse: TRESTResponse;
    PollingForUsersRequest: TRESTRequest;
    PollingForUsersResponse: TRESTResponse;
    PollingForUsersTimer: TTimer;
    procedure PollingForUsersTimerTimer(Sender: TObject);
  private
    FPollingForUsers: Boolean;
  protected
    procedure PollForUsers();
    function ParseGreenRoomUsers(const AJSONResponse: string): IList<IUserData>;

  public
    procedure CreateGame(const AGameData: IGameData; const AOnSuccess: TProc;
      const AOnError: TErrorProc);

    procedure JoinGame(const AUserName: string; const ASessionID: string;
      const AOnSuccess: TProc; const AOnError: TErrorProc);

    procedure StartPollingForUsers();
    procedure StopPollingForUsers();

    property PollingForUsers: Boolean read FPollingForUsers;
  end;

var
  RemoteData: TRemoteData;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  Generics.Collections, System.JSON, REST.JSON
, datamodel.standard, cwCollections.standard
, Data.Main, Utils.Messages
;

{ TRemoteData }

function TRemoteData.ParseGreenRoomUsers(const AJSONResponse: string): IList<IUserData>;
var
  idx: integer;
  JSONArray: TJSONArray;
begin
  Result := TList<IUserData>.Create;
  JSONArray := TJSONObject.ParseJSONValue(
    TEncoding.ASCII.GetBytes(AJSONResponse),0) as TJSONArray;
  if JSONArray.Size=0 then begin
    exit;
  end;
  for idx := 0 to pred(JSONArray.Count) do begin
    Result.Add(TJSON.JsonToObject<TUserData>(JSONArray.Get(idx).ToJSON));
  end;
end;

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

procedure TRemoteData.PollForUsers;
begin
  PollingForUsersRequest.Params.ParameterByName('authentication-string').Value :=
    MainData.UserData.UserID;
  PollingForUsersRequest.ExecuteAsync(
    procedure
    begin
      MainData.GameUsers := ParseGreenRoomUsers(PollingForUsersResponse.Content);
    end
  , True, True
  , procedure (AObj: TObject)
    begin
      // do nothing on error
    end
  );
end;

procedure TRemoteData.PollingForUsersTimerTimer(Sender: TObject);
begin
  PollingForUsersTimer.Enabled := False;
  try
    PollForUsers();
  finally
    PollingForUsersTimer.Enabled := FPollingForUsers;
  end;
end;

procedure TRemoteData.StartPollingForUsers;
begin
  FPollingForUsers := True;

  PollForUsers(); // 1st attempt immediately
  PollingForUsersTimer.Enabled := True;
end;

procedure TRemoteData.StopPollingForUsers;
begin
  FPollingForUsers := False;

  TPollingStopped.CreateAndSend(Self);
end;

end.
