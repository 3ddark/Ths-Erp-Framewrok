unit Ths.Erp.Database.Table.SysGridColPercent;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TSysGridColPercent = class(TTable)
  private
    FTableName: TFieldDB;
    FColumnName: TFieldDB;
    FMaxValue: TFieldDB;
    FColorBar: TFieldDB;
    FColorBarBack: TFieldDB;
    FColorBarText: TFieldDB;
    FColorBarTextActive: TFieldDB;
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
    property MaxValue: TFieldDB read FMaxValue write FMaxValue;
    property ColorBar: TFieldDB read FColorBar write FColorBar;
    property ColorBarBack: TFieldDB read FColorBarBack write FColorBarBack;
    property ColorBarText: TFieldDB read FColorBarText write FColorBarText;
    property ColorBarTextActive: TFieldDB read FColorBarTextActive write FColorBarTextActive;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSysGridColPercent.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_grid_col_percent';
  SourceCode := '1';

  FTableName  := TFieldDB.Create('table_name', ftString, '');
  FColumnName := TFieldDB.Create('column_name', ftString, '');
  FMaxValue := TFieldDB.Create('max_value', ftFloat, 0);
  FColorBar := TFieldDB.Create('color_bar', ftInteger, 0);
  FColorBarBack := TFieldDB.Create('color_bar_back', ftInteger, 0);
  FColorBarText := TFieldDB.Create('color_bar_text', ftInteger, 0);
  FColorBarTextActive := TFieldDB.Create('color_bar_text_active', ftInteger, 0);
end;

procedure TSysGridColPercent.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
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
          TableName + '.' + FColumnName.FieldName,
          TableName + '.' + FMaxValue.FieldName,
          TableName + '.' + FColorBar.FieldName,
          TableName + '.' + FColorBarBack.FieldName,
          TableName + '.' + FColorBarText.FieldName,
          TableName + '.' + FColorBarTextActive.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FTableName.FieldName).DisplayLabel := 'TABLE NAME';
      Self.DataSource.DataSet.FindField(FColumnName.FieldName).DisplayLabel := 'COLUMN NAME';
      Self.DataSource.DataSet.FindField(FMaxValue.FieldName).DisplayLabel := 'MAX VALUE';
      Self.DataSource.DataSet.FindField(FColorBar.FieldName).DisplayLabel := 'COLOR BAR';
      Self.DataSource.DataSet.FindField(FColorBarBack.FieldName).DisplayLabel := 'COLOR BAR BACK';
      Self.DataSource.DataSet.FindField(FColorBarText.FieldName).DisplayLabel := 'COLOR BAR TEXT';
      Self.DataSource.DataSet.FindField(FColorBarTextActive.FieldName).DisplayLabel := 'COLOR BAR TEXT ACTIVE';
	  end;
  end;
end;

procedure TSysGridColPercent.SelectToList(pFilter: string; pLock: Boolean;
  pPermissionControl: Boolean=True);
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
          TableName + '.' + FColumnName.FieldName,
          TableName + '.' + FMaxValue.FieldName,
          TableName + '.' + FColorBar.FieldName,
          TableName + '.' + FColorBarBack.FieldName,
          TableName + '.' + FColorBarText.FieldName,
          TableName + '.' + FColorBarTextActive.FieldName,
          ' 40::varchar as test '
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id.Value := GetVarToFormatedValue(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

		    FTableName.Value := GetVarToFormatedValue(FieldByName(FTableName.FieldName).DataType, FieldByName(FTableName.FieldName).Value);
        FColumnName.Value := GetVarToFormatedValue(FieldByName(FColumnName.FieldName).DataType, FieldByName(FColumnName.FieldName).Value);
        FMaxValue.Value := GetVarToFormatedValue(FieldByName(FMaxValue.FieldName).DataType, FieldByName(FMaxValue.FieldName).Value);
        FColorBar.Value := GetVarToFormatedValue(FieldByName(FColorBar.FieldName).DataType, FieldByName(FColorBar.FieldName).Value);
        FColorBarBack.Value := GetVarToFormatedValue(FieldByName(FColorBarBack.FieldName).DataType, FieldByName(FColorBarBack.FieldName).Value);
        FColorBarText.Value := GetVarToFormatedValue(FieldByName(FColorBarText.FieldName).DataType, FieldByName(FColorBarText.FieldName).Value);
        FColorBarTextActive.Value := GetVarToFormatedValue(FieldByName(FColorBarTextActive.FieldName).DataType, FieldByName(FColorBarTextActive.FieldName).Value);

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TSysGridColPercent.Insert(out pID: Integer;
  pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTableName.FieldName,
        FColumnName.FieldName,
        FMaxValue.FieldName,
        FColorBar.FieldName,
        FColorBarBack.FieldName,
        FColorBarText.FieldName,
        FColorBarTextActive.FieldName
      ]);

      ParamByName(FTableName.FieldName).Value := GetVarToFormatedValue(FTableName.FieldType, FTableName.Value);
      ParamByName(FColumnName.FieldName).Value := GetVarToFormatedValue(FColumnName.FieldType, FColumnName.Value);
      ParamByName(FMaxValue.FieldName).Value := GetVarToFormatedValue(FMaxValue.FieldType, FMaxValue.Value);
      ParamByName(FColorBar.FieldName).Value := GetVarToFormatedValue(FColorBar.FieldType, FColorBar.Value);
      ParamByName(FColorBarBack.FieldName).Value := GetVarToFormatedValue(FColorBarBack.FieldType, FColorBarBack.Value);
      ParamByName(FColorBarText.FieldName).Value := GetVarToFormatedValue(FColorBarText.FieldType, FColorBarText.Value);
      ParamByName(FColorBarTextActive.FieldName).Value := GetVarToFormatedValue(FColorBarTextActive.FieldType, FColorBarTextActive.Value);

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

procedure TSysGridColPercent.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTableName.FieldName,
        FColumnName.FieldName,
        FMaxValue.FieldName,
        FColorBar.FieldName,
        FColorBarBack.FieldName,
        FColorBarText.FieldName,
        FColorBarTextActive.FieldName
      ]);

      ParamByName(FTableName.FieldName).Value := GetVarToFormatedValue(FTableName.FieldType, FTableName.Value);
      ParamByName(FColumnName.FieldName).Value := GetVarToFormatedValue(FColumnName.FieldType, FColumnName.Value);
      ParamByName(FMaxValue.FieldName).Value := GetVarToFormatedValue(FMaxValue.FieldType, FMaxValue.Value);
      ParamByName(FColorBar.FieldName).Value := GetVarToFormatedValue(FColorBar.FieldType, FColorBar.Value);
      ParamByName(FColorBarBack.FieldName).Value := GetVarToFormatedValue(FColorBarBack.FieldType, FColorBarBack.Value);
      ParamByName(FColorBarText.FieldName).Value := GetVarToFormatedValue(FColorBarText.FieldType, FColorBarText.Value);
      ParamByName(FColorBarTextActive.FieldName).Value := GetVarToFormatedValue(FColorBarTextActive.FieldType, FColorBarTextActive.Value);

		  ParamByName(Self.Id.FieldName).Value := GetVarToFormatedValue(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

procedure TSysGridColPercent.Clear();
begin
  inherited;
  FTableName.Value := '';
  FColumnName.Value := '';
  FMaxValue.Value := 0;
  FColorBar.Value := 0;
  FColorBarBack.Value := 0;
  FColorBarText.Value := 0;
  FColorBarTextActive.Value := 0;
end;

function TSysGridColPercent.Clone():TTable;
begin
  Result := TSysGridColPercent.Create(Database);

  Self.Id.Clone(TSysGridColPercent(Result).Id);

  FTableName.Clone(TSysGridColPercent(Result).FTableName);
  FColumnName.Clone(TSysGridColPercent(Result).FColumnName);
  FMaxValue.Clone(TSysGridColPercent(Result).FMaxValue);
  FColorBar.Clone(TSysGridColPercent(Result).FColorBar);
  FColorBarBack.Clone(TSysGridColPercent(Result).FColorBarBack);
  FColorBarText.Clone(TSysGridColPercent(Result).FColorBarText);
  FColorBarTextActive.Clone(TSysGridColPercent(Result).FColorBarTextActive);
end;

end.
