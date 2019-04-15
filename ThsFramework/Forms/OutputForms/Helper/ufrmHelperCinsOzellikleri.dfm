inherited frmHelperCinsOzellikleri: TfrmHelperCinsOzellikleri
  Caption = 'Cins Ozellikleri'
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
      inherited edtFilter: TEdit
        Width = 486
        ExplicitWidth = 486
      end
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
      inherited flwpnlLeft: TFlowPanel
        Width = 233
        ExplicitWidth = 233
      end
      inherited flwpnlRight: TFlowPanel
        Left = 438
        Width = 104
        ExplicitLeft = 438
        ExplicitWidth = 104
        inherited imgFilterRemove: TImage
          Left = 72
          ExplicitLeft = 72
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 249
    Width = 544
    ExplicitTop = 249
    ExplicitWidth = 544
    inherited btnAccept: TButton
      Left = 335
      ExplicitLeft = 335
    end
    inherited btnClose: TButton
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
