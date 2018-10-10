inherited frmUlke: TfrmUlke
  Left = 501
  Top = 44
  Caption = 'Country'
  ClientHeight = 165
  ClientWidth = 352
  ExplicitWidth = 358
  ExplicitHeight = 194
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 348
    Height = 99
    ExplicitWidth = 348
    ExplicitHeight = 99
    object lblcountry_code: TLabel
      Left = 73
      Top = 6
      Width = 23
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Kod'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblCountryName: TLabel
      Left = 47
      Top = 28
      Width = 49
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = #220'lke Ad'#305
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblISOYear: TLabel
      Left = 81
      Top = 52
      Width = 15
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Y'#305'l'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblISOCCTLDCode: TLabel
      Left = 22
      Top = 72
      Width = 74
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'CCTLD Kodu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtCountryCode: TEdit
      Left = 104
      Top = 5
      Width = 234
      Height = 21
      TabOrder = 0
      Text = 'edtCountryCode'
    end
    object edtCountryName: TEdit
      Left = 104
      Top = 27
      Width = 234
      Height = 21
      TabOrder = 1
      Text = 'thsEdit1'
    end
    object edtISOYear: TEdit
      Left = 104
      Top = 49
      Width = 234
      Height = 21
      TabOrder = 2
      Text = 'thsEdit1'
    end
    object edtISOCCTLDCode: TEdit
      Left = 104
      Top = 71
      Width = 234
      Height = 21
      CharCase = ecLowerCase
      TabOrder = 3
      Text = 'thsedit1'
    end
  end
  inherited pnlBottom: TPanel
    Top = 103
    Width = 348
    ExplicitTop = 103
    ExplicitWidth = 348
    inherited btnAccept: TButton
      Left = 139
      ExplicitLeft = 139
    end
    inherited btnDelete: TButton
      Left = 35
      ExplicitLeft = 35
    end
    inherited btnClose: TButton
      Left = 243
      ExplicitLeft = 243
    end
  end
  inherited stbBase: TStatusBar
    Top = 147
    Width = 352
    ExplicitTop = 147
    ExplicitWidth = 352
  end
end
