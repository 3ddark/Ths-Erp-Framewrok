inherited frmBolgeTuru: TfrmBolgeTuru
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'B'#246'lge T'#252'r'#252
  ClientHeight = 121
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 350
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 55
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 55
    object lblTur: TLabel
      Left = 42
      Top = 6
      Width = 20
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'T'#252'r'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtTur: TEdit
      Left = 66
      Top = 3
      Width = 200
      Height = 21
      TabOrder = 0
    end
  end
  inherited pnlBottom: TPanel
    Top = 59
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
    Top = 103
    Width = 344
    ExplicitTop = 103
    ExplicitWidth = 344
  end
end
