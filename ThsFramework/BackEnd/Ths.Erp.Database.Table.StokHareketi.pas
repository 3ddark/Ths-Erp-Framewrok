unit Ths.Erp.Database.Table.StokHareketi;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TStokHareketi = class(TTable)
  private
    FStokKodu: TFieldDB;
    FMiktar: TFieldDB;
    FTutar: TFieldDB;
    FGirisCikisTipID: TFieldDB;
    FTarih: TFieldDB;
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

    Property StokKodu: TFieldDB read FStokKodu write FStokKodu;
    Property Miktar: TFieldDB read FMiktar write FMiktar;
    Property Tutar: TFieldDB read FTutar write FTutar;
    Property GirisCikisTipID: TFieldDB read FGirisCikisTipID write FGirisCikisTipID;
    Property Tarih: TFieldDB read FTarih write FTarih;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton, Ths.Erp.Database.Table.AyarStokHareketTipi;

constructor TStokHareketi.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'stok_hareketi';
  SourceCode := '1000';

  FStokKodu := TFieldDB.Create('stok_kodu', ftString, '');
  FMiktar := TFieldDB.Create('miktar', ftFloat, 0);
  FTutar := TFieldDB.Create('tutar', ftFloat, 0);
  FGirisCikisTipID := TFieldDB.Create('giris_cikis_tip_id', ftInteger, 0);
  FTarih := TFieldDB.Create('tarih', ftDateTime, 0);
end;

procedure TStokHareketi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
var
  vStokHareketTipi: TAyarStokHareketTipi;
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      vStokHareketTipi := TAyarStokHareketTipi.Create(Self.Database);
      try
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FStokKodu.FieldName,
          TableName + '.' + FMiktar.FieldName,
          TableName + '.' + FTutar.FieldName,
          TableName + '.' + FGirisCikisTipID.FieldName,
          ColumnFromIDCol(vStokHareketTipi.Deger.FieldName, vStokHareketTipi.TableName, FGirisCikisTipID.FieldName, 'hareket_tipi'),
          TableName + '.' + FTarih.FieldName+'::date'
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;
        Active := True;

        Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
        Self.DataSource.DataSet.FindField(FStokKodu.FieldName).DisplayLabel := 'Stok Kodu';
        Self.DataSource.DataSet.FindField(FMiktar.FieldName).DisplayLabel := 'Miktar';
        Self.DataSource.DataSet.FindField(FTutar.FieldName).DisplayLabel := 'Tutar';
        Self.DataSource.DataSet.FindField(FGirisCikisTipID.FieldName).DisplayLabel := 'Giriþ Çýkýþ Tip ID';
        Self.DataSource.DataSet.FindField('hareket_tipi').DisplayLabel := 'Hareket Tipi';
        Self.DataSource.DataSet.FindField(FTarih.FieldName).DisplayLabel := 'Tarih';
      finally
        vStokHareketTipi.Free;
      end;
    end;
  end;
end;

procedure TStokHareketi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FStokKodu.FieldName,
        TableName + '.' + FMiktar.FieldName,
        TableName + '.' + FTutar.FieldName,
        TableName + '.' + FGirisCikisTipID.FieldName,
        TableName + '.' + FTarih.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FStokKodu.Value := FormatedVariantVal(FieldByName(FStokKodu.FieldName).DataType, FieldByName(FStokKodu.FieldName).Value);
        FMiktar.Value := FormatedVariantVal(FieldByName(FMiktar.FieldName).DataType, FieldByName(FMiktar.FieldName).Value);
        FTutar.Value := FormatedVariantVal(FieldByName(FTutar.FieldName).DataType, FieldByName(FTutar.FieldName).Value);
        FGirisCikisTipID.Value := FormatedVariantVal(FieldByName(FGirisCikisTipID.FieldName).DataType, FieldByName(FGirisCikisTipID.FieldName).Value);
        FTarih.Value := FormatedVariantVal(FieldByName(FTarih.FieldName).DataType, FieldByName(FTarih.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TStokHareketi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FStokKodu.FieldName,
        FMiktar.FieldName,
        FTutar.FieldName,
        FGirisCikisTipID.FieldName,
        FTarih.FieldName
      ]);

      ParamByName(FStokKodu.FieldName).Value := FormatedVariantVal(FStokKodu.FieldType, FStokKodu.Value);
      ParamByName(FMiktar.FieldName).Value := FormatedVariantVal(FMiktar.FieldType, FMiktar.Value);
      ParamByName(FTutar.FieldName).Value := FormatedVariantVal(FTutar.FieldType, FTutar.Value);
      ParamByName(FGirisCikisTipID.FieldName).Value := FormatedVariantVal(FGirisCikisTipID.FieldType, FGirisCikisTipID.Value);
      ParamByName(FTarih.FieldName).Value := FormatedVariantVal(FTarih.FieldType, FTarih.Value);

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

procedure TStokHareketi.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FStokKodu.FieldName,
        FMiktar.FieldName,
        FTutar.FieldName,
        FGirisCikisTipID.FieldName,
        FTarih.FieldName
      ]);

      ParamByName(FStokKodu.FieldName).Value := FormatedVariantVal(FStokKodu.FieldType, FStokKodu.Value);
      ParamByName(FMiktar.FieldName).Value := FormatedVariantVal(FMiktar.FieldType, FMiktar.Value);
      ParamByName(FTutar.FieldName).Value := FormatedVariantVal(FTutar.FieldType, FTutar.Value);
      ParamByName(FGirisCikisTipID.FieldName).Value := FormatedVariantVal(FGirisCikisTipID.FieldType, FGirisCikisTipID.Value);
      ParamByName(FTarih.FieldName).Value := FormatedVariantVal(FTarih.FieldType, FTarih.Value);

      ParamByName(Self.Id.FieldName).Value := FormatedVariantVal(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TStokHareketi.Clear();
begin
  inherited;

  FStokKodu.Value := '';
  FMiktar.Value := 0;
  FTutar.Value := 0;
  FGirisCikisTipID.Value := 0;
  FTarih.Value := 0;
end;

function TStokHareketi.Clone():TTable;
begin
  Result := TStokHareketi.Create(Database);

  Self.Id.Clone(TStokHareketi(Result).Id);

  FStokKodu.Clone(TStokHareketi(Result).FStokKodu);
  FMiktar.Clone(TStokHareketi(Result).FMiktar);
  FTutar.Clone(TStokHareketi(Result).FTutar);
  FGirisCikisTipID.Clone(TStokHareketi(Result).FGirisCikisTipID);
  FTarih.Clone(TStokHareketi(Result).FTarih);
end;

end.
