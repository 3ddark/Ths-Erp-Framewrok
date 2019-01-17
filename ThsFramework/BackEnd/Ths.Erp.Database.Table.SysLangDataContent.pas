unit Ths.Erp.Database.Table.SysLangDataContent;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TSysLangDataContent = class(TTable)
  private
    FLang: TFieldDB;
    FTableName: TFieldDB;
    FColumnName: TFieldDB;
    FRowID: TFieldDB;
    FValue: TFieldDB;
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

    Property Lang: TFieldDB read FLang write FLang;
    Property TableName1: TFieldDB read FTableName write FTableName;
    Property ColumnName: TFieldDB read FColumnName write FColumnName;
    Property RowID: TFieldDB read FRowID write FRowID;
    Property Value: TFieldDB read FValue write FValue;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSysLangDataContent.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_lang_data_content';
  SourceCode := '1';

  FLang := TFieldDB.Create('lang', ftString, '', 0, False, False);
  FTableName := TFieldDB.Create('table_name', ftString, '', 0, False, False);
  FColumnName := TFieldDB.Create('column_name', ftString, '', 0, False, False);
  FRowID := TFieldDB.Create('row_id', ftInteger, 0, 0, False, False);
  FValue := TFieldDB.Create('value', ftString, '', 0, False, False);
end;

procedure TSysLangDataContent.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
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
        TableName + '.' + FTableName.FieldName,
        TableName + '.' + FColumnName.FieldName,
        TableName + '.' + FRowID.FieldName,
        TableName + '.' + FValue.FieldName + '::varchar'
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FLang.FieldName).DisplayLabel := 'LANG';
      Self.DataSource.DataSet.FindField(FTableName.FieldName).DisplayLabel := 'TABLE NAME';
      Self.DataSource.DataSet.FindField(FColumnName.FieldName).DisplayLabel := 'COLUMN NAME';
      Self.DataSource.DataSet.FindField(FRowID.FieldName).DisplayLabel := 'ROW ID';
      Self.DataSource.DataSet.FindField(FValue.FieldName).DisplayLabel := 'VALUE';
    end;
  end;
end;

procedure TSysLangDataContent.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
      pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

    with QueryOfList do
    begin
      Close;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FLang.FieldName,
        TableName + '.' + FTableName.FieldName,
        TableName + '.' + FColumnName.FieldName,
        TableName + '.' + FRowID.FieldName,
        TableName + '.' + FValue.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FLang.Value := FormatedVariantVal(FieldByName(FLang.FieldName).DataType, FieldByName(FLang.FieldName).Value);
        FTableName.Value := FormatedVariantVal(FieldByName(FTableName.FieldName).DataType, FieldByName(FTableName.FieldName).Value);
        FColumnName.Value := FormatedVariantVal(FieldByName(FColumnName.FieldName).DataType, FieldByName(FColumnName.FieldName).Value);
        FRowID.Value := FormatedVariantVal(FieldByName(FRowID.FieldName).DataType, FieldByName(FRowID.FieldName).Value);
        FValue.Value := FormatedVariantVal(FieldByName(FValue.FieldName).DataType, FieldByName(FValue.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TSysLangDataContent.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FLang.FieldName,
        FTableName.FieldName,
        FColumnName.FieldName,
        FRowID.FieldName,
        FValue.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FLang);
      NewParamForQuery(QueryOfInsert, FTableName);
      NewParamForQuery(QueryOfInsert, FColumnName);
      NewParamForQuery(QueryOfInsert, FRowID);
      NewParamForQuery(QueryOfInsert, FValue);

      Open;
      if (Fields.Count > 0) and (not Fields.FieldByName(Self.Id.FieldName).IsNull) then
        pID := Fields.FieldByName(Self.Id.FieldName).AsInteger
      else
        pID := 0;

      EmptyDataSet;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TSysLangDataContent.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FLang.FieldName,
        FTableName.FieldName,
        FColumnName.FieldName,
        FRowID.FieldName,
        FValue.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FLang);
      NewParamForQuery(QueryOfUpdate, FTableName);
      NewParamForQuery(QueryOfUpdate, FColumnName);
      NewParamForQuery(QueryOfUpdate, FRowID);
      NewParamForQuery(QueryOfUpdate, FValue);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TSysLangDataContent.BusinessInsert(out pID: Integer;
  var pPermissionControl: Boolean);
var
  vSysTableLangContent: TSysLangDataContent;
begin
  vSysTableLangContent := TSysLangDataContent.Create(Self.Database);
  try
    vSysTableLangContent.SelectToList(
          ' AND ' + vSysTableLangContent.FLang.FieldName        + '=' + QuotedStr(FormatedVariantVal(FLang.FieldType, FLang.Value)) +
          ' AND ' + vSysTableLangContent.FTableName.FieldName   + '=' + QuotedStr(FormatedVariantVal(FTableName.FieldType, FTableName.Value)) +
          ' AND ' + vSysTableLangContent.FColumnName.FieldName  + '=' + QuotedStr(FormatedVariantVal(FColumnName.FieldType, FColumnName.Value)) +
          ' AND ' + vSysTableLangContent.FRowID.FieldName       + '=' + QuotedStr(FormatedVariantVal(FRowID.FieldType, FRowID.Value)),
          False, False);
    if vSysTableLangContent.List.Count = 1 then
    begin
      Self.Id.Value := vSysTableLangContent.Id.Value;
      Self.Update()
    end
    else
      Self.Insert(pID);
  finally
    vSysTableLangContent.Free;
  end;
end;

function TSysLangDataContent.Clone():TTable;
begin
  Result := TSysLangDataContent.Create(Database);

  Self.Id.Clone(TSysLangDataContent(Result).Id);

  FLang.Clone(TSysLangDataContent(Result).FLang);
  FTableName.Clone(TSysLangDataContent(Result).FTableName);
  FColumnName.Clone(TSysLangDataContent(Result).FColumnName);
  FRowID.Clone(TSysLangDataContent(Result).FRowID);
  FValue.Clone(TSysLangDataContent(Result).FValue);
end;

end.
