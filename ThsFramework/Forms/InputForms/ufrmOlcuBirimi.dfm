inherited frmOlcuBirimi: TfrmOlcuBirimi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = #214'l'#231'c'#252' Birimi'
  ClientHeight = 193
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 350
  ExplicitHeight = 222
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 127
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 127
    inherited pgcMain: TPageControl
      Width = 338
      Height = 125
      ExplicitWidth = 338
      ExplicitHeight = 125
      inherited tsMain: TTabSheet
        ExplicitWidth = 330
        ExplicitHeight = 97
        object lblbirim: TLabel
          Left = 85
          Top = 6
          Width = 28
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Birim'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblefatura_birim: TLabel
          Left = 33
          Top = 28
          Width = 80
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'E-Fatura Birim'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblbirim_aciklama: TLabel
          Left = 30
          Top = 50
          Width = 83
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Birim A'#231#305'klama'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblis_float_tip: TLabel
          Left = 55
          Top = 72
          Width = 58
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Float Tip?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edtbirim: TEdit
          Left = 117
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 0
        end
        object edtefatura_birim: TEdit
          Left = 117
          Top = 25
          Width = 200
          Height = 21
          TabOrder = 1
        end
        object edtbirim_aciklama: TEdit
          Left = 117
          Top = 47
          Width = 200
          Height = 21
          TabOrder = 2
        end
        object chkis_float_tip: TCheckBox
          Left = 117
          Top = 72
          Width = 200
          Height = 17
          TabOrder = 3
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 131
    Width = 340
    ExplicitTop = 131
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
    Top = 175
    Width = 344
    ExplicitTop = 175
    ExplicitWidth = 344
  end
end
