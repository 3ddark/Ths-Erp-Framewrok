inherited frmStokCinsAilesi: TfrmStokCinsAilesi
  Left = 501
  Top = 443
  ActiveControl = btnClose
  Caption = 'Cins Ailesi'
  ClientHeight = 130
  ClientWidth = 348
  Font.Name = 'MS Sans Serif'
  Position = poDesktopCenter
  ExplicitWidth = 354
  ExplicitHeight = 159
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 344
    Height = 64
    Color = clWindow
    ExplicitWidth = 340
    ExplicitHeight = 55
    inherited pgcMain: TPageControl
      Width = 342
      Height = 62
      ExplicitWidth = 338
      ExplicitHeight = 53
      inherited tsMain: TTabSheet
        ExplicitWidth = 330
        ExplicitHeight = 25
        object lblaile: TLabel
          Left = 66
          Top = 6
          Width = 22
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdLeftToRight
          Caption = 'Aile'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object edtaile: TEdit
          Left = 92
          Top = 3
          Width = 200
          Height = 21
          TabOrder = 0
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 68
    Width = 344
    ExplicitTop = 59
    ExplicitWidth = 340
    inherited btnAccept: TButton
      Left = 135
      ExplicitLeft = 131
    end
    inherited btnClose: TButton
      Left = 239
      ExplicitLeft = 235
    end
  end
  inherited stbBase: TStatusBar
    Top = 112
    Width = 348
    ExplicitTop = 103
    ExplicitWidth = 344
  end
end
