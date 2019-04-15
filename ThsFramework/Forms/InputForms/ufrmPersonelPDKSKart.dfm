inherited frmPersonelPDKSKart: TfrmPersonelPDKSKart
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Personel PDKS Kart'
  ClientHeight = 191
  ClientWidth = 344
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 350
  ExplicitHeight = 220
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 340
    Height = 125
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 104
    inherited pgcMain: TPageControl
      Width = 338
      Height = 123
      ExplicitWidth = 338
      ExplicitHeight = 102
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 330
        ExplicitHeight = 74
        object lblIsActive: TLabel
          Left = 70
          Top = 72
          Width = 34
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
        object lblKartID: TLabel
          Left = 63
          Top = 6
          Width = 41
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
        object lblKartNo: TLabel
          Left = 60
          Top = 50
          Width = 44
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
        object lblPersonelNo: TLabel
          Left = 34
          Top = 28
          Width = 70
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
        object cbbKartNo: TComboBox
          Left = 108
          Top = 47
          Width = 200
          Height = 21
          TabOrder = 0
        end
        object chkIsActive: TCheckBox
          Left = 108
          Top = 72
          Width = 200
          Height = 17
          TabOrder = 1
        end
        object edtKartID: TEdit
          Left = 108
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 2
        end
        object edtPersonelNo: TEdit
          Left = 108
          Top = 25
          Width = 200
          Height = 21
          TabOrder = 3
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 129
    Width = 340
    ExplicitTop = 108
    ExplicitWidth = 340
    inherited btnAccept: TButton
      Left = 131
      ExplicitLeft = 131
    end
    inherited btnClose: TButton
      Left = 235
      ExplicitLeft = 235
    end
  end
  inherited stbBase: TStatusBar
    Top = 173
    Width = 344
    ExplicitTop = 152
    ExplicitWidth = 344
  end
end
