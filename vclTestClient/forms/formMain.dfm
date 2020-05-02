object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 479
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcMain: TPageControl
    Left = 0
    Top = 0
    Width = 684
    Height = 479
    ActivePage = pgGreenRoom
    Align = alClient
    TabOrder = 0
    object pgWelcome: TTabSheet
      Caption = 'pgWelcome'
      object btnStartGame: TButton
        Left = 224
        Top = 88
        Width = 137
        Height = 41
        Caption = 'Start New Game'
        TabOrder = 0
        OnClick = btnStartGameClick
      end
      object btnJoinGame: TButton
        Left = 224
        Top = 176
        Width = 137
        Height = 41
        Caption = 'Join Existing Game'
        TabOrder = 1
        OnClick = btnJoinGameClick
      end
    end
    object pgCreateGame: TTabSheet
      Caption = 'pgCreateGame'
      ImageIndex = 1
      object Label1: TLabel
        Left = 207
        Top = 29
        Width = 47
        Height = 13
        Caption = 'Language'
      end
      object Label2: TLabel
        Left = 40
        Top = 85
        Width = 46
        Height = 13
        Caption = 'Min Users'
      end
      object Label3: TLabel
        Left = 167
        Top = 85
        Width = 50
        Height = 13
        Caption = 'Max Users'
      end
      object edtGameName: TLabeledEdit
        Left = 40
        Top = 48
        Width = 161
        Height = 21
        EditLabel.Width = 57
        EditLabel.Height = 13
        EditLabel.Caption = 'Game Name'
        TabOrder = 0
        Text = 'test'
      end
      object edtPlayerName: TLabeledEdit
        Left = 40
        Top = 176
        Width = 161
        Height = 21
        EditLabel.Width = 52
        EditLabel.Height = 13
        EditLabel.Caption = 'Your Name'
        TabOrder = 1
        Text = 'Craig'
      end
      object cboLangID: TComboBox
        Left = 207
        Top = 48
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 2
        Text = 'US'
        Items.Strings = (
          'US'
          'GB'
          'DE'
          'IT')
      end
      object spedMinUser: TSpinEdit
        Left = 40
        Top = 104
        Width = 121
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 3
      end
      object spedMaxUser: TSpinEdit
        Left = 167
        Top = 104
        Width = 121
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 4
        Value = 5
      end
      object chkPrivate: TCheckBox
        Left = 40
        Top = 132
        Width = 121
        Height = 17
        Caption = 'Make game private?'
        TabOrder = 5
      end
      object btnCancelCreateGame: TButton
        Left = 40
        Top = 224
        Width = 75
        Height = 25
        Caption = 'Cancel'
        TabOrder = 6
      end
      object btnCreateGame: TButton
        Left = 142
        Top = 224
        Width = 75
        Height = 25
        Caption = 'Create'
        TabOrder = 7
        OnClick = btnCreateGameClick
      end
    end
    object pgGreenRoom: TTabSheet
      Caption = 'pgGreenRoom'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 28
      object lblWaitingToStart: TLabel
        Left = 24
        Top = 16
        Width = 176
        Height = 13
        Caption = 'Waiting for players to join the game.'
      end
      object Label5: TLabel
        Left = 24
        Top = 35
        Width = 176
        Height = 13
        Caption = 'Waiting for players to join the game.'
      end
      object lstPlayers: TListBox
        Left = 136
        Top = 78
        Width = 273
        Height = 241
        ItemHeight = 13
        TabOrder = 0
        OnDblClick = btnStartGame2Click
      end
      object btnStartGame2: TButton
        Left = 334
        Top = 336
        Width = 75
        Height = 25
        Caption = 'Start Game'
        TabOrder = 1
        OnClick = btnStartGame2Click
      end
    end
    object pgJoinGame: TTabSheet
      Caption = 'pgJoinGame'
      ImageIndex = 3
      object Label4: TLabel
        Left = 72
        Top = 72
        Width = 67
        Height = 13
        Caption = 'Select a game'
      end
      object Label6: TLabel
        Left = 56
        Top = 346
        Width = 71
        Height = 13
        Caption = 'Or Specify Key'
      end
      object Label7: TLabel
        Left = 72
        Top = 18
        Width = 51
        Height = 13
        Caption = 'Your name'
      end
      object lstAvailGames: TListBox
        Left = 88
        Top = 91
        Width = 257
        Height = 249
        ItemHeight = 13
        TabOrder = 0
        OnDblClick = btnJoinClick
      end
      object Edit1: TEdit
        Left = 88
        Top = 365
        Width = 257
        Height = 21
        TabOrder = 1
      end
      object btnJoin: TButton
        Left = 270
        Top = 400
        Width = 75
        Height = 25
        Caption = 'Join'
        TabOrder = 2
        OnClick = btnJoinClick
      end
      object edtPlayerName2: TEdit
        Left = 88
        Top = 37
        Width = 257
        Height = 21
        TabOrder = 3
        Text = 'Elon Musk'
      end
    end
  end
  object req: TRESTRequest
    Client = client
    Params = <>
    Response = resp
    SynchronizedEvents = False
    Left = 632
    Top = 88
  end
  object resp: TRESTResponse
    Left = 632
    Top = 144
  end
  object client: TRESTClient
    BaseURL = 'https://apocalypse.chapmanworld.com/api'
    Params = <>
    Left = 632
    Top = 32
  end
  object tmrPollUsers: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = tmrPollUsersTimer
    Left = 576
    Top = 88
  end
  object tmrAvailGames: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = tmrAvailGamesTimer
    Left = 576
    Top = 32
  end
end
