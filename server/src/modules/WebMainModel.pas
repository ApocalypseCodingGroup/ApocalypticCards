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

end.
