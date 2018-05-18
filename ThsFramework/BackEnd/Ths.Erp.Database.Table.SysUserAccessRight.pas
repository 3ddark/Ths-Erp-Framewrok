unit Ths.Erp.Database.Table.SysUserAccessRight;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, StrUtils,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TSysUserAccessRight = class(TTable)
  private
    FPermissionSourceCode : string;
    FIsRead               : Boolean;
    FIsAddRecord          : Boolean;
    FIsUpdate             : Boolean;
    FIsDelete             : Boolean;
    FIsSpecial            : Boolean;
    FUserName             : string;
    //not a database field
    FSourceName           : string;
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

    Property PermissionCode : string   read FPermissionSourceCode write FPermissionSourceCode;
    Property IsRead         : Boolean  read FIsRead             write FIsRead;
    Property IsAddRecord    : Boolean  read FIsAddRecord        write FIsAddRecord;
    Property IsUpdate       : Boolean  read FIsUpdate           write FIsUpdate;
    Property IsDelete       : Boolean  read FIsDelete           write FIsDelete;
    Property IsSpecial      : Boolean  read FIsSpecial          write FIsSpecial;
    Property UserName       : string   read FUserName           write FUserName;
    //not a database field
    Property SourceName     : string   read FSourceName         write FSourceName;
  end;

implementation

uses
  Ths.Erp.Constants;

constructor TSysUserAccessRight.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_user_access_right';
end;

procedure TSysUserAccessRight.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLSelectCmd(TableName,
        [TableName + '.id',
        TableName + '.permission_source_code',
        TableName + '.is_read',
        TableName + '.is_add_record',
        TableName + '.is_update',
        TableName + '.is_delete',
        TableName + '.is_special',
        TableName + '.user_name']) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField('id').DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField('permission_source_code').DisplayLabel := 'SOURCE CODE';
      Self.DataSource.DataSet.FindField('is_read').DisplayLabel := 'READ?';
      Self.DataSource.DataSet.FindField('is_add_record').DisplayLabel := 'ADD RECORD?';
      Self.DataSource.DataSet.FindField('is_update').DisplayLabel := 'UPDATE?';
      Self.DataSource.DataSet.FindField('is_delete').DisplayLabel := 'DELETE?';
      Self.DataSource.DataSet.FindField('is_special').DisplayLabel := 'SPECIAL?';
      Self.DataSource.DataSet.FindField('user_name').DisplayLabel := 'USER NAME';
	  end;
  end;
end;

procedure TSysUserAccessRight.SelectToList(pFilter: string; pLock:
  Boolean; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Text := Database.GetSQLSelectCmd(TableName,
        [TableName + '.id',
        TableName + '.permission_source_code',
        TableName + '.is_read',
        TableName + '.is_add_record',
        TableName + '.is_update',
        TableName + '.is_delete',
        TableName + '.is_special',
        TableName + '.user_name']) +
        'WHERE 1=1 ' + pFilter;
		  ExecSQL;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id               := FieldByName('id').AsInteger;

		    Self.FPermissionSourceCode := FieldByName('permission_source_code').AsString;
        Self.FIsRead := FieldByName('is_read').AsBoolean;
        Self.FIsAddRecord := FieldByName('is_add_record').AsBoolean;
        Self.FIsUpdate := FieldByName('is_update').AsBoolean;
        Self.FIsDelete := FieldByName('is_delete').AsBoolean;
        Self.FUserName := FieldByName('user_name').AsString;

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TSysUserAccessRight.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLInsertCmd(TableName, SQL_PARAM_SEPERATE,
        ['permission_source_code', 'is_read', 'is_add_record', 'is_update',
        'is_delete', 'is_special', 'user_name']);

      ParamByName('permission_source_code').Value := Self.PermissionCode;
      ParamByName('is_read').Value := Self.IsRead;
      ParamByName('is_add_record').Value := Self.IsAddRecord;
      ParamByName('is_update').Value := Self.IsUpdate;
      ParamByName('is_delete').Value := Self.IsDelete;
      ParamByName('is_special').Value := Self.IsSpecial;
      ParamByName('user_name').Value := Self.UserName;

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

procedure TSysUserAccessRight.Update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLUpdateCmd(TableName, SQL_PARAM_SEPERATE,
      ['permission_source_code',
      'is_read',
      'is_add_record',
      'is_update',
      'is_delete',
      'is_special',
      'user_name']);

	    ParamByName('permission_source_code').Value := Self.FPermissionSourceCode;
      ParamByName('is_read').Value := Self.FIsRead;
      ParamByName('is_add_record').Value := Self.FIsAddRecord;
      ParamByName('is_update').Value := Self.FIsUpdate;
      ParamByName('is_delete').Value := Self.FIsDelete;
      ParamByName('is_special').Value := Self.FIsSpecial;
	    ParamByName('user_name').Value := Self.FUserName;

		  ParamByName('id').Value       := Self.Id;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  EmptyDataSet;
		  Close;
	  end;

    Self.notify;
  end;
end;

procedure TSysUserAccessRight.Clear();
begin
  inherited;
  Self.FPermissionSourceCode := '';
  Self.FIsRead := False;
  Self.FIsAddRecord := False;
  Self.FIsUpdate := False;
  Self.FIsDelete := False;
  Self.FIsSpecial := False;
  Self.FUserName := '';
end;

function TSysUserAccessRight.Clone():TTable;
begin
  Result := TSysUserAccessRight.Create(Database);

  TSysUserAccessRight(Result).FPermissionSourceCode  := Self.FPermissionSourceCode;
  TSysUserAccessRight(Result).FIsRead          := Self.FIsRead;
  TSysUserAccessRight(Result).FIsAddRecord     := Self.FIsAddRecord;
  TSysUserAccessRight(Result).FIsUpdate        := Self.FIsUpdate;
  TSysUserAccessRight(Result).FIsDelete        := Self.FIsDelete;
  TSysUserAccessRight(Result).FIsSpecial       := Self.FIsSpecial;
  TSysUserAccessRight(Result).FUserName        := Self.FUserName;

  TSysUserAccessRight(Result).Id                    := Self.Id;
end;

end.
