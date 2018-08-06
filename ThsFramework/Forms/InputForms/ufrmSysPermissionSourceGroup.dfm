inherited frmSysPermissionSourceGroup: TfrmSysPermissionSourceGroup
  Left = 501
  Top = 443
  Caption = 'Permission Source Group'
  ClientHeight = 121
  ClientWidth = 352
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 358
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 348
    Height = 55
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 348
    ExplicitHeight = 55
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
    object edtSourceGroup: TthsEdit
      Left = 114
      Top = 4
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
    Top = 59
    Width = 348
    ExplicitTop = 59
    ExplicitWidth = 348
    inherited btnAccept: TButton
      Left = 139
      ExplicitLeft = 139
    end
    inherited btnDelete: TButton
      Left = 35
      ExplicitLeft = 35
    end
    inherited btnClose: TButton
      Left = 243
      ExplicitLeft = 243
    end
  end
  inherited stbBase: TStatusBar
    Top = 103
    Width = 352
    ExplicitTop = 103
    ExplicitWidth = 352
  end
end
