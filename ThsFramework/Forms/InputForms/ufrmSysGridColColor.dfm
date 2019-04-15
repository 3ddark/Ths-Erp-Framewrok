inherited frmSysGridColColor: TfrmSysGridColColor
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Sys Grid Colomn Color'
  ClientHeight = 249
  ClientWidth = 377
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 383
  ExplicitHeight = 278
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 373
    Height = 183
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 373
    ExplicitHeight = 149
    inherited pgcMain: TPageControl
      Width = 371
      Height = 181
      ExplicitWidth = 371
      ExplicitHeight = 147
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 363
        ExplicitHeight = 119
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
        object lblMaxColor: TLabel
          Left = 59
          Top = 122
          Width = 57
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Max Color'
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
          Top = 99
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
        object lblMinColor: TLabel
          Left = 62
          Top = 76
          Width = 54
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Min Color'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblMinValue: TLabel
          Left = 59
          Top = 53
          Width = 57
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Min Value'
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
        object edtMaxColor: TEdit
          Left = 122
          Top = 119
          Width = 240
          Height = 21
          TabOrder = 2
          Text = 'thsEdit1'
          OnDblClick = edtMaxColorDblClick
        end
        object edtMaxValue: TEdit
          Left = 122
          Top = 96
          Width = 240
          Height = 21
          TabOrder = 3
          Text = 'edtmin_value'
        end
        object edtMinColor: TEdit
          Left = 122
          Top = 73
          Width = 240
          Height = 21
          TabOrder = 4
          Text = 'thsEdit1'
          OnDblClick = edtMinColorDblClick
        end
        object edtMinValue: TEdit
          Left = 122
          Top = 50
          Width = 240
          Height = 21
          TabOrder = 5
          Text = 'edtMinValue'
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 187
    Width = 373
    ExplicitTop = 153
    ExplicitWidth = 373
    inherited btnAccept: TButton
      Left = 164
      ExplicitLeft = 164
    end
    inherited btnClose: TButton
      Left = 268
      ExplicitLeft = 268
    end
  end
  inherited stbBase: TStatusBar
    Top = 231
    Width = 377
    ExplicitTop = 197
    ExplicitWidth = 377
  end
end
