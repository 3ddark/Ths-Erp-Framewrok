inherited frmCurrency: TfrmCurrency
  Left = 501
  Top = 443
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Currency'
  ClientHeight = 176
  ClientWidth = 359
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 365
  ExplicitHeight = 205
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 355
    Height = 110
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 355
    ExplicitHeight = 110
    object lblCode: TLabel
      Left = 78
      Top = 11
      Width = 30
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblSymbol: TLabel
      Left = 67
      Top = 33
      Width = 41
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Symbol'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsDefault: TLabel
      Left = 59
      Top = 57
      Width = 49
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Default?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblCodeComment: TLabel
      Left = 23
      Top = 77
      Width = 85
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Code Comment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object chkIsDefault: TCheckBox
      Left = 114
      Top = 54
      Width = 223
      Height = 17
      TabOrder = 0
    end
    object edtCode: TthsEdit
      Left = 114
      Top = 8
      Width = 223
      Height = 21
      TabOrder = 1
      thsAlignment = taLeftJustify
      thsColorActive = clSkyBlue
      thsColorRequiredData = 7367916
      thsTabEnterKeyJump = True
      thsInputDataType = itString
      thsFCaseUpLowSupportTr = True
      thsDecimalDigit = 4
      thsRequiredData = False
      thsDoTrim = True
      thsActiveYear = 2018
    end
    object edtSymbol: TthsEdit
      Left = 114
      Top = 30
      Width = 223
      Height = 21
      TabOrder = 2
      thsAlignment = taLeftJustify
      thsColorActive = clSkyBlue
      thsColorRequiredData = 7367916
      thsTabEnterKeyJump = True
      thsInputDataType = itString
      thsFCaseUpLowSupportTr = True
      thsDecimalDigit = 4
      thsRequiredData = False
      thsDoTrim = True
      thsActiveYear = 2018
    end
    object edtCodeComment: TthsEdit
      Left = 114
      Top = 74
      Width = 223
      Height = 21
      TabOrder = 3
      thsAlignment = taLeftJustify
      thsColorActive = clSkyBlue
      thsColorRequiredData = 7367916
      thsTabEnterKeyJump = True
      thsInputDataType = itString
      thsFCaseUpLowSupportTr = True
      thsDecimalDigit = 4
      thsRequiredData = False
      thsDoTrim = True
      thsActiveYear = 2018
    end
  end
  inherited pnlBottom: TPanel
    Top = 114
    Width = 355
    ExplicitTop = 114
    ExplicitWidth = 355
    inherited btnAccept: TBitBtn
      Left = 146
      ExplicitLeft = 146
    end
    inherited btnDelete: TBitBtn
      Left = 42
      ExplicitLeft = 42
    end
    inherited btnClose: TBitBtn
      Left = 250
      ExplicitLeft = 250
    end
  end
  inherited stbBase: TStatusBar
    Top = 158
    Width = 359
    ExplicitTop = 158
    ExplicitWidth = 359
  end
end
