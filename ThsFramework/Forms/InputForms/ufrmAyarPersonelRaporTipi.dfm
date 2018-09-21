inherited frmAyarPersonelRaporTipi: TfrmAyarPersonelRaporTipi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Ayar Personel Rapor Tipi'
  ClientHeight = 95
  ClientWidth = 296
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
    object lblDeger: TLabel
      Left = 31
      Top = 6
      Width = 45
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Deðer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtDeger: TthsEdit
      Height = 21
      Left = 80
      Width = 200
      TabOrder = 0
      Top = 3
      thsAlignment = taLeftJustify
      thsColorActive = clSkyBlue
      thsColorRequiredData = 7367916
      thsTabEnterKeyJump = True
      thsInputDataType = itString
      thsCaseUpLowSupportTr = True
      thsDecimalDigit = 4
      thsRequiredData = True
      thsDoTrim = True
      thsActiveYear = 2018
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
