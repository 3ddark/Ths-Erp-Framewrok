inherited frmParaBirimi: TfrmParaBirimi
  Left = 501
  Top = 443
  Caption = 'Para Birimi'
  ClientHeight = 198
  ClientWidth = 359
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 365
  ExplicitHeight = 227
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 355
    Height = 132
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 355
    ExplicitHeight = 132
    inherited pgcMain: TPageControl
      Width = 353
      Height = 130
      ExplicitWidth = 353
      ExplicitHeight = 130
      inherited tsMain: TTabSheet
        ExplicitWidth = 345
        ExplicitHeight = 102
        object lblKod: TLabel
          Left = 85
          Top = 11
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
        object lblSembol: TLabel
          Left = 66
          Top = 33
          Width = 42
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Sembol'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblIsVarsayilan: TLabel
          Left = 42
          Top = 57
          Width = 66
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Varsay'#305'lan?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblAciklama: TLabel
          Left = 56
          Top = 77
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
        object edtKod: TEdit
          Left = 114
          Top = 8
          Width = 223
          Height = 21
          TabOrder = 0
        end
        object edtSembol: TEdit
          Left = 114
          Top = 30
          Width = 223
          Height = 21
          TabOrder = 1
        end
        object chkIsVarsayilan: TCheckBox
          Left = 114
          Top = 54
          Width = 223
          Height = 17
          TabOrder = 2
        end
        object edtAciklama: TEdit
          Left = 114
          Top = 74
          Width = 223
          Height = 21
          TabOrder = 3
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 136
    Width = 355
    ExplicitTop = 136
    ExplicitWidth = 355
    inherited btnAccept: TButton
      Left = 146
      ExplicitLeft = 146
    end
    inherited btnClose: TButton
      Left = 250
      ExplicitLeft = 250
    end
  end
  inherited stbBase: TStatusBar
    Top = 180
    Width = 359
    ExplicitTop = 180
    ExplicitWidth = 359
  end
end
