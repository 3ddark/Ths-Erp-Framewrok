inherited frmSysGridDefaultOrderFilter: TfrmSysGridDefaultOrderFilter
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'System Grid Default Order Filter'
  ClientHeight = 171
  ClientWidth = 348
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 354
  ExplicitHeight = 200
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 344
    Height = 105
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 75
    inherited pgcMain: TPageControl
      Width = 342
      Height = 103
      ExplicitWidth = 338
      ExplicitHeight = 73
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 330
        ExplicitHeight = 45
        object lblIsOrder: TLabel
          Left = 47
          Top = 51
          Width = 32
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Order'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblKey: TLabel
          Left = 57
          Top = 7
          Width = 22
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Key'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblValue: TLabel
          Left = 46
          Top = 29
          Width = 33
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Value'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object cbbKey: TComboBox
          Left = 82
          Top = 4
          Width = 248
          Height = 21
          TabOrder = 0
        end
        object chkIsOrder: TCheckBox
          Left = 82
          Top = 50
          Width = 248
          Height = 17
          TabOrder = 1
        end
        object edtValue: TEdit
          Left = 82
          Top = 26
          Width = 248
          Height = 21
          TabOrder = 2
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 109
    Width = 344
    ExplicitTop = 79
    ExplicitWidth = 340
    inherited btnAccept: TButton
      Left = 135
      ExplicitLeft = 131
    end
    inherited btnClose: TButton
      Left = 239
      ExplicitLeft = 235
    end
  end
  inherited stbBase: TStatusBar
    Top = 153
    Width = 348
    ExplicitTop = 123
    ExplicitWidth = 344
  end
end
