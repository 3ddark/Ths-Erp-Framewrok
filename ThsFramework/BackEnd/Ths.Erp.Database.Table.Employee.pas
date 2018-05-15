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

constructor TEmployee.Create(OwnerDatabase: TDatabase);
begin
  inherited;
  TableName := 'user';
  Self.PermissionSourceCode := 'USER';
end;

procedure TEmployee.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(Self.PermissionSourceCode, ptRead, pPermissionControl, taSelect) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
      EmptyDataSet;
		  SQL.Clear;
		  SQL.Text := ' SELECT id, validity, name, surname, department_id, unit_id, job_id ' +
                  ' FROM ' + TableName + ' WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.Fields[0].DisplayLabel := 'ID';
      Self.DataSource.DataSet.Fields[1].DisplayLabel := 'VALIDITY';
      Self.DataSource.DataSet.Fields[2].DisplayLabel := 'NAME';
      Self.DataSource.DataSet.Fields[3].DisplayLabel := 'SURNAME';
      Self.DataSource.DataSet.Fields[4].DisplayLabel := 'DEPARMENT ID';
      Self.DataSource.DataSet.Fields[5].DisplayLabel := 'UNIT ID';
      Self.DataSource.DataSet.Fields[6].DisplayLabel := 'JOB ID';
	  end;
  end;
end;

procedure TEmployee.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(Self.PermissionSourceCode, ptRead, pPermissionControl, taSelect) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Text := 'SELECT id, validity, name, surname, department_id, unit_id, job_id FROM ' + TableName + ' WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id                 := FieldByName('id').AsInteger;
		    Self.Validity           := FieldByName('validity').AsBoolean;

		    Self.Name               := FieldByName('kullanici_adi').AsString;
        Self.Surname            := FieldByName('sifre').AsString;
        Self.DeparmentID        := FieldByName('surum').AsInteger;
        Self.UnitID             := FieldByName('is_yonetici').AsInteger;
        Self.JobID              := FieldByName('is_yonetici').AsInteger;

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
  if Self.IsAuthorized(Self.PermissionSourceCode, ptWrite, pPermissionControl, taInsert) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text :=
      ' SELECT kullanici_insert(' +
          QuotedStr(Self.Name) + ',' +
          QuotedStr(Self.Surname) + ',' +
          IntToStr(Self.DeparmentID) + ',' +
          IntToStr(Self.UnitID) + ',' +
          IntToStr(Self.JobID) +
      ');';
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
  if Self.IsAuthorized(Self.PermissionSourceCode, ptWrite, pPermissionControl, taUpdate) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text :=
		  ' UPDATE ' + TableName + ' SET validity=:validity, ' +
        ' name=:name, surname=:surname, department_id=:department_id, ' +
        ' unit_id=:unit_id, job_id=:job_id ' +
		  ' WHERE id=:id;' ;

      if (Self.Name <> '') then
        ParamByName('name').Value := Self.Name;
      ParamByName('surname').Value := Self.Surname;
      ParamByName('deparment_id').Value := Self.DeparmentID;
      ParamByName('unit_id').Value := Self.UnitID;
      ParamByName('job_id').Value := Self.JobID;

      ParamByName('validity').Value := Self.Validity;
      ParamByName('id').Value := Self.Id;

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
  TEmployee(Result).Validity          := Self.Validity;
  TEmployee(Result).PermissionSourceCode  := Self.PermissionSourceCode;
end;

end.
