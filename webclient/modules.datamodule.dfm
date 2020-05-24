object mainDataModule: TmainDataModule
  OldCreateOrder = False
  Height = 612
  Width = 813
  object httpGetGames: TWebHttpRequest
    Headers.Strings = (
      'Cache-Control=no-cache, no-store, must-revalidate')
    OnResponse = httpGetGamesResponse
    Left = 96
    Top = 24
  end
  object BasicRequest: TWebHttpRequest
    Headers.Strings = (
      'Cache-Control=no-cache, no-store, must-revalidate')
    OnResponse = BasicRequestResponse
    Left = 216
    Top = 24
  end
  object httpCreateGame: TWebHttpRequest
    Command = httpPOST
    Headers.Strings = (
      'Cache-Control=no-cache, no-store, must-revalidate')
    OnRequestResponse = httpCreateGameRequestResponse
    Left = 88
    Top = 80
  end
end
