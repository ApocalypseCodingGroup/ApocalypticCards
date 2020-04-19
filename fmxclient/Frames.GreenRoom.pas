unit Frames.GreenRoom;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FrameStand, SubjectStand;

type
  TGreenRoomFrame = class(TFrame)
    WaitLayout: TLayout;
    WaitMessageLabel: TLabel;
    CodeOrHostLayout: TLayout;
    CodeOrHostLabel: TLabel;
  private
  public
    [BeforeShow]
    procedure FrameOnShow;
  end;

implementation

{$R *.fmx}

uses Data.Main;

{ TGreenRoomFrame }

procedure TGreenRoomFrame.FrameOnShow;
var
  LPassword: string;
begin
  LPassword := MainData.CurrentGame.SessionPassword;
  if LPassword <> '' then
    CodeOrHostLabel.Text := 'Give out your game code: ' + QuotedStr(LPassword)
  else
    CodeOrHostLabel.Visible := False;
end;

end.
