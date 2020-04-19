object RemoteData: TRemoteData
  OldCreateOrder = False
  Height = 399
  Width = 525
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
        Name = 'GameID'
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
    Interval = 3000
    OnTimer = PollingForUsersTimerTimer
    Left = 432
    Top = 48
  end
end
