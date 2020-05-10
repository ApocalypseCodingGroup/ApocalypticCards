program ApoCards;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main.View in 'Main.View.pas' {MainView},
  Game.Interfaces in 'Game.Interfaces.pas',
  Game.Model in 'Game.Model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
