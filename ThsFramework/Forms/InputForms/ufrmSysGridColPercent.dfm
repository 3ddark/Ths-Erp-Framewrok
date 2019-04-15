inherited frmSysGridColPercent: TfrmSysGridColPercent
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'City'
  ClientHeight = 299
  ClientWidth = 388
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 394
  ExplicitHeight = 328
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 384
    Height = 233
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 384
    ExplicitHeight = 212
    inherited pgcMain: TPageControl
      Width = 382
      Height = 231
      ExplicitWidth = 382
      ExplicitHeight = 210
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 374
        ExplicitHeight = 182
        object imgExample: TImage
          Left = 122
          Top = 172
          Width = 240
          Height = 26
        end
        object lblColorBar: TLabel
          Left = 63
          Top = 76
          Width = 53
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Color Bar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblColorBarBack: TLabel
          Left = 30
          Top = 99
          Width = 86
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Color Bar Back'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblColorBarText: TLabel
          Left = 57
          Top = 122
          Width = 59
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Color Text'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblColorBarTextActive: TLabel
          Left = 17
          Top = 145
          Width = 99
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Color Text Active'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblColumnName: TLabel
          Left = 38
          Top = 30
          Width = 78
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Column Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblMaxValue: TLabel
          Left = 56
          Top = 53
          Width = 60
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Max Value'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblTableName: TLabel
          Left = 47
          Top = 7
          Width = 69
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Table Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object cbbColumnName: TComboBox
          Left = 122
          Top = 27
          Width = 240
          Height = 21
          TabOrder = 0
        end
        object cbbTableName: TComboBox
          Left = 122
          Top = 4
          Width = 240
          Height = 21
          TabOrder = 1
          OnChange = cbbTableNameChange
        end
        object edtColorBar: TEdit
          Left = 122
          Top = 73
          Width = 240
          Height = 21
          TabOrder = 2
          Text = 'thsEdit1'
          OnDblClick = edtColorBarDblClick
        end
        object edtColorBarBack: TEdit
          Left = 122
          Top = 96
          Width = 240
          Height = 21
          TabOrder = 3
          Text = 'edtColorBarBack'
          OnDblClick = edtColorBarBackDblClick
        end
        object edtColorBarText: TEdit
          Left = 122
          Top = 119
          Width = 240
          Height = 21
          TabOrder = 4
          Text = 'thsEdit1'
          OnDblClick = edtColorBarTextDblClick
        end
        object edtColorBarTextActive: TEdit
          Left = 122
          Top = 142
          Width = 240
          Height = 21
          TabOrder = 5
          Text = 'edtColorBarTextActive'
          OnDblClick = edtColorBarTextActiveDblClick
        end
        object edtMaxValue: TEdit
          Left = 122
          Top = 50
          Width = 240
          Height = 21
          TabOrder = 6
          Text = 'edtmin_value'
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 237
    Width = 384
    ExplicitTop = 216
    ExplicitWidth = 384
    inherited btnAccept: TButton
      Left = 175
      ExplicitLeft = 175
    end
    inherited btnClose: TButton
      Left = 279
      ExplicitLeft = 279
    end
  end
  inherited stbBase: TStatusBar
    Top = 281
    Width = 388
    ExplicitTop = 260
    ExplicitWidth = 388
  end
end
