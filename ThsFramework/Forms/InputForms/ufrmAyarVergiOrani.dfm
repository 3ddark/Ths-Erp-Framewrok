inherited frmAyarVergiOrani: TfrmAyarVergiOrani
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Ayar Vergi Oran'#305
  ClientHeight = 237
  ClientWidth = 424
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 430
  ExplicitHeight = 266
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 420
    Height = 171
    Color = clWindow
    ExplicitWidth = 420
    ExplicitHeight = 171
    inherited pgcMain: TPageControl
      Width = 418
      Height = 169
      ExplicitWidth = 418
      ExplicitHeight = 169
      inherited tsMain: TTabSheet
        ExplicitWidth = 410
        ExplicitHeight = 141
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
        object edtAlisIadeVergiHesapKodu: TEdit
          Left = 210
          Top = 91
          Width = 200
          Height = 21
          TabOrder = 0
        end
        object edtAlisVergiHesapKodu: TEdit
          Left = 210
          Top = 69
          Width = 200
          Height = 21
          TabOrder = 1
        end
        object edtSatisIadeVergiHesapKodu: TEdit
          Left = 210
          Top = 47
          Width = 200
          Height = 21
          TabOrder = 2
        end
        object edtSatisVergiHesapKodu: TEdit
          Left = 210
          Top = 25
          Width = 200
          Height = 21
          TabOrder = 3
        end
        object edtVergiOrani: TEdit
          Left = 210
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 4
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 175
    Width = 420
    ExplicitTop = 175
    ExplicitWidth = 420
    inherited btnAccept: TButton
      Left = 211
      ExplicitLeft = 211
    end
    inherited btnClose: TButton
      Left = 315
      ExplicitLeft = 315
    end
  end
  inherited stbBase: TStatusBar
    Top = 219
    Width = 424
    ExplicitTop = 219
    ExplicitWidth = 424
  end
end
