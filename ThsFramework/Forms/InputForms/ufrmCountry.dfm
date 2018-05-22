inherited frmCOuntry: TfrmCOuntry
  Left = 501
  Top = 443
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Country'
  ClientHeight = 176
  ClientWidth = 346
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 352
  ExplicitHeight = 205
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 342
    Height = 110
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 342
    ExplicitHeight = 110
    object lblCountryCode: TLabel
      Left = 53
      Top = 6
      Width = 23
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Kod'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblCountryName: TLabel
      Left = 27
      Top = 28
      Width = 49
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = #220'lke Ad'#305
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblISOYear: TLabel
      Left = 61
      Top = 52
      Width = 15
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Y'#305'l'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblISOCCTLDCode: TLabel
      Left = 2
      Top = 72
      Width = 74
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'CCTLD Kodu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtCountryCode: TfyEdit
      Left = 82
      Top = 3
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
      frhtRequiredData = False
      frhtDoTrim = True
      frhtActiveYear = 2017
    end
    object edtCountryName: TfyEdit
      Left = 82
      Top = 25
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
      frhtRequiredData = False
      frhtDoTrim = True
      frhtActiveYear = 2017
    end
    object edtISOYear: TfyEdit
      Left = 82
      Top = 47
      Width = 250
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
      frhtAlignment = taLeftJustify
      frhtColorActive = clSkyBlue
      frhtColorRequiredData = 7367916
      frhtTabEnterKeyJump = True
      frhtDataInputType = frhtInteger
      frhtFCaseUpLowSupportTr = True
      frhtSeparatorDecimal = ','
      frhtSeparatorDate = '.'
      frhtSeparatorMoney = '.'
      frhtDecimalDigit = 2
      frhtRequiredData = False
      frhtDoTrim = True
      frhtActiveYear = 2017
    end
    object edtISOCCTLDCode: TfyEdit
      Left = 82
      Top = 69
      Width = 250
      Height = 21
      CharCase = ecLowerCase
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
      frhtRequiredData = False
      frhtDoTrim = True
      frhtActiveYear = 2017
    end
  end
  inherited pnlBottom: TPanel
    Top = 114
    Width = 342
    ExplicitTop = 114
    ExplicitWidth = 342
    inherited btnAccept: TBitBtn
      Left = 133
      ExplicitLeft = 133
    end
    inherited btnDelete: TBitBtn
      Left = 29
      ExplicitLeft = 29
    end
    inherited btnClose: TBitBtn
      Left = 237
      ExplicitLeft = 237
    end
  end
  inherited stbBase: TStatusBar
    Top = 158
    Width = 346
    ExplicitTop = 158
    ExplicitWidth = 346
  end
end
