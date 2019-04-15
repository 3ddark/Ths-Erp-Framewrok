inherited frmAracTakipArac: TfrmAracTakipArac
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Ara'#231' Takip Ara'#231
  ClientHeight = 347
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 350
  ExplicitHeight = 376
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 281
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 281
    inherited pgcMain: TPageControl
      Width = 338
      Height = 279
      ExplicitWidth = 338
      ExplicitHeight = 279
      inherited tsMain: TTabSheet
        ExplicitWidth = 330
        ExplicitHeight = 251
        object lblMarka: TLabel
          Left = 67
          Top = 6
          Width = 36
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Marka'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblModel: TLabel
          Left = 68
          Top = 28
          Width = 35
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Model'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblPlaka: TLabel
          Left = 70
          Top = 50
          Width = 33
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Plaka'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblRenk: TLabel
          Left = 72
          Top = 72
          Width = 31
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Renk'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblGelisTarihi: TLabel
          Left = 38
          Top = 94
          Width = 65
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Geli'#351' Tarihi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblGelisKM: TLabel
          Left = 52
          Top = 116
          Width = 51
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Geli'#351' KM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblGelisYeri: TLabel
          Left = 48
          Top = 138
          Width = 55
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Geli'#351' Yeri'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblAciklama: TLabel
          Left = 51
          Top = 160
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
        object lblIsActive: TLabel
          Left = 69
          Top = 182
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
        object lblAktifKM: TLabel
          Left = 54
          Top = 204
          Width = 49
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Aktif KM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblAktifKonum: TLabel
          Left = 34
          Top = 226
          Width = 69
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Aktif Konum'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edtMarka: TEdit
          Left = 107
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 0
        end
        object edtModel: TEdit
          Left = 107
          Top = 25
          Width = 200
          Height = 21
          TabOrder = 1
        end
        object edtPlaka: TEdit
          Left = 107
          Top = 47
          Width = 200
          Height = 21
          TabOrder = 2
        end
        object edtRenk: TEdit
          Left = 107
          Top = 69
          Width = 200
          Height = 21
          TabOrder = 3
        end
        object edtGelisTarihi: TEdit
          Left = 107
          Top = 91
          Width = 200
          Height = 21
          TabOrder = 4
        end
        object edtGelisKM: TEdit
          Left = 107
          Top = 113
          Width = 200
          Height = 21
          TabOrder = 5
        end
        object edtGelisYeri: TEdit
          Left = 107
          Top = 135
          Width = 200
          Height = 21
          TabOrder = 6
        end
        object mmoAciklama: TMemo
          Left = 107
          Top = 157
          Width = 200
          Height = 21
          TabOrder = 7
        end
        object chkIsActive: TCheckBox
          Left = 107
          Top = 181
          Width = 200
          Height = 17
          TabOrder = 8
        end
        object edtAktifKM: TEdit
          Left = 107
          Top = 201
          Width = 200
          Height = 21
          TabOrder = 9
        end
        object edtAktifKonum: TEdit
          Left = 107
          Top = 223
          Width = 200
          Height = 21
          TabOrder = 10
        end
        object DateTimePicker1: TDateTimePicker
          Left = 56
          Top = 64
          Width = 186
          Height = 21
          Date = 43525.501526539350000000
          Time = 43525.501526539350000000
          TabOrder = 11
        end
        object DateTimePicker2: TDateTimePicker
          Left = 121
          Top = 86
          Width = 186
          Height = 21
          Date = 43525.501526539350000000
          Time = 43525.501526539350000000
          Kind = dtkTime
          TabOrder = 12
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 285
    Width = 340
    ExplicitTop = 285
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
    Top = 329
    Width = 344
    ExplicitTop = 329
    ExplicitWidth = 344
  end
end
