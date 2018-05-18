unit Ths.Erp.Database.Table.SysUser;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, Ths.Erp.SpecialFunctions,
  Ths.Erp.Constants,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TSysUser = class(TTable)
  private
    FUserName       : string;
    FUserPassword   : string;
    FAppVersion     : string;
    FIsAdmin        : Boolean;
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

    Property UserName       : string  read FUserName       write FUserName;
    Property UserPassword   : string  read FUserPassword   write FUserPassword;
    Property AppVersion     : string  read FAppVersion     write FAppVersion;
    Property IsAdmin        : Boolean read FIsAdmin        write FIsAdmin;
  end;

implementation

constructor TSysUser.Create(OwnerDatabase: TDatabase);
begin
  inherited;
  TableName := 'sys_user';
end;

procedure TSysUser.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
      EmptyDataSet;
		  SQL.Clear;
		  SQL.Text :=
        Database.GetSQLSelectCmd(TableName,
          [TableName + '.id',
          TableName + '.user_name',
          TableName + '.user_password',
          TableName + '.app_version',
          TableName + '.is_admin']) +
          'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField('id').DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField('user_name').DisplayLabel := 'USER NAME';
      Self.DataSource.DataSet.FindField('user_password').DisplayLabel := 'USER PASSWORD';
      Self.DataSource.DataSet.FindField('app_version').DisplayLabel := 'APP VERSION';
      Self.DataSource.DataSet.FindField('is_admin').DisplayLabel := 'ADMIN?';
	  end;
  end;
end;

procedure TSysUser.SelectToList(pFilter: string; pLock: Boolean;
  pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Text :=
        Database.GetSQLSelectCmd(TableName,
          [TableName + '.id',
          TableName + '.user_name',
          TableName + '.user_password',
          TableName + '.app_version',
          TableName + '.is_admin']) +
          'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id                 := FieldByName('id').AsInteger;

		    Self.UserName           := FieldByName('user_name').AsString;
        Self.UserPassword       := FieldByName('user_password').AsString;
        Self.AppVersion         := FieldByName('app_version').AsString;
        Self.IsAdmin            := FieldByName('is_admin').AsBoolean;

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TSysUser.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLInsertCmd(TableName, SQL_PARAM_SEPERATE,
        ['user_name', 'user_password', 'app_version', 'is_admin']);

      ParamByName('user_name').Value := Self.UserName;
      ParamByName('user_password').Value := Self.UserPassword;
      ParamByName('app_version').Value := Self.AppVersion;
      ParamByName('is_admin').Value := Self.IsAdmin;

		  Database.SetQueryParamsDefaultValue(QueryOfTable);

      Open;

      pID := 0;
      if (Fields.Count > 0) and (not Fields.Fields[0].IsNull) then
        pID := Fields.Fields[0].AsInteger;

		  EmptyDataSet;
		  Close;
	  end;
    Self.notify;
  end;
end;

procedure TSysUser.Update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, SQL_PARAM_SEPERATE,
        ['user_name', 'user_password', 'app_version', 'is_admin']);

      ParamByName('user_name').Value := Self.UserName;
      ParamByName('user_password').Value := Self.UserPassword;
      ParamByName('app_version').Value := Self.AppVersion;
      ParamByName('is_admin').Value := Self.IsAdmin;

      ParamByName('id').Value := Self.Id;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  EmptyDataSet;
		  Close;
	  end;

    self.notify;
  end;
end;

procedure TSysUser.Clear();
begin
  inherited;
  Self.UserName := '';
  Self.UserPassword := '';
  Self.AppVersion := '';
  Self.IsAdmin := False;
end;

function TSysUser.Clone():TTable;
begin
  Result := TSysUser.Create(Database);

  TSysUser(Result).UserName          := Self.UserName;
  TSysUser(Result).UserPassword      := Self.UserPassword;
  TSysUser(Result).AppVersion        := Self.AppVersion;
  TSysUser(Result).IsAdmin           := Self.IsAdmin;

  TSysUser(Result).Id                := Self.Id;
end;

end.
