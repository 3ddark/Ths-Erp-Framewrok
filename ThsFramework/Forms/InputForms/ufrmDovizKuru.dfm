inherited frmDovizKuru: TfrmDovizKuru
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'D'#246'viz Kuru'
  ClientHeight = 171
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 350
  ExplicitHeight = 200
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 105
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 105
    inherited pgcMain: TPageControl
      Width = 338
      Height = 103
      ExplicitWidth = 338
      ExplicitHeight = 103
      inherited tsMain: TTabSheet
        ExplicitWidth = 330
        ExplicitHeight = 75
        object lbltarih: TLabel
          Left = 67
          Top = 6
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
        object lblpara_birimi: TLabel
          Left = 36
          Top = 28
          Width = 61
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Para Birimi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblkur: TLabel
          Left = 77
          Top = 50
          Width = 20
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Kur'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edttarih: TEdit
          Left = 101
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 0
        end
        object edtpara_birimi: TEdit
          Left = 101
          Top = 25
          Width = 200
          Height = 21
          TabOrder = 1
        end
        object edtkur: TEdit
          Left = 101
          Top = 47
          Width = 200
          Height = 21
          TabOrder = 2
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 109
    Width = 340
    ExplicitTop = 109
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
    Top = 153
    Width = 344
    ExplicitTop = 153
    ExplicitWidth = 344
  end
end
