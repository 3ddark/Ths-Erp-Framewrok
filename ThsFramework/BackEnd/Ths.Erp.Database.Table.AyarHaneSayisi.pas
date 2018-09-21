unit Ths.Erp.Database.Table.AyarHaneSayisi;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TAyarHaneSayisi = class(TTable)
  private
    FHesapBakiye: TFieldDB;
    FAlisMiktar: TFieldDB;
    FAlisFiyat: TFieldDB;
    FAlisTutar: TFieldDB;
    FSatisMiktar: TFieldDB;
    FSatisFiyat: TFieldDB;
    FSatisTutar: TFieldDB;
    FStokMiktar: TFieldDB;
    FStokFiyat: TFieldDB;
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

    property HesapBakiye: TFieldDB read FHesapBakiye write FHesapBakiye;
    property AlisMiktar: TFieldDB read FAlisMiktar write FAlisMiktar;
    property AlisFiyat: TFieldDB read FAlisFiyat write FAlisFiyat;
    property AlisTutar: TFieldDB read FAlisTutar write FAlisTutar;
    property SatisMiktar: TFieldDB read FSatisMiktar write FSatisMiktar;
    property SatisFiyat: TFieldDB read FSatisFiyat write FSatisFiyat;
    property SatisTutar: TFieldDB read FSatisTutar write FSatisTutar;
    property StokMiktar: TFieldDB read FStokMiktar write FStokMiktar;
    property StokFiyat: TFieldDB read FStokFiyat write FStokFiyat;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAyarHaneSayisi.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ayar_hane_sayisi';
  SourceCode := '1000';

  FHesapBakiye := TFieldDB.Create('hesap_bakiye', ftInteger, 2);
  FAlisMiktar := TFieldDB.Create('alis_miktar', ftInteger, 2);
  FAlisFiyat := TFieldDB.Create('alis_fiyat', ftInteger, 2);
  FAlisTutar := TFieldDB.Create('alis_tutar', ftInteger, 2);
  FSatisMiktar := TFieldDB.Create('satis_miktar', ftInteger, 2);
  FSatisFiyat := TFieldDB.Create('satis_fiyat', ftInteger, 2);
  FSatisTutar := TFieldDB.Create('satis_tutar', ftInteger, 2);
  FStokMiktar := TFieldDB.Create('stok_miktar', ftInteger, 2);
  FStokFiyat := TFieldDB.Create('stok_fiyat', ftInteger, 2);
end;

procedure TAyarHaneSayisi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FHesapBakiye.FieldName,
        TableName + '.' + FAlisMiktar.FieldName,
        TableName + '.' + FAlisFiyat.FieldName,
        TableName + '.' + FAlisTutar.FieldName,
        TableName + '.' + FSatisMiktar.FieldName,
        TableName + '.' + FSatisFiyat.FieldName,
        TableName + '.' + FSatisTutar.FieldName,
        TableName + '.' + FStokMiktar.FieldName,
        TableName + '.' + FStokFiyat.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FHesapBakiye.FieldName).DisplayLabel := 'HESAP BAKÝYE';
      Self.DataSource.DataSet.FindField(FAlisMiktar.FieldName).DisplayLabel := 'ALIÞ MÝKTAR';
      Self.DataSource.DataSet.FindField(FAlisFiyat.FieldName).DisplayLabel := 'ALIÞ FÝYAT';
      Self.DataSource.DataSet.FindField(FAlisTutar.FieldName).DisplayLabel := 'ALIÞ TUTAR';
      Self.DataSource.DataSet.FindField(FSatisMiktar.FieldName).DisplayLabel := 'SATIÞ MÝKTAR';
      Self.DataSource.DataSet.FindField(FSatisFiyat.FieldName).DisplayLabel := 'SATIÞ FÝYAT';
      Self.DataSource.DataSet.FindField(FSatisTutar.FieldName).DisplayLabel := 'SATIÞ TUTAR';
      Self.DataSource.DataSet.FindField(FStokMiktar.FieldName).DisplayLabel := 'STOK MÝKTAR';
      Self.DataSource.DataSet.FindField(FStokFiyat.FieldName).DisplayLabel := 'STOK FÝYAT';
    end;
  end;
end;

procedure TAyarHaneSayisi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FHesapBakiye.FieldName,
        TableName + '.' + FAlisMiktar.FieldName,
        TableName + '.' + FAlisFiyat.FieldName,
        TableName + '.' + FAlisTutar.FieldName,
        TableName + '.' + FSatisMiktar.FieldName,
        TableName + '.' + FSatisFiyat.FieldName,
        TableName + '.' + FSatisTutar.FieldName,
        TableName + '.' + FStokMiktar.FieldName,
        TableName + '.' + FStokFiyat.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FHesapBakiye.Value := FormatedVariantVal(FieldByName(FHesapBakiye.FieldName).DataType, FieldByName(FHesapBakiye.FieldName).Value);
        FAlisMiktar.Value := FormatedVariantVal(FieldByName(FAlisMiktar.FieldName).DataType, FieldByName(FAlisMiktar.FieldName).Value);
        FAlisFiyat.Value := FormatedVariantVal(FieldByName(FAlisFiyat.FieldName).DataType, FieldByName(FAlisFiyat.FieldName).Value);
        FAlisTutar.Value := FormatedVariantVal(FieldByName(FAlisTutar.FieldName).DataType, FieldByName(FAlisTutar.FieldName).Value);
        FSatisMiktar.Value := FormatedVariantVal(FieldByName(FSatisMiktar.FieldName).DataType, FieldByName(FSatisMiktar.FieldName).Value);
        FSatisFiyat.Value := FormatedVariantVal(FieldByName(FSatisFiyat.FieldName).DataType, FieldByName(FSatisFiyat.FieldName).Value);
        FSatisTutar.Value := FormatedVariantVal(FieldByName(FSatisTutar.FieldName).DataType, FieldByName(FSatisTutar.FieldName).Value);
        FStokMiktar.Value := FormatedVariantVal(FieldByName(FStokMiktar.FieldName).DataType, FieldByName(FStokMiktar.FieldName).Value);
        FStokFiyat.Value := FormatedVariantVal(FieldByName(FStokFiyat.FieldName).DataType, FieldByName(FStokFiyat.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAyarHaneSayisi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FHesapBakiye.FieldName,
        FAlisMiktar.FieldName,
        FAlisFiyat.FieldName,
        FAlisTutar.FieldName,
        FSatisMiktar.FieldName,
        FSatisFiyat.FieldName,
        FSatisTutar.FieldName,
        FStokMiktar.FieldName,
        FStokFiyat.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FHesapBakiye);
      NewParamForQuery(QueryOfInsert, FAlisMiktar);
      NewParamForQuery(QueryOfInsert, FAlisFiyat);
      NewParamForQuery(QueryOfInsert, FAlisTutar);
      NewParamForQuery(QueryOfInsert, FSatisMiktar);
      NewParamForQuery(QueryOfInsert, FSatisFiyat);
      NewParamForQuery(QueryOfInsert, FSatisTutar);
      NewParamForQuery(QueryOfInsert, FStokMiktar);
      NewParamForQuery(QueryOfInsert, FStokFiyat);

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

procedure TAyarHaneSayisi.Update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FHesapBakiye.FieldName,
        FAlisMiktar.FieldName,
        FAlisFiyat.FieldName,
        FAlisTutar.FieldName,
        FSatisMiktar.FieldName,
        FSatisFiyat.FieldName,
        FSatisTutar.FieldName,
        FStokMiktar.FieldName,
        FStokFiyat.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FHesapBakiye);
      NewParamForQuery(QueryOfUpdate, FAlisMiktar);
      NewParamForQuery(QueryOfUpdate, FAlisFiyat);
      NewParamForQuery(QueryOfUpdate, FAlisTutar);
      NewParamForQuery(QueryOfUpdate, FSatisMiktar);
      NewParamForQuery(QueryOfUpdate, FSatisFiyat);
      NewParamForQuery(QueryOfUpdate, FSatisTutar);
      NewParamForQuery(QueryOfUpdate, FStokMiktar);
      NewParamForQuery(QueryOfUpdate, FStokFiyat);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
  Self.notify;
  end;
end;

procedure TAyarHaneSayisi.Clear();
begin
  inherited;

  FHesapBakiye.Value := '0';
  FAlisMiktar.Value := '0';
  FAlisFiyat.Value := '0';
  FAlisTutar.Value := '0';
  FSatisMiktar.Value := '0';
  FSatisFiyat.Value := '0';
  FSatisTutar.Value := '0';
  FStokMiktar.Value := '0';
  FStokFiyat.Value := '0';
end;

function TAyarHaneSayisi.Clone():TTable;
begin
  Result := TAyarHaneSayisi.Create(Database);

  Self.Id.Clone(TAyarHaneSayisi(Result).Id);

  FHesapBakiye.Clone(TAyarHaneSayisi(Result).FHesapBakiye);
  FAlisMiktar.Clone(TAyarHaneSayisi(Result).FAlisMiktar);
  FAlisFiyat.Clone(TAyarHaneSayisi(Result).FAlisFiyat);
  FAlisTutar.Clone(TAyarHaneSayisi(Result).FAlisTutar);
  FSatisMiktar.Clone(TAyarHaneSayisi(Result).FSatisMiktar);
  FSatisFiyat.Clone(TAyarHaneSayisi(Result).FSatisFiyat);
  FSatisTutar.Clone(TAyarHaneSayisi(Result).FSatisTutar);
  FStokMiktar.Clone(TAyarHaneSayisi(Result).FStokMiktar);
  FStokFiyat.Clone(TAyarHaneSayisi(Result).FStokFiyat);
end;

end.
