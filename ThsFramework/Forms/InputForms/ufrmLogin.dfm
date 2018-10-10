inherited frmLogin: TfrmLogin
  BorderStyle = bsDialog
  Caption = 'Login'
  ClientHeight = 270
  ClientWidth = 356
  DefaultMonitor = dmPrimary
  Position = poDesktopCenter
  ExplicitWidth = 362
  ExplicitHeight = 299
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 352
    Height = 204
    ExplicitWidth = 352
    ExplicitHeight = 204
    object lblLanguage: TLabel
      Left = 6
      Top = 5
      Width = 129
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Dil'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblUserName: TLabel
      Left = 6
      Top = 28
      Width = 129
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Kullan'#305'c'#305
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPassword: TLabel
      Left = 6
      Top = 51
      Width = 129
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #350'ifre'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblServer: TLabel
      Left = 6
      Top = 95
      Width = 129
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Sunucu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblServerExample: TLabel
      Left = 6
      Top = 115
      Width = 330
      Height = 13
      AutoSize = False
      Caption = 'ValSunucuOrnek'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDatabase: TLabel
      Left = 6
      Top = 133
      Width = 129
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Database'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPortNo: TLabel
      Left = 6
      Top = 156
      Width = 129
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Port No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbbLanguage: TComboBox
      Left = 141
      Top = 2
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = cbbLanguageChange
    end
    object edtUserName: TEdit
      Left = 141
      Top = 25
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'edtUserName'
    end
    object edtPassword: TEdit
      Left = 141
      Top = 48
      Width = 121
      Height = 21
      PasswordChar = '#'
      TabOrder = 2
      Text = 'thsEdit1'
    end
    object edtServer: TEdit
      Left = 141
      Top = 92
      Width = 121
      Height = 21
      TabOrder = 3
      Text = 'edtServer'
    end
    object edtDatabase: TEdit
      Left = 141
      Top = 130
      Width = 121
      Height = 21
      TabOrder = 4
      Text = 'edtServer'
    end
    object edtPortNo: TEdit
      Left = 141
      Top = 153
      Width = 121
      Height = 21
      TabOrder = 5
      Text = 'edtServer'
    end
    object chkSaveSettings: TCheckBox
      Left = 141
      Top = 176
      Width = 195
      Height = 17
      Caption = 'Save Settings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
  end
  inherited pnlBottom: TPanel
    Top = 208
    Width = 352
    ExplicitTop = 208
    ExplicitWidth = 352
    inherited btnAccept: TButton
      Left = 143
      ExplicitLeft = 143
    end
    inherited btnDelete: TButton
      Left = 39
      ExplicitLeft = 39
    end
    inherited btnClose: TButton
      Left = 247
      ExplicitLeft = 247
    end
  end
  inherited stbBase: TStatusBar
    Top = 252
    Width = 356
    ExplicitTop = 252
    ExplicitWidth = 356
  end
end
