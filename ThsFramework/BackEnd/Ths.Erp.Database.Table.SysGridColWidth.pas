unit Ths.Erp.Database.Table.SysGridColWidth;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TSysGridColWidth = class(TTable)
  private
    FTableName: TFieldDB;
    FColumnName: TFieldDB;
    FColumnWidth: TFieldDB;
    FSequenceNo: TFieldDB;
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
    property ColumnWidth: TFieldDB read FColumnWidth write FColumnWidth;
    property SequenceNo: TFieldDB read FSequenceNo write FSequenceNo;
  end;

implementation

uses
  Ths.Erp.Constants;

constructor TSysGridColWidth.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_grid_col_width';
  SourceCode := '1000';

  Self.TableName1  := TFieldDB.Create('table_name', ftString, '');
  Self.ColumnName := TFieldDB.Create('column_name', ftString, '');
  Self.ColumnWidth  := TFieldDB.Create('column_width', ftInteger, 0);
  Self.SequenceNo := TFieldDB.Create('sequence_no', ftInteger, 0);
end;

procedure TSysGridColWidth.SelectToDatasource(pFilter: string;
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
          TableName + '.' + FColumnWidth.FieldName,
          TableName + '.' + FSequenceNo.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FTableName.FieldName).DisplayLabel := 'TABLE NAME';
      Self.DataSource.DataSet.FindField(FColumnName.FieldName).DisplayLabel := 'COLUMN NAME';
      Self.DataSource.DataSet.FindField(FColumnWidth.FieldName).DisplayLabel := 'COLUMN WIDTH';
      Self.DataSource.DataSet.FindField(FSequenceNo.FieldName).DisplayLabel := 'SEQUENCE NO';
	  end;
  end;
end;

procedure TSysGridColWidth.SelectToList(pFilter: string; pLock: Boolean;
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
          TableName + '.' + FColumnWidth.FieldName,
          TableName + '.' + FSequenceNo.FieldName
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
        Self.FColumnWidth.Value := FieldByName(FColumnWidth.FieldName).AsInteger;
        Self.FSequenceNo.Value := FieldByName(FSequenceNo.FieldName).AsInteger;

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TSysGridColWidth.Insert(out pID: Integer;
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
        FColumnWidth.FieldName,
        FSequenceNo.FieldName
      ]);

      ParamByName(FTableName.FieldName).Value := Self.FTableName.Value;
      ParamByName(FColumnName.FieldName).Value := Self.FColumnName.Value;
      ParamByName(FColumnWidth.FieldName).Value := Self.FColumnWidth.Value;
      ParamByName(FSequenceNo.FieldName).Value := Self.FSequenceNo.Value;

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

procedure TSysGridColWidth.Update(pPermissionControl: Boolean=True);
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
        FColumnWidth.FieldName,
        FSequenceNo.FieldName
      ]);

      ParamByName(FTableName.FieldName).Value := Self.FTableName.Value;
      ParamByName(FColumnName.FieldName).Value := Self.FColumnName.Value;
      ParamByName(FColumnWidth.FieldName).Value := Self.FColumnWidth.Value;
      ParamByName(FSequenceNo.FieldName).Value := Self.FSequenceNo.Value;

		  ParamByName(Self.Id.FieldName).Value := Self.Id.Value;

      Self.Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

procedure TSysGridColWidth.Clear();
begin
  inherited;
  Self.FTableName.Value := '';
  Self.FColumnName.Value := '';
  Self.FColumnWidth.Value := 0;
  Self.FSequenceNo.Value := 0;
end;

function TSysGridColWidth.Clone():TTable;
begin
  Result := TSysGridColWidth.Create(Database);

  Self.Id.Clone(TSysGridColWidth(Result).Id);

  Self.FTableName.Clone(TSysGridColWidth(Result).FTableName);
  Self.FColumnName.Clone(TSysGridColWidth(Result).FColumnName);
  Self.FColumnWidth.Clone(TSysGridColWidth(Result).FColumnWidth);
  Self.FSequenceNo.Clone(TSysGridColWidth(Result).FSequenceNo);
end;

end.
