unit Ths.Erp.Database.Table.AyarStkStokGrubu;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.AyarStkStokGrubuTuru,
  Ths.Erp.Database.Table.AyarVergiOrani,
  Ths.Erp.Database.Table.HesapKarti;

type
  TAyarStkStokGrubu = class(TTable)
  private
    FAyarStkStokGrubuTuruID: TFieldDB;
    FGrup: TFieldDB;
    FAlisHesabi: TFieldDB;
    FAlisIadeHesabi: TFieldDB;
    FSatisHesabi: TFieldDB;
    FSatisIadeHesabi: TFieldDB;
    FIhracatHesabi: TFieldDB;
    FHammaddeHesabi: TFieldDB;
    FMamulHesabi: TFieldDB;
    FKDVOrani: TFieldDB;
    FIsIskontoAktif: TFieldDB;
    FIskontoSatis: TFieldDB;
    FIskontoMudur: TFieldDB;
    FIsSatisFiyatiniKullan: TFieldDB;
    FIsMaliyetAnalizFarkliDB: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;

    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property AyarStkStokGrubuTuruID: TFieldDB read FAyarStkStokGrubuTuruID write FAyarStkStokGrubuTuruID;
    Property Grup: TFieldDB read FGrup write FGrup;
    Property AlisHesabi: TFieldDB read FAlisHesabi write FAlisHesabi;
    Property AlisIadeHesabi: TFieldDB read FAlisIadeHesabi write FAlisIadeHesabi;
    Property SatisHesabi: TFieldDB read FSatisHesabi write FSatisHesabi;
    Property SatisIadeHesabi: TFieldDB read FSatisIadeHesabi write FSatisIadeHesabi;
    Property IhracatHesabi: TFieldDB read FIhracatHesabi write FIhracatHesabi;
    Property HammaddeHesabi: TFieldDB read FHammaddeHesabi write FHammaddeHesabi;
    Property MamulHesabi: TFieldDB read FMamulHesabi write FMamulHesabi;
    Property KDVOrani: TFieldDB read FKDVOrani write FKDVOrani;
    Property IsIskontoAktif: TFieldDB read FIsIskontoAktif write FIsIskontoAktif;
    Property IskontoSatis: TFieldDB read FIskontoSatis write FIskontoSatis;
    Property IskontoMudur: TFieldDB read FIskontoMudur write FIskontoMudur;
    Property IsSatisFiyatiniKullan: TFieldDB read FIsSatisFiyatiniKullan write FIsSatisFiyatiniKullan;
    Property IsMaliyetAnalizFarkliDB: TFieldDB read FIsMaliyetAnalizFarkliDB write FIsMaliyetAnalizFarkliDB;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAyarStkStokGrubu.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ayar_stk_stok_grubu';
  SourceCode := '1000';

  FAyarStkStokGrubuTuruID := TFieldDB.Create('ayar_stk_stok_grubu_turu_id', ftInteger, 0, 0, True);
  FAyarStkStokGrubuTuruID.FK.FKTable := TAyarStkStokGrubuTuru.Create(OwnerDatabase);
  FAyarStkStokGrubuTuruID.FK.FKCol := TFieldDB.Create(TAyarStkStokGrubuTuru(FAyarStkStokGrubuTuruID.FK.FKTable).StokGrubuTur.FieldName, TAyarStkStokGrubuTuru(FAyarStkStokGrubuTuruID.FK.FKTable).StokGrubuTur.FieldType, '');
  FGrup := TFieldDB.Create('grup', ftString, '');
  FAlisHesabi := TFieldDB.Create('alis_hesabi', ftString, '', 0, True);
  FAlisHesabi.FK.FKTable := THesapKarti.Create(OwnerDatabase);
  FAlisHesabi.FK.FKCol := TFieldDB.Create(THesapKarti(FAlisHesabi.FK.FKTable).HesapKodu.FieldName, THesapKarti(FAlisHesabi.FK.FKTable).HesapKodu.FieldType, '');
  FAlisIadeHesabi := TFieldDB.Create('alis_iade_hesabi', ftString, '', 0, True);
  FAlisIadeHesabi.FK.FKTable := THesapKarti.Create(OwnerDatabase);
  FAlisIadeHesabi.FK.FKCol := TFieldDB.Create(THesapKarti(FAlisHesabi.FK.FKTable).HesapKodu.FieldName, THesapKarti(FAlisHesabi.FK.FKTable).HesapKodu.FieldType, '');
  FSatisHesabi := TFieldDB.Create('satis_hesabi', ftString, '', 0, True);
  FSatisHesabi.FK.FKTable := THesapKarti.Create(OwnerDatabase);
  FSatisHesabi.FK.FKCol := TFieldDB.Create(THesapKarti(FAlisHesabi.FK.FKTable).HesapKodu.FieldName, THesapKarti(FAlisHesabi.FK.FKTable).HesapKodu.FieldType, '');
  FSatisIadeHesabi := TFieldDB.Create('satis_iade_hesabi', ftString, '', 0, True);
  FSatisIadeHesabi.FK.FKTable := THesapKarti.Create(OwnerDatabase);
  FSatisIadeHesabi.FK.FKCol := TFieldDB.Create(THesapKarti(FAlisHesabi.FK.FKTable).HesapKodu.FieldName, THesapKarti(FAlisHesabi.FK.FKTable).HesapKodu.FieldType, '');
  FIhracatHesabi := TFieldDB.Create('ihracat_hesabi', ftString, '', 0, True);
  FIhracatHesabi.FK.FKTable := THesapKarti.Create(OwnerDatabase);
  FIhracatHesabi.FK.FKCol := TFieldDB.Create(THesapKarti(FAlisHesabi.FK.FKTable).HesapKodu.FieldName, THesapKarti(FAlisHesabi.FK.FKTable).HesapKodu.FieldType, '');
  FHammaddeHesabi := TFieldDB.Create('hammadde_hesabi', ftString, '', 0, True);
  FHammaddeHesabi.FK.FKTable := THesapKarti.Create(OwnerDatabase);
  FHammaddeHesabi.FK.FKCol := TFieldDB.Create(THesapKarti(FAlisHesabi.FK.FKTable).HesapKodu.FieldName, THesapKarti(FAlisHesabi.FK.FKTable).HesapKodu.FieldType, '');
  FMamulHesabi := TFieldDB.Create('mamul_hesabi', ftString, '', 0, True);
  FMamulHesabi.FK.FKTable := THesapKarti.Create(OwnerDatabase);
  FMamulHesabi.FK.FKCol := TFieldDB.Create(THesapKarti(FAlisHesabi.FK.FKTable).HesapKodu.FieldName, THesapKarti(FAlisHesabi.FK.FKTable).HesapKodu.FieldType, '');
  FKDVOrani := TFieldDB.Create('kdv_orani', ftInteger, 0, 0, True);
  FKDVOrani.FK.FKTable := TAyarVergiOrani.Create(OwnerDatabase);
  FKDVOrani.FK.FKCol := TFieldDB.Create(TAyarVergiOrani(FKDVOrani.FK.FKTable).VergiOrani.FieldName, TAyarVergiOrani(FKDVOrani.FK.FKTable).VergiOrani.FieldType, '');
  FIsIskontoAktif := TFieldDB.Create('is_iskonto_aktif', ftBoolean, False, 0, False);
  FIskontoSatis := TFieldDB.Create('iskonto_satis', ftFloat, 0, 0, False);
  FIskontoMudur := TFieldDB.Create('iskonto_mudur', ftFloat, 0, 0, False);
  FIsSatisFiyatiniKullan := TFieldDB.Create('is_satis_fiyatini_kullan', ftBoolean, False);
  FIsMaliyetAnalizFarkliDB := TFieldDB.Create('is_maliyet_analiz_farkli_db', ftBoolean, False);
end;

procedure TAyarStkStokGrubu.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FAyarStkStokGrubuTuruID.FieldName,
        ColumnFromIDCol(FAyarStkStokGrubuTuruID.FK.FKCol.FieldName, FAyarStkStokGrubuTuruID.FK.FKTable.TableName, FAyarStkStokGrubuTuruID.FieldName, FAyarStkStokGrubuTuruID.FK.FKCol.FieldName, TableName),
        getRawDataByLang(TableName, FGrup.FieldName),
        TableName + '.' + FAlisHesabi.FieldName,
        TableName + '.' + FAlisIadeHesabi.FieldName,
        TableName + '.' + FSatisHesabi.FieldName,
        TableName + '.' + FSatisIadeHesabi.FieldName,
        TableName + '.' + FIhracatHesabi.FieldName,
        TableName + '.' + FHammaddeHesabi.FieldName,
        TableName + '.' + FMamulHesabi.FieldName,
        TableName + '.' + FKDVOrani.FieldName,
        TableName + '.' + FIsIskontoAktif.FieldName,
        TableName + '.' + FIskontoSatis.FieldName,
        TableName + '.' + FIskontoMudur.FieldName,
        TableName + '.' + FIsSatisFiyatiniKullan.FieldName,
        TableName + '.' + FIsMaliyetAnalizFarkliDB.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FAyarStkStokGrubuTuruID.FieldName).DisplayLabel := 'Tür ID';
      Self.DataSource.DataSet.FindField(FAyarStkStokGrubuTuruID.FK.FKCol.FieldName).DisplayLabel := 'Tür';
      Self.DataSource.DataSet.FindField(FGrup.FieldName).DisplayLabel := 'Grup';
      Self.DataSource.DataSet.FindField(FAlisHesabi.FieldName).DisplayLabel := 'Alýþ Hesabý';
      Self.DataSource.DataSet.FindField(FAlisIadeHesabi.FieldName).DisplayLabel := 'Alýþ Ýade Hesabý';
      Self.DataSource.DataSet.FindField(FSatisHesabi.FieldName).DisplayLabel := 'Satýþ Hesabý';
      Self.DataSource.DataSet.FindField(FSatisIadeHesabi.FieldName).DisplayLabel := 'Satýþ Ýade Hesabý';
      Self.DataSource.DataSet.FindField(FIhracatHesabi.FieldName).DisplayLabel := 'Ýhracat Hesabý';
      Self.DataSource.DataSet.FindField(FHammaddeHesabi.FieldName).DisplayLabel := 'Hammadde Hesabý';
      Self.DataSource.DataSet.FindField(FMamulHesabi.FieldName).DisplayLabel := 'Mamül Hesabý';
      Self.DataSource.DataSet.FindField(FKDVOrani.FieldName).DisplayLabel := 'KDV Oraný';
      Self.DataSource.DataSet.FindField(FIsIskontoAktif.FieldName).DisplayLabel := 'Ýskonto Aktif?';
      Self.DataSource.DataSet.FindField(FIskontoSatis.FieldName).DisplayLabel := 'Ýskonto Satýþ';
      Self.DataSource.DataSet.FindField(FIskontoMudur.FieldName).DisplayLabel := 'Ýskonto Müdür';
      Self.DataSource.DataSet.FindField(FIsSatisFiyatiniKullan.FieldName).DisplayLabel := 'Satýþ Fiyatýný Kullan?';
      Self.DataSource.DataSet.FindField(FIsMaliyetAnalizFarkliDB.FieldName).DisplayLabel := 'Maliyet Analiz Farklý DB?';
    end;
  end;
end;

procedure TAyarStkStokGrubu.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FAyarStkStokGrubuTuruID.FieldName,
        ColumnFromIDCol(FAyarStkStokGrubuTuruID.FK.FKCol.FieldName, FAyarStkStokGrubuTuruID.FK.FKTable.TableName, FAyarStkStokGrubuTuruID.FieldName, FAyarStkStokGrubuTuruID.FK.FKCol.FieldName, TableName),
        getRawDataByLang(TableName, FGrup.FieldName),
        TableName + '.' + FAlisHesabi.FieldName,
        TableName + '.' + FAlisIadeHesabi.FieldName,
        TableName + '.' + FSatisHesabi.FieldName,
        TableName + '.' + FSatisIadeHesabi.FieldName,
        TableName + '.' + FIhracatHesabi.FieldName,
        TableName + '.' + FHammaddeHesabi.FieldName,
        TableName + '.' + FMamulHesabi.FieldName,
        TableName + '.' + FKDVOrani.FieldName,
        TableName + '.' + FIsIskontoAktif.FieldName,
        TableName + '.' + FIskontoSatis.FieldName,
        TableName + '.' + FIskontoMudur.FieldName,
        TableName + '.' + FIsSatisFiyatiniKullan.FieldName,
        TableName + '.' + FIsMaliyetAnalizFarkliDB.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FAyarStkStokGrubuTuruID.Value := FormatedVariantVal(FieldByName(FAyarStkStokGrubuTuruID.FieldName).DataType, FieldByName(FAyarStkStokGrubuTuruID.FieldName).Value);
        FAyarStkStokGrubuTuruID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FAyarStkStokGrubuTuruID.FK.FKCol.FieldName).DataType, FieldByName(FAyarStkStokGrubuTuruID.FK.FKCol.FieldName).Value);
        FGrup.Value := FormatedVariantVal(FieldByName(FGrup.FieldName).DataType, FieldByName(FGrup.FieldName).Value);
        FAlisHesabi.Value := FormatedVariantVal(FieldByName(FAlisHesabi.FieldName).DataType, FieldByName(FAlisHesabi.FieldName).Value);
        FAlisIadeHesabi.Value := FormatedVariantVal(FieldByName(FAlisIadeHesabi.FieldName).DataType, FieldByName(FAlisIadeHesabi.FieldName).Value);
        FSatisHesabi.Value := FormatedVariantVal(FieldByName(FSatisHesabi.FieldName).DataType, FieldByName(FSatisHesabi.FieldName).Value);
        FSatisIadeHesabi.Value := FormatedVariantVal(FieldByName(FSatisIadeHesabi.FieldName).DataType, FieldByName(FSatisIadeHesabi.FieldName).Value);
        FIhracatHesabi.Value := FormatedVariantVal(FieldByName(FIhracatHesabi.FieldName).DataType, FieldByName(FIhracatHesabi.FieldName).Value);
        FHammaddeHesabi.Value := FormatedVariantVal(FieldByName(FHammaddeHesabi.FieldName).DataType, FieldByName(FHammaddeHesabi.FieldName).Value);
        FMamulHesabi.Value := FormatedVariantVal(FieldByName(FMamulHesabi.FieldName).DataType, FieldByName(FMamulHesabi.FieldName).Value);
        FKDVOrani.Value := FormatedVariantVal(FieldByName(FKDVOrani.FieldName).DataType, FieldByName(FKDVOrani.FieldName).Value);
        FIsIskontoAktif.Value := FormatedVariantVal(FieldByName(FIsIskontoAktif.FieldName).DataType, FieldByName(FIsIskontoAktif.FieldName).Value);
        FIskontoSatis.Value := FormatedVariantVal(FieldByName(FIskontoSatis.FieldName).DataType, FieldByName(FIskontoSatis.FieldName).Value);
        FIskontoMudur.Value := FormatedVariantVal(FieldByName(FIskontoMudur.FieldName).DataType, FieldByName(FIskontoMudur.FieldName).Value);
        FIsSatisFiyatiniKullan.Value := FormatedVariantVal(FieldByName(FIsSatisFiyatiniKullan.FieldName).DataType, FieldByName(FIsSatisFiyatiniKullan.FieldName).Value);
        FIsMaliyetAnalizFarkliDB.Value := FormatedVariantVal(FieldByName(FIsMaliyetAnalizFarkliDB.FieldName).DataType, FieldByName(FIsMaliyetAnalizFarkliDB.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAyarStkStokGrubu.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FAyarStkStokGrubuTuruID.FieldName,
        FGrup.FieldName,
        FAlisHesabi.FieldName,
        FAlisIadeHesabi.FieldName,
        FSatisHesabi.FieldName,
        FSatisIadeHesabi.FieldName,
        FIhracatHesabi.FieldName,
        FHammaddeHesabi.FieldName,
        FMamulHesabi.FieldName,
        FKDVOrani.FieldName,
        FIsIskontoAktif.FieldName,
        FIskontoSatis.FieldName,
        FIskontoMudur.FieldName,
        FIsSatisFiyatiniKullan.FieldName,
        FIsMaliyetAnalizFarkliDB.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FAyarStkStokGrubuTuruID);
      NewParamForQuery(QueryOfInsert, FGrup);
      NewParamForQuery(QueryOfInsert, FAlisHesabi);
      NewParamForQuery(QueryOfInsert, FAlisIadeHesabi);
      NewParamForQuery(QueryOfInsert, FSatisHesabi);
      NewParamForQuery(QueryOfInsert, FSatisIadeHesabi);
      NewParamForQuery(QueryOfInsert, FIhracatHesabi);
      NewParamForQuery(QueryOfInsert, FHammaddeHesabi);
      NewParamForQuery(QueryOfInsert, FMamulHesabi);
      NewParamForQuery(QueryOfInsert, FKDVOrani);
      NewParamForQuery(QueryOfInsert, FIsIskontoAktif);
      NewParamForQuery(QueryOfInsert, FIskontoSatis);
      NewParamForQuery(QueryOfInsert, FIskontoMudur);
      NewParamForQuery(QueryOfInsert, FIsSatisFiyatiniKullan);
      NewParamForQuery(QueryOfInsert, FIsMaliyetAnalizFarkliDB);

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

procedure TAyarStkStokGrubu.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FAyarStkStokGrubuTuruID.FieldName,
        FGrup.FieldName,
        FAlisHesabi.FieldName,
        FAlisIadeHesabi.FieldName,
        FSatisHesabi.FieldName,
        FSatisIadeHesabi.FieldName,
        FIhracatHesabi.FieldName,
        FHammaddeHesabi.FieldName,
        FMamulHesabi.FieldName,
        FKDVOrani.FieldName,
        FIsIskontoAktif.FieldName,
        FIskontoSatis.FieldName,
        FIskontoMudur.FieldName,
        FIsSatisFiyatiniKullan.FieldName,
        FIsMaliyetAnalizFarkliDB.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FAyarStkStokGrubuTuruID);
      NewParamForQuery(QueryOfUpdate, FGrup);
      NewParamForQuery(QueryOfUpdate, FAlisHesabi);
      NewParamForQuery(QueryOfUpdate, FAlisIadeHesabi);
      NewParamForQuery(QueryOfUpdate, FSatisHesabi);
      NewParamForQuery(QueryOfUpdate, FSatisIadeHesabi);
      NewParamForQuery(QueryOfUpdate, FIhracatHesabi);
      NewParamForQuery(QueryOfUpdate, FHammaddeHesabi);
      NewParamForQuery(QueryOfUpdate, FMamulHesabi);
      NewParamForQuery(QueryOfUpdate, FKDVOrani);
      NewParamForQuery(QueryOfUpdate, FIsIskontoAktif);
      NewParamForQuery(QueryOfUpdate, FIskontoSatis);
      NewParamForQuery(QueryOfUpdate, FIskontoMudur);
      NewParamForQuery(QueryOfUpdate, FIsSatisFiyatiniKullan);
      NewParamForQuery(QueryOfUpdate, FIsMaliyetAnalizFarkliDB);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TAyarStkStokGrubu.Clone():TTable;
begin
  Result := TAyarStkStokGrubu.Create(Database);

  Self.Id.Clone(TAyarStkStokGrubu(Result).Id);

  FAyarStkStokGrubuTuruID.Clone(TAyarStkStokGrubu(Result).FAyarStkStokGrubuTuruID);
  FGrup.Clone(TAyarStkStokGrubu(Result).FGrup);
  FAlisHesabi.Clone(TAyarStkStokGrubu(Result).FAlisHesabi);
  FAlisIadeHesabi.Clone(TAyarStkStokGrubu(Result).FAlisIadeHesabi);
  FSatisHesabi.Clone(TAyarStkStokGrubu(Result).FSatisHesabi);
  FSatisIadeHesabi.Clone(TAyarStkStokGrubu(Result).FSatisIadeHesabi);
  FIhracatHesabi.Clone(TAyarStkStokGrubu(Result).FIhracatHesabi);
  FHammaddeHesabi.Clone(TAyarStkStokGrubu(Result).FHammaddeHesabi);
  FMamulHesabi.Clone(TAyarStkStokGrubu(Result).FMamulHesabi);
  FKDVOrani.Clone(TAyarStkStokGrubu(Result).FKDVOrani);
  FKDVOrani.Clone(TAyarStkStokGrubu(Result).FKDVOrani);
  FIsIskontoAktif.Clone(TAyarStkStokGrubu(Result).FIsIskontoAktif);
  FIskontoSatis.Clone(TAyarStkStokGrubu(Result).FIskontoSatis);
  FIskontoMudur.Clone(TAyarStkStokGrubu(Result).FIskontoMudur);
  FIsSatisFiyatiniKullan.Clone(TAyarStkStokGrubu(Result).FIsSatisFiyatiniKullan);
  FIsMaliyetAnalizFarkliDB.Clone(TAyarStkStokGrubu(Result).FIsMaliyetAnalizFarkliDB);
end;

end.
