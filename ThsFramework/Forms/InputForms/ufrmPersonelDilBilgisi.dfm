inherited frmPersonelDilBilgisi: TfrmPersonelDilBilgisi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Personel Dil Bilgisi'
  ClientHeight = 239
  ClientWidth = 437
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 443
  ExplicitHeight = 268
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 433
    Height = 173
    Color = clWindow
    ExplicitWidth = 433
    ExplicitHeight = 262
    inherited pgcMain: TPageControl
      Width = 431
      Height = 171
      ExplicitWidth = 431
      ExplicitHeight = 260
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 423
        ExplicitHeight = 232
        object lblDil: TLabel
          Left = 120
          Top = 6
          Width = 16
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Dil'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblKonusmaSeviyesi: TLabel
          Left = 33
          Top = 72
          Width = 103
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Konu'#351'ma Seviyesi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblOkumaSeviyesi: TLabel
          Left = 45
          Top = 28
          Width = 91
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Okuma Seviyesi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblPersonelAd: TLabel
          Left = 67
          Top = 94
          Width = 69
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Personel Ad'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblPersonelSoyad: TLabel
          Left = 47
          Top = 116
          Width = 89
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Personel Soyad'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblYazmaSeviyesi: TLabel
          Left = 47
          Top = 50
          Width = 89
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Yazma Seviyesi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object cbbKonusmaSeviyesi: TComboBox
          Left = 140
          Top = 69
          Width = 200
          Height = 21
          TabOrder = 0
        end
        object cbbOkumaSeviyesi: TComboBox
          Left = 140
          Top = 25
          Width = 200
          Height = 21
          TabOrder = 1
        end
        object cbbYazmaSeviyesi: TComboBox
          Left = 140
          Top = 47
          Width = 200
          Height = 21
          TabOrder = 2
        end
        object edtDil: TEdit
          Left = 140
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 3
        end
        object edtPersonelAd: TEdit
          Left = 140
          Top = 91
          Width = 200
          Height = 21
          TabOrder = 4
        end
        object edtPersonelSoyad: TEdit
          Left = 140
          Top = 113
          Width = 200
          Height = 21
          TabOrder = 5
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 177
    Width = 433
    ExplicitTop = 266
    ExplicitWidth = 433
    inherited btnAccept: TButton
      Left = 224
      ExplicitLeft = 224
    end
    inherited btnClose: TButton
      Left = 328
      ExplicitLeft = 328
    end
  end
  inherited stbBase: TStatusBar
    Top = 221
    Width = 437
    ExplicitTop = 310
    ExplicitWidth = 437
  end
end
