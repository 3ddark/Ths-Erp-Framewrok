inherited frmSysCountry: TfrmSysCountry
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
    ExplicitWidth = 388
    ExplicitHeight = 145
    inherited pgcMain: TPageControl
      Width = 386
      Height = 143
      ExplicitWidth = 386
      ExplicitHeight = 143
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 378
        ExplicitHeight = 115
        object lblcountry_code: TLabel
          Left = 51
          Top = 8
          Width = 77
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Country Code'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblcountry_name: TLabel
          Left = 48
          Top = 30
          Width = 80
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Country Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lbliso_year: TLabel
          Left = 101
          Top = 52
          Width = 27
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Year'
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
          Caption = 'CCTLD Code'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblis_eu_member: TLabel
          Left = 62
          Top = 94
          Width = 66
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'EU Member'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edtcountry_code: TEdit
          Left = 136
          Top = 5
          Width = 234
          Height = 21
          TabOrder = 0
        end
        object edtcountry_name: TEdit
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
        object chkis_eu_member: TCheckBox
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
    ExplicitTop = 149
    ExplicitWidth = 388
    inherited btnAccept: TButton
      Left = 179
      ExplicitLeft = 179
    end
    inherited btnClose: TButton
      Left = 283
      ExplicitLeft = 283
    end
  end
  inherited stbBase: TStatusBar
    Top = 193
    Width = 392
    ExplicitTop = 193
    ExplicitWidth = 392
  end
end
