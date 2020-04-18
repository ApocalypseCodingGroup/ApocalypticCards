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
    end>
  Height = 487
  Width = 656
end
