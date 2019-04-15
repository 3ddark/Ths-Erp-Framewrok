inherited frmSysPermissionSourceGroup: TfrmSysPermissionSourceGroup
  Left = 501
  Top = 443
  Caption = 'Permission Source Group'
  ClientHeight = 132
  ClientWidth = 352
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 358
  ExplicitHeight = 161
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 348
    Height = 66
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 348
    ExplicitHeight = 55
    inherited pgcMain: TPageControl
      Width = 346
      Height = 64
      ExplicitWidth = 346
      ExplicitHeight = 53
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 338
        ExplicitHeight = 25
        object lblSourceGroup: TLabel
          Left = 29
          Top = 7
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
        object edtSourceGroup: TEdit
          Left = 114
          Top = 4
          Width = 223
          Height = 21
          TabOrder = 0
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 70
    Width = 348
    ExplicitTop = 59
    ExplicitWidth = 348
    inherited btnAccept: TButton
      Left = 139
      ExplicitLeft = 139
    end
    inherited btnClose: TButton
      Left = 243
      ExplicitLeft = 243
    end
  end
  inherited stbBase: TStatusBar
    Top = 114
    Width = 352
    ExplicitTop = 103
    ExplicitWidth = 352
  end
end
