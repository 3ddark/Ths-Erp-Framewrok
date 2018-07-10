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
      TabOrder = 0
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
    ActivePage = tsInput
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
        Lines.Strings = (
          'unit Ths.Erp.Database.Table.Ulke;'
          ''
          'interface'
          ''
          'uses'
          
            '  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, D' +
            'ateUtils,'
          '  FireDAC.Stan.Param, System.Variants, Data.DB,'
          '  Ths.Erp.Database,'
          '  Ths.Erp.Database.Table,'
          '  Ths.Erp.Database.Table.Field;'
          ''
          'type'
          '  TUlke = class(TTable)'
          '  private'
          '    FUlkeKodu: TFieldDB;'
          '    FUlkeAdi: TFieldDB;'
          '    FISOYear: TFieldDB;'
          '    FISOCCTLDCode: TFieldDB;'
          '  protected'
          '  published'
          '    constructor Create(OwnerDatabase:TDatabase);override;'
          '  public'
          
            '    procedure SelectToDatasource(pFilter: string; pPermissionCon' +
            'trol: Boolean=True); override;'
          
            '    procedure SelectToList(pFilter: string; pLock: Boolean; pPer' +
            'missionControl: Boolean=True); override;'
          
            '    procedure Insert(out pID: Integer; pPermissionControl: Boole' +
            'an=True); override;'
          
            '    procedure Update(pPermissionControl: Boolean=True); override' +
            ';'
          ''
          '    procedure Clear();override;'
          '    function Clone():TTable;override;'
          ''
          '    property UlkeKodu: TFieldDB read FUlkeKodu write FUlkeKodu;'
          '    Property UlkeAdi: TFieldDB read FUlkeAdi write FUlkeAdi;'
          '    Property ISOYear: TFieldDB read FISOYear write FISOYear;'
          
            '    Property ISOCCTLDCode: TFieldDB read FISOCCTLDCode write FIS' +
            'OCCTLDCode;'
          '  end;'
          ''
          'implementation'
          ''
          'uses'
          '  Ths.Erp.Constants,'
          '  Ths.Erp.Database.Singleton;'
          ''
          'constructor TUlke.Create(OwnerDatabase:TDatabase);'
          'begin'
          '  inherited Create(OwnerDatabase);'
          '  TableName := '#39'ulke'#39';'
          '  SourceCode := '#39'1002'#39';'
          ''
          '  FUlkeKodu := TFieldDB.Create('#39'ulke_kodu'#39', ftString, '#39#39');'
          '  FUlkeAdi := TFieldDB.Create('#39'ulke_adi'#39', ftString, '#39#39');'
          '  FISOYear := TFieldDB.Create('#39'iso_year'#39', ftInteger, '#39#39');'
          
            '  FISOCCTLDCode := TFieldDB.Create('#39'iso_cctld_code'#39', ftString, '#39 +
            #39');'
          'end;'
          ''
          
            'procedure TUlke.SelectToDatasource(pFilter: string; pPermissionC' +
            'ontrol: Boolean=True);'
          'begin'
          '  if IsAuthorized(ptRead, pPermissionControl) then'
          '  begin'
          #9'  with QueryOfTable do'
          #9'  begin'
          #9#9'  Close;'
          #9#9'  SQL.Clear;'
          #9#9'  SQL.Text := Database.GetSQLSelectCmd(TableName, ['
          '          TableName + '#39'.'#39' + Self.Id.FieldName,'
          '          TableName + '#39'.'#39' + FUlkeKodu.FieldName,'
          '          TableName + '#39'.'#39' + FUlkeAdi.FieldName,'
          '          TableName + '#39'.'#39' + FIsoYear.FieldName,'
          '          TableName + '#39'.'#39' + FISOCCTLDCode.FieldName'
          '        ]) +'
          '        '#39'WHERE 1=1 '#39' + pFilter;'
          #9#9'  Open;'
          #9#9'  Active := True;'
          ''
          
            '      Self.DataSource.DataSet.FindField(Self.Id.FieldName).Displ' +
            'ayLabel := '#39'ID'#39';'
          
            '      Self.DataSource.DataSet.FindField(FUlkeKodu.FieldName).Dis' +
            'playLabel := '#39#220'LKE KODU'#39';'
          
            '      Self.DataSource.DataSet.FindField(FUlkeAdi.FieldName).Disp' +
            'layLabel := '#39#220'LKE ADI'#39';'
          
            '      Self.DataSource.DataSet.FindField(FISOYear.FieldName).Disp' +
            'layLabel := '#39'YEAR'#39';'
          
            '      Self.DataSource.DataSet.FindField(FISOCCTLDCode.FieldName)' +
            '.DisplayLabel := '#39'CCTLD CODE'#39';'
          #9'  end;'
          '  end;'
          'end;'
          ''
          
            'procedure TUlke.SelectToList(pFilter: string; pLock: Boolean; pP' +
            'ermissionControl: Boolean=True);'
          'begin'
          '  if IsAuthorized(ptRead, pPermissionControl) then'
          '  begin'
          #9'  if (pLock) then'
          #9#9'  pFilter := pFilter + '#39' FOR UPDATE NOWAIT; '#39';'
          ''
          #9'  with QueryOfTable do'
          #9'  begin'
          #9#9'  Close;'
          #9#9'  SQL.Text := Database.GetSQLSelectCmd(TableName, ['
          '          TableName + '#39'.'#39' + Self.Id.FieldName,'
          '          TableName + '#39'.'#39' + FUlkeKodu.FieldName,'
          '          TableName + '#39'.'#39' + FUlkeAdi.FieldName,'
          '          TableName + '#39'.'#39' + FISOYear.FieldName,'
          '          TableName + '#39'.'#39' + FISOCCTLDCode.FieldName'
          '        ]) +'
          '        '#39'WHERE 1=1 '#39' + pFilter;'
          #9#9'  Open;'
          ''
          #9#9'  FreeListContent();'
          #9#9'  List.Clear;'
          #9#9'  while NOT EOF do'
          #9#9'  begin'
          
            #9#9'    Self.Id.Value := GetVarToFormatedValue(FieldByName(Self.Id' +
            '.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);'
          ''
          
            #9#9'    FUlkeKodu.Value := GetVarToFormatedValue(FieldByName(FUlke' +
            'Kodu.FieldName).DataType, FieldByName(FUlkeKodu.FieldName).Value' +
            ');'
          
            '        FUlkeAdi.Value := GetVarToFormatedValue(FieldByName(FUlk' +
            'eAdi.FieldName).DataType, FieldByName(FUlkeAdi.FieldName).Value)' +
            ';'
          
            '        FISOYear.Value := GetVarToFormatedValue(FieldByName(FISO' +
            'Year.FieldName).DataType, FieldByName(FISOYear.FieldName).Value)' +
            ';'
          
            '        FISOCCTLDCode.Value := GetVarToFormatedValue(FieldByName' +
            '(FISOCCTLDCode.FieldName).DataType, FieldByName(FISOCCTLDCode.Fi' +
            'eldName).Value);'
          ''
          #9#9'    List.Add(Self.Clone());'
          ''
          #9#9'    Next;'
          #9#9'  end;'
          #9#9'  EmptyDataSet;'
          #9#9'  Close;'
          #9'  end;'
          '  end;'
          'end;'
          ''
          
            'procedure TUlke.Insert(out pID: Integer; pPermissionControl: Boo' +
            'lean=True);'
          'begin'
          '  if IsAuthorized(ptAddRecord, pPermissionControl) then'
          '  begin'
          #9'  with QueryOfTable do'
          #9'  begin'
          '      Close;'
          '      SQL.Clear;'
          
            '      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARA' +
            'M_CHAR, ['
          '        FUlkeKodu.FieldName,'
          '        FUlkeAdi.FieldName,'
          '        FISOYear.FieldName,'
          '        FISOCCTLDCode.FieldName'
          '      ]);'
          ''
          
            '      ParamByName(FUlkeKodu.FieldName).Value := GetVarToFormated' +
            'Value(FUlkeKodu.FieldType, FUlkeKodu.Value);'
          
            '      ParamByName(FUlkeAdi.FieldName).Value := GetVarToFormatedV' +
            'alue(FUlkeAdi.FieldType, FUlkeAdi.Value);'
          
            '      ParamByName(FISOYear.FieldName).Value := GetVarToFormatedV' +
            'alue(FISOYear.FieldType, FISOYear.Value);'
          
            '      ParamByName(FISOCCTLDCode.FieldName).Value := GetVarToForm' +
            'atedValue(FISOCCTLDCode.FieldType, FISOCCTLDCode.Value);'
          ''
          '      Database.SetQueryParamsDefaultValue(QueryOfTable);'
          ''
          '      Open;'
          
            '      if (Fields.Count > 0) and (not Fields.FieldByName(Self.Id.' +
            'FieldName).IsNull) then'
          '        pID := Fields.FieldByName(Self.Id.FieldName).AsInteger'
          '      else'
          '        pID := 0;'
          ''
          '      EmptyDataSet;'
          '      Close;'
          #9'  end;'
          '    Self.notify;'
          '  end;'
          'end;'
          ''
          'procedure TUlke.Update(pPermissionControl: Boolean=True);'
          'begin'
          '  if IsAuthorized(ptUpdate, pPermissionControl) then'
          '  begin'
          #9'  with QueryOfTable do'
          #9'  begin'
          #9#9'  Close;'
          #9#9'  SQL.Clear;'
          
            #9#9'  SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_' +
            'CHAR, ['
          #9#9'    FUlkeKodu.FieldName,'
          '        FUlkeAdi.FieldName,'
          '        FISOYear.FieldName,'
          '        FISOCCTLDCode.FieldName'
          '      ]);'
          ''
          
            '      ParamByName(FUlkeKodu.FieldName).Value := GetVarToFormated' +
            'Value(FUlkeKodu.FieldType, FUlkeKodu.Value);'
          
            '      ParamByName(FUlkeAdi.FieldName).Value := GetVarToFormatedV' +
            'alue(FUlkeAdi.FieldType, FUlkeAdi.Value);'
          
            '      ParamByName(FISOYear.FieldName).Value := GetVarToFormatedV' +
            'alue(FISOYear.FieldType, FISOYear.Value);'
          
            '      ParamByName(FISOCCTLDCode.FieldName).Value := GetVarToForm' +
            'atedValue(FISOCCTLDCode.FieldType, FISOCCTLDCode.Value);'
          ''
          
            #9#9'  ParamByName(Self.Id.FieldName).Value := GetVarToFormatedValu' +
            'e(Self.Id.FieldType, Self.Id.Value);'
          ''
          '      Database.SetQueryParamsDefaultValue(QueryOfTable);'
          ''
          #9#9'  ExecSQL;'
          #9#9'  Close;'
          #9'  end;'
          '    Self.notify;'
          '  end;'
          'end;'
          ''
          'procedure TUlke.Clear();'
          'begin'
          '  inherited;'
          '  FUlkeKodu.Value := '#39#39';'
          '  FUlkeAdi.Value := '#39#39';'
          '  FISOYear.Value := 0;'
          '  FISOCCTLDCode.Value := '#39#39';'
          'end;'
          ''
          'function TUlke.Clone():TTable;'
          'begin'
          '  Result := TUlke.Create(Database);'
          ''
          '  Self.Id.Clone(TUlke(Result).Id);'
          ''
          '  FUlkeKodu.Clone(TUlke(Result).FUlkeKodu);'
          '  FUlkeAdi.Clone(TUlke(Result).FUlkeAdi);'
          '  FISOYear.Clone(TUlke(Result).FISOYear);'
          '  FISOCCTLDCode.Clone(TUlke(Result).FISOCCTLDCode);'
          'end;'
          ''
          'end.')
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
          Lines.Strings = (
            'inherited frmCities: TfrmCities'
            '  Caption = '#39'Cities'#39
            '  ClientHeight = 311'
            '  ClientWidth = 548'
            '  ExplicitWidth = 564'
            '  ExplicitHeight = 350'
            '  PixelsPerInch = 96'
            '  TextHeight = 13'
            '  inherited pnlMain: TPanel'
            '    Width = 544'
            '    Height = 245'
            '    ExplicitWidth = 544'
            '    ExplicitHeight = 245'
            '    inherited splLeft: TSplitter'
            '      Height = 128'
            '      ExplicitHeight = 219'
            '    end'
            '    inherited splHeader: TSplitter'
            '      Width = 542'
            '      ExplicitWidth = 554'
            '    end'
            '    inherited pnlLeft: TPanel'
            '      Height = 125'
            '      ExplicitHeight = 125'
            '    end'
            '    inherited pnlHeader: TPanel'
            '      Width = 538'
            '      ExplicitWidth = 538'
            '    end'
            '    inherited pnlContent: TPanel'
            '      Width = 433'
            '      Height = 125'
            '      ExplicitWidth = 433'
            '      ExplicitHeight = 125'
            '      inherited dbgrdBase: TDBGrid'
            '        Width = 431'
            '        Height = 123'
            '      end'
            '    end'
            '    inherited pnlButtons: TPanel'
            '      Top = 165'
            '      Width = 542'
            '      ExplicitTop = 165'
            '      ExplicitWidth = 542'
            '      inherited flwpnlLeft: TFlowPanel'
            '        Width = 233'
            '        ExplicitWidth = 233'
            '      end'
            '      inherited flwpnlRight: TFlowPanel'
            '        Left = 438'
            '        Width = 104'
            '        ExplicitLeft = 438'
            '        ExplicitWidth = 104'
            '        inherited imgFilterRemove: TImage'
            '          Left = 72'
            '          ExplicitLeft = 72'
            '        end'
            '      end'
            '    end'
            '  end'
            '  inherited pnlBottom: TPanel'
            '    Top = 249'
            '    Width = 544'
            '    ExplicitTop = 249'
            '    ExplicitWidth = 544'
            '    inherited btnAccept: TButton'
            '      Left = 335'
            '      ExplicitLeft = 335'
            '    end'
            '    inherited btnDelete: TButton'
            '      Left = 231'
            '      ExplicitLeft = 231'
            '    end'
            '    inherited btnClose: TButton'
            '      Left = 439'
            '      ExplicitLeft = 439'
            '    end'
            '  end'
            '  inherited stbBase: TStatusBar'
            '    Top = 293'
            '    Width = 548'
            '    ExplicitTop = 293'
            '    ExplicitWidth = 548'
            '  end'
            'end')
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
          Lines.Strings = (
            'unit ufrmCities;'
            ''
            'interface'
            ''
            'uses'
            
              '  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data' +
              '.DB,'
            '  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,'
            '  Vcl.ExtCtrls,'
            
              '  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.S' +
              'amples.Spin,'
            '  Vcl.StdCtrls, Vcl.Grids;'
            ''
            'type'
            '  TfrmCities = class(TfrmBaseDBGrid)'
            '    procedure FormCreate(Sender: TObject);override;'
            '  private'
            '    { Private declarations }'
            '  protected'
            
              '    function CreateInputForm(pFormMode: TInputFormMod):TForm; ov' +
              'erride;'
            '  public'
            '    procedure SetSelectedItem();override;'
            '  end;'
            ''
            'implementation'
            ''
            'uses'
            '  ufrmCity,'
            '  Ths.Erp.Database.Table.City;'
            ''
            '{$R *.dfm}'
            ''
            '{ TfrmCities }'
            ''
            
              'function TfrmCities.CreateInputForm(pFormMode: TInputFormMod): T' +
              'Form;'
            'begin'
            '  Result:=nil;'
            '  if (pFormMode = ifmRewiev) then'
            
              '    Result := TfrmCity.Create(Application, Self, Table.Clone(), ' +
              'True, pFormMode)'
            '  else'
            '  if (pFormMode = ifmNewRecord) then'
            
              '    Result := TfrmCity.Create(Application, Self, TCity.Create(Ta' +
              'ble.Database), True, '
            'pFormMode);'
            'end;'
            ''
            'procedure TfrmCities.FormCreate(Sender: TObject);'
            'begin'
            '  QueryDefaultFilter := '#39#39';'
            
              '  QueryDefaultOrder := TCity(Table).CityName.FieldName + '#39' ASC, ' +
              #39' +'
            
              '                       TCity(Table).CountryName.FieldName + '#39' AS' +
              'C'#39';'
            '  inherited;'
            'end;'
            ''
            'procedure TfrmCities.SetSelectedItem;'
            'begin'
            '  inherited;'
            ''
            
              '  TCity(Table).CityName.Value := dbgrdBase.DataSource.DataSet.Fi' +
              'ndField(TCity'
            '(Table).CityName.FieldName).AsString;'
            
              '  TCity(Table).CountryName.Value := dbgrdBase.DataSource.DataSet' +
              '.FindField(TCity'
            '(Table).CountryName.FieldName).AsString;'
            'end;'
            ''
            'end.')
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
          Lines.Strings = (
            'inherited frmCity: TfrmCity'
            '  Left = 501'
            '  Top = 443'
            '  ActiveControl = btnClose'
            '  BorderIcons = [biSystemMenu, biMinimize]'
            '  BorderStyle = bsSingle'
            '  Caption = '#39'City'#39
            '  ClientHeight = 133'
            '  ClientWidth = 377'
            '  Font.Name = '#39'MS Sans Serif'#39
            '  Position = poDesktopCenter'
            '  ExplicitWidth = 383'
            '  ExplicitHeight = 162'
            '  PixelsPerInch = 96'
            '  TextHeight = 13'
            '  inherited pnlMain: TPanel'
            '    Width = 373'
            '    Height = 67'
            '    Color = clWindow'
            '    ParentBackground = False'
            '    ExplicitWidth = 373'
            '    ExplicitHeight = 67'
            '    object lblcity_name: TLabel'
            '      Left = 50'
            '      Top = 6'
            '      Width = 58'
            '      Height = 13'
            '      Alignment = taRightJustify'
            '      BiDiMode = bdLeftToRight'
            '      Caption = '#39'City Name'#39
            '      Font.Charset = DEFAULT_CHARSET'
            '      Font.Color = clWindowText'
            '      Font.Height = -11'
            '      Font.Name = '#39'MS Sans Serif'#39
            '      Font.Style = [fsBold]'
            '      ParentBiDiMode = False'
            '      ParentFont = False'
            '    end'
            '    object lblcountry_name: TLabel'
            '      Left = 28'
            '      Top = 28'
            '      Width = 80'
            '      Height = 13'
            '      Alignment = taRightJustify'
            '      BiDiMode = bdLeftToRight'
            '      Caption = '#39'Country Name'#39
            '      Font.Charset = DEFAULT_CHARSET'
            '      Font.Color = clWindowText'
            '      Font.Height = -11'
            '      Font.Name = '#39'MS Sans Serif'#39
            '      Font.Style = [fsBold]'
            '      ParentBiDiMode = False'
            '      ParentFont = False'
            '    end'
            '    object edtCityName: TthsEdit'
            '      Left = 114'
            '      Top = 3'
            '      Width = 239'
            '      Height = 21'
            '      TabOrder = 0'
            '      thsAlignment = taLeftJustify'
            '      thsColorActive = clSkyBlue'
            '      thsColorRequiredData = 7367916'
            '      thsTabEnterKeyJump = True'
            '      thsInputDataType = itString'
            '      thsCaseUpLowSupportTr = True'
            '      thsDecimalDigit = 4'
            '      thsRequiredData = True'
            '      thsDoTrim = True'
            '      thsActiveYear = 2018'
            '    end'
            '    object cbbCountryName: TthsCombobox'
            '      Left = 114'
            '      Top = 25'
            '      Width = 239'
            '      Height = 21'
            '      TabOrder = 1'
            '      thsAlignment = taLeftJustify'
            '      thsColorActive = clSkyBlue'
            '      thsColorRequiredData = 7367916'
            '      thsTabEnterKeyJump = True'
            '      thsInputDataType = itString'
            '      thsCaseUpLowSupportTr = True'
            '      thsDecimalDigit = 4'
            '      thsRequiredData = True'
            '      thsDoTrim = True'
            '      thsActiveYear = 2018'
            '    end'
            '  end'
            '  inherited pnlBottom: TPanel'
            '    Top = 71'
            '    Width = 373'
            '    ExplicitTop = 71'
            '    ExplicitWidth = 373'
            '    inherited btnAccept: TButton'
            '      Left = 164'
            '      ExplicitLeft = 164'
            '    end'
            '    inherited btnDelete: TButton'
            '      Left = 60'
            '      ExplicitLeft = 60'
            '    end'
            '    inherited btnClose: TButton'
            '      Left = 268'
            '      ExplicitLeft = 268'
            '    end'
            '  end'
            '  inherited stbBase: TStatusBar'
            '    Top = 115'
            '    Width = 377'
            '    ExplicitTop = 115'
            '    ExplicitWidth = 377'
            '  end'
            'end')
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
          Lines.Strings = (
            'unit ufrmCity;'
            ''
            'interface'
            ''
            'uses'
            
              '  Windows, Messages, SysUtils, Variants, Classes, Graphics, Cont' +
              'rols, Forms,'
            '  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,'
            '  Vcl.AppEvnts,'
            '  thsEdit, thsComboBox,'
            ''
            '  ufrmBase, ufrmBaseInputDB,'
            '  Ths.Erp.Database.Table.Country, System.ImageList, Vcl.ImgList,'
            '  Vcl.Samples.Spin;'
            ''
            'type'
            '  TfrmCity = class(TfrmBaseInputDB)'
            '    lblcity_name: TLabel;'
            '    lblcountry_name: TLabel;'
            '    edtCityName: TthsEdit;'
            '    cbbCountryName: TthsCombobox;'
            '    destructor Destroy; override;'
            '    procedure FormCreate(Sender: TObject);override;'
            '    procedure Repaint(); override;'
            '    procedure RefreshData();override;'
            '    procedure btnAcceptClick(Sender: TObject);override;'
            '  private'
            '  public'
            ''
            '  protected'
            '  published'
            '    procedure FormShow(Sender: TObject); override;'
            '  end;'
            ''
            'implementation'
            ''
            'uses'
            '  Ths.Erp.Database.Table.City;'
            ''
            '{$R *.dfm}'
            ''
            'Destructor TfrmCity.Destroy;'
            'begin'
            '  //'
            '  inherited;'
            'end;'
            ''
            'procedure TfrmCity.FormCreate(Sender: TObject);'
            'var'
            '  n1: Integer;'
            '  vCountry: TCountry;'
            'begin'
            
              '  TCity(Table).CityName.SetControlProperty(Table.TableName, edtC' +
              'ityName);'
            
              '  TCity(Table).CountryName.SetControlProperty(Table.TableName, c' +
              'bbCountryName);'
            ''
            '  inherited;'
            ''
            '  vCountry := TCountry.Create(Table.Database);'
            '  try'
            '    vCountry.SelectToList('#39#39', False, False);'
            ''
            '    cbbCountryName.Clear;'
            '    for n1 := 0 to vCountry.List.Count-1 do'
            '      cbbCountryName.Items.Add( VarToStr(TCountry(vCountry.List'
            '[n1]).CountryName.Value) );'
            '    cbbCountryName.ItemIndex := -1;'
            '  finally'
            '    vCountry.Free;'
            '  end;'
            'end;'
            ''
            'procedure TfrmCity.FormShow(Sender: TObject);'
            'begin'
            '  //'
            '  inherited;'
            'end;'
            ''
            'procedure TfrmCity.Repaint();'
            'begin'
            '  inherited;'
            '  //'
            'end;'
            ''
            'procedure TfrmCity.RefreshData();'
            'begin'
            '  //control i'#231'eri'#287'ini table class ile doldur'
            '  edtCityName.Text := TCity(Table).CityName.Value;'
            
              '  cbbCountryName.ItemIndex := cbbCountryName.Items.IndexOf( VarT' +
              'oStr(TCity'
            '(Table).CountryName.Value) );'
            'end;'
            ''
            'procedure TfrmCity.btnAcceptClick(Sender: TObject);'
            'begin'
            '  if (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) then'
            '  begin'
            '    if (ValidateInput) then'
            '    begin'
            '      TCity(Table).CityName.Value := edtCityName.Text;'
            '      TCity(Table).CountryName.Value := cbbCountryName.Text;'
            '      inherited;'
            '    end;'
            '  end'
            '  else'
            '    inherited;'
            'end;'
            ''
            'end.')
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
end
