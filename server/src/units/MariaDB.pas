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


type
  TMariaDB = Class(TInterfacedObject,IDataBase)
    strict private
      Function CreateNewGame(Const aSessionID : String;out Error : String) : boolean;
      Function JoinGame(Const aSessionID,aUserName : String;out Token, Error : String) : boolean;
      function ReadGames( out Response: string ): boolean;
    private
      class function QueryToJSON( const Qry: TFDQuery; const RequestedFields: TArrayOfString; out Response: string ): boolean; static;
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
, StrUtils
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
    {$ifdef DEBUG}
    fConn.Params.Database := 'apocalypticcards';
    fConn.Params.UserName := 'root';
    fConn.Params.Password := 'TestingDatabase';
    {$else}
    if not FileExists(cDatabaseIni) then begin
      raise
        Exception.Create('The credentials configuration is missing.');
    end;
    Credentials.LoadFromFile(cDatabaseIni);
    fConn.Params.Database := Credentials.Values['database'];
    fConn.Params.UserName := Credentials.Values['username'];
    fConn.Params.Password := Credentials.Values['password'];
    {$endif}
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

class function TMariaDB.QueryToJSON(const Qry: TFDQuery; const RequestedFields: TArrayOfString; out Response: string): boolean;
var
  Field: TField;
  FieldIndex: integer;
begin
  Result := False;
  Qry.First;
  Response := '[';
  while not Qry.EOF do begin
    Response := Response + '{';
    for FieldIndex := 0 to pred(Length(RequestedFields)) do begin
      Field := Qry.FieldByName(RequestedFields[FieldIndex]);
      if not assigned(Field) then begin
        exit;
      end;
      Response := Response + '"' + RequestedFields[FieldIndex] + '"';
      if Field.DataType in
        [ ftSmallint, ftInteger, ftFloat,
          ftCurrency, ftBCD, ftLargeint,
          ftLongWord, ftShortint, ftByte, ftExtended,
          ftSingle ] then begin
        Response := Response + ': ' + Field.AsString;
      end else begin
        Response := Response + ': "' + Field.AsString + '"';
      end;
    end;
    Response := Response + '},';
    Qry.Next;
  end;
  Response := LeftStr( Response, pred(Length(Response)) ); //- remove trialing comma
  Response := Response + ']';
  Result := True;
end;

function TMariaDB.ReadGames(out Response: string): boolean;
const
  cSQL = 'SELECT * from tbl_questions';
begin
  Result := False;
  Response := '';
  fQry.SQL.Text := cSQL;
  fQry.Active := True;
  if not QueryToJSON( fQry, ['str_question'], Response ) then begin
    exit;
  end;
  Result := True;
end;

end.

API/
- Show list of active sessions!
// Button Start New Game
// Client ask for UserSessionName and perhaps PW (if closed group)
//        ask min and max user
API/startjson?SessionID="hGASjsd6"&SessionName="Franks Game"&SessionPW=""&MinUser=4&MaxUser=6
// Result is {SessionID:"hGASjsd6"}
// new Entry in Gamebase

DROP TABLE IF EXISTS `developer`.`gamebase`;
CREATE TABLE  `developer`.`gamebase` (
  `PKID` VARCHAR(10) unsigned NOT NULL AUTO_INCREMENT,
  `Running` tinyint(1) NOT NULL,
  `SessionID` varchar(8) NOT NULL,
  `SessionName` varchar(45) NOT NULL,
  `SessionPW` varchar(45) NOT NULL,
  `LangID` varchar(2) NOT NULL,
  `MinUser` int(10) unsigned NOT NULL,
  `MaxUser` int(10) unsigned NOT NULL,
  `Position_In_QDeck` int(10) unsigned NOT NULL,
  `Position_In_ADeck` int(10) unsigned NOT NULL,
  `Act_Master` varchar(45) NOT NULL,
  `Acc_QDeckID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

API/Run?SessionID="hGASjsd6"
// Question and Answer DESK is created with SessionID shuffled
// Session set to Running
// Assign 10 Cards to All Users
// Result should be the First Quetion for Display. (Acc_QDeckID)

DROP TABLE IF EXISTS `developer`.`questionbase`;
CREATE TABLE  `developer`.`questionbase` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `URL` tinyint(1) NOT NULL,
  `Question` varchar(250) NOT NULL,
  `LangID` varchar(2) NOT NULL,
  `MinAnswerCards` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `developer`.`answerbase`;
CREATE TABLE  `developer`.`answerbase` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `URL` tinyint(1) NOT NULL,
  `Answer` varchar(250) NOT NULL,
  `LangID` varchar(2) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `developer`.`deckQbase`;
CREATE TABLE  `developer`.`deckbase` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SessionID` varchar(8) NOT NULL,
  `Quertion` int(10) unsigned NOT NULL,  // Pointer to QuetionBaseID
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `developer`.`deckAbase`;
CREATE TABLE  `developer`.`deckbase` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SessionID` varchar(8) NOT NULL,
  `Answer` int(10) unsigned NOT NULL,  // Pointer to AnswerBaseID
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

API/JoinGame?SessionID="hGASjsd6"&SessionName="Glenn"&SessionPW=""
// Result UserToken
API/ClickCard?SessionID="hGASjsd6"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&CardNr=2
API/ClickCard?SessionID="hGASjsd6"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&CardNr=4
API/ClickCard?SessionID="hGASjsd6"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&CardNr=2
API/ClickCard?SessionID="hGASjsd6"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&CardNr=6
// Result Selected_1=2
// Result Selected_2=4                            {EAC84404-8A36-4839-ADE0-BE9B14278315}
// Result Selected_1=-1
// Result Selected_1=6

API/Pullanswers?SessionID="hGASjsd6"&MasterToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"
// Result Not Ready | Selection Result from all Users
API/FinalPull?SessionID="hGASjsd6"&MasterToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"
// Selection Result from all Users that have done the selection in time

// Show results to Master

API/SelectResult?SessionID="hGASjsd6"&MasterToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"
// Collect Points
// Redraw from deck
// Select next Master

DROP TABLE IF EXISTS `developer`.`userbase`;
CREATE TABLE  `developer`.`userbase` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SessionID` varchar(8) NOT NULL,
  `UserToken` varchar(42) DEFAULT NULL,
  `Name` varchar(64) DEFAULT NULL,
  `Points` int(10) unsigned NOT NULL,
  `Card_0` int(10) unsigned NOT NULL,
  `Card_1` int(10) unsigned NOT NULL,
  `Card_2` int(10) unsigned NOT NULL,
  `Card_3` int(10) unsigned NOT NULL,
  `Card_4` int(10) unsigned NOT NULL,
  `Card_5` int(10) unsigned NOT NULL,
  `Card_6` int(10) unsigned NOT NULL,
  `Card_7` int(10) unsigned NOT NULL,
  `Selected_1` int(10) unsigned NOT NULL,
  `Selected_2` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;


