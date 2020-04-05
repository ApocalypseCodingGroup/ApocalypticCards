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
end
