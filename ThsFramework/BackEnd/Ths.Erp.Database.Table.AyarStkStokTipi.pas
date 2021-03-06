unit Ths.Erp.Database.Table.AyarStkStokTipi;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TAyarStkStokTipi = class(TTable)
  private
    FTip: TFieldDB;
    FIsDefault: TFieldDB;
    FIsStokHareketiYap: TFieldDB;
  protected
    procedure BusinessInsert(out pID: Integer; var pPermissionControl: Boolean); override;
    procedure BusinessUpdate(pPermissionControl: Boolean); override;
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property Tip: TFieldDB read FTip write FTip;
    Property IsDefault: TFieldDB read FIsDefault write FIsDefault;
    Property IsStokHareketiYap: TFieldDB read FIsStokHareketiYap write FIsStokHareketiYap;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAyarStkStokTipi.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ayar_stk_stok_tipi';
  SourceCode := '1000';

  FTip := TFieldDB.Create('tip', ftString, '');
  FIsDefault := TFieldDB.Create('is_default', ftBoolean, 0);
  FIsStokHareketiYap := TFieldDB.Create('is_stok_hareketi_yap', ftBoolean, 0);
end;

procedure TAyarStkStokTipi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        getRawDataByLang(TableName, FTip.FieldName),
        TableName + '.' + FIsDefault.FieldName,
        TableName + '.' + FIsStokHareketiYap.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FTip.FieldName).DisplayLabel := 'Tip';
      Self.DataSource.DataSet.FindField(FIsDefault.FieldName).DisplayLabel := 'Default?';
      Self.DataSource.DataSet.FindField(FIsStokHareketiYap.FieldName).DisplayLabel := 'Stok Hareketi Yap?';
    end;
  end;
end;

procedure TAyarStkStokTipi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        getRawDataByLang(TableName, FTip.FieldName),
        TableName + '.' + FIsDefault.FieldName,
        TableName + '.' + FIsStokHareketiYap.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FTip.Value := FormatedVariantVal(FieldByName(FTip.FieldName).DataType, FieldByName(FTip.FieldName).Value);
        FIsDefault.Value := FormatedVariantVal(FieldByName(FIsDefault.FieldName).DataType, FieldByName(FIsDefault.FieldName).Value);
        FIsStokHareketiYap.Value := FormatedVariantVal(FieldByName(FIsStokHareketiYap.FieldName).DataType, FieldByName(FIsStokHareketiYap.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAyarStkStokTipi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTip.FieldName,
        FIsDefault.FieldName,
        FIsStokHareketiYap.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FTip);
      NewParamForQuery(QueryOfInsert, FIsDefault);
      NewParamForQuery(QueryOfInsert, FIsStokHareketiYap);

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

procedure TAyarStkStokTipi.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTip.FieldName,
        FIsDefault.FieldName,
        FIsStokHareketiYap.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FTip);
      NewParamForQuery(QueryOfUpdate, FIsDefault);
      NewParamForQuery(QueryOfUpdate, FIsStokHareketiYap);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TAyarStkStokTipi.BusinessInsert(out pID: Integer;
  var pPermissionControl: Boolean);
var
  vStokTipi: TAyarStkStokTipi;
  n1: Integer;
begin
  if FormatedVariantVal(Self.IsDefault.FieldType, Self.IsDefault.Value) = True then
  begin
    vStokTipi := TAyarStkStokTipi.Create(Database);
    try
      vStokTipi.SelectToList(' and ' + vStokTipi.TableName + '.' + vStokTipi.FIsDefault.FieldName + '=True', False, False);
      for n1 := 0 to vStokTipi.List.Count-1 do
      begin
        TAyarStkStokTipi(vStokTipi.List[n1]).IsDefault.Value := False;
        TAyarStkStokTipi(vStokTipi.List[n1]).Update();
      end;
    finally
      vStokTipi.Free;
    end;
    Self.Insert(pID);
  end
  else
    Self.Insert(pID);
end;

procedure TAyarStkStokTipi.BusinessUpdate(pPermissionControl: Boolean);
var
  vStokTipi: TAyarStkStokTipi;
  n1: Integer;
begin
  if FormatedVariantVal(Self.IsDefault.FieldType, Self.IsDefault.Value) = True then
  begin
    vStokTipi := TAyarStkStokTipi.Create(Database);
    try
      vStokTipi.SelectToList(' and ' + vStokTipi.TableName + '.' + vStokTipi.FIsDefault.FieldName + '=True', False, False);
      for n1 := 0 to vStokTipi.List.Count-1 do
      begin
        TAyarStkStokTipi(vStokTipi.List[n1]).IsDefault.Value := False;
        TAyarStkStokTipi(vStokTipi.List[n1]).Update();
      end;
    finally
      vStokTipi.Free;
    end;
    Self.Update();
  end
  else
    Self.Update;
end;

function TAyarStkStokTipi.Clone():TTable;
begin
  Result := TAyarStkStokTipi.Create(Database);

  Self.Id.Clone(TAyarStkStokTipi(Result).Id);

  FTip.Clone(TAyarStkStokTipi(Result).FTip);
  FIsDefault.Clone(TAyarStkStokTipi(Result).FIsDefault);
  FIsStokHareketiYap.Clone(TAyarStkStokTipi(Result).FIsStokHareketiYap);
end;

end.
