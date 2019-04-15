inherited frmSysPermissionSource: TfrmSysPermissionSource
  Left = 501
  Top = 443
  Caption = 'Permission Source'
  ClientHeight = 173
  ClientWidth = 359
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 365
  ExplicitHeight = 202
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 355
    Height = 107
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 355
    ExplicitHeight = 84
    inherited pgcMain: TPageControl
      Width = 353
      Height = 105
      ExplicitWidth = 353
      ExplicitHeight = 82
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 345
        ExplicitHeight = 54
        object lblSourceCode: TLabel
          Left = 34
          Top = 7
          Width = 74
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Source Code'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblSourceGroup: TLabel
          Left = 29
          Top = 53
          Width = 79
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Source Group'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblSourceName: TLabel
          Left = 31
          Top = 30
          Width = 77
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Source Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object cbbSourceGroup: TComboBox
          Left = 114
          Top = 50
          Width = 223
          Height = 21
          Style = csDropDownList
          TabOrder = 0
        end
        object edtSourceCode: TEdit
          Left = 114
          Top = 4
          Width = 223
          Height = 21
          TabOrder = 1
        end
        object edtSourceName: TEdit
          Left = 114
          Top = 27
          Width = 223
          Height = 21
          TabOrder = 2
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 111
    Width = 355
    ExplicitTop = 88
    ExplicitWidth = 355
    inherited btnAccept: TButton
      Left = 146
      ExplicitLeft = 146
    end
    inherited btnClose: TButton
      Left = 250
      ExplicitLeft = 250
    end
  end
  inherited stbBase: TStatusBar
    Top = 155
    Width = 359
    ExplicitTop = 132
    ExplicitWidth = 359
  end
end
