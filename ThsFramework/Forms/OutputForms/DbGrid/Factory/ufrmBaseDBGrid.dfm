inherited frmBaseDBGrid: TfrmBaseDBGrid
  Caption = 'frmBaseDBGrid'
  ClientHeight = 476
  ClientWidth = 592
  Constraints.MinHeight = 350
  Constraints.MinWidth = 450
  ExplicitWidth = 608
  ExplicitHeight = 515
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 588
    Height = 410
    ExplicitWidth = 588
    ExplicitHeight = 410
    inherited splLeft: TSplitter
      Height = 293
      ExplicitHeight = 280
    end
    inherited splHeader: TSplitter
      Width = 586
      ExplicitWidth = 568
    end
    inherited pnlLeft: TPanel
      Height = 290
      Caption = ''
      ExplicitHeight = 290
    end
    inherited pnlHeader: TPanel
      Width = 582
      Caption = ''
      ExplicitWidth = 582
    end
    inherited pnlContent: TPanel
      Width = 477
      Height = 290
      ExplicitWidth = 477
      ExplicitHeight = 290
      object dbgrdBase: TDBGrid
        Left = 1
        Top = 1
        Width = 475
        Height = 288
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        PopupMenu = pmDB
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = dbgrdBaseCellClick
        OnColumnMoved = dbgrdBaseColumnMoved
        OnDrawDataCell = dbgrdBaseDrawDataCell
        OnDrawColumnCell = dbgrdBaseDrawColumnCell
        OnDblClick = dbgrdBaseDblClick
        OnExit = dbgrdBaseExit
        OnKeyDown = dbgrdBaseKeyDown
        OnKeyPress = dbgrdBaseKeyPress
        OnMouseLeave = dbgrdBaseMouseLeave
        OnMouseMove = dbgrdBaseMouseMove
        OnMouseUp = dbgrdBaseMouseUp
        OnTitleClick = dbgrdBaseTitleClick
      end
    end
    object pnlButtons: TPanel
      Left = 1
      Top = 330
      Width = 586
      Height = 79
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
      object flwpnlLeft: TFlowPanel
        Left = 0
        Top = 0
        Width = 249
        Height = 79
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object btnAddNew: TButton
          AlignWithMargins = True
          Left = 2
          Top = 2
          Width = 120
          Height = 36
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          Caption = 'ADD NEW'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HotImageIndex = 1
          ImageIndex = 1
          ParentFont = False
          TabOrder = 0
          OnClick = btnAddNewClick
        end
      end
      object flwpnlRight: TFlowPanel
        Left = 466
        Top = 0
        Width = 120
        Height = 79
        Align = alRight
        BevelOuter = bvNone
        FlowStyle = fsRightLeftTopBottom
        TabOrder = 1
        object imgFilterRemove: TImage
          Left = 88
          Top = 0
          Width = 32
          Height = 32
          Transparent = True
          OnClick = imgFilterRemoveClick
        end
      end
    end
  end
  inherited pnlBottom: TPanel
    Top = 414
    Width = 588
    ExplicitTop = 414
    ExplicitWidth = 588
    inherited btnAccept: TButton
      Left = 379
      ExplicitLeft = 379
    end
    inherited btnDelete: TButton
      Left = 25
      ExplicitLeft = 25
    end
    inherited btnClose: TButton
      Left = 483
      ExplicitLeft = 483
    end
  end
  inherited stbBase: TStatusBar
    Top = 458
    Width = 592
    ExplicitTop = 458
    ExplicitWidth = 592
  end
  inherited pmDB: TPopupMenu
    object mniPreview: TMenuItem
      Caption = 'Preview'
      ShortCut = 16397
      OnClick = mniPreviewClick
    end
    object mniCopyRecord: TMenuItem
      Caption = 'Copy Record'
      ShortCut = 16452
      OnClick = mniCopyRecordClick
    end
    object mniEditFormTitleByLang: TMenuItem
      Caption = 'Edit Form Title By Language'
      OnClick = mniEditFormTitleByLangClick
    end
    object mniAddColumnTitleByLang: TMenuItem
      Caption = 'Add/Edit Column Title By Language'
      OnClick = mniAddColumnTitleByLangClick
    end
    object mniAddLangDataContent: TMenuItem
      Caption = 'Add Lang Data Content'
      OnClick = mniAddLangDataContentClick
    end
    object mniAddUseMultiLangData: TMenuItem
      Caption = 'Add Use Multi Lang Data'
      OnClick = mniAddUseMultiLangDataClick
    end
    object mniUpdateCurrentColWidth: TMenuItem
      Caption = 'Update Current Col Width'
      OnClick = mniUpdateCurrentColWidthClick
    end
    object mniSeperator1: TMenuItem
      Caption = '-'
    end
    object mniFilter: TMenuItem
      Caption = 'Filter'
      ShortCut = 114
      OnClick = mniFilterClick
    end
    object mniExcludeFilter: TMenuItem
      Caption = 'Exclude Filter'
      OnClick = mniExcludeFilterClick
    end
    object mniRemoveFilter: TMenuItem
      Caption = 'Remove Filter'
      ShortCut = 119
      OnClick = mniRemoveFilterClick
    end
    object mniRemoveSort: TMenuItem
      Caption = 'Remove Sort'
      Visible = False
      OnClick = mniRemoveSortClick
    end
    object mniSeperator2: TMenuItem
      Caption = '-'
    end
    object mniExportExcel: TMenuItem
      Caption = 'Export Excel'
      ShortCut = 16453
      OnClick = mniExportExcelClick
    end
    object mniExportExcelAll: TMenuItem
      Caption = 'Export Excel All'
      OnClick = mniExportExcelAllClick
    end
    object mniPrint: TMenuItem
      Caption = 'Print'
      ShortCut = 16464
      OnClick = mniPrintClick
    end
    object mniSeperator3: TMenuItem
      Caption = '-'
    end
  end
end
