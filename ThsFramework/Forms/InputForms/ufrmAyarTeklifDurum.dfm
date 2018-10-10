inherited frmAyarTeklifDurum: TfrmAyarTeklifDurum
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Ayar Teklif Durum'
  ClientHeight = 145
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 350
  ExplicitHeight = 174
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 79
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 79
    object lblDeger: TLabel
      Left = 53
      Top = 6
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
    object lblAciklama: TLabel
      Left = 36
      Top = 28
      Width = 52
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'A'#231#305'klama'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsActive: TLabel
      Left = 54
      Top = 50
      Width = 34
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Aktif?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtDeger: TEdit
      Left = 92
      Top = 3
      Width = 200
      Height = 21
      TabOrder = 0
    end
    object edtAciklama: TEdit
      Left = 92
      Top = 25
      Width = 200
      Height = 21
      TabOrder = 1
    end
    object chkIsActive: TCheckBox
      Left = 92
      Top = 49
      Width = 200
      Height = 17
      TabOrder = 2
    end
  end
  inherited pnlBottom: TPanel
    Top = 83
    Width = 340
    ExplicitTop = 83
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
    Top = 127
    Width = 344
    ExplicitTop = 127
    ExplicitWidth = 344
  end
end
