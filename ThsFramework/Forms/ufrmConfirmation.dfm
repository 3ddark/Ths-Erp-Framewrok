inherited frmConfirmation: TfrmConfirmation
  BorderStyle = bsNone
  Caption = #304#351'lem Onay'#305'(Confirmation)'
  ClientHeight = 116
  ClientWidth = 380
  Constraints.MinHeight = 100
  Constraints.MinWidth = 300
  ExplicitWidth = 380
  ExplicitHeight = 116
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelMain: TPanel
    Width = 376
    Height = 68
    Color = 9151736
    ParentBackground = False
    ExplicitWidth = 376
    ExplicitHeight = 102
    object lblMessage: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 366
      Height = 40
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      Caption = 'lblMessage'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      ExplicitLeft = 101
      ExplicitTop = 85
      ExplicitWidth = 529
    end
    object strngrdReport: TStringGrid
      Left = 1
      Top = 49
      Width = 374
      Height = 18
      Align = alClient
      TabOrder = 0
      ExplicitTop = 67
      ExplicitHeight = 34
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
  inherited PanelBottom: TPanel
    Top = 72
    Width = 376
    ExplicitTop = 106
    ExplicitWidth = 376
    object ImageMessageFormat: TImage [0]
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
      ExplicitLeft = 200
      ExplicitTop = 1
    end
    inherited btnTamam: TBitBtn
      Left = 167
      ExplicitLeft = 167
    end
    inherited btnSil: TBitBtn
      Left = 63
      ExplicitLeft = 63
    end
    inherited btnKapat: TBitBtn
      Left = 271
      ExplicitLeft = 271
    end
  end
  object pmReport: TPopupMenu
    Left = 88
    Top = 32
    object MenuItemExceleAktar: TMenuItem
      Caption = 'Excele Aktar'
    end
  end
end
