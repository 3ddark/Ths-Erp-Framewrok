inherited frmBaseDetaylar: TfrmBaseDetaylar
  Caption = 'frmBaseDetaylar'
  ClientHeight = 625
  ClientWidth = 1086
  ExplicitWidth = 1092
  ExplicitHeight = 654
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 1082
    Height = 559
    ExplicitWidth = 1082
    ExplicitHeight = 559
    object splLeft: TSplitter
      Left = 104
      Top = 125
      Height = 433
      Beveled = True
      Color = clBtnFace
      ParentColor = False
      ExplicitLeft = 101
      ExplicitTop = 34
      ExplicitHeight = 213
    end
    object splHeader: TSplitter
      Left = 1
      Top = 122
      Width = 1080
      Height = 3
      Cursor = crVSplit
      Align = alTop
      Beveled = True
      Color = clBtnFace
      ParentColor = False
      ExplicitTop = 34
      ExplicitWidth = 600
    end
    object pnlHeader: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 1076
      Height = 118
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 1
      Align = alTop
      Constraints.MinHeight = 30
      TabOrder = 0
      object pgcHeader: TPageControl
        Left = 1
        Top = 1
        Width = 1074
        Height = 116
        ActivePage = tsHeader
        Align = alClient
        MultiLine = True
        TabOrder = 0
        TabPosition = tpLeft
        object tsHeader: TTabSheet
          Caption = 'Header'
        end
        object tsHeaderDiger: TTabSheet
          Caption = 'Di'#287'er'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
      end
    end
    object pnlContent: TPanel
      AlignWithMargins = True
      Left = 108
      Top = 126
      Width = 971
      Height = 430
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 1
      DesignSize = (
        971
        430)
      object pgcContent: TPageControl
        AlignWithMargins = True
        Left = 1
        Top = 1
        Width = 969
        Height = 428
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ActivePage = ts1
        Align = alClient
        TabOrder = 0
        object ts1: TTabSheet
          Caption = 'ts1'
          object pnl1: TPanel
            AlignWithMargins = True
            Left = 0
            Top = 287
            Width = 961
            Height = 113
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alBottom
            Color = 14993769
            TabOrder = 0
            object grpGenelToplamKalan: TGroupBox
              AlignWithMargins = True
              Left = 485
              Top = 4
              Width = 233
              Height = 105
              Align = alRight
              TabOrder = 0
              object lblToplamTutarKalan: TLabel
                Left = 4
                Top = 4
                Width = 114
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Toplam Tutar'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblValToplamTutarKalan: TLabel
                Left = 121
                Top = 4
                Width = 110
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'value'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblToplamIskontoTutarKalan: TLabel
                Left = 4
                Top = 18
                Width = 114
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = #304'skonto Tutar'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblValToplamIskontoTutarKalan: TLabel
                Left = 121
                Top = 18
                Width = 110
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'value'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblAraToplamKalan: TLabel
                Left = 4
                Top = 32
                Width = 114
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Ara Toplam'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblValAraToplamKalan: TLabel
                Left = 121
                Top = 32
                Width = 110
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'value'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblToplamKDVTutarKalan: TLabel
                Left = 4
                Top = 46
                Width = 114
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'KDV Tutar'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblValToplamKDVTutarKalan: TLabel
                Left = 121
                Top = 46
                Width = 110
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'value'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblToplamGenelIskontoTutarKalan: TLabel
                Left = 4
                Top = 60
                Width = 114
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Genel '#304'sk.Tutar'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblValToplamGenelIskontoTutarKalan: TLabel
                Left = 121
                Top = 60
                Width = 110
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'ValueToplamGenelIskontoTutar'
              end
              object lblTevkifatTutarKalan: TLabel
                Left = 4
                Top = 74
                Width = 114
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Tevkifat Tutar'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblValTevkifatTutarKalan: TLabel
                Left = 121
                Top = 74
                Width = 110
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'lblValTevkifatTutar'
              end
              object lblGenelToplamKalan: TLabel
                Left = 4
                Top = 88
                Width = 114
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Genel Toplam'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblValGenelToplamKalan: TLabel
                Left = 121
                Top = 88
                Width = 110
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'value'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
            end
            object grpGenelToplam: TGroupBox
              AlignWithMargins = True
              Left = 724
              Top = 4
              Width = 233
              Height = 105
              Align = alRight
              TabOrder = 1
              object lblToplamTutar: TLabel
                Left = 4
                Top = 4
                Width = 114
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Toplam Tutar'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblValToplamTutar: TLabel
                Left = 115
                Top = 4
                Width = 110
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'value'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblToplamIskontoTutar: TLabel
                Left = 4
                Top = 18
                Width = 114
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = #304'skonto Tutar'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblValToplamIskontoTutar: TLabel
                Left = 115
                Top = 18
                Width = 110
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'value'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblAraToplam: TLabel
                Left = 4
                Top = 32
                Width = 114
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Ara Toplam'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblValAraToplam: TLabel
                Left = 115
                Top = 32
                Width = 110
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'value'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblToplamKDVTutar: TLabel
                Left = 4
                Top = 46
                Width = 114
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'KDV Tutar'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblValToplamKDVTutar: TLabel
                Left = 115
                Top = 46
                Width = 110
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'value'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
              object lblToplamGenelIskontoTutar: TLabel
                Left = 4
                Top = 60
                Width = 114
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Genel '#304'sk.Tutar'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblValToplamGenelIskontoTutar: TLabel
                Left = 115
                Top = 60
                Width = 110
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'ValueToplamGenelIskontoTutar'
              end
              object lblTevkifatTutar: TLabel
                Left = 4
                Top = 74
                Width = 114
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Tevkifat Tutar'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblValTevkifatTutar: TLabel
                Left = 115
                Top = 74
                Width = 110
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'lblValTevkifatTutar'
              end
              object lblGenelToplam: TLabel
                Left = 4
                Top = 88
                Width = 114
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Genel Toplam'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblValGenelToplam: TLabel
                Left = 115
                Top = 88
                Width = 110
                Height = 13
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'value'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
              end
            end
            object flwpnl1: TFlowPanel
              Left = 1
              Top = 1
              Width = 481
              Height = 111
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 2
              object btnAddDetail: TButton
                AlignWithMargins = True
                Left = 2
                Top = 2
                Width = 120
                Height = 25
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alLeft
                Caption = 'Detay Ekle'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnClick = btnAddDetailClick
              end
              object btnConvert: TButton
                AlignWithMargins = True
                Left = 126
                Top = 2
                Width = 120
                Height = 25
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alLeft
                Caption = 'Convert'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
              end
              object btnSelectContent: TButton
                AlignWithMargins = True
                Left = 250
                Top = 2
                Width = 120
                Height = 25
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alLeft
                Caption = #304#231'erik Se'#231
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 2
              end
            end
          end
          object strngrd1: TStringGrid
            Left = 0
            Top = 0
            Width = 961
            Height = 287
            Align = alClient
            DefaultRowHeight = 20
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goRowMoving, goColMoving, goTabs, goFixedColClick, goFixedRowClick, goFixedHotTrack]
            PopupMenu = pm1
            TabOrder = 1
            OnDblClick = strngrd1DblClick
            OnDrawCell = strngrd1DrawCell
            ColWidths = (
              64
              64
              64
              64
              64)
            RowHeights = (
              20
              20
              20
              20
              20)
          end
        end
        object ts2: TTabSheet
          Caption = 'ts2'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object strngrd2: TStringGrid
            Left = 0
            Top = 0
            Width = 961
            Height = 266
            Align = alClient
            TabOrder = 0
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
          object pnl2: TPanel
            AlignWithMargins = True
            Left = 0
            Top = 266
            Width = 961
            Height = 134
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            object flwpnl2: TFlowPanel
              Left = 0
              Top = 0
              Width = 961
              Height = 134
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
            end
          end
        end
        object ts3: TTabSheet
          Caption = 'ts3'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object strngrd3: TStringGrid
            Left = 0
            Top = 0
            Width = 961
            Height = 266
            Align = alClient
            TabOrder = 0
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
          object pnl3: TPanel
            AlignWithMargins = True
            Left = 0
            Top = 266
            Width = 961
            Height = 134
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            object flwpnl3: TFlowPanel
              Left = 0
              Top = 0
              Width = 961
              Height = 134
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
            end
          end
        end
      end
      object btnHeaderShowHide: TButton
        Left = 880
        Top = 0
        Width = 86
        Height = 21
        Anchors = [akTop, akRight]
        Caption = 'Min/Max'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnHeaderShowHideClick
      end
    end
    object pnlLeft: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 126
      Width = 100
      Height = 430
      Margins.Left = 2
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 2
      Align = alLeft
      Constraints.MinHeight = 100
      Constraints.MinWidth = 100
      TabOrder = 2
    end
  end
  inherited pnlBottom: TPanel
    Top = 563
    Width = 1082
    ExplicitTop = 563
    ExplicitWidth = 1082
    inherited btnAccept: TButton
      Left = 873
      ExplicitLeft = 873
    end
    inherited btnDelete: TButton
      Left = 769
      ExplicitLeft = 769
    end
    inherited btnClose: TButton
      Left = 977
      ExplicitLeft = 977
    end
  end
  inherited stbBase: TStatusBar
    Top = 607
    Width = 1086
    ExplicitTop = 607
    ExplicitWidth = 1086
  end
  object pm1: TPopupMenu
    Left = 559
    Top = 157
    object mniExportExcel1: TMenuItem
      Caption = 'Export Excel'
      ShortCut = 16453
    end
    object mniPrint1: TMenuItem
      Caption = 'Print'
      ShortCut = 16464
    end
  end
  object pm2: TPopupMenu
    Left = 559
    Top = 221
    object mniExportExcel2: TMenuItem
      Caption = 'Export Excel'
      ShortCut = 16453
    end
    object mniPrint2: TMenuItem
      Caption = 'Print'
      ShortCut = 16464
    end
  end
  object pm3: TPopupMenu
    Left = 559
    Top = 293
    object mniExportExcel3: TMenuItem
      Caption = 'Export Excel'
      ShortCut = 16453
    end
    object mniPrint3: TMenuItem
      Caption = 'Print'
      ShortCut = 16464
    end
  end
end
