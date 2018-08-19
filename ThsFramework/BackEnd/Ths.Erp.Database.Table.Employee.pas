unit Ths.Erp.Database.Table.Employee;

interface

uses
  SysUtils, Classes, Types,
  FireDAC.Stan.Param, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TEmployee = class(TTable)
  private
    FName: TFieldDB;
    FSurname: TFieldDB;
    FDepartmentID: TFieldDB;
    FUnitID: TFieldDB;
    FJobID: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase: TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    property Name: TFieldDB read FName write FName;
    property Surname: TFieldDB read FSurname write FSurname;
    property DepartmentID: TFieldDB read FDepartmentID write FDepartmentID;
    property UnitID: TFieldDB read FUnitID write FUnitID;
    property JobID: TFieldDB read FJobID write FJobID;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TEmployee.Create(OwnerDatabase: TDatabase);
begin
  inherited;
  TableName := 'user';
  SourceCode := '1000';

  FName := TFieldDB.Create('name', ftString, '');
  FSurname := TFieldDB.Create('surname', ftString, '');
  FDepartmentID := TFieldDB.Create('department_id', ftInteger, '');
  FUnitID := TFieldDB.Create('unit_id', ftInteger, '');
  FJobID := TFieldDB.Create('job_id', ftInteger, '');
end;

procedure TEmployee.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FName.FieldName,
          TableName + '.' + FSurname.FieldName,
          TableName + '.' + FDepartmentID.FieldName,
          TableName + '.' + FUnitID.FieldName,
          TableName + '.' + FJobID.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FName.FieldName).DisplayLabel := 'NAME';
      Self.DataSource.DataSet.FindField(FSurname.FieldName).DisplayLabel := 'SURNAME';
      Self.DataSource.DataSet.FindField(FDepartmentID.FieldName).DisplayLabel := 'DEPARMENT ID';
      Self.DataSource.DataSet.FindField(FUnitID.FieldName).DisplayLabel := 'UNIT ID';
      Self.DataSource.DataSet.FindField(FJobID.FieldName).DisplayLabel := 'JOB ID';
	  end;
  end;
end;

procedure TEmployee.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
          TableName + '.' + FName.FieldName,
          TableName + '.' + FSurname.FieldName,
          TableName + '.' + FDepartmentID.FieldName,
          TableName + '.' + FUnitID.FieldName,
          TableName + '.' + FJobID.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

		    FName.Value := FormatedVariantVal(FieldByName(FName.FieldName).DataType, FieldByName(FName.FieldName).Value);
        FSurname.Value := FormatedVariantVal(FieldByName(FSurname.FieldName).DataType, FieldByName(FSurname.FieldName).Value);
        FDepartmentID.Value := FormatedVariantVal(FieldByName(FDepartmentID.FieldName).DataType, FieldByName(FDepartmentID.FieldName).Value);
        FUnitID.Value := FormatedVariantVal(FieldByName(FUnitID.FieldName).DataType, FieldByName(FUnitID.FieldName).Value);
        FJobID.Value := FormatedVariantVal(FieldByName(FJobID.FieldName).DataType, FieldByName(FJobID.FieldName).Value);

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TEmployee.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FName.FieldName,
        FSurname.FieldName,
        FDepartmentID.FieldName,
        FUnitID.FieldName,
        FJobID.FieldName
      ]);

      NewParamForQuery(QueryOfTable, FName);
      NewParamForQuery(QueryOfTable, FSurname);
      NewParamForQuery(QueryOfTable, FDepartmentID);
      NewParamForQuery(QueryOfTable, FUnitID);
      NewParamForQuery(QueryOfTable, FJobID);

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

procedure TEmployee.update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FName.FieldName,
        FSurname.FieldName,
        FDepartmentID.FieldName,
        FUnitID.FieldName,
        FJobID.FieldName
      ]);

      NewParamForQuery(QueryOfTable, FName);
      NewParamForQuery(QueryOfTable, FSurname);
      NewParamForQuery(QueryOfTable, FDepartmentID);
      NewParamForQuery(QueryOfTable, FUnitID);
      NewParamForQuery(QueryOfTable, FJobID);

      NewParamForQuery(QueryOfTable, Id);

		  ExecSQL;
		  Close;
	  end;

    self.notify;
  end;
end;

procedure TEmployee.Clear();
begin
  inherited;
  FName.Value := '';
  FSurname.Value := '';
  FDepartmentID.Value := 0;
  FUnitID.Value := 0;
  FJobID.Value := 0;
end;

function TEmployee.Clone():TTable;
begin
  Result := TEmployee.Create(Database);

  Self.Id.Clone(TEmployee(Result).Id);

  FName.Clone(TEmployee(Result).FName);
  FSurname.Clone(TEmployee(Result).FSurname);
  FDepartmentID.Clone(TEmployee(Result).FDepartmentID);
  FUnitID.Clone(TEmployee(Result).FUnitID);
  FJobID.Clone(TEmployee(Result).FJobID);
end;

end.
