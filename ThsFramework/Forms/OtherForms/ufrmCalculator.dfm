object frmCalculator: TfrmCalculator
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmCalculator'
  ClientHeight = 287
  ClientWidth = 253
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
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object lblState: TLabel
    Left = 0
    Top = 0
    Width = 253
    Height = 13
    Align = alTop
    Caption = 'lblState'
    ExplicitWidth = 36
  end
  object edtLCD: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 16
    Width = 247
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
    Width = 247
    Height = 220
    Align = alClient
    TabOrder = 1
    object grdpnlCalculator: TGridPanel
      Left = 1
      Top = 1
      Width = 245
      Height = 218
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
          Column = 1
          Control = btnC
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
          Row = 0
        end
        item
          Column = 0
          Control = btn0
          Row = 4
        end
        item
          Column = 1
          Control = btnVirgul
          Row = 4
        end
        item
          Column = 2
          ColumnSpan = 2
          Control = btnSonuc
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
      object btnC: TButton
        AlignWithMargins = True
        Left = 62
        Top = 2
        Width = 58
        Height = 41
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
        TabOrder = 0
        OnClick = btnCClick
      end
      object btnErase: TButton
        AlignWithMargins = True
        Left = 122
        Top = 2
        Width = 58
        Height = 41
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
        Left = 182
        Top = 2
        Width = 61
        Height = 41
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        Caption = '%'
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
        Top = 45
        Width = 58
        Height = 41
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
        Left = 62
        Top = 45
        Width = 58
        Height = 41
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
        Left = 122
        Top = 45
        Width = 58
        Height = 41
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
        Left = 182
        Top = 45
        Width = 61
        Height = 41
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
        Top = 88
        Width = 58
        Height = 41
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
        Left = 62
        Top = 88
        Width = 58
        Height = 41
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
        Left = 122
        Top = 88
        Width = 58
        Height = 41
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
        Left = 182
        Top = 88
        Width = 61
        Height = 41
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
        Top = 131
        Width = 58
        Height = 41
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
        Left = 62
        Top = 131
        Width = 58
        Height = 41
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
        Left = 122
        Top = 131
        Width = 58
        Height = 41
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
        Left = 182
        Top = 131
        Width = 61
        Height = 41
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
        Top = 2
        Width = 58
        Height = 41
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
      object btn0: TButton
        AlignWithMargins = True
        Left = 2
        Top = 174
        Width = 58
        Height = 41
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
        TabOrder = 16
      end
      object btnVirgul: TButton
        AlignWithMargins = True
        Left = 62
        Top = 174
        Width = 58
        Height = 41
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
        TabOrder = 17
        OnClick = btnVirgulClick
      end
      object btnSonuc: TButton
        AlignWithMargins = True
        Left = 122
        Top = 174
        Width = 121
        Height = 41
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
        TabOrder = 18
        OnClick = btnSonucClick
      end
    end
  end
end
