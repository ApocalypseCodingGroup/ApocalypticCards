unit WebMainModel;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp;

type
  TWebModule4 = class(TWebModule)
    procedure WebModule4wactGamesAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4wactUsersAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4wactTurnAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  end;

var
  WebModuleClass: TComponentClass = TWebModule4;

implementation
Uses
  Requests
, ViewModel
;
{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TWebModule4.WebModule4wactGamesAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  TGameRequest.HandleRequest( Request, Response, Handled,

    // Create
    procedure(const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.CreateGame( Request.Content );
    end,

    // Read
    procedure(const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.getPublicGames;
    end,

    // Update
    procedure(const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.setGameState( AuthToken, Request.Content );
    end,


    // Delete
    nil
  );
end;

procedure TWebModule4.WebModule4wactTurnAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  TGameRequest.HandleRequest( Request, Response, Handled,

    // Create
    nil,

    // Read
    procedure(const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
     Response.Content := ViewModel.getCurrentTurn( AuthToken );
    end,

    // Update
    procedure(const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin

    end,

    // Delete
    nil
  );

end;

procedure TWebModule4.WebModule4wactUsersAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  TGameRequest.HandleRequest( Request, Response, Handled,

    // Create
    procedure(const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.JoinGame( Request.Content );
    end,

    // Read
    procedure(const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.getUsers(AuthToken);
    end,

    // Update
    nil,

    // Delete
    nil
  );

end;

end.
