inherited frmSysGridColWidth: TfrmSysGridColWidth
  Left = 501
  Top = 443
  Caption = 'Grid Column Width'
  ClientHeight = 198
  ClientWidth = 392
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 398
  ExplicitHeight = 227
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 388
    Height = 132
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 377
    ExplicitHeight = 106
    inherited pgcMain: TPageControl
      Width = 386
      Height = 130
      ExplicitWidth = 375
      ExplicitHeight = 104
      inherited tsMain: TTabSheet
        ExplicitWidth = 367
        ExplicitHeight = 76
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
        object lblColumnWidth: TLabel
          Left = 37
          Top = 53
          Width = 79
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Column Width'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblSequenceNo: TLabel
          Left = 38
          Top = 76
          Width = 78
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Sequence No'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object cbbTableName: TComboBox
          Left = 122
          Top = 4
          Width = 239
          Height = 21
          TabOrder = 0
          OnChange = cbbTableNameChange
        end
        object cbbColumnName: TComboBox
          Left = 122
          Top = 27
          Width = 239
          Height = 21
          TabOrder = 1
        end
        object edtColumnWidth: TEdit
          Left = 122
          Top = 50
          Width = 239
          Height = 21
          TabOrder = 2
        end
        object edtSequenceNo: TEdit
          Left = 122
          Top = 73
          Width = 239
          Height = 21
          TabOrder = 3
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 136
    Width = 388
    ExplicitTop = 110
    ExplicitWidth = 377
    inherited btnAccept: TButton
      Left = 179
      ExplicitLeft = 168
    end
    inherited btnClose: TButton
      Left = 283
      ExplicitLeft = 272
    end
  end
  inherited stbBase: TStatusBar
    Top = 180
    Width = 392
    ExplicitTop = 154
    ExplicitWidth = 381
  end
end
