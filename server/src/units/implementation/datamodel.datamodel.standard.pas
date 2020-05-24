unit datamodel.datamodel.standard;

interface
uses
  cwCollections
, DataModel
, FireDAC.Stan.Intf
, FireDAC.Stan.Option
, FireDAC.Stan.Error
, FireDAC.Phys.Intf
, FireDAC.Stan.Def
, FireDAC.Stan.Pool
, FireDAC.Stan.Async
, FireDAC.Stan.Param
, FireDAC.Phys
, FireDAC.DApt
, FireDAC.ConsoleUI.Wait
, Data.DB
, FireDAC.Comp.Client
, FireDAC.Phys.MySQLDef
, FireDAC.Phys.MySQL
;

type
  TDataModel = class( TInterfacedObject, IDataModel )
  private
    fConn : TFDConnection;
  private
    procedure QueryToGameData(const Qry: TFDQuery; const GameData: IGameData);
    procedure QueryToUserData(const Qry: TFDQuery; const UserData: IUserData);
    function  AddFirstUserToGame(const GameID, UserID: string): boolean;
    function  IsCurrentUser(const UserID, GameID: string): boolean;
    function  getGameIDByUserID(const Key: string): string;
    function  TransitionGameToRunning(const GameData: IGameData; const Users: IList<IUserData>): string;
    function  ValidateUserCount( const GameData: IGameData; out UserCount: integer ): boolean;
    procedure AllocateAnswers( const GameData: IGameData; const Users: IList<IUserData>; const RequiredAnswers: Integer );
    procedure AllocateQuestions( const GameData: IGameData; const RequiredQuestions: Integer );
    procedure getSuggestedAnswers( const GameID: string; const Cards: IList<ICardData> );
    procedure getQuestion(const QuestionID: string;Const Question : ICardData);
    procedure getCards(const GameID: string; const UserID: string; const Cards: IList<ICardData>);
    procedure getSelectedCard( const GameID: string; const Card: ICardData );
    Procedure DrawNewCards(aGameID : String;Const NotUserWith : String;Users : IList<IUserData>);
    Function  UpdateQuestionAndCurrentUser(Const aGameID,aNextUser : String) : boolean;
    Function  DiscardQuestion(Const aQuestionID,aGameID : String) : String;
    procedure NextJudge(aSelectedCard: String; out Users: IList<IUserData>; out GameID, NewCurrentUser, LastJudge: String);
    procedure UpdateScore(aSelectedCard: String);
  strict private
    procedure UpdateUser(const User: IUserData);
    procedure UpdateGame(const Game: IGameData);
    procedure CleanUp;
    procedure UpdateUserPing( const UserID: string );
    function  getGames: IList<IGameData>;
    function  CreateGame(const GameData: IGameData) : boolean;
    function  FindGameByID(const GameID: string): IGameData;
    function  FindGameByPassword(const Password: string): IGameData;
    function  GetGameByUserID( const UserID: string ) : IGameData;
    procedure CreateUser(const NewUser: IUserData);
    function  getUsers(const Key: string): IList<IUserData>;
    function  setGameState(AuthToken: string; const GameData: IGameData): string;
    function  getCurrentTurn( AuthToken: string ): ITurnData;
    function  setCurrentTurn( AuthToken: string; Const TurnData : ITurnData ): String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  Classes
, SysUtils
, cwCollections.Standard
, DataModel.Standard
;

const
  {$ifdef DEBUG}
  cDatabaseIni = '.\cardgame.ini';
  {$else}
  cDatabaseIni = '/etc/apocalypsecards/cardgame.ini';
  {$endif}

function TDataModel.AddFirstUserToGame(const GameID: string; const UserID: string): boolean;
const
  cSQL = 'UPDATE tbl_games SET CurrentUser=:UserID, LastUpdate=:LastUpdate WHERE (PKID=:GameID) and (CurrentUser is NULL)';
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Qry.SQL.Text := cSQL;
    Qry.ParamByName('LastUpdate').AsDateTime := Now;
    Qry.ParamByName('UserID').AsString := UserID;
    Qry.ParamByName('GameID').AsString := GameID;
    Qry.ExecSQL;
    Result := Qry.RowsAffected=1;
    if Qry.RowsAffected>1 then begin
      raise
        Exception.Create('Ooops, It looks as though the database has become corrupt. Blame the developers');
    end;
  finally
    Qry.DisposeOf;
  end;
end;

procedure TDataModel.CreateUser(const NewUser: IUserData);
const
  cSQL = 'INSERT into tbl_users (PKID, FKGameID, Name, Deleted, LastUpdate) values (:PKID, :FKGameID, :Name, FALSE, Now());';
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Qry.SQL.Text := cSQL;
    Qry.ParamByName('PKID').AsString := NewUser.UserID;
    Qry.ParamByName('FKGameID').AsString := NewUser.GameID;
    Qry.ParamByName('Name').AsString := NewUser.Name;
    Qry.ExecSQL;
    NewUser.IsCurrentUser := AddFirstUserToGame(NewUser.GameID,NewUser.UserID);
  finally
    Qry.DisposeOf;
  end;
end;

procedure TDataModel.CleanUp;
const
  cSQLUserCleanup = 'DELETE FROM tbl_users WHERE LastUpdate<SUBTIME(Now(),''0 0:0:30.000000'');';
  cSQLGameCleanup = 'DELETE FROM tbl_games WHERE pkid IN (SELECT pkid FROM vw_livegames WHERE UserCount=0);';
begin
  fConn.ExecSQL(cSQLUserCleanup);
  fConn.ExecSQL(cSQLGameCleanup);
end;

constructor TDataModel.Create;
var
  Credentials: Classes.TStringList;
  lIndex     : Integer;
begin
  inherited Create;
  fConn := TFDConnection.Create(nil);
  fConn.Params.DriverID := 'MySQL';
  Credentials := Classes.TStringList.Create;
  try
    if not FileExists(cDatabaseIni) then begin
      raise
        Exception.Create('The credentials configuration is missing.');
    end;
    Credentials.LoadFromFile(cDatabaseIni);
    lIndex := Credentials.IndexOfName('server');

    if lIndex >= 0
      then fConn.Params.Add('Server='+Credentials.ValueFromIndex[lIndex])
      else fConn.Params.Add('Server=127.0.0.1');

    fConn.Params.Add('CharacterSet=latin1');

    fConn.Params.Database := Credentials.Values['database'];
    fConn.Params.UserName := Credentials.Values['username'];
    fConn.Params.Password := Credentials.Values['password'];
  finally
    Credentials.DisposeOf;
  end;
  fConn.LoginPrompt := False;
  fConn.Connected := True;
  if not fConn.Connected then begin
    raise
      Exception.Create('Could not connect to the database using the credentials provided.');
  end;
end;

function TDataModel.CreateGame(const GameData: IGameData): boolean;
const
  cSQL = 'insert into tbl_games (PkId,GameState,SessionName,LangId,MinUser,MaxUser,LastUpdate) values ( :PkId, :GameState, :SessionName, :LangId, :MinUser, :MaxUser, :LastUpdate );';
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Qry.SQL.Text := cSQL;
    Qry.Params.ParamByName('PkId').AsString := GameData.SessionID;
    Qry.Params.ParamByName('GameState').AsInteger := Integer(GameData.GameState);
    Qry.Params.ParamByName('SessionName').AsString := GameData.SessionName;
    Qry.Params.ParamByName('LangId').AsString := GameData.LangID;
    Qry.Params.ParamByName('MinUser').AsInteger := GameData.MinUser;
    Qry.Params.ParamByName('MaxUser').AsInteger := GameData.MaxUser;
    Qry.Params.ParamByName('LastUpdate').AsDateTime := Now;
    Qry.ExecSQL;
    Result := Qry.RowsAffected=1;
  finally
    Qry.DisposeOf;
  end;
end;

function TDataModel.FindGameByID(const GameID: string): IGameData;
const
  cSQL = 'SELECT * FROM tbl_games WHERE PKID=:SessionID;';
var
  Qry: TFDQuery;
begin
  Result := nil;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Qry.SQL.Text := cSQL;
    Qry.ParamByName('SessionID').AsString := GameID;
    Qry.Active := true;
    if Qry.RowsAffected>1 then begin
      raise
        Exception.Create('Requested game session id matches more than one game.');
    end;
    Qry.First;
    Result := TGameData.Create;
    QueryToGamedata( Qry, Result );
  finally
    Qry.DisposeOf;
  end;
end;

function TDataModel.FindGameByPassword(const Password: string): IGameData;
const
  cSQL = 'SELECT * FROM tbl_games WHERE SessionPW=:SessionPW;';
var
  Qry: TFDQuery;
begin
  Result := nil;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Qry.SQL.Text := cSQL;
    Qry.ParamByName('SessionPW').AsString := Password;
    Qry.Active := true;
    if Qry.RowsAffected>1 then begin
      raise
        Exception.Create('Requested game session password matches more than one game.');
    end;
    Qry.First;
    Result := TGameData.Create;
    QueryToGamedata( Qry, Result );
  finally
    Qry.DisposeOf;
  end;
end;

procedure TDataModel.QueryToGameData( const Qry: TFDQuery; const GameData: IGameData );
begin
  { TODO : Need to correct fields included in this method. }
  GameData.SessionID       := Qry.FieldByName('PkId').AsString;
  GameData.SessionName     := Qry.FieldByName('SessionName').AsString;
  GameData.LangID          := Qry.FieldByName('LangID').AsString;
  GameData.MinUser         := Qry.FieldByName('MinUser').AsInteger;
  GameData.MaxUser         := Qry.FieldByName('MaxUser').AsInteger;
  GameData.CurrentQuestion := Qry.FieldByName('CurrentQuestion').AsString;
  GameData.GameState       := TGameState(Qry.FieldByName('GameState').AsInteger);
  if assigned(Qry.FindField('UserCount')) then begin
    GameData.UserCount   := Qry.FieldByName('UserCount').AsInteger;
  end else begin
    GameData.UserCount   := -1;
  end;
end;

function TDataModel.getGames: IList<IGameData>;
const
  cSQL = 'SELECT g.*,l.usercount FROM tbl_games g JOIN vw_livegames l ON g.pkid=l.pkid WHERE LENGTH(SessionPW)<1 AND GameState=0;';
var
  NewGameData: IGameData;
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Result := TList<IGameData>.Create;
    Qry.SQL.Text := cSQL;
    Qry.Active := true;
    Qry.First;
    while not Qry.EOF do begin
      NewGameData := TGameData.Create();
      QueryToGameData( Qry, NewGameData );
      Result.Add( NewGameData );
      Qry.Next;
    end;
  finally
    Qry.DisposeOf;
  end;
end;

function TDataModel.IsCurrentUser( const UserID: string; const GameID: string ): boolean;
const
  cSQL = 'select CurrentUser FROM tbl_games WHERE PKID=:FKGameID';
var
  tmpQry: TFDQuery;
begin
  tmpQry := TFDQuery.Create(nil);
  try
    tmpQry.Connection := fConn;
    tmpQry.SQL.Text := cSQL;
    tmpQry.ParamByName('FKGameID').AsString := GameID;
    tmpQry.Active := True;
    tmpQry.First;
    Result := tmpQry.FieldByName('CurrentUser').AsString = UserID;
    tmpQry.Active := False;
  finally
    tmpQry.Free;
  end;
end;

procedure TDataModel.QueryToUserData( const Qry: TFDQuery; const UserData: IUserData);
begin
  UserData.GameID  := Qry.FieldByName('FKGameID').AsString;
  UserData.Name    := Qry.FieldByName('Name').AsString;
  UserData.UserID  := Qry.FieldByName('PKID').AsString;
  UserData.Deleted := Qry.FieldByName('Deleted').AsBoolean;
  UserData.Score   := Qry.FieldByName('Score').AsInteger;
  UserData.PlayerState := TPlayerState(Qry.FieldByName('PlayerState').AsInteger);
  UserData.IsCurrentUser := IsCurrentUser( UserData.UserID, UserData.GameID );
end;

function TDataModel.ValidateUserCount( const GameData: IGameData; out UserCount: integer ): boolean;
const
  cSQL = 'select count(*) usercount from tbl_users where FKGameID=:PKID and Deleted<>1;';
var
  tmpQry: TFDQuery;
begin
  Result := False;
  tmpQry := TFDQuery.Create(nil);
  try
    tmpQry.Connection := fConn;
    tmpQry.SQL.Text := cSQL;
    tmpQry.ParamByName('PKID').AsString := GameData.SessionID;
    tmpQry.Active := True;
    tmpQry.First;
    if tmpQry.EOF then begin
      raise
        Exception.Create('Live game not found while checking user count. Game('+GameData.SessionID+')');
    end;
    UserCount := tmpQry.FieldByName('usercount').AsInteger;
    Result := (UserCount>=GameData.MinUser) and (UserCount<=GameData.MaxUser);
    tmpQry.Active := False;
  finally
    tmpQry.Free;
  end;
end;

procedure TDataModel.AllocateQuestions( const GameData: IGameData; const RequiredQuestions: Integer );
const
  cSrcSQL = 'SELECT * FROM tbl_questions ORDER BY RAND() LIMIT :RequiredQuestions;';
  cTgtSQL = 'INSERT INTO tbl_gamequestions (PKID, FKGameID, FKQuestionID) VALUES (:PKID, :FKGameID, :FKQuestionID);';
var
  RemainingRequired: Integer;
  GUID: TGUID;
  strGUID: string;
  src: TFDQuery;
  tgt: TFDQuery;
begin
  RemainingRequired := RequiredQuestions;
  src := TFDQuery.Create(nil);
  tgt := TFDQuery.Create(nil);
  try
    src.Connection := fConn;
    tgt.Connection := fConn;
    src.SQL.Text := cSrcSQL;
    tgt.SQL.Text := cTgtSQL;
    tgt.ParamByName('FKGameID').AsString := GameData.SessionID;
    while RemainingRequired>0 do begin
      src.ParamByName('RequiredQuestions').AsInteger := RemainingRequired;
      src.Active := True;
      src.First;
      while not src.Eof do begin
        CreateGUID(GUID);
        strGUID := GUIDToString(GUID);
        tgt.ParamByName('PKID').AsString := strGUID;
        tgt.ParamByName('FKQuestionID').AsString := src.FieldByName('PKID').AsString;
        if trim(GameData.CurrentQuestion)='' then begin
          GameData.CurrentQuestion := src.FieldByName('PKID').AsString;
        end;
        tgt.ExecSQL;
        src.Next;
        dec(RemainingRequired);
      end;
    end;
  finally
    tgt.DisposeOf;
    src.DisposeOf;
  end;
end;

procedure TDataModel.AllocateAnswers( const GameData: IGameData; const Users: IList<IUserData>; const RequiredAnswers: Integer );
const
  cSrcSQL = 'SELECT * FROM tbl_answers ORDER BY RAND() LIMIT :RequiredAnswers;';
  cTgtSQL = 'INSERT INTO tbl_gameanswers (PKID, FKGameID, FKPlayerID, FKAnswerID, State) VALUES (:PKID, :FKGameID, :FKPlayerID, :FKAnswerID, :State);';
var
  RemainingRequired: Integer;
  GUID: TGUID;
  strGUID: string;
  src: TFDQuery;
  tgt: TFDQuery;
  CardIndex: Integer;
  MaxUserCards: Integer;
begin
  RemainingRequired := RequiredAnswers;
  src := TFDQuery.Create(nil);
  tgt := TFDQuery.Create(nil);
  try
    src.Connection := fConn;
    tgt.Connection := fConn;
    src.SQL.Text := cSrcSQL;
    tgt.SQL.Text := cTgtSQL;
    tgt.ParamByName('FKGameID').AsString := GameData.SessionID;
    CardIndex := 0;
    MaxUserCards := (cCardsPerHand * Users.Count);
    while RemainingRequired>0 do begin
      src.ParamByName('RequiredAnswers').AsInteger := RemainingRequired;
      src.Active := True;
      src.First;
      while not src.Eof do begin
        CreateGUID(GUID);
        strGUID := GUIDToString(GUID);
        tgt.ParamByName('PKID').AsString := strGUID;
        tgt.ParamByName('FKAnswerID').AsString := src.FieldByName('PKID').AsString;
        if (CardIndex<MaxUserCards) then begin
          tgt.ParamByName('FKPlayerID').AsString := Users[(CardIndex div cCardsPerHand)].UserID;
          tgt.ParamByName('State').AsInteger := Integer(TGameCardState.csInHand);
        end else begin
          tgt.ParamByName('FKPlayerID').AsString := '';
          tgt.ParamByName('State').AsInteger := Integer(TGameCardState.csOnDeck);
        end;
        tgt.ExecSQL;
        src.Next;
        dec(RemainingRequired);
        inc(CardIndex);
      end;
    end;
  finally
    tgt.DisposeOf;
    src.DisposeOf;
  end;
end;

function TDataModel.TransitionGameToRunning( const GameData: IGameData; const Users: IList<IUserData> ): string;
var
  UserCount: Integer;
  RequiredQuestions: Integer;
  RequiredAnswers: Integer;
begin
  // Validate min/max users
  try
    if not ValidateUserCount(GameData, UserCount) then begin
      raise
        Exception.Create('Insufficient users to start game.');
    end;
    // Allocate initial hands of questions and answers
    RequiredQuestions := (cGameRounds * UserCount);
    RequiredAnswers := (succ(cGameRounds) * UserCount) + (UserCount * cCardsPerHand);
    AllocateQuestions( GameData, RequiredQuestions );
    AllocateAnswers( GameData, Users, RequiredAnswers );
    // Set all users that are not current user to psPlayerSubmitting
    // Set the current user to psJudgeWaitingForSubmit
    Users.ForEach(
      procedure ( const Item: IUserData )
      begin
        Item.Score := 0;
        if Item.IsCurrentUser then begin
          Item.PlayerState := psJudgeWaitingForSubmit;
        end else begin
          Item.PlayerState := psPlayerSubmitting;
        end;
        UpdateUser(Item);
      end
    );
    //- Set game state
    GameData.GameState := TGameState.gsRunning;
    UpdateGame(GameData);
  finally
    Result := GameData.ToJSON;
  end;
end;

Procedure TDataModel.UpdateScore(aSelectedCard : String);
const
  cSQL      = 'SELECT FKPlayerID FROM tbl_gameanswers WHERE (PKID=:AnswerID) LIMIT 1;';
var
  GameID,
  lPlayer       : String;
  Users         : IList<IUserData>;
  User          : IUserData;
  I             : Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Qry.SQL.Text := cSQL;
    Qry.ParamByName('AnswerID').AsString := aSelectedCard;
    Qry.Active := true;
    Qry.First;

    if Qry.Eof then
      raise Exception.Create('Could not happen says the developer');

    lPlayer := Qry.FieldByName('FKPlayerID').AsString;

    Users := getUsers(lPlayer);

    for i:=0 to Users.Count-1 do
      begin
        User := Users.Items[i];

        if User.UserID = lPlayer then
          begin
            User.Score := User.Score + 1;
            UpdateUser(User); // Twice I know
            exit;
          end;
      end;
  finally
    Qry.DisposeOf;
  end;
end;

Procedure TDataModel.NextJudge(aSelectedCard : String;out Users : IList<IUserData>;out GameID : String;out NewCurrentUser : String;out LastJudge : String);
const
  cSQL      = 'SELECT FKGameID,FKPlayerID FROM tbl_gameanswers WHERE (PKID=:AnswerID) LIMIT 1;';
var
  lPlayer       : String;
  User          : IUserData;
  lLastJudgeID,
  I             : Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Qry.SQL.Text := cSQL;
    Qry.ParamByName('AnswerID').AsString := aSelectedCard;
    Qry.Active := true;
    Qry.First;
    if Qry.Eof then
      raise Exception.Create('Could not happen says the developer');

    GameID  := Qry.FieldByName('FKGameID').AsString;
    lPlayer := Qry.FieldByName('FKPlayerID').AsString;

    Users := getUsers(lPlayer);

    lLastJudgeID := -1;

    for i:=0 to Users.Count-1 do
      begin
        User := Users.Items[i];

        if User.PlayerState = TPlayerState.psJudgeWaitingForSubmit then
          begin
            lLastJudgeID := i;
            LastJudge    := User.UserID;
            break;
          end;
      end;

    if lLastJudgeID = -1 then
      raise Exception.Create('Could not happen says the developer');

    if lLastJudgeID = Users.Count-1
      then begin // last in row start at zero
             Users.Items[lLastJudgeID].PlayerState := TPlayerState.psPlayerSubmitting;
             UpdateUser(Users.Items[lLastJudgeID]);
             Users.Items[0].PlayerState            := TPlayerState.psJudgeWaitingForSubmit;
             NewCurrentUser := Users.Items[0].UserID;
             UpdateUser(Users.Items[0]);
           end
      else begin
             Users.Items[lLastJudgeID].PlayerState := TPlayerState.psPlayerSubmitting;
             UpdateUser(Users.Items[lLastJudgeID]);
             inc(lLastJudgeID);
             Users.Items[lLastJudgeID].PlayerState := TPlayerState.psJudgeWaitingForSubmit;
             NewCurrentUser := Users.Items[lLastJudgeID].UserID;
             UpdateUser(Users.Items[lLastJudgeID]);
           end;
  finally
    Qry.DisposeOf;
  end;
end;

destructor TDataModel.Destroy;
begin
  fConn.DisposeOf;
  inherited;
end;

Function TDataModel.DiscardQuestion(Const aQuestionID,aGameID : String) : String;
Const
    cSQL    = 'UPDATE tbl_gamequestions SET Discarded=1 WHERE (FKQuestionID=:QuestionID);';
    cGetNew = 'SELECT FKQuestionID FROM tbl_gamequestions WHERE (FKGameID=:GameID) and (Discarded = 0) Limit 1;';
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Result := ''; // Game End!

    Qry.SQL.Text := cSQL;
    Qry.ParamByName('QuestionID').AsString := aQuestionID;
    Qry.ExecSQL;

    Qry.SQL.Text := cGetNew;
    Qry.ParamByName('GameID').AsString := aGameID;

    Qry.Active := true;
    Qry.First;

    if not Qry.eof then
      Result := Qry.FieldByName('FKQuestionID').AsString;
  finally
    Qry.DisposeOf;
  end;
end;

Function TDataModel.UpdateQuestionAndCurrentUser(Const aGameID,aNextUser : String) : boolean;
const
  cGetQuestion      = 'SELECT CurrentQuestion FROM tbl_games WHERE (PKID=:PKID);';
  cSQLNext          = 'UPDATE tbl_games SET CurrentUser=:CurrentUser, CurrentQuestion=:CurrentQuestion WHERE (PKID=:PKID);';
  cSQLEnd           = 'UPDATE tbl_games SET GameState = 3 WHERE (PKID=:PKID);';  // EndGame
var
  lNextQuestion : String;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Result := true;

    Qry.SQL.Text := cGetQuestion;
    Qry.ParamByName('PKID').AsString := aGameID;
    Qry.Active := true;
    Qry.First;

    if Qry.eof then
      Raise Exception.Create('GameID not found');

    lNextQuestion := DiscardQuestion(Qry.FieldbyName('CurrentQuestion').AsString,aGameID);

    if lNextQuestion.Trim = ''
      then begin
             Qry.SQL.Text := cSQLEnd;
             result := false;
           end
      else begin
             Qry.SQL.Text := cSQLNext;
             Qry.ParamByName('CurrentQuestion').AsString := lNextQuestion;
             Qry.ParamByName('CurrentUser').AsString     := aNextUser;
           end;

    Qry.ParamByName('PKID').AsString := aGameID;
    Qry.ExecSQL;
  finally
    Qry.DisposeOf;
  end;
end;

Procedure TDataModel.DrawNewCards(aGameID : String;Const NotUserWith : String;Users : IList<IUserData>);
const
  cSQL      = 'UPDATE tbl_gameanswers SET State=4 WHERE (FKGameID=:GameID) and ((State = 2) or (State = 3));';
  cNewCards = 'SELECT PKID FROM tbl_gameanswers WHERE State=0 ORDER BY RAND() LIMIT :RequiredAnswers;';
  cNewUser  = 'UPDATE tbl_gameanswers SET FKPlayerID=:PlayerID, State=1 WHERE (PKID=:PKID);';
var
  tmpQry : TFDQuery;
  idx    : Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Qry.SQL.Text := cSQL;
    Qry.ParamByName('GameID').AsString := aGameID;
    Qry.ExecSQL;

    Qry.SQL.Text := cNewCards;
    Qry.ParamByName('RequiredAnswers').AsInteger := Users.Count-1; // The old Judge neads no card
    Qry.Active := true;
    Qry.First;

    tmpQry := TFDQuery.Create(nil);
    try
      tmpQry.Connection := fConn;
      tmpQry.SQL.Text   := cNewUser;

      idx := 0;

      while not Qry.eof do
        begin
          if Users[idx].UserID = NotUserWith then
            inc(idx);

          tmpQry.ParamByName('PKID').AsString     := Qry.FieldByName('PKID').AsString;
          tmpQry.ParamByName('PlayerID').AsString := Users.Items[idx].UserID;
          tmpQry.ExecSQL;

          inc(idx);
          Qry.Next;
        end;
    finally
      tmpQry.Free;
    end;
  finally
    Qry.DisposeOf;
  end;
end;

function TDataModel.setCurrentTurn(AuthToken: string; const TurnData: ITurnData): String;
const
  cSQL      = 'UPDATE tbl_gameanswers SET State=2 WHERE (PKID=:AnswerID);';
  cJudge    = 'UPDATE tbl_gameanswers SET State=3 WHERE (PKID=:AnswerID) and (State=2);';
  cNextTurn = 'UPDATE tbl_gameanswers SET State=4 WHERE (PKID=:AnswerID) and (State=3);';
var
  GameID,
  LastJudge,
  lNewUser  : String;
  Users     : IList<IUserData>;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Qry.SQL.Text := cNextTurn;
    Qry.ParamByName('AnswerID').AsString := TurnData.Selection.CardID;
    Qry.ExecSQL;

    if Qry.RowsAffected = 1
      then begin // NextTurn
             NextJudge(TurnData.Selection.CardID,Users,GameID,lNewUser,LastJudge);
             if not UpdateQuestionAndCurrentUser(GameID,lNewUser) then
               exit(''); // No more Quetions

             DrawNewCards(GameID,LastJudge,Users);
           end
      else begin
             Qry.SQL.Text := cJudge;
             Qry.ParamByName('AnswerID').AsString := TurnData.Selection.CardID;
             Qry.ExecSQL;

             if Qry.RowsAffected = 1
               then begin
                      UpdateScore(TurnData.Selection.CardID);
                    end
               else begin
                      Qry.SQL.Text := cSQL;
                      Qry.ParamByName('AnswerID').AsString := TurnData.Selection.CardID;
                      Qry.ExecSQL;

                      if Qry.RowsAffected <> 1 then
                        raise Exception.Create('Ooops, It looks as though the database has become corrupt. Blame the developers');
                    end;
           end;

    Result := getCurrentTurn(AuthToken).ToJSON;
  finally
    Qry.DisposeOf;
  end;
end;

function TDataModel.setGameState(AuthToken: string; const GameData: IGameData): string;
var
  AuthorizedGameID: string;
  ExistingGame: IGameData;
begin
  AuthorizedGameID := getGameIDByUserID( AuthToken );
  if (AuthorizedGameID<>GameData.SessionID) or
     (Trim(AuthorizedGameID)='') or
     (Trim(GameData.SessionID)='') then begin
    raise
      Exception.Create('You do not have permission to edit this game. STOP TRYING TO CHEAT!!!');
  end;
  ExistingGame := FindGameByID(AuthorizedGameID);
  if not assigned(ExistingGame) then begin
    raise
      Exception.Create('This is one of those errors which should not be possible, and should not even have a message about it.');
  end;
  case GameData.GameState of
    gsGreenRoom: begin
      raise
        Exception.Create('The game may not transition back to the green room.');
    end;
    gsRunning: begin
      if ExistingGame.GameState<>gsGreenRoom then begin
        raise
          Exception.Create('Cannot transition game to running state.');
      end;
      //- Trigger change to running state.
      Result := TransitionGameToRunning(ExistingGame,getUsers(AuthToken));
    end;
    gsNextTurn: begin
      raise
        Exception.Create('Not yet implemented.');
    end;
    gsGameOver: begin
      raise
        Exception.Create('Not yet implemented.');
    end;
    else begin
      raise
        Exception.Create('Unknown game state.');
    end;
  end;
end;

procedure TDataModel.UpdateUserPing(const UserID: string);
const
  cSQL = 'UPDATE tbl_users SET LastUpdate=Now() WHERE PKID=:PKID;';
var
  tmpQry: TFDQuery;
begin
  tmpQry := TFDQuery.Create(nil);
  try
    tmpQry.Connection := fConn;
    tmpQry.SQL.Text := cSQL;
    tmpQry.ParamByName('PKID').AsString := UserID;
    tmpQry.ExecSQL;

  finally
    tmpQry.Free;
  end;
end;

procedure TDataModel.UpdateGame(const Game: IGameData);
const
  cSQL = 'UPDATE tbl_games SET GameState=:GameState, CurrentQuestion=:CurrentQuestion, LastUpdate=Now() WHERE PKID=:PKID;';
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Qry.SQL.Text := cSQL;
    Qry.ParamByName('PKID').AsString := Game.SessionID;
    Qry.ParamByName('CurrentQuestion').AsString := Game.CurrentQuestion;
    Qry.ParamByName('GameState').AsInteger := Integer(Game.GameState);
    Qry.ExecSQL;
  finally
    Qry.DisposeOf;
  end;
end;

procedure TDataModel.UpdateUser(const User: IUserData);
const
  cSQL = 'UPDATE tbl_users SET Score=:Score, PlayerState=:PlayerState, LastUpdate=Now() WHERE PKID=:PKID;';
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Qry.SQL.Text := cSQL;
    Qry.ParamByName('PKID').AsString := User.UserID;
    Qry.ParamByName('Score').AsInteger := User.Score;
    Qry.ParamByName('PlayerState').AsInteger := Integer(User.PlayerState);
    Qry.ExecSQL;
  finally
    Qry.DisposeOf;
  end;
end;

procedure TDataModel.getSelectedCard( const GameID: string; const Card: ICardData );
const
  cSelectAnswers = 'SELECT g.PKID ID, g.FKPlayerID UserID, a.str_answer Title FROM tbl_gameanswers g JOIN tbl_answers a ON g.FKAnswerID = a.PKID WHERE state=:state and g.FKGameID=:gameid LIMIT 1;';
var
  tmpQry: TFDQuery;
begin
  tmpQry := TFDQuery.Create(nil);
  try
    tmpQry.Connection := fConn;
    tmpQry.SQL.Text := cSelectAnswers;
    tmpQry.ParamByName('gameid').AsString := GameID;
    tmpQry.ParamByName('state').AsInteger := Integer(TGameCardState.csSelected);
    tmpQry.Active := True;
    tmpQry.First;
    if not tmpQry.EOF then begin
      Card.CardID := tmpQry.FieldByName('ID').AsString;
      Card.Title  := tmpQry.FieldByName('Title').AsString;
      Card.Owner  := tmpQry.FieldByName('UserID').AsString;
    end;
    tmpQry.Active := False;
  finally
    tmpQry.Free;
  end;
end;

procedure TDataModel.getSuggestedAnswers( const GameID: string; const Cards: IList<ICardData> );
const
  cSelectAnswers = 'SELECT g.PKID ID, g.FKPlayerID UserID, a.str_answer Title FROM tbl_gameanswers g JOIN tbl_answers a ON g.FKAnswerID = a.PKID WHERE state=:state and g.FKGameID=:gameid;';
var
  tmpQry: TFDQuery;
  Card: ICardData;
begin
  tmpQry := TFDQuery.Create(nil);
  try
    tmpQry.Connection := fConn;
    tmpQry.SQL.Text := cSelectAnswers;
    tmpQry.ParamByName('gameid').AsString := GameID;
    tmpQry.ParamByName('state').AsInteger := Integer(TGameCardState.csAnswerInPlay);
    tmpQry.Active := True;
    tmpQry.First;
    while not tmpQry.EOF do begin
      Card := TCardData.Create;
      Card.CardID := tmpQry.FieldByName('ID').AsString;
      Card.Title  := tmpQry.FieldByName('Title').AsString;
      Card.Owner  := tmpQry.FieldByName('UserID').AsString;
      Cards.Add(Card);
      tmpQry.Next;
    end;
    tmpQry.Active := False;
  finally
    tmpQry.Free;
  end;
end;

Procedure TDataModel.getQuestion( const QuestionID: string;Const Question : ICardData );
const
  cSelectAnswers = 'SELECT str_question FROM tbl_questions WHERE PKID=:QuestionID;';
var
  tmpQry: TFDQuery;
  Card: ICardData;
begin
  tmpQry := TFDQuery.Create(nil);
  try
    tmpQry.Connection := fConn;
    tmpQry.SQL.Text := cSelectAnswers;
    tmpQry.ParamByName('QuestionID').AsString := QuestionID;
    tmpQry.Active := True;
    tmpQry.First;
    Question.Title  := tmpQry.FieldByName('str_question').AsString;
    Question.CardID := QuestionID;
    tmpQry.Active := False;
  finally
    tmpQry.Free;
  end;
end;

procedure TDataModel.getCards( const GameID: string; const UserID: string; const Cards: IList<ICardData> );
const
  cSelectAnswers = 'SELECT g.PKID ID, a.str_answer Title FROM tbl_gameanswers g JOIN tbl_answers a ON g.FKAnswerID = a.PKID WHERE state=:state and g.FKGameID=:gameid and g.FKPlayerID=:userid;';
var
  tmpQry: TFDQuery;
  Card: ICardData;
begin
  tmpQry := TFDQuery.Create(nil);
  try
    tmpQry.Connection := fConn;
    tmpQry.SQL.Text := cSelectAnswers;
    tmpQry.ParamByName('gameid').AsString := GameID;
    tmpQry.ParamByName('userid').AsString := UserID;
    tmpQry.ParamByName('state').AsInteger := Integer(TGameCardState.csInHand);
    tmpQry.Active := True;
    tmpQry.First;
    while not tmpQry.EOF do begin
      Card := TCardData.Create;
      Card.CardID := tmpQry.FieldByName('ID').AsString;
      Card.Title := tmpQry.FieldByName('Title').AsString;
      Cards.Add(Card);
      tmpQry.Next;
    end;
    tmpQry.Active := False;
  finally
    tmpQry.Free;
  end;
end;

function TDataModel.getCurrentTurn(AuthToken: string): ITurnData;
var
  GameID: string;
  Game: IGameData;
  Users: IList<IUserData>;
  User: IUserData;
  IsJudge: boolean;
  idx: nativeuint;
  Card : ICardData;
begin
  GameID := getGameIDByUserID(AuthToken);
  Game := FindGameByID(GameID);
  Users := getUsers(AuthToken);
  IsJudge := False;
  for idx := 0 to pred(Users.Count) do begin
    User := Users[idx];
    if (User.UserID=AuthToken) then begin
      if User.PlayerState=TPlayerState.psJudgeWaitingForSubmit then begin
        IsJudge := True;
      end;
      break;
    end;
  end;
  Result := TTurnData.Create;
  getQuestion( Game.CurrentQuestion,Result.Question );
  getSelectedCard( Game.SessionID, Result.Selection);

  getSuggestedAnswers( Game.SessionID, Result.Answers );
  if not IsJudge
    then begin
           getCards( Game.SessionID, User.UserID, Result.Cards );
         end
    else begin
           for idx := 0 to Pred(Users.Count) do
             begin
               Card := TCardData.Create;
               Result.Cards.Add(Card);
             end;
         end;
end;

function TDataModel.GetGameByUserID(const UserID: string): IGameData;
begin
  Result :=  FindGameByID(getGameIDByUserID(UserID));
end;

function TDataModel.getGameIDByUserID(const Key: string): string;
const
  cSQL = 'SELECT FKGameID from tbl_users where (PKID=:Key);';
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    Qry.SQL.Text := cSQL;
    Qry.ParamByName('Key').AsString := Key;
    Qry.Active := True;
    if Qry.RowsAffected<1 then begin
      raise
        Exception.Create('Failed to locate game by provided user ID: '+Key);
    end;
    Qry.First;
    Result := Qry.FieldByName('FKGameID').AsString;
    Qry.Active := False;
  finally
    Qry.DisposeOf;
  end;
end;

function TDataModel.getUsers(const Key: string): IList<IUserData>;
const
  cSQL = 'SELECT * FROM tbl_users WHERE FKGameID=:GameID;';
var
  NewUserData: IUserData;
  GameID: string;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := fConn;
    GameID := getGameIDByUserID(Key);
    Result := TList<IUserData>.Create;
    Qry.SQL.Text := cSQL;
    Qry.ParamByName('GameID').AsString := GameID;
    Qry.Active := true;
    Qry.First;
    while not Qry.EOF do begin
      NewUserData := TUserData.Create();
      QueryToUserData( Qry, NewUserData );
      Result.Add( NewUserData );
      Qry.Next;
    end;
  finally
    Qry.DisposeOf;
  end;
end;


end.
