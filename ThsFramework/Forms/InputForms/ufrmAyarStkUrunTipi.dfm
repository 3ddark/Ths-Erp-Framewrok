inherited frmAyarStkUrunTipi: TfrmAyarStkUrunTipi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = #220'r'#252'n Tipi'
  ClientHeight = 125
  ClientWidth = 356
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 362
  ExplicitHeight = 154
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 352
    Height = 59
    Color = clWindow
    ExplicitWidth = 352
    ExplicitHeight = 108
    inherited pgcMain: TPageControl
      Width = 350
      Height = 57
      ExplicitWidth = 350
      ExplicitHeight = 106
      inherited tsMain: TTabSheet
        ExplicitWidth = 342
        ExplicitHeight = 78
        object lbltip: TLabel
          Left = 117
          Top = 6
          Width = 19
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Tip'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edttip: TEdit
          Left = 140
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 0
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 63
    Width = 352
    ExplicitTop = 112
    ExplicitWidth = 352
    inherited btnAccept: TButton
      Left = 143
      ExplicitLeft = 143
    end
    inherited btnClose: TButton
      Left = 247
      ExplicitLeft = 247
    end
  end
  inherited stbBase: TStatusBar
    Top = 107
    Width = 356
    ExplicitTop = 156
    ExplicitWidth = 356
  end
end
