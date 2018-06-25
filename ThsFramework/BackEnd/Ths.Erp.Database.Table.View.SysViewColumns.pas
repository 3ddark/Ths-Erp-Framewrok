unit Ths.Erp.Database.Table.View.SysViewColumns;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.View,
  Ths.Erp.Database.Table.Field;

type
  TSysViewColumns = class(TView)
  private
    FTableName: TFieldDB;
    FColumnName: TFieldDB;
    FIsNullable: TFieldDB;
    FDataType: TFieldDB;
    FCharacterMaximumLength: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property TableName1: TFieldDB read FTableName write FTableName;
    Property ColumnName: TFieldDB read FColumnName write FColumnName;
    property IsNullable: TFieldDB read FIsNullable write FIsNullable;
    property DataType: TFieldDB read FDataType write FDataType;
    property CharacterMaximumLength: TFieldDB read FCharacterMaximumLength write FCharacterMaximumLength;
  end;

implementation

uses
  Ths.Erp.Constants;

constructor TSysViewColumns.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_view_columns';
  SourceCode := '1000';

  Self.TableName1  := TFieldDB.Create('table_name', ftString, '');
  Self.FColumnName := TFieldDB.Create('column_name', ftString, '');
  Self.FIsNullable := TFieldDB.Create('is_nullable', ftString, 'YES');
  Self.FDataType := TFieldDB.Create('data_type', ftString, '');
  Self.FCharacterMaximumLength := TFieldDB.Create('character_maximum_length', ftInteger, 0);
end;

procedure TSysViewColumns.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + FTableName.FieldName,
          TableName + '.' + FColumnName.FieldName,
          TableName + '.' + FIsNullable.FieldName,
          TableName + '.' + FDataType.FieldName,
          TableName + '.' + FCharacterMaximumLength.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(FTableName.FieldName).DisplayLabel := 'TABLE NAME';
      Self.DataSource.DataSet.FindField(FColumnName.FieldName).DisplayLabel := 'COLUMN NAME';
      Self.DataSource.DataSet.FindField(FIsNullable.FieldName).DisplayLabel := 'NULLABLE?';
      Self.DataSource.DataSet.FindField(FDataType.FieldName).DisplayLabel := 'DATA TYPE';
      Self.DataSource.DataSet.FindField(FCharacterMaximumLength.FieldName).DisplayLabel := 'CHARECTER MAX LENGTH';
	  end;
  end;
end;

procedure TSysViewColumns.SelectToList(pFilter: string; pLock: Boolean;
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
          TableName + '.' + FTableName.FieldName,
          TableName + '.' + FColumnName.FieldName,
          TableName + '.' + FIsNullable.FieldName,
          TableName + '.' + FDataType.FieldName,
          TableName + '.' + FCharacterMaximumLength.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.FTableName.Value := FieldByName(FTableName.FieldName).AsString;
        Self.FColumnName.Value := FieldByName(FColumnName.FieldName).AsString;
        Self.FIsNullable.Value := FieldByName(FIsNullable.FieldName).AsString;
        Self.FDataType.Value := FieldByName(FDataType.FieldName).AsString;
        Self.FCharacterMaximumLength.Value := FieldByName(FCharacterMaximumLength.FieldName).AsInteger;

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TSysViewColumns.Clear();
begin
  inherited;
  Self.FTableName.Value := '';
  Self.FColumnName.Value := '';
  Self.FIsNullable.Value := 'NO';
  Self.FDataType.Value := '';
  Self.FCharacterMaximumLength.Value := 0;
end;

function TSysViewColumns.Clone():TTable;
begin
  Result := TSysViewColumns.Create(Database);

  Self.FTableName.Clone(TSysViewColumns(Result).FTableName);
  Self.FColumnName.Clone(TSysViewColumns(Result).FColumnName);
  Self.FIsNullable.Clone(TSysViewColumns(Result).FIsNullable);
  Self.FDataType.Clone(TSysViewColumns(Result).FDataType);
  Self.FCharacterMaximumLength.Clone(TSysViewColumns(Result).FCharacterMaximumLength);
end;

end.
