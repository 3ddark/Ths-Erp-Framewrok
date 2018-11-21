inherited frmPersonelPDKSKart: TfrmPersonelPDKSKart
  Left = 501
  Top = 443
  ActiveControl = btnClose
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Personel PDKS Kart'
  ClientHeight = 170
  ClientWidth = 324
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
    object lblKartID: TLabel
      Left = 54
      Top = 6
      Width = 50
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Kart ID'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblPersonelNo: TLabel
      Left = 31
      Top = 28
      Width = 73
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Personel No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblKartNo: TLabel
      Left = 52
      Top = 50
      Width = 52
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Kart No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsActive: TLabel
      Left = 61
      Top = 72
      Width = 43
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
    object edtKartID: TEdit
      Height = 21
      Left = 108
      Width = 200
      TabOrder = 0
      Top = 3
    end
    object edtPersonelNo: TEdit
      Height = 21
      Left = 108
      Width = 200
      TabOrder = 1
      Top = 25
    end
    object cbbKartNo: TComboBox
      Height = 21
      Left = 108
      Width = 200
      TabOrder = 2
      Top = 47
    end
    object chkIsActive: TCheckBox
      Height = 17
      Left = 108
      Width = 200
      TabOrder = 3
      Top = 72
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
