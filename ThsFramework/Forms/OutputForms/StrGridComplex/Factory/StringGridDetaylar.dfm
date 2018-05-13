object FormStringGridDetaylar: TFormStringGridDetaylar
  Left = 0
  Top = 0
  Caption = 'FormStringGridDetaylar'
  ClientHeight = 497
  ClientWidth = 904
  Color = clBtnFace
  Constraints.MinHeight = 250
  Constraints.MinWidth = 380
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    AlignWithMargins = True
    Left = 4
    Top = 4
    Width = 896
    Height = 493
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 0
    Align = alClient
    Caption = 'PanelTop'
    Color = 14993769
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 154
      Top = 87
      Height = 322
      Color = clBtnFace
      ParentColor = False
      ExplicitLeft = 151
      ExplicitHeight = 445
    end
    object Splitter2: TSplitter
      Left = 1
      Top = 84
      Width = 894
      Height = 3
      Cursor = crVSplit
      Align = alTop
      Color = clBtnFace
      ParentColor = False
      ExplicitTop = 87
      ExplicitWidth = 844
    end
    object PanelLeft: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 87
      Width = 150
      Height = 319
      Margins.Top = 0
      Margins.Right = 0
      Align = alLeft
      Caption = 'PanelLeft'
      Color = 14993769
      Constraints.MaxWidth = 300
      Constraints.MinWidth = 150
      TabOrder = 0
    end
    object PanelHeader: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 888
      Height = 80
      Margins.Bottom = 0
      Align = alTop
      Caption = 'PanelHeader'
      Color = 14993769
      Constraints.MaxHeight = 120
      Constraints.MinHeight = 50
      TabOrder = 1
    end
    object PanelMiddle: TPanel
      AlignWithMargins = True
      Left = 157
      Top = 87
      Width = 735
      Height = 319
      Margins.Left = 0
      Margins.Top = 0
      Align = alClient
      Caption = 'PanelMiddle'
      Color = 14993769
      TabOrder = 2
      object Splitter3: TSplitter
        Left = 369
        Top = 1
        Height = 317
        Color = clBtnFace
        ParentColor = False
        ExplicitLeft = 151
        ExplicitHeight = 445
      end
      object StringGridRight: TStringGrid
        Left = 372
        Top = 1
        Width = 362
        Height = 317
        Align = alClient
        Color = clBtnFace
        TabOrder = 0
        RowHeights = (
          24
          24
          24
          24
          24)
      end
      object StringGridLeft: TStringGrid
        Left = 1
        Top = 1
        Width = 368
        Height = 317
        Align = alLeft
        Color = clBtnFace
        TabOrder = 1
        RowHeights = (
          24
          24
          24
          24
          24)
      end
    end
    object PanelTopFooter: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 412
      Width = 888
      Height = 80
      Margins.Bottom = 0
      Align = alBottom
      Caption = 'PanelHeader'
      Color = 14993769
      Constraints.MaxHeight = 120
      Constraints.MinHeight = 50
      TabOrder = 3
      object ButtonDetayEkle: TBitBtn
        Left = 8
        Top = 0
        Width = 75
        Height = 34
        Caption = 'Detay Ekle'
        TabOrder = 0
      end
      object ButtonBaslikDuzenle: TBitBtn
        Left = 8
        Top = 40
        Width = 75
        Height = 34
        Caption = 'Ba'#351'l'#305'k D'#252'zenle'
        TabOrder = 1
      end
    end
  end
end
