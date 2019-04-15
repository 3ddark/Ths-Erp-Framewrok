unit Ths.Erp.Database.Table.SysUser;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, Data.DB,
  Ths.Erp.Constants,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TSysUser = class(TTable)
  private
    FUserName: TFieldDB;
    FUserPassword: TFieldDB;
    FAppVersion: TFieldDB;
    FIsAdmin: TFieldDB;
    FIsSuperUser: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase: TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    property UserName: TFieldDB read FUserName write FUserName;
    property UserPassword: TFieldDB read FUserPassword write FUserPassword;
    property AppVersion: TFieldDB read FAppVersion write FAppVersion;
    property IsAdmin: TFieldDB read FIsAdmin write FIsAdmin;
    property IsSuperUser: TFieldDB read FIsSuperUser write FIsSuperUser;
  end;

implementation

uses
  Ths.Erp.Database.Singleton;

constructor TSysUser.Create(OwnerDatabase: TDatabase);
begin
  inherited;
  TableName := 'sys_user';
  SourceCode := '1';

  FUserName := TFieldDB.Create('user_name', ftString, '');
  FUserPassword := TFieldDB.Create('user_password', ftString, '');
  FAppVersion := TFieldDB.Create('app_version', ftString, '');
  FIsAdmin := TFieldDB.Create('is_admin', ftBoolean, False);
  FIsSuperUser := TFieldDB.Create('is_super_user', ftBoolean, False);
end;

procedure TSysUser.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfDS do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text :=
        Database.GetSQLSelectCmd(TableName, [
            TableName + '.' + Self.Id.FieldName,
            TableName + '.' + FUserName.FieldName,
            TableName + '.' + FUserPassword.FieldName,
            TableName + '.' + FAppVersion.FieldName,
            TableName + '.' + FIsAdmin.FieldName,
            TableName + '.' + FIsSuperUser.FieldName
          ]) +
          'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FUserName.FieldName).DisplayLabel := 'USER NAME';
      Self.DataSource.DataSet.FindField(FUserPassword.FieldName).DisplayLabel := 'USER PASSWORD';
      Self.DataSource.DataSet.FindField(FAppVersion.FieldName).DisplayLabel := 'APP VERSION';
      Self.DataSource.DataSet.FindField(FIsAdmin.FieldName).DisplayLabel := 'ADMIN?';
      Self.DataSource.DataSet.FindField(FIsSuperUser.FieldName).DisplayLabel := 'SUPER USER?';
	  end;
  end;
end;

procedure TSysUser.SelectToList(pFilter: string; pLock: Boolean;
  pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE OF ' + TableName + ' NOWAIT';

	  with QueryOfList do
	  begin
		  Close;
		  SQL.Text :=
        Database.GetSQLSelectCmd(TableName, [
            TableName + '.' + Self.Id.FieldName,
            TableName + '.' + FUserName.FieldName,
            TableName + '.' + FUserPassword.FieldName,
            TableName + '.' + FAppVersion.FieldName,
            TableName + '.' + FIsAdmin.FieldName,
            TableName + '.' + FIsSuperUser.FieldName
          ]) +
          'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

		    FUserName.Value := FormatedVariantVal(FieldByName(FUserName.FieldName).DataType, FieldByName(FUserName.FieldName).Value);
        FUserPassword.Value := FormatedVariantVal(FieldByName(FUserPassword.FieldName).DataType, FieldByName(FUserPassword.FieldName).Value);
        FAppVersion.Value := FormatedVariantVal(FieldByName(FAppVersion.FieldName).DataType, FieldByName(FAppVersion.FieldName).Value);
        FIsAdmin.Value := FormatedVariantVal(FieldByName(FIsAdmin.FieldName).DataType, FieldByName(FIsAdmin.FieldName).Value);
        FIsSuperUser.Value := FormatedVariantVal(FieldByName(FIsSuperUser.FieldName).DataType, FieldByName(FIsSuperUser.FieldName).Value);

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
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfInsert do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FUserName.FieldName,
        FUserPassword.FieldName,
        FAppVersion.FieldName,
        FIsAdmin.FieldName,
        FIsSuperUser.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FUserName);
      NewParamForQuery(QueryOfInsert, FUserPassword);
      NewParamForQuery(QueryOfInsert, FAppVersion);
      NewParamForQuery(QueryOfInsert, FIsAdmin);
      NewParamForQuery(QueryOfInsert, FIsSuperUser);

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
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfUpdate do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FUserName.FieldName,
        FUserPassword.FieldName,
        FAppVersion.FieldName,
        FIsAdmin.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FUserName);
      NewParamForQuery(QueryOfUpdate, FUserPassword);
      NewParamForQuery(QueryOfUpdate, FAppVersion);
      NewParamForQuery(QueryOfUpdate, FIsAdmin);
      NewParamForQuery(QueryOfUpdate, FIsSuperUser);

      NewParamForQuery(QueryOfUpdate, Id);

		  ExecSQL;
		  Close;
	  end;

    self.notify;
  end;
end;

function TSysUser.Clone():TTable;
begin
  Result := TSysUser.Create(Database);

  Self.Id.Clone(TSysUser(Result).Id);

  FUserName.Clone(TSysUser(Result).FUserName);
  FUserPassword.Clone(TSysUser(Result).FUserPassword);
  FAppVersion.Clone(TSysUser(Result).FAppVersion);
  FIsAdmin.Clone(TSysUser(Result).FIsAdmin);
  FIsSuperUser.Clone(TSysUser(Result).FIsSuperUser);
end;

end.
