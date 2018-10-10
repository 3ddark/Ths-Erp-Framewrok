inherited frmAyarVergiOrani: TfrmAyarVergiOrani
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Ayar Vergi Oran'#305
  ClientHeight = 121
  ClientWidth = 350
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 356
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 346
    Height = 55
    Color = clWindow
    ExplicitWidth = 346
    ExplicitHeight = 55
    object lblVergiOrani: TLabel
      Left = 62
      Top = 6
      Width = 68
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Vergi Orano'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblVergiHesapKodu: TLabel
      Left = 27
      Top = 28
      Width = 103
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Vergi Hesap Kodu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtVergiOrani: TEdit
      Left = 134
      Top = 3
      Width = 200
      Height = 21
      TabOrder = 0
    end
    object edtVergiHesapKodu: TEdit
      Left = 134
      Top = 25
      Width = 200
      Height = 21
      TabOrder = 1
    end
  end
  inherited pnlBottom: TPanel
    Top = 59
    Width = 346
    ExplicitTop = 59
    ExplicitWidth = 346
    inherited btnAccept: TButton
      Left = 137
      ExplicitLeft = 137
    end
    inherited btnDelete: TButton
      Left = 33
      ExplicitLeft = 33
    end
    inherited btnClose: TButton
      Left = 241
      ExplicitLeft = 241
    end
  end
  inherited stbBase: TStatusBar
    Top = 103
    Width = 350
    ExplicitTop = 103
    ExplicitWidth = 350
  end
end
