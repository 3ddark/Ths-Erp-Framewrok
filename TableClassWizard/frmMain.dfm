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
    Height = 302
    Align = alTop
    TabOrder = 0
    object Splitter3: TSplitter
      Left = 524
      Top = 1
      Height = 300
      ExplicitLeft = 348
      ExplicitHeight = 326
    end
    object strngrdList: TStringGrid
      AlignWithMargins = True
      Left = 530
      Top = 4
      Width = 354
      Height = 294
      Align = alClient
      ColCount = 4
      DefaultColWidth = 71
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowMoving]
      PopupMenu = pmBase
      TabOrder = 0
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
      Width = 517
      Height = 294
      Align = alLeft
      TabOrder = 1
      object Label2: TLabel
        Left = 82
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
        Left = 76
        Top = 49
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
        Left = 321
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
        Left = 28
        Top = 199
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
        Left = 81
        Top = 155
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
        Left = 85
        Top = 177
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
        Left = 57
        Top = 133
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
        Left = 3
        Top = 4
        Width = 135
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Main Project File (*.dpr)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblOutputFormCaption: TLabel
        Left = 25
        Top = 93
        Width = 117
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Output Form Caption'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblOutputFormName: TLabel
        Left = 36
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
        Left = 293
        Top = 71
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
        Left = 71
        Top = 245
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
        Left = 70
        Top = 267
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
        Left = 282
        Top = 93
        Width = 109
        Height = 13
        BiDiMode = bdRightToLeft
        Caption = 'Input Form Caption'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblInputLabelCaption: TLabel
        Left = 32
        Top = 221
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
      object edtMainProjectDirectory: TthsEdit
        Left = 144
        Top = 2
        Width = 297
        Height = 21
        TabOrder = 0
        OnDblClick = edtMainProjectDirectoryDblClick
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
      object edtClassType: TthsEdit
        Left = 144
        Top = 24
        Width = 120
        Height = 21
        TabOrder = 1
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
      object edtTableName: TthsEdit
        Left = 144
        Top = 46
        Width = 120
        Height = 21
        TabOrder = 2
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
      object edtSourceCode: TthsEdit
        Left = 393
        Top = 46
        Width = 120
        Height = 21
        TabOrder = 3
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
      object edtOutputFormName: TthsEdit
        Left = 144
        Top = 68
        Width = 120
        Height = 21
        TabOrder = 4
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
      object edtOutputFormCaption: TthsEdit
        Left = 144
        Top = 90
        Width = 120
        Height = 21
        TabOrder = 5
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
      object edtInputFormName: TthsEdit
        Left = 393
        Top = 68
        Width = 120
        Height = 21
        TabOrder = 6
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
      object edtInputFormCaption: TthsEdit
        Left = 393
        Top = 90
        Width = 120
        Height = 21
        TabOrder = 7
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
      object edtpropertyname: TthsEdit
        Left = 144
        Top = 130
        Width = 193
        Height = 21
        TabOrder = 8
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
      object edtFieldName: TthsEdit
        Left = 144
        Top = 152
        Width = 193
        Height = 21
        TabOrder = 9
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
      object cbbFieldType: TthsCombobox
        Left = 144
        Top = 174
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
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
      object edtCaption: TthsEdit
        Left = 144
        Top = 196
        Width = 193
        Height = 21
        TabOrder = 11
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
      object chkIsGUIControl: TCheckBox
        Left = 144
        Top = 244
        Width = 193
        Height = 17
        TabOrder = 13
        OnClick = chkIsGUIControlClick
      end
      object cbbControlType: TthsCombobox
        Left = 144
        Top = 264
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
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
      object btnAddField: TButton
        Left = 393
        Top = 167
        Width = 99
        Height = 27
        Caption = 'Add Field'
        TabOrder = 15
        OnClick = btnAddFieldClick
      end
      object btnClearLists: TButton
        Left = 393
        Top = 201
        Width = 99
        Height = 27
        Caption = 'Clear List'
        TabOrder = 16
        OnClick = btnClearListsClick
      end
      object btnSaveToFiles: TButton
        AlignWithMargins = True
        Left = 393
        Top = 234
        Width = 99
        Height = 27
        Caption = 'Save To Files'
        TabOrder = 17
        OnClick = btnSaveToFilesClick
      end
      object edtInputLabelCaption: TthsEdit
        Left = 144
        Top = 218
        Width = 193
        Height = 21
        TabOrder = 12
        thsAlignment = taLeftJustify
        thsColorActive = clSkyBlue
        thsColorRequiredData = 7367916
        thsTabEnterKeyJump = True
        thsInputDataType = itString
        thsCaseUpLowSupportTr = True
        thsDecimalDigit = 4
        thsRequiredData = False
        thsDoTrim = True
        thsActiveYear = 2018
      end
    end
  end
  object pgcMemos: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 311
    Width = 888
    Height = 287
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
        Height = 207
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
        OnKeyUp = mmoClassKeyUp
      end
      object pnlClass: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 216
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
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Splitter1: TSplitter
        Left = 420
        Top = 0
        Height = 259
        ExplicitLeft = 421
        ExplicitHeight = 360
      end
      object pnlOutputDFM: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 414
        Height = 253
        Align = alLeft
        Caption = 'pnlOutputDFM'
        TabOrder = 0
        object mmoOutputDFM: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 406
          Height = 199
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
          OnKeyUp = mmoClassKeyUp
        end
        object pnlOutputBottomDFM: TPanel
          AlignWithMargins = True
          Left = 4
          Top = 209
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
        Height = 253
        Align = alClient
        Caption = 'pnlOutputPAS'
        TabOrder = 1
        object mmoOutputPAS: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 443
          Height = 199
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
          OnKeyUp = mmoClassKeyUp
        end
        object pnlOutputBottomPAS: TPanel
          AlignWithMargins = True
          Left = 4
          Top = 209
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
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Splitter2: TSplitter
        Left = 420
        Top = 0
        Height = 259
        ExplicitLeft = 428
        ExplicitHeight = 360
      end
      object pnlInputDFM: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 414
        Height = 253
        Align = alLeft
        Caption = 'pnlOutputDFM'
        TabOrder = 0
        object mmoInputDFM: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 406
          Height = 199
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
          OnKeyUp = mmoClassKeyUp
        end
        object pnlInputBottomDFM: TPanel
          AlignWithMargins = True
          Left = 4
          Top = 209
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
        Height = 253
        Align = alClient
        Caption = 'pnlOutputPAS'
        TabOrder = 1
        object mmoInputPAS: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 443
          Height = 199
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
          OnKeyUp = mmoClassKeyUp
        end
        object pnlInputBottomPAS: TPanel
          AlignWithMargins = True
          Left = 4
          Top = 209
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
