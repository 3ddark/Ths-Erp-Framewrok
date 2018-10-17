inherited frmHesapPlani: TfrmHesapPlani
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Hesap Plano'
  ClientHeight = 170
  ClientWidth = 366
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 372
  ExplicitHeight = 199
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 362
    Height = 104
    Color = clWindow
    ExplicitWidth = 373
    ExplicitHeight = 67
    object lblPlanKoduVarsayilan: TLabel
      Left = 25
      Top = 6
      Width = 121
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Plan Kodu Varsay'#305'lan'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblAciklama: TLabel
      Left = 94
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
    object lblPlanKodu: TLabel
      Left = 87
      Top = 50
      Width = 59
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Plan Kodu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblSeviyeSayisi: TLabel
      Left = 70
      Top = 72
      Width = 76
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Seviye Say'#305's'#305
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtPlanKoduVarsayilan: TEdit
      Left = 150
      Top = 3
      Width = 200
      Height = 21
      TabOrder = 0
    end
    object edtAciklama: TEdit
      Left = 150
      Top = 25
      Width = 200
      Height = 21
      TabOrder = 1
    end
    object edtPlanKodu: TEdit
      Left = 150
      Top = 47
      Width = 200
      Height = 21
      TabOrder = 2
    end
    object edtSeviyeSayisi: TEdit
      Left = 150
      Top = 69
      Width = 200
      Height = 21
      TabOrder = 3
    end
  end
  inherited pnlBottom: TPanel
    Top = 108
    Width = 362
    ExplicitTop = 71
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
    Top = 152
    Width = 366
    ExplicitTop = 115
    ExplicitWidth = 377
  end
end
