inherited frmStokHareketi: TfrmStokHareketi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Stok Hareketi'
  ClientHeight = 190
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 350
  ExplicitHeight = 219
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 124
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 104
    inherited pgcMain: TPageControl
      Width = 338
      Height = 122
      ExplicitWidth = 338
      ExplicitHeight = 102
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 330
        ExplicitHeight = 74
        object lblMiktar: TLabel
          Left = 58
          Top = 28
          Width = 36
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Miktar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblStokKodu: TLabel
          Left = 89
          Top = 6
          Width = 5
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblTarih: TLabel
          Left = 64
          Top = 72
          Width = 30
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Tarih'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblTutar: TLabel
          Left = 63
          Top = 50
          Width = 31
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Tutar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edtMiktar: TEdit
          Left = 98
          Top = 25
          Width = 200
          Height = 21
          TabOrder = 0
        end
        object edtStokKodu: TEdit
          Left = 98
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 1
        end
        object edtTarih: TEdit
          Left = 98
          Top = 69
          Width = 200
          Height = 21
          TabOrder = 2
        end
        object edtTutar: TEdit
          Left = 98
          Top = 47
          Width = 200
          Height = 21
          TabOrder = 3
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 128
    Width = 340
    ExplicitTop = 108
    ExplicitWidth = 340
    inherited btnAccept: TButton
      Left = 131
      ExplicitLeft = 131
    end
    inherited btnClose: TButton
      Left = 235
      ExplicitLeft = 235
    end
  end
  inherited stbBase: TStatusBar
    Top = 172
    Width = 344
    ExplicitTop = 152
    ExplicitWidth = 344
  end
end
