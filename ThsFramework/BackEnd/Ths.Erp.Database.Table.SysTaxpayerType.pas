unit Ths.Erp.Database.Table.SysTaxpayerType;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TSysTaxpayerType = class(TTable)
  private
    FTaxpayerType: TFieldDB;
    FIsDefault: TFieldDB;
  protected
    procedure BusinessInsert(out pID: Integer; var pPermissionControl: Boolean);
      override;
    procedure BusinessUpdate(pPermissionControl: Boolean); override;
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property TaxpayerType: TFieldDB read FTaxpayerType write FTaxpayerType;
    Property IsDefault: TFieldDB read FIsDefault write FIsDefault;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSysTaxpayerType.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_taxpayer_type';
  SourceCode := '1000';

  FTaxpayerType := TFieldDB.Create('taxpayer_type', ftString, '');
  FIsDefault := TFieldDB.Create('is_default', ftBoolean, False);
end;

procedure TSysTaxpayerType.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FTaxpayerType.FieldName,
        TableName + '.' + FIsDefault.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'Id';
      Self.DataSource.DataSet.FindField(FTaxpayerType.FieldName).DisplayLabel := 'Taxpayer Type';
      Self.DataSource.DataSet.FindField(FIsDefault.FieldName).DisplayLabel := 'Default?';
    end;
  end;
end;

procedure TSysTaxpayerType.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE OF ' + TableName + ' NOWAIT';

    with QueryOfList do
    begin
      Close;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FTaxpayerType.FieldName,
        TableName + '.' + FIsDefault.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FTaxpayerType.Value := FormatedVariantVal(FieldByName(FTaxpayerType.FieldName).DataType, FieldByName(FTaxpayerType.FieldName).Value);
        FIsDefault.Value := FormatedVariantVal(FieldByName(FIsDefault.FieldName).DataType, FieldByName(FIsDefault.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TSysTaxpayerType.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTaxpayerType.FieldName,
        FIsDefault.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FTaxpayerType);
      NewParamForQuery(QueryOfInsert, FIsDefault);

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

procedure TSysTaxpayerType.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTaxpayerType.FieldName, FIsDefault.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FTaxpayerType);
      NewParamForQuery(QueryOfUpdate, FIsDefault);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TSysTaxpayerType.BusinessInsert(out pID: Integer;
  var pPermissionControl: Boolean);
var
  mukellef: TSysTaxpayerType;
  n1: Integer;
begin
  if Self.IsDefault.Value then
  begin
    mukellef := TSysTaxpayerType.Create(Database);
    try
      mukellef.SelectToList('', False, False);
      for n1 := 0 to mukellef.List.Count-1 do
      begin
        TSysTaxpayerType(mukellef.List[n1]).IsDefault.Value := False;
        TSysTaxpayerType(mukellef.List[n1]).Update(pPermissionControl);
      end;
    finally
      mukellef.Free;
    end;
  end;
  Self.Insert(pID, pPermissionControl);
end;

procedure TSysTaxpayerType.BusinessUpdate(pPermissionControl: Boolean);
var
  mukellef: TSysTaxpayerType;
  n1: Integer;
begin
  if Self.IsDefault.Value then
  begin
    mukellef := TSysTaxpayerType.Create(Database);
    try
      mukellef.SelectToList('', False, False);
      for n1 := 0 to mukellef.List.Count-1 do
      begin
        TSysTaxpayerType(mukellef.List[n1]).IsDefault.Value := False;
        TSysTaxpayerType(mukellef.List[n1]).Update(pPermissionControl);
      end;
    finally
      mukellef.Free;
    end;
  end;
  Self.Update(pPermissionControl);
end;

function TSysTaxpayerType.Clone():TTable;
begin
  Result := TSysTaxpayerType.Create(Database);

  Self.Id.Clone(TSysTaxpayerType(Result).Id);

  FTaxpayerType.Clone(TSysTaxpayerType(Result).FTaxpayerType);
  FIsDefault.Clone(TSysTaxpayerType(Result).FIsDefault);
end;

end.
