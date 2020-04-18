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
  strict private
    function getGames: IList<IGameData>;
    function CreateGame(const GameData: IGameData) : boolean;
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

constructor TDataModel.Create;
var
  Credentials: Classes.TStringList;
begin
  inherited Create;
  fConn := TFDConnection.Create(nil);
  fConn.Params.DriverID := 'MySQL';
  fConn.Params.Add('Server=127.0.0.1');
  Credentials := Classes.TStringList.Create;
  try
    if not FileExists(cDatabaseIni) then begin
      raise
        Exception.Create('The credentials configuration is missing.');
    end;
    Credentials.LoadFromFile(cDatabaseIni);
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
  cSQL = 'insert into tbl_gamebase (PkId,Running,SessionName,LangId,MinUser,MaxUser) values ( :PkId, :Running, :SessionName, :LangId, :MinUser, :MaxUser );';
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

function TDataModel.getGames: IList<IGameData>;
const
  cSQL = 'SELECT * from tbl_gamebase;';
var
  NewGameData: IGameData;
begin
  { TODO : Need to correct fields included in this method. }
  Result := TList<IGameData>.Create;
  fQry.SQL.Text := cSQL;
  fQry.Active := true;
  fQry.First;
  while not fQry.EOF do begin
    NewGameData := TGameData.Create();
    NewGameData.SessionID   := fQry.FieldByName('PkId').AsString;
    NewGameData.SessionName := fQry.FieldByName('SessionName').AsString;
    NewGameData.LangID      := fQry.FieldByName('LangID').AsString;
    NewGameData.MinUser     := fQry.FieldByName('MinUser').AsInteger;
    NewGameData.MaxUser     := fQry.FieldByName('MaxUser').AsInteger;
    NewGameData.Running     := fQry.FieldByName('Running').AsBoolean;
    Result.Add( NewGameData );
    fQry.Next;
  end;
end;


end.
