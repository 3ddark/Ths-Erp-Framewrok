unit Ths.Erp.Database.Table.StokGrubu;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field,
  Ths.Erp.Database.Table.StokGrubuTuru,
  Ths.Erp.Database.Table.AyarVergiOrani;

type
  TStokGrubu = class(TTable)
  private
    FGrup: TFieldDB;
    FAlisHesabi: TFieldDB;
    FSatisHesabi: TFieldDB;
    FHammaddeHesabi: TFieldDB;
    FMamulHesabi: TFieldDB;
    FKDVOraniID: TFieldDB;
    FKDVOrani: TFieldDB;
    FTurID: TFieldDB;
    FTur: TFieldDB;
    FIsIskontoAktif: TFieldDB;
    FIskontoSatis: TFieldDB;
    FIskontoMudur: TFieldDB;
    FIsSatisFiyatiniKullan: TFieldDB;
    FYariMamulHesabi: TFieldDB;
    FIsMaliyetAnalizFarkliDB: TFieldDB;
  protected
    vStokGrubuTur: TStokGrubuTuru;
    vVergiOrani: TAyarVergiOrani;
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property Grup: TFieldDB read FGrup write FGrup;
    Property AlisHesabi: TFieldDB read FAlisHesabi write FAlisHesabi;
    Property SatisHesabi: TFieldDB read FSatisHesabi write FSatisHesabi;
    Property HammaddeHesabi: TFieldDB read FHammaddeHesabi write FHammaddeHesabi;
    Property MamulHesabi: TFieldDB read FMamulHesabi write FMamulHesabi;
    Property KDVOraniID: TFieldDB read FKDVOraniID write FKDVOraniID;
    Property KDVOrani: TFieldDB read FKDVOrani write FKDVOrani;
    Property TurID: TFieldDB read FTurID write FTurID;
    Property Tur: TFieldDB read FTur write FTur;
    Property IsIskontoAktif: TFieldDB read FIsIskontoAktif write FIsIskontoAktif;
    Property IskontoSatis: TFieldDB read FIskontoSatis write FIskontoSatis;
    Property IskontoMudur: TFieldDB read FIskontoMudur write FIskontoMudur;
    Property IsSatisFiyatiniKullan: TFieldDB read FIsSatisFiyatiniKullan write FIsSatisFiyatiniKullan;
    Property YariMamulHesabi: TFieldDB read FYariMamulHesabi write FYariMamulHesabi;
    Property IsMaliyetAnalizFarkliDB: TFieldDB read FIsMaliyetAnalizFarkliDB write FIsMaliyetAnalizFarkliDB;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TStokGrubu.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'stok_grubu';
  SourceCode := '1000';

  FGrup := TFieldDB.Create('grup', ftString, '');
  FAlisHesabi := TFieldDB.Create('alis_hesabi', ftString, '');
  FSatisHesabi := TFieldDB.Create('satis_hesabi', ftString, '');
  FHammaddeHesabi := TFieldDB.Create('hammadde_hesabi', ftString, '');
  FMamulHesabi := TFieldDB.Create('mamul_hesabi', ftString, '');
  FKDVOraniID := TFieldDB.Create('kdv_orani_id', ftInteger, 0);
  FKDVOrani := TFieldDB.Create('kdv_orani', ftFloat, 0);
  FTurID := TFieldDB.Create('tur_id', ftInteger, 0);
  FTur := TFieldDB.Create('tur', ftString, '');
  FIsIskontoAktif := TFieldDB.Create('is_iskonto_aktif', ftBoolean, False, 0, False);
  FIskontoSatis := TFieldDB.Create('iskonto_satis', ftFloat, 0, 0, False);
  FIskontoMudur := TFieldDB.Create('iskonto_mudur', ftFloat, 0, 0, False);
  FIsSatisFiyatiniKullan := TFieldDB.Create('is_satis_fiyatini_kullan', ftBoolean, False);
  FYariMamulHesabi := TFieldDB.Create('yari_mamul_hesabi', ftString, '');
  FIsMaliyetAnalizFarkliDB := TFieldDB.Create('is_maliyet_analiz_farkli_db', ftBoolean, False);
end;

procedure TStokGrubu.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      vStokGrubuTur := TStokGrubuTuru.Create(Database);
      vVergiOrani := TAyarVergiOrani.Create(Database);
      try
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          GetRawDataSQLByLang(TableName, FGrup.FieldName),
          TableName + '.' + FAlisHesabi.FieldName,
          TableName + '.' + FSatisHesabi.FieldName,
          TableName + '.' + FHammaddeHesabi.FieldName,
          TableName + '.' + FMamulHesabi.FieldName,
          TableName + '.' + FKDVOraniID.FieldName,
          ColumnFromIDCol(vVergiOrani.VergiOrani.FieldName, vVergiOrani.TableName, FKDVOraniID.FieldName, FKDVOrani.FieldName, TableName, True),
          TableName + '.' + FTurID.FieldName,
          ColumnFromIDCol(vStokGrubuTur.Tur.FieldName, vStokGrubuTur.TableName, FTurID.FieldName, FTur.FieldName, TableName),
          TableName + '.' + FIsIskontoAktif.FieldName,
          TableName + '.' + FIskontoSatis.FieldName,
          TableName + '.' + FIskontoMudur.FieldName,
          TableName + '.' + FIsSatisFiyatiniKullan.FieldName,
          TableName + '.' + FYariMamulHesabi.FieldName,
          TableName + '.' + FIsMaliyetAnalizFarkliDB.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;
        Active := True;

        Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
        Self.DataSource.DataSet.FindField(FGrup.FieldName).DisplayLabel := 'Grup';
        Self.DataSource.DataSet.FindField(FAlisHesabi.FieldName).DisplayLabel := 'Alýþ Hesabý';
        Self.DataSource.DataSet.FindField(FSatisHesabi.FieldName).DisplayLabel := 'Satýþ Hesabý';
        Self.DataSource.DataSet.FindField(FHammaddeHesabi.FieldName).DisplayLabel := 'Hammadde Hesabý';
        Self.DataSource.DataSet.FindField(FMamulHesabi.FieldName).DisplayLabel := 'Mamül Hesabý';
        Self.DataSource.DataSet.FindField(FKDVOraniID.FieldName).DisplayLabel := 'KDV Oraný ID';
        Self.DataSource.DataSet.FindField(FKDVOrani.FieldName).DisplayLabel := 'KDV Oraný';
        Self.DataSource.DataSet.FindField(FTurID.FieldName).DisplayLabel := 'Tür ID';
        Self.DataSource.DataSet.FindField(FTur.FieldName).DisplayLabel := 'Tür';
        Self.DataSource.DataSet.FindField(FIsIskontoAktif.FieldName).DisplayLabel := 'Ýskonto Aktif?';
        Self.DataSource.DataSet.FindField(FIskontoSatis.FieldName).DisplayLabel := 'Ýskonto Satýþ';
        Self.DataSource.DataSet.FindField(FIskontoMudur.FieldName).DisplayLabel := 'Ýskonto Müdür';
        Self.DataSource.DataSet.FindField(FIsSatisFiyatiniKullan.FieldName).DisplayLabel := 'Satýþ Fiyatýný Kullan?';
        Self.DataSource.DataSet.FindField(FYariMamulHesabi.FieldName).DisplayLabel := 'Yarý Mamül Hesabý';
        Self.DataSource.DataSet.FindField(FIsMaliyetAnalizFarkliDB.FieldName).DisplayLabel := 'Maliyet Analiz Farklý DB?';
      finally
        vStokGrubuTur.Free;
        vVergiOrani.Free;
      end;
    end;
  end;
end;

procedure TStokGrubu.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
      pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

    with QueryOfList do
    begin
      vStokGrubuTur := TStokGrubuTuru.Create(Database);
      vVergiOrani := TAyarVergiOrani.Create(Database);
      try
        Close;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          GetRawDataSQLByLang(TableName, FGrup.FieldName),
          TableName + '.' + FAlisHesabi.FieldName,
          TableName + '.' + FSatisHesabi.FieldName,
          TableName + '.' + FHammaddeHesabi.FieldName,
          TableName + '.' + FMamulHesabi.FieldName,
          TableName + '.' + FKDVOraniID.FieldName,
          ColumnFromIDCol(vVergiOrani.VergiOrani.FieldName, vVergiOrani.TableName, FKDVOraniID.FieldName, FKDVOrani.FieldName, TableName, True),
          TableName + '.' + FTurID.FieldName,
          ColumnFromIDCol(vStokGrubuTur.Tur.FieldName, vStokGrubuTur.TableName, FTurID.FieldName, FTur.FieldName, TableName),
          TableName + '.' + FIsIskontoAktif.FieldName,
          TableName + '.' + FIskontoSatis.FieldName,
          TableName + '.' + FIskontoMudur.FieldName,
          TableName + '.' + FIsSatisFiyatiniKullan.FieldName,
          TableName + '.' + FYariMamulHesabi.FieldName,
          TableName + '.' + FIsMaliyetAnalizFarkliDB.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;

        FreeListContent();
        List.Clear;
        while NOT EOF do
        begin
          Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

          FGrup.Value := FormatedVariantVal(FieldByName(FGrup.FieldName).DataType, FieldByName(FGrup.FieldName).Value);
          FAlisHesabi.Value := FormatedVariantVal(FieldByName(FAlisHesabi.FieldName).DataType, FieldByName(FAlisHesabi.FieldName).Value);
          FSatisHesabi.Value := FormatedVariantVal(FieldByName(FSatisHesabi.FieldName).DataType, FieldByName(FSatisHesabi.FieldName).Value);
          FHammaddeHesabi.Value := FormatedVariantVal(FieldByName(FHammaddeHesabi.FieldName).DataType, FieldByName(FHammaddeHesabi.FieldName).Value);
          FMamulHesabi.Value := FormatedVariantVal(FieldByName(FMamulHesabi.FieldName).DataType, FieldByName(FMamulHesabi.FieldName).Value);
          FKDVOraniID.Value := FormatedVariantVal(FieldByName(FKDVOraniID.FieldName).DataType, FieldByName(FKDVOraniID.FieldName).Value);
          FKDVOrani.Value := FormatedVariantVal(FieldByName(FKDVOrani.FieldName).DataType, FieldByName(FKDVOrani.FieldName).Value);
          FTurID.Value := FormatedVariantVal(FieldByName(FTurID.FieldName).DataType, FieldByName(FTurID.FieldName).Value);
          FTur.Value := FormatedVariantVal(FieldByName(FTur.FieldName).DataType, FieldByName(FTur.FieldName).Value);
          FIsIskontoAktif.Value := FormatedVariantVal(FieldByName(FIsIskontoAktif.FieldName).DataType, FieldByName(FIsIskontoAktif.FieldName).Value);
          FIskontoSatis.Value := FormatedVariantVal(FieldByName(FIskontoSatis.FieldName).DataType, FieldByName(FIskontoSatis.FieldName).Value);
          FIskontoMudur.Value := FormatedVariantVal(FieldByName(FIskontoMudur.FieldName).DataType, FieldByName(FIskontoMudur.FieldName).Value);
          FIsSatisFiyatiniKullan.Value := FormatedVariantVal(FieldByName(FIsSatisFiyatiniKullan.FieldName).DataType, FieldByName(FIsSatisFiyatiniKullan.FieldName).Value);
          FYariMamulHesabi.Value := FormatedVariantVal(FieldByName(FYariMamulHesabi.FieldName).DataType, FieldByName(FYariMamulHesabi.FieldName).Value);
          FIsMaliyetAnalizFarkliDB.Value := FormatedVariantVal(FieldByName(FIsMaliyetAnalizFarkliDB.FieldName).DataType, FieldByName(FIsMaliyetAnalizFarkliDB.FieldName).Value);

          List.Add(Self.Clone());

          Next;
        end;
        Close;
      finally
        vStokGrubuTur.Free;
        vVergiOrani.Free;
      end;
    end;
  end;
end;

procedure TStokGrubu.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FGrup.FieldName,
        FAlisHesabi.FieldName,
        FSatisHesabi.FieldName,
        FHammaddeHesabi.FieldName,
        FMamulHesabi.FieldName,
        FKDVOraniID.FieldName,
        FTurID.FieldName,
        FIsIskontoAktif.FieldName,
        FIskontoSatis.FieldName,
        FIskontoMudur.FieldName,
        FIsSatisFiyatiniKullan.FieldName,
        FYariMamulHesabi.FieldName,
        FIsMaliyetAnalizFarkliDB.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FGrup);
      NewParamForQuery(QueryOfInsert, FAlisHesabi);
      NewParamForQuery(QueryOfInsert, FSatisHesabi);
      NewParamForQuery(QueryOfInsert, FHammaddeHesabi);
      NewParamForQuery(QueryOfInsert, FMamulHesabi);
      NewParamForQuery(QueryOfInsert, FKDVOraniID);
      NewParamForQuery(QueryOfInsert, FTurID);
      NewParamForQuery(QueryOfInsert, FIsIskontoAktif);
      NewParamForQuery(QueryOfInsert, FIskontoSatis);
      NewParamForQuery(QueryOfInsert, FIskontoMudur);
      NewParamForQuery(QueryOfInsert, FIsSatisFiyatiniKullan);
      NewParamForQuery(QueryOfInsert, FYariMamulHesabi);
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

procedure TStokGrubu.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FGrup.FieldName,
        FAlisHesabi.FieldName,
        FSatisHesabi.FieldName,
        FHammaddeHesabi.FieldName,
        FMamulHesabi.FieldName,
        FKDVOraniID.FieldName,
        FTurID.FieldName,
        FIsIskontoAktif.FieldName,
        FIskontoSatis.FieldName,
        FIskontoMudur.FieldName,
        FIsSatisFiyatiniKullan.FieldName,
        FYariMamulHesabi.FieldName,
        FIsMaliyetAnalizFarkliDB.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FGrup);
      NewParamForQuery(QueryOfUpdate, FAlisHesabi);
      NewParamForQuery(QueryOfUpdate, FSatisHesabi);
      NewParamForQuery(QueryOfUpdate, FHammaddeHesabi);
      NewParamForQuery(QueryOfUpdate, FMamulHesabi);
      NewParamForQuery(QueryOfUpdate, FKDVOraniID);
      NewParamForQuery(QueryOfUpdate, FTurID);
      NewParamForQuery(QueryOfUpdate, FIsIskontoAktif);
      NewParamForQuery(QueryOfUpdate, FIskontoSatis);
      NewParamForQuery(QueryOfUpdate, FIskontoMudur);
      NewParamForQuery(QueryOfUpdate, FIsSatisFiyatiniKullan);
      NewParamForQuery(QueryOfUpdate, FYariMamulHesabi);
      NewParamForQuery(QueryOfUpdate, FIsMaliyetAnalizFarkliDB);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TStokGrubu.Clear();
begin
  inherited;

  FGrup.Value := '';
  FAlisHesabi.Value := '';
  FSatisHesabi.Value := '';
  FHammaddeHesabi.Value := '';
  FMamulHesabi.Value := '';
  FKDVOraniID.Value := 0;
  FKDVOrani.Value := 0;
  FTurID.Value := 0;
  FTur.Value := '';
  FIsIskontoAktif.Value := 0;
  FIskontoSatis.Value := 0;
  FIskontoMudur.Value := 0;
  FIsSatisFiyatiniKullan.Value := 0;
  FYariMamulHesabi.Value := '';
  FIsMaliyetAnalizFarkliDB.Value := 0;
end;

function TStokGrubu.Clone():TTable;
begin
  Result := TStokGrubu.Create(Database);

  Self.Id.Clone(TStokGrubu(Result).Id);

  FGrup.Clone(TStokGrubu(Result).FGrup);
  FAlisHesabi.Clone(TStokGrubu(Result).FAlisHesabi);
  FSatisHesabi.Clone(TStokGrubu(Result).FSatisHesabi);
  FHammaddeHesabi.Clone(TStokGrubu(Result).FHammaddeHesabi);
  FMamulHesabi.Clone(TStokGrubu(Result).FMamulHesabi);
  FKDVOraniID.Clone(TStokGrubu(Result).FKDVOraniID);
  FKDVOrani.Clone(TStokGrubu(Result).FKDVOrani);
  FTurID.Clone(TStokGrubu(Result).FTurID);
  FTur.Clone(TStokGrubu(Result).FTur);
  FIsIskontoAktif.Clone(TStokGrubu(Result).FIsIskontoAktif);
  FIskontoSatis.Clone(TStokGrubu(Result).FIskontoSatis);
  FIskontoMudur.Clone(TStokGrubu(Result).FIskontoMudur);
  FIsSatisFiyatiniKullan.Clone(TStokGrubu(Result).FIsSatisFiyatiniKullan);
  FYariMamulHesabi.Clone(TStokGrubu(Result).FYariMamulHesabi);
  FIsMaliyetAnalizFarkliDB.Clone(TStokGrubu(Result).FIsMaliyetAnalizFarkliDB);
end;

end.
