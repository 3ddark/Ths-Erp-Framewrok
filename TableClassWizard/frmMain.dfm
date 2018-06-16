object frmMainClassGenerator: TfrmMainClassGenerator
  Left = 0
  Top = 0
  Caption = 'Class Generator'
  ClientHeight = 398
  ClientWidth = 907
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 70
    Top = 14
    Width = 58
    Height = 13
    BiDiMode = bdRightToLeft
    Caption = 'Unit Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
  end
  object Label2: TLabel
    Left = 68
    Top = 36
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
    Left = 62
    Top = 58
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
    Left = 58
    Top = 80
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
    Left = 251
    Top = 128
    Width = 42
    Height = 13
    BiDiMode = bdRightToLeft
    Caption = 'caption'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
  end
  object lblFieldType: TLabel
    Left = 171
    Top = 128
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
  object lblFieldName: TLabel
    Left = 86
    Top = 128
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
  object lblpropertyname: TLabel
    Left = 10
    Top = 128
    Width = 54
    Height = 13
    BiDiMode = bdRightToLeft
    Caption = 'pro name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
  end
  object edtUnitName: TthsEdit
    Left = 134
    Top = 11
    Width = 146
    Height = 21
    TabOrder = 0
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
    Left = 134
    Top = 33
    Width = 146
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
    Left = 134
    Top = 55
    Width = 146
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
    Left = 134
    Top = 77
    Width = 146
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
  object btnCreateFile: TButton
    Left = 246
    Top = 358
    Width = 75
    Height = 25
    Caption = 'Create File'
    TabOrder = 12
    OnClick = btnCreateFileClick
  end
  object btnAddMemo: TButton
    Left = 165
    Top = 358
    Width = 75
    Height = 25
    Caption = 'Add Memo'
    TabOrder = 11
    OnClick = btnAddMemoClick
  end
  object strngrdList: TStringGrid
    Left = 7
    Top = 199
    Width = 314
    Height = 153
    ColCount = 4
    DefaultColWidth = 71
    FixedCols = 0
    FixedRows = 0
    TabOrder = 10
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
  object btnAddField: TButton
    Left = 246
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Add Field'
    TabOrder = 8
    OnClick = btnAddFieldClick
  end
  object btnClearLists: TButton
    Left = 165
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Clear List'
    TabOrder = 9
    OnClick = btnClearListsClick
  end
  object edtCaption: TthsEdit
    Left = 251
    Top = 141
    Width = 70
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
  object cbbFieldType: TthsCombobox
    Left = 171
    Top = 141
    Width = 74
    Height = 21
    Style = csDropDownList
    TabOrder = 6
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
  object edtFieldName: TthsEdit
    Left = 86
    Top = 141
    Width = 74
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
  object edtpropertyname: TthsEdit
    Left = 10
    Top = 141
    Width = 70
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
  object Memo1: TMemo
    Left = 324
    Top = 8
    Width = 575
    Height = 378
    Lines.Strings = (
      'unit Ths.Erp.Database.Table.Country;'
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
      '  TCountry = class(TTable)'
      '  private'
      '    FCountryCode : TFieldDB;'
      '    FCountryName : TFieldDB;'
      '    FISOYear : TFieldDB;'
      '    FISOCCTLDCode : TFieldDB;'
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
      
        '    property CountryCode: TFieldDB read FCountryCode write FCoun' +
        'tryCode;'
      
        '    Property CountryName: TFieldDB read FCountryName write FCoun' +
        'tryName;'
      '    Property ISOYear : TFieldDB read FISOYear write FISOYear;'
      
        '    Property ISOCCTLDCode : TFieldDB read FISOCCTLDCode write FI' +
        'SOCCTLDCode;'
      '  end;'
      ''
      'implementation'
      ''
      'uses'
      '  Ths.Erp.Constants;'
      ''
      'constructor TCountry.Create(OwnerDatabase:TDatabase);'
      'begin'
      '  inherited Create(OwnerDatabase);'
      '  TableName := '#39'country'#39';'
      '  SourceCode := '#39'1002'#39';'
      ''
      '  FCountryCode := TFieldDB.Create('#39'country_code'#39', ftString, '#39#39');'
      '  FCountryName := TFieldDB.Create('#39'country_name'#39', ftString, '#39#39');'
      '  FISOYear := TFieldDB.Create('#39'iso_year'#39', ftInteger, '#39#39');'
      
        '  FISOCCTLDCode := TFieldDB.Create('#39'iso_cctld_code'#39', ftString, '#39 +
        #39');'
      'end;'
      ''
      
        'procedure TCountry.SelectToDatasource(pFilter: string; pPermissi' +
        'onControl: Boolean=True);'
      'begin'
      '  if Self.IsAuthorized(ptRead, pPermissionControl) then'
      '  begin'
      '    with QueryOfTable do'
      '    begin'
      '      Close;'
      '      SQL.Clear;'
      '      SQL.Text := Self.Database.GetSQLSelectCmd(TableName,'
      '        [TableName + '#39'.'#39' + Self.Id.FieldName,'
      '        TableName + '#39'.'#39' + FCountryCode.FieldName,'
      '        TableName + '#39'.'#39' + FCountryName.FieldName,'
      '        TableName + '#39'.'#39' + FIsoYear.FieldName,'
      '        TableName + '#39'.'#39' + FISOCCTLDCode.FieldName]) +'
      '        '#39'WHERE 1=1 '#39' + pFilter;'
      '      Open;'
      '      Active := True;'
      ''
      
        '      Self.DataSource.DataSet.FindField(Self.Id.FieldName).Displ' +
        'ayLabel := '#39'ID'#39';'
      
        '      Self.DataSource.DataSet.FindField(FCountryCode.FieldName).' +
        'DisplayLabel := '#39'COUNTRY CODE'#39';'
      
        '      Self.DataSource.DataSet.FindField(FCountryName.FieldName).' +
        'DisplayLabel := '#39'COUNTRY NAME'#39';'
      
        '      Self.DataSource.DataSet.FindField(FISOYear.FieldName).Disp' +
        'layLabel := '#39'YEAR'#39';'
      
        '      Self.DataSource.DataSet.FindField(FISOCCTLDCode.FieldName)' +
        '.DisplayLabel := '#39'CCTLD CODE'#39';'
      '    end;'
      '  end;'
      'end;'
      ''
      
        'procedure TCountry.SelectToList(pFilter: string; pLock: Boolean;' +
        ' pPermissionControl: Boolean=True);'
      'begin'
      '  if Self.IsAuthorized(ptRead, pPermissionControl) then'
      '  begin'
      '    if (pLock) then'
      '      pFilter := pFilter + '#39' FOR UPDATE NOWAIT; '#39';'
      ''
      '    with QueryOfTable do'
      '    begin'
      '      Close;'
      '      SQL.Text := Self.Database.GetSQLSelectCmd(TableName,'
      '        [TableName + '#39'.'#39' + Self.Id.FieldName,'
      '        TableName + '#39'.'#39' + FCountryCode.FieldName,'
      '        TableName + '#39'.'#39' + FCountryName.FieldName,'
      '        TableName + '#39'.'#39' + FISOYear.FieldName,'
      '        TableName + '#39'.'#39' + FISOCCTLDCode.FieldName]) +'
      '        '#39' WHERE 1=1 '#39' + pFilter;'
      '      Open;'
      ''
      '      FreeListContent();'
      '      List.Clear;'
      '      while NOT EOF do'
      '      begin'
      
        '        Self.Id.Value := FieldByName(Self.Id.FieldName).AsIntege' +
        'r;'
      ''
      
        '        Self.FCountryCode.Value := FieldByName(FCountryCode.Fiel' +
        'dName).AsString;'
      
        '        Self.FCountryName.Value := FieldByName(FCountryName.Fiel' +
        'dName).AsString;'
      
        '        Self.FISOYear.Value := FieldByName(FISOYear.FieldName).A' +
        'sInteger;'
      
        '        Self.FISOCCTLDCode.Value := FieldByName(FISOCCTLDCode.Fi' +
        'eldName).AsString;'
      ''
      '        List.Add(Self.Clone());'
      '        Next;'
      '      end;'
      '      EmptyDataSet;'
      '      Close;'
      '    end;'
      '  end;'
      'end;'
      ''
      
        'procedure TCountry.Insert(out pID: Integer; pPermissionControl: ' +
        'Boolean=True);'
      'begin'
      '  if Self.IsAuthorized(ptAddRecord, pPermissionControl) then'
      '  begin'
      '    with QueryOfTable do'
      '    begin'
      '      Close;'
      '      SQL.Clear;'
      
        '      SQL.Text := Self.Database.GetSQLInsertCmd(TableName, SQL_P' +
        'ARAM_SEPERATE,'
      
        '        [FCountryCode.FieldName, FCountryName.FieldName, FISOYea' +
        'r.FieldName, FISOCCTLDCode.FieldName]);'
      ''
      
        '      ParamByName(FCountryCode.FieldName).Value := Self.FCountry' +
        'Code.Value;'
      
        '      ParamByName(FCountryName.FieldName).Value := Self.FCountry' +
        'Name.Value;'
      
        '      ParamByName(FISOYear.FieldName).Value := Self.FISOYear.Val' +
        'ue;'
      
        '      ParamByName(ISOCCTLDCode.FieldName).Value := Self.ISOCCTLD' +
        'Code.Value;'
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
      '    end;'
      '    Self.notify;'
      '  end;'
      'end;'
      ''
      'procedure TCountry.Update(pPermissionControl: Boolean=True);'
      'begin'
      '  if Self.IsAuthorized(ptUpdate, pPermissionControl) then'
      '  begin'
      '    with QueryOfTable do'
      '    begin'
      '    Close;'
      '    SQL.Clear;'
      
        '    SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, SQL_PAR' +
        'AM_SEPERATE,'
      
        '      [FCountryCode.FieldName, FCountryName.FieldName, FISOYear.' +
        'FieldName, ISOCCTLDCode.FieldName]);'
      ''
      
        '      ParamByName(FCountryCode.FieldName).Value := Self.FCountry' +
        'Code.Value;'
      
        '      ParamByName(FCountryName.FieldName).Value := Self.FCountry' +
        'Name.Value;'
      
        '      ParamByName(FISOYear.FieldName).Value := Self.FISOYear.Val' +
        'ue;'
      
        '      ParamByName(FISOCCTLDCode.FieldName).Value := Self.FISOCCT' +
        'LDCode.Value;'
      ''
      '      ParamByName(Self.Id.FieldName).Value := Self.Id.Value;'
      ''
      '      Database.SetQueryParamsDefaultValue(QueryOfTable);'
      ''
      '      ExecSQL;'
      '      Close;'
      '    end;'
      '    Self.notify;'
      '  end;'
      'end;'
      ''
      'procedure TCountry.Clear();'
      'begin'
      '  inherited;'
      '  self.FCountryCode.Value := '#39#39';'
      '  self.FCountryName.Value := '#39#39';'
      '  self.FISOYear.Value := 0;'
      '  self.FISOCCTLDCode.Value := '#39#39';'
      'end;'
      ''
      'function TCountry.Clone():TTable;'
      'begin'
      '  Result := TCountry.Create(Database);'
      ''
      '  Self.Id.Clone(TCountry(Result).Id);'
      ''
      '  Self.FCountryCode.Clone(TCountry(Result).FCountryCode);'
      '  Self.FCountryName.Clone(TCountry(Result).FCountryName);'
      '  Self.FISOYear.Clone(TCountry(Result).FISOYear);'
      '  Self.FISOCCTLDCode.Clone(TCountry(Result).FISOCCTLDCode);'
      'end;'
      ''
      'end.')
    ScrollBars = ssBoth
    TabOrder = 13
    OnKeyPress = Memo1KeyPress
  end
end
