unit Ths.Erp.Database.Table.View.SysViewTables;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.View,
  Ths.Erp.Database.Table.Field;

type
  TSysViewTables = class(TView)
  private
    FTableName: TFieldDB;
    FTableType: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property TableName1: TFieldDB read FTableName write FTableName;
    Property TableType: TFieldDB read FTableType write FTableType;
  end;

implementation

uses
  Ths.Erp.Database.Singleton;

constructor TSysViewTables.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_view_tables';
  SourceCode := '1000';

  FTableName  := TFieldDB.Create('table_name', ftString, '');
  FTableType := TFieldDB.Create('table_type', ftString, '');
end;

procedure TSysViewTables.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfDS do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + FTableName.FieldName,
          TableName + '.' + FTableType.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(FTableName.FieldName).DisplayLabel := 'Table Name';
      Self.DataSource.DataSet.FindField(FTableType.FieldName).DisplayLabel := 'Table Type';
	  end;
  end;
end;

procedure TSysViewTables.SelectToList(pFilter: string; pLock: Boolean;
  pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfList do
	  begin
		  Close;
		  SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + FTableName.FieldName,
          TableName + '.' + FTableType.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    FTableName.Value := FormatedVariantVal(FieldByName(FTableName.FieldName).DataType, FieldByName(FTableName.FieldName).Value);
        FTableType.Value := FormatedVariantVal(FieldByName(FTableType.FieldName).DataType, FieldByName(FTableType.FieldName).Value);

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TSysViewTables.Clear();
begin
  inherited;
  FTableName.Value := '';
  FTableType.Value := '';
end;

function TSysViewTables.Clone():TTable;
begin
  Result := TSysViewTables.Create(Database);

  FTableName.Clone(TSysViewTables(Result).FTableName);
  FTableType.Clone(TSysViewTables(Result).FTableType);
end;

end.
