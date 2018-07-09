inherited frmSysGridColWidth: TfrmSysGridColWidth
  Left = 501
  Top = 443
  Caption = 'Grid Column Width'
  ClientHeight = 172
  ClientWidth = 381
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 387
  ExplicitHeight = 201
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 377
    Height = 106
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 369
    ExplicitHeight = 106
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
    object cbbTableName: TthsCombobox
      Left = 122
      Top = 4
      Width = 239
      Height = 21
      TabOrder = 0
      OnChange = cbbTableNameChange
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
    object cbbColumnName: TthsCombobox
      Left = 122
      Top = 27
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
      thsRequiredData = True
      thsDoTrim = True
      thsActiveYear = 2018
    end
    object edtColumnWidth: TthsEdit
      Left = 122
      Top = 50
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
    object edtSequenceNo: TthsEdit
      Left = 122
      Top = 73
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
    Width = 377
    ExplicitTop = 110
    ExplicitWidth = 369
    inherited btnAccept: TButton
      Left = 168
      ExplicitLeft = 160
    end
    inherited btnDelete: TButton
      Left = 64
      ExplicitLeft = 56
    end
    inherited btnClose: TButton
      Left = 272
      ExplicitLeft = 264
    end
  end
  inherited stbBase: TStatusBar
    Top = 154
    Width = 381
    ExplicitTop = 154
    ExplicitWidth = 373
  end
end
