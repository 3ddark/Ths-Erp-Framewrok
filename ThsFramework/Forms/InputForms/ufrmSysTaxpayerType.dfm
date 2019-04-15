inherited frmSysTaxpayerType: TfrmSysTaxpayerType
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Ayar M'#252'kellef Tipi'
  ClientHeight = 154
  ClientWidth = 368
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 374
  ExplicitHeight = 183
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 364
    Height = 88
    Color = clWindow
    ExplicitWidth = 344
    ExplicitHeight = 61
    inherited pgcMain: TPageControl
      Width = 362
      Height = 86
      ExplicitWidth = 342
      ExplicitHeight = 59
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 334
        ExplicitHeight = 31
        object lbltaxpayer_type: TLabel
          Left = 73
          Top = 8
          Width = 35
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'De'#287'er'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblIsDefault: TLabel
          Left = 42
          Top = 35
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
        object edttaxpayer_type: TEdit
          Left = 110
          Top = 5
          Width = 224
          Height = 21
          TabOrder = 0
        end
        object chkIsDefault: TCheckBox
          Left = 110
          Top = 34
          Width = 224
          Height = 17
          TabOrder = 1
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 92
    Width = 364
    ExplicitTop = 65
    ExplicitWidth = 344
    inherited btnAccept: TButton
      Left = 155
      ExplicitLeft = 135
    end
    inherited btnClose: TButton
      Left = 259
      ExplicitLeft = 239
    end
  end
  inherited stbBase: TStatusBar
    Top = 136
    Width = 368
    ExplicitTop = 109
    ExplicitWidth = 348
  end
end
