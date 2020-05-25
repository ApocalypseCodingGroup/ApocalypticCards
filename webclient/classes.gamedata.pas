unit classes.gamedata;

interface

type

  TGameState = (
    gsGreenRoom,  //- Waiting for players to join
    gsRunning,    //- Game has started
    gsNextTurn,   //- (Not to database, just triggers state change)
    gsGameOver    //- We're done here.
  );

  TGameData = record
    CurrentQuestion: string;
    SessionPassword: string;
    SessionName: string;
    LangID: string;
    MinUser: integer;
    MaxUser: integer;
    SessionID: string;
    GameState: TGameState;
    UserCount: integer;
    function ToJSON: string;
    class function FromJSON(const JSONString: string): TGameData; static;
  end;

  TPlayerState = (
    psInGreenRoom,            //- Waiting in green room for game to begin.
    psJudgeWaitingForSubmit,  //- Waiting for other players to submit cards
    psPlayerSubmitting,       //- I should submit a card from my hand
    psGameEnded               //- Game is over, display scores
  );

  TGameUser = record
    UserName:      string;
    PlayerState:   TPlayerState;
    Score:         integer;
    Deleted:       boolean;
    IsCurrentUser: boolean;
    UserID:        string;
    Name:          string;
    GameID:        string;
  end;

(* This is what comes down from the API call

 {
        "currentQuestion": "",
        "sessionPassword": "",
        "sessionName": "Craig's Game",
        "langID": "US",
        "minUser": 3,
        "maxUser": 6,
        "sessionID": "{B88F96D7-14BC-480E-BEFD-21AA94B614B3}",
        "gameState": "gsGreenRoom",
        "userCount": 1
    }
]

*)

implementation
uses WEBLib.JSON, StrUtils, WebLib.WebTools, SysUtils;

{ TGameData }

class function TGameData.FromJSON(const JSONString: string): TGameData;
var
  JS: TJSON;
  JO: TJSONObject;
begin
  try
    JS                     := TJSON.Create;
    JO                     := JS.Parse(JSONString);
    Result.CurrentQuestion := JO.GetJSONValue('currentQuestion');
    Result.SessionPassword := JO.GetJSONValue('sessionPassword');
    Result.SessionName     := JO.GetJSONValue('sessionName');
    Result.LangID          := JO.GetJSONValue('langID');
    Result.MinUser         := StrToIntDef(JO.GetJSONValue('minUser'), 0);
    Result.MaxUser         := StrToIntDef(JO.GetJSONValue('maxUser'), 0);
    Result.SessionID       := JO.GetJSONValue('sessionID');
    Result.GameState       := TGameState(StrToIntDef(JO.GetJSONValue('gameState'), Ord(TGameState.gsGameOver)));
    Result.UserCount       := StrToIntDef(JO.GetJSONValue('userCount'), 0);
  except
    on E: Exception do
      OutputDebugString('TGameData.FromJSON: Error while translating "' + E.Message);
  end;
end;

function TGameData.ToJSON: string;
var
  JO: TJSONObject;
begin
  JO      := TJSONObject.Create;
  try
    JO.AddPair(TJSONPair.Create('currentQuestion', CurrentQuestion));
    JO.AddPair(TJSONPair.Create('sessionPassword', SessionPassword));
    JO.AddPair(TJSONPair.Create('sessionName',     SessionName));
    JO.AddPair(TJSONPair.Create('langID',          LeftStr(LangID, 2)));
    JO.AddPair(TJSONPair.Create('minUser',         TJSONNumber.Create(MinUser)));
    JO.AddPair(TJSONPair.Create('maxUser',         TJSONNumber.Create(MaxUser)));
    JO.AddPair(TJSONPair.Create('sessionID',       SessionID));
    JO.AddPair(TJSONPair.Create('gameState',       TJSONNumber.Create(Ord(GameState))));
    JO.AddPair(TJSONPair.Create('userCount',       TJSONNumber.Create(UserCount)));
    Result := JO.ToJSON();
  except
    on E: Exception do
      OutputDebugString('TGameData.ToJSON: Error while composing "' + E.Message);
  end;
end;

end.
