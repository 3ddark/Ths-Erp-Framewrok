unit Ths.Erp.Database.Table.View.SysViewColumns;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.View;

type
  TSysViewColumns = class(TView)
  private
    FTableName: TFieldDB;
    FColumnName: TFieldDB;
    FIsNullable: TFieldDB;
    FDataType: TFieldDB;
    FCharacterMaximumLength: TFieldDB;
    FOrdinalPosition: TFieldDB;
    FNumericPrecision: TFieldDB;
    FNumericScale: TFieldDB;
    FOrjTableName: TFieldDB;
    FOrjColumnName: TFieldDB;
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
    property NumericPrecision: TFieldDB read FNumericPrecision write FNumericPrecision;
    property NumericScale: TFieldDB read FNumericScale write FNumericScale;
    property OrjTableName: TFieldDB read FOrjTableName write FOrjTableName;
    property OrjColumnName: TFieldDB read FOrjColumnName write FOrjColumnName;
  end;

implementation

uses
  Ths.Erp.Database.Singleton;

constructor TSysViewColumns.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_view_columns';
  SourceCode := '1000';

  FTableName  := TFieldDB.Create('table_name', ftString, '', 0, False, False);
  FColumnName := TFieldDB.Create('column_name', ftString, '', 0, False, False);
  FIsNullable := TFieldDB.Create('is_nullable', ftString, 'YES', 0, False, False);
  FDataType := TFieldDB.Create('data_type', ftString, '', 0, False, False);
  FCharacterMaximumLength := TFieldDB.Create('character_maximum_length', ftInteger, 0, 0, False, False);
  FOrdinalPosition := TFieldDB.Create('ordinal_position', ftInteger, 0, 0, False, False);
  FNumericPrecision := TFieldDB.Create('numeric_precision', ftInteger, 0, 0, False, False);
  FNumericScale := TFieldDB.Create('numeric_scale', ftInteger, 0, 0, False, False);
  FOrjTableName  := TFieldDB.Create('orj_table_name', ftString, '', 0, False, False);
  FOrjColumnName := TFieldDB.Create('orj_column_name', ftString, '', 0, False, False);
end;

procedure TSysViewColumns.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
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
          TableName + '.' + FOrdinalPosition.FieldName,
          TableName + '.' + FNumericPrecision.FieldName,
          TableName + '.' + FNumericScale.FieldName,
          TableName + '.' + FOrjTableName.FieldName,
          TableName + '.' + FOrjColumnName.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(FTableName.FieldName).DisplayLabel := 'Table Name';
      Self.DataSource.DataSet.FindField(FColumnName.FieldName).DisplayLabel := 'Column Name';
      Self.DataSource.DataSet.FindField(FIsNullable.FieldName).DisplayLabel := 'Nullable?';
      Self.DataSource.DataSet.FindField(FDataType.FieldName).DisplayLabel := 'Data Type';
      Self.DataSource.DataSet.FindField(FCharacterMaximumLength.FieldName).DisplayLabel := 'Character Max Length';
      Self.DataSource.DataSet.FindField(FOrdinalPosition.FieldName).DisplayLabel := 'Ordinal Position';
      Self.DataSource.DataSet.FindField(FNumericPrecision.FieldName).DisplayLabel := 'Numeric Precision';
      Self.DataSource.DataSet.FindField(FNumericScale.FieldName).DisplayLabel := 'Numeric Scale';
      Self.DataSource.DataSet.FindField(FOrjTableName.FieldName).DisplayLabel := 'Orj Table Name';
      Self.DataSource.DataSet.FindField(FOrjColumnName.FieldName).DisplayLabel := 'Orj Column Name';
	  end;
  end;
end;

procedure TSysViewColumns.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE OF ' + TableName + ' NOWAIT';

	  with QueryOfList do
	  begin
		  Close;
		  SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + FTableName.FieldName,
          TableName + '.' + FColumnName.FieldName,
          TableName + '.' + FIsNullable.FieldName,
          TableName + '.' + FDataType.FieldName,
          TableName + '.' + FCharacterMaximumLength.FieldName,
          TableName + '.' + FOrdinalPosition.FieldName,
          TableName + '.' + FNumericPrecision.FieldName,
          TableName + '.' + FNumericScale.FieldName,
          TableName + '.' + FOrjTableName.FieldName,
          TableName + '.' + FOrjColumnName.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    FTableName.Value := FormatedVariantVal(FindField(FTableName.FieldName).DataType, FindField(FTableName.FieldName).Value);
        FColumnName.Value := FormatedVariantVal(FindField(FColumnName.FieldName).DataType, FindField(FColumnName.FieldName).Value);
        FIsNullable.Value := FormatedVariantVal(FindField(FIsNullable.FieldName).DataType, FindField(FIsNullable.FieldName).Value);
        FDataType.Value := FormatedVariantVal(FindField(FDataType.FieldName).DataType, FindField(FDataType.FieldName).Value);
        FCharacterMaximumLength.Value := FormatedVariantVal(FindField(FCharacterMaximumLength.FieldName).DataType, FindField(FCharacterMaximumLength.FieldName).Value);
        FOrdinalPosition.Value := FormatedVariantVal(FindField(FOrdinalPosition.FieldName).DataType, FindField(FOrdinalPosition.FieldName).Value);
        FNumericPrecision.Value := FormatedVariantVal(FindField(FNumericPrecision.FieldName).DataType, FindField(FNumericPrecision.FieldName).Value);
        FNumericScale.Value := FormatedVariantVal(FindField(FNumericScale.FieldName).DataType, FindField(FNumericScale.FieldName).Value);
		    FOrjTableName.Value := FormatedVariantVal(FindField(FOrjTableName.FieldName).DataType, FindField(FOrjTableName.FieldName).Value);
        FOrjColumnName.Value := FormatedVariantVal(FindField(FOrjColumnName.FieldName).DataType, FindField(FOrjColumnName.FieldName).Value);

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
  FNumericPrecision.Clone(TSysViewColumns(Result).FNumericPrecision);
  FNumericScale.Clone(TSysViewColumns(Result).FNumericScale);
  FOrjTableName.Clone(TSysViewColumns(Result).FOrjTableName);
  FOrjColumnName.Clone(TSysViewColumns(Result).FOrjColumnName);
end;

end.
