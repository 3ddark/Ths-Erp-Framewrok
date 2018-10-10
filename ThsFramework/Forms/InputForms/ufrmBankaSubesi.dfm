inherited frmBankaSubesi: TfrmBankaSubesi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Banka '#350'ubeleri'
  ClientHeight = 170
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 350
  ExplicitHeight = 199
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 104
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 104
    object lblBanka: TLabel
      Left = 61
      Top = 6
      Width = 37
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Banka'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblSubeKodu: TLabel
      Left = 35
      Top = 28
      Width = 63
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = #350'ube Kodu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblSubeAdi: TLabel
      Left = 46
      Top = 50
      Width = 52
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = #350'ube Ad'#305
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblSubeIl: TLabel
      Left = 57
      Top = 72
      Width = 41
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = #350'ube '#304'l'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object cbbBanka: TComboBox
      Left = 102
      Top = 3
      Width = 200
      Height = 21
      TabOrder = 0
    end
    object edtSubeKodu: TEdit
      Left = 102
      Top = 25
      Width = 200
      Height = 21
      TabOrder = 1
    end
    object edtSubeAdi: TEdit
      Left = 102
      Top = 47
      Width = 200
      Height = 21
      TabOrder = 2
    end
    object cbbSubeIl: TComboBox
      Left = 102
      Top = 69
      Width = 200
      Height = 21
      TabOrder = 3
    end
  end
  inherited pnlBottom: TPanel
    Top = 108
    Width = 340
    ExplicitTop = 108
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
    Top = 152
    Width = 344
    ExplicitTop = 152
    ExplicitWidth = 344
  end
end
