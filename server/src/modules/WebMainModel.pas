unit WebMainModel;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Web.HTTPProd, datamodel;

type
  TWebModule4 = class(TWebModule)
    Main: TPageProducer;
    CreateGame: TPageProducer;
    JoinGame: TPageProducer;
    GreenRoom: TPageProducer;
    Turn: TPageProducer;
    Score: TPageProducer;
    Pre: TPageProducer;
    Css: TPageProducer;
    post: TPageProducer;
    Ajax: TPageProducer;
    Question: TPageProducer;
    JudgeButtonNext: TPageProducer;
    Error: TPageProducer;
    DoSubmit: TPageProducer;
    AjaxResult: TPageProducer;
    AjaxNewTarget: TPageProducer;
    GameOver: TPageProducer;

    procedure WebModule4DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4wactGamesAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4wactUsersAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4wactTurnAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4HTMLGameListAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure MainHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModule4FormCreateJoinAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure JoinGameHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure CreateGameHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModule4FormCreateGameAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4FormGreenRoomAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4HTMLUserListAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure GreenRoomHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModule4FormTurnAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4HTMLTurnContentAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure TurnHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModule4HTMLPostTurnAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule4FrameScoreAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure ScoreHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure AjaxHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure JudgeButtonNextHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure ErrorHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure PreHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure postHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure CssHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure QuestionHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure DoSubmitHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure AjaxResultHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure AjaxNewTargetHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModule4HTMLWaitForTurnAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure GameOverHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
    private
      fFullScoreAndSelectedAnswer,
      fException,
      fButton,
      fName,
      fUserID,
      fGameID,

      fAjaxHTMLSource,
      fAjaxWithPost,
      fAjaxToken,
      fAjaxNewTarget,
      fAjaxParam,

      fCardID,
      fQuestionID,
      fGameName : String;
      fGreenRoomError,
      fIsJudge,
      fCurrentUser : boolean;
      fTurn        : ITurnData;
    private
      function  CheckLayout(const TagString: String; var ReplaceText: String) : boolean;
      procedure CheckGlobalTags(const TagString: String; var ReplaceText: String;Params: TStrings = NIL);
      procedure PrepareResponse(Response : TWebResponse;Const Content : String;AjaxCall : boolean = true);overload;
      procedure PrepareResponse(Response : TWebResponse;Const PageProducer : TPageProducer);overload;
      procedure PrepareError(Response : TWebResponse;Const Info : String);
      procedure GetFields(Request: TWebRequest);
      function  CheckAjaxFields(const TagString: String; var ReplaceText: String): boolean;
      procedure GetAjaxFields(Params: TStrings; var ReplaceText: String);
  end;

Const
  cToken_StartGame = 'GOGOGO';
  cToken_GoScore   = 'GOSCORE';
  cShowErrors      = true;
  cPollTimer       = '3000';

{$IFDEF DEBUG}
  DebugLayout = true;
  cURL        = 'http://localhost:8080';
  cScriptURL  = '';
  cIMGURL     = 'https://www.delphiprofi.de/game/';
{$ELSE}
  DebugLayout = false;
  {$IFDEF MSWINDOWS}
    cURL        = 'https://delphiprofi.com/'
    cIMGURL     = 'https://www.delphiprofi.de/game/';
    cScriptURL  = '/cgi-bin/Cardgame.dll';
  {$ELSE}
    cURL        = 'https://apocalypse.chapmanworld.com';
    cIMGURL     = 'https://apocalypse.chapmanworld.com/broker/img/';
    cScriptURL  = '/api';
  {$ENDIF}
{$ENDIF}


var
  WebModuleClass: TComponentClass = TWebModule4;

implementation
Uses
  Requests
, System.JSON
, ViewModel
, datamodel.standard
, REST.JSON
;
{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}


{$REGION 'HTMLTag Handler'}

function TWebModule4.CheckLayout(const TagString: String; var ReplaceText: String) : boolean;
begin
  result := true;

  if DebugLayout
    then begin
           if SameText(TagString,'CSS')
             then ReplaceText := '.MarkColor {background-color: #FFFF00;}'
             else
           if SameText(TagString,'PRE')
             then ReplaceText := '<h1>Apocalypse Coding Group</h1>'
             else
           if SameText(TagString,'POST')
             then ReplaceText := ''
             else result := false;
         end
    else begin
           if SameText(TagString,'CSS')
             then ReplaceText := CSS.Content
             else
           if SameText(TagString,'PRE')
             then ReplaceText := PRE.Content
             else
           if SameText(TagString,'POST')
             then ReplaceText := POST.Content
             else result := false;
         end;
end;

procedure TWebModule4.CreateGameHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if SameText(TagString,'MarkColor')
    then begin
           if fGameName.trim = ''
             then ReplaceText := 'class="MarkColor"'
             else ReplaceText := '';
         end
    else CheckGlobalTags(TagString,ReplaceText);
end;

procedure TWebModule4.JudgeButtonNextHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  CheckGlobalTags(TagString,ReplaceText);
end;

procedure TWebModule4.CssHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  CheckGlobalTags(TagString,ReplaceText);
end;

procedure TWebModule4.DoSubmitHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  CheckGlobalTags(TagString,ReplaceText); { TODO : Needed? }
end;

procedure TWebModule4.ErrorHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  CheckGlobalTags(TagString,ReplaceText);
end;

procedure TWebModule4.QuestionHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  CheckGlobalTags(TagString,ReplaceText); { TODO : Needed? }
end;

procedure TWebModule4.MainHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if SameText(TagString,'MarkColor')
    then begin
           if fName.trim = ''
             then ReplaceText := 'class="MarkColor"'
             else ReplaceText := '';
         end
    else CheckGlobalTags(TagString,ReplaceText);
end;

procedure TWebModule4.postHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  CheckGlobalTags(TagString,ReplaceText);
end;

procedure TWebModule4.PreHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  CheckGlobalTags(TagString,ReplaceText);
end;

procedure TWebModule4.GreenRoomHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if SameText(TagString,'Error')
    then begin
           if fGreenRoomError
             then ReplaceText := 'window.alert("Not enought players");'
             else ReplaceText := '';
         end
    else CheckGlobalTags(TagString,ReplaceText,TagParams);
end;

procedure TWebModule4.JoinGameHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  CheckGlobalTags(TagString,ReplaceText,TagParams);
end;

procedure TWebModule4.ScoreHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if SameText(TagString,'Score')
    then ReplaceText := fFullScoreAndSelectedAnswer
    else
  if SameText(TagString,'Judge')
    then begin
           if fIsJudge
             then ReplaceText := JudgeButtonNext.Content
             else ReplaceText := '';
         end
    else CheckGlobalTags(TagString,ReplaceText,TagParams);
end;

procedure TWebModule4.AjaxHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if not CheckAjaxFields(TagString,ReplaceText) then
    CheckGlobalTags(TagString,ReplaceText);
end;

procedure TWebModule4.TurnHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  CheckGlobalTags(TagString,ReplaceText,TagParams);
end;

procedure TWebModule4.GameOverHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  CheckGlobalTags(TagString,ReplaceText);
end;

procedure  TWebModule4.GetAjaxFields(Params: TStrings; var ReplaceText: String);
begin
  fAjaxHTMLSource := Params.Values['HTMLSource'];
  fAjaxWithPost   := Params.Values['WithPost'];
  fAjaxToken      := Params.Values['Token'];
  fAjaxNewTarget  := Params.Values['NewTarget'];
  fAjaxParam      := Params.Values['Param'];

  if fAjaxParam.trim <> '' then
    fAjaxParam := fQuestionID;

  ReplaceText     := Ajax.Content;
end;

procedure TWebModule4.AjaxNewTargetHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if SameText(TagString,'PollTimer')
    then ReplaceText := cPollTimer
    else if not CheckAjaxFields(TagString,ReplaceText) then
           CheckGlobalTags(TagString,ReplaceText);
end;

procedure TWebModule4.AjaxResultHTMLTag(Sender: TObject; Tag: TTag; const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if SameText(TagString,'PollTimer')
    then ReplaceText := cPollTimer;
end;

function TWebModule4.CheckAjaxFields(const TagString: String; var ReplaceText: String) : boolean;
begin
  Result := true;

  if SameText(TagString,'AJAXResult')
    then begin
           if fAjaxToken.Trim = ''
             then ReplaceText := AJAXResult.Content
             else ReplaceText := AJAXNewTarget.Content;
         end
    else
  if SameText(TagString,'HTMLSource')
    then ReplaceText := fAjaxHTMLSource
    else
  if SameText(TagString,'WithPost')
    then begin
           if fAjaxWithPost.Trim = '' then
             begin
               Replacetext := '';
               exit;
             end;

           if SameText(fAjaxWithPost,'Postquestion')
             then ReplaceText := Question.Content
             else
           if SameText(fAjaxWithPost,'DoSubmit')
             then ReplaceText := DoSubmit.Content
             else Raise Exception.CreateFMT('AjaxWithPost token (%s) no found',[fAjaxWithPost]);
         end
    else
  if SameText(TagString,'Token')
    then ReplaceText := fAjaxToken
    else
  if SameText(TagString,'Param')
    then begin
           if fAjaxParam.Trim <> ''
             then ReplaceText := '&QID='+fAjaxParam
             else ReplaceText := '';
         end
    else
  if SameText(TagString,'NewTarget')
    then ReplaceText := fAjaxNewTarget
    else result := false;
end;

procedure TWebModule4.CheckGlobalTags(const TagString: String; var ReplaceText: String;Params: TStrings = NIL);
begin
  if (Params <> NIL) and SameText(TagString,'AJAX') then
    begin
      GetAjaxFields(Params,ReplaceText);
      exit;
    end;

  if not CheckLayout(TagString,ReplaceText) then
    begin
      if SameText(TagString,'URL')
        then ReplaceText := cURL
        else
      if SameText(TagString,'SCRIPTURL')
        then ReplaceText := cURL+cScriptURL
        else
      if SameText(TagString,'Gamename')
        then ReplaceText := fGameName
        else
      if SameText(TagString,'UserID')
        then ReplaceText := fUserID
        else
      if SameText(TagString,'SessionID')
        then ReplaceText := fGameID
        else
      if SameText(TagString,'CardID')
        then ReplaceText := fCardID
        else
      if SameText(TagString,'AJAX')
        then ReplaceText := AJAX.Content
        else
      if SameText(TagString,'IMGURL')
        then ReplaceText := cIMGURL
        else
      if SameText(TagString,'Error')
        then ReplaceText := fException
        else
      if SameText(TagString,'Name')
        then ReplaceText := fName
        else Raise Exception.CreateFMT('Tag not defined:%s',[TagString]);

      {$IFDEF DEBUG}
//      if ReplaceText.Trim = '' then
//        Raise Exception.CreateFMT('RepalceText empty for Tag(%s)',[TagString]);
      {$ENDIF}
    end;
end;

{$ENDREGION}
{$REGION 'HTML Source'}

procedure TWebModule4.PrepareError(Response: TWebResponse; const Info: String);
begin
  if cShowErrors
    then begin
           fException := Info;
           PrepareResponse(Response,Error);
         end
    else begin
           Response.Content := Info;
           Response.StatusCode := 501;
         end;
end;

procedure TWebModule4.PrepareResponse(Response: TWebResponse; const PageProducer: TPageProducer);
begin
  Response.StatusCode := 200;
  Response.Content    := PageProducer.Content; // or URL
end;

procedure TWebModule4.PrepareResponse(Response: TWebResponse; const Content: String;AjaxCall : boolean);
begin
  if AjaxCall then
    Response.SetCustomHeader('Cache-Control','no-cache,no-store');

  Response.StatusCode := 200;
  Response.Content    := Content;
end;

procedure TWebModule4.GetFields(Request : TWebRequest);
begin
  if Request.ContentFields.Text.Trim <> '' then
    begin
      fName     := Request.ContentFields.Values['Name'];
      fGameName := Request.ContentFields.Values['Gamename'];
      fButton   := Request.ContentFields.Values['Button'];
      fGameID   := Request.ContentFields.Values['SessionID'];
      fUserID   := Request.ContentFields.Values['UserID'];
      fCardID   := Request.ContentFields.Values['Answers'];
    end;

  if Request.QueryFields.Text.Trim <> '' then
    begin
      fUserID     := Request.QueryFields.Values['UserID'];
      fQuestionID := Request.QueryFields.Values['QID'];
      {$IFDEF DEBUG}
      fButton     := Request.QueryFields.Values['Button'];
      fGameName   := Request.QueryFields.Values['Gamename'];
      {$ENDIF}

      fName       := Request.QueryFields.Values['Username'];

      if fName <> '' then
        raise exception.Create('Wrong field name it just name');

      fName   := Request.ContentFields.Values['Name'];
    end;
end;

procedure TWebModule4.WebModule4DefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin // just for faster debugging
  GetFields(Request);

  PrepareResponse(Response,Main);
end;
{$ENDREGION}
{$REGION 'HTML Forms'}
procedure TWebModule4.WebModule4FormCreateGameAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  GetFields(Request);

  if fGameName.Trim = ''
    then begin  // Just for eays Debugging
           fGameName := fName+''''+'s Game';
           PrepareResponse(Response,CreateGame);
         end
    else begin
           // Create Game
           TGameRequest.HandleWeb(Response,'',Procedure (Const AuthToken : String;Response : TWebResponse;Const ViewModel : IViewModel)
             var
               lGame : IGameData;
               lUser : IUserData;
             begin
               lGame             := TGameData.Create;
               lGame.SessionName := fGameName;
               lGame.LangID      := 'US';
               lGame.MinUser     := 3;
               lGame.MaxUser     := 6;

               lGame             := TJSON.JsonToObject<TGameData>(ViewModel.CreateGame(lGame.ToJSON));

               fGameID           := lGame.SessionID;
               fGameName         := lGame.SessionName;

               // Create user data

               lUser             := TUserData.Create;
               lUser.Name        := fName;
               lUser.GameID      := lGame.SessionID;
               lUser             := TJSON.JsonToObject<TUserData>(ViewModel.JoinGame( lUser.ToJSON ));

               fUserID           := lUser.UserID;
               fCurrentUser      := true;

               PrepareResponse(Response,GreenRoom)
             end);
         end;
end;

procedure TWebModule4.WebModule4FormCreateJoinAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  GetFields(Request);

  if fName.Trim = ''
    then begin
           PrepareResponse(Response,Main);
         end
    else begin
           if SameText(fButton,'Create')
             then PrepareResponse(Response,CreateGame)
             else PrepareResponse(Response,JoinGame);
         end;
end;

procedure TWebModule4.WebModule4FormGreenRoomAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  lUser : IUserData;
begin
  GetFields(Request);

  fCurrentUser := false;

  if fGameID='-' then
    begin
      PrepareError(Response,'SessionID Missing');
      exit;
    end;

 if fName='' then
    begin
      PrepareError(Response,'Name missing<br>'+Request.ContentFields.Text);
      exit;
    end;

   TGameRequest.HandleWeb(Response,'',Procedure (Const AuthToken : String;Response: TWebResponse;Const ViewModel : IViewModel)
     var
       lUser : IUserData;
     begin
       lUser        := TUserData.Create;
       lUser.Name   := fName;
       lUser.GameID := fGameID;
       lUser        := TJSON.JsonToObject<TUserData>(ViewModel.JoinGame( lUser.ToJSON ));
       fUserID      := lUser.UserID;

       PrepareResponse(Response,GreenRoom);
     end);
end;

procedure TWebModule4.WebModule4FormTurnAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  if Request.MethodType = mtGet
    then begin // User
           fUserID := Request.QueryFields.Values['UserID'];
           fGameID := Request.QueryFields.Values['SessionID'];
           PrepareResponse(Response,Turn);
           exit;
         end
    else begin // Judge
           fUserID := Request.ContentFields.Values['UserID'];
           fGameID := Request.ContentFields.Values['SessionID'];
         end;

  TGameRequest.HandleWeb(Response,fUserID,Procedure (Const AuthToken : String;Response: TWebResponse;Const ViewModel : IViewModel)
  var
    lGame : IGameData;
    lJSON : String;
    begin
      lGame           := TGameData.Create;
      lGame.GameState := TGameState.gsRunning;
      lGame.SessionID := fGameID;

      try
        lGame := TJSON.JsonToObject<TGameData>(ViewModel.setGameState(fUserID,lGame.ToJSON));
      except
        fGreenRoomError := true;   // Inform Judge not enough User
        PrepareResponse(Response,GreenRoom);
        exit;
      end;

      if lGame.GameState = TGameState.gsRunning
         then PrepareResponse(Response,Turn)
         else PrepareError(Response,'Should not happen! Possible Database error'); // Error should been catched 3 lines before
    end);
end;

procedure TWebModule4.WebModule4FrameScoreAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  GetFields(Request);
  fIsJudge := false;

  TGameRequest.HandleWeb(Response,fUserID,Procedure (Const AuthToken : String;Response: TWebResponse;Const ViewModel : IViewModel)
     var
       _Result   : String;
       JSONArray : TJSONArray;
       lUser     : IUserData;
       idx       : Integer;
     begin
       fTurn   := TTurnData.FromJSON(ViewModel.getCurrentTurn( AuthToken ));

       _Result := '<p>The selected answer is:</p>'+StringReplace(fTurn.Question.Title,cQuestToken,fTurn.Selection.Title,[])+'<br />';
       fQuestionID := fTurn.Question.CardID;

       JSONArray := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ViewModel.getUsers(AuthToken)),0) as TJSONArray;

       _Result := _Result + '<ul>';

       for idx := 0 to pred(JSONArray.Count) do
         begin
           lUser := TJSON.JsonToObject<TUserData>(JSONArray.Get(idx).ToJSON);
           _Result := _Result + '<li>'+lUser.Name+' ('+lUser.Score.ToString+')</li>';
         end;

       _Result := _Result + '</ul>';

       _Result := _Result + '<div id="Content"></div>';

       fFullScoreAndSelectedAnswer := _Result;

       Response.Content := Score.Content;
       Response.StatusCode := 200;
     end);
end;
{$ENDREGION}
{$REGION 'AJAX Action Handler'}
procedure TWebModule4.WebModule4HTMLGameListAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  GetFields(Request);
  fGreenRoomError := false;

   TGameRequest.HandleWeb(Response,fUserID,Procedure (Const AuthToken : String;Response: TWebResponse;Const ViewModel : IViewModel)
     var
       JSONArray : TJSONArray;
       Idx       : nativeuint;
       lGame     : IGameData;
       _Result   : String;
     begin
       JSONArray := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ViewModel.getPublicGames),0) as TJSONArray;

       if JSONArray.Size=0 then begin
         PrepareResponse(Response,'no Games, akt time is: '+formatDatetime('hh:nn:ss',Now)); { TODO : Time is just for testing - show's server and AJAX still running }
         exit;
       end;

       _Result := '<ul>';

       for idx := 0 to pred(JSONArray.Count) do
         begin
           lGame := TJSON.JsonToObject<TGameData>(JSONArray.Get(idx).ToJSON);
           _Result := _Result + '<li><a href="javascript:{}" onclick="DoSubmit('''+lGame.SessionID+'''); return false;">'+lGame.SessionName+'</a></li>';
         end;                                                 //      ^^^^^^^^ Do not change is hardcoded in the script

       _Result := _Result + '</ul>';

       PrepareResponse(Response,_Result);
     end);
end;

procedure TWebModule4.WebModule4HTMLPostTurnAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  GetFields(Request);

  if fCardID = '' then
    PrepareError(Response,'No CardID: Database Error - or blame the developer');

  TGameRequest.HandleWeb(Response,fUserID,Procedure (Const AuthToken : String;Response: TWebResponse;Const ViewModel : IViewModel)
    var
       _Result   : String;
       lJSON     : String;
       JSONArray : TJSONArray;
       lUser     : IUserData;
       idx       : Integer;
    begin
      fTurn := TTurnData.Create;
      fTurn.Selection.CardID := fCardID;

      try
        lJSON := ViewModel.setCurrentTurn(fUserID,fTurn.ToJSON);
      except
        on E : Exception do
          begin
            PrepareError(Response,E.Message);
            exit;
          end;
      end;

      if lJSON.trim <> '' then
        fTurn := TTurnData.FromJSON(lJSON);

      if fTurn.Selection.CardID <> ''
        then begin
               if lJSON.trim <> '' then   { TODO : ENDGAME }
                 fIsJudge         := true;

               _Result   := '<p>The selected answer is:</p>'+
                            StringReplace(fTurn.Question.Title,cQuestToken,fTurn.Selection.Title,[])+'<br />';

               fCardID := fTurn.Selection.CardID;

               JSONArray := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ViewModel.getUsers(AuthToken)),0) as TJSONArray;

               if lJSON = ''
                 then _Result   := _Result + '<p>The final scores are:</p>'
                 else _Result   := _Result + '<p>The scores are:</p>';

               _Result   := _Result + '<ul>';

               for idx := 0 to pred(JSONArray.Count) do
                 begin
                   lUser := TJSON.JsonToObject<TUserData>(JSONArray.Get(idx).ToJSON);
                   _Result := _Result + '<li>'+lUser.Name+' ('+lUser.Score.ToString+')</li>';
                 end;

               _Result   := _Result + '</ul>';

               if lJSON.trim = '' then
                 _Result := _Result + GameOver.Content;

               fFullScoreAndSelectedAnswer := _Result;

               PrepareResponse(Response,Score);
             end
        else PrepareResponse(Response,Turn);
    end);
end;

procedure TWebModule4.WebModule4HTMLTurnContentAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  GetFields(Request);

  TGameRequest.HandleWeb(Response,fUserID,Procedure (Const AuthToken : String;Response: TWebResponse;Const ViewModel : IViewModel)
    var
      _Result    : String;
      lQuestion  : String;
      lNr        : Integer;
      lAnswered,
      lNowSelect : boolean;
    begin
      fTurn := TTurnData.FromJSON(ViewModel.getCurrentTurn( AuthToken ));

      lQuestion := fTurn.Question.Title;

      if fTurn.Cards.Items[0].CardID = ''
        then begin // Judge
               lNowSelect := (fTurn.Answers.Count = (fTurn.Cards.Count-1));

               if lNowSelect
                 then _Result   := '<p>Please select the best answer:</p>'
                 else _Result   := 'The players have selected ('+fTurn.Answers.Count.ToString+'/'+(fTurn.Cards.Count-1).ToString+'):<ul>';

                fTurn.Answers.ForEach(procedure( const item: ICardData )
                begin
                  if lNowSelect
                    then begin
                           _Result := _Result + '<label for="Radio'+lNr.ToString+'"><input id="Radio'+lNr.ToString+'" onclick="Postquestion()" name="Answers" type="radio" value="'+Item.CardID+'">'+
                           StringReplace(lQuestion,cQuestToken,Item.Title,[])+'</label><br />';
                         end
                    else begin
                           _Result := _Result + '<li>'+StringReplace(lQuestion,cQuestToken,Item.Title,[])+'</li>';
                         end;

                   inc(lNr);
                end);

               if not lNowSelect then
                 _Result := _Result + '</ul>';
             end
        else begin
               if fTurn.Selection.CardID = ''
                 then begin
                        _Result   := 'Other players have selected:<ul>';
                        lNr       := 1;
                        lAnswered := false;

                        fTurn.Answers.ForEach(procedure( const item: ICardData )
                        begin
                          _Result := _Result + '<li>'+StringReplace(lQuestion,cQuestToken,Item.Title,[])+'</li>';
                          if Item.Owner = AuthToken then
                            lAnswered := true
                        end);

                        _Result := _Result + '</ul><hr>';

                        if lAnswered
                          then _Result := _Result + '<p>Wating for the judge''s selection!</p>'
                          else begin
                                 _Result := _Result + '<p>Please select your answer:</p>';

                                 fTurn.Cards.ForEach(procedure( const item: ICardData )
                                 begin
                                   _Result := _Result + '<label for="Radio'+lNr.ToString+'"><input id="Radio'+lNr.ToString+'" onclick="Postquestion()" name="Answers" type="radio" value="'+Item.CardID+'">'+
                                                         StringReplace(lQuestion,cQuestToken,Item.Title,[])+'</label><br />'; //       ^^^^^^^^^^^^ Do not change is hardcoded in the script
                                   inc(lNr);
                                 end);
                               end;
                      end
                 else _Result := cToken_GOSCORE;
             end;

      PrepareResponse(Response,_Result);
    end);
end;

procedure TWebModule4.WebModule4HTMLUserListAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  GetFields(Request);

  TGameRequest.HandleWeb(Response,fUserID,Procedure (Const AuthToken : String;Response: TWebResponse;Const ViewModel : IViewModel)
     var
       idx       : integer;
       JSONArray : TJSONArray;
       lUser     : IUserData;
       _Result   : String;
     begin
       JSONArray := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ViewModel.getUsers(AuthToken)),0) as TJSONArray;

       if JSONArray.Size=0 then begin
         PrepareResponse(Response,'- no User -'); // Perhaps to early?
         exit;
       end;

       _Result      := '<ul>';
       fCurrentUser := false;

       for idx := 0 to pred(JSONArray.Count) do
         begin
           lUser := TJSON.JsonToObject<TUserData>(JSONArray.Get(idx).ToJSON);
           if (lUser.UserID = fUserID) and (lUser.PlayerState <> psInGreenRoom) then
             begin
               Response.Content := cToken_StartGame;
               exit;
             end;

           if lUser.IsCurrentUser and (lUser.UserID = fUserID) then
             fCurrentUser := true;
           _Result := _Result + '<li>'+lUser.Name+'</li>';
         end;

       _Result := _Result + '</ul>';

       if fCurrentUser then
         if JSONArray.Count >= 3
           then _Result := _Result +'</ br></ br><input type="submit" name="Start" value="Start the Game" />'
           else _Result := _Result +'</ br></ br><input type="submit" name="Start" value="Start the Game" disabled/>';

       PrepareResponse(Response,_Result);
     end);
end;

procedure TWebModule4.WebModule4HTMLWaitForTurnAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  GetFields(Request);

  TGameRequest.HandleWeb(Response,fUserID,Procedure (Const AuthToken : String;Response: TWebResponse;Const ViewModel : IViewModel)
     var
       idx       : integer;
       JSONArray : TJSONArray;
       lUser     : IUserData;
       lGame     : IGameData;
       _Result   : String;
     begin
       lGame := ViewModel.getCurrentGame(fUserID);

       if lGame.GameState = TGameState.gsGameOver
         then begin
                _Result := GameOver.Content;
              end
         else begin
                if lGame.CurrentQuestion <> fQuestionID
                  then _Result := cToken_StartGame
                  else _Result := 'waiting for judge to start next turn...';
              end;

       PrepareResponse(Response,_Result);
     end);
end;

{$ENDREGION}

procedure TWebModule4.WebModule4wactGamesAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  TGameRequest.HandleRequest( Request, Response, Handled,

    // Create
    procedure(const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.CreateGame( Request.Content );
    end,

    // Read
    procedure(const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.getPublicGames;
    end,

    // Update
    procedure(const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.setGameState( AuthToken, Request.Content );
    end,

    // Delete
    nil
  );
end;

procedure TWebModule4.WebModule4wactTurnAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  TGameRequest.HandleRequest( Request, Response, Handled,

    // Create
    nil,

    // Read
    procedure(const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.getCurrentTurn( AuthToken );
    end,

    // Update
    procedure(const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.setCurrentTurn( AuthToken, Request.Content );
    end,

    // Delete
    nil
  );

end;

procedure TWebModule4.WebModule4wactUsersAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  TGameRequest.HandleRequest( Request, Response, Handled,

    // Create
    procedure(const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.JoinGame( Request.Content );
    end,

    // Read
    procedure(const AuthToken: string; Response: TWebResponse; var Handled: Boolean; const ViewModel: IViewModel)
    begin
      Response.Content := ViewModel.getUsers(AuthToken);
    end,

    // Update
    nil,

    // Delete
    nil
  );

end;

end.



