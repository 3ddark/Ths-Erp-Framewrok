unit Ths.Erp.Database.Table.SysUser;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, Data.DB,
  Ths.Erp.Constants,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TSysUser = class(TTable)
  private
    FUserName       : TFieldDB;
    FUserPassword   : TFieldDB;
    FAppVersion     : TFieldDB;
    FIsAdmin        : TFieldDB;
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

    Property UserName       : TFieldDB read FUserName       write FUserName;
    Property UserPassword   : TFieldDB read FUserPassword   write FUserPassword;
    Property AppVersion     : TFieldDB read FAppVersion     write FAppVersion;
    Property IsAdmin        : TFieldDB read FIsAdmin        write FIsAdmin;
  end;

implementation

constructor TSysUser.Create(OwnerDatabase: TDatabase);
begin
  inherited;
  TableName := 'sys_user';
  SourceCode := '1000';

  Self.FUserName := TFieldDB.Create('user_name', ftString, '');
  Self.FUserPassword := TFieldDB.Create('user_password', ftString, '');
  Self.FAppVersion := TFieldDB.Create('app_version', ftString, '');
  Self.FIsAdmin := TFieldDB.Create('is_admin', ftBoolean, False);
end;

procedure TSysUser.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text :=
        Database.GetSQLSelectCmd(TableName, [
            TableName + '.' + Self.Id.FieldName,
            TableName + '.' + FUserName.FieldName,
            TableName + '.' + FUserPassword.FieldName,
            TableName + '.' + FAppVersion.FieldName,
            TableName + '.' + FIsAdmin.FieldName
          ]) +
          'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FUserName.FieldName).DisplayLabel := 'USER NAME';
      Self.DataSource.DataSet.FindField(FUserPassword.FieldName).DisplayLabel := 'USER PASSWORD';
      Self.DataSource.DataSet.FindField(FAppVersion.FieldName).DisplayLabel := 'APP VERSION';
      Self.DataSource.DataSet.FindField(FIsAdmin.FieldName).DisplayLabel := 'ADMIN?';
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
        Database.GetSQLSelectCmd(TableName, [
            TableName + '.' + Self.Id.FieldName,
            TableName + '.' + FUserName.FieldName,
            TableName + '.' + FUserPassword.FieldName,
            TableName + '.' + FAppVersion.FieldName,
            TableName + '.' + FIsAdmin.FieldName
          ]) +
          'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id.Value                 := FieldByName(Self.Id.FieldName).AsInteger;

		    Self.UserName.Value           := FieldByName(FUserName.FieldName).AsString;
        Self.UserPassword.Value       := FieldByName(FUserPassword.FieldName).AsString;
        Self.AppVersion.Value         := FieldByName(FAppVersion.FieldName).AsString;
        Self.IsAdmin.Value            := FieldByName(FIsAdmin.FieldName).AsBoolean;

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
		  SQL.Text := Self.Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FUserName.FieldName,
        FUserPassword.FieldName,
        FAppVersion.FieldName,
        FIsAdmin.FieldName
      ]);

      ParamByName(FUserName.FieldName).Value := Self.UserName.Value;
      ParamByName(FUserPassword.FieldName).Value := Self.UserPassword.Value;
      ParamByName(FAppVersion.FieldName).Value := Self.AppVersion.Value;
      ParamByName(FIsAdmin.FieldName).Value := Self.IsAdmin.Value;

		  Database.SetQueryParamsDefaultValue(QueryOfTable);

      Open;

      pID := 0;
      if (Fields.Count > 0) and (not Fields.FieldByName(Self.Id.FieldName).IsNull) then
        pID := Fields.FieldByName(Self.Id.FieldName).AsInteger;

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
		  SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FUserName.FieldName,
        FUserPassword.FieldName,
        FAppVersion.FieldName,
        FIsAdmin.FieldName
      ]);

      ParamByName(FUserName.FieldName).Value := Self.UserName.Value;
      ParamByName(FUserPassword.FieldName).Value := Self.UserPassword.Value;
      ParamByName(FAppVersion.FieldName).Value := Self.AppVersion.Value;
      ParamByName(FIsAdmin.FieldName).Value := Self.IsAdmin.Value;

      ParamByName(Self.Id.FieldName).Value := Self.Id.Value;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;

    self.notify;
  end;
end;

procedure TSysUser.Clear();
begin
  inherited;
  Self.UserName.Value := '';
  Self.UserPassword.Value := '';
  Self.AppVersion.Value := '';
  Self.IsAdmin.Value := False;
end;

function TSysUser.Clone():TTable;
begin
  Result := TSysUser.Create(Database);

  Self.Id.Clone(TSysUser(Result).Id);
  Self.FUserName.Clone(TSysUser(Result).FUserName);
  Self.FUserPassword.Clone(TSysUser(Result).FUserPassword);
  Self.FAppVersion.Clone(TSysUser(Result).FAppVersion);
  Self.FIsAdmin.Clone(TSysUser(Result).FIsAdmin);
end;

end.
