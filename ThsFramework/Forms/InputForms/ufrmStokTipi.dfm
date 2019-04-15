inherited frmStokTipi: TfrmStokTipi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Stok Tipi'
  ClientHeight = 174
  ClientWidth = 356
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 362
  ExplicitHeight = 203
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 352
    Height = 108
    Color = clWindow
    ExplicitWidth = 352
    ExplicitHeight = 108
    inherited pgcMain: TPageControl
      Width = 350
      Height = 106
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
        object lblis_default: TLabel
          Left = 87
          Top = 28
          Width = 49
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Default?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblis_stok_hareketi_yap: TLabel
          Left = 24
          Top = 50
          Width = 112
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Stok Hareketi Yap?'
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
        object chkis_default: TCheckBox
          Left = 140
          Top = 26
          Width = 200
          Height = 17
          TabOrder = 1
        end
        object chkis_stok_hareketi_yap: TCheckBox
          Left = 140
          Top = 49
          Width = 200
          Height = 17
          TabOrder = 2
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 112
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
    Top = 156
    Width = 356
    ExplicitTop = 156
    ExplicitWidth = 356
  end
end
