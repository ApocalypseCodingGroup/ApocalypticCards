unit WebMainModel;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp;

type
  TWebModule4 = class(TWebModule)
    procedure WebModule4DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4StartGameAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4JoinGameAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4RESTStartGameAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4RESTJoinGameAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  WebModuleClass: TComponentClass = TWebModule4;

implementation

Uses
  Dek
, GameService
, MariaDB
;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TWebModule4.WebModule4DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
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
  lWebCall := TCardGameWeb.Create(TMariaDB.Construct);

  Response.Content :=
    '<html>' +
    '<head><title>Apocalypse Card Game</title></head>' +
    '<body>'+
    '<h1>JOIN</h1>'+
    '</body>'+
    '</html>';
end;

procedure TWebModule4.WebModule4RESTJoinGameAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  lWebCall : ICardgame;
begin
  lWebCall := TCardGameJSON.Create(TMariaDB.Construct);
  Response.Content := lWebCall.JoinSession(Request.QueryFields.Values['SessionID'],Request.QueryFields.Values['User']);
end;

procedure TWebModule4.WebModule4RESTStartGameAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  lWebCall : ICardgame;
begin
  lWebCall         := TCardGameJSON.Create(TMariaDB.Construct);
  Response.Content := lWebCall.CreateNewSessionKey;
end;

procedure TWebModule4.WebModule4StartGameAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  lWebCall : ICardgame;
begin
  lWebCall := TCardGameWeb.Create(TMariaDB.Construct);

  Response.Content :=
    '<html>' +
    '<head><title>Apocalypse Card Game</title></head>' +
    '<body>'+
    '<h1>New Game : Your ID ('+lWebCall.CreateNewSessionKey+')!</h1>'+
    '</body>'+
    '</html>';
end;

end.
