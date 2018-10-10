inherited frmOlcuBirimi: TfrmOlcuBirimi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = #214'l'#231'c'#252' Birimi'
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
    object lblBirim: TLabel
      Left = 85
      Top = 6
      Width = 28
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Birim'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblEFaturaBirim: TLabel
      Left = 33
      Top = 28
      Width = 80
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'E-Fatura Birim'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblBirimAciklama: TLabel
      Left = 30
      Top = 50
      Width = 83
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Birim A'#231#305'klama'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblIsFloatTip: TLabel
      Left = 55
      Top = 72
      Width = 58
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Float Tip?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object edtBirim: TEdit
      Left = 117
      Top = 3
      Width = 200
      Height = 21
      TabOrder = 0
    end
    object edtEFaturaBirim: TEdit
      Left = 117
      Top = 25
      Width = 200
      Height = 21
      TabOrder = 1
    end
    object edtBirimAciklama: TEdit
      Left = 117
      Top = 47
      Width = 200
      Height = 21
      TabOrder = 2
    end
    object chkIsFloatTip: TCheckBox
      Left = 117
      Top = 72
      Width = 200
      Height = 17
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
