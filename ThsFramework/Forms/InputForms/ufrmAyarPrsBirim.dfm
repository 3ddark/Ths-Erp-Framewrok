inherited frmAyarPrsBirim: TfrmAyarPrsBirim
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Personel Birim'
  ClientHeight = 147
  ClientWidth = 355
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 361
  ExplicitHeight = 176
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 351
    Height = 81
    Color = clWindow
    ExplicitWidth = 351
    ExplicitHeight = 81
    inherited pgcMain: TPageControl
      Width = 349
      Height = 79
      ExplicitWidth = 349
      ExplicitHeight = 79
      inherited tsMain: TTabSheet
        ExplicitWidth = 341
        ExplicitHeight = 51
        object lblbolum_id: TLabel
          Left = 57
          Top = 5
          Width = 35
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'B'#246'l'#252'm'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblbirim: TLabel
          Left = 64
          Top = 27
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
        object edtbolum_id: TEdit
          Left = 96
          Top = 2
          Width = 232
          Height = 21
          TabOrder = 0
        end
        object edtbirim: TEdit
          Left = 96
          Top = 24
          Width = 232
          Height = 21
          TabOrder = 1
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 85
    Width = 351
    ExplicitTop = 85
    ExplicitWidth = 351
    inherited btnAccept: TButton
      Left = 142
      ExplicitLeft = 142
    end
    inherited btnClose: TButton
      Left = 246
      ExplicitLeft = 246
    end
  end
  inherited stbBase: TStatusBar
    Top = 129
    Width = 355
    ExplicitTop = 129
    ExplicitWidth = 355
  end
end
