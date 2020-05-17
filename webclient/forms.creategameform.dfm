inherited CreateGameForm: TCreateGameForm
  Caption = 'CreateGameForm'
  OnCreate = WebFormCreate
  inherited BaseCenterPanel: TWebPanel
    Top = 28
    ExplicitTop = 28
    object WebLabel1: TWebLabel
      Left = 40
      Top = 24
      Width = 66
      Height = 14
      Caption = 'Game Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object WebLabel2: TWebLabel
      Left = 414
      Top = 24
      Width = 54
      Height = 14
      Caption = 'Language'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object WebLabel3: TWebLabel
      Left = 40
      Top = 84
      Width = 56
      Height = 14
      Caption = 'Min Users'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object WebLabel4: TWebLabel
      Left = 272
      Top = 84
      Width = 58
      Height = 14
      Caption = 'Max Users'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object GameNameEdit: TWebEdit
      Left = 40
      Top = 44
      Width = 367
      Height = 22
      ChildOrder = 1
      OnChange = GameNameEditChange
      OnExit = GameNameEditExit
    end
    object WebComboBox1: TWebComboBox
      Left = 414
      Top = 44
      Width = 145
      Height = 22
      Text = 'GB'#11
      ItemIndex = 0
      Items.Strings = (
        'GB'#11
        'DE'
        'FR'
        'KN')
    end
    object PrivateGameCheckbox: TWebCheckBox
      Left = 40
      Top = 197
      Width = 465
      Height = 22
      Caption = '&nbsp;&nbsp;&nbsp;Make game private'
      ChildOrder = 8
      Color = clNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbUnchecked
    end
    object BackButton: TWebButton
      Left = 47
      Top = 317
      Width = 115
      Height = 38
      Caption = 'Back'
      ChildOrder = 11
      ElementClassName = 'btn-warning'
      OnClick = BackButtonClick
    end
    object CreateButton: TWebButton
      Left = 168
      Top = 317
      Width = 115
      Height = 38
      Caption = 'Create game'
      ChildOrder = 11
      ElementClassName = 'btn-success'
      Visible = False
    end
    object SpinMinUsers: TTMSFNCSpinEdit
      AlignWithMargins = True
      Left = 40
      Top = 103
      Width = 169
      Height = 40
      ParentDoubleBuffered = False
      Color = clBtnFace
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      Appearance.ButtonSize = 50
      Appearance.ButtonDownStroke.Color = clBlack
      Appearance.ButtonStroke.Color = clBlack
      Appearance.ButtonStroke.Width = 2.000000000000000000
      Appearance.ButtonShape = bsRectangle
      Appearance.ValueFont.Charset = DEFAULT_CHARSET
      Appearance.ValueFont.Color = clBlack
      Appearance.ValueFont.Height = -24
      Appearance.ValueFont.Name = 'Tahoma'
      Appearance.ValueFont.Style = [fsBold]
      Interaction.RepeatClick = True
      EditFieldPrecision = 2
      Fill.Kind = gfkNone
      Stroke.Kind = gskNone
      Stroke.Color = 14524677
      Max = 7.000000000000000000
      Min = 3.000000000000000000
      Value = 3.000000000000000000
      OnValueChanged = SpinMinUsersValueChanged
    end
    object SpinMaxUsers: TTMSFNCSpinEdit
      AlignWithMargins = True
      Left = 272
      Top = 104
      Width = 169
      Height = 40
      ParentDoubleBuffered = False
      Color = clBtnFace
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      Appearance.ButtonSize = 50
      Appearance.ButtonDownStroke.Color = clBlack
      Appearance.ButtonStroke.Color = clBlack
      Appearance.ButtonStroke.Width = 2.000000000000000000
      Appearance.ButtonShape = bsRectangle
      Appearance.ValueFont.Charset = DEFAULT_CHARSET
      Appearance.ValueFont.Color = clBlack
      Appearance.ValueFont.Height = -24
      Appearance.ValueFont.Name = 'Tahoma'
      Appearance.ValueFont.Style = [fsBold]
      Interaction.RepeatClick = True
      EditFieldPrecision = 2
      Fill.Kind = gfkNone
      Stroke.Kind = gskNone
      Stroke.Color = 14524677
      Max = 10.000000000000000000
      Min = 3.000000000000000000
      Value = 3.000000000000000000
      OnValueChanged = SpinMaxUsersValueChanged
    end
  end
end
