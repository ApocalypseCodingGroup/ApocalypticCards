object WebModule4: TWebModule4
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule4DefaultHandlerAction
    end
    item
      Name = 'wactGames'
      PathInfo = '/games'
      OnAction = WebModule4wactGamesAction
    end
    item
      Name = 'wactUsers'
      PathInfo = '/users'
      OnAction = WebModule4wactUsersAction
    end
    item
      Name = 'wactTurn'
      PathInfo = '/turn'
      OnAction = WebModule4wactTurnAction
    end
    item
      Name = 'FormCreateJoin'
      PathInfo = '/CreateOrJoin'
      OnAction = WebModule4FormCreateJoinAction
    end
    item
      Name = 'FormCreateGame'
      PathInfo = '/CreateGame'
      OnAction = WebModule4FormCreateGameAction
    end
    item
      Name = 'FormGreenRoom'
      PathInfo = '/GreenRoom'
      OnAction = WebModule4FormGreenRoomAction
    end
    item
      Name = 'FormTurn'
      PathInfo = '/Rungame'
      OnAction = WebModule4FormTurnAction
    end
    item
      Name = 'FormScore'
      PathInfo = '/Score'
      OnAction = WebModule4FrameScoreAction
    end
    item
      Name = 'HTMLPostTurn'
      PathInfo = '/SelectAnswer'
      OnAction = WebModule4HTMLPostTurnAction
    end
    item
      Name = 'HTMLTurnContent'
      PathInfo = '/turncontent'
      OnAction = WebModule4HTMLTurnContentAction
    end
    item
      Name = 'HTMLUserList'
      PathInfo = '/Userlist'
      OnAction = WebModule4HTMLUserListAction
    end
    item
      Name = 'HTMLGameList'
      PathInfo = '/gamelist'
      OnAction = WebModule4HTMLGameListAction
    end
    item
      Name = 'HTMLWaitForTurn'
      PathInfo = '/WaitNext'
      OnAction = WebModule4HTMLWaitForTurnAction
    end>
  Height = 487
  Width = 656
  object Main: TPageProducer
    HTMLDoc.Strings = (
      
        '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "' +
        'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
      '<html xmlns="http://www.w3.org/1999/xhtml">'
      ''
      '<head>'
      
        '<meta content="text/html; charset=utf-8" http-equiv="Content-Typ' +
        'e" />'
      '<meta content="max-age=0" http-equiv="cache-control" />'
      '<meta content="no-cache" http-equiv="cache-control" />'
      '<meta content="0" http-equiv="expires" />'
      
        '<meta content="Tue, 01 Jan 1980 1:00:00 GMT" http-equiv="expires' +
        '" />'
      '<meta content="no-cache" http-equiv="pragma" />'
      '<title>Apocalypse Coding Group</title>'
      '<style type="text/css">'
      '<#CSS>'
      '</style>'
      '</head>'
      '<body class="bodystyle" >'
      '<#PRE>'
      '<div id="content" class="divCenter">'
      #9'<form action="<#SCRIPTURL>/createOrJoin" method="post">'
      
        #9#9'<span class="LabelInput"><strong>Your Name</strong></span><br ' +
        '/>'
      
        #9#9'<input name="Name" type="text" style="width: 328px" value="<#N' +
        'ame>" <#MarkColor> ><br />'
      #9#9'<br />'
      
        #9#9'<button name="Button" type="submit" value="Create">Create a ne' +
        'w game</button>'
      
        #9#9'<button name="Button" type="submit" value="Join">Join a game</' +
        'button>'
      #9'</form>'
      '</div>'
      '<#POST>'
      '</body>'
      '</html>')
    OnHTMLTag = MainHTMLTag
    Left = 168
    Top = 24
  end
  object CreateGame: TPageProducer
    HTMLDoc.Strings = (
      
        '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "' +
        'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
      '<html xmlns="http://www.w3.org/1999/xhtml">'
      ''
      '<head>'
      
        '<meta content="text/html; charset=utf-8" http-equiv="Content-Typ' +
        'e" />'
      '<meta content="max-age=0" http-equiv="cache-control" />'
      '<meta content="no-cache" http-equiv="cache-control" />'
      '<meta content="0" http-equiv="expires" />'
      
        '<meta content="Tue, 01 Jan 1980 1:00:00 GMT" http-equiv="expires' +
        '" />'
      '<meta content="no-cache" http-equiv="pragma" />'
      '<title>Apocalypse Coding Group</title>'
      '<style type="text/css">'
      '<#CSS>'
      '</style>'
      ''
      '</head>'
      ''
      '<body class="bodystyle" >'
      ''
      '<#PRE>'
      ''
      '<div id="content" class="divCenter">'
      #9'<form action="<#SCRIPTURL>/creategame" method="post">'
      
        #9#9'<span class="LabelInput"><strong>Game name</strong></span><br ' +
        '/>'
      
        #9#9'<input name="Gamename" type="text" style="width: 328px" value=' +
        '"<#Gamename>" <#MarkColor> ><br />'
      
        '    '#9'<input type="hidden" name="Name" value="<#Name>" />  <br />' +
        #9
      #9'    <br />'
      
        '        <button type="submit" name="Button" value="Create">Creat' +
        'e</button>'#9#9
      '    </form>'
      '</div>'
      ''
      '<#POST>'
      ''
      '</html>')
    OnHTMLTag = CreateGameHTMLTag
    Left = 232
    Top = 24
  end
  object JoinGame: TPageProducer
    HTMLDoc.Strings = (
      
        '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "' +
        'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
      '<html xmlns="http://www.w3.org/1999/xhtml">'
      ''
      '<head>'
      
        '<meta content="text/html; charset=utf-8" http-equiv="Content-Typ' +
        'e" />'
      '<meta content="max-age=0" http-equiv="cache-control" />'
      '<meta content="no-cache" http-equiv="cache-control" />'
      '<meta content="0" http-equiv="expires" />'
      
        '<meta content="Tue, 01 Jan 1980 1:00:00 GMT" http-equiv="expires' +
        '" />'
      '<meta content="no-cache" http-equiv="pragma" />'
      '<title>Apocalypse Coding Group</title>'
      '<style type="text/css">'
      '<#CSS>'
      '</style>'
      ''
      '</head>'
      ''
      '<body class="bodystyle" >'
      ''
      '<#PRE>'
      ''
      '<div class="divCenter">'
      ''
      '<p class="LabelInput">Hello <#Name>!</P>'
      ''
      '<p class="LabelInput">Here are the running games:</p>'
      '<form id="Join" action="<#SCRIPTURL>/GreenRoom" method="post">'
      '<input type="hidden" name="SessionID" value="-" />'
      '<input type="hidden" name="Name" value="<#Name>" />'
      '<div id="Content">'
      '<p>No Games</p>'
      '</div>'
      ''
      '</form>'
      '</div>'
      ''
      '<#AJAX HTMLSource=gamelist WithPost=DoSubmit>'
      ''
      '</body>'
      '</html>')
    OnHTMLTag = JoinGameHTMLTag
    Left = 304
    Top = 24
  end
  object GreenRoom: TPageProducer
    HTMLDoc.Strings = (
      
        '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "' +
        'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
      '<html xmlns="http://www.w3.org/1999/xhtml">'
      ''
      '<head>'
      
        '<meta content="text/html; charset=utf-8" http-equiv="Content-Typ' +
        'e" />'
      '<meta content="max-age=0" http-equiv="cache-control" />'
      '<meta content="no-cache" http-equiv="cache-control" />'
      '<meta content="0" http-equiv="expires" />'
      
        '<meta content="Tue, 01 Jan 1980 1:00:00 GMT" http-equiv="expires' +
        '" />'
      '<meta content="no-cache" http-equiv="pragma" />'
      '<title>Apocalypse Coding Group</title>'
      '<style type="text/css">'
      '<#CSS>'
      '</style>'
      ''
      '</head>'
      ''
      '<body class="bodystyle" >'
      ''
      '<#PRE>'
      ''
      '<div class="divCenter">'
      ''
      '<p class="LabelInput"><#Gamename></p>'
      '<p class="LabelInput">Waiting for Players to join the game:</p>'
      '<form id="Start" action="<#SCRIPTURL>/Rungame" method="post">'
      #9'<input name="SessionID" type="hidden" value="<#SessionID>" />'
      #9'<input name="UserID" type="hidden" value="<#UserID>" />'#9
      #9'<div id="Content">'
      #9#9'<p>No Players</p>'
      #9'</div>'
      '</form>'
      ''
      '</div>'
      ''
      '<#AJAX HTMLSource=userlist Token=GOGOGO NewTarget=Rungame>'
      ''
      '</body>'
      ''
      '</html>')
    OnHTMLTag = GreenRoomHTMLTag
    Left = 168
    Top = 80
  end
  object Turn: TPageProducer
    HTMLDoc.Strings = (
      
        '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "' +
        'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
      '<html xmlns="http://www.w3.org/1999/xhtml">'
      ''
      '<head>'
      
        '<meta content="text/html; charset=utf-8" http-equiv="Content-Typ' +
        'e" />'
      '<meta content="max-age=0" http-equiv="cache-control" />'
      '<meta content="no-cache" http-equiv="cache-control" />'
      '<meta content="0" http-equiv="expires" />'
      
        '<meta content="Tue, 01 Jan 1980 1:00:00 GMT" http-equiv="expires' +
        '" />'
      '<meta content="no-cache" http-equiv="pragma" />'
      '<title>Apocalypse Coding Group</title>'
      '<style type="text/css">'
      '<#CSS>'
      '</style>'
      ''
      '</head>'
      ''
      '<body class="bodystyle" >'
      ''
      '<#PRE>'
      ''
      '<div class="divCenter">'
      ''
      
        '<form id="Turn" action="<#SCRIPTURL>/SelectAnswer" method="post"' +
        '>'
      #9'<input name="UserID" type="hidden" value="<#UserID>" />'#9
      #9'<div id="Content">'
      #9'  <p>Reading quetions</p>'
      #9'</div>'
      '</form>'
      ''
      '</div>'
      ''
      
        '<#AJAX HTMLSource=turncontent Token=GOSCORE NewTarget=Score With' +
        'Post=Postquestion>'
      ''
      '</body>'
      '</html>')
    OnHTMLTag = TurnHTMLTag
    Left = 232
    Top = 80
  end
  object Score: TPageProducer
    HTMLDoc.Strings = (
      
        '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "' +
        'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
      '<html xmlns="http://www.w3.org/1999/xhtml">'
      ''
      '<head>'
      
        '<meta content="text/html; charset=utf-8" http-equiv="Content-Typ' +
        'e" />'
      '<meta content="max-age=0" http-equiv="cache-control" />'
      '<meta content="no-cache" http-equiv="cache-control" />'
      '<meta content="0" http-equiv="expires" />'
      
        '<meta content="Tue, 01 Jan 1980 1:00:00 GMT" http-equiv="expires' +
        '" />'
      '<meta content="no-cache" http-equiv="pragma" />'
      '<title>Apocalypse Coding Group</title>'
      '<style type="text/css">'
      '<#CSS>'
      '</style>'
      ''
      '</head>'
      ''
      '<body class="bodystyle" >'
      ''
      '<#PRE>'
      ''
      '<div class="divCenter">'
      ''
      '<h2>The Judge has made a desition</h2>'
      ''
      '<#Score>'
      '<#Judge>'
      ''
      '</div>'
      ''
      
        '<#AJAX HTMLSource=WaitNext Param=CardID Token=GOGOGO NewTarget=R' +
        'ungame>'
      ''
      ''
      '</body>'
      ''
      '</html>'
      '')
    OnHTMLTag = ScoreHTMLTag
    Left = 304
    Top = 80
  end
  object Pre: TPageProducer
    HTMLDoc.Strings = (
      '<p>&nbsp;</p>'
      ''
      ''
      
        '<table align="center" style="width: 1280px; height: 763px;" cell' +
        'spacing="1" class="Tablesetting">'
      #9'<tr>'
      
        #9#9'<td style="height: 72px" class="MarkColor"><h1 class="divCente' +
        'r">Apocalypse Coding Group</h1></td>'
      #9#9'<td rowspan="3" style="width: 247px" class="divCenter">'
      
        #9#9'<a href="https://www.youtube.com/watch?v=dbgaHNrDdBs&amp;list=' +
        'PL-oEujJyp0deGinpcUgiZwoa_rPnmgCwN" target="_blank">'
      
        #9#9'<img alt="" class="noBorder" height="114" src="<#IMGURL>Icon.p' +
        'ng" width="210" /></a><br />'
      #9#9'<br />'
      
        #9#9'<a href="http://www.youtube.com/subscription_center?add_user=d' +
        'elphiprofi" target="_blank">'
      
        #9#9'<img alt="" class="noBorder" height="135" src="<#IMGURL>icon2.' +
        'png" width="210" /></a><br />'
      #9#9'<br />'
      
        #9#9'<a href="https://www.youtube.com/watch?v=6_6q6Qxj7ig&amp;list=' +
        'PLeTZrf8Bni042sWDZ7Sco0w8Jw-494eA2" target="_blank">'
      
        #9#9'<img alt="" class="noBorder" height="114" src="<#IMGURL>icon3.' +
        'png" width="210" /></a><br />'
      #9#9'<br />'
      
        #9#9'<a href="https://www.youtube.com/watch?v=eyj6c8r4L9Q&amp;list=' +
        'PLeTZrf8Bni05UB9njIjx1LellxnLpjAFP" target="_blank">'
      
        #9#9'<img alt="" class="noBorder" height="114" src="<#IMGURL>icon4.' +
        'png" width="210" /></a><br />'
      #9#9'<br />'
      
        #9#9'<a href="https://www.youtube.com/channel/UCkfFILmNGDRODMJ6LqsT' +
        '5yQ/featured" target="_blank">'
      
        #9#9'<img alt="" class="noBorder" height="131" src="<#IMGURL>icon5.' +
        'png" width="209" /></a></td>'
      #9'</tr>'
      #9'<tr>'
      #9#9'<td class="apopicture" style="height: 655px">')
    OnHTMLTag = PreHTMLTag
    Left = 88
    Top = 80
  end
  object Css: TPageProducer
    HTMLDoc.Strings = (
      '.MarkColor {'
      #9'background-color: #FFFF00;'
      '}'
      '.apopicture {'
      #9'background-image: url('#39'<#IMGURL>Back.jpg'#39');'
      '}'
      '.Tablesetting {'
      #9'border-collapse: collapse;'
      '}'
      '.copyright {'
      #9'color: #00FFFF;'
      #9'text-align: center;'
      '}'
      '.webadr {'
      #9'color: #00FFFF;'
      '}'
      '.noBorder {'
      #9'border-width: 0px;'
      '}'
      '.divCenter {'
      #9'text-align: center;'
      '}'
      '.LabelInput {'
      '    color: #FF0000;'
      '}'
      '.bodystyle {'
      '  background-color: #000000;'
      '}'
      '.ExceptionCaption {'
      #9'color: #FF0000;'
      #9'text-align: center;'
      '}'
      '.ExceptionMessage {'
      #9'text-align: center;'
      #9'color: #0000FF;'
      '}'
      '.Error {'
      '       height:827px;'
      '       width:1280px;'
      '       src:<#IMGURL>Error.jpg;'
      '}'
      '.DisplayError {'
      '       position: relative;'
      '       width: 503px;'
      '       height: 129px;'
      '       z-index: 1;'
      '       left: -20px;'
      '       top: -745px;'
      '}')
    OnHTMLTag = CssHTMLTag
    Left = 88
    Top = 24
  end
  object post: TPageProducer
    HTMLDoc.Strings = (
      #9#9
      '        </td>'
      #9'</tr>'
      #9'<tr>'
      
        #9#9'<td class="copyright">Webclient (c) by Frank Lauter&nbsp;'#8226'&nbs' +
        'p;Frank@delphiprofi.com&nbsp;'#8226'&nbsp;<a href="http://www.delphipr' +
        'ofi.com" target="_blank">'
      
        '          <span class="webadr">www.delphiprofi.com</span></a>&nb' +
        'sp;'#8226'&nbsp;Idea and supervisor Craig Chapman.'
      '        </td>'
      #9'</tr>'
      '</table>'
      ''
      ''
      '')
    OnHTMLTag = postHTMLTag
    Left = 88
    Top = 136
  end
  object Ajax: TPageProducer
    HTMLDoc.Strings = (
      '<script>'
      ''
      '<#WithPost>'
      ''
      'function fetchdata()'
      '  { var xhttp = new XMLHttpRequest();'
      '    xhttp.onreadystatechange = function()'
      '      {'
      '        if (this.readyState == 4 && this.status == 200)'
      '          {'
      '            <#AJAXRESULT>'
      '          }'
      '       };'
      ''
      
        '  xhttp.open("GET", "<#SCRIPTURL>/<#HTMLSource>?UserID=<#UserID>' +
        '<#Param>&t=" + Math.random(), true);'
      '  xhttp.send();'
      '};'
      ''
      'window.onload = function(){'
      ' <#Error>'
      ' document.getElementById("Content").innerHTML = '#39'preparing...'#39';'
      ' fetchdata();'
      '};'
      ''
      '</script>')
    OnHTMLTag = AjaxHTMLTag
    Left = 88
    Top = 208
  end
  object Question: TPageProducer
    HTMLDoc.Strings = (
      'function Postquestion() {'
      '  document.getElementById('#39'Turn'#39').submit();'
      '};')
    OnHTMLTag = QuestionHTMLTag
    Left = 296
    Top = 208
  end
  object JudgeButtonNext: TPageProducer
    HTMLDoc.Strings = (
      
        '<form action="<#SCRIPTURL>/SelectAnswer" method="post"><br /><in' +
        'put name="UserID" type="hidden" value="<#UserID>"><input name="A' +
        'nswers" type="hidden" value="<#CardID>"><Input type="submit" val' +
        'ue="Next round"></form>')
    OnHTMLTag = JudgeButtonNextHTMLTag
    Left = 440
    Top = 208
  end
  object Error: TPageProducer
    HTMLDoc.Strings = (
      
        '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "' +
        'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
      '<html xmlns="http://www.w3.org/1999/xhtml">'
      ''
      '<head>'
      
        '<meta content="text/html; charset=utf-8" http-equiv="Content-Typ' +
        'e" />'
      '<meta content="max-age=0" http-equiv="cache-control" />'
      '<meta content="no-cache" http-equiv="cache-control" />'
      '<meta content="0" http-equiv="expires" />'
      
        '<meta content="Tue, 01 Jan 1980 1:00:00 GMT" http-equiv="expires' +
        '" />'
      '<meta content="no-cache" http-equiv="pragma" />'
      '<title>Apocalypse Coding Group</title>'
      '<style type="text/css">'
      '<#CSS>'
      '</style>'
      ''
      '</head>'
      ''
      '<body class="bodystyle" >'
      '<center>'
      '<img alt="" class="Error">'
      '<div class="DisplayError" id="layer1">'
      #9'<h1 class="ExceptionCaption">FATAL ERROR</h1>'
      '    <h2 class="ExceptionMessage"><#ERROR></h2>'#9
      '</div>'
      '</center>'
      '</body>'
      '</html>')
    OnHTMLTag = ErrorHTMLTag
    Left = 88
    Top = 288
  end
  object DoSubmit: TPageProducer
    HTMLDoc.Strings = (
      'function DoSubmit(SessionID) {'
      '  oFormObject  = document.forms['#39'Join'#39'];'
      '  oFormObject.elements["SessionID"].value = SessionID;'
      '  document.getElementById('#39'Join'#39').submit();'
      '}')
    OnHTMLTag = DoSubmitHTMLTag
    Left = 360
    Top = 208
  end
  object AjaxResult: TPageProducer
    HTMLDoc.Strings = (
      
        'document.getElementById("Content").innerHTML = this.responseText' +
        ';'
      '            setTimeout(fetchdata,<#PollTimer>);')
    OnHTMLTag = AjaxResultHTMLTag
    Left = 144
    Top = 208
  end
  object AjaxNewTarget: TPageProducer
    HTMLDoc.Strings = (
      ' if (this.responseText == "<#Token>")'
      '              {'
      
        '                window.location = "<#SCRIPTURL>/<#NewTarget>?Use' +
        'rID=<#UserID>";'
      '              }'
      '            else {'
      
        '                   document.getElementById("Content").innerHTML ' +
        '= this.responseText;'
      '                   setTimeout(fetchdata,<#PollTimer>);'
      '                 }')
    OnHTMLTag = AjaxNewTargetHTMLTag
    Left = 216
    Top = 208
  end
  object GameOver: TPageProducer
    HTMLDoc.Strings = (
      '<form action="<#SCRIPTURL>/createOrJoin" method="post">'
      
        '        <input name="Name" type="hidden" style="width: 328px" va' +
        'lue="<#Name>"<br />'
      
        '        <button name="Button" type="submit" value="Create">Creat' +
        'e a new game</button>'
      
        '        <button name="Button" type="submit" value="Join">Join a ' +
        'game</button>'
      '</form>')
    OnHTMLTag = GameOverHTMLTag
    Left = 440
    Top = 288
  end
end
