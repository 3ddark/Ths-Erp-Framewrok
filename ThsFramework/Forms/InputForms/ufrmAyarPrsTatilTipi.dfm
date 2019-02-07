inherited frmAyarPrsTatilTipi: TfrmAyarPrsTatilTipi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Ayar Personel Tatil Tipi'
  ClientHeight = 121
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
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
    object lbltatil_tipi: TLabel
      Left = 48
      Top = 6
      Width = 51
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Tatil Tipi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblis_resmi_tatil: TLabel
      Left = 28
      Top = 28
      Width = 71
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Resmi Tatil?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edttatil_tipi: TEdit
      Left = 103
      Top = 3
      Width = 200
      Height = 21
      TabOrder = 0
    end
    object chkis_resmi_tatil: TCheckBox
      Left = 103
      Top = 26
      Width = 200
      Height = 17
      TabOrder = 1
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
