unit Ths.Erp.Database.Table.SysQualityFomNumber;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TSysQualityFomNumber = class(TTable)
  private
    FTableName: TFieldDB;
    FFormNo: TFieldDB;
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

    property TableName1: TFieldDB read FTableName write FTableName;
    property FormNo: TFieldDB read FFormNo write FFormNo;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Constants;

constructor TSysQualityFomNumber.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_quality_form_number';
  SourceCode := '1000';

  FTableName := TFieldDB.Create('table_name', ftString, '');
  FFormNo := TFieldDB.Create('form_no', ftString, '');
end;

procedure TSysQualityFomNumber.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
    Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FTableName.FieldName,
        TableName + '.' + FFormNo.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FTableName.FieldName).DisplayLabel := 'TABLE NAME';
      Self.DataSource.DataSet.FindField(FFormNo.FieldName).DisplayLabel := 'FORM NO';
    end;
  end;
end;

procedure TSysQualityFomNumber.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FTableName.FieldName,
        TableName + '.' + FFormNo.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := GetVarToFormatedValue(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FTableName.Value := GetVarToFormatedValue(FieldByName(FTableName.FieldName).DataType, FieldByName(FTableName.FieldName).Value);
        FFormNo.Value := GetVarToFormatedValue(FieldByName(FFormNo.FieldName).DataType, FieldByName(FFormNo.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TSysQualityFomNumber.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTableName.FieldName,
        FFormNo.FieldName
      ]);

      ParamByName(FTableName.FieldName).Value := GetVarToFormatedValue(FTableName.FieldType, FTableName.Value);
      ParamByName(FFormNo.FieldName).Value := GetVarToFormatedValue(FFormNo.FieldType, FFormNo.Value);

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

procedure TSysQualityFomNumber.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTableName.FieldName,
        FFormNo.FieldName
      ]);

      ParamByName(FTableName.FieldName).Value := GetVarToFormatedValue(FTableName.FieldType, FTableName.Value);
      ParamByName(FFormNo.FieldName).Value := GetVarToFormatedValue(FFormNo.FieldType, FFormNo.Value);

      ParamByName(Self.Id.FieldName).Value := Self.Id.Value;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TSysQualityFomNumber.Clear();
begin
  inherited;

  FTableName.Value := '';
  FFormNo.Value := '';
end;

function TSysQualityFomNumber.Clone():TTable;
begin
  Result := TSysQualityFomNumber.Create(Database);

  Self.Id.Clone(TSysQualityFomNumber(Result).Id);

  FTableName.Clone(TSysQualityFomNumber(Result).FTableName);
  FFormNo.Clone(TSysQualityFomNumber(Result).FFormNo);
end;

end.
