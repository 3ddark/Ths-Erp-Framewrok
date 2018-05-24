inherited frmCity: TfrmCity
  Left = 501
  Top = 443
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'City'
  ClientHeight = 134
  ClientWidth = 377
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 383
  ExplicitHeight = 163
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 373
    Height = 68
    Color = clWindow
    ParentBackground = False
    ExplicitWidth = 373
    ExplicitHeight = 68
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
    object edtCityName: TthsEdit
      Left = 114
      Top = 3
      Width = 239
      Height = 21
      TabOrder = 0
      Text = 'edtCityName'
      thsAlignment = taLeftJustify
      thsColorActive = clSkyBlue
      thsColorRequiredData = 7367916
      thsTabEnterKeyJump = True
      thsInputDataType = itString
      thsFCaseUpLowSupportTr = True
      thsDecimalDigit = 4
      thsRequiredData = False
      thsDoTrim = True
      thsActiveYear = 2018
    end
    object cbbCountryName: TComboBox
      Left = 114
      Top = 25
      Width = 239
      Height = 21
      TabOrder = 1
      Text = 'cbbCountryName'
    end
  end
  inherited pnlBottom: TPanel
    Top = 72
    Width = 373
    ExplicitTop = 72
    ExplicitWidth = 373
    inherited btnAccept: TBitBtn
      Left = 164
      ExplicitLeft = 164
    end
    inherited btnDelete: TBitBtn
      Left = 60
      ExplicitLeft = 60
    end
    inherited btnClose: TBitBtn
      Left = 268
      ExplicitLeft = 268
    end
  end
  inherited stbBase: TStatusBar
    Top = 116
    Width = 377
    ExplicitTop = 116
    ExplicitWidth = 377
  end
end
