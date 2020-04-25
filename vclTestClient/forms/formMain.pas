unit formMain;

interface

uses
  cwCollections,
  datamodel,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls, Vcl.ComCtrls, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TfrmMain = class(TForm)
    pgcMain: TPageControl;
    pgWelcome: TTabSheet;
    btnStartGame: TButton;
    btnJoinGame: TButton;
    pgCreateGame: TTabSheet;
    edtGameName: TLabeledEdit;
    edtPlayerName: TLabeledEdit;
    Label1: TLabel;
    cboLangID: TComboBox;
    spedMinUser: TSpinEdit;
    spedMaxUser: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    chkPrivate: TCheckBox;
    btnCancelCreateGame: TButton;
    btnCreateGame: TButton;
    req: TRESTRequest;
    resp: TRESTResponse;
    client: TRESTClient;
    pgGreenRoom: TTabSheet;
    lblWaitingToStart: TLabel;
    Label5: TLabel;
    lstPlayers: TListBox;
    tmrPollUsers: TTimer;
    procedure btnStartGameClick(Sender: TObject);
    procedure btnCreateGameClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrPollUsersTimer(Sender: TObject);
  private
    procedure SwitchPage(const PageName: string);
    procedure ClearRequest;
    procedure ExecuteRequest;
    { Private declarations }
  private
    fGame: IGameData;
    fUser: IUserData;
    procedure DoEnterGreenRoom;
    function RequestUsers: IList<IUserData>;
    procedure AddRequestAuthentication;
    procedure UpdateGreenRoomPlayers;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
uses
  cwCollections.Standard
, datamodel.standard
, System.Json
, REST.JSON
;

{$R *.dfm}

procedure TfrmMain.SwitchPage( const PageName: string );
var
  idx: integer;
  utPageName: string;
  utTab: string;
  Switched: boolean;
begin
  Switched := False;
  utPageName := Uppercase(Trim(PageName));
  for idx := 0 to pred(pgcMain.PageCount) do begin
    utTab := Uppercase(Trim(pgcMain.Pages[idx].Name));
    if utTab=utPageName then begin
      pgcMain.TabIndex := idx;
      Switched := True;
      break;
    end;
  end;
  if not Switched then begin
    exit;
  end;
  if utPageName = 'PGGREENROOM' then begin
    DoEnterGreenRoom;
  end;
end;

procedure TfrmMain.tmrPollUsersTimer(Sender: TObject);
begin
  UpdateGreenRoomPlayers;
end;

procedure TfrmMain.ClearRequest;
begin
  req.Params.Clear;
  req.Body.ClearBody;
end;

procedure TfrmMain.ExecuteRequest;
begin
  try
    req.Execute;
  except
    on E: Exception do begin
      // Response
      if resp.StatusCode <> 200 then begin
        raise
          Exception.Create(resp.Content);
      end;
    end;
  end;
end;

procedure TfrmMain.AddRequestAuthentication;
var
  AuthParam: TRESTRequestParameter;
begin
  AuthParam := req.Params.AddItem;
  AuthParam.Kind := TRESTRequestParameterKind.pkHTTPHEADER;
  AuthParam.Name := 'authentication-string';
  AuthParam.Value := fUser.UserID;
end;

function TfrmMain.RequestUsers: IList<IUserData>;
var
  idx: integer;
  JSONArray: TJSONArray;
begin
  Result := TList<IUserData>.Create;
  ClearRequest;
  req.Resource := 'users';
  req.Method := TRestRequestMethod.rmGET;
  AddRequestAuthentication;
  ExecuteRequest;
  JSONArray := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(resp.content),0) as TJSONArray;
  if JSONArray.Size=0 then begin
    exit;
  end;
  for idx := 0 to pred(JSONArray.Count) do begin
    Result.Add(TJSON.JsonToObject<TUserData>(JSONArray.Get(idx).ToJSON));
  end;
end;

procedure TfrmMain.UpdateGreenRoomPlayers;
var
  idx: integer;
  Users: IList<IUserData>;
begin
  lstPlayers.Clear;
  Users := RequestUsers;
  if Users.Count=0 then begin
    exit;
  end;
  for idx := 0 to pred(Users.Count) do begin
    lstPlayers.Items.Add(Users[idx].Name);
    if Users[idx].IsCurrentUser then begin
      lblWaitingToStart.Caption := 'Waiting for sufficient players and for '+Users[idx].Name+' to start the game...';
    end;
  end;
end;

procedure TfrmMain.DoEnterGreenRoom;
begin
  UpdateGreenRoomPlayers;
  tmrPollUsers.Enabled := True;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  SwitchPage('pgWelcome');
end;

procedure TfrmMain.btnCreateGameClick(Sender: TObject);
begin

  // Create game request data
  fGame := TGameData.Create;
  fGame.SessionName := edtGameName.Text;
  fGame.MinUser := spedMinUser.Value;
  fGame.MaxUser := spedMaxUser.Value;
  fGame.LangID := cboLangID.Text;
  if chkPrivate.Checked then begin
    fGame.SessionPassword := 'Generate';
  end else begin
    fGame.SessionPassword := '';
  end;

  // Create game request.
  ClearRequest;
  req.Resource := '/games';
  req.Method := TRestRequestMethod.rmPOST;
  req.Body.Add(fGame.ToJSON,TRestContentType.ctAPPLICATION_JSON);
  ExecuteRequest;
  fGame := TJSON.JsonToObject<TGameData>(resp.Content);

  // Create user data
  fUser := TUserData.Create;
  fUser.Name := edtPlayerName.Text;
  fUser.GameID := fGame.SessionID;

  // Create user request.
  ClearRequest;
  req.Resource := '/users';
  req.Method := TRestRequestMethod.rmPOST;
  req.Body.Add(fUser.ToJSON,TRestContentType.ctAPPLICATION_JSON);
  ExecuteRequest;
  fUser := TJSON.JsonToObject<TUserData>(resp.Content);

  SwitchPage('pgGreenRoom');
end;

procedure TfrmMain.btnStartGameClick(Sender: TObject);
begin
  SwitchPage('pgCreateGame');
end;

end.
