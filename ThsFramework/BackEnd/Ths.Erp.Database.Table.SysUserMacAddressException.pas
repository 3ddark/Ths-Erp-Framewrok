unit Ths.Erp.Database.Table.SysUserMacAddressException;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TSysUserMacAddressException = class(TTable)
  private
    FUserName: TFieldDB;
    FIpAddress: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property UserName: TFieldDB read FUserName write FUserName;
    Property IpAddress: TFieldDB read FIpAddress write FIpAddress;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSysUserMacAddressException.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_user_mac_address_exception';
  SourceCode := '1';

  FUserName := TFieldDB.Create('user_name', ftString, '');
  FIpAddress := TFieldDB.Create('ip_address', ftString, '');
end;

procedure TSysUserMacAddressException.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FUserName.FieldName,
        TableName + '.' + FIpAddress.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FUserName.FieldName).DisplayLabel := 'User Name';
      Self.DataSource.DataSet.FindField(FIpAddress.FieldName).DisplayLabel := 'Ip Address';
    end;
  end;
end;

procedure TSysUserMacAddressException.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FUserName.FieldName,
        TableName + '.' + FIpAddress.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FUserName.Value := FormatedVariantVal(FieldByName(FUserName.FieldName).DataType, FieldByName(FUserName.FieldName).Value);
        FIpAddress.Value := FormatedVariantVal(FieldByName(FIpAddress.FieldName).DataType, FieldByName(FIpAddress.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TSysUserMacAddressException.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FUserName.FieldName,
        FIpAddress.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FUserName);
      NewParamForQuery(QueryOfInsert, FIpAddress);

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

procedure TSysUserMacAddressException.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FUserName.FieldName,
        FIpAddress.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FUserName);
      NewParamForQuery(QueryOfUpdate, FIpAddress);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TSysUserMacAddressException.Clone():TTable;
begin
  Result := TSysUserMacAddressException.Create(Database);

  Self.Id.Clone(TSysUserMacAddressException(Result).Id);

  FUserName.Clone(TSysUserMacAddressException(Result).FUserName);
  FIpAddress.Clone(TSysUserMacAddressException(Result).FIpAddress);
end;

end.
