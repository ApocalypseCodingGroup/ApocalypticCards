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
    procedure QueryToGameData(const Qry: TFDQuery; var GameData: IGameData);
  strict private
    function getGames: IList<IGameData>;
    function CreateGame(const GameData: IGameData) : boolean;
    function FindGameByID(const GameID: string): IGameData;
    function FindGameByPassword(const Password: string): IGameData;
    procedure CreateUser(const NewUser: IUserData);
  public
    constructor Create; reintroduce;
  end;

implementation
uses
  Classes
, SysUtils
, cwCollections.Standard
, DataModel.GameData.Standard
;

const
  {$ifdef DEBUG}
  cDatabaseIni = '.\cardgame.ini';
  {$else}
  cDatabaseIni = '/var/www/apocalypse/https/private/cardgame.ini';
  {$endif}

procedure TDataModel.CreateUser(const NewUser: IUserData);
begin

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
  cSQL = 'insert into tbl_games (PkId,Running,SessionName,LangId,MinUser,MaxUser) values ( :PkId, :Running, :SessionName, :LangId, :MinUser, :MaxUser );';
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

procedure TDataModel.QueryToGameData( const Qry: TFDQuery; var GameData: IGameData );
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


end.
