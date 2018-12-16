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
    FOrdinalPosition: TFieldDB;
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
    property OrdinalPosition: TFieldDB read FOrdinalPosition write FOrdinalPosition;
  end;

implementation

uses
  Ths.Erp.Database.Singleton;

constructor TSysViewColumns.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_view_columns';
  SourceCode := '1000';

  FTableName  := TFieldDB.Create('table_name', ftString, '');
  FColumnName := TFieldDB.Create('column_name', ftString, '');
  FIsNullable := TFieldDB.Create('is_nullable', ftString, 'YES');
  FDataType := TFieldDB.Create('data_type', ftString, '');
  FCharacterMaximumLength := TFieldDB.Create('character_maximum_length', ftInteger, 0);
  FOrdinalPosition := TFieldDB.Create('ordinal_position', ftInteger, 0);
end;

procedure TSysViewColumns.SelectToDatasource(pFilter: string;
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
          TableName + '.' + FColumnName.FieldName,
          TableName + '.' + FIsNullable.FieldName,
          TableName + '.' + FDataType.FieldName,
          TableName + '.' + FCharacterMaximumLength.FieldName,
          TableName + '.' + FOrdinalPosition.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(FTableName.FieldName).DisplayLabel := 'TABLE NAME';
      Self.DataSource.DataSet.FindField(FColumnName.FieldName).DisplayLabel := 'COLUMN NAME';
      Self.DataSource.DataSet.FindField(FIsNullable.FieldName).DisplayLabel := 'NULLABLE?';
      Self.DataSource.DataSet.FindField(FDataType.FieldName).DisplayLabel := 'DATA TYPE';
      Self.DataSource.DataSet.FindField(FCharacterMaximumLength.FieldName).DisplayLabel := 'CHARECTER MAX LENGTH';
      Self.DataSource.DataSet.FindField(FOrdinalPosition.FieldName).DisplayLabel := 'ORDINAL POSITION';
	  end;
  end;
end;

procedure TSysViewColumns.SelectToList(pFilter: string; pLock: Boolean;
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
          TableName + '.' + FColumnName.FieldName,
          TableName + '.' + FIsNullable.FieldName,
          TableName + '.' + FDataType.FieldName,
          TableName + '.' + FCharacterMaximumLength.FieldName,
          TableName + '.' + FOrdinalPosition.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    FTableName.Value := FormatedVariantVal(FieldByName(FTableName.FieldName).DataType, FieldByName(FTableName.FieldName).Value);
        FColumnName.Value := FormatedVariantVal(FieldByName(FColumnName.FieldName).DataType, FieldByName(FColumnName.FieldName).Value);
        FIsNullable.Value := FormatedVariantVal(FieldByName(FIsNullable.FieldName).DataType, FieldByName(FIsNullable.FieldName).Value);
        FDataType.Value := FormatedVariantVal(FieldByName(FDataType.FieldName).DataType, FieldByName(FDataType.FieldName).Value);
        FCharacterMaximumLength.Value := FormatedVariantVal(FieldByName(FCharacterMaximumLength.FieldName).DataType, FieldByName(FCharacterMaximumLength.FieldName).Value);
        FOrdinalPosition.Value := FormatedVariantVal(FieldByName(FOrdinalPosition.FieldName).DataType, FieldByName(FOrdinalPosition.FieldName).Value);

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
  FIsNullable.Value := 'NO';
end;

function TSysViewColumns.Clone():TTable;
begin
  Result := TSysViewColumns.Create(Database);

  FTableName.Clone(TSysViewColumns(Result).FTableName);
  FColumnName.Clone(TSysViewColumns(Result).FColumnName);
  FIsNullable.Clone(TSysViewColumns(Result).FIsNullable);
  FDataType.Clone(TSysViewColumns(Result).FDataType);
  FCharacterMaximumLength.Clone(TSysViewColumns(Result).FCharacterMaximumLength);
  FOrdinalPosition.Clone(TSysViewColumns(Result).FOrdinalPosition);
end;

end.
