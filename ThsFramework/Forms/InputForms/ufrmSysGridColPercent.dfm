inherited frmSysGridColPercent: TfrmSysGridColPercent
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'City'
  ClientHeight = 278
  ClientWidth = 388
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 394
  ExplicitHeight = 307
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 384
    Height = 212
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 384
    ExplicitHeight = 212
    object lblTableName: TLabel
      Left = 47
      Top = 7
      Width = 69
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Table Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblColumnName: TLabel
      Left = 38
      Top = 30
      Width = 78
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Column Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblMaxValue: TLabel
      Left = 56
      Top = 53
      Width = 60
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Max Value'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblColorBarBack: TLabel
      Left = 30
      Top = 99
      Width = 86
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Color Bar Back'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblColorBarText: TLabel
      Left = 57
      Top = 122
      Width = 59
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Color Text'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblColorBar: TLabel
      Left = 63
      Top = 76
      Width = 53
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Color Bar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblColorBarTextActive: TLabel
      Left = 17
      Top = 145
      Width = 99
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Color Text Active'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object imgExample: TImage
      Left = 122
      Top = 166
      Width = 240
      Height = 26
    end
    object cbbTableName: TthsCombobox
      Left = 122
      Top = 4
      Width = 240
      Height = 21
      TabOrder = 0
      OnChange = cbbTableNameChange
      thsAlignment = taLeftJustify
      thsColorActive = clSkyBlue
      thsColorRequiredData = 7367916
      thsTabEnterKeyJump = True
      thsInputDataType = itString
      thsCaseUpLowSupportTr = True
      thsDecimalDigit = 4
      thsRequiredData = True
      thsDoTrim = True
      thsActiveYear = 2018
    end
    object cbbColumnName: TthsCombobox
      Left = 122
      Top = 27
      Width = 240
      Height = 21
      TabOrder = 1
      thsAlignment = taLeftJustify
      thsColorActive = clSkyBlue
      thsColorRequiredData = 7367916
      thsTabEnterKeyJump = True
      thsInputDataType = itString
      thsCaseUpLowSupportTr = True
      thsDecimalDigit = 4
      thsRequiredData = True
      thsDoTrim = True
      thsActiveYear = 2018
    end
    object edtMaxValue: TthsEdit
      Left = 122
      Top = 50
      Width = 240
      Height = 21
      TabOrder = 2
      Text = 'edtmin_value'
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
    object edtColorBar: TthsEdit
      Left = 122
      Top = 73
      Width = 240
      Height = 21
      TabOrder = 3
      Text = 'thsEdit1'
      OnDblClick = edtColorBarDblClick
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
    object edtColorBarBack: TthsEdit
      Left = 122
      Top = 96
      Width = 240
      Height = 21
      TabOrder = 4
      Text = 'edtColorBarBack'
      OnDblClick = edtColorBarBackDblClick
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
    object edtColorBarText: TthsEdit
      Left = 122
      Top = 119
      Width = 240
      Height = 21
      TabOrder = 5
      Text = 'thsEdit1'
      OnDblClick = edtColorBarTextDblClick
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
    object edtColorBarTextActive: TthsEdit
      Left = 122
      Top = 142
      Width = 240
      Height = 21
      TabOrder = 6
      Text = 'edtColorBarTextActive'
      OnDblClick = edtColorBarTextActiveDblClick
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
  end
  inherited pnlBottom: TPanel
    Top = 216
    Width = 384
    ExplicitTop = 216
    ExplicitWidth = 384
    inherited btnAccept: TButton
      Left = 175
      ExplicitLeft = 175
    end
    inherited btnDelete: TButton
      Left = 71
      ExplicitLeft = 71
    end
    inherited btnClose: TButton
      Left = 279
      ExplicitLeft = 279
    end
  end
  inherited stbBase: TStatusBar
    Top = 260
    Width = 388
    ExplicitTop = 260
    ExplicitWidth = 388
  end
end
