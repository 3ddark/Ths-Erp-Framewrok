inherited frmSysCity: TfrmSysCity
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = #350'ehir'
  ClientHeight = 173
  ClientWidth = 376
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 382
  ExplicitHeight = 202
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 372
    Height = 107
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 373
    ExplicitHeight = 81
    inherited pgcMain: TPageControl
      Width = 370
      Height = 105
      ExplicitWidth = 371
      ExplicitHeight = 79
      inherited tsMain: TTabSheet
        ExplicitLeft = -36
        ExplicitTop = 288
        ExplicitWidth = 691
        ExplicitHeight = 468
        object lblcountry_id: TLabel
          Left = 59
          Top = 10
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
        object lblcity_name: TLabel
          Left = 56
          Top = 32
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
        object lblcar_plate_code: TLabel
          Left = 42
          Top = 54
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
        object edtcountry_id: TEdit
          Left = 114
          Top = 7
          Width = 239
          Height = 21
          TabOrder = 0
        end
        object edtcity_name: TEdit
          Left = 114
          Top = 29
          Width = 239
          Height = 21
          TabOrder = 1
        end
        object edtcar_plate_code: TEdit
          Left = 114
          Top = 51
          Width = 239
          Height = 21
          TabOrder = 2
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 111
    Width = 372
    ExplicitTop = 85
    ExplicitWidth = 373
    inherited btnAccept: TButton
      Left = 163
      ExplicitLeft = 164
    end
    inherited btnClose: TButton
      Left = 267
      ExplicitLeft = 268
    end
  end
  inherited stbBase: TStatusBar
    Top = 155
    Width = 376
    ExplicitTop = 129
    ExplicitWidth = 377
  end
end
