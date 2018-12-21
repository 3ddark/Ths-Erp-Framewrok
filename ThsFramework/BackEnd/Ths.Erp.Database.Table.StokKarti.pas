unit Ths.Erp.Database.Table.StokKarti;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.StokTipi,
  Ths.Erp.Database.Table.StokGrubu,
  Ths.Erp.Database.Table.OlcuBirimi,
  Ths.Erp.Database.Table.CinsOzelligi,
  Ths.Erp.Database.Table.Ulke;

type
  TStokKarti = class;
  TStokKarti = class(TTable)
  private
    FStokKodu: TFieldDB;
    FStokAdi: TFieldDB;
    FStokGrubuID: TFieldDB;
    FStokGrubu: TFieldDB;
    FOlcuBirimiID: TFieldDB;
    FOlcuBirimi: TFieldDB;
    FAlisIskonto: TFieldDB;
    FSatisIskonto: TFieldDB;
    FYetkiliIskonto: TFieldDB;
    FStokTipiID: TFieldDB;
    FStokTipi: TFieldDB;
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
    FVarsayilanRecete: TFieldDB;
    FEn: TFieldDB;
    FBoy: TFieldDB;
    FYukseklik: TFieldDB;
    FMenseiID: TFieldDB;
    FMensei: TFieldDB;
    FGtipNo: TFieldDB;
    FDiibUrunTanimi: TFieldDB;
    FEnAzStokSeviyesi: TFieldDB;
    FTanim: TFieldDB;
    FOzelKod: TFieldDB;
    FMarka: TFieldDB;
    FAgirlik: TFieldDB;
    FKapasite: TFieldDB;
    FCinsID: TFieldDB;
    FCins: TFieldDB;
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
    FIsAnaUrun: TFieldDB;
    FIsYariMamul: TFieldDB;
    FIsOtomatikUretimUrunu: TFieldDB;
    FIsOzetUrun: TFieldDB;
    FLotPartiMiktari: TFieldDB;
    FPaketMiktari: TFieldDB;
    FSeriNoTuru: TFieldDB;
    FIsHariciSeriNoIcerir: TFieldDB;
    FHariciSeriNoStokKoduID: TFieldDB;
    FHariciSerinoStokKodu: TFieldDB;
    FTasiyiciPaketID: TFieldDB;
    FTasiyiciPaket: TFieldDB;
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
    vStokTipi: TStokTipi;
    vStokGrubu: TStokGrubu;
    vOlcuBirimi: TOlcuBirimi;
    vCinsOzelligi: TCinsOzelligi;
    vUlke: TUlke;
    vStokKarti: TStokKarti;
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
    Property StokGrubu: TFieldDB read FStokGrubu write FStokGrubu;
    Property OlcuBirimiID: TFieldDB read FOlcuBirimiID write FOlcuBirimiID;
    Property OlcuBirimi: TFieldDB read FOlcuBirimi write FOlcuBirimi;
    Property AlisIskonto: TFieldDB read FAlisIskonto write FAlisIskonto;
    Property SatisIskonto: TFieldDB read FSatisIskonto write FSatisIskonto;
    Property YetkiliIskonto: TFieldDB read FYetkiliIskonto write FYetkiliIskonto;
    Property StokTipiID: TFieldDB read FStokTipiID write FStokTipiID;
    Property StokTipi: TFieldDB read FStokTipi write FStokTipi;
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
    Property VarsayilanRecete: TFieldDB read FVarsayilanRecete write FVarsayilanRecete;
    Property En: TFieldDB read FEn write FEn;
    Property Boy: TFieldDB read FBoy write FBoy;
    Property Yukseklik: TFieldDB read FYukseklik write FYukseklik;
    Property MenseiID: TFieldDB read FMenseiID write FMenseiID;
    Property Mensei: TFieldDB read FMensei write FMensei;
    Property GtipNo: TFieldDB read FGtipNo write FGtipNo;
    Property DiibUrunTanimi: TFieldDB read FDiibUrunTanimi write FDiibUrunTanimi;
    Property EnAzStokSeviyesi: TFieldDB read FEnAzStokSeviyesi write FEnAzStokSeviyesi;
    Property Tanim: TFieldDB read FTanim write FTanim;
    Property OzelKod: TFieldDB read FOzelKod write FOzelKod;
    Property Marka: TFieldDB read FMarka write FMarka;
    Property Agirlik: TFieldDB read FAgirlik write FAgirlik;
    Property Kapasite: TFieldDB read FKapasite write FKapasite;
    Property CinsID: TFieldDB read FCinsID write FCinsID;
    Property Cins: TFieldDB read FCins write FCins;
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
    Property IsAnaUrun: TFieldDB read FIsAnaUrun write FIsAnaUrun;
    Property IsYariMamul: TFieldDB read FIsYariMamul write FIsYariMamul;
    Property IsOtomatikUretimUrunu: TFieldDB read FIsOtomatikUretimUrunu write FIsOtomatikUretimUrunu;
    Property IsOzetUrun: TFieldDB read FIsOzetUrun write FIsOzetUrun;
    Property LotPartiMiktari: TFieldDB read FLotPartiMiktari write FLotPartiMiktari;
    Property PaketMiktari: TFieldDB read FPaketMiktari write FPaketMiktari;
    Property SeriNoTuru: TFieldDB read FSeriNoTuru write FSeriNoTuru;
    Property IsHariciSeriNoIcerir: TFieldDB read FIsHariciSeriNoIcerir write FIsHariciSeriNoIcerir;
    Property HariciSeriNoStokKoduID: TFieldDB read FHariciSeriNoStokKoduID write FHariciSeriNoStokKoduID;
    Property HariciSerinoStokKodu: TFieldDB read FHariciSerinoStokKodu write FHariciSerinoStokKodu;
    Property TasiyiciPaketID: TFieldDB read FTasiyiciPaketID write FTasiyiciPaketID;
    Property TasiyiciPaket: TFieldDB read FTasiyiciPaket write FTasiyiciPaket;
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

  FStokKodu := TFieldDB.Create('stok_kodu', ftString, '', 0, False, False);
  FStokAdi := TFieldDB.Create('stok_adi', ftString, '', 0);
  FStokGrubuID := TFieldDB.Create('stok_grubu_id', ftInteger, 0, 0, False, True);
  FStokGrubu := TFieldDB.Create('stok_grubu', ftString, '');
  FOlcuBirimiID := TFieldDB.Create('olcu_birimi_id', ftInteger, 0, 0, False, True);
  FOlcuBirimi := TFieldDB.Create('olcu_birimi', ftString, '');
  FAlisIskonto := TFieldDB.Create('alis_iskonto', ftFloat, 0);
  FSatisIskonto := TFieldDB.Create('satis_iskonto', ftFloat, 0);
  FYetkiliIskonto := TFieldDB.Create('yetkili_iskonto', ftFloat, 0);
  FStokTipiID := TFieldDB.Create('stok_tipi_id', ftInteger, 0, 0, False, True);
  FStokTipi := TFieldDB.Create('stok_tipi', ftString, '');
  FHamAlisFiyat := TFieldDB.Create('ham_alis_fiyat', ftFloat, 0, 0, False, False);
  FHamAlisParaBirimi := TFieldDB.Create('ham_alis_para_birim', ftString, '');
  FAlisFiyat := TFieldDB.Create('alis_fiyat', ftFloat, 0, 0, False, False);
  FAlisParaBirimi := TFieldDB.Create('alis_para_birim', ftString, '');
  FSatisFiyat := TFieldDB.Create('satis_fiyat', ftFloat, 0, 0, False, False);
  FSatisParaBirimi := TFieldDB.Create('satis_para_birim', ftString, '');
  FIhracFiyat := TFieldDB.Create('ihrac_fiyat', ftFloat, 0, 0, False, False);
  FIhracParaBirimi := TFieldDB.Create('ihrac_para_birim', ftString, '');
  FOrtalamaMaliyet := TFieldDB.Create('ortalama_maliyet', ftFloat, 0, 0, False, False);
  FVarsayilaReceteID := TFieldDB.Create('varsayilan_recete_id', ftInteger, 0, 0, True, True);
  FVarsayilanRecete := TFieldDB.Create('varsayilan_recete', ftString, '');
  FEn := TFieldDB.Create('en', ftFloat, 0);
  FBoy := TFieldDB.Create('boy', ftFloat, 0);
  FYukseklik := TFieldDB.Create('yukseklik', ftFloat, 0);
  FMenseiID := TFieldDB.Create('mensei_id', ftInteger, 0, 0, False, True);
  FMensei := TFieldDB.Create('mensei', ftString, '');
  FGtipNo := TFieldDB.Create('gtip_no', ftString, '');
  FDiibUrunTanimi := TFieldDB.Create('diib_urun_tanimi', ftString, '');
  FEnAzStokSeviyesi := TFieldDB.Create('en_az_stok_seviyesi', ftFloat, 0);
  FTanim := TFieldDB.Create('tanim', ftString, '');
  FOzelKod := TFieldDB.Create('ozel_kod', ftString, '');
  FMarka := TFieldDB.Create('marka', ftString, '');
  FAgirlik := TFieldDB.Create('agirlik', ftFloat, 0);
  FKapasite := TFieldDB.Create('kapasite', ftFloat, 0);
  FCinsID := TFieldDB.Create('cins_id', ftInteger, 0, 0, False, True);
  FCins := TFieldDB.Create('cins', ftString, '');
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
  FIsAnaUrun := TFieldDB.Create('is_ana_urun', ftBoolean, 0);
  FIsYariMamul := TFieldDB.Create('is_yari_mamul', ftBoolean, 0);
  FIsOtomatikUretimUrunu := TFieldDB.Create('is_otomatik_uretim_urunu', ftBoolean, 0);
  FIsOzetUrun := TFieldDB.Create('is_ozet_urun', ftBoolean, 0);
  FLotPartiMiktari := TFieldDB.Create('lot_parti_miktari', ftFloat, 0);
  FPaketMiktari := TFieldDB.Create('paket_miktari', ftFloat, 0);
  FSeriNoTuru := TFieldDB.Create('seri_no_turu', ftString, '');
  FIsHariciSeriNoIcerir := TFieldDB.Create('is_harici_seri_no_icerir', ftBoolean, 0);
  FHariciSeriNoStokKoduID := TFieldDB.Create('harici_serino_stok_kodu_id', ftInteger, 0, 0, False, True);
  FHariciSerinoStokKodu := TFieldDB.Create('harici_serino_stok_kodu', ftString, '');
  FTasiyiciPaketID := TFieldDB.Create('tasiyici_paket_id', ftInteger, 0, 0, False, True);
  FTasiyiciPaket := TFieldDB.Create('tasiyici_paket', ftString, '');
  FOncekiDonemCikanMiktar := TFieldDB.Create('onceki_donem_cikan_miktar', ftFloat, 0);
  FTeminSuresi := TFieldDB.Create('temin_suresi', ftInteger, 0);
  FStockName := TFieldDB.Create('stock_name', ftString, '');
  FEnStringDegisken1 := TFieldDB.Create('en_string_degisken1', ftString, '');
  FEnStringDegisken2 := TFieldDB.Create('en_string_degisken2', ftString, '');
  FEnStringDegisken3 := TFieldDB.Create('en_string_degisken3', ftString, '');
  FEnStringDegisken4 := TFieldDB.Create('en_string_degisken4', ftString, '');
  FEnStringDegisken5 := TFieldDB.Create('en_string_degisken5', ftString, '');
  FEnStringDegisken6 := TFieldDB.Create('en_string_degisken6', ftString, '');
end;

procedure TStokKarti.SelectToDatasourceHelper(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      vStokTipi := TStokTipi.Create(Database);
      vStokGrubu := TStokGrubu.Create(Database);
      vOlcuBirimi := TOlcuBirimi.Create(Database);
      try
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FStokKodu.FieldName,
          TableName + '.' + FStokAdi.FieldName,
          TableName + '.' + FStokGrubuID.FieldName,
          ColumnFromIDCol(vStokGrubu.Grup.FieldName, vStokGrubu.TableName, FStokGrubuID.FieldName, FStokGrubu.FieldName, TableName),
          TableName + '.' + FOlcuBirimiID.FieldName,
          ColumnFromIDCol(vOlcuBirimi.Birim.FieldName, vOlcuBirimi.TableName, FOlcuBirimiID.FieldName, FOlcuBirimi.FieldName, TableName),
          TableName + '.' + FStokTipiID.FieldName,
          ColumnFromIDCol(vStokTipi.Tip.FieldName, vStokTipi.TableName, FStokTipiID.FieldName, FStokTipi.FieldName, TableName),
          TableName + '.' + FSatisFiyat.FieldName,
          TableName + '.' + FSatisParaBirimi.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;
        Active := True;

        Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
        Self.DataSource.DataSet.FindField(FStokKodu.FieldName).DisplayLabel := 'Stok Kodu';
        Self.DataSource.DataSet.FindField(FStokAdi.FieldName).DisplayLabel := 'Stok Adý';
        Self.DataSource.DataSet.FindField(FStokGrubuID.FieldName).DisplayLabel := 'Stok Grubu ID';
        Self.DataSource.DataSet.FindField(FStokGrubu.FieldName).DisplayLabel := 'Stok Grubu';
        Self.DataSource.DataSet.FindField(FOlcuBirimiID.FieldName).DisplayLabel := 'Ölçü Birimi ID';
        Self.DataSource.DataSet.FindField(FOlcuBirimi.FieldName).DisplayLabel := 'Ölçü Birimi';
        Self.DataSource.DataSet.FindField(FStokTipiID.FieldName).DisplayLabel := 'Stok Tipi ID';
        Self.DataSource.DataSet.FindField(FStokTipi.FieldName).DisplayLabel := 'Stok Tipi';
        Self.DataSource.DataSet.FindField(FSatisFiyat.FieldName).DisplayLabel := 'Satýþ Fiyat';
        Self.DataSource.DataSet.FindField(FSatisParaBirimi.FieldName).DisplayLabel := 'Satýþ Para Birimi';
      finally
        vStokTipi.Free;
        vStokGrubu.Free;
        vOlcuBirimi.Free;
      end;
    end;
  end;
end;

procedure TStokKarti.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      vStokTipi := TStokTipi.Create(Database);
      vStokGrubu := TStokGrubu.Create(Database);
      vOlcuBirimi := TOlcuBirimi.Create(Database);
      vCinsOzelligi := TCinsOzelligi.Create(Database);
      vUlke := TUlke.Create(Database);
      vStokKarti := TStokKarti.Create(Database);
      try
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FStokKodu.FieldName,
          TableName + '.' + FStokAdi.FieldName,
          TableName + '.' + FStokGrubuID.FieldName,
          ColumnFromIDCol(vStokGrubu.Grup.FieldName, vStokGrubu.TableName, FStokGrubuID.FieldName, FStokGrubu.FieldName, TableName),
          TableName + '.' + FOlcuBirimiID.FieldName,
          ColumnFromIDCol(vOlcuBirimi.Birim.FieldName, vOlcuBirimi.TableName, FOlcuBirimiID.FieldName, FOlcuBirimi.FieldName, TableName),
          TableName + '.' + FAlisIskonto.FieldName,
          TableName + '.' + FSatisIskonto.FieldName,
          TableName + '.' + FYetkiliIskonto.FieldName,
          TableName + '.' + FStokTipiID.FieldName,
          ColumnFromIDCol(vStokTipi.Tip.FieldName, vStokTipi.TableName, FStokTipiID.FieldName, FStokTipi.FieldName, TableName),
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
//          TableName + '.' + FVarsayilanRecete.FieldName,
          TableName + '.' + FEn.FieldName,
          TableName + '.' + FBoy.FieldName,
          TableName + '.' + FYukseklik.FieldName,

          TableName + '.' + FMenseiID.FieldName,
          ColumnFromIDCol(vUlke.UlkeAdi.FieldName, vUlke.TableName, FMenseiID.FieldName, FMensei.FieldName, TableName),

          TableName + '.' + FGtipNo.FieldName,
          TableName + '.' + FDiibUrunTanimi.FieldName,
          TableName + '.' + FEnAzStokSeviyesi.FieldName,
          TableName + '.' + FTanim.FieldName,
          TableName + '.' + FOzelKod.FieldName,
          TableName + '.' + FMarka.FieldName,
          TableName + '.' + FAgirlik.FieldName,
          TableName + '.' + FKapasite.FieldName,
          TableName + '.' + FCinsID.FieldName,
          ColumnFromIDCol(vCinsOzelligi.Cins.FieldName, vCinsOzelligi.TableName, FCinsID.FieldName, FCins.FieldName, TableName),
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
          TableName + '.' + FIsAnaUrun.FieldName,
          TableName + '.' + FIsYariMamul.FieldName,
          TableName + '.' + FIsOtomatikUretimUrunu.FieldName,
          TableName + '.' + FIsOzetUrun.FieldName,
          TableName + '.' + FLotPartiMiktari.FieldName,
          TableName + '.' + FPaketMiktari.FieldName,

          TableName + '.' + FSeriNoTuru.FieldName,
          TableName + '.' + FIsHariciSeriNoIcerir.FieldName,
          TableName + '.' + FHariciSeriNoStokKoduID.FieldName,
          ColumnFromIDCol(vStokKarti.StokKodu.FieldName, vStokKarti.TableName, FHariciSeriNoStokKoduID.FieldName, FHariciSerinoStokKodu.FieldName, TableName),

          TableName + '.' + FTasiyiciPaketID.FieldName,
//          TableName + '.' + FTasiyiciPaket.FieldName,
          TableName + '.' + FOncekiDonemCikanMiktar.FieldName,
          TableName + '.' + FTeminSuresi.FieldName,
          TableName + '.' + FStockName.FieldName,
          TableName + '.' + FEnStringDegisken1.FieldName,
          TableName + '.' + FEnStringDegisken2.FieldName,
          TableName + '.' + FEnStringDegisken3.FieldName,
          TableName + '.' + FEnStringDegisken4.FieldName,
          TableName + '.' + FEnStringDegisken5.FieldName,
          TableName + '.' + FEnStringDegisken6.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;
        Active := True;

        Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
        Self.DataSource.DataSet.FindField(FStokKodu.FieldName).DisplayLabel := 'Stok Kodu';
        Self.DataSource.DataSet.FindField(FStokAdi.FieldName).DisplayLabel := 'Stok Adý';
        Self.DataSource.DataSet.FindField(FStokGrubuID.FieldName).DisplayLabel := 'Stok Grubu ID';
        Self.DataSource.DataSet.FindField(FStokGrubu.FieldName).DisplayLabel := 'Stok Grubu';
        Self.DataSource.DataSet.FindField(FOlcuBirimiID.FieldName).DisplayLabel := 'Ölçü Birimi ID';
        Self.DataSource.DataSet.FindField(FOlcuBirimi.FieldName).DisplayLabel := 'Ölçü Birimi';
        Self.DataSource.DataSet.FindField(FAlisIskonto.FieldName).DisplayLabel := 'Alýþ Ýskonto';
        Self.DataSource.DataSet.FindField(FSatisIskonto.FieldName).DisplayLabel := 'Satýþ Ýskonto';
        Self.DataSource.DataSet.FindField(FYetkiliIskonto.FieldName).DisplayLabel := 'Yetkili Ýskonto';
        Self.DataSource.DataSet.FindField(FStokTipiID.FieldName).DisplayLabel := 'Stok Tipi ID';
        Self.DataSource.DataSet.FindField(FStokTipi.FieldName).DisplayLabel := 'Stok Tipi';
        Self.DataSource.DataSet.FindField(FHamAlisFiyat.FieldName).DisplayLabel := 'Ham Alýþ Fiyat';
        Self.DataSource.DataSet.FindField(FHamAlisParaBirimi.FieldName).DisplayLabel := 'Ham Alýþ Para Birimi';
        Self.DataSource.DataSet.FindField(FAlisFiyat.FieldName).DisplayLabel := 'Alýþ Fiyat';
        Self.DataSource.DataSet.FindField(FAlisParaBirimi.FieldName).DisplayLabel := 'Alýþ Para Birimi';
        Self.DataSource.DataSet.FindField(FSatisFiyat.FieldName).DisplayLabel := 'Satýþ Fiyat';
        Self.DataSource.DataSet.FindField(FSatisParaBirimi.FieldName).DisplayLabel := 'Satýþ Para Birimi';
        Self.DataSource.DataSet.FindField(FIhracFiyat.FieldName).DisplayLabel := 'Ýhraç Fiyatý';
        Self.DataSource.DataSet.FindField(FIhracParaBirimi.FieldName).DisplayLabel := 'Ýhraç Para Birimi';
        Self.DataSource.DataSet.FindField(FOrtalamaMaliyet.FieldName).DisplayLabel := 'Ortalama Maliyet';
        Self.DataSource.DataSet.FindField(FVarsayilaReceteID.FieldName).DisplayLabel := 'Varsayýlan Reçete ID';
//        Self.DataSource.DataSet.FindField(FVarsayilanRecete.FieldName).DisplayLabel := 'Varsayýlan Reçete';
        Self.DataSource.DataSet.FindField(FEn.FieldName).DisplayLabel := 'En';
        Self.DataSource.DataSet.FindField(FBoy.FieldName).DisplayLabel := 'Boy';
        Self.DataSource.DataSet.FindField(FYukseklik.FieldName).DisplayLabel := 'Yükseklik';
        Self.DataSource.DataSet.FindField(FMenseiID.FieldName).DisplayLabel := 'Menþei ID';
        Self.DataSource.DataSet.FindField(FMensei.FieldName).DisplayLabel := 'Menþei';
        Self.DataSource.DataSet.FindField(FGtipNo.FieldName).DisplayLabel := 'GTIP No';
        Self.DataSource.DataSet.FindField(FDiibUrunTanimi.FieldName).DisplayLabel := 'DÝÝB Ürün Tanýmý';
        Self.DataSource.DataSet.FindField(FEnAzStokSeviyesi.FieldName).DisplayLabel := 'En Az Stok Seviyesi';
        Self.DataSource.DataSet.FindField(FTanim.FieldName).DisplayLabel := 'Taným';
        Self.DataSource.DataSet.FindField(FOzelKod.FieldName).DisplayLabel := 'Özel Kod';
        Self.DataSource.DataSet.FindField(FMarka.FieldName).DisplayLabel := 'Marka';
        Self.DataSource.DataSet.FindField(FAgirlik.FieldName).DisplayLabel := 'Aðýrlýk';
        Self.DataSource.DataSet.FindField(FKapasite.FieldName).DisplayLabel := 'Kapasite';
        Self.DataSource.DataSet.FindField(FCinsID.FieldName).DisplayLabel := 'Cins ID';
        Self.DataSource.DataSet.FindField(FCins.FieldName).DisplayLabel := 'Cins';
        Self.DataSource.DataSet.FindField(FStringDegisken1.FieldName).DisplayLabel := 'String Deðiþken 1';
        Self.DataSource.DataSet.FindField(FStringDegisken2.FieldName).DisplayLabel := 'String Deðiþken 2';
        Self.DataSource.DataSet.FindField(FStringDegisken3.FieldName).DisplayLabel := 'String Deðiþken 3';
        Self.DataSource.DataSet.FindField(FStringDegisken4.FieldName).DisplayLabel := 'String Deðiþken 4';
        Self.DataSource.DataSet.FindField(FStringDegisken5.FieldName).DisplayLabel := 'String Deðiþken 5';
        Self.DataSource.DataSet.FindField(FStringDegisken6.FieldName).DisplayLabel := 'String Deðiþken 6';
        Self.DataSource.DataSet.FindField(FIntegerDegisken1.FieldName).DisplayLabel := 'Integer Deðiþken 1';
        Self.DataSource.DataSet.FindField(FIntegerDegisken2.FieldName).DisplayLabel := 'Integer Deðiþken2';
        Self.DataSource.DataSet.FindField(FIntegerDegisken3.FieldName).DisplayLabel := 'Integer Deðiþken 3';
        Self.DataSource.DataSet.FindField(FDoubleDegisken1.FieldName).DisplayLabel := 'Double Deðiþken 1';
        Self.DataSource.DataSet.FindField(FDoubleDegisken2.FieldName).DisplayLabel := 'Double Deðiþken 2';
        Self.DataSource.DataSet.FindField(FDoubleDegisken3.FieldName).DisplayLabel := 'Double Deðiþken 3';
        Self.DataSource.DataSet.FindField(FIsSatilabilir.FieldName).DisplayLabel := 'Satýlabilir?';
        Self.DataSource.DataSet.FindField(FIsAnaUrun.FieldName).DisplayLabel := 'Ana Ürün?';
        Self.DataSource.DataSet.FindField(FIsYariMamul.FieldName).DisplayLabel := 'Yarý Mamül?';
        Self.DataSource.DataSet.FindField(FIsOtomatikUretimUrunu.FieldName).DisplayLabel := 'Otomatik Üretim Ürünü?';
        Self.DataSource.DataSet.FindField(FIsOzetUrun.FieldName).DisplayLabel := 'Özet Ürün?';
        Self.DataSource.DataSet.FindField(FLotPartiMiktari.FieldName).DisplayLabel := 'Lot Parti Miktarý';
        Self.DataSource.DataSet.FindField(FPaketMiktari.FieldName).DisplayLabel := 'Paket Miktarý';
        Self.DataSource.DataSet.FindField(FSeriNoTuru.FieldName).DisplayLabel := 'Seri No Türü';
        Self.DataSource.DataSet.FindField(FIsHariciSeriNoIcerir.FieldName).DisplayLabel := 'Harici Seri No Ýçerir';
        Self.DataSource.DataSet.FindField(FHariciSeriNoStokKoduID.FieldName).DisplayLabel := 'Harici Seri No Stok Kodu ID';
        Self.DataSource.DataSet.FindField(FHariciSerinoStokKodu.FieldName).DisplayLabel := 'Harici SeriNo Stok Kodu';
        Self.DataSource.DataSet.FindField(FTasiyiciPaketID.FieldName).DisplayLabel := 'Taþýyýcý Paket ID';
//        Self.DataSource.DataSet.FindField(FTasiyiciPaket.FieldName).DisplayLabel := 'Taþýyýcý Paket';
        Self.DataSource.DataSet.FindField(FOncekiDonemCikanMiktar.FieldName).DisplayLabel := 'Önceki Dönem Çýkan Miktar';
        Self.DataSource.DataSet.FindField(FTeminSuresi.FieldName).DisplayLabel := 'Temin Süresi';
        Self.DataSource.DataSet.FindField(FStockName.FieldName).DisplayLabel := 'Stock Name';
        Self.DataSource.DataSet.FindField(FEnStringDegisken1.FieldName).DisplayLabel := 'String Deðiþken 1';
        Self.DataSource.DataSet.FindField(FEnStringDegisken2.FieldName).DisplayLabel := 'String Deðiþken 2';
        Self.DataSource.DataSet.FindField(FEnStringDegisken3.FieldName).DisplayLabel := 'String Deðiþken 3';
        Self.DataSource.DataSet.FindField(FEnStringDegisken4.FieldName).DisplayLabel := 'String Deðiþken 4';
        Self.DataSource.DataSet.FindField(FEnStringDegisken5.FieldName).DisplayLabel := 'String Deðiþken 5';
        Self.DataSource.DataSet.FindField(FEnStringDegisken6.FieldName).DisplayLabel := 'String Deðiþken 6';
      finally
        vStokTipi.Free;
        vStokGrubu.Free;
        vOlcuBirimi.Free;
        vCinsOzelligi.Free;
        vUlke.Free;
        vStokKarti.Free;
      end;
    end;
  end;
end;

procedure TStokKarti.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
      pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

    with QueryOfList do
    begin
      vStokTipi := TStokTipi.Create(Database);
      vStokGrubu := TStokGrubu.Create(Database);
      vOlcuBirimi := TOlcuBirimi.Create(Database);
      vCinsOzelligi := TCinsOzelligi.Create(Database);
      vUlke := TUlke.Create(Database);
      vStokKarti := TStokKarti.Create(Database);
      try
        Close;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FStokKodu.FieldName,
          TableName + '.' + FStokAdi.FieldName,
          TableName + '.' + FStokGrubuID.FieldName,
          ColumnFromIDCol(vStokGrubu.Grup.FieldName, vStokGrubu.TableName, FStokGrubuID.FieldName, FStokGrubu.FieldName, TableName),
          TableName + '.' + FOlcuBirimiID.FieldName,
          ColumnFromIDCol(vOlcuBirimi.Birim.FieldName, vOlcuBirimi.TableName, FOlcuBirimiID.FieldName, FOlcuBirimi.FieldName, TableName),
          TableName + '.' + FAlisIskonto.FieldName,
          TableName + '.' + FSatisIskonto.FieldName,
          TableName + '.' + FYetkiliIskonto.FieldName,
          TableName + '.' + FStokTipiID.FieldName,
          ColumnFromIDCol(vStokTipi.Tip.FieldName, vStokTipi.TableName, FStokTipiID.FieldName, FStokTipi.FieldName, TableName),
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
//          TableName + '.' + FVarsayilanRecete.FieldName,

          TableName + '.' + FEn.FieldName,
          TableName + '.' + FBoy.FieldName,
          TableName + '.' + FYukseklik.FieldName,

          TableName + '.' + FMenseiID.FieldName,
          ColumnFromIDCol(vUlke.UlkeAdi.FieldName, vUlke.TableName, FMenseiID.FieldName, FMensei.FieldName, TableName),

          TableName + '.' + FGtipNo.FieldName,
          TableName + '.' + FDiibUrunTanimi.FieldName,
          TableName + '.' + FEnAzStokSeviyesi.FieldName,
          TableName + '.' + FTanim.FieldName,
          TableName + '.' + FOzelKod.FieldName,
          TableName + '.' + FMarka.FieldName,
          TableName + '.' + FAgirlik.FieldName,
          TableName + '.' + FKapasite.FieldName,
          TableName + '.' + FCinsID.FieldName,
          ColumnFromIDCol(vCinsOzelligi.Cins.FieldName, vCinsOzelligi.TableName, FCinsID.FieldName, FCins.FieldName, TableName),
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
          TableName + '.' + FIsAnaUrun.FieldName,
          TableName + '.' + FIsYariMamul.FieldName,
          TableName + '.' + FIsOtomatikUretimUrunu.FieldName,
          TableName + '.' + FIsOzetUrun.FieldName,
          TableName + '.' + FLotPartiMiktari.FieldName,
          TableName + '.' + FPaketMiktari.FieldName,
          TableName + '.' + FSeriNoTuru.FieldName,
          TableName + '.' + FIsHariciSeriNoIcerir.FieldName,
          TableName + '.' + FHariciSeriNoStokKoduID.FieldName,
          ColumnFromIDCol(vStokKarti.StokKodu.FieldName, vStokKarti.TableName, FHariciSeriNoStokKoduID.FieldName, FHariciSerinoStokKodu.FieldName, TableName),
          TableName + '.' + FTasiyiciPaketID.FieldName,
//          TableName + '.' + FTasiyiciPaket.FieldName,
          TableName + '.' + FOncekiDonemCikanMiktar.FieldName,
          TableName + '.' + FTeminSuresi.FieldName,
          TableName + '.' + FStockName.FieldName,
          TableName + '.' + FEnStringDegisken1.FieldName,
          TableName + '.' + FEnStringDegisken2.FieldName,
          TableName + '.' + FEnStringDegisken3.FieldName,
          TableName + '.' + FEnStringDegisken4.FieldName,
          TableName + '.' + FEnStringDegisken5.FieldName,
          TableName + '.' + FEnStringDegisken6.FieldName
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
          FStokGrubu.Value := FormatedVariantVal(FieldByName(FStokGrubu.FieldName).DataType, FieldByName(FStokGrubu.FieldName).Value);
          FOlcuBirimiID.Value := FormatedVariantVal(FieldByName(FOlcuBirimiID.FieldName).DataType, FieldByName(FOlcuBirimiID.FieldName).Value);
          FOlcuBirimi.Value := FormatedVariantVal(FieldByName(FOlcuBirimi.FieldName).DataType, FieldByName(FOlcuBirimi.FieldName).Value);

          FAlisIskonto.Value := FormatedVariantVal(FieldByName(FAlisIskonto.FieldName).DataType, FieldByName(FAlisIskonto.FieldName).Value);
          FSatisIskonto.Value := FormatedVariantVal(FieldByName(FSatisIskonto.FieldName).DataType, FieldByName(FSatisIskonto.FieldName).Value);
          FYetkiliIskonto.Value := FormatedVariantVal(FieldByName(FYetkiliIskonto.FieldName).DataType, FieldByName(FYetkiliIskonto.FieldName).Value);

          FStokTipiID.Value := FormatedVariantVal(FieldByName(FStokTipiID.FieldName).DataType, FieldByName(FStokTipiID.FieldName).Value);
          FStokTipi.Value := FormatedVariantVal(FieldByName(FStokTipi.FieldName).DataType, FieldByName(FStokTipi.FieldName).Value);
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
//          FVarsayilanRecete.Value := FormatedVariantVal(FieldByName(FVarsayilanRecete.FieldName).DataType, FieldByName(FVarsayilanRecete.FieldName).Value);

          FEn.Value := FormatedVariantVal(FieldByName(FEn.FieldName).DataType, FieldByName(FEn.FieldName).Value);
          FBoy.Value := FormatedVariantVal(FieldByName(FBoy.FieldName).DataType, FieldByName(FBoy.FieldName).Value);
          FYukseklik.Value := FormatedVariantVal(FieldByName(FYukseklik.FieldName).DataType, FieldByName(FYukseklik.FieldName).Value);

          FMenseiID.Value := FormatedVariantVal(FieldByName(FMenseiID.FieldName).DataType, FieldByName(FMenseiID.FieldName).Value);
          FMensei.Value := FormatedVariantVal(FieldByName(FMensei.FieldName).DataType, FieldByName(FMensei.FieldName).Value);

          FGtipNo.Value := FormatedVariantVal(FieldByName(FGtipNo.FieldName).DataType, FieldByName(FGtipNo.FieldName).Value);
          FDiibUrunTanimi.Value := FormatedVariantVal(FieldByName(FDiibUrunTanimi.FieldName).DataType, FieldByName(FDiibUrunTanimi.FieldName).Value);
          FEnAzStokSeviyesi.Value := FormatedVariantVal(FieldByName(FEnAzStokSeviyesi.FieldName).DataType, FieldByName(FEnAzStokSeviyesi.FieldName).Value);
          FTanim.Value := FormatedVariantVal(FieldByName(FTanim.FieldName).DataType, FieldByName(FTanim.FieldName).Value);
          FOzelKod.Value := FormatedVariantVal(FieldByName(FOzelKod.FieldName).DataType, FieldByName(FOzelKod.FieldName).Value);
          FMarka.Value := FormatedVariantVal(FieldByName(FMarka.FieldName).DataType, FieldByName(FMarka.FieldName).Value);
          FAgirlik.Value := FormatedVariantVal(FieldByName(FAgirlik.FieldName).DataType, FieldByName(FAgirlik.FieldName).Value);
          FKapasite.Value := FormatedVariantVal(FieldByName(FKapasite.FieldName).DataType, FieldByName(FKapasite.FieldName).Value);

          FCinsID.Value := FormatedVariantVal(FieldByName(FCinsID.FieldName).DataType, FieldByName(FCinsID.FieldName).Value);
          FCins.Value := FormatedVariantVal(FieldByName(FCins.FieldName).DataType, FieldByName(FCins.FieldName).Value);
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
          FIsAnaUrun.Value := FormatedVariantVal(FieldByName(FIsAnaUrun.FieldName).DataType, FieldByName(FIsAnaUrun.FieldName).Value);
          FIsYariMamul.Value := FormatedVariantVal(FieldByName(FIsYariMamul.FieldName).DataType, FieldByName(FIsYariMamul.FieldName).Value);
          FIsOtomatikUretimUrunu.Value := FormatedVariantVal(FieldByName(FIsOtomatikUretimUrunu.FieldName).DataType, FieldByName(FIsOtomatikUretimUrunu.FieldName).Value);
          FIsOzetUrun.Value := FormatedVariantVal(FieldByName(FIsOzetUrun.FieldName).DataType, FieldByName(FIsOzetUrun.FieldName).Value);

          FLotPartiMiktari.Value := FormatedVariantVal(FieldByName(FLotPartiMiktari.FieldName).DataType, FieldByName(FLotPartiMiktari.FieldName).Value);
          FPaketMiktari.Value := FormatedVariantVal(FieldByName(FPaketMiktari.FieldName).DataType, FieldByName(FPaketMiktari.FieldName).Value);
          FSeriNoTuru.Value := FormatedVariantVal(FieldByName(FSeriNoTuru.FieldName).DataType, FieldByName(FSeriNoTuru.FieldName).Value);
          FIsHariciSeriNoIcerir.Value := FormatedVariantVal(FieldByName(FIsHariciSeriNoIcerir.FieldName).DataType, FieldByName(FIsHariciSeriNoIcerir.FieldName).Value);

          FHariciSeriNoStokKoduID.Value := FormatedVariantVal(FieldByName(FHariciSeriNoStokKoduID.FieldName).DataType, FieldByName(FHariciSeriNoStokKoduID.FieldName).Value);
          FHariciSerinoStokKodu.Value := FormatedVariantVal(FieldByName(FHariciSerinoStokKodu.FieldName).DataType, FieldByName(FHariciSerinoStokKodu.FieldName).Value);

          FTasiyiciPaketID.Value := FormatedVariantVal(FieldByName(FTasiyiciPaketID.FieldName).DataType, FieldByName(FTasiyiciPaketID.FieldName).Value);
//          FTasiyiciPaket.Value := FormatedVariantVal(FieldByName(FTasiyiciPaket.FieldName).DataType, FieldByName(FTasiyiciPaket.FieldName).Value);

          FOncekiDonemCikanMiktar.Value := FormatedVariantVal(FieldByName(FOncekiDonemCikanMiktar.FieldName).DataType, FieldByName(FOncekiDonemCikanMiktar.FieldName).Value);
          FTeminSuresi.Value := FormatedVariantVal(FieldByName(FTeminSuresi.FieldName).DataType, FieldByName(FTeminSuresi.FieldName).Value);

          FStockName.Value := FormatedVariantVal(FieldByName(FStockName.FieldName).DataType, FieldByName(FStockName.FieldName).Value);
          FEnStringDegisken1.Value := FormatedVariantVal(FieldByName(FEnStringDegisken1.FieldName).DataType, FieldByName(FEnStringDegisken1.FieldName).Value);
          FEnStringDegisken2.Value := FormatedVariantVal(FieldByName(FEnStringDegisken2.FieldName).DataType, FieldByName(FEnStringDegisken2.FieldName).Value);
          FEnStringDegisken3.Value := FormatedVariantVal(FieldByName(FEnStringDegisken3.FieldName).DataType, FieldByName(FEnStringDegisken3.FieldName).Value);
          FEnStringDegisken4.Value := FormatedVariantVal(FieldByName(FEnStringDegisken4.FieldName).DataType, FieldByName(FEnStringDegisken4.FieldName).Value);
          FEnStringDegisken5.Value := FormatedVariantVal(FieldByName(FEnStringDegisken5.FieldName).DataType, FieldByName(FEnStringDegisken5.FieldName).Value);
          FEnStringDegisken6.Value := FormatedVariantVal(FieldByName(FEnStringDegisken6.FieldName).DataType, FieldByName(FEnStringDegisken6.FieldName).Value);

          List.Add(Self.Clone());

          Next;
        end;
        Close;
      finally
        vStokTipi.Free;
        vStokGrubu.Free;
        vOlcuBirimi.Free;
        vCinsOzelligi.Free;
        vStokKarti.Free;
      end;
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
        FIsAnaUrun.FieldName,
        FIsYariMamul.FieldName,
        FIsOtomatikUretimUrunu.FieldName,
        FIsOzetUrun.FieldName,
        FLotPartiMiktari.FieldName,
        FPaketMiktari.FieldName,
        FSeriNoTuru.FieldName,
        FIsHariciSeriNoIcerir.FieldName,
        FHariciSeriNoStokKoduID.FieldName,
        FTasiyiciPaketID.FieldName,
        FOncekiDonemCikanMiktar.FieldName,
        FTeminSuresi.FieldName,
        FStockName.FieldName,
        FEnStringDegisken1.FieldName,
        FEnStringDegisken2.FieldName,
        FEnStringDegisken3.FieldName,
        FEnStringDegisken4.FieldName,
        FEnStringDegisken5.FieldName,
        FEnStringDegisken6.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FStokKodu);
      NewParamForQuery(QueryOfInsert, FStokAdi);
      NewParamForQuery(QueryOfInsert, FStokGrubuID);
      NewParamForQuery(QueryOfInsert, FOlcuBirimiID);
      NewParamForQuery(QueryOfInsert, FAlisIskonto);
      NewParamForQuery(QueryOfInsert, FSatisIskonto);
      NewParamForQuery(QueryOfInsert, FYetkiliIskonto);
      NewParamForQuery(QueryOfInsert, FStokTipiID);
      NewParamForQuery(QueryOfInsert, FHamAlisFiyat);
      NewParamForQuery(QueryOfInsert, FHamAlisParaBirimi);
      NewParamForQuery(QueryOfInsert, FAlisFiyat);
      NewParamForQuery(QueryOfInsert, FAlisParaBirimi);
      NewParamForQuery(QueryOfInsert, FSatisFiyat);
      NewParamForQuery(QueryOfInsert, FSatisParaBirimi);
      NewParamForQuery(QueryOfInsert, FIhracFiyat);
      NewParamForQuery(QueryOfInsert, FIhracParaBirimi);
      NewParamForQuery(QueryOfInsert, FVarsayilaReceteID);
      NewParamForQuery(QueryOfInsert, FEn);
      NewParamForQuery(QueryOfInsert, FBoy);
      NewParamForQuery(QueryOfInsert, FYukseklik);
      NewParamForQuery(QueryOfInsert, FMenseiID);
      NewParamForQuery(QueryOfInsert, FGtipNo);
      NewParamForQuery(QueryOfInsert, FDiibUrunTanimi);
      NewParamForQuery(QueryOfInsert, FEnAzStokSeviyesi);
      NewParamForQuery(QueryOfInsert, FTanim);
      NewParamForQuery(QueryOfInsert, FOzelKod);
      NewParamForQuery(QueryOfInsert, FMarka);
      NewParamForQuery(QueryOfInsert, FAgirlik);
      NewParamForQuery(QueryOfInsert, FKapasite);
      NewParamForQuery(QueryOfInsert, FCinsID);
      NewParamForQuery(QueryOfInsert, FStringDegisken1);
      NewParamForQuery(QueryOfInsert, FStringDegisken2);
      NewParamForQuery(QueryOfInsert, FStringDegisken3);
      NewParamForQuery(QueryOfInsert, FStringDegisken4);
      NewParamForQuery(QueryOfInsert, FStringDegisken5);
      NewParamForQuery(QueryOfInsert, FStringDegisken6);
      NewParamForQuery(QueryOfInsert, FIntegerDegisken1);
      NewParamForQuery(QueryOfInsert, FIntegerDegisken2);
      NewParamForQuery(QueryOfInsert, FIntegerDegisken3);
      NewParamForQuery(QueryOfInsert, FDoubleDegisken1);
      NewParamForQuery(QueryOfInsert, FDoubleDegisken2);
      NewParamForQuery(QueryOfInsert, FDoubleDegisken3);
      NewParamForQuery(QueryOfInsert, FIsSatilabilir);
      NewParamForQuery(QueryOfInsert, FIsAnaUrun);
      NewParamForQuery(QueryOfInsert, FIsYariMamul);
      NewParamForQuery(QueryOfInsert, FIsOtomatikUretimUrunu);
      NewParamForQuery(QueryOfInsert, FIsOzetUrun);
      NewParamForQuery(QueryOfInsert, FLotPartiMiktari);
      NewParamForQuery(QueryOfInsert, FPaketMiktari);
      NewParamForQuery(QueryOfInsert, FSeriNoTuru);
      NewParamForQuery(QueryOfInsert, FIsHariciSeriNoIcerir);
      NewParamForQuery(QueryOfInsert, FHariciSeriNoStokKoduID);
      NewParamForQuery(QueryOfInsert, FTasiyiciPaketID);
      NewParamForQuery(QueryOfInsert, FOncekiDonemCikanMiktar);
      NewParamForQuery(QueryOfInsert, FTeminSuresi);
      NewParamForQuery(QueryOfInsert, FStockName);
      NewParamForQuery(QueryOfInsert, FEnStringDegisken1);
      NewParamForQuery(QueryOfInsert, FEnStringDegisken2);
      NewParamForQuery(QueryOfInsert, FEnStringDegisken3);
      NewParamForQuery(QueryOfInsert, FEnStringDegisken4);
      NewParamForQuery(QueryOfInsert, FEnStringDegisken5);
      NewParamForQuery(QueryOfInsert, FEnStringDegisken6);

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
        FIsAnaUrun.FieldName,
        FIsYariMamul.FieldName,
        FIsOtomatikUretimUrunu.FieldName,
        FIsOzetUrun.FieldName,
        FLotPartiMiktari.FieldName,
        FPaketMiktari.FieldName,
        FSeriNoTuru.FieldName,
        FIsHariciSeriNoIcerir.FieldName,
        FHariciSeriNoStokKoduID.FieldName,
        FTasiyiciPaketID.FieldName,
        FOncekiDonemCikanMiktar.FieldName,
        FTeminSuresi.FieldName,
        FStockName.FieldName,
        FEnStringDegisken1.FieldName,
        FEnStringDegisken2.FieldName,
        FEnStringDegisken3.FieldName,
        FEnStringDegisken4.FieldName,
        FEnStringDegisken5.FieldName,
        FEnStringDegisken6.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FStokKodu);
      NewParamForQuery(QueryOfUpdate, FStokAdi);
      NewParamForQuery(QueryOfUpdate, FStokGrubuID);
      NewParamForQuery(QueryOfUpdate, FOlcuBirimiID);
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
      NewParamForQuery(QueryOfUpdate, FIsAnaUrun);
      NewParamForQuery(QueryOfUpdate, FIsYariMamul);
      NewParamForQuery(QueryOfUpdate, FIsOtomatikUretimUrunu);
      NewParamForQuery(QueryOfUpdate, FIsOzetUrun);
      NewParamForQuery(QueryOfUpdate, FLotPartiMiktari);
      NewParamForQuery(QueryOfUpdate, FPaketMiktari);
      NewParamForQuery(QueryOfUpdate, FSeriNoTuru);
      NewParamForQuery(QueryOfUpdate, FIsHariciSeriNoIcerir);
      NewParamForQuery(QueryOfUpdate, FHariciSeriNoStokKoduID);
      NewParamForQuery(QueryOfUpdate, FTasiyiciPaketID);
      NewParamForQuery(QueryOfUpdate, FOncekiDonemCikanMiktar);
      NewParamForQuery(QueryOfUpdate, FTeminSuresi);
      NewParamForQuery(QueryOfUpdate, FStockName);
      NewParamForQuery(QueryOfUpdate, FEnStringDegisken1);
      NewParamForQuery(QueryOfUpdate, FEnStringDegisken2);
      NewParamForQuery(QueryOfUpdate, FEnStringDegisken3);
      NewParamForQuery(QueryOfUpdate, FEnStringDegisken4);
      NewParamForQuery(QueryOfUpdate, FEnStringDegisken5);
      NewParamForQuery(QueryOfUpdate, FEnStringDegisken6);

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
  FStokGrubu.Clone(TStokKarti(Result).FStokGrubu);
  FOlcuBirimiID.Clone(TStokKarti(Result).FOlcuBirimiID);
  FOlcuBirimi.Clone(TStokKarti(Result).FOlcuBirimi);
  FAlisIskonto.Clone(TStokKarti(Result).FAlisIskonto);
  FSatisIskonto.Clone(TStokKarti(Result).FSatisIskonto);
  FYetkiliIskonto.Clone(TStokKarti(Result).FYetkiliIskonto);
  FStokTipiID.Clone(TStokKarti(Result).FStokTipiID);
  FStokTipi.Clone(TStokKarti(Result).FStokTipi);
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
  FVarsayilanRecete.Clone(TStokKarti(Result).FVarsayilanRecete);
  FEn.Clone(TStokKarti(Result).FEn);
  FBoy.Clone(TStokKarti(Result).FBoy);
  FYukseklik.Clone(TStokKarti(Result).FYukseklik);
  FMenseiID.Clone(TStokKarti(Result).FMenseiID);
  FMensei.Clone(TStokKarti(Result).FMensei);
  FGtipNo.Clone(TStokKarti(Result).FGtipNo);
  FDiibUrunTanimi.Clone(TStokKarti(Result).FDiibUrunTanimi);
  FEnAzStokSeviyesi.Clone(TStokKarti(Result).FEnAzStokSeviyesi);
  FTanim.Clone(TStokKarti(Result).FTanim);
  FOzelKod.Clone(TStokKarti(Result).FOzelKod);
  FMarka.Clone(TStokKarti(Result).FMarka);
  FAgirlik.Clone(TStokKarti(Result).FAgirlik);
  FKapasite.Clone(TStokKarti(Result).FKapasite);
  FCinsID.Clone(TStokKarti(Result).FCinsID);
  FCins.Clone(TStokKarti(Result).FCins);
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
  FIsAnaUrun.Clone(TStokKarti(Result).FIsAnaUrun);
  FIsYariMamul.Clone(TStokKarti(Result).FIsYariMamul);
  FIsOtomatikUretimUrunu.Clone(TStokKarti(Result).FIsOtomatikUretimUrunu);
  FIsOzetUrun.Clone(TStokKarti(Result).FIsOzetUrun);
  FLotPartiMiktari.Clone(TStokKarti(Result).FLotPartiMiktari);
  FPaketMiktari.Clone(TStokKarti(Result).FPaketMiktari);
  FSeriNoTuru.Clone(TStokKarti(Result).FSeriNoTuru);
  FIsHariciSeriNoIcerir.Clone(TStokKarti(Result).FIsHariciSeriNoIcerir);
  FHariciSeriNoStokKoduID.Clone(TStokKarti(Result).FHariciSeriNoStokKoduID);
  FHariciSerinoStokKodu.Clone(TStokKarti(Result).FHariciSerinoStokKodu);
  FTasiyiciPaketID.Clone(TStokKarti(Result).FTasiyiciPaketID);
  FTasiyiciPaket.Clone(TStokKarti(Result).FTasiyiciPaket);
  FOncekiDonemCikanMiktar.Clone(TStokKarti(Result).FOncekiDonemCikanMiktar);
  FTeminSuresi.Clone(TStokKarti(Result).FTeminSuresi);
  FStockName.Clone(TStokKarti(Result).FStockName);
  FEnStringDegisken1.Clone(TStokKarti(Result).FEnStringDegisken1);
  FEnStringDegisken2.Clone(TStokKarti(Result).FEnStringDegisken2);
  FEnStringDegisken3.Clone(TStokKarti(Result).FEnStringDegisken3);
  FEnStringDegisken4.Clone(TStokKarti(Result).FEnStringDegisken4);
  FEnStringDegisken5.Clone(TStokKarti(Result).FEnStringDegisken5);
  FEnStringDegisken6.Clone(TStokKarti(Result).FEnStringDegisken6);
end;

end.
