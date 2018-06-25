inherited frmSysUserAccessRight: TfrmSysUserAccessRight
  Left = 501
  Top = 443
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Access Right'
  ClientHeight = 244
  ClientWidth = 375
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 381
  ExplicitHeight = 273
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 371
    Height = 178
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 352
    ExplicitHeight = 178
    object lblUserName: TLabel
      Left = 53
      Top = 11
      Width = 63
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'User Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblSourceCode: TLabel
      Left = 42
      Top = 33
      Width = 74
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Source Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsRead: TLabel
      Left = 78
      Top = 58
      Width = 38
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Read?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsAddRecord: TLabel
      Left = 41
      Top = 80
      Width = 75
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Add Record?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsUpdate: TLabel
      Left = 67
      Top = 102
      Width = 49
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Update?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsDelete: TLabel
      Left = 71
      Top = 124
      Width = 45
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Delete?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsSpecial: TLabel
      Left = 66
      Top = 146
      Width = 50
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Special?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object cbbUserName: TthsCombobox
      Left = 122
      Top = 8
      Width = 223
      Height = 21
      TabOrder = 0
      thsAlignment = taLeftJustify
      thsColorActive = clSkyBlue
      thsColorRequiredData = 7367916
      thsTabEnterKeyJump = True
      thsInputDataType = itString
      thsCaseUpLowSupportTr = True
      thsDecimalDigit = 4
      thsRequiredData = False
      thsDoTrim = True
      thsActiveYear = 2018
    end
    object edtSourceCode: TthsEdit
      Left = 122
      Top = 30
      Width = 223
      Height = 21
      TabOrder = 1
      thsAlignment = taLeftJustify
      thsColorActive = clSkyBlue
      thsColorRequiredData = 7367916
      thsTabEnterKeyJump = True
      thsInputDataType = itString
      thsCaseUpLowSupportTr = True
      thsDecimalDigit = 4
      thsRequiredData = False
      thsDoTrim = True
      thsActiveYear = 2018
    end
    object cbxIsRead: TCheckBox
      Left = 122
      Top = 57
      Width = 223
      Height = 17
      TabOrder = 2
    end
    object cbxIsAddRecord: TCheckBox
      Left = 122
      Top = 79
      Width = 223
      Height = 17
      TabOrder = 3
    end
    object cbxIsUpdate: TCheckBox
      Left = 122
      Top = 101
      Width = 223
      Height = 17
      TabOrder = 4
    end
    object cbxIsDelete: TCheckBox
      Left = 122
      Top = 123
      Width = 223
      Height = 17
      TabOrder = 5
    end
    object cbxIsSpecial: TCheckBox
      Left = 122
      Top = 145
      Width = 223
      Height = 17
      TabOrder = 6
    end
  end
  inherited pnlBottom: TPanel
    Top = 182
    Width = 371
    ExplicitTop = 182
    ExplicitWidth = 352
    inherited btnAccept: TButton
      Left = 162
      ExplicitLeft = 143
    end
    inherited btnDelete: TButton
      Left = 58
      ExplicitLeft = 39
    end
    inherited btnClose: TButton
      Left = 266
      ExplicitLeft = 247
    end
  end
  inherited stbBase: TStatusBar
    Top = 226
    Width = 375
    ExplicitTop = 226
    ExplicitWidth = 356
  end
  inherited il16x16: TImageList
    Left = 152
    Top = 112
  end
end
