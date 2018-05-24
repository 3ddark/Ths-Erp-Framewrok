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
      Left = 73
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
      Left = 47
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
      Left = 81
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
      Left = 22
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
    object edtCountryCode: TthsEdit
      Left = 104
      Top = 5
      Width = 234
      Height = 21
      TabOrder = 0
      Text = 'edtCountryCode'
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
    object edtCountryName: TthsEdit
      Left = 104
      Top = 27
      Width = 234
      Height = 21
      TabOrder = 1
      Text = 'thsEdit1'
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
    object edtISOYear: TthsEdit
      Left = 104
      Top = 49
      Width = 234
      Height = 21
      TabOrder = 2
      Text = 'thsEdit1'
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
    object edtISOCCTLDCode: TthsEdit
      Left = 104
      Top = 71
      Width = 234
      Height = 21
      TabOrder = 3
      Text = 'thsEdit1'
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
