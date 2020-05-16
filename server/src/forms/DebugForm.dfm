object Form4: TForm4
  Left = 271
  Top = 114
  Caption = 'Form4'
  ClientHeight = 235
  ClientWidth = 399
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 48
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object ButtonStart: TButton
    Left = 24
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Starten'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 105
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Anhalten'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object EditPort: TEdit
    Left = 24
    Top = 67
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '8080'
  end
  object ButtonOpenBrowser: TButton
    Left = 24
    Top = 112
    Width = 107
    Height = 25
    Caption = 'Browser '#246'ffnen'
    TabOrder = 3
    OnClick = ButtonOpenBrowserClick
  end
  object Button1: TButton
    Left = 137
    Top = 112
    Width = 115
    Height = 25
    Caption = '4 Craig'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 137
    Top = 143
    Width = 115
    Height = 25
    Caption = '4 Elon'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 258
    Top = 112
    Width = 115
    Height = 25
    Caption = '4 Frank'
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 24
    Top = 191
    Width = 107
    Height = 25
    Caption = 'DEBUG'
    TabOrder = 7
    OnClick = Button4Click
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 288
    Top = 24
  end
end
