unit Frames.Home;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects;

type
  THomeFrame = class(TFrame)
    CreateGameButton: TButton;
    JoinGameButton: TButton;
    Layout1: TLayout;
    BackgroundImage: TImage;
    procedure CreateGameButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OnCreateGameClick: TProc;
  end;

implementation

{$R *.fmx}

procedure THomeFrame.CreateGameButtonClick(Sender: TObject);
begin
  if Assigned(OnCreateGameClick) then
    OnCreateGameClick();
end;

end.
