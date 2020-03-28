unit MariaDB;

interface

Uses
  Dek
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

Type
  TMariaDB = Class(TInterfacedObject,IDataBase)
    strict private
      Function CreateNewGame(Const aSessionID : String;out Error : String) : boolean;
      Function JoinGame(Const aSessionID,aUserName : String;out Token, Error : String) : boolean;
    private
      fConn: TFDConnection;
      fQry: TFDQuery;
    public
      Constructor Create; reintroduce;
      Destructor Destroy; override;
      Class Function Construct : IDataBase;
  end;

implementation
uses
  SysUtils
, Classes
;

{ TMariaDB }
const
  {$ifdef DEBUG}
  cDatabaseIni = '';
  {$else}
  cDatabaseIni = '/var/www/apocalypse/https/private/cardgame.ini';
  {$endif}

class function TMariaDB.Construct: IDataBase;
begin
  Result := TMariaDB.Create;
end;

constructor TMariaDB.Create;
var
  Credentials: TStringList;
begin
  inherited Create;
  fConn := TFDConnection.Create(nil);
  fConn.Params.DriverID := 'MySQL';
  fConn.Params.Add('Server=127.0.0.1');
  Credentials := TStringList.Create;
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

function TMariaDB.CreateNewGame(const aSessionID: String; out Error: String): boolean;
begin
  Result := False;
  Error := '';
  fQry.SQL.Text := 'SELECT * from test;';
  fQry.Active := True;
  if not fQry.Active then begin
    Error := 'Your query was stoopid';
    exit;
  end;
  fQry.First;
  while not fQry.EOF do begin
    Error := Error + fQry.FieldByName('int_test').AsString + ':';
    fQry.Next;
  end;
  exit;
  Error := 'Not Implemented';
  Result := false;
end;

destructor TMariaDB.Destroy;
begin
  fQry.DisposeOf;
  fConn.DisposeOf;
  inherited Destroy;
end;

function TMariaDB.JoinGame(const aSessionID, aUserName: String; out Token, Error: String): boolean;
begin
  Error := 'Not Implemented';
  result := false;
end;

end.
