inherited frmCity: TfrmCity
  Left = 501
  Top = 443
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'City'
  ClientHeight = 103
  ClientWidth = 372
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 378
  ExplicitHeight = 132
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 368
    Height = 55
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 368
    ExplicitHeight = 55
    object lblCityName: TLabel
      Left = 50
      Top = 6
      Width = 58
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'City Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblCountryName: TLabel
      Left = 28
      Top = 28
      Width = 80
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Country Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtCityName: TfyEdit
      Left = 114
      Top = 3
      Width = 250
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      frhtAlignment = taLeftJustify
      frhtColorActive = clSkyBlue
      frhtColorRequiredData = 7367916
      frhtTabEnterKeyJump = True
      frhtDataInputType = frhtString
      frhtFCaseUpLowSupportTr = True
      frhtSeparatorDecimal = ','
      frhtSeparatorDate = '.'
      frhtSeparatorMoney = '.'
      frhtDecimalDigit = 2
      frhtRequiredData = True
      frhtDoTrim = True
      frhtActiveYear = 2017
    end
    object cbbCountryName: TfyComboBox
      Left = 114
      Top = 25
      Width = 250
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      frhtColorActive = clSkyBlue
      frhtColorRequiredData = 7367916
      frhtTabEnterKeyJump = True
      frhtDataInputType = frhtString
      frhtCaseUpperTr = True
      frhtSeparatorDecimal = ','
      frhtSeparatorDate = '.'
      frhtSeparatorMoney = '.'
      frhtDecimalDigit = 2
      frhtRequiredData = False
      frhtDoTrim = False
      frhtActiveYear = 2018
    end
  end
  inherited pnlBottom: TPanel
    Top = 59
    Width = 368
    ExplicitTop = 59
    ExplicitWidth = 368
    inherited btnAccept: TBitBtn
      Left = 159
      ExplicitLeft = 159
    end
    inherited btnDelete: TBitBtn
      Left = 55
      ExplicitLeft = 55
    end
    inherited btnClose: TBitBtn
      Left = 263
      ExplicitLeft = 263
    end
  end
end
