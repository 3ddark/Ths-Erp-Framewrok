inherited frmSysLangGuiContent: TfrmSysLangGuiContent
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Sys Lang Content'
  ClientHeight = 217
  ClientWidth = 377
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 383
  ExplicitHeight = 246
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 373
    Height = 151
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 373
    ExplicitHeight = 151
    object lblCode: TLabel
      Left = 78
      Top = 30
      Width = 30
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Code'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblLang: TLabel
      Left = 51
      Top = 7
      Width = 57
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Language'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblValue: TLabel
      Left = 75
      Top = 99
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
    object lblIsFactorySetting: TLabel
      Left = 16
      Top = 122
      Width = 92
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Template Ayar'#305'?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblContentType: TLabel
      Left = 31
      Top = 53
      Width = 77
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Content Type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object Label2: TLabel
      Left = 39
      Top = 76
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
    object cbbLang: TComboBox
      Left = 114
      Top = 4
      Width = 239
      Height = 21
      TabOrder = 0
    end
    object edtCode: TEdit
      Left = 114
      Top = 27
      Width = 239
      Height = 21
      TabOrder = 1
    end
    object edtContentType: TEdit
      Left = 114
      Top = 50
      Width = 239
      Height = 21
      TabOrder = 2
    end
    object cbbTableName: TComboBox
      Left = 114
      Top = 73
      Width = 239
      Height = 21
      TabOrder = 3
    end
    object edtValue: TEdit
      Left = 114
      Top = 96
      Width = 239
      Height = 21
      TabOrder = 4
    end
    object chkIsFactorySetting: TCheckBox
      Left = 114
      Top = 121
      Width = 239
      Height = 17
      TabOrder = 5
    end
  end
  inherited pnlBottom: TPanel
    Top = 155
    Width = 373
    ExplicitTop = 155
    ExplicitWidth = 373
    inherited btnAccept: TButton
      Left = 164
      ExplicitLeft = 164
    end
    inherited btnDelete: TButton
      Left = 60
      ExplicitLeft = 60
    end
    inherited btnClose: TButton
      Left = 268
      ExplicitLeft = 268
    end
  end
  inherited stbBase: TStatusBar
    Top = 199
    Width = 377
    ExplicitTop = 199
    ExplicitWidth = 377
  end
end
