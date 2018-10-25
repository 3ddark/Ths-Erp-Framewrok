inherited frmAyarFirmaTipi: TfrmAyarFirmaTipi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Ayar Firma Tipi'
  ClientHeight = 121
  ClientWidth = 359
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 365
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 355
    Height = 55
    Color = clWindow
    ExplicitWidth = 355
    ExplicitHeight = 55
    object lblFirmaTuru: TLabel
      Left = 69
      Top = 7
      Width = 61
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Firma T'#252'r'#252
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblFirmaTipi: TLabel
      Left = 77
      Top = 29
      Width = 56
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Firma Tipi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object cbbFirmaTuru: TComboBox
      Left = 137
      Top = 4
      Width = 208
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object edtFirmaTipi: TEdit
      Left = 137
      Top = 26
      Width = 208
      Height = 21
      TabOrder = 1
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
