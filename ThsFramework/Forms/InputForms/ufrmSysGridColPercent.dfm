inherited frmSysGridColPercent: TfrmSysGridColPercent
  Left = 501
  Top = 443
  ActiveControl = btnClose
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'City'
  ClientHeight = 278
  ClientWidth = 388
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 394
  ExplicitHeight = 307
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 384
    Height = 212
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 373
    ExplicitHeight = 222
    object lbltable_name: TLabel
      Left = 47
      Top = 5
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
    object lblcolumn_name: TLabel
      Left = 38
      Top = 28
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
    object lblmax_value: TLabel
      Left = 56
      Top = 51
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
    object lblcolor_bar_back: TLabel
      Left = 30
      Top = 97
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
    object lblcolor_bar_text: TLabel
      Left = 57
      Top = 120
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
    object lblcolor_bar: TLabel
      Left = 63
      Top = 74
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
    object lblcolor_bar_text_active: TLabel
      Left = 17
      Top = 143
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
    object Image1: TImage
      Left = 122
      Top = 172
      Width = 240
      Height = 26
    end
    object cbbtable_name: TthsCombobox
      Left = 122
      Top = 2
      Width = 240
      Height = 21
      TabOrder = 0
      OnChange = cbbtable_nameChange
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
    object cbbcolumn_name: TthsCombobox
      Left = 122
      Top = 25
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
    object edtmax_value: TthsEdit
      Left = 122
      Top = 48
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
    object edtcolor_bar: TthsEdit
      Left = 122
      Top = 71
      Width = 240
      Height = 21
      TabOrder = 3
      Text = 'thsEdit1'
      OnDblClick = edtcolor_barDblClick
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
    object edtcolor_bar_back: TthsEdit
      Left = 122
      Top = 94
      Width = 240
      Height = 21
      TabOrder = 4
      Text = 'edtcolor_bar_back'
      OnDblClick = edtcolor_bar_backDblClick
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
    object edtcolor_bar_text: TthsEdit
      Left = 122
      Top = 117
      Width = 240
      Height = 21
      TabOrder = 5
      Text = 'thsEdit1'
      OnDblClick = edtcolor_bar_textDblClick
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
    object edtcolor_bar_text_active: TthsEdit
      Left = 122
      Top = 140
      Width = 240
      Height = 21
      TabOrder = 6
      Text = 'edtcolor_bar_text_active'
      OnDblClick = edtcolor_bar_text_activeDblClick
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
    ExplicitTop = 226
    ExplicitWidth = 373
    inherited btnAccept: TButton
      Left = 175
      ExplicitLeft = 164
    end
    inherited btnDelete: TButton
      Left = 71
      ExplicitLeft = 60
    end
    inherited btnClose: TButton
      Left = 279
      ExplicitLeft = 268
    end
  end
  inherited stbBase: TStatusBar
    Top = 260
    Width = 388
    ExplicitTop = 270
    ExplicitWidth = 377
  end
end
