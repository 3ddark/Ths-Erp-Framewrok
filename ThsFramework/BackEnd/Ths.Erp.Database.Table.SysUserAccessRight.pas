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
    FSourceCode: TFieldDB;
    FIsRead: TFieldDB;
    FIsAddRecord: TFieldDB;
    FIsUpdate: TFieldDB;
    FIsDelete: TFieldDB;
    FIsSpecial: TFieldDB;
    FUserName: TFieldDB;
    //not a database field
    FSourceName: TFieldDB;
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

    Property PermissionCode: TFieldDB read FSourceCode write FSourceCode;
    Property IsRead: TFieldDB read FIsRead write FIsRead;
    Property IsAddRecord: TFieldDB read FIsAddRecord write FIsAddRecord;
    Property IsUpdate: TFieldDB read FIsUpdate write FIsUpdate;
    Property IsDelete: TFieldDB read FIsDelete write FIsDelete;
    Property IsSpecial: TFieldDB read FIsSpecial write FIsSpecial;
    Property UserName: TFieldDB read FUserName write FUserName;
    //not a database field
    Property SourceName     : TFieldDB read FSourceName         write FSourceName;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSysUserAccessRight.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_user_access_right';
  SourceCode := '1';

  FSourceCode := TFieldDB.Create('source_code', ftString, '');
  FIsRead := TFieldDB.Create('is_read', ftBoolean, False);
  FIsAddRecord := TFieldDB.Create('is_add_record', ftBoolean, False);
  FIsUpdate := TFieldDB.Create('is_update', ftBoolean, False);
  FIsDelete := TFieldDB.Create('is_delete', ftBoolean, False);
  FIsSpecial := TFieldDB.Create('is_special', ftBoolean, False);
  FUserName := TFieldDB.Create('user_name', ftString, '');
  FSourceName := TFieldDB.Create('source_name', ftString, '');
end;

procedure TSysUserAccessRight.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfDS do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FSourceCode.FieldName,
          'ps.' + FSourceName.FieldName,
          TableName + '.' + FIsRead.FieldName,
          TableName + '.' + FIsAddRecord.FieldName,
          TableName + '.' + FIsUpdate.FieldName,
          TableName + '.' + FIsDelete.FieldName,
          TableName + '.' + FIsSpecial.FieldName,
          TableName + '.' + FUserName.FieldName
        ]) +
        'JOIN sys_permission_source ps ON ps.source_code=' + TableName + '.' + FSourceCode.FieldName + ' ' +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FSourceCode.FieldName).DisplayLabel := 'SOURCE CODE';
      Self.DataSource.DataSet.FindField(FSourceName.FieldName).DisplayLabel := 'SOURCE NAME';
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
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfList do
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
		    Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

		    FSourceCode.Value := FormatedVariantVal(FieldByName(FSourceCode.FieldName).DataType, FieldByName(FSourceCode.FieldName).Value);
        FIsRead.Value := FormatedVariantVal(FieldByName(FIsRead.FieldName).DataType, FieldByName(FIsRead.FieldName).Value);
        FIsAddRecord.Value := FormatedVariantVal(FieldByName(FIsAddRecord.FieldName).DataType, FieldByName(FIsAddRecord.FieldName).Value);
        FIsUpdate.Value := FormatedVariantVal(FieldByName(FIsUpdate.FieldName).DataType, FieldByName(FIsUpdate.FieldName).Value);
        FIsDelete.Value := FormatedVariantVal(FieldByName(FIsDelete.FieldName).DataType, FieldByName(FIsDelete.FieldName).Value);
        FIsSpecial.Value := FormatedVariantVal(FieldByName(FIsSpecial.FieldName).DataType, FieldByName(FIsSpecial.FieldName).Value);
        FUserName.Value := FormatedVariantVal(FieldByName(FUserName.FieldName).DataType, FieldByName(FUserName.FieldName).Value);

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
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfInsert do
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

      NewParamForQuery(QueryOfInsert, FSourceCode);
      NewParamForQuery(QueryOfInsert, FIsRead);
      NewParamForQuery(QueryOfInsert, FIsAddRecord);
      NewParamForQuery(QueryOfInsert, FIsUpdate);
      NewParamForQuery(QueryOfInsert, FIsDelete);
      NewParamForQuery(QueryOfInsert, FIsSpecial);
      NewParamForQuery(QueryOfInsert, FUserName);

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
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfUpdate do
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

      NewParamForQuery(QueryOfUpdate, FSourceCode);
      NewParamForQuery(QueryOfUpdate, FIsRead);
      NewParamForQuery(QueryOfUpdate, FIsAddRecord);
      NewParamForQuery(QueryOfUpdate, FIsUpdate);
      NewParamForQuery(QueryOfUpdate, FIsDelete);
      NewParamForQuery(QueryOfUpdate, FIsSpecial);
      NewParamForQuery(QueryOfUpdate, FUserName);

		  NewParamForQuery(QueryOfUpdate, Id);

		  ExecSQL;
		  Close;
	  end;

    Self.notify;
  end;
end;

procedure TSysUserAccessRight.Clear();
begin
  inherited;
  FSourceCode.Value := '';
  FIsRead.Value := False;
  FIsAddRecord.Value := False;
  FIsUpdate.Value := False;
  FIsDelete.Value := False;
  FIsSpecial.Value := False;
  FUserName.Value := '';
  //not a database field
  FSourceName.Value := '';
end;

function TSysUserAccessRight.Clone():TTable;
begin
  Result := TSysUserAccessRight.Create(Database);

  Id.Clone(TSysUserAccessRight(Result).Id);

  FSourceCode.Clone(TSysUserAccessRight(Result).FSourceCode);
  FIsRead.Clone(TSysUserAccessRight(Result).FIsRead);
  FIsAddRecord.Clone(TSysUserAccessRight(Result).FIsAddRecord);
  FIsUpdate.Clone(TSysUserAccessRight(Result).FIsUpdate);
  FIsDelete.Clone(TSysUserAccessRight(Result).FIsDelete);
  FIsSpecial.Clone(TSysUserAccessRight(Result).FIsSpecial);
  FUserName.Clone(TSysUserAccessRight(Result).FUserName);
  //not a database field
  FSourceName.Clone(TSysUserAccessRight(Result).FSourceName);
end;

end.
