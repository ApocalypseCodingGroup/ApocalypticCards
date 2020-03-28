unit WebMainModel;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp;

type
  TWebModule4 = class(TWebModule)
    procedure WebModule4DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  WebModuleClass: TComponentClass = TWebModule4;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TWebModule4.WebModule4DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content :=
    '<html>' +
    '<head><title>Webserver-Anwendung</title></head>' +
    '<body>Webserver-Anwendung</body>' +
    '</html>';
end;

end.
