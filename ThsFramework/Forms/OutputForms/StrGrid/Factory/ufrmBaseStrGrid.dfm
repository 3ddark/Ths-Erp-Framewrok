inherited frmBaseStrGrid: TfrmBaseStrGrid
  Caption = 'String Grid Base'
  ClientHeight = 478
  ClientWidth = 820
  OldCreateOrder = True
  ExplicitWidth = 836
  ExplicitHeight = 517
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 816
    Height = 430
    ExplicitWidth = 816
    ExplicitHeight = 430
    inherited splLeft: TSplitter
      Height = 392
      ExplicitHeight = 373
    end
    inherited splHeader: TSplitter
      Width = 814
      ExplicitWidth = 814
    end
    inherited pnlLeft: TPanel
      Height = 389
      ExplicitHeight = 389
    end
    inherited pnlHeader: TPanel
      Width = 810
      ExplicitWidth = 810
    end
    inherited pnlContent: TPanel
      Width = 705
      Height = 389
      ExplicitWidth = 705
      ExplicitHeight = 389
      object strGrdBase: TAdvStringGrid
        Left = 1
        Top = 1
        Width = 703
        Height = 387
        Cursor = crDefault
        Align = alClient
        Ctl3D = True
        DrawingStyle = gdsClassic
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goFixedColClick]
        ParentCtl3D = False
        ScrollBars = ssBoth
        TabOrder = 0
        ActiveRowShow = True
        HoverRowCells = [hcNormal, hcSelected]
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientDownFrom = clGray
        ControlLook.FixedGradientDownTo = clSilver
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDown.TextChecked = 'Checked'
        FilterDropDown.TextUnChecked = 'Unchecked'
        FilterDropDownAuto = True
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Larger than'
          'Smaller than'
          'Clear')
        FixedRowHeight = 22
        FixedRowAlways = True
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'Tahoma'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'Tahoma'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'Tahoma'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Kapat'
        SearchFooter.HintFindNext = 'Sonrakini Bul'
        SearchFooter.HintFindPrev = #214'ncekini Bul'
        SearchFooter.HintHighlight = 'Se'#231'ili olan'
        SearchFooter.MatchCaseCaption = 'B'#252'y'#252'k harf duyarl'#305
        SearchFooter.Visible = True
        SortSettings.DefaultFormat = ssAutomatic
        Version = '8.1.3.0'
        ColWidths = (
          64
          64
          64
          64
          64)
        RowHeights = (
          22
          22
          22
          22
          22
          22
          22
          22
          22
          22)
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 434
    Width = 816
    ExplicitTop = 434
    ExplicitWidth = 816
    inherited btnAccept: TBitBtn
      Left = 607
      ExplicitLeft = 607
    end
    inherited btnDelete: TBitBtn
      Left = 711
      ExplicitLeft = 711
    end
    inherited btnClose: TBitBtn
      Left = 503
      ExplicitLeft = 503
    end
  end
end
