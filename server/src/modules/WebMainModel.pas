unit WebMainModel;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, Web.HTTPProd,
  FireDAC.VCLUI.Wait;

type
  TWebModule4 = class(TWebModule)
    conn: TFDConnection;
    procedure WebModule4wactGamesAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  end;

var
  WebModuleClass: TComponentClass = TWebModule4;

implementation

Uses
  MariaDB
, Requests
;
const
  {$ifdef DEBUG}
  cDatabaseIni = '';
  {$else}
  cDatabaseIni = '/var/www/apocalypse/https/private/cardgame.ini';
  {$endif}

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TWebModule4.WebModule4DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content :=
    '<html>' +
    '<head><title>Apocalypse Card Game</title></head>' +
    '<body>'+
    '<h1><a href="'+BaseURL+'/startnew">Start Game</a></h1>'+
    '<h1><a href="'+BaseURL+'/joingame">Join Game</a></h1>'+
    '</body>'+
    '</html>';
end;

procedure TWebModule4.WebModule4JoinGameAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  lWebCall : ICardgame;
begin

  Response.Content :=
    '<html>' +
    '<head><title>Apocalypse Card Game</title></head>' +
    '<body>'+
    '<h1>JOIN</h1>'+
    '</body>'+
    '</html>';
end;

//- Comment to see why is this not going into repo
procedure TWebModule4.WebModule4wactGamesAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  TGameRequest.HandleRequest( Request, Response, Handled,

    // Create
    procedure(Response: TWebResponse; var Handled: Boolean; const aWebCall: ICardgame)
    var
      Str: string;
    begin
      if aWebCall.Create_Games( Str, Request.Content ) then begin
        Response.Content := Str;
      end else begin
        TGameRequest.PrepareException( Response, Str );
      end;
    end,

    // Read
    procedure(Response: TWebResponse; var Handled: Boolean; const aWebCall: ICardgame)
    var
      Str: string;
    begin
      if aWebCall.Read_Games( Str ) then begin
        Response.Content := Str;
      end else begin
        TGameRequest.PrepareException( Response, Str );
      end;
    end,

    // Update
    nil,

    // Delete
    nil
  );
end;

end.
