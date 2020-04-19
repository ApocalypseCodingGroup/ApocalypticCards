unit Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, SubjectStand, FrameStand,
  Frames.CreateGame, Frames.Home, Utils.Messages;

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

uses System.Messaging, Data.Main, System.Rtti;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // subscribe to changes to CurrentView
  TMessageManager.DefaultManager.SubscribeToMessage(
    TCurrentViewChanged
  , procedure(const Sender: TObject; const M: TMessage)
    var
      LCurrentView: TAppView;
    begin
      LCurrentView := (M as TCurrentViewChanged).Value;
      case LCurrentView of
        Home       : begin
          FrameStand1.New<THomeFrame>(MainContentLayout).Show;
        end;
        CreateGame : begin
          FrameStand1.New<TCreateGameFrame>(MainContentLayout, 'solidBackground').Show;
        end;
      end;

      CurrentViewLabel.Text := TRttiEnumerationType.GetName<TAppView>(LCurrentView);
    end
  );


  // Init the application
  MainData.CurrentView := Home;
end;

end.
