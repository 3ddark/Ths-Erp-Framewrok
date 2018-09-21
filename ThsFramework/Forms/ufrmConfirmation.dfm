inherited frmConfirmation: TfrmConfirmation
  BorderStyle = bsDialog
  Caption = 'Confirmation'
  ClientHeight = 208
  ClientWidth = 553
  ExplicitWidth = 559
  ExplicitHeight = 237
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 549
    Height = 142
    ExplicitWidth = 612
    ExplicitHeight = 346
    object lblMessage: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 140
      Height = 13
      Align = alClient
      Caption = 'All messages fill into this label'
    end
    object strngrdReport: TStringGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 541
      Height = 134
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 120
      ExplicitTop = 153
      ExplicitWidth = 320
      ExplicitHeight = 120
      ColWidths = (
        64
        64
        64
        64
        64)
      RowHeights = (
        24
        24
        24
        24
        24)
    end
  end
  inherited pnlBottom: TPanel
    Top = 146
    Width = 549
    ExplicitTop = 350
    ExplicitWidth = 612
    object imgMessageFormat: TImage [0]
      AlignWithMargins = True
      Left = 25
      Top = 5
      Width = 32
      Height = 32
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      ExplicitLeft = 58
      ExplicitTop = 8
      ExplicitHeight = 30
    end
    inherited btnAccept: TButton
      Left = 340
      ExplicitLeft = 403
    end
    inherited btnDelete: TButton
      Left = 236
      ExplicitLeft = 299
    end
    inherited btnClose: TButton
      Left = 444
      ExplicitLeft = 507
    end
  end
  inherited stbBase: TStatusBar
    Top = 190
    Width = 553
    ExplicitTop = 394
    ExplicitWidth = 616
  end
  object pmReport: TPopupMenu
    Left = 368
    Top = 64
    object mniExportExcell: TMenuItem
      Caption = 'Excele Aktar'
      OnClick = mniExportExcellClick
    end
  end
end
