inherited frmStokGrubuTuru: TfrmStokGrubuTuru
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Stok Grubu T'#252'r'#252
  ClientHeight = 130
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 350
  ExplicitHeight = 159
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 64
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 64
    inherited pgcMain: TPageControl
      Width = 338
      Height = 62
      ExplicitWidth = 338
      ExplicitHeight = 62
      inherited tsMain: TTabSheet
        ExplicitWidth = 330
        ExplicitHeight = 34
        object lblstok_grubu_tur: TLabel
          Left = 49
          Top = 6
          Width = 20
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'T'#252'r'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edtstok_grubu_tur: TEdit
          Left = 73
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 0
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 68
    Width = 340
    ExplicitTop = 68
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
    Top = 112
    Width = 344
    ExplicitTop = 112
    ExplicitWidth = 344
  end
end
