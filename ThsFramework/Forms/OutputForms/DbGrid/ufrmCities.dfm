inherited frmCities: TfrmCities
  Caption = 'Cities'
  ClientHeight = 311
  ClientWidth = 548
  ExplicitWidth = 564
  ExplicitHeight = 350
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 544
    Height = 245
    ExplicitWidth = 544
    ExplicitHeight = 245
    inherited splLeft: TSplitter
      Height = 128
      ExplicitHeight = 219
    end
    inherited splHeader: TSplitter
      Width = 542
      ExplicitWidth = 554
    end
    inherited pnlLeft: TPanel
      Height = 125
      ExplicitHeight = 125
    end
    inherited pnlHeader: TPanel
      Width = 538
      ExplicitWidth = 538
    end
    inherited pnlContent: TPanel
      Width = 433
      Height = 125
      ExplicitWidth = 433
      ExplicitHeight = 125
      inherited dbgrdBase: TDBGrid
        Width = 431
        Height = 123
      end
    end
    inherited pnlButtons: TPanel
      Top = 165
      Width = 542
      ExplicitTop = 165
      ExplicitWidth = 542
      inherited flwpnlRight: TFlowPanel
        Width = 333
        ExplicitWidth = 333
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 249
    Width = 544
    ExplicitTop = 249
    ExplicitWidth = 544
    inherited btnAccept: TBitBtn
      Left = 335
      ExplicitLeft = 335
    end
    inherited btnDelete: TBitBtn
      Left = 231
      ExplicitLeft = 231
    end
    inherited btnClose: TBitBtn
      Left = 439
      ExplicitLeft = 439
    end
  end
  inherited stbBase: TStatusBar
    Top = 293
    Width = 548
    ExplicitTop = 293
    ExplicitWidth = 548
  end
end
