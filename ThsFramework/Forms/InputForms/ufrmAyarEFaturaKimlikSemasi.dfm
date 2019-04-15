inherited frmAyarEFaturaKimlikSemasi: TfrmAyarEFaturaKimlikSemasi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Ayar E-Fatura Kimlik Semasi'
  ClientHeight = 167
  ClientWidth = 457
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 463
  ExplicitHeight = 196
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 453
    Height = 101
    Color = clWindow
    ExplicitWidth = 453
    ExplicitHeight = 101
    inherited pgcMain: TPageControl
      Width = 451
      Height = 99
      ExplicitWidth = 451
      ExplicitHeight = 99
      inherited tsMain: TTabSheet
        ExplicitWidth = 443
        ExplicitHeight = 71
        object lbldeger: TLabel
          Left = 49
          Top = 6
          Width = 35
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'De'#287'er'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblaciklama: TLabel
          Left = 32
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
        object lblis_active: TLabel
          Left = 50
          Top = 50
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
        object edtdeger: TEdit
          Left = 88
          Top = 3
          Width = 153
          Height = 21
          TabOrder = 0
        end
        object edtaciklama: TEdit
          Left = 88
          Top = 25
          Width = 349
          Height = 21
          TabOrder = 1
        end
        object chkis_active: TCheckBox
          Left = 90
          Top = 47
          Width = 347
          Height = 17
          TabOrder = 2
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 105
    Width = 453
    ExplicitTop = 105
    ExplicitWidth = 453
    inherited btnAccept: TButton
      Left = 244
      ExplicitLeft = 244
    end
    inherited btnClose: TButton
      Left = 348
      ExplicitLeft = 348
    end
  end
  inherited stbBase: TStatusBar
    Top = 149
    Width = 457
    ExplicitTop = 149
    ExplicitWidth = 457
  end
end
