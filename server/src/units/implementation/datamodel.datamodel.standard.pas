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
    fConn: TFDConnection;
    fQry: TFDQuery;
    procedure QueryToGameData(const Qry: TFDQuery; const GameData: IGameData);
    procedure QueryToUserData(const Qry: TFDQuery; const UserData: IUserData; const IncludeUID: boolean = FALSE);
    function AddFirstUserToGame(const GameID, UserID: string): boolean;
    function IsCurrentUser(const UserID, GameID: string): boolean;
  strict private
    function getGames: IList<IGameData>;
    function CreateGame(const GameData: IGameData) : boolean;
    function FindGameByID(const GameID: string): IGameData;
    function FindGameByPassword(const Password: string): IGameData;
    procedure CreateUser(const NewUser: IUserData);
    function getUsersByGameIDOrUserID(const Key: string): IList<IUserData>;
  public
    constructor Create; reintroduce;
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
  cDatabaseIni = '/var/www/apocalypse/https/private/cardgame.ini';
  {$endif}

function TDataModel.AddFirstUserToGame(const GameID: string; const UserID: string): boolean;
const
  cSQL = 'UPDATE tbl_games SET CurrentUser=:UserID, LastUpdate=:LastUpdate WHERE (PKID=:GameID) and (CurrentUser is NULL)';
begin
  fQry.SQL.Text := cSQL;
  fQry.ParamByName('LastUpdate').AsDateTime := Now;
  fQry.ParamByName('UserID').AsString := UserID;
  fQry.ParamByName('GameID').AsString := GameID;
  fQry.ExecSQL;
  Result := fQry.RowsAffected=1;
  if fQry.RowsAffected>1 then begin
    raise
      Exception.Create('Ooops, It looks as though the database has become corrupt. Blame the developers');
  end;
end;

procedure TDataModel.CreateUser(const NewUser: IUserData);
const
  cSQL = 'INSERT into tbl_users (PKID, FKGameID, Name) values (:PKID, :FKGameID, :Name);';
begin
  fQry.SQL.Text := cSQL;
  fQry.ParamByName('PKID').AsString := NewUser.UserID;
  fQry.ParamByName('FKGameID').AsString := NewUser.GameID;
  fQry.ParamByName('Name').AsString := NewUser.Name;
  fQry.ExecSQL;
  NewUser.IsCurrentUser := AddFirstUserToGame(NewUser.GameID,NewUser.UserID);
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
  fQry := TFDQuery.Create(nil);
  fQry.Connection := fConn;
end;

function TDataModel.CreateGame(const GameData: IGameData): boolean;
const
  cSQL = 'insert into tbl_games (PkId,Running,SessionName,LangId,MinUser,MaxUser,LastUpdate) values ( :PkId, :Running, :SessionName, :LangId, :MinUser, :MaxUser, :LastUpdate );';
begin
  fQry.SQL.Text := cSQL;
  fQry.Params.ParamByName('PkId').AsString := GameData.SessionID;
  if GameData.Running then begin
    fQry.Params.ParamByName('Running').AsInteger := 1;
  end else begin
    fQry.Params.ParamByName('Running').AsInteger := 0;
  end;
  fQry.Params.ParamByName('SessionName').AsString := GameData.SessionName;
  fQry.Params.ParamByName('LangId').AsString := GameData.LangID;
  fQry.Params.ParamByName('MinUser').AsInteger := GameData.MinUser;
  fQry.Params.ParamByName('MaxUser').AsInteger := GameData.MaxUser;
  fQry.Params.ParamByName('LastUpdate').AsDateTime := Now;
  fQry.ExecSQL;
  Result := fQry.RowsAffected=1;
end;

function TDataModel.FindGameByID(const GameID: string): IGameData;
const
  cSQL = 'SELECT * FROM tbl_games WHERE PKID=:SessionID;';
begin
  Result := nil;
  fQry.SQL.Text := cSQL;
  fQry.ParamByName('SessionID').AsString := GameID;
  fQry.Active := true;
  if fQry.RowsAffected>1 then begin
    raise
      Exception.Create('Requested game session id matches more than one game.');
  end;
  fQry.First;
  Result := TGameData.Create;
  QueryToGamedata( fQry, Result );
end;

function TDataModel.FindGameByPassword(const Password: string): IGameData;
const
  cSQL = 'SELECT * FROM tbl_games WHERE SessionPW=:SessionPW;';
begin
  Result := nil;
  fQry.SQL.Text := cSQL;
  fQry.ParamByName('SessionPW').AsString := Password;
  fQry.Active := true;
  if fQry.RowsAffected>1 then begin
    raise
      Exception.Create('Requested game session password matches more than one game.');
  end;
  fQry.First;
  Result := TGameData.Create;
  QueryToGamedata( fQry, Result );
end;

procedure TDataModel.QueryToGameData( const Qry: TFDQuery; const GameData: IGameData );
begin
  { TODO : Need to correct fields included in this method. }
  GameData.SessionID   := Qry.FieldByName('PkId').AsString;
  GameData.SessionName := Qry.FieldByName('SessionName').AsString;
  GameData.LangID      := Qry.FieldByName('LangID').AsString;
  GameData.MinUser     := Qry.FieldByName('MinUser').AsInteger;
  GameData.MaxUser     := Qry.FieldByName('MaxUser').AsInteger;
  GameData.Running     := Qry.FieldByName('Running').AsBoolean;
end;

function TDataModel.getGames: IList<IGameData>;
const
  cSQL = 'SELECT * from tbl_games;';
var
  NewGameData: IGameData;
begin
  Result := TList<IGameData>.Create;
  fQry.SQL.Text := cSQL;
  fQry.Active := true;
  fQry.First;
  while not fQry.EOF do begin
    NewGameData := TGameData.Create();
    QueryToGameData( fQry, NewGameData );
    Result.Add( NewGameData );
    fQry.Next;
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

procedure TDataModel.QueryToUserData( const Qry: TFDQuery; const UserData: IUserData; const IncludeUID: boolean = FALSE );
begin
  UserData.GameID := Qry.FieldByName('FKGameID').AsString;
  UserData.Name   := Qry.FieldByName('Name').AsString;
  UserData.UserID := Qry.FieldByName('PKID').AsString;
  UserData.IsCurrentUser := IsCurrentUser( UserData.UserID, UserData.GameID );
  if not IncludeUID then begin
    UserData.UserID := '';
  end;
end;

function TDataModel.getUsersByGameIDOrUserID(const Key: string): IList<IUserData>;
const
  cSQL = 'SELECT * from tbl_users where ((PKID=:Key) or (FKGameID=:Key));';
var
  NewUserData: IUserData;
begin
  Result := TList<IUserData>.Create;
  fQry.SQL.Text := cSQL;
  fQry.ParamByName('Key').AsString := Key;
  fQry.Active := true;
  fQry.First;
  while not fQry.EOF do begin
    NewUserData := TUserData.Create();
    QueryToUserData( fQry, NewUserData, FALSE );
    Result.Add( NewUserData );
    fQry.Next;
  end;
end;


end.
