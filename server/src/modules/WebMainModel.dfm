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
      MethodType = mtGet
      Name = 'StartGame'
      PathInfo = '/startnew'
      OnAction = WebModule4StartGameAction
    end
    item
      MethodType = mtGet
      Name = 'JoinGame'
      PathInfo = '/joingame'
      OnAction = WebModule4JoinGameAction
    end
    item
      MethodType = mtGet
      Name = 'RESTStartGame'
      PathInfo = '/startjson'
      OnAction = WebModule4RESTStartGameAction
    end
    item
      MethodType = mtGet
      Name = 'RESTJoinGame'
      PathInfo = '/joinjson'
      OnAction = WebModule4RESTJoinGameAction
    end
    item
      Name = 'wactGames'
      PathInfo = '/games'
      OnAction = WebModule4wactGamesAction
    end>
  Height = 487
  Width = 656
  object conn: TFDConnection
    Params.Strings = (
      'Database=apocalypticcards'
      'User_Name=root'
      'Password=TestingDatabase'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 40
    Top = 16
  end
end
