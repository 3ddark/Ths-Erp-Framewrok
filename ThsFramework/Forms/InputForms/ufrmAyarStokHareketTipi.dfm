inherited frmAyarStokHareketTipi: TfrmAyarStokHareketTipi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Ayar Stok Hareket Tipi'
  ClientHeight = 171
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 350
  ExplicitHeight = 200
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 105
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 105
    object lblDeger: TLabel
      Left = 42
      Top = 21
      Width = 35
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'De'#287'er'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsInput: TLabel
      Left = 40
      Top = 43
      Width = 37
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Input?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtDeger: TEdit
      Left = 81
      Top = 18
      Width = 240
      Height = 21
      TabOrder = 0
    end
  end
  inherited pnlBottom: TPanel
    Top = 109
    Width = 340
    ExplicitTop = 109
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
    Top = 153
    Width = 344
    ExplicitTop = 153
    ExplicitWidth = 344
  end
  object chkIsInput: TCheckBox [3]
    Left = 83
    Top = 44
    Width = 240
    Height = 17
    TabOrder = 3
  end
end
