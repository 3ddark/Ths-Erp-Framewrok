inherited frmSehir: TfrmSehir
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = #350'ehir'
  ClientHeight = 169
  ClientWidth = 377
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 383
  ExplicitHeight = 198
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 373
    Height = 103
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 373
    ExplicitHeight = 81
    inherited pgcMain: TPageControl
      Width = 371
      Height = 101
      ExplicitWidth = 371
      ExplicitHeight = 79
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 363
        ExplicitHeight = 51
        object lblPlakaKodu: TLabel
          Left = 42
          Top = 28
          Width = 66
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Plaka Kodu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblSehirAdi: TLabel
          Left = 56
          Top = 6
          Width = 52
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = #350'ehir Ad'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblUlkeAdi: TLabel
          Left = 59
          Top = 50
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
        object edtPlakaKodu: TEdit
          Left = 114
          Top = 25
          Width = 239
          Height = 21
          TabOrder = 0
        end
        object edtSehirAdi: TEdit
          Left = 114
          Top = 3
          Width = 239
          Height = 21
          TabOrder = 1
        end
        object edtUlkeAdi: TEdit
          Left = 114
          Top = 47
          Width = 239
          Height = 21
          TabOrder = 2
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 107
    Width = 373
    ExplicitTop = 85
    ExplicitWidth = 373
    inherited btnAccept: TButton
      Left = 164
      ExplicitLeft = 164
    end
    inherited btnClose: TButton
      Left = 268
      ExplicitLeft = 268
    end
  end
  inherited stbBase: TStatusBar
    Top = 151
    Width = 377
    ExplicitTop = 129
    ExplicitWidth = 377
  end
end
