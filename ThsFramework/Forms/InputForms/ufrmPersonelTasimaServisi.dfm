inherited frmPersonelTasimaServisi: TfrmPersonelTasimaServisi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Personel Taþýma Servisi'
  ClientHeight = 120
  ClientWidth = 313
  Font.Name = 'MS Sans Serif'
  Position = poOwnerFormCenter
  ExplicitWidth = 383
  ExplicitHeight = 162
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 357
    Height = 67
    Color = clWindow
    ParentBackground = True
    ExplicitWidth = 373
    ExplicitHeight = 67
    object lblServisNo: TLabel
      Left = 32
      Top = 6
      Width = 61
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Servis No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblServisAdi: TLabel
      Left = 30
      Top = 28
      Width = 63
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Servis Adý'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtServisNo: TEdit
      Height = 21
      Left = 97
      Width = 200
      TabOrder = 0
      Top = 3
    end
    object edtServisAdi: TEdit
      Height = 21
      Left = 97
      Width = 200
      TabOrder = 1
      Top = 25
    end
  end
  inherited pnlBottom: TPanel
    Top = 71
    Width = 373
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
    Top = 115
    Width = 377
    ExplicitTop = 115
    ExplicitWidth = 377
  end
end
