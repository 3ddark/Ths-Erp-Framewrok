inherited frmAyarEFaturaIstisnaKodu: TfrmAyarEFaturaIstisnaKodu
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Ayar E-Fatura '#304'stisna Kodu'
  ClientHeight = 211
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 350
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 145
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 104
    inherited pgcMain: TPageControl
      Width = 338
      Height = 143
      ExplicitWidth = 338
      ExplicitHeight = 102
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 330
        ExplicitHeight = 74
        object lblAciklama: TLabel
          Left = 54
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
        object lblFaturaTipi: TLabel
          Left = 44
          Top = 50
          Width = 62
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Fatura Tipi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblIsTamIstisna: TLabel
          Left = 33
          Top = 72
          Width = 73
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Tam '#304'stisna?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblKod: TLabel
          Left = 83
          Top = 6
          Width = 23
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Kod'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object cbbFaturaTipi: TComboBox
          Left = 110
          Top = 47
          Width = 200
          Height = 21
          TabOrder = 0
        end
        object chkIsTamIstisna: TCheckBox
          Left = 110
          Top = 72
          Width = 200
          Height = 17
          TabOrder = 1
        end
        object edtAciklama: TEdit
          Left = 110
          Top = 25
          Width = 200
          Height = 21
          TabOrder = 2
        end
        object edtKod: TEdit
          Left = 110
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 3
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 149
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
    Top = 193
    Width = 344
    ExplicitTop = 152
    ExplicitWidth = 344
  end
end
