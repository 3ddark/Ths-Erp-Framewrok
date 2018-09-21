inherited frmBaseInputDetay: TfrmBaseInputDetay
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'frmBaseInputDetay'
  ClientHeight = 468
  ClientWidth = 674
  Constraints.MinHeight = 150
  Constraints.MinWidth = 350
  ExplicitWidth = 680
  ExplicitHeight = 497
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 670
    Height = 402
    ExplicitWidth = 670
    ExplicitHeight = 402
  end
  inherited pnlBottom: TPanel
    Top = 406
    Width = 670
    ExplicitTop = 406
    ExplicitWidth = 670
    inherited btnAccept: TButton
      Left = 461
      ExplicitLeft = 461
    end
    inherited btnDelete: TButton
      Left = 357
      ExplicitLeft = 357
    end
    inherited btnClose: TButton
      Left = 565
      ExplicitLeft = 565
    end
  end
  inherited stbBase: TStatusBar
    Top = 450
    Width = 674
    ExplicitTop = 450
    ExplicitWidth = 674
  end
end
