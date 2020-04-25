unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, SubjectStand, FrameStand
, Frames.CreateGame, Frames.Home, Frames.GreenRoom
, Utils.Messages
;

type
  TMainForm = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    MainContentLayout: TLayout;
    FrameStand1: TFrameStand;
    Stands: TStyleBook;
    CurrentViewLabel: TLabel;
    procedure FormCreate(Sender: TObject);
  private
//    FHomeFI: TFrameInfo<THomeFrame>;
//    FCreateGameFI: TFrameInfo<TCreateGameFrame>;
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses Data.Main, System.Rtti, System.Messaging, Frames.JoinGame;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TCurrentViewChanged.Subscribe(
    procedure(const Sender: TObject; const M: TMessage)
    var
      LCurrentView: TAppView;
    begin
      LCurrentView := (M as TCurrentViewChanged).Value;
      case LCurrentView of
        Home       : begin
          FrameStand1.New<THomeFrame>(MainContentLayout, 'apocalypseBackground').Show;
        end;
        CreateGame : begin
          FrameStand1.New<TCreateGameFrame>(MainContentLayout, 'solidBackground').Show;
        end;
        GreenRoom : begin
          FrameStand1.New<TGreenRoomFrame>(MainContentLayout, 'solidBackground').Show;
        end;
        JoinGame : begin
          FrameStand1.New<TJoinFrame>(MainContentLayout, 'solidBackground').Show;
        end;

      end;

      CurrentViewLabel.Text := TRttiEnumerationType.GetName<TAppView>(LCurrentView);
    end
  );


  // Init the application
  MainData.CurrentView := Home;
end;

end.
