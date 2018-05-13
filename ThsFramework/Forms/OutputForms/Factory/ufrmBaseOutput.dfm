inherited frmBaseOutput: TfrmBaseOutput
  Caption = 'Output Base Form'
  ClientHeight = 407
  ClientWidth = 663
  ExplicitWidth = 679
  ExplicitHeight = 446
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelMain: TPanel
    Width = 659
    Height = 359
    ExplicitWidth = 659
    ExplicitHeight = 359
    object splLeft: TSplitter
      Left = 104
      Top = 37
      Height = 321
      Beveled = True
      Color = clBtnFace
      ParentColor = False
      ExplicitLeft = 101
      ExplicitTop = 34
      ExplicitHeight = 213
    end
    object splHeader: TSplitter
      Left = 1
      Top = 34
      Width = 657
      Height = 3
      Cursor = crVSplit
      Align = alTop
      Beveled = True
      Color = clBtnFace
      ParentColor = False
      ExplicitWidth = 484
    end
    object pnlLeft: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 38
      Width = 100
      Height = 318
      Margins.Left = 2
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 2
      Align = alLeft
      Caption = 'pnlLeft'
      Constraints.MinHeight = 100
      Constraints.MinWidth = 100
      TabOrder = 0
    end
    object pnlHeader: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 653
      Height = 30
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 1
      Align = alTop
      Caption = 'Panel1'
      Constraints.MinHeight = 30
      TabOrder = 1
    end
    object pnlContent: TPanel
      AlignWithMargins = True
      Left = 108
      Top = 38
      Width = 548
      Height = 318
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 2
    end
  end
  inherited PanelBottom: TPanel
    Top = 363
    Width = 659
    ExplicitTop = 363
    ExplicitWidth = 659
    inherited btnTamam: TBitBtn
      Left = 450
      ExplicitLeft = 450
    end
    inherited btnSil: TBitBtn
      Left = 346
      ExplicitLeft = 346
    end
    inherited btnKapat: TBitBtn
      Left = 554
      ExplicitLeft = 554
    end
  end
  object pmDB: TPopupMenu
    Left = 208
    Top = 128
  end
end
