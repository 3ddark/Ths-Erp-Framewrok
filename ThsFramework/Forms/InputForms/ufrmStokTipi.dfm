inherited frmStokTipi: TfrmStokTipi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Stok Tipi'
  ClientHeight = 145
  ClientWidth = 356
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 362
  ExplicitHeight = 174
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 352
    Height = 79
    Color = clWindow
    ExplicitWidth = 352
    ExplicitHeight = 79
    object lblTip: TLabel
      Left = 117
      Top = 6
      Width = 19
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Tip'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsDefault: TLabel
      Left = 87
      Top = 28
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
    object lblIsStokHareketiYap: TLabel
      Left = 24
      Top = 50
      Width = 112
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Stok Hareketi Yap?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtTip: TthsEdit
      Left = 140
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
    object chkIsDefault: TCheckBox
      Left = 140
      Top = 26
      Width = 200
      Height = 17
      TabOrder = 1
    end
    object chkIsStokHareketiYap: TCheckBox
      Left = 140
      Top = 49
      Width = 200
      Height = 17
      TabOrder = 2
    end
  end
  inherited pnlBottom: TPanel
    Top = 83
    Width = 352
    ExplicitTop = 83
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
    Top = 127
    Width = 356
    ExplicitTop = 127
    ExplicitWidth = 356
  end
end
