unit Ths.Erp.Database.Table.SysTableLangContent;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TSysTableLangContent = class(TTable)
  private
    FLang: TFieldDB;
    FTableName1: TFieldDB;
    FColumnName: TFieldDB;
    FRowID: TFieldDB;
    FValue: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property Lang: TFieldDB read FLang write FLang;
    Property TableName1: TFieldDB read FTableName1 write FTableName1;
    Property ColumnName: TFieldDB read FColumnName write FColumnName;
    Property RowID: TFieldDB read FRowID write FRowID;
    Property Value: TFieldDB read FValue write FValue;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSysTableLangContent.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_table_lang_content';
  SourceCode := '1';

  FLang := TFieldDB.Create('lang', ftString, '');
  FTableName1 := TFieldDB.Create('table_name', ftString, '');
  FColumnName := TFieldDB.Create('column_name', ftString, '');
  FRowID := TFieldDB.Create('row_id', ftInteger, 0);
  FValue := TFieldDB.Create('value', ftString, '');
end;

procedure TSysTableLangContent.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FLang.FieldName,
        TableName + '.' + FTableName1.FieldName,
        TableName + '.' + FColumnName.FieldName,
        TableName + '.' + FRowID.FieldName,
        TableName + '.' + FValue.FieldName + '::varchar'
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FLang.FieldName).DisplayLabel := 'LANG';
      Self.DataSource.DataSet.FindField(FTableName1.FieldName).DisplayLabel := 'TABLE NAME';
      Self.DataSource.DataSet.FindField(FColumnName.FieldName).DisplayLabel := 'COLUMN NAME';
      Self.DataSource.DataSet.FindField(FRowID.FieldName).DisplayLabel := 'ROW ID';
      Self.DataSource.DataSet.FindField(FValue.FieldName).DisplayLabel := 'VALUE';
    end;
  end;
end;

procedure TSysTableLangContent.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
      pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

    with QueryOfTable do
    begin
      Close;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FLang.FieldName,
        TableName + '.' + FTableName1.FieldName,
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
        Self.Id.Value := GetVarToFormatedValue(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FLang.Value := GetVarToFormatedValue(FieldByName(FLang.FieldName).DataType, FieldByName(FLang.FieldName).Value);
        FTableName1.Value := GetVarToFormatedValue(FieldByName(FTableName1.FieldName).DataType, FieldByName(FTableName1.FieldName).Value);
        FColumnName.Value := GetVarToFormatedValue(FieldByName(FColumnName.FieldName).DataType, FieldByName(FColumnName.FieldName).Value);
        FRowID.Value := GetVarToFormatedValue(FieldByName(FRowID.FieldName).DataType, FieldByName(FRowID.FieldName).Value);
        FValue.Value := GetVarToFormatedValue(FieldByName(FValue.FieldName).DataType, FieldByName(FValue.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TSysTableLangContent.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FLang.FieldName,
        FTableName1.FieldName,
        FColumnName.FieldName,
        FRowID.FieldName,
        FValue.FieldName
      ]);

      ParamByName(FLang.FieldName).Value := GetVarToFormatedValue(FLang.FieldType, FLang.Value);
      ParamByName(FTableName1.FieldName).Value := GetVarToFormatedValue(FTableName1.FieldType, FTableName1.Value);
      ParamByName(FColumnName.FieldName).Value := GetVarToFormatedValue(FColumnName.FieldType, FColumnName.Value);
      ParamByName(FRowID.FieldName).Value := GetVarToFormatedValue(FRowID.FieldType, FRowID.Value);
      ParamByName(FValue.FieldName).Value := GetVarToFormatedValue(FValue.FieldType, FValue.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

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

procedure TSysTableLangContent.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FLang.FieldName,
        FTableName1.FieldName,
        FColumnName.FieldName,
        FRowID.FieldName,
        FValue.FieldName
      ]);

      ParamByName(FLang.FieldName).Value := GetVarToFormatedValue(FLang.FieldType, FLang.Value);
      ParamByName(FTableName1.FieldName).Value := GetVarToFormatedValue(FTableName1.FieldType, FTableName1.Value);
      ParamByName(FColumnName.FieldName).Value := GetVarToFormatedValue(FColumnName.FieldType, FColumnName.Value);
      ParamByName(FRowID.FieldName).Value := GetVarToFormatedValue(FRowID.FieldType, FRowID.Value);
      ParamByName(FValue.FieldName).Value := GetVarToFormatedValue(FValue.FieldType, FValue.Value);

      ParamByName(Self.Id.FieldName).Value := GetVarToFormatedValue(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TSysTableLangContent.Clear();
begin
  inherited;

  FLang.Value := '';
  FTableName1.Value := '';
  FColumnName.Value := '';
  FRowID.Value := 0;
  FValue.Value := '';
end;

function TSysTableLangContent.Clone():TTable;
begin
  Result := TSysTableLangContent.Create(Database);

  Self.Id.Clone(TSysTableLangContent(Result).Id);

  FLang.Clone(TSysTableLangContent(Result).FLang);
  FTableName1.Clone(TSysTableLangContent(Result).FTableName1);
  FColumnName.Clone(TSysTableLangContent(Result).FColumnName);
  FRowID.Clone(TSysTableLangContent(Result).FRowID);
  FValue.Clone(TSysTableLangContent(Result).FValue);
end;

end.
