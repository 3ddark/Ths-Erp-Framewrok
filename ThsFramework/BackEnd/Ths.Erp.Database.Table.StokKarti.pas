unit Ths.Erp.Database.Table.StokKarti;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.AyarStkStokTipi,
  Ths.Erp.Database.Table.AyarStkStokGrubu,
  Ths.Erp.Database.Table.OlcuBirimi,
  Ths.Erp.Database.Table.AyarStkCinsOzelligi,
  Ths.Erp.Database.Table.SysCountry,
  Ths.Erp.Database.Table.AyarStkUrunTipi;

type
  TStokKarti = class;
  TStokKarti = class(TTable)
  private
    FStokKodu: TFieldDB;
    FStokAdi: TFieldDB;
    FStokGrubuID: TFieldDB;
    FOlcuBirimiID: TFieldDB;
    FUrunTipiID: TFieldDB;
    FAlisIskonto: TFieldDB;
    FSatisIskonto: TFieldDB;
    FYetkiliIskonto: TFieldDB;
    FStokTipiID: TFieldDB;
    FHamAlisFiyat: TFieldDB;
    FHamAlisParaBirimi: TFieldDB;
    FAlisFiyat: TFieldDB;
    FAlisParaBirimi: TFieldDB;
    FSatisFiyat: TFieldDB;
    FSatisParaBirimi: TFieldDB;
    FIhracFiyat: TFieldDB;
    FIhracParaBirimi: TFieldDB;
    FOrtalamaMaliyet: TFieldDB;
    FVarsayilaReceteID: TFieldDB;
    FEn: TFieldDB;
    FBoy: TFieldDB;
    FYukseklik: TFieldDB;
    FMenseiID: TFieldDB;
    FGtipNo: TFieldDB;
    FDiibUrunTanimi: TFieldDB;
    FEnAzStokSeviyesi: TFieldDB;
    FTanim: TFieldDB;
    FOzelKod: TFieldDB;
    FMarka: TFieldDB;
    FAgirlik: TFieldDB;
    FKapasite: TFieldDB;
    FCinsID: TFieldDB;
    FStringDegisken1: TFieldDB;
    FStringDegisken2: TFieldDB;
    FStringDegisken3: TFieldDB;
    FStringDegisken4: TFieldDB;
    FStringDegisken5: TFieldDB;
    FStringDegisken6: TFieldDB;
    FIntegerDegisken1: TFieldDB;
    FIntegerDegisken2: TFieldDB;
    FIntegerDegisken3: TFieldDB;
    FDoubleDegisken1: TFieldDB;
    FDoubleDegisken2: TFieldDB;
    FDoubleDegisken3: TFieldDB;
    FIsSatilabilir: TFieldDB;
    FIsOtomatikUretimUrunu: TFieldDB;
    FLotPartiMiktari: TFieldDB;
    FPaketMiktari: TFieldDB;
    FSeriNoTuru: TFieldDB;
    FIsHariciSeriNoIcerir: TFieldDB;
    FHariciSeriNoStokKoduID: TFieldDB;
    FTasiyiciPaketID: TFieldDB;
    FOncekiDonemCikanMiktar: TFieldDB;
    FTeminSuresi: TFieldDB;
    FStockName: TFieldDB;
    FEnStringDegisken1: TFieldDB;
    FEnStringDegisken2: TFieldDB;
    FEnStringDegisken3: TFieldDB;
    FEnStringDegisken4: TFieldDB;
    FEnStringDegisken5: TFieldDB;
    FEnStringDegisken6: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;

    procedure SelectToDatasourceHelper(pFilter: string; pPermissionControl: Boolean=True);
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property StokKodu: TFieldDB read FStokKodu write FStokKodu;
    Property StokAdi: TFieldDB read FStokAdi write FStokAdi;
    Property StokGrubuID: TFieldDB read FStokGrubuID write FStokGrubuID;
    Property OlcuBirimiID: TFieldDB read FOlcuBirimiID write FOlcuBirimiID;
    Property UrunTipiID: TFieldDB read FUrunTipiID write FUrunTipiID;
    Property AlisIskonto: TFieldDB read FAlisIskonto write FAlisIskonto;
    Property SatisIskonto: TFieldDB read FSatisIskonto write FSatisIskonto;
    Property YetkiliIskonto: TFieldDB read FYetkiliIskonto write FYetkiliIskonto;
    Property StokTipiID: TFieldDB read FStokTipiID write FStokTipiID;
    Property HamAlisFiyat: TFieldDB read FHamAlisFiyat write FHamAlisFiyat;
    Property HamAlisParaBirimi: TFieldDB read FHamAlisParaBirimi write FHamAlisParaBirimi;
    Property AlisFiyat: TFieldDB read FAlisFiyat write FAlisFiyat;
    Property AlisParaBirimi: TFieldDB read FAlisParaBirimi write FAlisParaBirimi;
    Property SatisFiyat: TFieldDB read FSatisFiyat write FSatisFiyat;
    Property SatisParaBirimi: TFieldDB read FSatisParaBirimi write FSatisParaBirimi;
    Property IhracFiyat: TFieldDB read FIhracFiyat write FIhracFiyat;
    Property IhracParaBirimi: TFieldDB read FIhracParaBirimi write FIhracParaBirimi;
    Property OrtalamaMaliyet: TFieldDB read FOrtalamaMaliyet write FOrtalamaMaliyet;
    Property VarsayilaReceteID: TFieldDB read FVarsayilaReceteID write FVarsayilaReceteID;
    Property En: TFieldDB read FEn write FEn;
    Property Boy: TFieldDB read FBoy write FBoy;
    Property Yukseklik: TFieldDB read FYukseklik write FYukseklik;
    Property MenseiID: TFieldDB read FMenseiID write FMenseiID;
    Property GtipNo: TFieldDB read FGtipNo write FGtipNo;
    Property DiibUrunTanimi: TFieldDB read FDiibUrunTanimi write FDiibUrunTanimi;
    Property EnAzStokSeviyesi: TFieldDB read FEnAzStokSeviyesi write FEnAzStokSeviyesi;
    Property Tanim: TFieldDB read FTanim write FTanim;
    Property OzelKod: TFieldDB read FOzelKod write FOzelKod;
    Property Marka: TFieldDB read FMarka write FMarka;
    Property Agirlik: TFieldDB read FAgirlik write FAgirlik;
    Property Kapasite: TFieldDB read FKapasite write FKapasite;
    Property CinsID: TFieldDB read FCinsID write FCinsID;
    Property StringDegisken1: TFieldDB read FStringDegisken1 write FStringDegisken1;
    Property StringDegisken2: TFieldDB read FStringDegisken2 write FStringDegisken2;
    Property StringDegisken3: TFieldDB read FStringDegisken3 write FStringDegisken3;
    Property StringDegisken4: TFieldDB read FStringDegisken4 write FStringDegisken4;
    Property StringDegisken5: TFieldDB read FStringDegisken5 write FStringDegisken5;
    Property StringDegisken6: TFieldDB read FStringDegisken6 write FStringDegisken6;
    Property IntegerDegisken1: TFieldDB read FIntegerDegisken1 write FIntegerDegisken1;
    Property IntegerDegisken2: TFieldDB read FIntegerDegisken2 write FIntegerDegisken2;
    Property IntegerDegisken3: TFieldDB read FIntegerDegisken3 write FIntegerDegisken3;
    Property DoubleDegisken1: TFieldDB read FDoubleDegisken1 write FDoubleDegisken1;
    Property DoubleDegisken2: TFieldDB read FDoubleDegisken2 write FDoubleDegisken2;
    Property DoubleDegisken3: TFieldDB read FDoubleDegisken3 write FDoubleDegisken3;
    Property IsSatilabilir: TFieldDB read FIsSatilabilir write FIsSatilabilir;
    Property IsOtomatikUretimUrunu: TFieldDB read FIsOtomatikUretimUrunu write FIsOtomatikUretimUrunu;
    Property LotPartiMiktari: TFieldDB read FLotPartiMiktari write FLotPartiMiktari;
    Property PaketMiktari: TFieldDB read FPaketMiktari write FPaketMiktari;
    Property SeriNoTuru: TFieldDB read FSeriNoTuru write FSeriNoTuru;
    Property IsHariciSeriNoIcerir: TFieldDB read FIsHariciSeriNoIcerir write FIsHariciSeriNoIcerir;
    Property HariciSeriNoStokKoduID: TFieldDB read FHariciSeriNoStokKoduID write FHariciSeriNoStokKoduID;
    Property TasiyiciPaketID: TFieldDB read FTasiyiciPaketID write FTasiyiciPaketID;
    Property OncekiDonemCikanMiktar: TFieldDB read FOncekiDonemCikanMiktar write FOncekiDonemCikanMiktar;
    Property TeminSuresi: TFieldDB read FTeminSuresi write FTeminSuresi;
    Property StockName: TFieldDB read FStockName write FStockName;
    Property EnStringDegisken1: TFieldDB read FEnStringDegisken1 write FEnStringDegisken1;
    Property EnStringDegisken2: TFieldDB read FEnStringDegisken2 write FEnStringDegisken2;
    Property EnStringDegisken3: TFieldDB read FEnStringDegisken3 write FEnStringDegisken3;
    Property EnStringDegisken4: TFieldDB read FEnStringDegisken4 write FEnStringDegisken4;
    Property EnStringDegisken5: TFieldDB read FEnStringDegisken5 write FEnStringDegisken5;
    Property EnStringDegisken6: TFieldDB read FEnStringDegisken6 write FEnStringDegisken6;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TStokKarti.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'stok_karti';
  SourceCode := '1030';

  FStokKodu := TFieldDB.Create('stok_kodu', ftString, '');
  FStokAdi := TFieldDB.Create('stok_adi', ftString, '');
  FStokGrubuID := TFieldDB.Create('stok_grubu_id', ftInteger, 0, 0, True);
  FStokGrubuID.FK.FKTable := TAyarStkStokGrubu.Create(Database);
  FStokGrubuID.FK.FKCol := TFieldDB.Create(TAyarStkStokGrubu(FStokGrubuID.FK.FKTable).Grup.FieldName, TAyarStkStokGrubu(FStokGrubuID.FK.FKTable).Grup.FieldType, '');
  FOlcuBirimiID := TFieldDB.Create('olcu_birimi_id', ftInteger, 0, 0, True);
  FOlcuBirimiID.FK.FKTable := TOlcuBirimi.Create(Database);
  FOlcuBirimiID.FK.FKCol := TFieldDB.Create(TOlcuBirimi(FOlcuBirimiID.FK.FKTable).Birim.FieldName, TOlcuBirimi(FOlcuBirimiID.FK.FKTable).Birim.FieldType, '');
  FUrunTipiID := TFieldDB.Create('urun_tipi_id', ftInteger, 0, 0, True);
  FUrunTipiID.FK.FKTable := TAyarStkUrunTipi.Create(Database);
  FUrunTipiID.FK.FKCol := TFieldDB.Create(TAyarStkUrunTipi(FUrunTipiID.FK.FKTable).Tip.FieldName, TAyarStkUrunTipi(FUrunTipiID.FK.FKTable).Tip.FieldType, '');
  FAlisIskonto := TFieldDB.Create('alis_iskonto', ftFloat, 0);
  FSatisIskonto := TFieldDB.Create('satis_iskonto', ftFloat, 0);
  FYetkiliIskonto := TFieldDB.Create('yetkili_iskonto', ftFloat, 0);
  FStokTipiID := TFieldDB.Create('stok_tipi_id', ftInteger, 0, 0, True);
  FStokTipiID.FK.FKTable := TAyarStkStokTipi.Create(Database);
  FStokTipiID.FK.FKCol := TFieldDB.Create(TAyarStkStokTipi(FStokTipiID.FK.FKTable).Tip.FieldName, TAyarStkStokTipi(FStokTipiID.FK.FKTable).Tip.FieldType, '');
  FHamAlisFiyat := TFieldDB.Create('ham_alis_fiyat', ftFloat, 0);
  FHamAlisParaBirimi := TFieldDB.Create('ham_alis_para_birim', ftString, '');
  FAlisFiyat := TFieldDB.Create('alis_fiyat', ftFloat, 0);
  FAlisParaBirimi := TFieldDB.Create('alis_para_birim', ftString, '');
  FSatisFiyat := TFieldDB.Create('satis_fiyat', ftFloat, 0);
  FSatisParaBirimi := TFieldDB.Create('satis_para_birim', ftString, '');
  FIhracFiyat := TFieldDB.Create('ihrac_fiyat', ftFloat, 0);
  FIhracParaBirimi := TFieldDB.Create('ihrac_para_birim', ftString, '');
  FOrtalamaMaliyet := TFieldDB.Create('ortalama_maliyet', ftFloat, 0);
  FVarsayilaReceteID := TFieldDB.Create('varsayilan_recete_id', ftInteger, 0);  //Recete Tablo s�n�f� a��l�nca buras� Helper modda aktif edilecek
//  FVarsayilaReceteID.FK.FKTable := TRecete.Create(Database);
//  FVarsayilaReceteID.FK.FKCol := TFieldDB.Create(TRecete(FVarsayilaReceteID.FK.FKTable).UrunKodu.FieldName, TRecete(FVarsayilaReceteID.FK.FKTable).UrunKodu.FieldType);
  FEn := TFieldDB.Create('en', ftFloat, 0);
  FBoy := TFieldDB.Create('boy', ftFloat, 0);
  FYukseklik := TFieldDB.Create('yukseklik', ftFloat, 0);
  FMenseiID := TFieldDB.Create('mensei_id', ftInteger, 0, 0, True);
  FMenseiID.FK.FKTable := TSysCountry.Create(Database);
  FMenseiID.FK.FKCol := TFieldDB.Create(TSysCountry(FMenseiID.FK.FKTable).CountryName.FieldName, TSysCountry(FMenseiID.FK.FKTable).CountryName.FieldType, '');
  FGtipNo := TFieldDB.Create('gtip_no', ftString, '');
  FDiibUrunTanimi := TFieldDB.Create('diib_urun_tanimi', ftString, '');
  FEnAzStokSeviyesi := TFieldDB.Create('en_az_stok_seviyesi', ftFloat, 0);
  FTanim := TFieldDB.Create('tanim', ftString, '');
  FOzelKod := TFieldDB.Create('ozel_kod', ftString, '');
  FMarka := TFieldDB.Create('marka', ftString, '');
  FAgirlik := TFieldDB.Create('agirlik', ftFloat, 0);
  FKapasite := TFieldDB.Create('kapasite', ftFloat, 0);
  FCinsID := TFieldDB.Create('cins_id', ftInteger, 0, 0, True);
  FCinsID.FK.FKTable := TAyarStkCinsOzelligi.Create(Database);
  FCinsID.FK.FKCol := TFieldDB.Create(TAyarStkCinsOzelligi(FCinsID.FK.FKTable).Cins.FieldName, TAyarStkCinsOzelligi(FCinsID.FK.FKTable).Cins.FieldType, '');
  FStringDegisken1 := TFieldDB.Create('string_degisken1', ftString, '');
  FStringDegisken2 := TFieldDB.Create('string_degisken2', ftString, '');
  FStringDegisken3 := TFieldDB.Create('string_degisken3', ftString, '');
  FStringDegisken4 := TFieldDB.Create('string_degisken4', ftString, '');
  FStringDegisken5 := TFieldDB.Create('string_degisken5', ftString, '');
  FStringDegisken6 := TFieldDB.Create('string_degisken6', ftString, '');
  FIntegerDegisken1 := TFieldDB.Create('integer_degisken1', ftInteger, 0);
  FIntegerDegisken2 := TFieldDB.Create('integer_degisken2', ftInteger, 0);
  FIntegerDegisken3 := TFieldDB.Create('integer_degisken3', ftInteger, 0);
  FDoubleDegisken1 := TFieldDB.Create('double_degisken1', ftFloat, 0);
  FDoubleDegisken2 := TFieldDB.Create('double_degisken2', ftFloat, 0);
  FDoubleDegisken3 := TFieldDB.Create('double_degisken3', ftFloat, 0);
  FIsSatilabilir := TFieldDB.Create('is_satilabilir', ftBoolean, 0);
  FIsOtomatikUretimUrunu := TFieldDB.Create('is_otomatik_uretim_urunu', ftBoolean, 0);
  FLotPartiMiktari := TFieldDB.Create('lot_parti_miktari', ftFloat, 0);
  FPaketMiktari := TFieldDB.Create('paket_miktari', ftFloat, 0);
  FSeriNoTuru := TFieldDB.Create('seri_no_turu', ftString, '');
  FIsHariciSeriNoIcerir := TFieldDB.Create('is_harici_seri_no_icerir', ftBoolean, 0);
  FHariciSeriNoStokKoduID := TFieldDB.Create('harici_serino_stok_kodu_id', ftInteger, 0);
//  FHariciSeriNoStokKoduID.FK.FKTable := TCinsOzelligi.Create(Database);
//  FHariciSeriNoStokKoduID.FK.FKCol := TFieldDB.Create(TCinsOzelligi(FMenseiID.FK.FKTable).Cins.FieldName, TCinsOzelligi(FMenseiID.FK.FKTable).Cins.FieldType);
  FTasiyiciPaketID := TFieldDB.Create('tasiyici_paket_id', ftInteger, 0);
//  FTasiyiciPaketID.FK.FKTable := TCinsOzelligi.Create(Database);
//  FTasiyiciPaketID.FK.FKCol := TFieldDB.Create(TCinsOzelligi(FMenseiID.FK.FKTable).Cins.FieldName, TCinsOzelligi(FMenseiID.FK.FKTable).Cins.FieldType);
  FOncekiDonemCikanMiktar := TFieldDB.Create('onceki_donem_cikan_miktar', ftFloat, 0);
  FTeminSuresi := TFieldDB.Create('temin_suresi', ftInteger, 0);
  FStockName := TFieldDB.Create('stock_name', ftString, '');
  FEnStringDegisken1 := TFieldDB.Create('en_string_degisken1', ftInteger, 0);
  FEnStringDegisken2 := TFieldDB.Create('en_string_degisken2', ftInteger, 0);
  FEnStringDegisken3 := TFieldDB.Create('en_string_degisken3', ftInteger, 0);
  FEnStringDegisken4 := TFieldDB.Create('en_string_degisken4', ftInteger, 0);
  FEnStringDegisken5 := TFieldDB.Create('en_string_degisken5', ftInteger, 0);
  FEnStringDegisken6 := TFieldDB.Create('en_string_degisken6', ftInteger, 0);
end;

procedure TStokKarti.SelectToDatasourceHelper(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FStokKodu.FieldName,
        TableName + '.' + FStokAdi.FieldName,
        TableName + '.' + FStokGrubuID.FieldName,
        ColumnFromIDCol(FStokGrubuID.FK.FKCol.FieldName, FStokGrubuID.FK.FKTable.TableName, FStokGrubuID.FieldName, FStokGrubuID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FOlcuBirimiID.FieldName,
        ColumnFromIDCol(FOlcuBirimiID.FK.FKCol.FieldName, FOlcuBirimiID.FK.FKTable.TableName, FOlcuBirimiID.FieldName, FOlcuBirimiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FStokTipiID.FieldName,
        ColumnFromIDCol(FStokTipiID.FK.FKCol.FieldName, FStokTipiID.FK.FKTable.TableName, FStokTipiID.FieldName, FStokTipiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FSatisFiyat.FieldName,
        TableName + '.' + FSatisParaBirimi.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FStokKodu.FieldName).DisplayLabel := 'Stok Kodu';
      Self.DataSource.DataSet.FindField(FStokAdi.FieldName).DisplayLabel := 'Stok Ad�';
      Self.DataSource.DataSet.FindField(FStokGrubuID.FieldName).DisplayLabel := 'Stok Grubu ID';
      Self.DataSource.DataSet.FindField(FStokGrubuID.FK.FKCol.FieldName).DisplayLabel := 'Stok Grubu';
      Self.DataSource.DataSet.FindField(FOlcuBirimiID.FieldName).DisplayLabel := '�l�� Birimi ID';
      Self.DataSource.DataSet.FindField(FOlcuBirimiID.FK.FKCol.FieldName).DisplayLabel := '�l�� Birimi';
      Self.DataSource.DataSet.FindField(FStokTipiID.FieldName).DisplayLabel := 'Stok Tipi ID';
      Self.DataSource.DataSet.FindField(FStokTipiID.FK.FKCol.FieldName).DisplayLabel := 'Stok Tipi';
      Self.DataSource.DataSet.FindField(FSatisFiyat.FieldName).DisplayLabel := 'Sat�� Fiyat';
      Self.DataSource.DataSet.FindField(FSatisParaBirimi.FieldName).DisplayLabel := 'Sat�� Para Birimi';
    end;
  end;
end;

procedure TStokKarti.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FStokKodu.FieldName,
        TableName + '.' + FStokAdi.FieldName,
        TableName + '.' + FStokGrubuID.FieldName,
        ColumnFromIDCol(FStokGrubuID.FK.FKCol.FieldName, FStokGrubuID.FK.FKTable.TableName, FStokGrubuID.FieldName, FStokGrubuID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FOlcuBirimiID.FieldName,
        ColumnFromIDCol(FOlcuBirimiID.FK.FKCol.FieldName, FOlcuBirimiID.FK.FKTable.TableName, FOlcuBirimiID.FieldName, FOlcuBirimiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FUrunTipiID.FieldName,
        ColumnFromIDCol(FUrunTipiID.FK.FKCol.FieldName, FUrunTipiID.FK.FKTable.TableName, FUrunTipiID.FieldName, FUrunTipiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FAlisIskonto.FieldName,
        TableName + '.' + FSatisIskonto.FieldName,
        TableName + '.' + FYetkiliIskonto.FieldName,
        TableName + '.' + FStokTipiID.FieldName,
        ColumnFromIDCol(FStokTipiID.FK.FKCol.FieldName, FStokTipiID.FK.FKTable.TableName, FStokTipiID.FieldName, FStokTipiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FHamAlisFiyat.FieldName,
        TableName + '.' + FHamAlisParaBirimi.FieldName,
        TableName + '.' + FAlisFiyat.FieldName,
        TableName + '.' + FAlisParaBirimi.FieldName,
        TableName + '.' + FSatisFiyat.FieldName,
        TableName + '.' + FSatisParaBirimi.FieldName,
        TableName + '.' + FIhracFiyat.FieldName,
        TableName + '.' + FIhracParaBirimi.FieldName,
        TableName + '.' + FOrtalamaMaliyet.FieldName,
        TableName + '.' + FVarsayilaReceteID.FieldName,
//        ColumnFromIDCol(FVarsayilaReceteID.FK.FKCol.FieldName, FVarsayilaReceteID.FK.FKTable.TableName, FVarsayilaReceteID.FieldName, FVarsayilaReceteID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FEn.FieldName,
        TableName + '.' + FBoy.FieldName,
        TableName + '.' + FYukseklik.FieldName,
        TableName + '.' + FMenseiID.FieldName,
        ColumnFromIDCol(FMenseiID.FK.FKCol.FieldName, FMenseiID.FK.FKTable.TableName, FMenseiID.FieldName, FMenseiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FGtipNo.FieldName,
        TableName + '.' + FDiibUrunTanimi.FieldName,
        TableName + '.' + FEnAzStokSeviyesi.FieldName,
        TableName + '.' + FTanim.FieldName,
        TableName + '.' + FOzelKod.FieldName,
        TableName + '.' + FMarka.FieldName,
        TableName + '.' + FAgirlik.FieldName,
        TableName + '.' + FKapasite.FieldName,
        TableName + '.' + FCinsID.FieldName,
        ColumnFromIDCol(FCinsID.FK.FKCol.FieldName, FCinsID.FK.FKTable.TableName, FCinsID.FieldName, FCinsID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FStringDegisken1.FieldName,
        TableName + '.' + FStringDegisken2.FieldName,
        TableName + '.' + FStringDegisken3.FieldName,
        TableName + '.' + FStringDegisken4.FieldName,
        TableName + '.' + FStringDegisken5.FieldName,
        TableName + '.' + FStringDegisken6.FieldName,
        TableName + '.' + FIntegerDegisken1.FieldName,
        TableName + '.' + FIntegerDegisken2.FieldName,
        TableName + '.' + FIntegerDegisken3.FieldName,
        TableName + '.' + FDoubleDegisken1.FieldName,
        TableName + '.' + FDoubleDegisken2.FieldName,
        TableName + '.' + FDoubleDegisken3.FieldName,
        TableName + '.' + FIsSatilabilir.FieldName,
        TableName + '.' + FIsOtomatikUretimUrunu.FieldName,
        TableName + '.' + FLotPartiMiktari.FieldName,
        TableName + '.' + FPaketMiktari.FieldName,
        TableName + '.' + FSeriNoTuru.FieldName,
        TableName + '.' + FIsHariciSeriNoIcerir.FieldName,
        TableName + '.' + FHariciSeriNoStokKoduID.FieldName,
//        ColumnFromIDCol(FHariciSeriNoStokKoduID.FK.FKCol.FieldName, FHariciSeriNoStokKoduID.FK.FKTable.TableName, FHariciSeriNoStokKoduID.FieldName, FHariciSeriNoStokKoduID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FTasiyiciPaketID.FieldName,
//        ColumnFromIDCol(FTasiyiciPaketID.FK.FKCol.FieldName, FTasiyiciPaketID.FK.FKTable.TableName, FTasiyiciPaketID.FieldName, FTasiyiciPaketID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FOncekiDonemCikanMiktar.FieldName,
        TableName + '.' + FTeminSuresi.FieldName
//        TableName + '.' + FStockName.FieldName,
//        TableName + '.' + FEnStringDegisken1.FieldName,
//        TableName + '.' + FEnStringDegisken2.FieldName,
//        TableName + '.' + FEnStringDegisken3.FieldName,
//        TableName + '.' + FEnStringDegisken4.FieldName,
//        TableName + '.' + FEnStringDegisken5.FieldName,
//        TableName + '.' + FEnStringDegisken6.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'Id';
      Self.DataSource.DataSet.FindField(FStokKodu.FieldName).DisplayLabel := 'Stok Kodu';
      Self.DataSource.DataSet.FindField(FStokAdi.FieldName).DisplayLabel := 'Stok Ad�';
      Self.DataSource.DataSet.FindField(FStokGrubuID.FieldName).DisplayLabel := 'Stok Grubu ID';
      Self.DataSource.DataSet.FindField(FStokGrubuID.FK.FKCol.FieldName).DisplayLabel := 'Stok Grubu';
      Self.DataSource.DataSet.FindField(FOlcuBirimiID.FieldName).DisplayLabel := '�l�� Birimi ID';
      Self.DataSource.DataSet.FindField(FOlcuBirimiID.FK.FKCol.FieldName).DisplayLabel := '�l�� Birimi';
      Self.DataSource.DataSet.FindField(FUrunTipiID.FieldName).DisplayLabel := '�r�n Tipi ID';
      Self.DataSource.DataSet.FindField(FUrunTipiID.FK.FKCol.FieldName).DisplayLabel := '�r�n Tipi';
      Self.DataSource.DataSet.FindField(FAlisIskonto.FieldName).DisplayLabel := 'Al�� �skonto';
      Self.DataSource.DataSet.FindField(FSatisIskonto.FieldName).DisplayLabel := 'Sat�� �skonto';
      Self.DataSource.DataSet.FindField(FYetkiliIskonto.FieldName).DisplayLabel := 'Yetkili �skonto';
      Self.DataSource.DataSet.FindField(FStokTipiID.FieldName).DisplayLabel := 'Stok Tipi ID';
      Self.DataSource.DataSet.FindField(FStokTipiID.FK.FKCol.FieldName).DisplayLabel := 'Stok Tipi';
      Self.DataSource.DataSet.FindField(FHamAlisFiyat.FieldName).DisplayLabel := 'Ham Al�� Fiyat';
      Self.DataSource.DataSet.FindField(FHamAlisParaBirimi.FieldName).DisplayLabel := 'Ham Al�� Para Birimi';
      Self.DataSource.DataSet.FindField(FAlisFiyat.FieldName).DisplayLabel := 'Al�� Fiyat';
      Self.DataSource.DataSet.FindField(FAlisParaBirimi.FieldName).DisplayLabel := 'Al�� Para Birimi';
      Self.DataSource.DataSet.FindField(FSatisFiyat.FieldName).DisplayLabel := 'Sat�� Fiyat';
      Self.DataSource.DataSet.FindField(FSatisParaBirimi.FieldName).DisplayLabel := 'Sat�� Para Birimi';
      Self.DataSource.DataSet.FindField(FIhracFiyat.FieldName).DisplayLabel := '�hra� Fiyat�';
      Self.DataSource.DataSet.FindField(FIhracParaBirimi.FieldName).DisplayLabel := '�hra� Para Birimi';
      Self.DataSource.DataSet.FindField(FOrtalamaMaliyet.FieldName).DisplayLabel := 'Ortalama Maliyet';
      Self.DataSource.DataSet.FindField(FVarsayilaReceteID.FieldName).DisplayLabel := 'Varsay�lan Re�ete ID';
//        Self.DataSource.DataSet.FindField(FVarsayilanRecete.FieldName).DisplayLabel := 'Varsay�lan Re�ete';
      Self.DataSource.DataSet.FindField(FEn.FieldName).DisplayLabel := 'En';
      Self.DataSource.DataSet.FindField(FBoy.FieldName).DisplayLabel := 'Boy';
      Self.DataSource.DataSet.FindField(FYukseklik.FieldName).DisplayLabel := 'Y�kseklik';
      Self.DataSource.DataSet.FindField(FMenseiID.FieldName).DisplayLabel := 'Men�ei ID';
      Self.DataSource.DataSet.FindField(FMenseiID.FK.FKCol.FieldName).DisplayLabel := 'Men�ei';
      Self.DataSource.DataSet.FindField(FGtipNo.FieldName).DisplayLabel := 'GTIP No';
      Self.DataSource.DataSet.FindField(FDiibUrunTanimi.FieldName).DisplayLabel := 'D��B �r�n Tan�m�';
      Self.DataSource.DataSet.FindField(FEnAzStokSeviyesi.FieldName).DisplayLabel := 'En Az Stok Seviyesi';
      Self.DataSource.DataSet.FindField(FTanim.FieldName).DisplayLabel := 'Tan�m';
      Self.DataSource.DataSet.FindField(FOzelKod.FieldName).DisplayLabel := '�zel Kod';
      Self.DataSource.DataSet.FindField(FMarka.FieldName).DisplayLabel := 'Marka';
      Self.DataSource.DataSet.FindField(FAgirlik.FieldName).DisplayLabel := 'A��rl�k';
      Self.DataSource.DataSet.FindField(FKapasite.FieldName).DisplayLabel := 'Kapasite';
      Self.DataSource.DataSet.FindField(FCinsID.FieldName).DisplayLabel := 'Cins ID';
      Self.DataSource.DataSet.FindField(FCinsID.FK.FKCol.FieldName).DisplayLabel := 'Cins';
      Self.DataSource.DataSet.FindField(FStringDegisken1.FieldName).DisplayLabel := 'String De�i�ken 1';
      Self.DataSource.DataSet.FindField(FStringDegisken2.FieldName).DisplayLabel := 'String De�i�ken 2';
      Self.DataSource.DataSet.FindField(FStringDegisken3.FieldName).DisplayLabel := 'String De�i�ken 3';
      Self.DataSource.DataSet.FindField(FStringDegisken4.FieldName).DisplayLabel := 'String De�i�ken 4';
      Self.DataSource.DataSet.FindField(FStringDegisken5.FieldName).DisplayLabel := 'String De�i�ken 5';
      Self.DataSource.DataSet.FindField(FStringDegisken6.FieldName).DisplayLabel := 'String De�i�ken 6';
      Self.DataSource.DataSet.FindField(FIntegerDegisken1.FieldName).DisplayLabel := 'Integer De�i�ken 1';
      Self.DataSource.DataSet.FindField(FIntegerDegisken2.FieldName).DisplayLabel := 'Integer De�i�ken2';
      Self.DataSource.DataSet.FindField(FIntegerDegisken3.FieldName).DisplayLabel := 'Integer De�i�ken 3';
      Self.DataSource.DataSet.FindField(FDoubleDegisken1.FieldName).DisplayLabel := 'Double De�i�ken 1';
      Self.DataSource.DataSet.FindField(FDoubleDegisken2.FieldName).DisplayLabel := 'Double De�i�ken 2';
      Self.DataSource.DataSet.FindField(FDoubleDegisken3.FieldName).DisplayLabel := 'Double De�i�ken 3';
      Self.DataSource.DataSet.FindField(FIsSatilabilir.FieldName).DisplayLabel := 'Sat�labilir?';
      Self.DataSource.DataSet.FindField(FIsOtomatikUretimUrunu.FieldName).DisplayLabel := 'Otomatik �retim �r�n�?';
      Self.DataSource.DataSet.FindField(FLotPartiMiktari.FieldName).DisplayLabel := 'Lot Parti Miktar�';
      Self.DataSource.DataSet.FindField(FPaketMiktari.FieldName).DisplayLabel := 'Paket Miktar�';
      Self.DataSource.DataSet.FindField(FSeriNoTuru.FieldName).DisplayLabel := 'Seri No T�r�';
      Self.DataSource.DataSet.FindField(FIsHariciSeriNoIcerir.FieldName).DisplayLabel := 'Harici Seri No ��erir';
      Self.DataSource.DataSet.FindField(FHariciSeriNoStokKoduID.FieldName).DisplayLabel := 'Harici Seri No Stok Kodu ID';
//      Self.DataSource.DataSet.FindField(FHariciSeriNoStokKoduID.FK.FKCol.FieldName).DisplayLabel := 'Harici SeriNo Stok Kodu';
      Self.DataSource.DataSet.FindField(FTasiyiciPaketID.FieldName).DisplayLabel := 'Ta��y�c� Paket ID';
//        Self.DataSource.DataSet.FindField(FTasiyiciPaket.FieldName).DisplayLabel := 'Ta��y�c� Paket';
      Self.DataSource.DataSet.FindField(FOncekiDonemCikanMiktar.FieldName).DisplayLabel := '�nceki D�nem ��kan Miktar';
      Self.DataSource.DataSet.FindField(FTeminSuresi.FieldName).DisplayLabel := 'Temin S�resi';
//      Self.DataSource.DataSet.FindField(FStockName.FieldName).DisplayLabel := 'Stock Name';
//      Self.DataSource.DataSet.FindField(FEnStringDegisken1.FieldName).DisplayLabel := 'En String De�i�ken 1';
//      Self.DataSource.DataSet.FindField(FEnStringDegisken2.FieldName).DisplayLabel := 'En String De�i�ken 2';
//      Self.DataSource.DataSet.FindField(FEnStringDegisken3.FieldName).DisplayLabel := 'En String De�i�ken 3';
//      Self.DataSource.DataSet.FindField(FEnStringDegisken4.FieldName).DisplayLabel := 'En String De�i�ken 4';
//      Self.DataSource.DataSet.FindField(FEnStringDegisken5.FieldName).DisplayLabel := 'En String De�i�ken 5';
//      Self.DataSource.DataSet.FindField(FEnStringDegisken6.FieldName).DisplayLabel := 'En String De�i�ken 6';
    end;
  end;
end;

procedure TStokKarti.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FStokKodu.FieldName,
        TableName + '.' + FStokAdi.FieldName,
        TableName + '.' + FStokGrubuID.FieldName,
        ColumnFromIDCol(FStokGrubuID.FK.FKCol.FieldName, FStokGrubuID.FK.FKTable.TableName, FStokGrubuID.FieldName, FStokGrubuID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FOlcuBirimiID.FieldName,
        ColumnFromIDCol(FOlcuBirimiID.FK.FKCol.FieldName, FOlcuBirimiID.FK.FKTable.TableName, FOlcuBirimiID.FieldName, FOlcuBirimiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FUrunTipiID.FieldName,
        ColumnFromIDCol(FUrunTipiID.FK.FKCol.FieldName, FUrunTipiID.FK.FKTable.TableName, FUrunTipiID.FieldName, FUrunTipiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FAlisIskonto.FieldName,
        TableName + '.' + FSatisIskonto.FieldName,
        TableName + '.' + FYetkiliIskonto.FieldName,
        TableName + '.' + FStokTipiID.FieldName,
        ColumnFromIDCol(FStokTipiID.FK.FKCol.FieldName, FStokTipiID.FK.FKTable.TableName, FStokTipiID.FieldName, FStokTipiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FHamAlisFiyat.FieldName,
        TableName + '.' + FHamAlisParaBirimi.FieldName,
        TableName + '.' + FAlisFiyat.FieldName,
        TableName + '.' + FAlisParaBirimi.FieldName,
        TableName + '.' + FSatisFiyat.FieldName,
        TableName + '.' + FSatisParaBirimi.FieldName,
        TableName + '.' + FIhracFiyat.FieldName,
        TableName + '.' + FIhracParaBirimi.FieldName,
        TableName + '.' + FOrtalamaMaliyet.FieldName,
        TableName + '.' + FVarsayilaReceteID.FieldName,
//        ColumnFromIDCol(FVarsayilaReceteID.FK.FKCol.FieldName, FVarsayilaReceteID.FK.FKTable.TableName, FVarsayilaReceteID.FieldName, FVarsayilaReceteID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FEn.FieldName,
        TableName + '.' + FBoy.FieldName,
        TableName + '.' + FYukseklik.FieldName,
        TableName + '.' + FMenseiID.FieldName,
        ColumnFromIDCol(FMenseiID.FK.FKCol.FieldName, FMenseiID.FK.FKTable.TableName, FMenseiID.FieldName, FMenseiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FGtipNo.FieldName,
        TableName + '.' + FDiibUrunTanimi.FieldName,
        TableName + '.' + FEnAzStokSeviyesi.FieldName,
        TableName + '.' + FTanim.FieldName,
        TableName + '.' + FOzelKod.FieldName,
        TableName + '.' + FMarka.FieldName,
        TableName + '.' + FAgirlik.FieldName,
        TableName + '.' + FKapasite.FieldName,
        TableName + '.' + FCinsID.FieldName,
        ColumnFromIDCol(FCinsID.FK.FKCol.FieldName, FCinsID.FK.FKTable.TableName, FCinsID.FieldName, FCinsID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FStringDegisken1.FieldName,
        TableName + '.' + FStringDegisken2.FieldName,
        TableName + '.' + FStringDegisken3.FieldName,
        TableName + '.' + FStringDegisken4.FieldName,
        TableName + '.' + FStringDegisken5.FieldName,
        TableName + '.' + FStringDegisken6.FieldName,
        TableName + '.' + FIntegerDegisken1.FieldName,
        TableName + '.' + FIntegerDegisken2.FieldName,
        TableName + '.' + FIntegerDegisken3.FieldName,
        TableName + '.' + FDoubleDegisken1.FieldName,
        TableName + '.' + FDoubleDegisken2.FieldName,
        TableName + '.' + FDoubleDegisken3.FieldName,
        TableName + '.' + FIsSatilabilir.FieldName,
        TableName + '.' + FIsOtomatikUretimUrunu.FieldName,
        TableName + '.' + FLotPartiMiktari.FieldName,
        TableName + '.' + FPaketMiktari.FieldName,
        TableName + '.' + FSeriNoTuru.FieldName,
        TableName + '.' + FIsHariciSeriNoIcerir.FieldName,
        TableName + '.' + FHariciSeriNoStokKoduID.FieldName,
//        ColumnFromIDCol(FHariciSeriNoStokKoduID.FK.FKCol.FieldName, FHariciSeriNoStokKoduID.FK.FKTable.TableName, FHariciSeriNoStokKoduID.FieldName, FHariciSeriNoStokKoduID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FTasiyiciPaketID.FieldName,
//        ColumnFromIDCol(FTasiyiciPaketID.FK.FKCol.FieldName, FTasiyiciPaketID.FK.FKTable.TableName, FTasiyiciPaketID.FieldName, FTasiyiciPaketID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FOncekiDonemCikanMiktar.FieldName,
        TableName + '.' + FTeminSuresi.FieldName
//        TableName + '.' + FStockName.FieldName,
//        TableName + '.' + FEnStringDegisken1.FieldName,
//        TableName + '.' + FEnStringDegisken2.FieldName,
//        TableName + '.' + FEnStringDegisken3.FieldName,
//        TableName + '.' + FEnStringDegisken4.FieldName,
//        TableName + '.' + FEnStringDegisken5.FieldName,
//        TableName + '.' + FEnStringDegisken6.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FStokKodu.Value := FormatedVariantVal(FieldByName(FStokKodu.FieldName).DataType, FieldByName(FStokKodu.FieldName).Value);
        FStokAdi.Value := FormatedVariantVal(FieldByName(FStokAdi.FieldName).DataType, FieldByName(FStokAdi.FieldName).Value);
        FStokGrubuID.Value := FormatedVariantVal(FieldByName(FStokGrubuID.FieldName).DataType, FieldByName(FStokGrubuID.FieldName).Value);
        FStokGrubuID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FStokGrubuID.FK.FKCol.FieldName).DataType, FieldByName(FStokGrubuID.FK.FKCol.FieldName).Value);
        FOlcuBirimiID.Value := FormatedVariantVal(FieldByName(FOlcuBirimiID.FieldName).DataType, FieldByName(FOlcuBirimiID.FieldName).Value);
        FOlcuBirimiID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FOlcuBirimiID.FK.FKCol.FieldName).DataType, FieldByName(FOlcuBirimiID.FK.FKCol.FieldName).Value);
        FUrunTipiID.Value := FormatedVariantVal(FieldByName(FUrunTipiID.FieldName).DataType, FieldByName(FUrunTipiID.FieldName).Value);
        FUrunTipiID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FUrunTipiID.FK.FKCol.FieldName).DataType, FieldByName(FUrunTipiID.FK.FKCol.FieldName).Value);
        FAlisIskonto.Value := FormatedVariantVal(FieldByName(FAlisIskonto.FieldName).DataType, FieldByName(FAlisIskonto.FieldName).Value);
        FSatisIskonto.Value := FormatedVariantVal(FieldByName(FSatisIskonto.FieldName).DataType, FieldByName(FSatisIskonto.FieldName).Value);
        FYetkiliIskonto.Value := FormatedVariantVal(FieldByName(FYetkiliIskonto.FieldName).DataType, FieldByName(FYetkiliIskonto.FieldName).Value);
        FStokTipiID.Value := FormatedVariantVal(FieldByName(FStokTipiID.FieldName).DataType, FieldByName(FStokTipiID.FieldName).Value);
        FStokTipiID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FStokTipiID.FK.FKCol.FieldName).DataType, FieldByName(FStokTipiID.FK.FKCol.FieldName).Value);
        FHamAlisFiyat.Value := FormatedVariantVal(FieldByName(FHamAlisFiyat.FieldName).DataType, FieldByName(FHamAlisFiyat.FieldName).Value);
        FHamAlisParaBirimi.Value := FormatedVariantVal(FieldByName(FHamAlisParaBirimi.FieldName).DataType, FieldByName(FHamAlisParaBirimi.FieldName).Value);
        FAlisFiyat.Value := FormatedVariantVal(FieldByName(FAlisFiyat.FieldName).DataType, FieldByName(FAlisFiyat.FieldName).Value);
        FAlisParaBirimi.Value := FormatedVariantVal(FieldByName(FAlisParaBirimi.FieldName).DataType, FieldByName(FAlisParaBirimi.FieldName).Value);
        FSatisFiyat.Value := FormatedVariantVal(FieldByName(FSatisFiyat.FieldName).DataType, FieldByName(FSatisFiyat.FieldName).Value);
        FSatisParaBirimi.Value := FormatedVariantVal(FieldByName(FSatisParaBirimi.FieldName).DataType, FieldByName(FSatisParaBirimi.FieldName).Value);
        FIhracFiyat.Value := FormatedVariantVal(FieldByName(FIhracFiyat.FieldName).DataType, FieldByName(FIhracFiyat.FieldName).Value);
        FIhracParaBirimi.Value := FormatedVariantVal(FieldByName(FIhracParaBirimi.FieldName).DataType, FieldByName(FIhracParaBirimi.FieldName).Value);
        FOrtalamaMaliyet.Value := FormatedVariantVal(FieldByName(FOrtalamaMaliyet.FieldName).DataType, FieldByName(FOrtalamaMaliyet.FieldName).Value);
        FVarsayilaReceteID.Value := FormatedVariantVal(FieldByName(FVarsayilaReceteID.FieldName).DataType, FieldByName(FVarsayilaReceteID.FieldName).Value);
//        FVarsayilanRecete.Value := FormatedVariantVal(FieldByName(FVarsayilanRecete.FieldName).DataType, FieldByName(FVarsayilanRecete.FieldName).Value);
        FEn.Value := FormatedVariantVal(FieldByName(FEn.FieldName).DataType, FieldByName(FEn.FieldName).Value);
        FBoy.Value := FormatedVariantVal(FieldByName(FBoy.FieldName).DataType, FieldByName(FBoy.FieldName).Value);
        FYukseklik.Value := FormatedVariantVal(FieldByName(FYukseklik.FieldName).DataType, FieldByName(FYukseklik.FieldName).Value);
        FMenseiID.Value := FormatedVariantVal(FieldByName(FMenseiID.FieldName).DataType, FieldByName(FMenseiID.FieldName).Value);
        FMenseiID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FMenseiID.FK.FKCol.FieldName).DataType, FieldByName(FMenseiID.FK.FKCol.FieldName).Value);
        FGtipNo.Value := FormatedVariantVal(FieldByName(FGtipNo.FieldName).DataType, FieldByName(FGtipNo.FieldName).Value);
        FDiibUrunTanimi.Value := FormatedVariantVal(FieldByName(FDiibUrunTanimi.FieldName).DataType, FieldByName(FDiibUrunTanimi.FieldName).Value);
        FEnAzStokSeviyesi.Value := FormatedVariantVal(FieldByName(FEnAzStokSeviyesi.FieldName).DataType, FieldByName(FEnAzStokSeviyesi.FieldName).Value);
        FTanim.Value := FormatedVariantVal(FieldByName(FTanim.FieldName).DataType, FieldByName(FTanim.FieldName).Value);
        FOzelKod.Value := FormatedVariantVal(FieldByName(FOzelKod.FieldName).DataType, FieldByName(FOzelKod.FieldName).Value);
        FMarka.Value := FormatedVariantVal(FieldByName(FMarka.FieldName).DataType, FieldByName(FMarka.FieldName).Value);
        FAgirlik.Value := FormatedVariantVal(FieldByName(FAgirlik.FieldName).DataType, FieldByName(FAgirlik.FieldName).Value);
        FKapasite.Value := FormatedVariantVal(FieldByName(FKapasite.FieldName).DataType, FieldByName(FKapasite.FieldName).Value);
        FCinsID.Value := FormatedVariantVal(FieldByName(FCinsID.FieldName).DataType, FieldByName(FCinsID.FieldName).Value);
        FCinsID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FCinsID.FK.FKCol.FieldName).DataType, FieldByName(FCinsID.FK.FKCol.FieldName).Value);
        FStringDegisken1.Value := FormatedVariantVal(FieldByName(FStringDegisken1.FieldName).DataType, FieldByName(FStringDegisken1.FieldName).Value);
        FStringDegisken2.Value := FormatedVariantVal(FieldByName(FStringDegisken2.FieldName).DataType, FieldByName(FStringDegisken2.FieldName).Value);
        FStringDegisken3.Value := FormatedVariantVal(FieldByName(FStringDegisken3.FieldName).DataType, FieldByName(FStringDegisken3.FieldName).Value);
        FStringDegisken4.Value := FormatedVariantVal(FieldByName(FStringDegisken4.FieldName).DataType, FieldByName(FStringDegisken4.FieldName).Value);
        FStringDegisken5.Value := FormatedVariantVal(FieldByName(FStringDegisken5.FieldName).DataType, FieldByName(FStringDegisken5.FieldName).Value);
        FStringDegisken6.Value := FormatedVariantVal(FieldByName(FStringDegisken6.FieldName).DataType, FieldByName(FStringDegisken6.FieldName).Value);
        FIntegerDegisken1.Value := FormatedVariantVal(FieldByName(FIntegerDegisken1.FieldName).DataType, FieldByName(FIntegerDegisken1.FieldName).Value);
        FIntegerDegisken2.Value := FormatedVariantVal(FieldByName(FIntegerDegisken2.FieldName).DataType, FieldByName(FIntegerDegisken2.FieldName).Value);
        FIntegerDegisken3.Value := FormatedVariantVal(FieldByName(FIntegerDegisken3.FieldName).DataType, FieldByName(FIntegerDegisken3.FieldName).Value);
        FDoubleDegisken1.Value := FormatedVariantVal(FieldByName(FDoubleDegisken1.FieldName).DataType, FieldByName(FDoubleDegisken1.FieldName).Value);
        FDoubleDegisken2.Value := FormatedVariantVal(FieldByName(FDoubleDegisken2.FieldName).DataType, FieldByName(FDoubleDegisken2.FieldName).Value);
        FDoubleDegisken3.Value := FormatedVariantVal(FieldByName(FDoubleDegisken3.FieldName).DataType, FieldByName(FDoubleDegisken3.FieldName).Value);
        FIsSatilabilir.Value := FormatedVariantVal(FieldByName(FIsSatilabilir.FieldName).DataType, FieldByName(FIsSatilabilir.FieldName).Value);
        FIsOtomatikUretimUrunu.Value := FormatedVariantVal(FieldByName(FIsOtomatikUretimUrunu.FieldName).DataType, FieldByName(FIsOtomatikUretimUrunu.FieldName).Value);
        FLotPartiMiktari.Value := FormatedVariantVal(FieldByName(FLotPartiMiktari.FieldName).DataType, FieldByName(FLotPartiMiktari.FieldName).Value);
        FPaketMiktari.Value := FormatedVariantVal(FieldByName(FPaketMiktari.FieldName).DataType, FieldByName(FPaketMiktari.FieldName).Value);
        FSeriNoTuru.Value := FormatedVariantVal(FieldByName(FSeriNoTuru.FieldName).DataType, FieldByName(FSeriNoTuru.FieldName).Value);
        FIsHariciSeriNoIcerir.Value := FormatedVariantVal(FieldByName(FIsHariciSeriNoIcerir.FieldName).DataType, FieldByName(FIsHariciSeriNoIcerir.FieldName).Value);
        FHariciSeriNoStokKoduID.Value := FormatedVariantVal(FieldByName(FHariciSeriNoStokKoduID.FieldName).DataType, FieldByName(FHariciSeriNoStokKoduID.FieldName).Value);
//        FHariciSeriNoStokKoduID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FHariciSeriNoStokKoduID.FK.FKCol.FieldName).DataType, FieldByName(FHariciSeriNoStokKoduID.FK.FKCol.FieldName).Value);
        FTasiyiciPaketID.Value := FormatedVariantVal(FieldByName(FTasiyiciPaketID.FieldName).DataType, FieldByName(FTasiyiciPaketID.FieldName).Value);
//          FTasiyiciPaket.Value := FormatedVariantVal(FieldByName(FTasiyiciPaket.FieldName).DataType, FieldByName(FTasiyiciPaket.FieldName).Value);
        FOncekiDonemCikanMiktar.Value := FormatedVariantVal(FieldByName(FOncekiDonemCikanMiktar.FieldName).DataType, FieldByName(FOncekiDonemCikanMiktar.FieldName).Value);
        FTeminSuresi.Value := FormatedVariantVal(FieldByName(FTeminSuresi.FieldName).DataType, FieldByName(FTeminSuresi.FieldName).Value);
//        FStockName.Value := FormatedVariantVal(FieldByName(FStockName.FieldName).DataType, FieldByName(FStockName.FieldName).Value);
//        FEnStringDegisken1.Value := FormatedVariantVal(FieldByName(FEnStringDegisken1.FieldName).DataType, FieldByName(FEnStringDegisken1.FieldName).Value);
//        FEnStringDegisken2.Value := FormatedVariantVal(FieldByName(FEnStringDegisken2.FieldName).DataType, FieldByName(FEnStringDegisken2.FieldName).Value);
//        FEnStringDegisken3.Value := FormatedVariantVal(FieldByName(FEnStringDegisken3.FieldName).DataType, FieldByName(FEnStringDegisken3.FieldName).Value);
//        FEnStringDegisken4.Value := FormatedVariantVal(FieldByName(FEnStringDegisken4.FieldName).DataType, FieldByName(FEnStringDegisken4.FieldName).Value);
//        FEnStringDegisken5.Value := FormatedVariantVal(FieldByName(FEnStringDegisken5.FieldName).DataType, FieldByName(FEnStringDegisken5.FieldName).Value);
//        FEnStringDegisken6.Value := FormatedVariantVal(FieldByName(FEnStringDegisken6.FieldName).DataType, FieldByName(FEnStringDegisken6.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TStokKarti.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FStokKodu.FieldName,
        FStokAdi.FieldName,
        FStokGrubuID.FieldName,
        FOlcuBirimiID.FieldName,
        FUrunTipiID.FieldName,
        FAlisIskonto.FieldName,
        FSatisIskonto.FieldName,
        FYetkiliIskonto.FieldName,
        FStokTipiID.FieldName,
        FHamAlisFiyat.FieldName,
        FHamAlisParaBirimi.FieldName,
        FAlisFiyat.FieldName,
        FAlisParaBirimi.FieldName,
        FSatisFiyat.FieldName,
        FSatisParaBirimi.FieldName,
        FIhracFiyat.FieldName,
        FIhracParaBirimi.FieldName,
        FVarsayilaReceteID.FieldName,
        FEn.FieldName,
        FBoy.FieldName,
        FYukseklik.FieldName,
        FMenseiID.FieldName,
        FGtipNo.FieldName,
        FDiibUrunTanimi.FieldName,
        FEnAzStokSeviyesi.FieldName,
        FTanim.FieldName,
        FOzelKod.FieldName,
        FMarka.FieldName,
        FAgirlik.FieldName,
        FKapasite.FieldName,
        FCinsID.FieldName,
        FStringDegisken1.FieldName,
        FStringDegisken2.FieldName,
        FStringDegisken3.FieldName,
        FStringDegisken4.FieldName,
        FStringDegisken5.FieldName,
        FStringDegisken6.FieldName,
        FIntegerDegisken1.FieldName,
        FIntegerDegisken2.FieldName,
        FIntegerDegisken3.FieldName,
        FDoubleDegisken1.FieldName,
        FDoubleDegisken2.FieldName,
        FDoubleDegisken3.FieldName,
        FIsSatilabilir.FieldName,
        FIsOtomatikUretimUrunu.FieldName,
        FLotPartiMiktari.FieldName,
        FPaketMiktari.FieldName,
        FSeriNoTuru.FieldName,
        FIsHariciSeriNoIcerir.FieldName,
        FHariciSeriNoStokKoduID.FieldName,
        FTasiyiciPaketID.FieldName,
        FOncekiDonemCikanMiktar.FieldName,
        FTeminSuresi.FieldName
//        FStockName.FieldName,
//        FEnStringDegisken1.FieldName,
//        FEnStringDegisken2.FieldName,
//        FEnStringDegisken3.FieldName,
//        FEnStringDegisken4.FieldName,
//        FEnStringDegisken5.FieldName,
//        FEnStringDegisken6.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FStokKodu);
      NewParamForQuery(QueryOfUpdate, FStokAdi);
      NewParamForQuery(QueryOfUpdate, FStokGrubuID);
      NewParamForQuery(QueryOfUpdate, FOlcuBirimiID);
      NewParamForQuery(QueryOfUpdate, FUrunTipiID);
      NewParamForQuery(QueryOfUpdate, FAlisIskonto);
      NewParamForQuery(QueryOfUpdate, FSatisIskonto);
      NewParamForQuery(QueryOfUpdate, FYetkiliIskonto);
      NewParamForQuery(QueryOfUpdate, FStokTipiID);
      NewParamForQuery(QueryOfUpdate, FHamAlisFiyat);
      NewParamForQuery(QueryOfUpdate, FHamAlisParaBirimi);
      NewParamForQuery(QueryOfUpdate, FAlisFiyat);
      NewParamForQuery(QueryOfUpdate, FAlisParaBirimi);
      NewParamForQuery(QueryOfUpdate, FSatisFiyat);
      NewParamForQuery(QueryOfUpdate, FSatisParaBirimi);
      NewParamForQuery(QueryOfUpdate, FIhracFiyat);
      NewParamForQuery(QueryOfUpdate, FIhracParaBirimi);
      NewParamForQuery(QueryOfUpdate, FVarsayilaReceteID);
      NewParamForQuery(QueryOfUpdate, FEn);
      NewParamForQuery(QueryOfUpdate, FBoy);
      NewParamForQuery(QueryOfUpdate, FYukseklik);
      NewParamForQuery(QueryOfUpdate, FMenseiID);
      NewParamForQuery(QueryOfUpdate, FGtipNo);
      NewParamForQuery(QueryOfUpdate, FDiibUrunTanimi);
      NewParamForQuery(QueryOfUpdate, FEnAzStokSeviyesi);
      NewParamForQuery(QueryOfUpdate, FTanim);
      NewParamForQuery(QueryOfUpdate, FOzelKod);
      NewParamForQuery(QueryOfUpdate, FMarka);
      NewParamForQuery(QueryOfUpdate, FAgirlik);
      NewParamForQuery(QueryOfUpdate, FKapasite);
      NewParamForQuery(QueryOfUpdate, FCinsID);
      NewParamForQuery(QueryOfUpdate, FStringDegisken1);
      NewParamForQuery(QueryOfUpdate, FStringDegisken2);
      NewParamForQuery(QueryOfUpdate, FStringDegisken3);
      NewParamForQuery(QueryOfUpdate, FStringDegisken4);
      NewParamForQuery(QueryOfUpdate, FStringDegisken5);
      NewParamForQuery(QueryOfUpdate, FStringDegisken6);
      NewParamForQuery(QueryOfUpdate, FIntegerDegisken1);
      NewParamForQuery(QueryOfUpdate, FIntegerDegisken2);
      NewParamForQuery(QueryOfUpdate, FIntegerDegisken3);
      NewParamForQuery(QueryOfUpdate, FDoubleDegisken1);
      NewParamForQuery(QueryOfUpdate, FDoubleDegisken2);
      NewParamForQuery(QueryOfUpdate, FDoubleDegisken3);
      NewParamForQuery(QueryOfUpdate, FIsSatilabilir);
      NewParamForQuery(QueryOfUpdate, FIsOtomatikUretimUrunu);
      NewParamForQuery(QueryOfUpdate, FLotPartiMiktari);
      NewParamForQuery(QueryOfUpdate, FPaketMiktari);
      NewParamForQuery(QueryOfUpdate, FSeriNoTuru);
      NewParamForQuery(QueryOfUpdate, FIsHariciSeriNoIcerir);
      NewParamForQuery(QueryOfUpdate, FHariciSeriNoStokKoduID);
      NewParamForQuery(QueryOfUpdate, FTasiyiciPaketID);
      NewParamForQuery(QueryOfUpdate, FOncekiDonemCikanMiktar);
      NewParamForQuery(QueryOfUpdate, FTeminSuresi);
//      NewParamForQuery(QueryOfUpdate, FStockName);
//      NewParamForQuery(QueryOfUpdate, FEnStringDegisken1);
//      NewParamForQuery(QueryOfUpdate, FEnStringDegisken2);
//      NewParamForQuery(QueryOfUpdate, FEnStringDegisken3);
//      NewParamForQuery(QueryOfUpdate, FEnStringDegisken4);
//      NewParamForQuery(QueryOfUpdate, FEnStringDegisken5);
//      NewParamForQuery(QueryOfUpdate, FEnStringDegisken6);

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

procedure TStokKarti.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FStokKodu.FieldName,
        FStokAdi.FieldName,
        FStokGrubuID.FieldName,
        FOlcuBirimiID.FieldName,
        FUrunTipiID.FieldName,
        FAlisIskonto.FieldName,
        FSatisIskonto.FieldName,
        FYetkiliIskonto.FieldName,
        FStokTipiID.FieldName,
        FHamAlisFiyat.FieldName,
        FHamAlisParaBirimi.FieldName,
        FAlisFiyat.FieldName,
        FAlisParaBirimi.FieldName,
        FSatisFiyat.FieldName,
        FSatisParaBirimi.FieldName,
        FIhracFiyat.FieldName,
        FIhracParaBirimi.FieldName,
        FVarsayilaReceteID.FieldName,
        FEn.FieldName,
        FBoy.FieldName,
        FYukseklik.FieldName,
        FMenseiID.FieldName,
        FGtipNo.FieldName,
        FDiibUrunTanimi.FieldName,
        FEnAzStokSeviyesi.FieldName,
        FTanim.FieldName,
        FOzelKod.FieldName,
        FMarka.FieldName,
        FAgirlik.FieldName,
        FKapasite.FieldName,
        FCinsID.FieldName,
        FStringDegisken1.FieldName,
        FStringDegisken2.FieldName,
        FStringDegisken3.FieldName,
        FStringDegisken4.FieldName,
        FStringDegisken5.FieldName,
        FStringDegisken6.FieldName,
        FIntegerDegisken1.FieldName,
        FIntegerDegisken2.FieldName,
        FIntegerDegisken3.FieldName,
        FDoubleDegisken1.FieldName,
        FDoubleDegisken2.FieldName,
        FDoubleDegisken3.FieldName,
        FIsSatilabilir.FieldName,
        FIsOtomatikUretimUrunu.FieldName,
        FLotPartiMiktari.FieldName,
        FPaketMiktari.FieldName,
        FSeriNoTuru.FieldName,
        FIsHariciSeriNoIcerir.FieldName,
        FHariciSeriNoStokKoduID.FieldName,
        FTasiyiciPaketID.FieldName,
        FOncekiDonemCikanMiktar.FieldName,
        FTeminSuresi.FieldName
//        FStockName.FieldName,
//        FEnStringDegisken1.FieldName,
//        FEnStringDegisken2.FieldName,
//        FEnStringDegisken3.FieldName,
//        FEnStringDegisken4.FieldName,
//        FEnStringDegisken5.FieldName,
//        FEnStringDegisken6.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FStokKodu);
      NewParamForQuery(QueryOfUpdate, FStokAdi);
      NewParamForQuery(QueryOfUpdate, FStokGrubuID);
      NewParamForQuery(QueryOfUpdate, FOlcuBirimiID);
      NewParamForQuery(QueryOfUpdate, FUrunTipiID);
      NewParamForQuery(QueryOfUpdate, FAlisIskonto);
      NewParamForQuery(QueryOfUpdate, FSatisIskonto);
      NewParamForQuery(QueryOfUpdate, FYetkiliIskonto);
      NewParamForQuery(QueryOfUpdate, FStokTipiID);
      NewParamForQuery(QueryOfUpdate, FHamAlisFiyat);
      NewParamForQuery(QueryOfUpdate, FHamAlisParaBirimi);
      NewParamForQuery(QueryOfUpdate, FAlisFiyat);
      NewParamForQuery(QueryOfUpdate, FAlisParaBirimi);
      NewParamForQuery(QueryOfUpdate, FSatisFiyat);
      NewParamForQuery(QueryOfUpdate, FSatisParaBirimi);
      NewParamForQuery(QueryOfUpdate, FIhracFiyat);
      NewParamForQuery(QueryOfUpdate, FIhracParaBirimi);
      NewParamForQuery(QueryOfUpdate, FVarsayilaReceteID);
      NewParamForQuery(QueryOfUpdate, FEn);
      NewParamForQuery(QueryOfUpdate, FBoy);
      NewParamForQuery(QueryOfUpdate, FYukseklik);
      NewParamForQuery(QueryOfUpdate, FMenseiID);
      NewParamForQuery(QueryOfUpdate, FGtipNo);
      NewParamForQuery(QueryOfUpdate, FDiibUrunTanimi);
      NewParamForQuery(QueryOfUpdate, FEnAzStokSeviyesi);
      NewParamForQuery(QueryOfUpdate, FTanim);
      NewParamForQuery(QueryOfUpdate, FOzelKod);
      NewParamForQuery(QueryOfUpdate, FMarka);
      NewParamForQuery(QueryOfUpdate, FAgirlik);
      NewParamForQuery(QueryOfUpdate, FKapasite);
      NewParamForQuery(QueryOfUpdate, FCinsID);
      NewParamForQuery(QueryOfUpdate, FStringDegisken1);
      NewParamForQuery(QueryOfUpdate, FStringDegisken2);
      NewParamForQuery(QueryOfUpdate, FStringDegisken3);
      NewParamForQuery(QueryOfUpdate, FStringDegisken4);
      NewParamForQuery(QueryOfUpdate, FStringDegisken5);
      NewParamForQuery(QueryOfUpdate, FStringDegisken6);
      NewParamForQuery(QueryOfUpdate, FIntegerDegisken1);
      NewParamForQuery(QueryOfUpdate, FIntegerDegisken2);
      NewParamForQuery(QueryOfUpdate, FIntegerDegisken3);
      NewParamForQuery(QueryOfUpdate, FDoubleDegisken1);
      NewParamForQuery(QueryOfUpdate, FDoubleDegisken2);
      NewParamForQuery(QueryOfUpdate, FDoubleDegisken3);
      NewParamForQuery(QueryOfUpdate, FIsSatilabilir);
      NewParamForQuery(QueryOfUpdate, FIsOtomatikUretimUrunu);
      NewParamForQuery(QueryOfUpdate, FLotPartiMiktari);
      NewParamForQuery(QueryOfUpdate, FPaketMiktari);
      NewParamForQuery(QueryOfUpdate, FSeriNoTuru);
      NewParamForQuery(QueryOfUpdate, FIsHariciSeriNoIcerir);
      NewParamForQuery(QueryOfUpdate, FHariciSeriNoStokKoduID);
      NewParamForQuery(QueryOfUpdate, FTasiyiciPaketID);
      NewParamForQuery(QueryOfUpdate, FOncekiDonemCikanMiktar);
      NewParamForQuery(QueryOfUpdate, FTeminSuresi);
//      NewParamForQuery(QueryOfUpdate, FStockName);
//      NewParamForQuery(QueryOfUpdate, FEnStringDegisken1);
//      NewParamForQuery(QueryOfUpdate, FEnStringDegisken2);
//      NewParamForQuery(QueryOfUpdate, FEnStringDegisken3);
//      NewParamForQuery(QueryOfUpdate, FEnStringDegisken4);
//      NewParamForQuery(QueryOfUpdate, FEnStringDegisken5);
//      NewParamForQuery(QueryOfUpdate, FEnStringDegisken6);

      NewParamForQuery(QueryOfUpdate, Self.Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TStokKarti.Clone():TTable;
begin
  Result := TStokKarti.Create(Database);

  Self.Id.Clone(TStokKarti(Result).Id);

  FStokKodu.Clone(TStokKarti(Result).FStokKodu);
  FStokAdi.Clone(TStokKarti(Result).FStokAdi);
  FStokGrubuID.Clone(TStokKarti(Result).FStokGrubuID);
  FOlcuBirimiID.Clone(TStokKarti(Result).FOlcuBirimiID);
  FUrunTipiID.Clone(TStokKarti(Result).FUrunTipiID);
  FAlisIskonto.Clone(TStokKarti(Result).FAlisIskonto);
  FSatisIskonto.Clone(TStokKarti(Result).FSatisIskonto);
  FYetkiliIskonto.Clone(TStokKarti(Result).FYetkiliIskonto);
  FStokTipiID.Clone(TStokKarti(Result).FStokTipiID);
  FHamAlisFiyat.Clone(TStokKarti(Result).FHamAlisFiyat);
  FHamAlisParaBirimi.Clone(TStokKarti(Result).FHamAlisParaBirimi);
  FAlisFiyat.Clone(TStokKarti(Result).FAlisFiyat);
  FAlisParaBirimi.Clone(TStokKarti(Result).FAlisParaBirimi);
  FSatisFiyat.Clone(TStokKarti(Result).FSatisFiyat);
  FSatisParaBirimi.Clone(TStokKarti(Result).FSatisParaBirimi);
  FIhracFiyat.Clone(TStokKarti(Result).FIhracFiyat);
  FIhracParaBirimi.Clone(TStokKarti(Result).FIhracParaBirimi);
  FOrtalamaMaliyet.Clone(TStokKarti(Result).FOrtalamaMaliyet);
  FVarsayilaReceteID.Clone(TStokKarti(Result).FVarsayilaReceteID);
  FEn.Clone(TStokKarti(Result).FEn);
  FBoy.Clone(TStokKarti(Result).FBoy);
  FYukseklik.Clone(TStokKarti(Result).FYukseklik);
  FMenseiID.Clone(TStokKarti(Result).FMenseiID);
  FGtipNo.Clone(TStokKarti(Result).FGtipNo);
  FDiibUrunTanimi.Clone(TStokKarti(Result).FDiibUrunTanimi);
  FEnAzStokSeviyesi.Clone(TStokKarti(Result).FEnAzStokSeviyesi);
  FTanim.Clone(TStokKarti(Result).FTanim);
  FOzelKod.Clone(TStokKarti(Result).FOzelKod);
  FMarka.Clone(TStokKarti(Result).FMarka);
  FAgirlik.Clone(TStokKarti(Result).FAgirlik);
  FKapasite.Clone(TStokKarti(Result).FKapasite);
  FCinsID.Clone(TStokKarti(Result).FCinsID);
  FStringDegisken1.Clone(TStokKarti(Result).FStringDegisken1);
  FStringDegisken2.Clone(TStokKarti(Result).FStringDegisken2);
  FStringDegisken3.Clone(TStokKarti(Result).FStringDegisken3);
  FStringDegisken4.Clone(TStokKarti(Result).FStringDegisken4);
  FStringDegisken5.Clone(TStokKarti(Result).FStringDegisken5);
  FStringDegisken6.Clone(TStokKarti(Result).FStringDegisken6);
  FIntegerDegisken1.Clone(TStokKarti(Result).FIntegerDegisken1);
  FIntegerDegisken2.Clone(TStokKarti(Result).FIntegerDegisken2);
  FIntegerDegisken3.Clone(TStokKarti(Result).FIntegerDegisken3);
  FDoubleDegisken1.Clone(TStokKarti(Result).FDoubleDegisken1);
  FDoubleDegisken2.Clone(TStokKarti(Result).FDoubleDegisken2);
  FDoubleDegisken3.Clone(TStokKarti(Result).FDoubleDegisken3);
  FIsSatilabilir.Clone(TStokKarti(Result).FIsSatilabilir);
  FIsOtomatikUretimUrunu.Clone(TStokKarti(Result).FIsOtomatikUretimUrunu);
  FLotPartiMiktari.Clone(TStokKarti(Result).FLotPartiMiktari);
  FPaketMiktari.Clone(TStokKarti(Result).FPaketMiktari);
  FSeriNoTuru.Clone(TStokKarti(Result).FSeriNoTuru);
  FIsHariciSeriNoIcerir.Clone(TStokKarti(Result).FIsHariciSeriNoIcerir);
  FHariciSeriNoStokKoduID.Clone(TStokKarti(Result).FHariciSeriNoStokKoduID);
  FTasiyiciPaketID.Clone(TStokKarti(Result).FTasiyiciPaketID);
  FOncekiDonemCikanMiktar.Clone(TStokKarti(Result).FOncekiDonemCikanMiktar);
  FTeminSuresi.Clone(TStokKarti(Result).FTeminSuresi);
//  FStockName.Clone(TStokKarti(Result).FStockName);
//  FEnStringDegisken1.Clone(TStokKarti(Result).FEnStringDegisken1);
//  FEnStringDegisken2.Clone(TStokKarti(Result).FEnStringDegisken2);
//  FEnStringDegisken3.Clone(TStokKarti(Result).FEnStringDegisken3);
//  FEnStringDegisken4.Clone(TStokKarti(Result).FEnStringDegisken4);
//  FEnStringDegisken5.Clone(TStokKarti(Result).FEnStringDegisken5);
//  FEnStringDegisken6.Clone(TStokKarti(Result).FEnStringDegisken6);
end;

end.
