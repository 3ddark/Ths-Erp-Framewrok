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
    Height = 128
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 342
    ExplicitHeight = 128
    object lblCode: TLabel
      Left = 62
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
      Left = 51
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
      Left = 43
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
      Left = 7
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
    object edtCode: TfyEdit
      Left = 98
      Top = 8
      Width = 250
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      frhtAlignment = taLeftJustify
      frhtColorActive = clSkyBlue
      frhtColorRequiredData = 7367916
      frhtTabEnterKeyJump = True
      frhtDataInputType = frhtString
      frhtFCaseUpLowSupportTr = True
      frhtSeparatorDecimal = ','
      frhtSeparatorDate = '.'
      frhtSeparatorMoney = '.'
      frhtDecimalDigit = 2
      frhtRequiredData = True
      frhtDoTrim = True
      frhtActiveYear = 2017
    end
    object edtSymbol: TfyEdit
      Left = 98
      Top = 30
      Width = 250
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      frhtAlignment = taLeftJustify
      frhtColorActive = clSkyBlue
      frhtColorRequiredData = 7367916
      frhtTabEnterKeyJump = True
      frhtDataInputType = frhtString
      frhtFCaseUpLowSupportTr = True
      frhtSeparatorDecimal = ','
      frhtSeparatorDate = '.'
      frhtSeparatorMoney = '.'
      frhtDecimalDigit = 2
      frhtRequiredData = True
      frhtDoTrim = True
      frhtActiveYear = 2017
    end
    object edtCodeComment: TfyEdit
      Left = 98
      Top = 74
      Width = 250
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
      frhtAlignment = taLeftJustify
      frhtColorActive = clSkyBlue
      frhtColorRequiredData = 7367916
      frhtTabEnterKeyJump = True
      frhtDataInputType = frhtString
      frhtFCaseUpLowSupportTr = True
      frhtSeparatorDecimal = ','
      frhtSeparatorDate = '.'
      frhtSeparatorMoney = '.'
      frhtDecimalDigit = 2
      frhtRequiredData = True
      frhtDoTrim = True
      frhtActiveYear = 2017
    end
    object chkIsDefault: TCheckBox
      Left = 98
      Top = 54
      Width = 250
      Height = 17
      TabOrder = 2
    end
  end
  inherited pnlBottom: TPanel
    Top = 132
    Width = 355
    ExplicitTop = 132
    ExplicitWidth = 342
    inherited btnAccept: TBitBtn
      Left = 146
      ExplicitLeft = 133
    end
    inherited btnDelete: TBitBtn
      Left = 42
      ExplicitLeft = 29
    end
    inherited btnClose: TBitBtn
      Left = 250
      ExplicitLeft = 237
    end
  end
end
