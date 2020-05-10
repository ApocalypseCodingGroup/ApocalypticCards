object WebModule4: TWebModule4
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
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
    end>
  Height = 487
  Width = 656
end
