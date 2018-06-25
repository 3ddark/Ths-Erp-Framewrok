inherited frmSysPermissionSourceGroup: TfrmSysPermissionSourceGroup
  Left = 501
  Top = 443
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Permission Source Group'
  ClientHeight = 105
  ClientWidth = 359
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 365
  ExplicitHeight = 134
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 355
    Height = 39
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 355
    ExplicitHeight = 39
    object lblSourceGroup: TLabel
      Left = 29
      Top = 11
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
    object edtSourceGroup: TthsEdit
      Left = 114
      Top = 8
      Width = 223
      Height = 21
      TabOrder = 0
      thsAlignment = taLeftJustify
      thsColorActive = clSkyBlue
      thsColorRequiredData = 7367916
      thsTabEnterKeyJump = True
      thsInputDataType = itString
      thsCaseUpLowSupportTr = True
      thsDecimalDigit = 4
      thsRequiredData = False
      thsDoTrim = True
      thsActiveYear = 2018
    end
  end
  inherited pnlBottom: TPanel
    Top = 43
    Width = 355
    ExplicitTop = 43
    ExplicitWidth = 355
    inherited btnAccept: TButton
      Left = 146
      ExplicitLeft = 146
    end
    inherited btnDelete: TButton
      Left = 42
      ExplicitLeft = 42
    end
    inherited btnClose: TButton
      Left = 250
      ExplicitLeft = 250
    end
  end
  inherited stbBase: TStatusBar
    Top = 87
    Width = 359
    ExplicitTop = 87
    ExplicitWidth = 359
  end
end
