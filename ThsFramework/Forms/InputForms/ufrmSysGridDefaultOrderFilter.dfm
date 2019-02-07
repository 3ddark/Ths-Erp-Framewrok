inherited frmSysGridDefaultOrderFilter: TfrmSysGridDefaultOrderFilter
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'System Grid Default Order Filter'
  ClientHeight = 141
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 350
  ExplicitHeight = 170
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 75
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 75
    object lblKey: TLabel
      Left = 57
      Top = 7
      Width = 22
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Key'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblValue: TLabel
      Left = 46
      Top = 29
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
    object lblIsOrder: TLabel
      Left = 47
      Top = 51
      Width = 32
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Order'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object cbbKey: TComboBox
      Left = 83
      Top = 4
      Width = 248
      Height = 21
      TabOrder = 0
    end
    object edtValue: TEdit
      Left = 83
      Top = 26
      Width = 248
      Height = 21
      TabOrder = 1
    end
    object chkIsOrder: TCheckBox
      Left = 83
      Top = 50
      Width = 248
      Height = 17
      TabOrder = 2
    end
  end
  inherited pnlBottom: TPanel
    Top = 79
    Width = 340
    ExplicitTop = 79
    ExplicitWidth = 340
    inherited btnAccept: TButton
      Left = 131
      ExplicitLeft = 131
    end
    inherited btnClose: TButton
      Left = 235
      ExplicitLeft = 235
    end
  end
  inherited stbBase: TStatusBar
    Top = 123
    Width = 344
    ExplicitTop = 123
    ExplicitWidth = 344
  end
end
