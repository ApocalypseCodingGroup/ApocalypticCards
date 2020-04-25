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
      ExplicitWidth = 281
      ExplicitHeight = 165
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
      end
    end
    object pgCreateGame: TTabSheet
      Caption = 'pgCreateGame'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = -16
      ExplicitWidth = 609
      ExplicitHeight = 373
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
    BaseURL = 'http://localhost:8080/'
    Params = <>
    Left = 632
    Top = 32
  end
  object tmrPollUsers: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = tmrPollUsersTimer
    Left = 632
    Top = 208
  end
end
