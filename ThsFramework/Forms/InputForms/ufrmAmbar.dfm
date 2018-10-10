inherited frmAmbar: TfrmAmbar
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Ambar'
  ClientHeight = 170
  ClientWidth = 412
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 418
  ExplicitHeight = 199
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 408
    Height = 104
    Color = clWindow
    ExplicitWidth = 408
    ExplicitHeight = 104
    object lblAmbarAdi: TLabel
      Left = 134
      Top = 6
      Width = 58
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Ambar Ad'#305
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsVarsayilanHammaddeAmbari: TLabel
      Left = 18
      Top = 28
      Width = 174
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Varsay'#305'lan Hammadde Ambar'#305'?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsVarsayilanUretimAmbari: TLabel
      Left = 44
      Top = 50
      Width = 148
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Varsay'#305'lan '#220'retim Ambar'#305'?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsVarsayilanSatisAmbari: TLabel
      Left = 52
      Top = 72
      Width = 140
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Varsay'#305'lan Sat'#305#351' Ambar'#305'?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtAmbarAdi: TEdit
      Left = 196
      Top = 3
      Width = 200
      Height = 21
      TabOrder = 0
    end
    object chkIsVarsayilanHammaddeAmbari: TCheckBox
      Left = 196
      Top = 26
      Width = 200
      Height = 17
      TabOrder = 1
    end
    object chkIsVarsayilanUretimAmbari: TCheckBox
      Left = 196
      Top = 49
      Width = 200
      Height = 17
      TabOrder = 2
    end
    object chkIsVarsayilanSatisAmbari: TCheckBox
      Left = 196
      Top = 72
      Width = 200
      Height = 17
      TabOrder = 3
    end
  end
  inherited pnlBottom: TPanel
    Top = 108
    Width = 408
    ExplicitTop = 108
    ExplicitWidth = 408
    inherited btnAccept: TButton
      Left = 199
      ExplicitLeft = 199
    end
    inherited btnDelete: TButton
      Left = 95
      ExplicitLeft = 95
    end
    inherited btnClose: TButton
      Left = 303
      ExplicitLeft = 303
    end
  end
  inherited stbBase: TStatusBar
    Top = 152
    Width = 412
    ExplicitTop = 152
    ExplicitWidth = 412
  end
end
