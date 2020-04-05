inherited WelcomeForm: TWelcomeForm
  Caption = 'WelcomeForm'
  inherited BaseCenterPanel: TWebPanel
    BorderStyle = bsNone
    ChildOrder = 2
    Color = 16772810
    object StartButton: TWebButton
      Left = 136
      Top = 40
      Width = 329
      Height = 106
      Caption = 'Start a game'
      ElementClassName = 'btn-primary'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = StartButtonClick
    end
    object JoinGameButton: TWebButton
      Left = 136
      Top = 207
      Width = 329
      Height = 106
      Caption = 'Join a game'
      ChildOrder = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = JoinGameButtonClick
    end
  end
end
