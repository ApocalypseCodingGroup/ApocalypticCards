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
    PollingForGamesRequest: TRESTRequest;
    PollingForGamesResponse: TRESTResponse;
    PollingForGamesTimer: TTimer;
    StartGameResponse: TRESTResponse;
    StartGameRequest: TRESTRequest;
    TurnResponse: TRESTResponse;
    TurnRequest: TRESTRequest;
    procedure PollingForUsersTimerTimer(Sender: TObject);
    procedure PollingForGamesTimerTimer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    FPollingForUsers: Boolean;
    FPollingForGames: Boolean;
  protected
    procedure EndorseAuthentication(const AReq: TRESTRequest);

    procedure PollForUsers();
    procedure PollForGames();
    function ParseGames(const AJSONResponse: string): IList<IGameData>;
    function ParseGreenRoomUsers(const AJSONResponse: string): IList<IUserData>;

  public
    procedure CreateGame(const AGameData: IGameData; const AOnSuccess: TProc;
      const AOnError: TErrorProc);

    procedure JoinGame(const AUserName: string; const ASessionID: string;
      const AOnSuccess: TProc; const AOnError: TErrorProc);

    procedure StartGame(const AOnSuccess: TProc; const AOnError: TErrorProc);

    procedure RetrieveTurnData(const AOnSuccess: TProc; const AOnError: TErrorProc);

    procedure StartPollingForUsers();
    procedure StopPollingForUsers();

    procedure StartPollingForGames();
    procedure StopPollingForGames();


    property PollingForUsers: Boolean read FPollingForUsers;
    property PollingForGames: Boolean read FPollingForGames;
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
, CodeSiteLogging
;

{ TRemoteData }

function TRemoteData.ParseGames(const AJSONResponse: string): IList<IGameData>;
var
  idx: integer;
  JSONArray: TJSONArray;
begin
  Result := TList<IGameData>.Create;
  JSONArray := TJSONObject.ParseJSONValue(
    TEncoding.ASCII.GetBytes(AJSONResponse),0) as TJSONArray;
  if JSONArray.Count = 0 then begin
    exit;
  end;
  for idx := 0 to pred(JSONArray.Count) do begin
    Result.Add(TJSON.JsonToObject<TGameData>(JSONArray.Items[idx].ToJSON));
  end;
end;

function TRemoteData.ParseGreenRoomUsers(const AJSONResponse: string): IList<IUserData>;
var
  idx: integer;
  JSONArray: TJSONArray;
begin
  Result := TList<IUserData>.Create;
  JSONArray := TJSONObject.ParseJSONValue(
    TEncoding.ASCII.GetBytes(AJSONResponse),0) as TJSONArray;
  if JSONArray.Count = 0 then begin
    exit;
  end;
  for idx := 0 to pred(JSONArray.Count) do begin
    Result.Add(TJSON.JsonToObject<TUserData>(JSONArray.Items[idx].ToJSON));
  end;
end;

procedure TRemoteData.CreateGame(const AGameData: IGameData;
  const AOnSuccess: TProc; const AOnError: TErrorProc);
var
  LGameJSON: string;
begin
  LGameJSON := TJson.ObjectToJsonString(AGameData.AsObject);

  GameRequest.Body.ClearBody;
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

procedure TRemoteData.DataModuleCreate(Sender: TObject);
begin
  if paramstr(1)='debug' then begin
    RESTClient1.BaseURL := 'http://localhost:8080';
  end;
end;

procedure TRemoteData.EndorseAuthentication(const AReq: TRESTRequest);
const AUTH_PARAM_NAME: string = 'authentication-string';
var
  LParam: TRESTRequestParameter;
begin
  if not Assigned(MainData.UserData) then
    raise Exception.Create('No userdata available to endorse authentication');

  if not AReq.Params.ContainsParameter(AUTH_PARAM_NAME) then
  begin
    LParam := AReq.Params.AddItem;
    LParam.Kind := TRESTRequestParameterKind.pkHTTPHEADER;
    LParam.Name := AUTH_PARAM_NAME;
  end;

  AReq.Params.ParameterByName(AUTH_PARAM_NAME).Value := MainData.UserData.UserID;
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

      if Assigned(MainData.Games) then
        MainData.Games.ForEach(
          procedure (const game: IGameData)
          begin
            if (MainData.CurrentGame <> game) and (game.SessionID = ASessionID) then
              MainData.CurrentGame := game;
          end
        );

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

procedure TRemoteData.PollForGames;
begin
  PollingForGamesRequest.ExecuteAsync(
    procedure
    begin
      MainData.Games := ParseGames(PollingForGamesResponse.Content);
    end
  , True, True
  , procedure (AObj: TObject)
    begin
      // do nothing on error

    end
  );
end;

procedure TRemoteData.PollForUsers;
begin
  EndorseAuthentication(PollingForUsersRequest);

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

procedure TRemoteData.PollingForGamesTimerTimer(Sender: TObject);
begin
  PollingForGamesTimer.Enabled := False;
  try
    PollForGames();
  finally
    PollingForGamesTimer.Enabled := FPollingForGames;
  end;
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

procedure TRemoteData.RetrieveTurnData(const AOnSuccess: TProc;
  const AOnError: TErrorProc);
begin
  EndorseAuthentication(TurnRequest);

  TurnRequest.ExecuteAsync(
    procedure
    var
      LTurnData: ITurnData;
    begin
      CodeSite.SendMsg('RetrieveTurnData: ' + TurnResponse.Content);

//      LTurnData := TJSON.JsonToObject<TTurnData>(TurnResponse.Content);
      LTurnData := TTurnData.FromJSON(TurnResponse.Content);
      MainData.TurnData := LTurnData;

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

procedure TRemoteData.StartGame(const AOnSuccess: TProc;
  const AOnError: TErrorProc);
var
  LGame: IGameData;
begin
  Assert(Assigned(MainData.CurrentGame));

  LGame := MainData.CurrentGame;
  LGame.GameState := TGameState.gsRunning;
  EndorseAuthentication(StartGameRequest);
  StartGameRequest.Body.Add(LGame.ToJSON, ctAPPLICATION_JSON);

  StartGameRequest.ExecuteAsync(
    procedure
    begin
      LGame := TJSON.JsonToObject<TGameData>(StartGameResponse.Content);
//      if not LGame.GameState = TGameState.gsRunning then
//        ShowMessage('Game did not start - Number of required users not met.'); //AM
      MainData.CurrentGame := LGame;

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

procedure TRemoteData.StartPollingForGames;
begin
  FPollingForGames := True;

  PollForGames(); // 1st attempt immediately
  PollingForGamesTimer.Enabled := True;
end;

procedure TRemoteData.StartPollingForUsers;
begin
  FPollingForUsers := True;

  PollForUsers(); // 1st attempt immediately
  PollingForUsersTimer.Enabled := True;
end;

procedure TRemoteData.StopPollingForGames;
begin
  FPollingForGames := False;

  TGamesPollingStopped.CreateAndSend(Self);
end;

procedure TRemoteData.StopPollingForUsers;
begin
  FPollingForUsers := False;

  TUsersPollingStopped.CreateAndSend(Self);
end;

end.
