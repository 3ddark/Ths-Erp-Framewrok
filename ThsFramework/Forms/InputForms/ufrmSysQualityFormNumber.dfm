inherited frmSysQualityFormNumber: TfrmSysQualityFormNumber
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'System Quality Fom Number'
  ClientHeight = 142
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 350
  ExplicitHeight = 171
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 76
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 55
    object lblTableName1: TLabel
      Left = 32
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
    object lblFormNo: TLabel
      Left = 53
      Top = 29
      Width = 48
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Form No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsInput: TLabel
      Left = 33
      Top = 51
      Width = 68
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Input Form?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object cbbTableName1: TComboBox
      Left = 105
      Top = 4
      Width = 200
      Height = 21
      TabOrder = 0
    end
    object edtFormNo: TEdit
      Left = 105
      Top = 26
      Width = 200
      Height = 21
      TabOrder = 1
    end
    object chkIsInput: TCheckBox
      Left = 104
      Top = 48
      Width = 201
      Height = 17
      TabOrder = 2
    end
  end
  inherited pnlBottom: TPanel
    Top = 80
    Width = 340
    ExplicitTop = 59
    ExplicitWidth = 340
    inherited btnAccept: TButton
      Left = 131
      ExplicitLeft = 131
    end
    inherited btnDelete: TButton
      Left = 27
      ExplicitLeft = 27
    end
    inherited btnClose: TButton
      Left = 235
      ExplicitLeft = 235
    end
  end
  inherited stbBase: TStatusBar
    Top = 124
    Width = 344
    ExplicitTop = 103
    ExplicitWidth = 344
  end
end
