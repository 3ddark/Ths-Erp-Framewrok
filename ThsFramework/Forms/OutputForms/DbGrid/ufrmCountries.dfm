inherited frmCountries: TfrmCountries
  Caption = 'Ulkeler'
  ClientHeight = 311
  ClientWidth = 548
  ExplicitWidth = 564
  ExplicitHeight = 350
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 544
    Height = 244
    ExplicitWidth = 544
    ExplicitHeight = 244
    inherited splLeft: TSplitter
      Height = 127
      ExplicitHeight = 219
    end
    inherited splHeader: TSplitter
      Width = 542
      ExplicitWidth = 554
    end
    inherited pnlLeft: TPanel
      Height = 124
      ExplicitHeight = 124
    end
    inherited pnlHeader: TPanel
      Width = 538
      ExplicitWidth = 538
    end
    inherited pnlContent: TPanel
      Width = 433
      Height = 124
      ExplicitWidth = 433
      ExplicitHeight = 124
      inherited dbgrdBase: TDBGrid
        Width = 431
        Height = 122
      end
    end
    inherited pnlButtons: TPanel
      Top = 164
      Width = 542
      ExplicitTop = 164
      ExplicitWidth = 542
      inherited flwpnlRight: TFlowPanel
        Width = 333
        ExplicitWidth = 333
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 248
    Width = 544
    ExplicitTop = 248
    ExplicitWidth = 544
    inherited btnAccept: TBitBtn
      Left = 335
      ExplicitLeft = 335
    end
    inherited btnErase: TBitBtn
      Left = 231
      ExplicitLeft = 231
    end
    inherited btnClose: TBitBtn
      Left = 439
      ExplicitLeft = 439
    end
  end
  inherited stbDBGrid: TStatusBar
    Top = 292
    Width = 548
    ExplicitTop = 292
    ExplicitWidth = 548
  end
end
