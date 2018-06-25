unit Ths.Erp.Database.Table.SysGridColColor;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

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

    procedure Clear();override;
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
  Ths.Erp.Constants;

constructor TSysGridColColor.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_grid_col_color';
  SourceCode := '1000';

  Self.FTableName  := TFieldDB.Create('table_name', ftString, '');
  Self.FColumnName := TFieldDB.Create('column_name', ftString, '');
  Self.FMinValue := TFieldDB.Create('min_value', ftFloat, 0);
  Self.FMinColor := TFieldDB.Create('min_color', ftInteger, 0);
  Self.FMaxValue := TFieldDB.Create('max_value', ftFloat, 0);
  Self.FMaxColor := TFieldDB.Create('max_color', ftInteger, 0);
end;

procedure TSysGridColColor.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
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
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
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
		    Self.Id.Value := FieldByName(Self.Id.FieldName).AsInteger;

		    Self.FTableName.Value := FieldByName(FTableName.FieldName).AsString;
        Self.FColumnName.Value := FieldByName(FColumnName.FieldName).AsString;
        Self.FMinValue.Value := FieldByName(FMinValue.FieldName).AsFloat;
        Self.FMinColor.Value := FieldByName(FMinColor.FieldName).AsInteger;
        Self.FMaxValue.Value := FieldByName(FMaxValue.FieldName).AsFloat;
        Self.FMaxColor.Value := FieldByName(FMaxColor.FieldName).AsInteger;

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
  if Self.IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTableName.FieldName,
        FColumnName.FieldName,
        FMinValue.FieldName,
        FMinColor.FieldName,
        FMaxValue.FieldName,
        FMaxColor.FieldName
      ]);

      ParamByName(FTableName.FieldName).Value := Self.FTableName.Value;
      ParamByName(FColumnName.FieldName).Value := Self.FColumnName.Value;
      ParamByName(FMinValue.FieldName).Value := Self.FMinValue.Value;
      ParamByName(FMinColor.FieldName).Value := Self.FMinColor.Value;
      ParamByName(FMaxValue.FieldName).Value := Self.FMaxValue.Value;
      ParamByName(FMaxColor.FieldName).Value := Self.FMaxColor.Value;

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

procedure TSysGridColColor.Update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTableName.FieldName,
        FColumnName.FieldName,
        FMinValue.FieldName,
        FMinColor.FieldName,
        FMaxValue.FieldName,
        FMaxColor.FieldName
      ]);

      ParamByName(FTableName.FieldName).Value := Self.FTableName.Value;
      ParamByName(FColumnName.FieldName).Value := Self.FColumnName.Value;
      ParamByName(FMinValue.FieldName).Value := Self.FMinValue.Value;
      ParamByName(FMinColor.FieldName).Value := Self.FMinColor.Value;
      ParamByName(FMaxValue.FieldName).Value := Self.FMaxValue.Value;
      ParamByName(FMaxColor.FieldName).Value := Self.FMaxColor.Value;
      
		  ParamByName(Self.Id.FieldName).Value := Self.Id.Value;

      Self.Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

procedure TSysGridColColor.Clear();
begin
  inherited;
  Self.FTableName.Value := '';
  Self.FColumnName.Value := '';
  Self.FMinValue.Value := 0;
  Self.FMinColor.Value := 0;
  Self.FMaxValue.Value := 0;
  Self.FMaxColor.Value := 0;
end;

function TSysGridColColor.Clone():TTable;
begin
  Result := TSysGridColColor.Create(Database);

  Self.Id.Clone(TSysGridColColor(Result).Id);

  Self.FTableName.Clone(TSysGridColColor(Result).FTableName);
  Self.FColumnName.Clone(TSysGridColColor(Result).FColumnName);
  Self.FMinValue.Clone(TSysGridColColor(Result).FMinValue);
  Self.FMinColor.Clone(TSysGridColColor(Result).FMinColor);
  Self.FMaxValue.Clone(TSysGridColColor(Result).FMaxValue);
  Self.FMaxColor.Clone(TSysGridColColor(Result).FMaxColor);
end;

end.
