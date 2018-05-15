unit Ths.Erp.Database.Table.SysUser;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, uSpecialFunctions,
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
  Self.PermissionSourceCode := '1002';
end;

procedure TSysUser.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(Self.PermissionSourceCode, ptRead, pPermissionControl, taSelect) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
      EmptyDataSet;
		  SQL.Clear;
		  SQL.Text :=
        Database.GetSQLSelectCmd(TableName,
          [TableName + '.id',
          TableName + '.validity',
          TableName + '.user_name',
          TableName + '.user_password',
          TableName + '.app_version',
          TableName + '.is_admin'])
        + ' WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.Fields[0].DisplayLabel := 'ID';
      Self.DataSource.DataSet.Fields[1].DisplayLabel := 'VALIDITY';
      Self.DataSource.DataSet.Fields[2].DisplayLabel := 'USER NAME';
      Self.DataSource.DataSet.Fields[3].DisplayLabel := 'USER PASSWORD';
      Self.DataSource.DataSet.Fields[4].DisplayLabel := 'APP VERSION';
      Self.DataSource.DataSet.Fields[5].DisplayLabel := 'ADMIN?';
	  end;
  end;
end;

procedure TSysUser.SelectToList(pFilter: string; pLock: Boolean;
  pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(Self.PermissionSourceCode, ptRead, pPermissionControl, taSelect) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Text :=
        Database.GetSQLSelectCmd(TableName,
          [TableName + '.id',
          TableName + '.validity',
          TableName + '.user_name',
          TableName + '.user_password',
          TableName + '.app_version',
          TableName + '.is_admin'])
        + ' WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id                 := FieldByName('id').AsInteger;
		    Self.Validity           := FieldByName('validity').AsBoolean;

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
  if Self.IsAuthorized(Self.PermissionSourceCode, ptWrite, pPermissionControl, taInsert) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text :=
      ' SELECT kullanici_insert(' +
          QuotedStr(Self.UserName) + ',' +
          QuotedStr(Self.UserPassword) + ',' +
          QuotedStr(Self.AppVersion) + ',' +
          QuotedStr(TSpecialFunctions.myBoolToStr(Self.IsAdmin)) +
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

procedure TSysUser.Update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(Self.PermissionSourceCode, ptWrite, pPermissionControl, taUpdate) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text :=
		  ' UPDATE ' + TableName + ' SET validity=:validity, ' +
        ' kullanici_adi=:kullanici_adi, sifre=:sifre, surum=:surum, is_yonetici=:is_yonetici ' +
		  ' WHERE id=:id;' ;

      if (Self.UserName <> '') then
        ParamByName('kullanici_adi').Value := Self.UserName;
      ParamByName('sifre').Value := Self.UserPassword;
      ParamByName('surum').Value := Self.AppVersion;
      ParamByName('is_yonetici').Value := Self.IsAdmin;

      ParamByName('validity').Value := Self.Validity;
      ParamByName('id').Value := Self.Id;

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
  TSysUser(Result).Validity          := Self.Validity;
  TSysUser(Result).PermissionSourceCode  := Self.PermissionSourceCode;
end;

end.
