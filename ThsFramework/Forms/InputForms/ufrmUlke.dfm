inherited frmUlke: TfrmUlke
  Left = 501
  Top = 44
  Caption = 'Country'
  ClientHeight = 211
  ClientWidth = 392
  ExplicitWidth = 398
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 388
    Height = 145
    ExplicitWidth = 376
    ExplicitHeight = 125
    inherited pgcMain: TPageControl
      Width = 386
      Height = 143
      ExplicitWidth = 374
      ExplicitHeight = 123
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 366
        ExplicitHeight = 95
        object lblulke_kodu: TLabel
          Left = 105
          Top = 8
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
        object lblulke_adi: TLabel
          Left = 79
          Top = 30
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
        object lbliso_year: TLabel
          Left = 113
          Top = 52
          Width = 15
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Y'#305'l'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lbliso_cctld_code: TLabel
          Left = 54
          Top = 74
          Width = 74
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'CCTLD Kodu'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblis_ab_uyesi: TLabel
          Left = 76
          Top = 94
          Width = 52
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'AB '#220'yesi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edtulke_kodu: TEdit
          Left = 136
          Top = 5
          Width = 234
          Height = 21
          TabOrder = 0
        end
        object edtulke_adi: TEdit
          Left = 136
          Top = 27
          Width = 234
          Height = 21
          TabOrder = 1
        end
        object edtiso_year: TEdit
          Left = 136
          Top = 49
          Width = 234
          Height = 21
          TabOrder = 2
        end
        object edtiso_cctld_code: TEdit
          Left = 136
          Top = 71
          Width = 234
          Height = 21
          TabOrder = 3
        end
        object chkis_ab_uyesi: TCheckBox
          Left = 136
          Top = 93
          Width = 234
          Height = 17
          TabOrder = 4
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 149
    Width = 388
    ExplicitTop = 129
    ExplicitWidth = 376
    inherited btnAccept: TButton
      Left = 179
      ExplicitLeft = 167
    end
    inherited btnClose: TButton
      Left = 283
      ExplicitLeft = 271
    end
  end
  inherited stbBase: TStatusBar
    Top = 193
    Width = 392
    ExplicitTop = 173
    ExplicitWidth = 380
  end
end
