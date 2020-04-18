program FMXClientProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  Forms.Main in 'Forms.Main.pas' {MainForm},
  Data.Remote in 'Data.Remote.pas' {RemoteData: TDataModule},
  Frames.CreateGame in 'Frames.CreateGame.pas' {CreateGameFrame: TFrame},
  Frames.Home in 'Frames.Home.pas' {HomeFrame: TFrame},
  Data.Main in 'Data.Main.pas' {MainData: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TRemoteData, RemoteData);
  Application.CreateForm(TMainData, MainData);
  Application.Run;
end.
