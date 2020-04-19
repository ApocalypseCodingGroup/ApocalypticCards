unit WebMainModel;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp;

type
  TWebModule4 = class(TWebModule)
    procedure WebModule4wactGamesAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4wactUsersAction(Sender: TObject; Request: TWebRequest;
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
    procedure(Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.CreateGame( Request.Content );
    end,

    // Read
    procedure(Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.getPublicGames;
    end,

    // Update
    nil,

    // Delete
    nil
  );
end;

procedure TWebModule4.WebModule4wactUsersAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  TGameRequest.HandleRequest( Request, Response, Handled,

    // Create
    procedure(Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.JoinGame( Request.Content );
    end,

    // Read
    procedure(Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    var
      index: integer;
      utFieldName: string;
      Found: boolean;
      SearchKey: string;
    begin
      Found := False;
      for index := 0 to pred( Request.QueryFields.Count ) do begin
        utFieldName := Uppercase(Trim(Request.QueryFields.Names[index]));
        if (utFieldName='GAMEID') or (utFieldName='USERID') then begin
          SearchKey := Request.QueryFields.Values[Request.QueryFields.Names[index]];
          Found := True;
          break;
        end;
      end;
      if not Found then begin
        raise
          Exception.Create('Missing parameter: Require at least GameID or UserID');
      end;
      Response.Content := ViewModel.getUsersByGameIDOrUserID(SearchKey);
    end,

    // Update
    nil,

    // Delete
    nil
  );

end;

end.
