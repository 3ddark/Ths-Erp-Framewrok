inherited frmSysLang: TfrmSysLang
  Left = 501
  Top = 443
  Caption = 'Language'
  ClientHeight = 121
  ClientWidth = 359
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 365
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 355
    Height = 55
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 355
    ExplicitHeight = 55
    object lblLanguage: TLabel
      Left = 34
      Top = 7
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
    object edtLanguage: TthsEdit
      Left = 114
      Top = 4
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
  end
  inherited pnlBottom: TPanel
    Top = 59
    Width = 355
    ExplicitTop = 59
    ExplicitWidth = 355
    inherited btnAccept: TButton
      Left = 146
      ExplicitLeft = 146
    end
    inherited btnDelete: TButton
      Left = 42
      ExplicitLeft = 42
    end
    inherited btnClose: TButton
      Left = 250
      ExplicitLeft = 250
    end
  end
  inherited stbBase: TStatusBar
    Top = 103
    Width = 359
    ExplicitTop = 103
    ExplicitWidth = 359
  end
end
