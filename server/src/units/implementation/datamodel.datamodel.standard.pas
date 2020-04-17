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
    NewGameData.SessionID   := fqry.FieldByName('PKID').AsString;
    NewGameData.SessionName := fqry.FieldByName('SessionName').AsString;
    NewGameData.LangID      := fqry.FieldByName('LangID').AsString;
    NewGameData.MinUser     := fqry.FieldByName('MinUser').AsInteger;
    NewGameData.MaxUser     := fqry.FieldByName('MaxUser').AsInteger;
    Result.Add( NewGameData );
    fQry.Next;
  end;
end;

end.
