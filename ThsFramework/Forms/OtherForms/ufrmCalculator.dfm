object frmCalculator: TfrmCalculator
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmCalculator'
  ClientHeight = 424
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object lblState: TLabel
    Left = 0
    Top = 0
    Width = 397
    Height = 13
    Align = alTop
    Caption = 'lblState'
    ExplicitWidth = 36
  end
  object edtLCD: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 16
    Width = 391
    Height = 42
    Align = alTop
    Alignment = taRightJustify
    AutoSelect = False
    Enabled = False
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Consolas'
    Font.Style = [fsBold]
    HideSelection = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    Text = '0,0'
  end
  object pnlButtons: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 64
    Width = 391
    Height = 357
    Align = alClient
    TabOrder = 1
    object grdpnlCalculator: TGridPanel
      Left = 1
      Top = 1
      Width = 389
      Height = 355
      Align = alClient
      ColumnCollection = <
        item
          Value = 24.999999999999990000
        end
        item
          Value = 24.999999999999990000
        end
        item
          Value = 25.000000000000020000
        end
        item
          Value = 25.000000000000010000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = btnCE
          Row = 0
        end
        item
          Column = 2
          Control = btnErase
          Row = 0
        end
        item
          Column = 3
          Control = btnBol
          Row = 0
        end
        item
          Column = 0
          Control = btn7
          Row = 1
        end
        item
          Column = 1
          Control = btn8
          Row = 1
        end
        item
          Column = 2
          Control = btn9
          Row = 1
        end
        item
          Column = 3
          Control = btnCarp
          Row = 1
        end
        item
          Column = 0
          Control = btn4
          Row = 2
        end
        item
          Column = 1
          Control = btn5
          Row = 2
        end
        item
          Column = 2
          Control = btn6
          Row = 2
        end
        item
          Column = 3
          Control = btnCikart
          Row = 2
        end
        item
          Column = 0
          Control = btn1
          Row = 3
        end
        item
          Column = 1
          Control = btn2
          Row = 3
        end
        item
          Column = 2
          Control = btn3
          Row = 3
        end
        item
          Column = 3
          Control = btnTopla
          Row = 3
        end
        item
          Column = 0
          Control = btnArtiEksi
          Row = 4
        end
        item
          Column = 2
          Control = btnVirgul
          Row = 4
        end
        item
          Column = 3
          Control = btnSonuc
          Row = 4
        end
        item
          Column = 1
          Control = btnC
          Row = 0
        end
        item
          Column = 1
          Control = btn0
          Row = 4
        end>
      RowCollection = <
        item
          Value = 19.999999764044880000
        end
        item
          Value = 20.000000656360610000
        end
        item
          Value = 20.000000222995330000
        end
        item
          Value = 19.999999644801760000
        end
        item
          Value = 19.999999711797430000
        end
        item
          SizeStyle = ssAuto
        end>
      TabOrder = 0
      object btnCE: TButton
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = 'CE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnCEClick
      end
      object btnErase: TButton
        AlignWithMargins = True
        Left = 194
        Top = 2
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '<<'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnEraseClick
      end
      object btnBol: TButton
        AlignWithMargins = True
        Left = 290
        Top = 2
        Width = 97
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '/'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btnBolClick
      end
      object btn7: TButton
        AlignWithMargins = True
        Left = 2
        Top = 72
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '7'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object btn8: TButton
        AlignWithMargins = True
        Left = 98
        Top = 72
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '8'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object btn9: TButton
        AlignWithMargins = True
        Left = 194
        Top = 72
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '9'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
      end
      object btnCarp: TButton
        AlignWithMargins = True
        Left = 290
        Top = 72
        Width = 97
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = 'x'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        OnClick = btnCarpClick
      end
      object btn4: TButton
        AlignWithMargins = True
        Left = 2
        Top = 142
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '4'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
      end
      object btn5: TButton
        AlignWithMargins = True
        Left = 98
        Top = 142
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '5'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
      end
      object btn6: TButton
        AlignWithMargins = True
        Left = 194
        Top = 142
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '6'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 9
      end
      object btnCikart: TButton
        AlignWithMargins = True
        Left = 290
        Top = 142
        Width = 97
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '-'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 10
        OnClick = btnCikartClick
      end
      object btn1: TButton
        AlignWithMargins = True
        Left = 2
        Top = 212
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '1'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 11
      end
      object btn2: TButton
        AlignWithMargins = True
        Left = 98
        Top = 212
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '2'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
      end
      object btn3: TButton
        AlignWithMargins = True
        Left = 194
        Top = 212
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '3'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 13
      end
      object btnTopla: TButton
        AlignWithMargins = True
        Left = 290
        Top = 212
        Width = 97
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '+'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 14
        OnClick = btnToplaClick
      end
      object btnArtiEksi: TButton
        AlignWithMargins = True
        Left = 2
        Top = 282
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '+/-'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 15
        OnClick = btnArtiEksiClick
      end
      object btnVirgul: TButton
        AlignWithMargins = True
        Left = 194
        Top = 282
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = ','
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 16
        OnClick = btnVirgulClick
      end
      object btnSonuc: TButton
        AlignWithMargins = True
        Left = 290
        Top = 282
        Width = 97
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '='
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 17
        OnClick = btnSonucClick
      end
      object btnC: TButton
        AlignWithMargins = True
        Left = 98
        Top = 2
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = 'C'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 18
        OnClick = btnCClick
      end
      object btn0: TButton
        AlignWithMargins = True
        Left = 98
        Top = 282
        Width = 94
        Height = 68
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 19
      end
    end
  end
end
