unit Frames.Submitting;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation
, SubjectStand, FrameStand
;

type
  TSubmittingFrame = class(TFrame)
    Label1: TLabel;
    Label2: TLabel;
  private
  public
    procedure AfterConstruction; override;

    [BeforeShow]
    procedure FrameShow;
  end;

implementation

{$R *.fmx}

uses
  System.Messaging, Utils.Messages, Data.Main, Data.Remote
, CodeSiteLogging
;

{ TSubmittingFrame }

procedure TSubmittingFrame.AfterConstruction;
begin
  inherited;

  TTurnDataChanged.Subscribe(
    procedure(const Sender: TObject; const M: TMessage)
    begin
      CodeSite.SendMsg('Submitting frame: turndata changed');
      Label2.Text := MainData.TurnData.Question.Title;
    end
  );

end;

procedure TSubmittingFrame.FrameShow;
begin
  CodeSite.SendMsg('Submitting frame on show');
  RemoteData.RetrieveTurnData(nil, nil);
end;

end.
