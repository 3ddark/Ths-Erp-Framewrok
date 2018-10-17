object frmMainClassGenerator: TfrmMainClassGenerator
  Left = 0
  Top = 0
  Caption = 'Class Generator'
  ClientHeight = 601
  ClientWidth = 894
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 888
    Height = 294
    Align = alTop
    TabOrder = 0
    object Splitter3: TSplitter
      Left = 460
      Top = 1
      Height = 292
      ExplicitLeft = 348
      ExplicitHeight = 326
    end
    object strngrdList: TStringGrid
      AlignWithMargins = True
      Left = 466
      Top = 4
      Width = 418
      Height = 286
      Align = alClient
      ColCount = 4
      DefaultColWidth = 71
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowMoving]
      PopupMenu = pmBase
      TabOrder = 0
      OnDblClick = strngrdListDblClick
      OnMouseDown = strngrdListMouseDown
      OnRowMoved = strngrdListRowMoved
      ColWidths = (
        71
        71
        71
        71)
      RowHeights = (
        24
        24
        24
        24
        24)
    end
    object pnlLeft: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 453
      Height = 286
      Align = alLeft
      TabOrder = 1
      object Label2: TLabel
        Left = 70
        Top = 27
        Width = 60
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Class Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label3: TLabel
        Left = 268
        Top = 27
        Width = 66
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Table Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label4: TLabel
        Left = 264
        Top = 49
        Width = 70
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Source Code'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblCaption: TLabel
        Left = 16
        Top = 189
        Width = 114
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Grid Column Caption'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblFieldName: TLabel
        Left = 69
        Top = 145
        Width = 61
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Field Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblFieldType: TLabel
        Left = 73
        Top = 167
        Width = 57
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Field Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblpropertyname: TLabel
        Left = 45
        Top = 123
        Width = 85
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Property Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object Label5: TLabel
        Left = 21
        Top = 4
        Width = 105
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Project File (*.dpr)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblOutputFormCaption: TLabel
        Left = 259
        Top = 71
        Width = 75
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Form Caption'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblOutputFormName: TLabel
        Left = 24
        Top = 71
        Width = 106
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Output Form Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblInputFormName: TLabel
        Left = 32
        Top = 93
        Width = 98
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Input Form Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblIsGUIControl: TLabel
        Left = 59
        Top = 235
        Width = 71
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = '?GUI Control'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblControlType: TLabel
        Left = 58
        Top = 257
        Width = 72
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Control Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblInputFormCaption: TLabel
        Left = 259
        Top = 93
        Width = 75
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Form Caption'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblInputLabelCaption: TLabel
        Left = 20
        Top = 211
        Width = 110
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Input Label Caption'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object edtMainProjectDirectory: TEdit
        Left = 132
        Top = 2
        Width = 316
        Height = 21
        TabOrder = 0
        OnDblClick = edtMainProjectDirectoryDblClick
      end
      object edtClassType: TEdit
        Left = 132
        Top = 24
        Width = 112
        Height = 21
        TabOrder = 1
      end
      object edtTableName: TEdit
        Left = 336
        Top = 24
        Width = 112
        Height = 21
        TabOrder = 2
      end
      object edtSourceCode: TEdit
        Left = 336
        Top = 46
        Width = 112
        Height = 21
        TabOrder = 3
      end
      object edtOutputFormName: TEdit
        Left = 132
        Top = 68
        Width = 112
        Height = 21
        TabOrder = 4
      end
      object edtOutputFormCaption: TEdit
        Left = 336
        Top = 68
        Width = 112
        Height = 21
        TabOrder = 5
      end
      object edtInputFormName: TEdit
        Left = 132
        Top = 90
        Width = 112
        Height = 21
        TabOrder = 6
      end
      object edtInputFormCaption: TEdit
        Left = 336
        Top = 90
        Width = 112
        Height = 21
        TabOrder = 7
      end
      object edtpropertyname: TEdit
        Left = 132
        Top = 120
        Width = 193
        Height = 21
        TabOrder = 8
      end
      object edtFieldName: TEdit
        Left = 132
        Top = 142
        Width = 193
        Height = 21
        TabOrder = 9
      end
      object cbbFieldType: TComboBox
        Left = 132
        Top = 164
        Width = 193
        Height = 21
        Style = csDropDownList
        TabOrder = 10
        Items.Strings = (
          'ftString'
          'ftWideString'
          'ftInteger'
          'ftLongInt'
          'ftFloat'
          'ftDate'
          'ftDateTime'
          'ftTime'
          'ftWord'
          'ftBoolean')
      end
      object edtCaption: TEdit
        Left = 132
        Top = 186
        Width = 193
        Height = 21
        TabOrder = 11
      end
      object chkIsGUIControl: TCheckBox
        Left = 132
        Top = 234
        Width = 193
        Height = 17
        TabOrder = 13
        OnClick = chkIsGUIControlClick
      end
      object cbbControlType: TComboBox
        Left = 132
        Top = 254
        Width = 193
        Height = 21
        Style = csDropDownList
        TabOrder = 14
        Items.Strings = (
          'ftString'
          'ftWideString'
          'ftInteger'
          'ftLongInt'
          'ftFloat'
          'ftDate'
          'ftDateTime'
          'ftTime'
          'ftWord'
          'ftBoolean')
      end
      object btnAddField: TButton
        Left = 349
        Top = 205
        Width = 99
        Height = 27
        Caption = 'Add Field'
        TabOrder = 15
        OnClick = btnAddFieldClick
      end
      object btnClearLists: TButton
        Left = 349
        Top = 120
        Width = 99
        Height = 27
        Caption = 'Clear List'
        TabOrder = 16
        OnClick = btnClearListsClick
      end
      object btnSaveToFiles: TButton
        AlignWithMargins = True
        Left = 349
        Top = 163
        Width = 99
        Height = 27
        Caption = 'Save To Files'
        TabOrder = 17
        OnClick = btnSaveToFilesClick
      end
      object edtInputLabelCaption: TEdit
        Left = 132
        Top = 208
        Width = 193
        Height = 21
        TabOrder = 12
      end
      object btnEditField: TButton
        Left = 349
        Top = 248
        Width = 99
        Height = 27
        Caption = 'Edit Field'
        TabOrder = 18
        OnClick = btnEditFieldClick
      end
    end
  end
  object pgcMemos: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 303
    Width = 888
    Height = 295
    ActivePage = tsClass
    Align = alClient
    TabOrder = 1
    object tsClass: TTabSheet
      Caption = 'Class Section'
      object mmoClass: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 874
        Height = 215
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
        OnKeyUp = mmoClassKeyUp
      end
      object pnlClass: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 224
        Width = 874
        Height = 40
        Align = alBottom
        TabOrder = 1
        object btnAddClassToMemo: TButton
          AlignWithMargins = True
          Left = 795
          Top = 4
          Width = 75
          Height = 32
          Align = alRight
          Caption = 'Add Memo'
          TabOrder = 0
          OnClick = btnAddClassToMemoClick
        end
      end
    end
    object tsOutput: TTabSheet
      Caption = 'Output Form Section'
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 420
        Top = 0
        Height = 267
        ExplicitLeft = 421
        ExplicitHeight = 360
      end
      object pnlOutputDFM: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 414
        Height = 261
        Align = alLeft
        Caption = 'pnlOutputDFM'
        TabOrder = 0
        object mmoOutputDFM: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 406
          Height = 207
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
          OnKeyUp = mmoClassKeyUp
        end
        object pnlOutputBottomDFM: TPanel
          AlignWithMargins = True
          Left = 4
          Top = 217
          Width = 406
          Height = 40
          Align = alBottom
          TabOrder = 1
          object btnAddOutputDFMToMemo: TButton
            AlignWithMargins = True
            Left = 327
            Top = 4
            Width = 75
            Height = 32
            Align = alRight
            Caption = 'Add Memo'
            TabOrder = 0
            OnClick = btnAddOutputDFMToMemoClick
          end
        end
      end
      object pnlOutputPAS: TPanel
        AlignWithMargins = True
        Left = 426
        Top = 3
        Width = 451
        Height = 261
        Align = alClient
        Caption = 'pnlOutputPAS'
        TabOrder = 1
        object mmoOutputPAS: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 443
          Height = 207
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
          OnKeyUp = mmoClassKeyUp
        end
        object pnlOutputBottomPAS: TPanel
          AlignWithMargins = True
          Left = 4
          Top = 217
          Width = 443
          Height = 40
          Align = alBottom
          TabOrder = 1
          object btnAddOutputPASToMemo: TButton
            AlignWithMargins = True
            Left = 364
            Top = 4
            Width = 75
            Height = 32
            Align = alRight
            Caption = 'Add Memo'
            TabOrder = 0
            OnClick = btnAddOutputPASToMemoClick
          end
        end
      end
    end
    object tsInput: TTabSheet
      Caption = 'Input Form Caption'
      ImageIndex = 2
      object Splitter2: TSplitter
        Left = 420
        Top = 0
        Height = 267
        ExplicitLeft = 428
        ExplicitHeight = 360
      end
      object pnlInputDFM: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 414
        Height = 261
        Align = alLeft
        Caption = 'pnlOutputDFM'
        TabOrder = 0
        object mmoInputDFM: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 406
          Height = 207
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
          OnKeyUp = mmoClassKeyUp
        end
        object pnlInputBottomDFM: TPanel
          AlignWithMargins = True
          Left = 4
          Top = 217
          Width = 406
          Height = 40
          Align = alBottom
          TabOrder = 1
          object btnAddInputDFMToMemo: TButton
            AlignWithMargins = True
            Left = 327
            Top = 4
            Width = 75
            Height = 32
            Align = alRight
            Caption = 'Add Memo'
            TabOrder = 0
            OnClick = btnAddInputDFMToMemoClick
          end
        end
      end
      object pnlInputPAS: TPanel
        AlignWithMargins = True
        Left = 426
        Top = 3
        Width = 451
        Height = 261
        Align = alClient
        Caption = 'pnlOutputPAS'
        TabOrder = 1
        object mmoInputPAS: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 443
          Height = 207
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
          OnKeyUp = mmoClassKeyUp
        end
        object pnlInputBottomPAS: TPanel
          AlignWithMargins = True
          Left = 4
          Top = 217
          Width = 443
          Height = 40
          Align = alBottom
          TabOrder = 1
          object btnAddInputPASToMemo: TButton
            AlignWithMargins = True
            Left = 364
            Top = 4
            Width = 75
            Height = 32
            Align = alRight
            Caption = 'Add Memo'
            TabOrder = 0
            OnClick = btnAddInputPASToMemoClick
          end
        end
      end
    end
  end
  object pmBase: TPopupMenu
    Left = 752
    Top = 160
    object mniDeleteRow: TMenuItem
      Caption = 'Delete Row'
      OnClick = mniDeleteRowClick
    end
    object mniSaveToFile: TMenuItem
      Caption = 'Save To File'
      OnClick = mniSaveToFileClick
    end
    object mniLoadFromFile: TMenuItem
      Caption = 'Load From File'
      OnClick = mniLoadFromFileClick
    end
  end
end
