inherited frmBanka: TfrmBanka
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Banka'
  ClientHeight = 145
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 350
  ExplicitHeight = 174
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 79
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 79
    object lblAdi: TLabel
      Left = 78
      Top = 6
      Width = 19
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Ad'#305
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblSwiftKodu: TLabel
      Left = 35
      Top = 28
      Width = 62
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Swift Kodu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsActive: TLabel
      Left = 63
      Top = 50
      Width = 34
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Aktif?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtAdi: TthsEdit
      Left = 101
      Top = 3
      Width = 200
      Height = 21
      TabOrder = 0
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
    object edtSwiftKodu: TthsEdit
      Left = 101
      Top = 25
      Width = 200
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
    object chkIsActive: TCheckBox
      Left = 101
      Top = 49
      Width = 200
      Height = 17
      TabOrder = 2
    end
  end
  inherited pnlBottom: TPanel
    Top = 83
    Width = 340
    ExplicitTop = 83
    ExplicitWidth = 340
    inherited btnAccept: TButton
      Left = 131
      ExplicitLeft = 131
    end
    inherited btnDelete: TButton
      Left = 27
      ExplicitLeft = 27
    end
    inherited btnClose: TButton
      Left = 235
      ExplicitLeft = 235
    end
  end
  inherited stbBase: TStatusBar
    Top = 127
    Width = 344
    ExplicitTop = 127
    ExplicitWidth = 344
  end
end
