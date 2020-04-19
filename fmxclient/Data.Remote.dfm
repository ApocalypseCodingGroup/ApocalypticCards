object RemoteData: TRemoteData
  OldCreateOrder = False
  Height = 268
  Width = 377
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://apocalypse.chapmanworld.com/api'
    ContentType = 'application/json'
    Params = <>
    Left = 152
    Top = 48
  end
  object GameRequest: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <>
    Resource = 'games'
    Response = GameResponse
    SynchronizedEvents = False
    Left = 144
    Top = 112
  end
  object GameResponse: TRESTResponse
    ContentType = 'application/json'
    Left = 144
    Top = 168
  end
end
