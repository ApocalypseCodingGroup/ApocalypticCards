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
      PathInfo = '/api/games'
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
