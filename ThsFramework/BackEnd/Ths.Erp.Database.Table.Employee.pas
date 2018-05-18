unit Ths.Erp.Database.Table.Employee;

interface

uses
  SysUtils, Classes, Types,
  FireDAC.Stan.Param,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TEmployee = class(TTable)
  private
    FName           : string;
    FSurname        : string;
    FDeparmentID    : Integer;
    FUnitID         : Integer;
    FJobID          : Integer;
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

    Property Name           : string  read FName            write FName;
    Property Surname        : string  read FSurname         write FSurname;
    Property DeparmentID    : Integer read FDeparmentID     write FDeparmentID;
    Property UnitID         : Integer read FUnitID          write FUnitID;
    Property JobID          : Integer read FJobID           write FJobID;
  end;

implementation

uses
  Ths.Erp.Constants;

constructor TEmployee.Create(OwnerDatabase: TDatabase);
begin
  inherited;
  TableName := 'user';
end;

procedure TEmployee.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
      EmptyDataSet;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName,
        [TableName + '.' + 'id',
        TableName + '.' + 'name',
        TableName + '.' + 'surname',
        TableName + '.' + 'department_id',
        TableName + '.' + 'unit_id',
        TableName + '.' + 'job_id']) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField('id').DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField('name').DisplayLabel := 'NAME';
      Self.DataSource.DataSet.FindField('surname').DisplayLabel := 'SURNAME';
      Self.DataSource.DataSet.FindField('department_id').DisplayLabel := 'DEPARMENT ID';
      Self.DataSource.DataSet.FindField('unit_id').DisplayLabel := 'UNIT ID';
      Self.DataSource.DataSet.FindField('job_id').DisplayLabel := 'JOB ID';
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
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName,
        [TableName + '.' + 'id',
        TableName + '.' + 'name',
        TableName + '.' + 'surname',
        TableName + '.' + 'department_id',
        TableName + '.' + 'unit_id',
        TableName + '.' + 'job_id']) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id                 := FieldByName('id').AsInteger;

		    Self.Name               := FieldByName('name').AsString;
        Self.Surname            := FieldByName('surname').AsString;
        Self.DeparmentID        := FieldByName('department_id').AsInteger;
        Self.UnitID             := FieldByName('unit_id').AsInteger;
        Self.JobID              := FieldByName('job_id').AsInteger;

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
      SQL.Text := Self.Database.GetSQLInsertCmd(TableName, SQL_PARAM_SEPERATE,
        ['name', 'surname', 'department_id', 'unit_id', 'job_id']);

      ParamByName('name').Value := Self.FName;
      ParamByName('surname').Value := Self.FSurname;
      ParamByName('department_id').Value := Self.FDeparmentID;
      ParamByName('unit_id').Value := Self.FUnitID;
      ParamByName('job_id').Value := Self.FJobID;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  Open;

      if (Fields.Count > 0) and (not Fields.Fields[0].IsNull) then
        pID := Fields.Fields[0].AsInteger
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
		  SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, SQL_PARAM_SEPERATE,
        ['name', 'surname', 'department_id', 'unit_id', 'job_id']);

      ParamByName('name').Value := Self.Name;
      ParamByName('surname').Value := Self.Surname;
      ParamByName('deparment_id').Value := Self.DeparmentID;
      ParamByName('unit_id').Value := Self.UnitID;
      ParamByName('job_id').Value := Self.JobID;

      ParamByName('id').Value := Self.Id;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  EmptyDataSet;
		  Close;
	  end;

    self.notify;
  end;
end;

procedure TEmployee.Clear();
begin
  inherited;
  Self.Name := '';
  Self.Surname := '';
  Self.DeparmentID := 0;
  Self.UnitID := 0;
  Self.JobID := 0;
end;

function TEmployee.Clone():TTable;
begin
  Result := TEmployee.Create(Database);

  TEmployee(Result).Name              := Self.Name;
  TEmployee(Result).Surname           := Self.Surname;
  TEmployee(Result).DeparmentID       := Self.DeparmentID;
  TEmployee(Result).UnitID            := Self.UnitID;
  TEmployee(Result).JobID             := Self.JobID;

  TEmployee(Result).Id                := Self.Id;
end;

end.
