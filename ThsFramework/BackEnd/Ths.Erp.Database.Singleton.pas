unit Ths.Erp.Database.Singleton;

interface

uses
  IniFiles, SysUtils, WinTypes, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, Vcl.StdCtrls,
  Data.DB, FireDAC.Stan.Param, FireDAC.Comp.Client, System.Variants,
  Ths.Erp.Database,
  Ths.Erp.Database.Table.SysUser,
  Ths.Erp.Database.Table.AyarHaneSayisi,
  Ths.Erp.Database.Table.SysApplicationSettings;

type
  TLang = record
    StatusAccept: string;
    StatusAdd: string;
    StatusCancel: string;
    StatusDelete: string;

    ButtonAccept: string;
    ButtonAdd: string;
    ButtonCancel: string;
    ButtonClose: string;
    ButtonDelete: string;
    ButtonFilter: string;
    ButtonUpdate: string;

    ErrorAccessRight: string;
    ErrorDatabaseConnection: string;
    ErrorLogin: string;
    ErrorRecordDeleted: string;
    ErrorRecordDeletedMessage: string;
    ErrorRedInputsRequired: string;
    ErrorRequiredData: string;

    GeneralConfirmationLower: string;
    GeneralConfirmationUpper: string;
    GeneralNoUpper: string;
    GeneralNoLower: string;
    GeneralYesUpper: string;
    GeneralYesLower: string;
    GeneralRecordCount: string;

    FilterFilterCriteriaTitle: string;
    FilterLike: string;
    FilterNotLike: string;
    FilterSelectFilterFields: string;
    FilterWithEnd: string;
    FilterWithStart: string;

    MessageApplicationTerminate: string;
    MessageCloseWindow: string;
    MessageDeleteRecord: string;
    MessageUnsupportedProcess: string;
    MessageUpdateRecord: string;

    PopupAddLanguageContent: string;
    PopupAddLanguageData: string;
    PopupCopyRecord: string;
    PopupExcludeFilter: string;
    PopupExportExcel: string;
    PopupExportExcelAll: string;
    PopupFilter: string;
    PopupPreview: string;
    PopupPrint: string;
    PopupRemoveFilter: string;
    PopupRemoveSort: string;

    WarningActiveTransaction: string;
    WarningLockedRecord: string;
    WarningOpenWindow: string;
  end;

type
  TSingletonDB = class(TObject)
  strict private
    class var FInstance: TSingletonDB;
    constructor CreatePrivate;
  private
    FDataBase: TDatabase;
    FUser: TSysUser;
    FLangFramework: TLang;
    FHaneMiktari: TAyarHaneSayisi;
    FApplicationSetting: TSysApplicationSettings;
  public
    property DataBase: TDatabase read FDataBase write FDataBase;
    property User: TSysUser read FUser write FUser;
    property LangFramework : TLang read FLangFramework;
    property HaneMiktari: TAyarHaneSayisi read FHaneMiktari write FHaneMiktari;
    property ApplicationSetting: TSysApplicationSettings read FApplicationSetting write FApplicationSetting;

    constructor Create;
    class function GetInstance(): TSingletonDB;

    destructor Destroy; override;

    function GetGridDefaultOrderFilter(pKey: string; pIsOrder: Boolean): string;
    function GetIsRequired(pTableName, pFieldName: string): Boolean;
    function GetTextFromLang(pDefault, pCode, pTip: string; pTable: string=''): string;
    function GetMaxLength(pTableName, pFieldName: string): Integer;
    function GetQualityFormNo(pTableName: string): string;

    procedure FillTableName(var pComboBox: TComboBox);
    procedure FillColName(var pComboBox: TComboBox; pTableName: string);
    procedure FillColNameForColWidth(var pComboBox: TComboBox; pTableName: string);
    function GetDistinctColumnName(pTableName: string): TStringList;
    function GetLangTextSQL(pRawTableColName, pRawTableName, pDataColName, pVirtualColName: string): string;
    function GetRawDataSQLByLang(pBaseTableName, pBaseColName: string): string;

    function FillComboFramLangData(pComboBox: TComboBox; pBaseTableName, pBaseColName: string; pRowID: Integer): string;
  end;

  function GetVarToFormatedValue(pType: TFieldType; pVal: Variant): Variant;
  function ReplaceToRealColOrTableName(const pTableName: string): string;
  function ReplaceRealColOrTableNameTo(const pTableName: string): string;

var
  SingletonDB: TSingletonDB;
  vLangContent, vLangContent2: string;

implementation

uses
  Ths.Erp.Database.Table.View.SysViewColumns,
  Ths.Erp.Database.Table.SysGridDefaultOrderFilter,
  Ths.Erp.SpecialFunctions, Ths.Erp.Constants, Ths.Erp.Database.Table;

function GetVarToFormatedValue(pType: TFieldType; pVal: Variant): Variant;
var
  vValueInt: Integer;
  vValueDouble: Double;
  vValueBool: Boolean;
begin
  if (pType = ftString)
  or (pType = ftMemo)
  or (pType = ftWideString)
  or (pType = ftWideMemo)
  or (pType = ftWideString)
  then
  begin
    if not VarIsNull(pVal) then
    begin
      Result := VarToStr(pVal)
    end
    else
      Result := '';
  end
  else
  if (pType = ftSmallint)
  or (pType = ftShortint)
  or (pType = ftInteger)
  or (pType = ftLargeint)
  or (pType = ftWord)
  or (pType = ftBCD)
  then
  begin
    if not VarIsNull(pVal) then
    begin
      if TryStrToInt(pVal, vValueInt) then
        Result := VarToStr(pVal).ToInteger
      else
        Result := 0;
    end
    else
      Result := 0;
  end
  else
  if (pType = ftFloat)
  or (pType = ftCurrency)
  or (pType = ftSingle)
  then
  begin
    if not VarIsNull(pVal) then
    begin
      if TryStrToFloat(pVal, vValueDouble) then
        Result := VarToStr(pVal).ToDouble
      else
        Result := 0.0;
    end
    else
      Result := 0.0;
  end
  else
  if (pType = ftBoolean) then
  begin
    if not VarIsNull(pVal) then
    begin
      if TryStrToBool(pVal, vValueBool) then
        Result := VarToStr(pVal).ToBoolean
      else
        Result := False;
    end
    else
      Result := False;
  end
  else
  if (pType = ftBlob) then
    Result := pVal
  else
    Result := pVal;
end;

function ReplaceToRealColOrTableName(const pTableName: string): string;
begin
  Result := StringReplace(pTableName, ' ', '_', [rfReplaceAll]);
  Result := LowerCase(Result);
end;

function ReplaceRealColOrTableNameTo(const pTableName: string): string;
var
  n1: Integer;
  vDump: string;
begin
  vDump := StringReplace(pTableName, '_', ' ', [rfReplaceAll]);

  if vDump = '' then
    Result := ''
  else
  begin
    Result := Uppercase(vDump[1]);
    for n1 := 2 to Length(vDump) do
    begin
      if vDump[n1-1] = ' ' then
        Result := Result + Uppercase(vDump[n1])
      else
        Result := Result + Lowercase(vDump[n1]);
    end;
  end;

end;

constructor TSingletonDB.Create();
begin
  raise Exception.Create('Object Singleton');
end;

constructor TSingletonDB.CreatePrivate;
begin
  inherited Create;

  FLangFramework.StatusAccept := 'Accept';
  FLangFramework.StatusAdd := 'Add';
  FLangFramework.StatusCancel := 'Cancel';
  FLangFramework.StatusDelete := 'Delete';

  FLangFramework.ButtonAccept := 'Accept';
  FLangFramework.ButtonAdd := 'Add';
  FLangFramework.ButtonCancel := 'Cancel';
  FLangFramework.ButtonClose := 'Close';
  FLangFramework.ButtonDelete := 'Delete';
  FLangFramework.ButtonFilter := 'Filter';
  FLangFramework.ButtonUpdate := 'Update';

  FLangFramework.ErrorAccessRight := 'Access Right';
  FLangFramework.ErrorDatabaseConnection := 'Database Connection';
  FLangFramework.ErrorLogin := 'Login';
  FLangFramework.ErrorRecordDeleted := 'Record Deleted';
  FLangFramework.ErrorRecordDeletedMessage := 'Record Deleted Message';
  FLangFramework.ErrorRedInputsRequired := 'Red Inputs Required';
  FLangFramework.ErrorRequiredData := 'Required Data';

  FLangFramework.GeneralConfirmationLower := 'Confirmation Lower';
  FLangFramework.GeneralConfirmationUpper := 'Confirmation Upper';
  FLangFramework.GeneralNoLower := 'No Lower';
  FLangFramework.GeneralNoUpper := 'No Upper';
  FLangFramework.GeneralRecordCount := 'Record Count';
  FLangFramework.GeneralYesLower := 'Yes Lower';
  FLangFramework.GeneralYesUpper := 'Yes Upper';

  FLangFramework.MessageApplicationTerminate := 'Application Terminate';
  FLangFramework.MessageCloseWindow := 'Close Window';
  FLangFramework.MessageDeleteRecord := 'Delete Record';
  FLangFramework.MessageUnsupportedProcess := 'Unsupported Process';
  FLangFramework.MessageUpdateRecord := 'Update Record';

  FLangFramework.PopupAddLanguageContent := 'Add Language Content';
  FLangFramework.PopupAddLanguageData := 'Add Language Data';
  FLangFramework.PopupCopyRecord := 'Copy Record';
  FLangFramework.PopupExcludeFilter := 'Exclude Filter';
  FLangFramework.PopupExportExcel := 'Export Excel';
  FLangFramework.PopupExportExcelAll := 'Export Excel All';
  FLangFramework.PopupFilter := 'Filter';
  FLangFramework.PopupPreview := 'Preview';
  FLangFramework.PopupPrint := 'Print';
  FLangFramework.PopupRemoveFilter := 'Remove Filter';
  FLangFramework.PopupRemoveSort := 'Remove Sort';

  FLangFramework.WarningActiveTransaction := 'Active Transaction';
  FLangFramework.WarningLockedRecord := 'Locked Record';
  FLangFramework.WarningOpenWindow := 'Open Window';


  if Self.FDataBase = nil then
    FDataBase := TDatabase.Create;

  if Self.FUser = nil then
    FUser := TSysUser.Create(Self.FDataBase);

  if Self.FHaneMiktari = nil then
    FHaneMiktari := TAyarHaneSayisi.Create(Self.FDataBase);

  if Self.FApplicationSetting = nil then
    FApplicationSetting := TSysApplicationSettings.Create(Self.FDataBase);
end;

destructor TSingletonDB.Destroy();
begin
  if SingletonDB <> Self then
  begin
    SingletonDB := nil;
  end;

  FUser.Free;
  FHaneMiktari.Free;
  FDataBase.Free;
  FApplicationSetting.Free;

  inherited Destroy;
end;

class function TSingletonDB.GetInstance: TSingletonDB;
begin
  if not Assigned(FInstance) then
    FInstance := TSingletonDB.CreatePrivate;
  Result := FInstance;
end;

function TSingletonDB.GetGridDefaultOrderFilter(pKey: string; pIsOrder: Boolean): string;
var
  vSysGridDefaultOrderFilter: TSysGridDefaultOrderFilter;
  vOrderFilter: string;
begin
  Result := '';
  if pIsOrder then
    vOrderFilter := ' and is_order=True'
  else
    vOrderFilter := ' and is_order=False';

  vSysGridDefaultOrderFilter := TSysGridDefaultOrderFilter.Create(TSingletonDB.GetInstance.DataBase);
  try
    vSysGridDefaultOrderFilter.SelectToList(vOrderFilter + ' and key=' + QuotedStr(pKey), False, False);
    if vSysGridDefaultOrderFilter.List.Count=1 then
      Result := TSysGridDefaultOrderFilter(vSysGridDefaultOrderFilter.List[0]).Value.Value;
  finally
    vSysGridDefaultOrderFilter.Free;
  end;

  if Trim(Result) <> '' then
    if not pIsOrder then
      Result := ' AND ' + Result;
end;

function TSingletonDB.GetIsRequired(pTableName, pFieldName: string): Boolean;
var
  vSysInputGui: TSysViewColumns;
begin
  Result := False;

  vSysInputGui := TSysViewColumns.Create(TSingletonDB.GetInstance.DataBase);
  try
    vSysInputGui.SelectToList(' and table_name=' + QuotedStr(pTableName) +
                              ' and column_name=' + QuotedStr(pFieldName), False, False);
    if vSysInputGui.List.Count=1 then
      Result := TSysViewColumns(vSysInputGui.List[0]).IsNullable.Value = 'NO';
  finally
    vSysInputGui.Free;
  end;
end;

function TSingletonDB.FillComboFramLangData(pComboBox: TComboBox; pBaseTableName,
    pBaseColName: string; pRowID: Integer): string;
begin
  pComboBox.Clear;
  with DataBase.NewQuery do
  try
    Close;
    SQL.Text :=
        'SELECT ' +
        ' CASE ' +
        '   WHEN b.value IS NULL THEN a.' + pBaseColName + ' ' +
        '   ELSE b.value ' +
        ' END as value ' +
        'FROM public.' + pBaseTableName + ' a ' +
        'LEFT JOIN sys_table_lang_content b ON b.row_id = a.id ' +
        '   AND b.table_name = ' + QuotedStr( ReplaceRealColOrTableNameTo(pBaseTableName) ) + ' ' +
        '   AND b.lang=' + QuotedStr(Self.FInstance.DataBase.ConnSetting.Language);
    Open;
    while NOT EOF do
    begin
      pComboBox.Items.Add(Fields.Fields[0].AsString);
      Next;
    end;
    EmptyDataSet;
    Close;
  finally
    Free;
  end;
end;

function TSingletonDB.GetRawDataSQLByLang(pBaseTableName, pBaseColName: string): string;
begin
  Result :=
    '(SELECT ' +
    '  CASE WHEN b.value IS NULL THEN a.' + pBaseColName + ' ' +
    '  ELSE b.value ' +
    '  END as ' + pBaseColName + ' ' +
    'FROM public.' + pBaseTableName + ' a ' +
    'LEFT JOIN sys_table_lang_content b ON b.row_id = a.id ' +
      ' AND b.table_name=' + QuotedStr(ReplaceRealColOrTableNameTo(pBaseTableName)) +
      ' AND b.lang=' + QuotedStr(Self.FInstance.DataBase.ConnSetting.Language) + ' ' +
    'WHERE b.row_id = ' + pBaseTableName + '.id)::varchar as ' + pBaseColName;
end;

function TSingletonDB.GetLangTextSQL(pRawTableColName, pRawTableName, pDataColName, pVirtualColName: string): string;
begin
  Result :=
      '(SELECT get_lang_text(' +
        '(SELECT ' + pRawTableColName + ' FROM ' + pRawTableName + ' WHERE id=' + pDataColName + ')' + ',' +
        QuotedStr(ReplaceRealColOrTableNameTo(pRawTableName) ) + ',' +
        QuotedStr(ReplaceRealColOrTableNameTo(pRawTableColName)) + ', ' +
        pDataColName + ', ' +
        QuotedStr(TSingletonDB.GetInstance.DataBase.ConnSetting.Language) + ')) as ' + pVirtualColName;
end;

function TSingletonDB.GetMaxLength(pTableName, pFieldName: string): Integer;
var
  vSysInputGui: TSysViewColumns;
begin
  Result := 0;

  vSysInputGui := TSysViewColumns.Create(TSingletonDB.GetInstance.DataBase);
  try
    vSysInputGui.SelectToList(' and table_name=' + QuotedStr(pTableName) +
                              ' and column_name=' + QuotedStr(pFieldName), False, False);
    if vSysInputGui.List.Count=1 then
      Result := TSysViewColumns(vSysInputGui.List[0]).CharacterMaximumLength.Value;
  finally
    vSysInputGui.Free;
  end;
end;

function TSingletonDB.GetQualityFormNo(pTableName: string): string;
var
  Query: TFDQuery;
begin
  Result := '';

  if Self.FInstance.DataBase.Connection.Connected then
  begin
    Query := Self.FInstance.DataBase.NewQuery;
    try
      with Query do
      begin
        Close;
        SQL.Text := 'SELECT form_no FROM sys_quality_form_number WHERE table_name=:table_name;';
        ParamByName('table_name').Value := pTableName;
        Open;

        if (not (Fields.Fields[0].IsNull)) and (Fields.Fields[0].AsString <> '') then
          Result := Fields.Fields[0].AsString;

        EmptyDataSet;
        Close;
      end;
    finally
      Query.Free;
    end;
  end;
end;

function TSingletonDB.GetTextFromLang(pDefault, pCode, pTip: string; pTable: string=''): string;
var
  Query: TFDQuery;
  vFilter: string;
begin
  Result := pDefault;

  vFilter := 'lang=' + QUERY_PARAM_CHAR + 'lang AND code=' + QUERY_PARAM_CHAR + 'code AND content_type=' + QUERY_PARAM_CHAR + 'content_type';

  if pTable <> '' then
    vFilter := vFilter + ' AND table_name=' + QUERY_PARAM_CHAR + 'table_name';

  if Self.FInstance.DataBase.Connection.Connected then
  begin
    Query := Self.FInstance.DataBase.NewQuery;
    try
      with Query do
      begin
        Close;
        SQL.Text := 'SELECT value FROM sys_lang_contents ' +
                    'WHERE 1=1 AND ' + vFilter;
        ParamByName('lang').Value := Self.FInstance.DataBase.ConnSetting.Language;
        ParamByName('code').Value := pCode;
        ParamByName('content_type').Value := pTip;
        if pTable <> '' then
          ParamByName('table_name').Value := pTable;
        Open;

        if not (Fields.Fields[0].IsNull) then
          Result := Fields.Fields[0].AsString;

        if Result = '' then
          Result := pDefault;

        EmptyDataSet;
        Close;
      end;
    finally
      Query.Free;
    end;
  end;
end;

procedure TSingletonDB.FillTableName(var pComboBox: TComboBox);
begin
  pComboBox.Clear;
  with Self.DataBase.NewQuery do
  try
    Close;
    SQL.Text := 'SELECT distinct table_name, table_type FROM sys_view_columns ' +
                'GROUP BY table_name, table_type ' +
                'ORDER BY table_type, table_name ASC';
    Open;
    while NOT EOF do
    begin
      pComboBox.Items.Add(Fields.Fields[0].AsString);
      Next;
    end;
    EmptyDataSet;
    Close;
  finally
    Free;
  end;
end;

function TSingletonDB.GetDistinctColumnName(pTableName: string): TStringList;
begin
  Result := TStringList.Create;
  with DataBase.NewQuery do
  try
    Close;
    SQL.Text := 'SELECT distinct v.column_name FROM sys_view_columns v ' +
                ' LEFT JOIN sys_grid_col_width a ON a.table_name=v.table_name and a.column_name = v.column_name ' +
                ' WHERE v.table_name=' + QuotedStr(pTableName) + ' and a.column_name is null ';
    Open;
    while NOT EOF do
    begin
      Result.Add( Fields.Fields[0].AsString );
      Next;
    end;
    EmptyDataSet;
    Close;
  finally
    Free;
  end;
end;

procedure TSingletonDB.FillColName(var pComboBox: TComboBox; pTableName: string);
begin
  pComboBox.Clear;

  with DataBase.NewQuery do
  try
    Close;
    SQL.Text := 'SELECT distinct column_name, ordinal_position FROM sys_view_columns ' +
                'WHERE table_name=' + QuotedStr(pTableName) + ' ' +
                'GROUP BY column_name, ordinal_position ' +
                'ORDER BY ordinal_position ASC ';
    Open;
    while NOT EOF do
    begin
      pComboBox.Items.Add( Fields.Fields[0].AsString );
      Next;
    end;
    EmptyDataSet;
    Close;
  finally
    Free;
  end;
end;

procedure TSingletonDB.FillColNameForColWidth(var pComboBox: TComboBox; pTableName: string);
begin
  pComboBox.Clear;

  with DataBase.NewQuery do
  try
    Close;
    SQL.Text := 'SELECT distinct v.column_name, ordinal_position FROM sys_view_columns v ' +
                'LEFT JOIN sys_grid_col_width a ON a.table_name=v.table_name and a.column_name = v.column_name ' +
                'WHERE v.table_name=' + QuotedStr(pTableName) + ' and a.column_name is null ' +
                'GROUP BY v.column_name, ordinal_position ' +
                'ORDER BY ordinal_position ASC ';
    Open;
    while NOT EOF do
    begin
      pComboBox.Items.Add( Fields.Fields[0].AsString );
      Next;
    end;
    EmptyDataSet;
    Close;
  finally
    Free;
  end;
end;

end.
