program PlayRemoteGIF;

uses
  System.StartUpCopy,
  FMX.Forms,
  GifMain in 'GifMain.pas' {Form13},
  FMX.GifUtils in 'FMX.GifUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm13, Form13);
  Application.Run;
end.
