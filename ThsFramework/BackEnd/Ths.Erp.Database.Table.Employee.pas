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
    FName           : TFieldDB;
    FSurname        : TFieldDB;
    FDepartmentID   : TFieldDB;
    FUnitID         : TFieldDB;
    FJobID          : TFieldDB;
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

    Property Name           : TFieldDB read FName            write FName;
    Property Surname        : TFieldDB read FSurname         write FSurname;
    Property DepartmentID   : TFieldDB read FDepartmentID    write FDepartmentID;
    Property UnitID         : TFieldDB read FUnitID          write FUnitID;
    Property JobID          : TFieldDB read FJobID           write FJobID;
  end;

implementation

uses
  Ths.Erp.Constants;

constructor TEmployee.Create(OwnerDatabase: TDatabase);
begin
  inherited;
  TableName := 'user';
  SourceCode := '1000';

  Self.FName := TFieldDB.Create('name', ftString, '');
  Self.FSurname := TFieldDB.Create('surname', ftString, '');
  Self.FDepartmentID := TFieldDB.Create('department_id', ftInteger, '');
  Self.FUnitID := TFieldDB.Create('unit_id', ftInteger, '');
  Self.FJobID := TFieldDB.Create('job_id', ftInteger, '');
end;

procedure TEmployee.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + Self.FName.FieldName,
          TableName + '.' + Self.FSurname.FieldName,
          TableName + '.' + Self.FDepartmentID.FieldName,
          TableName + '.' + Self.FUnitID.FieldName,
          TableName + '.' + Self.FJobID.FieldName
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
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
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
		    Self.Id.Value            := FieldByName(Self.Id.FieldName).AsInteger;

		    Self.FName.Value         := FieldByName(FName.FieldName).AsString;
        Self.FSurname.Value      := FieldByName(FSurname.FieldName).AsString;
        Self.FDepartmentID.Value := FieldByName(FDepartmentID.FieldName).AsInteger;
        Self.FUnitID.Value       := FieldByName(FUnitID.FieldName).AsInteger;
        Self.FJobID.Value        := FieldByName(FJobID.FieldName).AsInteger;

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
  if Self.IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
      SQL.Text := Self.Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FName.FieldName,
        FSurname.FieldName,
        FDepartmentID.FieldName,
        FUnitID.FieldName,
        FJobID.FieldName
      ]);

      ParamByName(FName.FieldName).Value := FName.Value;
      ParamByName(FSurname.FieldName).Value := FSurname.Value;
      ParamByName(FDepartmentID.FieldName).Value := FDepartmentID.Value;
      ParamByName(FUnitID.FieldName).Value := FUnitID.Value;
      ParamByName(FJobID.FieldName).Value := FJobID.Value;

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

procedure TEmployee.update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FName.FieldName,
        FSurname.FieldName,
        FDepartmentID.FieldName,
        FUnitID.FieldName,
        FJobID.FieldName
      ]);

      ParamByName(FName.FieldName).Value := Self.Name.Value;
      ParamByName(FSurname.FieldName).Value := Self.Surname.Value;
      ParamByName(FDepartmentID.FieldName).Value := Self.DepartmentID.Value;
      ParamByName(FUnitID.FieldName).Value := Self.UnitID.Value;
      ParamByName(FJobID.FieldName).Value := Self.JobID.Value;

      ParamByName(Self.Id.FieldName).Value := Self.Id.Value;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;

    self.notify;
  end;
end;

procedure TEmployee.Clear();
begin
  inherited;
  Self.Name.Value := '';
  Self.Surname.Value := '';
  Self.DepartmentID.Value := 0;
  Self.UnitID.Value := 0;
  Self.JobID.Value := 0;
end;

function TEmployee.Clone():TTable;
begin
  Result := TEmployee.Create(Database);

  Self.Id.Clone(TEmployee(Result).Id);

  Self.FName.Clone(TEmployee(Result).FName);
  Self.FSurname.Clone(TEmployee(Result).FSurname);
  Self.FDepartmentID.Clone(TEmployee(Result).FDepartmentID);
  Self.FUnitID.Clone(TEmployee(Result).FUnitID);
  Self.FJobID.Clone(TEmployee(Result).FJobID);
end;

end.
