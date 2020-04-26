object RemoteData: TRemoteData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 399
  Width = 759
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://apocalypse.chapmanworld.com/api'
    Params = <>
    Left = 24
    Top = 16
  end
  object GameRequest: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <>
    Resource = 'games'
    Response = GameResponse
    SynchronizedEvents = False
    Left = 120
    Top = 24
  end
  object GameResponse: TRESTResponse
    Left = 120
    Top = 80
  end
  object UsersRequest: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <>
    Resource = 'users'
    Response = UsersResponse
    SynchronizedEvents = False
    Left = 216
    Top = 24
  end
  object UsersResponse: TRESTResponse
    ContentType = 'text/html'
    Left = 216
    Top = 80
  end
  object PollingForUsersRequest: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkHTTPHEADER
        Name = 'authentication-string'
      end>
    Resource = 'users'
    Response = PollingForUsersResponse
    SynchronizedEvents = False
    Left = 336
    Top = 24
  end
  object PollingForUsersResponse: TRESTResponse
    ContentType = 'text/html'
    Left = 336
    Top = 80
  end
  object PollingForUsersTimer: TTimer
    Enabled = False
    Interval = 6000
    OnTimer = PollingForUsersTimerTimer
    Left = 336
    Top = 144
  end
  object PollingForGamesRequest: TRESTRequest
    Client = RESTClient1
    Params = <
      item
        Kind = pkHTTPHEADER
        Name = 'authentication-string'
      end>
    Resource = 'games'
    Response = PollingForGamesResponse
    SynchronizedEvents = False
    Left = 488
    Top = 24
  end
  object PollingForGamesResponse: TRESTResponse
    ContentType = 'text/html'
    Left = 488
    Top = 80
  end
  object PollingForGamesTimer: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = PollingForGamesTimerTimer
    Left = 488
    Top = 144
  end
end
