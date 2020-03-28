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
    end>
  Height = 487
  Width = 656
end
