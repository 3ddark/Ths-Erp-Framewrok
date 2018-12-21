unit Ths.Erp.Database.Table.SysGridDefaultOrderFilter;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TSysGridDefaultOrderFilter = class(TTable)
  private
    FKey: TFieldDB;
    FValue: TFieldDB;
    FIsOrder: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property Key: TFieldDB read FKey write FKey;
    Property Value: TFieldDB read FValue write FValue;
    Property IsOrder: TFieldDB read FIsOrder write FIsOrder;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSysGridDefaultOrderFilter.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_grid_default_order_filter';
  SourceCode := '1';

  FKey := TFieldDB.Create('key', ftString, '');
  FValue := TFieldDB.Create('value', ftString, '');
  FIsOrder := TFieldDB.Create('is_order', ftBoolean, 0);
end;

procedure TSysGridDefaultOrderFilter.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FKey.FieldName,
        TableName + '.' + FValue.FieldName,
        TableName + '.' + FIsOrder.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FKey.FieldName).DisplayLabel := 'KEY';
      Self.DataSource.DataSet.FindField(FValue.FieldName).DisplayLabel := 'VALUE';
      Self.DataSource.DataSet.FindField(FIsOrder.FieldName).DisplayLabel := 'ORDER?';
    end;
  end;
end;

procedure TSysGridDefaultOrderFilter.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FKey.FieldName,
        TableName + '.' + FValue.FieldName,
        TableName + '.' + FIsOrder.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FKey.Value := FormatedVariantVal(FieldByName(FKey.FieldName).DataType, FieldByName(FKey.FieldName).Value);
        FValue.Value := FormatedVariantVal(FieldByName(FValue.FieldName).DataType, FieldByName(FValue.FieldName).Value);
        FIsOrder.Value := FormatedVariantVal(FieldByName(FIsOrder.FieldName).DataType, FieldByName(FIsOrder.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TSysGridDefaultOrderFilter.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FKey.FieldName,
        FValue.FieldName,
        FIsOrder.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FKey);
      NewParamForQuery(QueryOfInsert, FValue);
      NewParamForQuery(QueryOfInsert, FIsOrder);

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

procedure TSysGridDefaultOrderFilter.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FKey.FieldName,
        FValue.FieldName,
        FIsOrder.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FKey);
      NewParamForQuery(QueryOfUpdate, FValue);
      NewParamForQuery(QueryOfUpdate, FIsOrder);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TSysGridDefaultOrderFilter.Clone():TTable;
begin
  Result := TSysGridDefaultOrderFilter.Create(Database);

  Self.Id.Clone(TSysGridDefaultOrderFilter(Result).Id);

  FKey.Clone(TSysGridDefaultOrderFilter(Result).FKey);
  FValue.Clone(TSysGridDefaultOrderFilter(Result).FValue);
  FIsOrder.Clone(TSysGridDefaultOrderFilter(Result).FIsOrder);
end;

end.
