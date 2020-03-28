unit GifMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Net.URLClient, System.Net.HttpClient, FMX.GifUtils,
  System.Net.HttpClientComponent, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Edit, FMX.Objects, FMX.Ani, FMX.WebBrowser;

type
  TForm13 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    NetHTTPRequest1: TNetHTTPRequest;
    NetHTTPClient1: TNetHTTPClient;
    Image1: TImage;
    BitmapAnimation1: TBitmapAnimation;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    gifPlayer: TGifPlayer;
  public
    { Public declarations }
  end;

var
  Form13: TForm13;

implementation

{$R *.fmx}

procedure TForm13.FormDestroy(Sender: TObject);
begin
  gifPlayer.Destroy;
end;

procedure TForm13.FormCreate(Sender: TObject);
begin
  gifPlayer := TGifPlayer.Create(nil);
  gifPlayer.Image := Image1;
end;

procedure TForm13.Button1Click(Sender: TObject);
var
  gifStrm: TMemoryStream;
begin
  gifStrm := TMemoryStream.Create;
  try
    NetHTTPRequest1.Get(Edit1.Text, gifStrm);
    gifStrm.Seek(0,soBeginning);
    image1.Bitmap.LoadFromStream(gifStrm);
    gifStrm.Seek(0,soBeginning);
    gifPlayer.LoadFromStream(gifStrm);
    gifPlayer.Play;
  finally
    gifStrm.Free;
  end;
end;

end.
