unit Ths.Erp.Database.Table.SysUserAccessRight;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, StrUtils, RTTI, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TSysUserAccessRight = class(TTable)
  private
    FSourceCode           : TFieldDB;
    FIsRead               : TFieldDB;
    FIsAddRecord          : TFieldDB;
    FIsUpdate             : TFieldDB;
    FIsDelete             : TFieldDB;
    FIsSpecial            : TFieldDB;
    FUserName             : TFieldDB;
    //not a database field
    FSourceName           : TFieldDB;
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

    Property PermissionCode : TFieldDB read FSourceCode         write FSourceCode;
    Property IsRead         : TFieldDB read FIsRead             write FIsRead;
    Property IsAddRecord    : TFieldDB read FIsAddRecord        write FIsAddRecord;
    Property IsUpdate       : TFieldDB read FIsUpdate           write FIsUpdate;
    Property IsDelete       : TFieldDB read FIsDelete           write FIsDelete;
    Property IsSpecial      : TFieldDB read FIsSpecial          write FIsSpecial;
    Property UserName       : TFieldDB read FUserName           write FUserName;
    //not a database field
    Property SourceName     : TFieldDB read FSourceName         write FSourceName;
  end;

implementation

uses
  Ths.Erp.Constants, Ths.Erp.Database.Table.SysPermissionSource;

constructor TSysUserAccessRight.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_user_access_right';
  SourceCode := '1000';

  Self.FSourceCode := TFieldDB.Create('source_code', ftString, '');
  Self.FIsRead := TFieldDB.Create('is_read', ftBoolean, False);
  Self.FIsAddRecord := TFieldDB.Create('is_add_record', ftBoolean, False);
  Self.FIsUpdate := TFieldDB.Create('is_update', ftBoolean, False);
  Self.FIsDelete := TFieldDB.Create('is_delete', ftBoolean, False);
  Self.FIsSpecial := TFieldDB.Create('is_special', ftBoolean, False);
  Self.FUserName := TFieldDB.Create('user_name', ftString, '');
  Self.FSourceName := TFieldDB.Create('source_name', ftString, '');
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
		  SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FSourceCode.FieldName,
          TableName + '.' + FIsRead.FieldName,
          TableName + '.' + FIsAddRecord.FieldName,
          TableName + '.' + FIsUpdate.FieldName,
          TableName + '.' + FIsDelete.FieldName,
          TableName + '.' + FIsSpecial.FieldName,
          TableName + '.' + FUserName.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FSourceCode.FieldName).DisplayLabel := 'SOURCE CODE';
      Self.DataSource.DataSet.FindField(FIsRead.FieldName).DisplayLabel := 'READ?';
      Self.DataSource.DataSet.FindField(FIsAddRecord.FieldName).DisplayLabel := 'ADD RECORD?';
      Self.DataSource.DataSet.FindField(FIsUpdate.FieldName).DisplayLabel := 'UPDATE?';
      Self.DataSource.DataSet.FindField(FIsDelete.FieldName).DisplayLabel := 'DELETE?';
      Self.DataSource.DataSet.FindField(FIsSpecial.FieldName).DisplayLabel := 'SPECIAL?';
      Self.DataSource.DataSet.FindField(FUserName.FieldName).DisplayLabel := 'USER NAME';
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
		  SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FSourceCode.FieldName,
          TableName + '.' + FIsRead.FieldName,
          TableName + '.' + FIsAddRecord.FieldName,
          TableName + '.' + FIsUpdate.FieldName,
          TableName + '.' + FIsDelete.FieldName,
          TableName + '.' + FIsSpecial.FieldName,
          TableName + '.' + FUserName.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id.Value := FieldByName(Self.Id.FieldName).AsInteger;

		    Self.FSourceCode.Value := FieldByName(FSourceCode.FieldName).AsString;
        Self.FIsRead.Value := FieldByName(FIsRead.FieldName).AsBoolean;
        Self.FIsAddRecord.Value := FieldByName(FIsAddRecord.FieldName).AsBoolean;
        Self.FIsUpdate.Value := FieldByName(FIsUpdate.FieldName).AsBoolean;
        Self.FIsDelete.Value := FieldByName(FIsDelete.FieldName).AsBoolean;
        Self.FIsSpecial.Value := FieldByName(FIsSpecial.FieldName).AsBoolean;
        Self.FUserName.Value := FieldByName(FUserName.FieldName).AsString;

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
		  SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FSourceCode.FieldName,
        FIsRead.FieldName,
        FIsAddRecord.FieldName,
        FIsUpdate.FieldName,
        FIsDelete.FieldName,
        FIsSpecial.FieldName,
        FUserName.FieldName
      ]);

      ParamByName(FSourceCode.FieldName).Value := Self.FSourceCode.Value;
      ParamByName(FIsRead.FieldName).Value := Self.IsRead.Value;
      ParamByName(FIsAddRecord.FieldName).Value := Self.IsAddRecord.Value;
      ParamByName(FIsUpdate.FieldName).Value := Self.IsUpdate.Value;
      ParamByName(FIsDelete.FieldName).Value := Self.IsDelete.Value;
      ParamByName(FIsSpecial.FieldName).Value := Self.IsSpecial.Value;
      ParamByName(FUserName.FieldName).Value := Self.UserName.Value;

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

procedure TSysUserAccessRight.Update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FSourceCode.FieldName,
        FIsRead.FieldName,
        FIsAddRecord.FieldName,
        FIsUpdate.FieldName,
        FIsDelete.FieldName,
        FIsSpecial.FieldName,
        FUserName.FieldName
      ]);

      ParamByName(FSourceCode.FieldName).Value := Self.FSourceCode.Value;
      ParamByName(FIsRead.FieldName).Value := Self.FIsRead.Value;
      ParamByName(FIsAddRecord.FieldName).Value := Self.FIsAddRecord.Value;
      ParamByName(FIsUpdate.FieldName).Value := Self.FIsUpdate.Value;
      ParamByName(FIsDelete.FieldName).Value := Self.FIsDelete.Value;
      ParamByName(FIsSpecial.FieldName).Value := Self.FIsSpecial.Value;
      ParamByName(FUserName.FieldName).Value := Self.FUserName.Value;

		  ParamByName(Self.Id.FieldName).Value := Self.Id.Value;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;

    Self.notify;
  end;
end;

procedure TSysUserAccessRight.Clear();
begin
  inherited;
  Self.FSourceCode.Value := '';
  Self.FIsRead.Value := False;
  Self.FIsAddRecord.Value := False;
  Self.FIsUpdate.Value := False;
  Self.FIsDelete.Value := False;
  Self.FIsSpecial.Value := False;
  Self.FUserName.Value := '';
  //not a database field
  Self.FSourceName.Value := '';
end;

function TSysUserAccessRight.Clone():TTable;
begin
  Result := TSysUserAccessRight.Create(Database);

  Self.Id.Clone(TSysUserAccessRight(Result).Id);

  Self.FSourceCode.Clone(TSysUserAccessRight(Result).FSourceCode);
  Self.FIsRead.Clone(TSysUserAccessRight(Result).FIsRead);
  Self.FIsAddRecord.Clone(TSysUserAccessRight(Result).FIsAddRecord);
  Self.FIsUpdate.Clone(TSysUserAccessRight(Result).FIsUpdate);
  Self.FIsDelete.Clone(TSysUserAccessRight(Result).FIsDelete);
  Self.FIsSpecial.Clone(TSysUserAccessRight(Result).FIsSpecial);
  Self.FUserName.Clone(TSysUserAccessRight(Result).FUserName);
  //not a database field
  Self.FSourceName.Clone(TSysUserAccessRight(Result).FSourceName);
end;

end.
