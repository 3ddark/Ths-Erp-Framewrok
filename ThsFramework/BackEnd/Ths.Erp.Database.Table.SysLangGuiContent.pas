unit Ths.Erp.Database.Table.SysLangGuiContent;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.SysLang;

type
  TSysLangGuiContent = class(TTable)
  private
    FLang: TFieldDB;
    FCode: TFieldDB;
    FContentType: TFieldDB;
    FTableName: TFieldDB;
    FVal: TFieldDB;
    FIsFactorySetting: TFieldDB;
    FFormName: TFieldDB;
  protected
    procedure BusinessInsert(out pID: Integer; var pPermissionControl: Boolean); override;
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    property Lang: TFieldDB read FLang write FLang;
    property Code: TFieldDB read FCode write FCode;
    property ContentType: TFieldDB read FContentType write FContentType;
    property TableName1: TFieldDB read FTableName write FTableName;
    property Val: TFieldDB read FVal write FVal;
    property IsFactorySetting: TFieldDB read FIsFactorySetting write FIsFactorySetting;
    property FormName: TFieldDB read FFormName write FFormName;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSysLangGuiContent.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_lang_gui_content';
  SourceCode := '1';

  FLang := TFieldDB.Create('lang', ftString, '', 0, True, False);
  FLang.FK.FKTable := TSysLang.Create(Database);
  FLang.FK.FKCol := TFieldDB.Create(TSysLang(FLang.FK.FKTable).Language.FieldName, TSysLang(FLang.FK.FKTable).Language.FieldType, '');
  FCode := TFieldDB.Create('code', ftString, '');
  FContentType := TFieldDB.Create('content_type', ftString, '');
  FTableName := TFieldDB.Create('table_name', ftString, '');
  FVal := TFieldDB.Create('val', ftString, '');
  FIsFactorySetting := TFieldDB.Create('is_factory_setting', ftBoolean, False);
  FFormName := TFieldDB.Create('form_name', ftString, '');
end;

procedure TSysLangGuiContent.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
    Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FLang.FieldName,
        TableName + '.' + FCode.FieldName,
        TableName + '.' + FContentType.FieldName,
        TableName + '.' + FTableName.FieldName,
        TableName + '.' + FVal.FieldName + '::varchar ',
        TableName + '.' + FIsFactorySetting.FieldName,
        TableName + '.' + FFormName.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'Id';
      Self.DataSource.DataSet.FindField(FLang.FieldName).DisplayLabel := 'Lang';
      Self.DataSource.DataSet.FindField(FCode.FieldName).DisplayLabel := 'Code';
      Self.DataSource.DataSet.FindField(FContentType.FieldName).DisplayLabel := 'Content Type';
      Self.DataSource.DataSet.FindField(FTableName.FieldName).DisplayLabel := 'Table Name';
      Self.DataSource.DataSet.FindField(FVal.FieldName).DisplayLabel := 'Val';
      Self.DataSource.DataSet.FindField(FIsFactorySetting.FieldName).DisplayLabel := 'Factory Setting?';
      Self.DataSource.DataSet.FindField(FFormName.FieldName).DisplayLabel := 'Form Adý';
    end;
  end;
end;

procedure TSysLangGuiContent.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE OF ' + TableName + ' NOWAIT';

    with QueryOfList do
    begin
      Close;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FLang.FieldName,
        TableName + '.' + FCode.FieldName,
        TableName + '.' + FContentType.FieldName,
        TableName + '.' + FTableName.FieldName,
        TableName + '.' + FVal.FieldName,
        TableName + '.' + FIsFactorySetting.FieldName,
        TableName + '.' + FFormName.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FLang.Value := FormatedVariantVal(FieldByName(FLang.FieldName).DataType, FieldByName(FLang.FieldName).Value);
        FCode.Value := FormatedVariantVal(FieldByName(FCode.FieldName).DataType, FieldByName(FCode.FieldName).Value);
        FContentType.Value := FormatedVariantVal(FieldByName(FContentType.FieldName).DataType, FieldByName(FContentType.FieldName).Value);
        FTableName.Value := FormatedVariantVal(FieldByName(FTableName.FieldName).DataType, FieldByName(FTableName.FieldName).Value);
        FVal.Value := FormatedVariantVal(FieldByName(FVal.FieldName).DataType, FieldByName(FVal.FieldName).Value);
        FIsFactorySetting.Value := FormatedVariantVal(FieldByName(FIsFactorySetting.FieldName).DataType, FieldByName(FIsFactorySetting.FieldName).Value);
        FFormName.Value := FormatedVariantVal(FieldByName(FFormName.FieldName).DataType, FieldByName(FFormName.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TSysLangGuiContent.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    {$IFDEF CRUD_MODE_SP}
      SpInsert.ExecProc;
      pID := SpInsert.ParamByName('result').AsInteger;
      Self.Notify;
    {$ELSE IFDEF CRUD_MODE_PURE_SQL}
      with QueryOfInsert do
      begin
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
          FLang.FieldName,
          FCode.FieldName,
          FContentType.FieldName,
          FTableName.FieldName,
          FVal.FieldName,
          FIsFactorySetting.FieldName,
          FFormName.FieldName
        ]);

        NewParamForQuery(QueryOfInsert, FLang);
        NewParamForQuery(QueryOfInsert, FCode);
        NewParamForQuery(QueryOfInsert, FContentType);
        NewParamForQuery(QueryOfInsert, FTableName);
        NewParamForQuery(QueryOfInsert, FVal);
        NewParamForQuery(QueryOfInsert, FIsFactorySetting);
        NewParamForQuery(QueryOfInsert, FFormName);

        Open;
        if (Fields.Count > 0) and (not Fields.FieldByName(Self.Id.FieldName).IsNull) then
          pID := Fields.FieldByName(Self.Id.FieldName).AsInteger
        else
          pID := 0;

        EmptyDataSet;
        Close;
      end;
      Self.Notify;
    {$ENDIF}
  end;
end;

procedure TSysLangGuiContent.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    {$IFDEF CRUD_MODE_SP}
      SpUpdate.ExecProc;
      Self.Notify;
    {$ELSE IFDEF CRUD_MODE_PURE_SQL}
      with QueryOfUpdate do
      begin
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
          FLang.FieldName,
          FCode.FieldName,
          FContentType.FieldName,
          FTableName.FieldName,
          FVal.FieldName,
          FIsFactorySetting.FieldName,
          FFormName.FieldName
        ]);

        NewParamForQuery(QueryOfUpdate, FLang);
        NewParamForQuery(QueryOfUpdate, FCode);
        NewParamForQuery(QueryOfUpdate, FContentType);
        NewParamForQuery(QueryOfUpdate, FTableName);
        NewParamForQuery(QueryOfUpdate, FVal);
        NewParamForQuery(QueryOfUpdate, FIsFactorySetting);
        NewParamForQuery(QueryOfUpdate, FFormName);

        NewParamForQuery(QueryOfUpdate, Id);

        ExecSQL;
        Close;
      end;
      Self.Notify;
    {$ENDIF}
  end;
end;

procedure TSysLangGuiContent.BusinessInsert(out pID: Integer;
  var pPermissionControl: Boolean);
var
  vSysLangGuiContent: TSysLangGuiContent;
  vDmpFilter: string;
begin
  vSysLangGuiContent := TSysLangGuiContent.Create(Self.Database);
  try
    if FormatedVariantVal(FTableName.FieldType, FTableName.Value) <> '' then
      vDmpFilter := ' AND table_name=' + QuotedStr(FormatedVariantVal(FTableName.FieldType, FTableName.Value));

    vSysLangGuiContent.SelectToList(' AND lang=' + QuotedStr(FormatedVariantVal(FLang.FieldType, FLang.Value)) +
                                    ' AND code=' + QuotedStr(FormatedVariantVal(FCode.FieldType, FCode.Value)) +
                                    ' AND content_type=' + QuotedStr(FormatedVariantVal(FContentType.FieldType, FContentType.Value)) +
                                 vDmpFilter, False, False);
    if vSysLangGuiContent.List.Count = 1 then
    begin
      Self.Id.Value := vSysLangGuiContent.Id.Value;
      Self.Update()
    end
    else
      Self.Insert(pID);
  finally
    vSysLangGuiContent.Free;
  end;
end;

function TSysLangGuiContent.Clone():TTable;
begin
  Result := TSysLangGuiContent.Create(Database);

  Self.Id.Clone(TSysLangGuiContent(Result).Id);

  FLang.Clone(TSysLangGuiContent(Result).FLang);
  FCode.Clone(TSysLangGuiContent(Result).FCode);
  FContentType.Clone(TSysLangGuiContent(Result).FContentType);
  FTableName.Clone(TSysLangGuiContent(Result).FTableName);
  FVal.Clone(TSysLangGuiContent(Result).FVal);
  FIsFactorySetting.Clone(TSysLangGuiContent(Result).FIsFactorySetting);
  FFormName.Clone(TSysLangGuiContent(Result).FFormName);
end;

end.
