unit Ths.Erp.Database.Table.SysQualityFormNumber;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TSysQualityFormNumber = class(TTable)
  private
    FTableName1: TFieldDB;
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

    Property TableName1: TFieldDB read FTableName1 write FTableName1;
    Property FormNo: TFieldDB read FFormNo write FFormNo;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSysQualityFormNumber.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_quality_form_number';
  SourceCode := '1';

  FTableName1 := TFieldDB.Create('table_name', ftString, '');
  FFormNo := TFieldDB.Create('form_no', ftString, '');
end;

procedure TSysQualityFormNumber.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FTableName1.FieldName,
        TableName + '.' + FFormNo.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FTableName1.FieldName).DisplayLabel := '';
      Self.DataSource.DataSet.FindField(FFormNo.FieldName).DisplayLabel := '';
    end;
  end;
end;

procedure TSysQualityFormNumber.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FTableName1.FieldName,
        TableName + '.' + FFormNo.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FTableName1.Value := FormatedVariantVal(FieldByName(FTableName1.FieldName).DataType, FieldByName(FTableName1.FieldName).Value);
        FFormNo.Value := FormatedVariantVal(FieldByName(FFormNo.FieldName).DataType, FieldByName(FFormNo.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TSysQualityFormNumber.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTableName1.FieldName,
        FFormNo.FieldName
      ]);

      NewParamForQuery(QueryOfTable, FTableName1);
      NewParamForQuery(QueryOfTable, FFormNo);

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

procedure TSysQualityFormNumber.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTableName1.FieldName,
        FFormNo.FieldName
      ]);

      NewParamForQuery(QueryOfTable, FTableName1);
      NewParamForQuery(QueryOfTable, FFormNo);

      NewParamForQuery(QueryOfTable, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TSysQualityFormNumber.Clear();
begin
  inherited;

  FTableName1.Value := '';
  FFormNo.Value := '';
end;

function TSysQualityFormNumber.Clone():TTable;
begin
  Result := TSysQualityFormNumber.Create(Database);

  Self.Id.Clone(TSysQualityFormNumber(Result).Id);

  FTableName1.Clone(TSysQualityFormNumber(Result).FTableName1);
  FFormNo.Clone(TSysQualityFormNumber(Result).FFormNo);
end;

end.
