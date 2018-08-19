unit Ths.Erp.Database.Table.AyarStokHareketTipi;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TAyarStokHareketTipi = class(TTable)
  private
    FDeger: TFieldDB;
    FIsInput: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property Deger: TFieldDB read FDeger write FDeger;
    Property IsInput: TFieldDB read FIsInput write FIsInput;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAyarStokHareketTipi.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ayar_stok_hareket_tipi';
  SourceCode := '1000';

  FDeger := TFieldDB.Create('deger', ftString, '');
  FIsInput := TFieldDB.Create('is_input', ftBoolean, False);
end;

procedure TAyarStokHareketTipi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        GetRawDataSQLByLang(TableName, FDeger.FieldName),
        TableName + '.' + Self.FIsInput.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FDeger.FieldName).DisplayLabel := 'Deðer';
      Self.DataSource.DataSet.FindField(FIsInput.FieldName).DisplayLabel := 'Input?';
    end;
  end;
end;

procedure TAyarStokHareketTipi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        GetRawDataSQLByLang(TableName, FDeger.FieldName),
        TableName + '.' + FIsInput.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FDeger.Value := FormatedVariantVal(FieldByName(FDeger.FieldName).DataType, FieldByName(FDeger.FieldName).Value);
        FIsInput.Value := FormatedVariantVal(FieldByName(FIsInput.FieldName).DataType, FieldByName(FIsInput.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAyarStokHareketTipi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FDeger.FieldName,
        FIsInput.FieldName
      ]);

      NewParamForQuery(QueryOfTable, FDeger);
      NewParamForQuery(QueryOfTable, FIsInput);
      
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

procedure TAyarStokHareketTipi.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FDeger.FieldName,
        FIsInput.FieldName
      ]);

      NewParamForQuery(QueryOfTable, FDeger);
      NewParamForQuery(QueryOfTable, FIsInput);

      NewParamForQuery(QueryOfTable, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TAyarStokHareketTipi.Clear();
begin
  inherited;

  FDeger.Value := '';
  FIsInput.Value := False;
end;

function TAyarStokHareketTipi.Clone():TTable;
begin
  Result := TAyarStokHareketTipi.Create(Database);

  Self.Id.Clone(TAyarStokHareketTipi(Result).Id);

  FDeger.Clone(TAyarStokHareketTipi(Result).FDeger);
  FIsInput.Clone(TAyarStokHareketTipi(Result).FIsInput);
end;

end.
