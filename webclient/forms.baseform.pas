unit forms.baseform;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.Controls, WEBLib.ExtCtrls;

type
  TBaseForm = class(TWebForm)
    BaseCenterPanel: TWebPanel;
    procedure WebFormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BaseForm: TBaseForm;

implementation

{$R *.dfm}

procedure TBaseForm.WebFormResize(Sender: TObject);
begin
  BaseCenterPanel.Left := (Width - BaseCenterPanel.Width) div 2;
end;

end.