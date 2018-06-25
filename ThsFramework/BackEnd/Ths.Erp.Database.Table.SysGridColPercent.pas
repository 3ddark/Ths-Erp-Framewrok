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
  Ths.Erp.Constants;

constructor TSysGridColPercent.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_grid_col_percent';
  SourceCode := '1000';

  Self.TableName1  := TFieldDB.Create('table_name', ftString, '');
  Self.ColumnName := TFieldDB.Create('column_name', ftString, '');
  Self.MaxValue := TFieldDB.Create('max_value', ftFloat, 0);
  Self.ColorBar := TFieldDB.Create('color_bar', ftInteger, 0);
  Self.ColorBarBack := TFieldDB.Create('color_bar_back', ftInteger, 0);
  Self.ColorBarText := TFieldDB.Create('color_bar_text', ftInteger, 0);
  Self.ColorBarTextActive := TFieldDB.Create('color_bar_text_active', ftInteger, 0);
end;

procedure TSysGridColPercent.SelectToDatasource(pFilter: string;
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
          TableName + '.' + FMaxValue.FieldName,
          TableName + '.' + FColorBar.FieldName,
          TableName + '.' + FColorBarBack.FieldName,
          TableName + '.' + FColorBarText.FieldName,
          TableName + '.' + FColorBarTextActive.FieldName
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
        Self.FMaxValue.Value := FieldByName(FMaxValue.FieldName).AsFloat;
        Self.FColorBar.Value := FieldByName(FColorBar.FieldName).AsInteger;
        Self.FColorBarBack.Value := FieldByName(FColorBarBack.FieldName).AsInteger;
        Self.FColorBarText.Value := FieldByName(FColorBarText.FieldName).AsInteger;
        Self.FColorBarTextActive.Value := FieldByName(FColorBarTextActive.FieldName).AsInteger;

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
  if Self.IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTableName.FieldName,
        FColumnName.FieldName,
        FMaxValue.FieldName,
        FColorBar.FieldName,
        FColorBarBack.FieldName,
        FColorBarText.FieldName,
        FColorBarTextActive.FieldName
      ]);

      ParamByName(FTableName.FieldName).Value := Self.FTableName.Value;
      ParamByName(FColumnName.FieldName).Value := Self.FColumnName.Value;
      ParamByName(FMaxValue.FieldName).Value := Self.FMaxValue.Value;
      ParamByName(FColorBar.FieldName).Value := Self.FColorBar.Value;
      ParamByName(FColorBarBack.FieldName).Value := Self.FColorBarBack.Value;
      ParamByName(FColorBarText.FieldName).Value := Self.FColorBarText.Value;
      ParamByName(FColorBarTextActive.FieldName).Value := Self.FColorBarTextActive.Value;

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
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTableName.FieldName,
        FColumnName.FieldName,
        FMaxValue.FieldName,
        FColorBar.FieldName,
        FColorBarBack.FieldName,
        FColorBarText.FieldName,
        FColorBarTextActive.FieldName
      ]);

      ParamByName(FTableName.FieldName).Value := Self.FTableName.Value;
      ParamByName(FColumnName.FieldName).Value := Self.FColumnName.Value;
      ParamByName(FMaxValue.FieldName).Value := Self.FMaxValue.Value;
      ParamByName(FColorBar.FieldName).Value := Self.FColorBar.Value;
      ParamByName(FColorBarBack.FieldName).Value := Self.FColorBarBack.Value;
      ParamByName(FColorBarText.FieldName).Value := Self.FColorBarText.Value;
      ParamByName(FColorBarTextActive.FieldName).Value := Self.FColorBarTextActive.Value;

		  ParamByName(Self.Id.FieldName).Value := Self.Id.Value;

      Self.Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

procedure TSysGridColPercent.Clear();
begin
  inherited;
  Self.FTableName.Value := '';
  Self.FColumnName.Value := '';
  Self.FMaxValue.Value := 0;
  Self.FColorBar.Value := 0;
  Self.FColorBarBack.Value := 0;
  Self.FColorBarText.Value := 0;
  Self.FColorBarTextActive.Value := 0;
end;

function TSysGridColPercent.Clone():TTable;
begin
  Result := TSysGridColPercent.Create(Database);

  Self.Id.Clone(TSysGridColPercent(Result).Id);

  Self.FTableName.Clone(TSysGridColPercent(Result).FTableName);
  Self.FColumnName.Clone(TSysGridColPercent(Result).FColumnName);
  Self.FMaxValue.Clone(TSysGridColPercent(Result).FMaxValue);
  Self.FColorBar.Clone(TSysGridColPercent(Result).FColorBar);
  Self.FColorBarBack.Clone(TSysGridColPercent(Result).FColorBarBack);
  Self.FColorBarText.Clone(TSysGridColPercent(Result).FColorBarText);
  Self.FColorBarTextActive.Clone(TSysGridColPercent(Result).FColorBarTextActive);
end;

end.
