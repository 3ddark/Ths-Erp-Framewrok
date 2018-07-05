inherited frmSysGridColWidth: TfrmSysGridColWidth
  Left = 501
  Top = 443
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Grid Column Width'
  ClientHeight = 172
  ClientWidth = 373
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 379
  ExplicitHeight = 201
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 369
    Height = 106
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 369
    ExplicitHeight = 106
    object lbltable_name: TLabel
      Left = 47
      Top = 5
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
    object lblcolumn_name: TLabel
      Left = 38
      Top = 27
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
    object lblcolumn_width: TLabel
      Left = 37
      Top = 49
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
    object lblsequence_no: TLabel
      Left = 38
      Top = 71
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
    object cbbtable_name: TthsCombobox
      Left = 122
      Top = 2
      Width = 239
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      thsAlignment = taLeftJustify
      thsColorActive = clSkyBlue
      thsColorRequiredData = 7367916
      thsTabEnterKeyJump = True
      thsInputDataType = itString
      thsCaseUpLowSupportTr = True
      thsDecimalDigit = 4
      thsRequiredData = True
      thsDoTrim = True
      thsActiveYear = 2018
    end
    object edtColumnName: TthsEdit
      Left = 122
      Top = 24
      Width = 239
      Height = 21
      TabOrder = 1
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
    object edtcolumn_width: TthsEdit
      Left = 122
      Top = 46
      Width = 239
      Height = 21
      TabOrder = 2
      thsAlignment = taLeftJustify
      thsColorActive = clSkyBlue
      thsColorRequiredData = 7367916
      thsTabEnterKeyJump = True
      thsInputDataType = itString
      thsCaseUpLowSupportTr = True
      thsDecimalDigit = 4
      thsRequiredData = True
      thsDoTrim = True
      thsActiveYear = 2018
    end
    object edtsequence_no: TthsEdit
      Left = 122
      Top = 68
      Width = 239
      Height = 21
      TabOrder = 3
      thsAlignment = taLeftJustify
      thsColorActive = clSkyBlue
      thsColorRequiredData = 7367916
      thsTabEnterKeyJump = True
      thsInputDataType = itString
      thsCaseUpLowSupportTr = True
      thsDecimalDigit = 4
      thsRequiredData = True
      thsDoTrim = True
      thsActiveYear = 2018
    end
  end
  inherited pnlBottom: TPanel
    Top = 110
    Width = 369
    ExplicitTop = 110
    ExplicitWidth = 369
    inherited btnAccept: TButton
      Left = 160
      ExplicitLeft = 160
    end
    inherited btnDelete: TButton
      Left = 56
      ExplicitLeft = 56
    end
    inherited btnClose: TButton
      Left = 264
      ExplicitLeft = 264
    end
  end
  inherited stbBase: TStatusBar
    Top = 154
    Width = 373
    ExplicitTop = 154
    ExplicitWidth = 373
  end
end
