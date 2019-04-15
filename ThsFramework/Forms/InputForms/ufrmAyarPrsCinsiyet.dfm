inherited frmAyarPrsCinsiyet: TfrmAyarPrsCinsiyet
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Ayar Cinsiyet'
  ClientHeight = 173
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 350
  ExplicitHeight = 202
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 107
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 55
    inherited pgcMain: TPageControl
      Width = 338
      Height = 105
      ExplicitWidth = 338
      ExplicitHeight = 53
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 26
        ExplicitWidth = 330
        ExplicitHeight = 25
        object lblcinsiyet: TLabel
          Left = 69
          Top = 34
          Width = 45
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Cinsiyet'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblis_man: TLabel
          Left = 73
          Top = 12
          Width = 41
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Erkek?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object chkis_man: TCheckBox
          Left = 120
          Top = 8
          Width = 200
          Height = 17
          TabOrder = 0
        end
        object edtcinsiyet: TEdit
          Left = 120
          Top = 31
          Width = 200
          Height = 21
          TabOrder = 1
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 111
    Width = 340
    ExplicitTop = 59
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
    Top = 155
    Width = 344
    ExplicitTop = 103
    ExplicitWidth = 344
  end
end
