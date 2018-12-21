inherited frmAyarVergiOrani: TfrmAyarVergiOrani
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Ayar Vergi Oran'#305
  ClientHeight = 190
  ClientWidth = 424
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 430
  ExplicitHeight = 219
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 420
    Height = 124
    Color = clWindow
    ExplicitWidth = 346
    ExplicitHeight = 55
    object lblVergiOrani: TLabel
      Left = 146
      Top = 6
      Width = 64
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Vergi Oran'#305
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblSatisVergiHesapKodu: TLabel
      Left = 75
      Top = 28
      Width = 135
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Sat'#305#351' Vergi Hesap Kodu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblSatisIadeVergiHesapKodu: TLabel
      Left = 46
      Top = 50
      Width = 164
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Sat'#305#351' '#304'ade Vergi Hesap Kodu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblAlisVergiHesapKodu: TLabel
      Left = 83
      Top = 72
      Width = 127
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Al'#305#351' Vergi Hesap Kodu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblAlisIadeVergiHesapKodu: TLabel
      Left = 54
      Top = 94
      Width = 156
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Al'#305#351' '#304'ade Vergi Hesap Kodu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtVergiOrani: TEdit
      Left = 214
      Top = 3
      Width = 200
      Height = 21
      TabOrder = 0
    end
    object edtSatisVergiHesapKodu: TEdit
      Left = 214
      Top = 25
      Width = 200
      Height = 21
      TabOrder = 1
    end
    object edtSatisIadeVergiHesapKodu: TEdit
      Left = 214
      Top = 47
      Width = 200
      Height = 21
      TabOrder = 2
    end
    object edtAlisVergiHesapKodu: TEdit
      Left = 214
      Top = 69
      Width = 200
      Height = 21
      TabOrder = 3
    end
    object edtAlisIadeVergiHesapKodu: TEdit
      Left = 214
      Top = 91
      Width = 200
      Height = 21
      TabOrder = 4
    end
  end
  inherited pnlBottom: TPanel
    Top = 128
    Width = 420
    ExplicitTop = 59
    ExplicitWidth = 346
    inherited btnAccept: TButton
      Left = 211
      ExplicitLeft = 137
    end
    inherited btnDelete: TButton
      Left = 25
      ExplicitLeft = 25
    end
    inherited btnClose: TButton
      Left = 315
      ExplicitLeft = 241
    end
  end
  inherited stbBase: TStatusBar
    Top = 172
    Width = 424
    ExplicitTop = 103
    ExplicitWidth = 350
  end
end
