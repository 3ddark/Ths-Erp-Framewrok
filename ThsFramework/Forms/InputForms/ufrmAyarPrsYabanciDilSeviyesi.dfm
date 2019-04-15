inherited frmAyarPrsYabanciDilSeviyesi: TfrmAyarPrsYabanciDilSeviyesi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Ayar Personel Dil Seviyesi'
  ClientHeight = 121
  ClientWidth = 362
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 368
  ExplicitHeight = 150
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 358
    Height = 55
    Color = clWindow
    ExplicitWidth = 358
    ExplicitHeight = 55
    inherited pgcMain: TPageControl
      Width = 356
      Height = 53
      ExplicitWidth = 356
      ExplicitHeight = 53
      inherited tsMain: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 348
        ExplicitHeight = 25
        object lblyabanci_dil_seviyesi: TLabel
          Left = 31
          Top = 6
          Width = 117
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Yabanc'#305' Dil Seviyesi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edtyabanci_dil_seviyesi: TEdit
          Left = 148
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 0
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 59
    Width = 358
    ExplicitTop = 59
    ExplicitWidth = 358
    inherited btnAccept: TButton
      Left = 149
      ExplicitLeft = 149
    end
    inherited btnClose: TButton
      Left = 253
      ExplicitLeft = 253
    end
  end
  inherited stbBase: TStatusBar
    Top = 103
    Width = 362
    ExplicitTop = 103
    ExplicitWidth = 362
  end
end
