unit Ths.Erp.Database.Table.SysGridColColor;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TSysGridColColor = class(TTable)
  private
    FTableName: TFieldDB;
    FColumnName: TFieldDB;
    FMinValue: TFieldDB;
    FMinColor: TFieldDB;
    FMaxValue: TFieldDB;
    FMaxColor: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property TableName1: TFieldDB read FTableName write FTableName;
    Property ColumnName: TFieldDB read FColumnName write FColumnName;
    property MinValue: TFieldDB read FMinValue write FMinValue;
    property MinColor: TFieldDB read FMinColor write FMinColor;
    property MaxValue: TFieldDB read FMaxValue write FMaxValue;
    property MaxColor: TFieldDB read FMaxColor write FMaxColor;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSysGridColColor.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_grid_col_color';
  SourceCode := '1';

  FTableName  := TFieldDB.Create('table_name', ftString, '');
  FColumnName := TFieldDB.Create('column_name', ftString, '');
  FMinValue := TFieldDB.Create('min_value', ftFloat, 0);
  FMinColor := TFieldDB.Create('min_color', ftInteger, 0);
  FMaxValue := TFieldDB.Create('max_value', ftFloat, 0);
  FMaxColor := TFieldDB.Create('max_color', ftInteger, 0);
end;

procedure TSysGridColColor.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfDS do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FTableName.FieldName,
          TableName + '.' + FColumnName.FieldName,
          TableName + '.' + FMinValue.FieldName,
          TableName + '.' + FMinColor.FieldName,
          TableName + '.' + FMaxValue.FieldName,
          TableName + '.' + FMaxColor.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FTableName.FieldName).DisplayLabel := 'TABLE NAME';
      Self.DataSource.DataSet.FindField(FColumnName.FieldName).DisplayLabel := 'COLUMN NAME';
      Self.DataSource.DataSet.FindField(FMinValue.FieldName).DisplayLabel := 'MIN VALUE';
      Self.DataSource.DataSet.FindField(FMinColor.FieldName).DisplayLabel := 'MIN COLOR';
      Self.DataSource.DataSet.FindField(FMaxValue.FieldName).DisplayLabel := 'MAX VALUE';
      Self.DataSource.DataSet.FindField(FMaxColor.FieldName).DisplayLabel := 'MAX COLOR';
	  end;
  end;
end;

procedure TSysGridColColor.SelectToList(pFilter: string; pLock: Boolean;
  pPermissionControl: Boolean=True);
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
          TableName + '.' + FTableName.FieldName,
          TableName + '.' + FColumnName.FieldName,
          TableName + '.' + FMinValue.FieldName,
          TableName + '.' + FMinColor.FieldName,
          TableName + '.' + FMaxValue.FieldName,
          TableName + '.' + FMaxColor.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

		    FTableName.Value := FormatedVariantVal(FieldByName(FTableName.FieldName).DataType, FieldByName(FTableName.FieldName).Value);
        FColumnName.Value := FormatedVariantVal(FieldByName(FColumnName.FieldName).DataType, FieldByName(FColumnName.FieldName).Value);
        FMinValue.Value := FormatedVariantVal(FieldByName(FMinValue.FieldName).DataType, FieldByName(FMinValue.FieldName).Value);
        FMinColor.Value := FormatedVariantVal(FieldByName(FMinColor.FieldName).DataType, FieldByName(FMinColor.FieldName).Value);
        FMaxValue.Value := FormatedVariantVal(FieldByName(FMaxValue.FieldName).DataType, FieldByName(FMaxValue.FieldName).Value);
        FMaxColor.Value := FormatedVariantVal(FieldByName(FMaxColor.FieldName).DataType, FieldByName(FMaxColor.FieldName).Value);

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TSysGridColColor.Insert(out pID: Integer;
  pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfInsert do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTableName.FieldName,
        FColumnName.FieldName,
        FMinValue.FieldName,
        FMinColor.FieldName,
        FMaxValue.FieldName,
        FMaxColor.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FTableName);
      NewParamForQuery(QueryOfInsert, FColumnName);
      NewParamForQuery(QueryOfInsert, FMinValue);
      NewParamForQuery(QueryOfInsert, FMinColor);
      NewParamForQuery(QueryOfInsert, FMaxValue);
      NewParamForQuery(QueryOfInsert, FMaxColor);

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

procedure TSysGridColColor.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfUpdate do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTableName.FieldName,
        FColumnName.FieldName,
        FMinValue.FieldName,
        FMinColor.FieldName,
        FMaxValue.FieldName,
        FMaxColor.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FTableName);
      NewParamForQuery(QueryOfUpdate, FColumnName);
      NewParamForQuery(QueryOfUpdate, FMinValue);
      NewParamForQuery(QueryOfUpdate, FMinColor);
      NewParamForQuery(QueryOfUpdate, FMaxValue);
      NewParamForQuery(QueryOfUpdate, FMaxColor);

      NewParamForQuery(QueryOfUpdate, Id);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

function TSysGridColColor.Clone():TTable;
begin
  Result := TSysGridColColor.Create(Database);

  Self.Id.Clone(TSysGridColColor(Result).Id);

  FTableName.Clone(TSysGridColColor(Result).FTableName);
  FColumnName.Clone(TSysGridColColor(Result).FColumnName);
  FMinValue.Clone(TSysGridColColor(Result).FMinValue);
  FMinColor.Clone(TSysGridColColor(Result).FMinColor);
  FMaxValue.Clone(TSysGridColColor(Result).FMaxValue);
  FMaxColor.Clone(TSysGridColColor(Result).FMaxColor);
end;

end.
