inherited frmHesapPlani: TfrmHesapPlani
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Hesap Plan'#305
  ClientHeight = 194
  ClientWidth = 372
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 378
  ExplicitHeight = 223
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 368
    Height = 128
    Color = clWindow
    ExplicitWidth = 368
    ExplicitHeight = 128
    inherited pgcMain: TPageControl
      Width = 366
      Height = 126
      ExplicitWidth = 366
      ExplicitHeight = 126
      inherited tsMain: TTabSheet
        ExplicitWidth = 358
        ExplicitHeight = 98
        object lbltek_duzen_kodu: TLabel
          Left = 50
          Top = 6
          Width = 96
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Tek D'#252'zen Kodu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblaciklama: TLabel
          Left = 94
          Top = 28
          Width = 52
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'A'#231#305'klama'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblplan_kodu: TLabel
          Left = 87
          Top = 50
          Width = 59
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Plan Kodu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblseviye_sayisi: TLabel
          Left = 70
          Top = 72
          Width = 76
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Seviye Say'#305's'#305
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edttek_duzen_kodu: TEdit
          Left = 150
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 0
        end
        object edtaciklama: TEdit
          Left = 150
          Top = 25
          Width = 200
          Height = 21
          TabOrder = 1
        end
        object edtplan_kodu: TEdit
          Left = 150
          Top = 47
          Width = 200
          Height = 21
          TabOrder = 2
        end
        object edtseviye_sayisi: TEdit
          Left = 150
          Top = 69
          Width = 200
          Height = 21
          TabOrder = 3
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 132
    Width = 368
    ExplicitTop = 132
    ExplicitWidth = 368
    inherited btnAccept: TButton
      Left = 159
      ExplicitLeft = 159
    end
    inherited btnClose: TButton
      Left = 263
      ExplicitLeft = 263
    end
  end
  inherited stbBase: TStatusBar
    Top = 176
    Width = 372
    ExplicitTop = 176
    ExplicitWidth = 372
  end
end
