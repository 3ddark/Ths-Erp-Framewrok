unit Ths.Erp.Database.Table.StokTipi;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TStokTipi = class(TTable)
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

    procedure Clear();override;
    function Clone():TTable;override;

    Property Tip: TFieldDB read FTip write FTip;
    Property IsDefault: TFieldDB read FIsDefault write FIsDefault;
    Property IsStokHareketiYap: TFieldDB read FIsStokHareketiYap write FIsStokHareketiYap;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TStokTipi.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'stok_tipi';
  SourceCode := '1000';

  FTip := TFieldDB.Create('tip', ftString, '');
  FIsDefault := TFieldDB.Create('is_default', ftBoolean, 0);
  FIsStokHareketiYap := TFieldDB.Create('is_stok_hareketi_yap', ftBoolean, 0);
end;

procedure TStokTipi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FTip.FieldName,
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

procedure TStokTipi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
      pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

    with QueryOfTable do
    begin
      Close;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FTip.FieldName,
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

procedure TStokTipi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTip.FieldName,
        FIsDefault.FieldName,
        FIsStokHareketiYap.FieldName
      ]);

      ParamByName(FTip.FieldName).Value := FormatedVariantVal(FTip.FieldType, FTip.Value);
      ParamByName(FIsDefault.FieldName).Value := FormatedVariantVal(FIsDefault.FieldType, FIsDefault.Value);
      ParamByName(FIsStokHareketiYap.FieldName).Value := FormatedVariantVal(FIsStokHareketiYap.FieldType, FIsStokHareketiYap.Value);

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

procedure TStokTipi.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTip.FieldName,
        FIsDefault.FieldName,
        FIsStokHareketiYap.FieldName
      ]);

      ParamByName(FTip.FieldName).Value := FormatedVariantVal(FTip.FieldType, FTip.Value);
      ParamByName(FIsDefault.FieldName).Value := FormatedVariantVal(FIsDefault.FieldType, FIsDefault.Value);
      ParamByName(FIsStokHareketiYap.FieldName).Value := FormatedVariantVal(FIsStokHareketiYap.FieldType, FIsStokHareketiYap.Value);

      ParamByName(Self.Id.FieldName).Value := FormatedVariantVal(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TStokTipi.BusinessInsert(out pID: Integer;
  var pPermissionControl: Boolean);
var
  vStokTipi: TStokTipi;
  n1: Integer;
begin
  if FormatedVariantVal(Self.IsDefault.FieldType, Self.IsDefault.Value) = True then
  begin
    vStokTipi := TStokTipi.Create(Database);
    try
      vStokTipi.SelectToList(' and ' + vStokTipi.TableName + '.' + vStokTipi.FIsDefault.FieldName + '=True', False, False);
      for n1 := 0 to vStokTipi.List.Count-1 do
      begin
        TStokTipi(vStokTipi.List[n1]).IsDefault.Value := False;
        TStokTipi(vStokTipi.List[n1]).Update();
      end;
    finally
      vStokTipi.Free;
    end;
    Self.Insert(pID);
  end
  else
    Self.Insert(pID);
end;

procedure TStokTipi.BusinessUpdate(pPermissionControl: Boolean);
var
  vStokTipi: TStokTipi;
  n1: Integer;
begin
  if FormatedVariantVal(Self.IsDefault.FieldType, Self.IsDefault.Value) = True then
  begin
    vStokTipi := TStokTipi.Create(Database);
    try
      vStokTipi.SelectToList(' and ' + vStokTipi.TableName + '.' + vStokTipi.FIsDefault.FieldName + '=True', False, False);
      for n1 := 0 to vStokTipi.List.Count-1 do
      begin
        TStokTipi(vStokTipi.List[n1]).IsDefault.Value := False;
        TStokTipi(vStokTipi.List[n1]).Update();
      end;
    finally
      vStokTipi.Free;
    end;
    Self.Update();
  end
  else
    Self.Update;
end;

procedure TStokTipi.Clear();
begin
  inherited;

  FTip.Value := '';
  FIsDefault.Value := 0;
  FIsStokHareketiYap.Value := 0;
end;

function TStokTipi.Clone():TTable;
begin
  Result := TStokTipi.Create(Database);

  Self.Id.Clone(TStokTipi(Result).Id);

  FTip.Clone(TStokTipi(Result).FTip);
  FIsDefault.Clone(TStokTipi(Result).FIsDefault);
  FIsStokHareketiYap.Clone(TStokTipi(Result).FIsStokHareketiYap);
end;

end.
