unit Main.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.ListBox, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, Game.Interfaces, System.generics.Collections;

type
  TMainView = class(TForm)
    TabControl1: TTabControl;
    ToolBar1: TToolBar;
    Label1: TLabel;
    StartTab: TTabItem;
    YourName: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Layout1: TLayout;
    Button2: TButton;
    Join: TTabItem;
    Host: TTabItem;
    Label3: TLabel;
    Layout2: TLayout;
    Button3: TButton;
    GameName: TEdit;
    Label4: TLabel;
    MinUser: TComboBox;
    Label5: TLabel;
    MaxUser: TComboBox;
    Label6: TLabel;
    BackButton: TButton;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    Green: TTabItem;
    Users: TListBox;
    PollGames: TTimer;
    PollUser: TTimer;
    client: TRESTClient;
    req: TRESTRequest;
    resp: TRESTResponse;
    Games: TListBox;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure BackButtonClick(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure PollGamesTimer(Sender: TObject);
    procedure PollUserTimer(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure YourNameChangeTracking(Sender: TObject);
  private
    { Private-Deklarationen }
    fPrivateGame : boolean;
    fGame        : IGameData;
    fUser        : IUserData;
    fIsJoin      : boolean;
    fGameList    : TList<IGameData>;
    fUserList    : TList<IUserData>;
    fGameItems   : TObjectDictionary<String,TListBoxItem>;
    fSlots       : Array[0..9] of TListBoxItem;
    Function CheckName : boolean;
    Function CheckGamename : boolean;
    Procedure ChangeTo(Const aTabItem : TTabItem);
    Procedure RefreshGames;
    Procedure RefreshUser;
    procedure ClearRequest;
    procedure ExecuteRequest;
    procedure SyncGameList;
    procedure SyncUserList;
    procedure CreateGame;
    Procedure JoinGameClick(Sender : TObject);
    procedure AddRequestAuthentication;
    procedure CreateGreen;
    procedure StartGame(Sender : TObject);
  public
    { Public-Deklarationen }
  end;

var
  MainView: TMainView;

implementation

Uses
  System.Json
, System.Math
, System.Threading
, REST.JSON
, Game.Model
;

{$R *.fmx}

procedure TMainView.AddRequestAuthentication;
var
  AuthParam: TRESTRequestParameter;
begin
  AuthParam       := req.Params.AddItem;
  AuthParam.Kind  := TRESTRequestParameterKind.pkHTTPHEADER;
  AuthParam.Name  := 'authentication-string';
  AuthParam.Value := fUser.UserID;
end;

procedure TMainView.Button1Click(Sender: TObject);
begin
  if CheckName then
    begin
      fIsJoin := true;
      TThread.ForceQueue(NIL,Procedure
        begin
          TabControl1.SetActiveTabWithTransitionAsync(Join,TTabTransition.Slide,TTabTransitionDirection.Normal,RefreshGames);
        end);
    end;
end;

procedure TMainView.Button2Click(Sender: TObject);
begin
  if CheckName then
    begin
      fIsJoin := false;
      TThread.ForceQueue(NIL,Procedure
        begin
          TabControl1.SetActiveTabWithTransition(Host,TTabTransition.Slide,TTabTransitionDirection.Normal);
        end);
    end;
end;

procedure TMainView.BackButtonClick(Sender: TObject);
begin
  case TabControl1.TabIndex of
    1,2 : ChangeTo(StartTab);
    3   : if fIsJoin
            then ChangeTo(Join)
            else ChangeTo(Host);
  end;
end;

procedure TMainView.ChangeTo(const aTabItem: TTabItem);
var
  lTabItem: TTabItem;
begin
  lTabItem := aTabItem;

  TThread.ForceQueue(NIL,Procedure
    begin
      TabControl1.SetActiveTabWithTransition(lTabItem,TTabTransition.Slide,TTabTransitionDirection.Reversed);
    end);
end;

function TMainView.CheckGamename: boolean;
begin
  if (GameName.Text.Length < 3) then
    begin
      ShowMessage('Please Enter a Gamename');
      GameName.SetFocus;
      exit(false);
    end;

  Result := true;
end;

Function TMainView.CheckName : boolean;
begin
  if (YourName.Text.Length < 3) then
    begin
      ShowMessage('Please Enter your Name');
      YourName.SetFocus;
      exit(false);
    end;

  Result := true;
end;

procedure TMainView.ClearRequest;
begin
  req.Params.Clear;
  req.Body.ClearBody;
end;

procedure TMainView.CreateGame;
begin
  // Create game request data
  fGame := TGameData.Create;
  fGame.SessionName := GameName.Text;
  fGame.MinUser     := MinUser.ItemIndex + 3;
  fGame.MaxUser     := MaxUser.ItemIndex + 3;
  fGame.LangID      := 'US';

  if fPrivateGame then begin
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
  fUser.Name := YourName.Text;
  fUser.GameID := fGame.SessionID;

  // Create user request.
  ClearRequest;
  req.Resource := '/users';
  req.Method := TRestRequestMethod.rmPOST;
  req.Body.Add(fUser.ToJSON,TRestContentType.ctAPPLICATION_JSON);
  ExecuteRequest;
  fUser := TJSON.JsonToObject<TUserData>(resp.Content);
end;

procedure TMainView.CreateGreen;
var
  LBI : TListBoxItem;
begin
  Users.BeginUpdate;
  try
    Users.Clear;

    for var i:=0 to fGame.MaxUser do
      begin
        LBI := TListBoxItem.Create(NIL);
        LBI.Parent := Users;
        LBI.Height := 49;
        LBI.StyleLookup := 'istboxitemleftdetail';
        LBI.ItemData.Text := '< Open Slot >';
        LBI.ItemData.Detail := '';
        fSlots[i] := LBI;
      end;

    for var i:= fGame.MaxUser to 9 do
      if Assigned(fSlots[i]) then
        fSlots[i].Free;
  finally
    Users.EndUpdate;
  end;

  RefreshUser;
end;

procedure TMainView.ExecuteRequest;
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

procedure TMainView.FormCreate(Sender: TObject);
begin
  TabControl1.ActiveTab := StartTab;
  TabControl1.TabPosition := TTabPosition.None;
  MinUser.ItemIndex := 0;
  MaxUser.Itemindex := 3;
  button4.Visible := false;
  fGameItems   := TObjectDictionary<String,TListBoxItem>.Create([DoownsValues]);
  Games.Clear;
  Users.Clear;
  fGameList    := TList<IGameData>.Create;
  fUserList    := TList<IUserData>.Create;

  Fillchar(fSlots,Sizeof(fSlots),0);
end;

procedure TMainView.FormDeactivate(Sender: TObject);
begin
  fGameItems.Free;
  fGameList.Free;
  fUserList.Free;
end;

procedure TMainView.JoinGameClick(Sender: TObject);
begin
  TTask.Run(Procedure
              begin
                fUser := TUserData.Create;
                fUser.Name := Yourname.Text;
                fUser.GameID := (Sender as TListBoxItem).TagString;


                fGame := NIL;

                for var i:=0 to fGameList.Count-1 do
                  if fGameList[i].SessionID = fUser.GameID then
                    fGame := fGameList[i];

                // Create user request.
                ClearRequest;
                req.Resource := '/users';
                req.Method := TRestRequestMethod.rmPOST;
                req.Body.Add(fUser.ToJSON,TRestContentType.ctAPPLICATION_JSON);
                ExecuteRequest;
                fUser := TJSON.JsonToObject<TUserData>(resp.Content);

                TThread.Queue(NIL,Procedure
                  begin
                    TabControl1.SetActiveTabWithTransitionAsync(Green,TTabTransition.Slide,TTabTransitionDirection.Normal,CreateGreen);
                  end);
              end);
end;

procedure TMainView.ListBoxItem1Click(Sender: TObject);
begin
  if CheckGamename then
    begin
      fPrivateGame := (Sender = ListBoxItem1);
      Button4.Visible := true;

      TThread.ForceQueue(NIL,Procedure
        begin
          TabControl1.SetActiveTabWithTransitionAsync(Green,TTabTransition.Slide,TTabTransitionDirection.Normal,Procedure
            begin
              TTask.Run(Procedure
                begin
                  CreateGame;
                  TThread.Queue(NIL,CreateGreen);
                end);
            end);
        end);
    end;
end;

procedure TMainView.PollGamesTimer(Sender: TObject);
begin
  PollGames.Enabled := False;
  RefreshGames;
end;

procedure TMainView.PollUserTimer(Sender: TObject);
begin
  PollUser.Enabled := False;
  RefreshUser;
end;

procedure TMainView.RefreshGames;
begin
  Button4.Visible := true;

  TTask.Run(Procedure
              var
                idx: nativeuint;
                JSONArray: TJSONArray;
                GameIdx: nativeuint;
              begin
                try
                  ClearRequest;
                  req.Resource := 'games';
                  req.Method := TRestRequestMethod.rmGET;
                  ExecuteRequest;
                  JSONArray := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(resp.content),0) as TJSONArray;
                  if JSONArray.Size=0 then begin
                    exit;
                  end;

                  fGameList.Clear;

                  for idx := 0 to pred(JSONArray.Count) do begin
                    fGameList.Add(TJSON.JsonToObject<TGameData>(JSONArray.Get(idx).ToJSON));
                  end;
                finally
                  TThread.Synchronize(NIL,Procedure
                    begin
                      SyncGameList;
                      PollGames.Enabled := True;
                      Button4.Visible := false;
                    end);
                end;
              end);
end;

procedure TMainView.RefreshUser;
begin
  button4.Visible := true;

  TTask.Run(Procedure
              var
                idx: integer;
                JSONArray: TJSONArray;
              begin
                try
                  fUserList.Clear;

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
                    fUserList.Add(TJSON.JsonToObject<TUserData>(JSONArray.Get(idx).ToJSON));
                  end;
                finally
                  TThread.Synchronize(NIL,Procedure
                    begin
                      SyncUserList;
                      button4.Visible := false;
                      PollUser.Enabled := True;
                    end);
                end;
              end);
end;

procedure TMainView.StartGame;
begin
  //
end;

procedure TMainView.SyncGameList;
var
  lGame        : IGameData;
  lLBI         : TListBoxItem;
  lPair        : TPair<String,TListBoxItem>;
  lPairs       : TArray<TPair<String,TListBoxItem>>;
begin
  Games.BeginUpdate;
  try
    for lGame in fGameList do
      begin
        if fGameItems.TryGetValue(lGame.SessionID,lLBI)
          then begin
                 lLBI.ItemData.Text := lGame.SessionName;
                 lLBI.ItemData.Detail := 'Users in Game : '+lGame.UserCount.ToString+'  - Game Setting : '+lGame.MinUser.ToString+' / '+lGame.MaxUser.ToString;
                 lLBI.Tag := 1;
               end
          else begin
                 lLBI := TListBoxItem.Create(NIL);
                 lLBI.Parent := Games;
                 lLBI.Height := 49;
                 lLBI.StyleLookup := 'ListBoxItemBottomDetail';
                 lLBI.ItemData.Accessory := TListBoxItemData.TAccessory.aMore;
                 lLBI.Tag := 1;
                 lLBI.OnClick := JoinGameClick;
                 lLBI.TagString := lGame.SessionID;
                 fGameItems.TryAdd(lGame.SessionID,lLBI);
               end
      end;

   lPairs := fGameItems.ToArray;

   for lPair in lPairs do
     if lPair.Value.Tag = 1
       then lPair.Value.Tag := 0
       else fGameItems.Remove(lPair.Key);
  finally
    Games.EndUpdate;
  end;
end;

procedure TMainView.SyncUserList;
begin
  for var i := 0 to Min(fUserList.Count-1,9) do
    begin
      fSlots[i].ItemData.Text := fUserList.Items[i].Name;

      if fUserList.Items[i].IsCurrentUser
        then begin
               fSlots[i].ItemData.Detail := 'HOST';
               if fUserList.Count >= fGame.MinUser then
                 begin
                   fSlots[i].ItemData.Accessory := TListBoxItemData.TAccessory.aMore;
                   fSlots[i].OnClick := StartGame;
                 end;
             end
        else begin
               fSlots[i].ItemData.Detail    := '';
               fSlots[i].ItemData.Accessory := TListBoxItemData.TAccessory.aNone;
               fSlots[i].OnClick            := NIL;
             end;
    end;
end;

procedure TMainView.TabControl1Change(Sender: TObject);

  Procedure NoPoll;
  begin
    PollGames.Enabled  := false;
    PollUser.Enabled   := false;
  end;

begin
  BackButton.Visible := true;

  case TabControl1.TabIndex of
    0 : begin
          BackButton.Visible := false;
          NoPoll;
        end;
    2 : NoPoll;
  end; // of case
end;

procedure TMainView.YourNameChangeTracking(Sender: TObject);
begin
  GameName.Text := YourName.Text.Trim + '''s Game';
end;

end.


