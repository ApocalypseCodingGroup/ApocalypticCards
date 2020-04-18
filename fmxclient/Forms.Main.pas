unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, SubjectStand, FrameStand,
  Frames.CreateGame, Frames.Home;

type
  TMainForm = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    MainContentLayout: TLayout;
    FrameStand1: TFrameStand;
    Stands: TStyleBook;
    procedure FormCreate(Sender: TObject);
  private
    FHomeFI: TFrameInfo<THomeFrame>;
    FCreateGameFI: TFrameInfo<TCreateGameFrame>;
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FHomeFI := FrameStand1.New<THomeFrame>(MainContentLayout);

  FHomeFI.Frame.OnCreateGameClick :=
    procedure
    begin
      FCreateGameFI := FrameStand1.New<TCreateGameFrame>(MainContentLayout, 'solidBackground');
      FCreateGameFI.Show;
    end;

  FHomeFI.Show();
end;

end.
