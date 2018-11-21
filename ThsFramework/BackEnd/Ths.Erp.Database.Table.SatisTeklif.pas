unit Ths.Erp.Database.Table.SatisTeklif;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.AyarHaneSayisi,
  Ths.Erp.Database.Table.SatisTeklifDetay,
  Ths.Erp.Database.TableDetailed,
  Ths.Erp.Database.Table.Field,
  Ths.Erp.Database.Table.PersonelKarti,
  Ths.Erp.Database.Table.AyarEFaturaFaturaTipi,
  Ths.Erp.Database.Table.AyarTeklifTipi,
  Ths.Erp.Database.Table.AyarTeklifDurum,
  Ths.Erp.Database.Table.AyarOdemeBaslangicDonemi;

type
  TSatisTeklif = class(TTableDetailed)
  private
    FSiparisID: TFieldDB;
    FIrsaliyeID: TFieldDB;
    FFaturaID: TFieldDB;
    FIsSiparislesti: TFieldDB;
    FIsTaslak: TFieldDB;
    FIsEFatura: TFieldDB;
    FTutar: TFieldDB;
    FIskontoTutar: TFieldDB;
    FAraToplam: TFieldDB;
    FGenelIskontoTutar: TFieldDB;
    FKDVTutar: TFieldDB;
    FGenelToplam: TFieldDB;
    FIslemTipiID: TFieldDB;
    FIslemTipi: TFieldDB;
    FTeklifNo: TFieldDB;
    FTeklifTarihi: TFieldDB;
    FTeslimTarihi: TFieldDB;
    FGecerlilikTarihi: TFieldDB;
    FMusteriKodu: TFieldDB;
    FMusteriAdi: TFieldDB;
    FAdresMusteri: TFieldDB;
    FSehirMusteri: TFieldDB;
    FPostaKodu: TFieldDB;
    FVergiDairesi: TFieldDB;
    FVergiNo: TFieldDB;
    FMusteriTemsilcisiID: TFieldDB;
    FMusteriTemsilcisi: TFieldDB;
    FTeklifTipiID: TFieldDB;
    FTeklifTipi: TFieldDB;
    FAdresSevkiyat: TFieldDB;
    FSehirSevkiyat: TFieldDB;
    FMuhattapAd: TFieldDB;
    FMuhattapSoyad: TFieldDB;
    FOdemeVadesi: TFieldDB;
    FReferans: TFieldDB;
    FTeslimatSuresi: TFieldDB;
    FTeklifDurumID: TFieldDB;
    FTeklifDurum: TFieldDB;
    FSevkTarihi: TFieldDB;
    FVadeGunSayisi: TFieldDB;
    FFaturaSevkTarihi: TFieldDB;
    FParaBirimi: TFieldDB;
    FDolarKur: TFieldDB;
    FEuroKur: TFieldDB;
    FOdemeBaslangicDonemiID: TFieldDB;
    FOdemeBaslangicDonemi: TFieldDB;
    FTeslimSartiID: TFieldDB;
    FTeslimSarti: TFieldDB;
    FGonderimSekliID: TFieldDB;
    FGonderimSekli: TFieldDB;
    FGonderimSekliDetay: TFieldDB;
    FOdemeSekliID: TFieldDB;
    FOdemeSekli: TFieldDB;
    FAciklama: TFieldDB;
    FProformaNo: TFieldDB;
    FArayanKisiID: TFieldDB;
    FArayanKisi: TFieldDB;
    FAramaTarihi: TFieldDB;
    FSonrakiAksiyonTarihi: TFieldDB;
    FAksiyonNotu: TFieldDB;
    FTevkifatKodu: TFieldDB;
    FTevkifatPay: TFieldDB;
    FTevkifatPayda: TFieldDB;
    FIhracKayitKodu: TFieldDB;
    //veri tabaný alaný deðil
    FOrtakIskonto: TFieldDB;
    FOrtakKDV: TFieldDB;
  protected
    vMusteriTemsilcisi: TPersonelKarti;
    vIslemTipi: TAyarEFaturaFaturaTipi;
    vTeklifTipi: TAyarTeklifTipi;
    vTeklifDurum: TAyarTeklifDurum;
    vOdemeBaslangicDonemi: TAyarOdemeBaslangicDonemi;

    procedure BusinessSelect(pFilter: string; pLock, pPermissionControl: Boolean); override;
    procedure BusinessInsert(out pID: Integer; var pPermissionControl: Boolean); override;
    procedure BusinessUpdate(pPermissionControl: Boolean); override;
    procedure BusinessDelete(pPermissionControl: Boolean); override;

    procedure RefreshHeader(); override;
    function ValidateDetay(pTable: TTable): Boolean; override;
  published
    constructor Create(pOwnerDatabase: TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean = True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean = True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean = True); override;
    procedure Update(pPermissionControl: Boolean = True); override;

    procedure Clear(); override;
    function Clone(): TTable; override;

    function ToSiparis(): TTable;
    function ToProforma(): TTable;

    procedure RefreshHeaderPublic();

    procedure AddDetay(pTable: TTable); override;
    procedure UpdateDetay(pTable: TTable); override;
    procedure RemoveDetay(pTable: TTable); override;

    procedure DetayKopyala(pSelectedDetay: TSatisTeklifDetay);

    procedure SortDetaylar();
    function DetayUrunMiktariniAnaUrunMiktarinaGoreOranla(pID: Integer; pAnaUrunArtisMiktari: Double): Boolean;
    procedure AnaUrunOzetFiyatlandir();

    procedure FiyatlariGuncelle();

    function ContainsAnaUrun(): Boolean;
    function CheckFarkliKDV(): Boolean;
    function ValidateTasiyiciDetayMiktar(pMalKodu: string; pMiktar: Double; pTasiyiciDetayID: Integer): Boolean;

    procedure UpdateAlisTeklifOnayi(pAlisOnayi: Boolean);

    Property SiparisID: TFieldDB read FSiparisID write FSiparisID;
    Property IrsaliyeID: TFieldDB read FIrsaliyeID write FIrsaliyeID;
    Property FaturaID: TFieldDB read FFaturaID write FFaturaID;
    Property IsSiparislesti: TFieldDB read FIsSiparislesti write FIsSiparislesti;
    Property IsTaslak: TFieldDB read FIsTaslak write FIsTaslak;
    Property IsEFatura: TFieldDB read FIsEFatura write FIsEFatura;
    Property Tutar: TFieldDB read FTutar write FTutar;
    Property IskontoTutar: TFieldDB read FIskontoTutar write FIskontoTutar;
    Property AraToplam: TFieldDB read FAraToplam write FAraToplam;
    Property GenelIskontoTutar: TFieldDB read FGenelIskontoTutar write FGenelIskontoTutar;
    Property KDVTutar: TFieldDB read FKDVTutar write FKDVTutar;
    Property GenelToplam: TFieldDB read FGenelToplam write FGenelToplam;
    Property IslemTipiID: TFieldDB read FIslemTipiID write FIslemTipiID;
    Property IslemTipi: TFieldDB read FIslemTipi write FIslemTipi;
    Property TeklifNo: TFieldDB read FTeklifNo write FTeklifNo;
    Property TeklifTarihi: TFieldDB read FTeklifTarihi write FTeklifTarihi;
    Property TeslimTarihi: TFieldDB read FTeslimTarihi write FTeslimTarihi;
    Property GecerlilikTarihi: TFieldDB read FGecerlilikTarihi write FGecerlilikTarihi;
    Property MusteriKodu: TFieldDB read FMusteriKodu write FMusteriKodu;
    Property MusteriAdi: TFieldDB read FMusteriAdi write FMusteriAdi;
    Property AdresMusteri: TFieldDB read FAdresMusteri write FAdresMusteri;
    Property SehirMusteri: TFieldDB read FSehirMusteri write FSehirMusteri;
    Property PostaKodu: TFieldDB read FPostaKodu write FPostaKodu;
    Property VergiDairesi: TFieldDB read FVergiDairesi write FVergiDairesi;
    Property VergiNo: TFieldDB read FVergiNo write FVergiNo;
    Property MusteriTemsilcisiID: TFieldDB read FMusteriTemsilcisiID write FMusteriTemsilcisiID;
    Property MusteriTemsilcisi: TFieldDB read FMusteriTemsilcisi write FMusteriTemsilcisi;
    Property TeklifTipiID: TFieldDB read FTeklifTipiID write FTeklifTipiID;
    Property TeklifTipi: TFieldDB read FTeklifTipi write FTeklifTipi;
    Property AdresSevkiyat: TFieldDB read FAdresSevkiyat write FAdresSevkiyat;
    Property SehirSevkiyat: TFieldDB read FSehirSevkiyat write FSehirSevkiyat;
    Property MuhattapAd: TFieldDB read FMuhattapAd write FMuhattapAd;
    Property MuhattapSoyad: TFieldDB read FMuhattapSoyad write FMuhattapSoyad;
    Property OdemeVadesi: TFieldDB read FOdemeVadesi write FOdemeVadesi;
    Property Referans: TFieldDB read FReferans write FReferans;
    Property TeslimatSuresi: TFieldDB read FTeslimatSuresi write FTeslimatSuresi;
    Property TeklifDurumID: TFieldDB read FTeklifDurumID write FTeklifDurumID;
    Property TeklifDurum: TFieldDB read FTeklifDurum write FTeklifDurum;
    Property SevkTarihi: TFieldDB read FSevkTarihi write FSevkTarihi;
    Property VadeGunSayisi: TFieldDB read FVadeGunSayisi write FVadeGunSayisi;
    Property FaturaSevkTarihi: TFieldDB read FFaturaSevkTarihi write FFaturaSevkTarihi;
    Property ParaBirimi: TFieldDB read FParaBirimi write FParaBirimi;
    Property DolarKur: TFieldDB read FDolarKur write FDolarKur;
    Property EuroKur: TFieldDB read FEuroKur write FEuroKur;
    Property OdemeBaslangicDonemiID: TFieldDB read FOdemeBaslangicDonemiID write FOdemeBaslangicDonemiID;
    Property OdemeBaslangicDonemi: TFieldDB read FOdemeBaslangicDonemi write FOdemeBaslangicDonemi;
    Property TeslimSartiID: TFieldDB read FTeslimSartiID write FTeslimSartiID;
    Property TeslimSarti: TFieldDB read FTeslimSarti write FTeslimSarti;
    Property GonderimSekliID: TFieldDB read FGonderimSekliID write FGonderimSekliID;
    Property GonderimSekli: TFieldDB read FGonderimSekli write FGonderimSekli;
    Property GonderimSekliDetay: TFieldDB read FGonderimSekliDetay write FGonderimSekliDetay;
    Property OdemeSekliID: TFieldDB read FOdemeSekliID write FOdemeSekliID;
    Property OdemeSekli: TFieldDB read FOdemeSekli write FOdemeSekli;
    Property Aciklama: TFieldDB read FAciklama write FAciklama;
    Property ProformaNo: TFieldDB read FProformaNo write FProformaNo;
    Property ArayanKisiID: TFieldDB read FArayanKisiID write FArayanKisiID;
    Property ArayanKisi: TFieldDB read FArayanKisi write FArayanKisi;
    Property AramaTarihi: TFieldDB read FAramaTarihi write FAramaTarihi;
    Property SonrakiAksiyonTarihi: TFieldDB read FSonrakiAksiyonTarihi write FSonrakiAksiyonTarihi;
    Property AksiyonNotu: TFieldDB read FAksiyonNotu write FAksiyonNotu;
    Property TevkifatKodu: TFieldDB read FTevkifatKodu write FTevkifatKodu;
    Property TevkifatPay: TFieldDB read FTevkifatPay write FTevkifatPay;
    Property TevkifatPayda: TFieldDB read FTevkifatPayda write FTevkifatPayda;
    Property IhracKayitKodu: TFieldDB read FIhracKayitKodu write FIhracKayitKodu;
    //veri tabaný alaný deðil
    Property OrtakIskonto: TFieldDB read FOrtakIskonto write FOrtakIskonto;
    Property OrtakKDV: TFieldDB read FOrtakKDV write FOrtakKDV;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSatisTeklif.Create(pOwnerDatabase:TDatabase);
begin
  inherited Create(pOwnerDatabase);
  TableName := 'satis_teklif';
  SourceCode := '1000';

  FSiparisID := TFieldDB.Create('siparis_id', ftInteger, 0);
  FIrsaliyeID := TFieldDB.Create('irsaliye_id', ftInteger, 0);
  FFaturaID := TFieldDB.Create('fatura_id', ftInteger, 0);
  FIsSiparislesti := TFieldDB.Create('is_siparislesti', ftBoolean, False, 0, False);
  FIsTaslak := TFieldDB.Create('is_taslak', ftBoolean, False, 0, False);
  FIsEFatura := TFieldDB.Create('is_efatura', ftBoolean, False, 0, False);
  FTutar := TFieldDB.Create('tutar', ftFloat, 0, 0, False);
  FIskontoTutar := TFieldDB.Create('iskonto_tutar', ftFloat, 0, 0, False);
  FAraToplam := TFieldDB.Create('ara_toplam', ftFloat, 0, 0, False);
  FGenelIskontoTutar := TFieldDB.Create('genel_iskonto_tutar', ftFloat, 0, 0, False);
  FKDVTutar := TFieldDB.Create('kdv_tutar', ftFloat, 0, 0, False);
  FGenelToplam := TFieldDB.Create('genel_toplam', ftFloat, 0, 0, False);
  FIslemTipiID := TFieldDB.Create('islem_tipi_id', ftInteger, 0);
  FIslemTipi := TFieldDB.Create('islem_tipi', ftString, '');
  FTeklifNo := TFieldDB.Create('teklif_no', ftString, '');
  FTeklifTarihi := TFieldDB.Create('teklif_tarihi', ftDateTime, 0);
  FTeslimTarihi := TFieldDB.Create('teslim_tarihi', ftDateTime, 0);
  FGecerlilikTarihi := TFieldDB.Create('gecerlilik_tarihi', ftDateTime, 0);
  FMusteriKodu := TFieldDB.Create('musteri_kodu', ftString, '');
  FMusteriAdi := TFieldDB.Create('musteri_adi', ftString, '');
  FAdresMusteri := TFieldDB.Create('adres_musteri', ftString, '');
  FSehirMusteri := TFieldDB.Create('sehir_musteri', ftString, '');
  FPostaKodu := TFieldDB.Create('posta_kodu', ftString, '');
  FVergiDairesi := TFieldDB.Create('vergi_dairesi', ftString, '');
  FVergiNo := TFieldDB.Create('vergi_no', ftString, '');
  FMusteriTemsilcisiID := TFieldDB.Create('musteri_temsilcisi_id', ftInteger, 0);
  FMusteriTemsilcisi := TFieldDB.Create('musteri_temsilcisi', ftString, '');
  FTeklifTipiID := TFieldDB.Create('teklif_tipi_id', ftInteger, 0);
  FTeklifTipi := TFieldDB.Create('teklif_tipi', ftString, '');
  FAdresSevkiyat := TFieldDB.Create('adres_sevkiyat', ftString, '');
  FSehirSevkiyat := TFieldDB.Create('sehir_sevkiyat', ftString, '');
  FMuhattapAd := TFieldDB.Create('muhattap_ad', ftString, '');
  FMuhattapSoyad := TFieldDB.Create('muhattap_soyad', ftString, '');
  FOdemeVadesi := TFieldDB.Create('odeme_vadesi', ftString, '');
  FReferans := TFieldDB.Create('referans', ftString, '');
  FTeslimatSuresi := TFieldDB.Create('teslimat_suresi', ftString, '');
  FTeklifDurumID := TFieldDB.Create('teklif_durum_id', ftInteger, 0);
  FTeklifDurum := TFieldDB.Create('teklif_durum', ftString, '');
  FSevkTarihi := TFieldDB.Create('sevk_tarihi', ftDateTime, 0);
  FVadeGunSayisi := TFieldDB.Create('vade_gun_sayisi', ftInteger, 0);
  FFaturaSevkTarihi := TFieldDB.Create('fatura_sevk_tarihi', ftString, '');
  FParaBirimi := TFieldDB.Create('para_birimi', ftString, '');
  FDolarKur := TFieldDB.Create('dolar_kur', ftFloat, 0);
  FEuroKur := TFieldDB.Create('euro_kur', ftFloat, 0);
  FOdemeBaslangicDonemiID := TFieldDB.Create('odeme_baslangic_donemi_id', ftInteger, 0);
  FOdemeBaslangicDonemi := TFieldDB.Create('odeme_baslangic_donemi', ftString, '');
  FTeslimSartiID := TFieldDB.Create('teslim_sarti_id', ftInteger, 0);
  FTeslimSarti := TFieldDB.Create('teslim_sarti', ftString, '');
  FGonderimSekliID := TFieldDB.Create('gonderim_sekli_id', ftInteger, 0);
  FGonderimSekli := TFieldDB.Create('gonderim_sekli', ftString, '');
  FGonderimSekliDetay := TFieldDB.Create('gonderim_sekli_detay', ftString, '');
  FOdemeSekliID := TFieldDB.Create('odeme_sekli_id', ftInteger, 0);
  FOdemeSekli := TFieldDB.Create('odeme_sekli', ftString, '');
  FAciklama := TFieldDB.Create('aciklama', ftString, '');
  FProformaNo := TFieldDB.Create('proforma_no', ftInteger, 0);
  FArayanKisiID := TFieldDB.Create('arayan_kisi_id', ftInteger, 0);
  FArayanKisi := TFieldDB.Create('arayan_kisi', ftString, '');
  FAramaTarihi := TFieldDB.Create('arama_tarihi', ftDateTime, 0);
  FSonrakiAksiyonTarihi := TFieldDB.Create('sonraki_aksiyon_tarihi', ftDateTime, 0);
  FAksiyonNotu := TFieldDB.Create('aksiyon_notu', ftString, '');
  FTevkifatKodu := TFieldDB.Create('tevkifat_kodu', ftString, '');
  FTevkifatPay := TFieldDB.Create('tevkifat_pay', ftInteger, 0);
  FTevkifatPayda := TFieldDB.Create('tevkifat_payda', ftInteger, 0);
  FIhracKayitKodu := TFieldDB.Create('ihrac_kayit_kodu', ftString, '');
  //veri tabaný alaný deðil
  FOrtakIskonto := TFieldDB.Create('ortak_iskonto', ftFloat, 0);
  FOrtakKDV := TFieldDB.Create('ortak_kdv', ftFloat, 0);
end;

procedure TSatisTeklif.DetayKopyala(pSelectedDetay: TSatisTeklifDetay);
begin
  //
end;

function TSatisTeklif.DetayUrunMiktariniAnaUrunMiktarinaGoreOranla(pID: Integer;
  pAnaUrunArtisMiktari: Double): Boolean;
begin
  Result := False;
end;

procedure TSatisTeklif.FiyatlariGuncelle;
begin
  //
end;

procedure TSatisTeklif.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      vMusteriTemsilcisi := TPersonelKarti.Create(Database);
      vIslemTipi := TAyarEFaturaFaturaTipi.Create(Database);
      vTeklifTipi := TAyarTeklifTipi.Create(Database);
      vTeklifDurum := TAyarTeklifDurum.Create(Database);
      vOdemeBaslangicDonemi := TAyarOdemeBaslangicDonemi.Create(Database);
      try
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FSiparisID.FieldName,
          TableName + '.' + FIrsaliyeID.FieldName,
          TableName + '.' + FFaturaID.FieldName,
          TableName + '.' + FIsSiparislesti.FieldName,
          TableName + '.' + FIsTaslak.FieldName,
          TableName + '.' + FIsEFatura.FieldName,
          TableName + '.' + FTutar.FieldName,
          TableName + '.' + FIskontoTutar.FieldName,
          TableName + '.' + FAraToplam.FieldName,
          TableName + '.' + FGenelIskontoTutar.FieldName,
          TableName + '.' + FKDVTutar.FieldName,
          TableName + '.' + FGenelToplam.FieldName,
          TableName + '.' + FIslemTipiID.FieldName,
          ColumnFromIDCol(vIslemTipi.Tip.FieldName, vIslemTipi.TableName, FIslemTipiID.FieldName, FIslemTipi.FieldName, TableName),
          TableName + '.' + FTeklifNo.FieldName,
          TableName + '.' + FTeklifTarihi.FieldName,
          TableName + '.' + FTeslimTarihi.FieldName,
          TableName + '.' + FGecerlilikTarihi.FieldName,
          TableName + '.' + FMusteriKodu.FieldName,
          TableName + '.' + FMusteriAdi.FieldName,
          TableName + '.' + FAdresMusteri.FieldName,
          TableName + '.' + FSehirMusteri.FieldName,
          TableName + '.' + FPostaKodu.FieldName,
          TableName + '.' + FVergiDairesi.FieldName,
          TableName + '.' + FVergiNo.FieldName,
          TableName + '.' + FMusteriTemsilcisiID.FieldName,
          ColumnFromIDCol(vMusteriTemsilcisi.PersonelAdSoyad.FieldName, vMusteriTemsilcisi.TableName, FMusteriTemsilcisiID.FieldName, FMusteriTemsilcisi.FieldName, TableName),
          TableName + '.' + FTeklifTipiID.FieldName,
          ColumnFromIDCol(vTeklifTipi.Deger.FieldName, vTeklifTipi.TableName, FTeklifTipiID.FieldName, FTeklifTipi.FieldName, TableName),
          TableName + '.' + FAdresSevkiyat.FieldName,
          TableName + '.' + FSehirSevkiyat.FieldName,
          TableName + '.' + FMuhattapAd.FieldName,
          TableName + '.' + FMuhattapSoyad.FieldName,
          TableName + '.' + FOdemeVadesi.FieldName,
          TableName + '.' + FReferans.FieldName,
          TableName + '.' + FTeslimatSuresi.FieldName,
          TableName + '.' + FTeklifDurumID.FieldName,
          ColumnFromIDCol(vTeklifDurum.Deger.FieldName, vTeklifDurum.TableName, FTeklifDurumID.FieldName, FTeklifDurum.FieldName, TableName),
          TableName + '.' + FSevkTarihi.FieldName,
          TableName + '.' + FVadeGunSayisi.FieldName,
          TableName + '.' + FFaturaSevkTarihi.FieldName,
          TableName + '.' + FParaBirimi.FieldName,
          TableName + '.' + FDolarKur.FieldName,
          TableName + '.' + FEuroKur.FieldName,
          TableName + '.' + FOdemeBaslangicDonemiID.FieldName,
          ColumnFromIDCol(vOdemeBaslangicDonemi.Deger.FieldName, vOdemeBaslangicDonemi.TableName, FOdemeBaslangicDonemiID.FieldName, FOdemeBaslangicDonemi.FieldName, TableName),

          TableName + '.' + FTeslimSartiID.FieldName,
//          ColumnFromIDCol(vOdemeBaslangicDonemi.Deger.FieldName, vOdemeBaslangicDonemi.TableName, FOdemeBaslangicDonemiID.FieldName, FOdemeBaslangicDonemi.FieldName, TableName),

          TableName + '.' + FGonderimSekliID.FieldName,
//          ColumnFromIDCol(vOdemeBaslangicDonemi.Deger.FieldName, vOdemeBaslangicDonemi.TableName, FOdemeBaslangicDonemiID.FieldName, FOdemeBaslangicDonemi.FieldName, TableName),

          TableName + '.' + FGonderimSekliDetay.FieldName,

          TableName + '.' + FOdemeSekliID.FieldName,
//          ColumnFromIDCol(vOdemeBaslangicDonemi.Deger.FieldName, vOdemeBaslangicDonemi.TableName, FOdemeBaslangicDonemiID.FieldName, FOdemeBaslangicDonemi.FieldName, TableName),

          TableName + '.' + FAciklama.FieldName,
          TableName + '.' + FProformaNo.FieldName,

          TableName + '.' + FArayanKisiID.FieldName,
          ColumnFromIDCol(vMusteriTemsilcisi.PersonelAdSoyad.FieldName, vMusteriTemsilcisi.TableName, FArayanKisiID.FieldName, FArayanKisi.FieldName, TableName),

          TableName + '.' + FAramaTarihi.FieldName,
          TableName + '.' + FSonrakiAksiyonTarihi.FieldName,
          TableName + '.' + FAksiyonNotu.FieldName,
          TableName + '.' + FTevkifatKodu.FieldName,
          TableName + '.' + FTevkifatPay.FieldName,
          TableName + '.' + FTevkifatPayda.FieldName,
          TableName + '.' + FIhracKayitKodu.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;
        Active := True;

        Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
        Self.DataSource.DataSet.FindField(FSiparisID.FieldName).DisplayLabel := 'Sipariþ ID';
        Self.DataSource.DataSet.FindField(FIrsaliyeID.FieldName).DisplayLabel := 'Ýrsaliye ID';
        Self.DataSource.DataSet.FindField(FFaturaID.FieldName).DisplayLabel := 'Fatura ID';
        Self.DataSource.DataSet.FindField(FIsSiparislesti.FieldName).DisplayLabel := 'Sipariþleþti?';
        Self.DataSource.DataSet.FindField(FIsTaslak.FieldName).DisplayLabel := 'Taslak?';
        Self.DataSource.DataSet.FindField(FIsEFatura.FieldName).DisplayLabel := 'E-Fatura?';
        Self.DataSource.DataSet.FindField(FTutar.FieldName).DisplayLabel := 'Tutar';
        Self.DataSource.DataSet.FindField(FIskontoTutar.FieldName).DisplayLabel := 'Ýskonto Tutar';
        Self.DataSource.DataSet.FindField(FAraToplam.FieldName).DisplayLabel := 'Ara Toplam';
        Self.DataSource.DataSet.FindField(FGenelIskontoTutar.FieldName).DisplayLabel := 'Genel Ýskonto Tutar';
        Self.DataSource.DataSet.FindField(FKDVTutar.FieldName).DisplayLabel := 'KDV Tutar';
        Self.DataSource.DataSet.FindField(FGenelToplam.FieldName).DisplayLabel := 'Genel Toplam';
        Self.DataSource.DataSet.FindField(FIslemTipiID.FieldName).DisplayLabel := 'Ýþlem Tipi ID';
        Self.DataSource.DataSet.FindField(FIslemTipi.FieldName).DisplayLabel := 'Ýþlem Tipi';
        Self.DataSource.DataSet.FindField(FTeklifNo.FieldName).DisplayLabel := 'Teklif No';
        Self.DataSource.DataSet.FindField(FTeklifTarihi.FieldName).DisplayLabel := 'Teklif Tarihi';
        Self.DataSource.DataSet.FindField(FTeslimTarihi.FieldName).DisplayLabel := 'Teslim Tarihi';
        Self.DataSource.DataSet.FindField(FGecerlilikTarihi.FieldName).DisplayLabel := 'Geçerlilik Tarihi';
        Self.DataSource.DataSet.FindField(FMusteriKodu.FieldName).DisplayLabel := 'Müþteri Kodu';
        Self.DataSource.DataSet.FindField(FMusteriAdi.FieldName).DisplayLabel := 'Müþteri Adý';
        Self.DataSource.DataSet.FindField(FAdresMusteri.FieldName).DisplayLabel := 'Adres Müþteri';
        Self.DataSource.DataSet.FindField(FSehirMusteri.FieldName).DisplayLabel := 'Þehir Müþteri';
        Self.DataSource.DataSet.FindField(FPostaKodu.FieldName).DisplayLabel := 'Posta Kodu';
        Self.DataSource.DataSet.FindField(FVergiDairesi.FieldName).DisplayLabel := 'Vergi Dairesi';
        Self.DataSource.DataSet.FindField(FVergiNo.FieldName).DisplayLabel := 'Vergi No';
        Self.DataSource.DataSet.FindField(FMusteriTemsilcisiID.FieldName).DisplayLabel := 'Müþteri Temsilci ID';
        Self.DataSource.DataSet.FindField(FMusteriTemsilcisi.FieldName).DisplayLabel := 'Müþteri Temsilci';
        Self.DataSource.DataSet.FindField(FTeklifTipiID.FieldName).DisplayLabel := 'Teklif Tipi ID';
        Self.DataSource.DataSet.FindField(FTeklifTipi.FieldName).DisplayLabel := 'Teklif Tipi';
        Self.DataSource.DataSet.FindField(FAdresSevkiyat.FieldName).DisplayLabel := 'Adres Sevkiyat';
        Self.DataSource.DataSet.FindField(FSehirSevkiyat.FieldName).DisplayLabel := 'Þehir Sevkiyat';
        Self.DataSource.DataSet.FindField(FMuhattapAd.FieldName).DisplayLabel := 'Muhattap Ad';
        Self.DataSource.DataSet.FindField(FMuhattapSoyad.FieldName).DisplayLabel := 'Muhattap Soyad';
        Self.DataSource.DataSet.FindField(FOdemeVadesi.FieldName).DisplayLabel := 'Ödeme Vadesi';
        Self.DataSource.DataSet.FindField(FReferans.FieldName).DisplayLabel := 'Referans';
        Self.DataSource.DataSet.FindField(FTeslimatSuresi.FieldName).DisplayLabel := 'Teslimat Süresi';
        Self.DataSource.DataSet.FindField(FTeklifDurumID.FieldName).DisplayLabel := 'Teklif Durum ID';
        Self.DataSource.DataSet.FindField(FTeklifDurum.FieldName).DisplayLabel := 'Teklif Durum';
        Self.DataSource.DataSet.FindField(FSevkTarihi.FieldName).DisplayLabel := 'Sevk Tarihi';
        Self.DataSource.DataSet.FindField(FVadeGunSayisi.FieldName).DisplayLabel := 'Vade Gün Sayýsý';
        Self.DataSource.DataSet.FindField(FFaturaSevkTarihi.FieldName).DisplayLabel := 'Fatura Sevk Tarihi';
        Self.DataSource.DataSet.FindField(FParaBirimi.FieldName).DisplayLabel := 'Para Birimi';
        Self.DataSource.DataSet.FindField(FDolarKur.FieldName).DisplayLabel := 'Dolar Kuru';
        Self.DataSource.DataSet.FindField(FEuroKur.FieldName).DisplayLabel := 'Euro Kuru';
        Self.DataSource.DataSet.FindField(FOdemeBaslangicDonemiID.FieldName).DisplayLabel := 'Ödeme Baþlangýç Dönemi ID';
        Self.DataSource.DataSet.FindField(FOdemeBaslangicDonemi.FieldName).DisplayLabel := 'Ödeme Baþlangýç Dönemi';
        Self.DataSource.DataSet.FindField(FTeslimSartiID.FieldName).DisplayLabel := 'Teslim Þartý ID';
  //      Self.DataSource.DataSet.FindField(FTeslimSarti.FieldName).DisplayLabel := 'Teslim Þartý';
        Self.DataSource.DataSet.FindField(FGonderimSekliID.FieldName).DisplayLabel := 'Gönderim Þekli ID';
  //      Self.DataSource.DataSet.FindField(FGonderimSekli.FieldName).DisplayLabel := 'Gönderim Þekli';
        Self.DataSource.DataSet.FindField(GonderimSekliDetay.FieldName).DisplayLabel := 'Gönderim Þekli Detay';
        Self.DataSource.DataSet.FindField(FOdemeSekliID.FieldName).DisplayLabel := 'Ödeme Þekli ID';
  //      Self.DataSource.DataSet.FindField(FOdemeSekli.FieldName).DisplayLabel := 'Ödeme Þekli';
        Self.DataSource.DataSet.FindField(FAciklama.FieldName).DisplayLabel := 'Açýklama';
        Self.DataSource.DataSet.FindField(FProformaNo.FieldName).DisplayLabel := 'Proforma No';
        Self.DataSource.DataSet.FindField(FArayanKisiID.FieldName).DisplayLabel := 'Arayan Kiþi ID';
        Self.DataSource.DataSet.FindField(FArayanKisi.FieldName).DisplayLabel := 'Arayan Kiþi';
        Self.DataSource.DataSet.FindField(FAramaTarihi.FieldName).DisplayLabel := 'Arama Tarihi';
        Self.DataSource.DataSet.FindField(FSonrakiAksiyonTarihi.FieldName).DisplayLabel := 'Sonraki Aksiyon Tarihi';
        Self.DataSource.DataSet.FindField(FAksiyonNotu.FieldName).DisplayLabel := 'Aksiyon Notu';
        Self.DataSource.DataSet.FindField(FTevkifatKodu.FieldName).DisplayLabel := 'Tevkifat Kodu';
        Self.DataSource.DataSet.FindField(FTevkifatPay.FieldName).DisplayLabel := 'Tevkifat Pay';
        Self.DataSource.DataSet.FindField(FTevkifatPayda.FieldName).DisplayLabel := 'Tevkifat Payda';
        Self.DataSource.DataSet.FindField(FIhracKayitKodu.FieldName).DisplayLabel := 'Ýhraç Kayýt Kodu';
      finally
        vMusteriTemsilcisi.Free;
        vIslemTipi.Free;
        vTeklifTipi.Free;
        vTeklifDurum.Free;
        vOdemeBaslangicDonemi.Free;
      end;
    end;
  end;
end;

procedure TSatisTeklif.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
      pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

    with QueryOfList do
    begin
      vMusteriTemsilcisi := TPersonelKarti.Create(Database);
      vIslemTipi := TAyarEFaturaFaturaTipi.Create(Database);
      vTeklifTipi := TAyarTeklifTipi.Create(Database);
      vTeklifDurum := TAyarTeklifDurum.Create(Database);
      vOdemeBaslangicDonemi := TAyarOdemeBaslangicDonemi.Create(Database);
      try
        Close;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FSiparisID.FieldName,
          TableName + '.' + FIrsaliyeID.FieldName,
          TableName + '.' + FFaturaID.FieldName,
          TableName + '.' + FIsSiparislesti.FieldName,
          TableName + '.' + FIsTaslak.FieldName,
          TableName + '.' + FIsEFatura.FieldName,
          TableName + '.' + FTutar.FieldName,
          TableName + '.' + FIskontoTutar.FieldName,
          TableName + '.' + FAraToplam.FieldName,
          TableName + '.' + FGenelIskontoTutar.FieldName,
          TableName + '.' + FKDVTutar.FieldName,
          TableName + '.' + FGenelToplam.FieldName,
          TableName + '.' + FIslemTipiID.FieldName,
          ColumnFromIDCol(vIslemTipi.Tip.FieldName, vIslemTipi.TableName, FIslemTipiID.FieldName, FIslemTipi.FieldName, TableName),
          TableName + '.' + FTeklifNo.FieldName,
          TableName + '.' + FTeklifTarihi.FieldName,
          TableName + '.' + FTeslimTarihi.FieldName,
          TableName + '.' + FGecerlilikTarihi.FieldName,
          TableName + '.' + FMusteriKodu.FieldName,
          TableName + '.' + FMusteriAdi.FieldName,
          TableName + '.' + FAdresMusteri.FieldName,
          TableName + '.' + FSehirMusteri.FieldName,
          TableName + '.' + FPostaKodu.FieldName,
          TableName + '.' + FVergiDairesi.FieldName,
          TableName + '.' + FVergiNo.FieldName,
          TableName + '.' + FMusteriTemsilcisiID.FieldName,
          ColumnFromIDCol(vMusteriTemsilcisi.PersonelAdSoyad.FieldName, vMusteriTemsilcisi.TableName, FMusteriTemsilcisiID.FieldName, FMusteriTemsilcisi.FieldName, TableName),
          TableName + '.' + FTeklifTipiID.FieldName,
          ColumnFromIDCol(vTeklifTipi.Deger.FieldName, vTeklifTipi.TableName, FTeklifTipiID.FieldName, FTeklifTipi.FieldName, TableName),
          TableName + '.' + FAdresSevkiyat.FieldName,
          TableName + '.' + FSehirSevkiyat.FieldName,
          TableName + '.' + FMuhattapAd.FieldName,
          TableName + '.' + FMuhattapSoyad.FieldName,
          TableName + '.' + FOdemeVadesi.FieldName,
          TableName + '.' + FReferans.FieldName,
          TableName + '.' + FTeslimatSuresi.FieldName,
          TableName + '.' + FTeklifDurumID.FieldName,
          ColumnFromIDCol(vTeklifDurum.Deger.FieldName, vTeklifDurum.TableName, FTeklifDurumID.FieldName, FTeklifDurum.FieldName, TableName),
          TableName + '.' + FSevkTarihi.FieldName,
          TableName + '.' + FVadeGunSayisi.FieldName,
          TableName + '.' + FFaturaSevkTarihi.FieldName,
          TableName + '.' + FParaBirimi.FieldName,
          TableName + '.' + FDolarKur.FieldName,
          TableName + '.' + FEuroKur.FieldName,
          TableName + '.' + FOdemeBaslangicDonemiID.FieldName,
          ColumnFromIDCol(vOdemeBaslangicDonemi.Deger.FieldName, vOdemeBaslangicDonemi.TableName, FOdemeBaslangicDonemiID.FieldName, FOdemeBaslangicDonemi.FieldName, TableName),

          TableName + '.' + FTeslimSartiID.FieldName,
//          ColumnFromIDCol(vOdemeBaslangicDonemi.Deger.FieldName, vOdemeBaslangicDonemi.TableName, FOdemeBaslangicDonemiID.FieldName, FOdemeBaslangicDonemi.FieldName, TableName),

          TableName + '.' + FGonderimSekliID.FieldName,
//          ColumnFromIDCol(vOdemeBaslangicDonemi.Deger.FieldName, vOdemeBaslangicDonemi.TableName, FOdemeBaslangicDonemiID.FieldName, FOdemeBaslangicDonemi.FieldName, TableName),

          TableName + '.' + FGonderimSekliDetay.FieldName,

          TableName + '.' + FOdemeSekliID.FieldName,
//          ColumnFromIDCol(vOdemeBaslangicDonemi.Deger.FieldName, vOdemeBaslangicDonemi.TableName, FOdemeBaslangicDonemiID.FieldName, FOdemeBaslangicDonemi.FieldName, TableName),

          TableName + '.' + FAciklama.FieldName,
          TableName + '.' + FProformaNo.FieldName,

          TableName + '.' + FArayanKisiID.FieldName,
          ColumnFromIDCol(vMusteriTemsilcisi.PersonelAdSoyad.FieldName, vMusteriTemsilcisi.TableName, FArayanKisiID.FieldName, FArayanKisi.FieldName, TableName),

          TableName + '.' + FAramaTarihi.FieldName,
          TableName + '.' + FSonrakiAksiyonTarihi.FieldName,
          TableName + '.' + FAksiyonNotu.FieldName,
          TableName + '.' + FTevkifatKodu.FieldName,
          TableName + '.' + FTevkifatPay.FieldName,
          TableName + '.' + FTevkifatPayda.FieldName,
          TableName + '.' + FIhracKayitKodu.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;

        FreeListContent();
        List.Clear;
        while NOT EOF do
        begin
          Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

          FSiparisID.Value := FormatedVariantVal(FieldByName(FSiparisID.FieldName).DataType, FieldByName(FSiparisID.FieldName).Value);
          FIrsaliyeID.Value := FormatedVariantVal(FieldByName(FIrsaliyeID.FieldName).DataType, FieldByName(FIrsaliyeID.FieldName).Value);
          FFaturaID.Value := FormatedVariantVal(FieldByName(FFaturaID.FieldName).DataType, FieldByName(FFaturaID.FieldName).Value);
          FIsSiparislesti.Value := FormatedVariantVal(FieldByName(FIsSiparislesti.FieldName).DataType, FieldByName(FIsSiparislesti.FieldName).Value);
          FIsTaslak.Value := FormatedVariantVal(FieldByName(FIsTaslak.FieldName).DataType, FieldByName(FIsTaslak.FieldName).Value);
          FIsEFatura.Value := FormatedVariantVal(FieldByName(FIsEFatura.FieldName).DataType, FieldByName(FIsEFatura.FieldName).Value);
          FTutar.Value := FormatedVariantVal(FieldByName(FTutar.FieldName).DataType, FieldByName(FTutar.FieldName).Value);
          FIskontoTutar.Value := FormatedVariantVal(FieldByName(FIskontoTutar.FieldName).DataType, FieldByName(FIskontoTutar.FieldName).Value);
          FAraToplam.Value := FormatedVariantVal(FieldByName(FAraToplam.FieldName).DataType, FieldByName(FAraToplam.FieldName).Value);
          FGenelIskontoTutar.Value := FormatedVariantVal(FieldByName(FGenelIskontoTutar.FieldName).DataType, FieldByName(FGenelIskontoTutar.FieldName).Value);
          FKDVTutar.Value := FormatedVariantVal(FieldByName(FKDVTutar.FieldName).DataType, FieldByName(FKDVTutar.FieldName).Value);
          FGenelToplam.Value := FormatedVariantVal(FieldByName(FGenelToplam.FieldName).DataType, FieldByName(FGenelToplam.FieldName).Value);
          FIslemTipiID.Value := FormatedVariantVal(FieldByName(FIslemTipiID.FieldName).DataType, FieldByName(FIslemTipiID.FieldName).Value);
          FIslemTipi.Value := FormatedVariantVal(FieldByName(FIslemTipi.FieldName).DataType, FieldByName(FIslemTipi.FieldName).Value);
          FTeklifNo.Value := FormatedVariantVal(FieldByName(FTeklifNo.FieldName).DataType, FieldByName(FTeklifNo.FieldName).Value);
          FTeklifTarihi.Value := FormatedVariantVal(FieldByName(FTeklifTarihi.FieldName).DataType, FieldByName(FTeklifTarihi.FieldName).Value);
          FTeslimTarihi.Value := FormatedVariantVal(FieldByName(FTeslimTarihi.FieldName).DataType, FieldByName(FTeslimTarihi.FieldName).Value);
          FGecerlilikTarihi.Value := FormatedVariantVal(FieldByName(FGecerlilikTarihi.FieldName).DataType, FieldByName(FGecerlilikTarihi.FieldName).Value);
          FMusteriKodu.Value := FormatedVariantVal(FieldByName(FMusteriKodu.FieldName).DataType, FieldByName(FMusteriKodu.FieldName).Value);
          FMusteriAdi.Value := FormatedVariantVal(FieldByName(FMusteriAdi.FieldName).DataType, FieldByName(FMusteriAdi.FieldName).Value);
          FAdresMusteri.Value := FormatedVariantVal(FieldByName(FAdresMusteri.FieldName).DataType, FieldByName(FAdresMusteri.FieldName).Value);
          FSehirMusteri.Value := FormatedVariantVal(FieldByName(FSehirMusteri.FieldName).DataType, FieldByName(FSehirMusteri.FieldName).Value);
          FPostaKodu.Value := FormatedVariantVal(FieldByName(FPostaKodu.FieldName).DataType, FieldByName(FPostaKodu.FieldName).Value);
          FVergiDairesi.Value := FormatedVariantVal(FieldByName(FVergiDairesi.FieldName).DataType, FieldByName(FVergiDairesi.FieldName).Value);
          FVergiNo.Value := FormatedVariantVal(FieldByName(FVergiNo.FieldName).DataType, FieldByName(FVergiNo.FieldName).Value);
          FMusteriTemsilcisiID.Value := FormatedVariantVal(FieldByName(FMusteriTemsilcisiID.FieldName).DataType, FieldByName(FMusteriTemsilcisiID.FieldName).Value);
          FMusteriTemsilcisi.Value := FormatedVariantVal(FieldByName(FMusteriTemsilcisi.FieldName).DataType, FieldByName(FMusteriTemsilcisi.FieldName).Value);
          FTeklifTipiID.Value := FormatedVariantVal(FieldByName(FTeklifTipiID.FieldName).DataType, FieldByName(FTeklifTipiID.FieldName).Value);
          FTeklifTipi.Value := FormatedVariantVal(FieldByName(FTeklifTipi.FieldName).DataType, FieldByName(FTeklifTipi.FieldName).Value);
          FAdresSevkiyat.Value := FormatedVariantVal(FieldByName(FAdresSevkiyat.FieldName).DataType, FieldByName(FAdresSevkiyat.FieldName).Value);
          FSehirSevkiyat.Value := FormatedVariantVal(FieldByName(FSehirSevkiyat.FieldName).DataType, FieldByName(FSehirSevkiyat.FieldName).Value);
          FMuhattapAd.Value := FormatedVariantVal(FieldByName(FMuhattapAd.FieldName).DataType, FieldByName(FMuhattapAd.FieldName).Value);
          FMuhattapSoyad.Value := FormatedVariantVal(FieldByName(FMuhattapSoyad.FieldName).DataType, FieldByName(FMuhattapSoyad.FieldName).Value);
          FOdemeVadesi.Value := FormatedVariantVal(FieldByName(FOdemeVadesi.FieldName).DataType, FieldByName(FOdemeVadesi.FieldName).Value);
          FReferans.Value := FormatedVariantVal(FieldByName(FReferans.FieldName).DataType, FieldByName(FReferans.FieldName).Value);
          FTeslimatSuresi.Value := FormatedVariantVal(FieldByName(FTeslimatSuresi.FieldName).DataType, FieldByName(FTeslimatSuresi.FieldName).Value);
          FTeklifDurumID.Value := FormatedVariantVal(FieldByName(FTeklifDurumID.FieldName).DataType, FieldByName(FTeklifDurumID.FieldName).Value);
          FTeklifDurum.Value := FormatedVariantVal(FieldByName(FTeklifDurum.FieldName).DataType, FieldByName(FTeklifDurum.FieldName).Value);
          FSevkTarihi.Value := FormatedVariantVal(FieldByName(FSevkTarihi.FieldName).DataType, FieldByName(FSevkTarihi.FieldName).Value);
          FVadeGunSayisi.Value := FormatedVariantVal(FieldByName(FVadeGunSayisi.FieldName).DataType, FieldByName(FVadeGunSayisi.FieldName).Value);
          FFaturaSevkTarihi.Value := FormatedVariantVal(FieldByName(FFaturaSevkTarihi.FieldName).DataType, FieldByName(FFaturaSevkTarihi.FieldName).Value);
          FParaBirimi.Value := FormatedVariantVal(FieldByName(FParaBirimi.FieldName).DataType, FieldByName(FParaBirimi.FieldName).Value);
          FDolarKur.Value := FormatedVariantVal(FieldByName(FDolarKur.FieldName).DataType, FieldByName(FDolarKur.FieldName).Value);
          FEuroKur.Value := FormatedVariantVal(FieldByName(FEuroKur.FieldName).DataType, FieldByName(FEuroKur.FieldName).Value);
          FOdemeBaslangicDonemiID.Value := FormatedVariantVal(FieldByName(FOdemeBaslangicDonemiID.FieldName).DataType, FieldByName(FOdemeBaslangicDonemiID.FieldName).Value);
          FOdemeBaslangicDonemi.Value := FormatedVariantVal(FieldByName(FOdemeBaslangicDonemi.FieldName).DataType, FieldByName(FOdemeBaslangicDonemi.FieldName).Value);
          FTeslimSartiID.Value := FormatedVariantVal(FieldByName(FTeslimSartiID.FieldName).DataType, FieldByName(FTeslimSartiID.FieldName).Value);
//          FTeslimSarti.Value := FormatedVariantVal(FieldByName(FTeslimSarti.FieldName).DataType, FieldByName(FTeslimSarti.FieldName).Value);
          FGonderimSekliID.Value := FormatedVariantVal(FieldByName(FGonderimSekliID.FieldName).DataType, FieldByName(FGonderimSekliID.FieldName).Value);
//          FGonderimSekli.Value := FormatedVariantVal(FieldByName(FGonderimSekli.FieldName).DataType, FieldByName(FGonderimSekli.FieldName).Value);
          FGonderimSekliDetay.Value := FormatedVariantVal(FieldByName(FGonderimSekliDetay.FieldName).DataType, FieldByName(FGonderimSekliDetay.FieldName).Value);
          FOdemeSekliID.Value := FormatedVariantVal(FieldByName(FOdemeSekliID.FieldName).DataType, FieldByName(FOdemeSekliID.FieldName).Value);
//          FOdemeSekli.Value := FormatedVariantVal(FieldByName(FOdemeSekli.FieldName).DataType, FieldByName(FOdemeSekli.FieldName).Value);
          FAciklama.Value := FormatedVariantVal(FieldByName(FAciklama.FieldName).DataType, FieldByName(FAciklama.FieldName).Value);
          FProformaNo.Value := FormatedVariantVal(FieldByName(FProformaNo.FieldName).DataType, FieldByName(FProformaNo.FieldName).Value);
          FArayanKisiID.Value := FormatedVariantVal(FieldByName(FArayanKisiID.FieldName).DataType, FieldByName(FArayanKisiID.FieldName).Value);
          FArayanKisi.Value := FormatedVariantVal(FieldByName(FArayanKisi.FieldName).DataType, FieldByName(FArayanKisi.FieldName).Value);
          FAramaTarihi.Value := FormatedVariantVal(FieldByName(FAramaTarihi.FieldName).DataType, FieldByName(FAramaTarihi.FieldName).Value);
          FSonrakiAksiyonTarihi.Value := FormatedVariantVal(FieldByName(FSonrakiAksiyonTarihi.FieldName).DataType, FieldByName(FSonrakiAksiyonTarihi.FieldName).Value);
          FAksiyonNotu.Value := FormatedVariantVal(FieldByName(FAksiyonNotu.FieldName).DataType, FieldByName(FAksiyonNotu.FieldName).Value);
          FTevkifatKodu.Value := FormatedVariantVal(FieldByName(FTevkifatKodu.FieldName).DataType, FieldByName(FTevkifatKodu.FieldName).Value);
          FTevkifatPay.Value := FormatedVariantVal(FieldByName(FTevkifatPay.FieldName).DataType, FieldByName(FTevkifatPay.FieldName).Value);
          FTevkifatPayda.Value := FormatedVariantVal(FieldByName(FTevkifatPayda.FieldName).DataType, FieldByName(FTevkifatPayda.FieldName).Value);
          FIhracKayitKodu.Value := FormatedVariantVal(FieldByName(FIhracKayitKodu.FieldName).DataType, FieldByName(FIhracKayitKodu.FieldName).Value);

          List.Add(Self.Clone());

          Next;
        end;
        Close;
      finally
        vMusteriTemsilcisi.Free;
        vIslemTipi.Free;
        vTeklifTipi.Free;
        vTeklifDurum.Free;
        vOdemeBaslangicDonemi.Free;
      end;
    end;
  end;
end;

procedure TSatisTeklif.SortDetaylar;
begin
  //
end;

function TSatisTeklif.ToProforma: TTable;
begin
  Result := nil;
end;

function TSatisTeklif.ToSiparis: TTable;
begin
  Result := nil;
end;

procedure TSatisTeklif.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FSiparisID.FieldName,
        FIrsaliyeID.FieldName,
        FFaturaID.FieldName,
        FIsSiparislesti.FieldName,
        FIsTaslak.FieldName,
        FIsEFatura.FieldName,
        FTutar.FieldName,
        FIskontoTutar.FieldName,
        FAraToplam.FieldName,
        FGenelIskontoTutar.FieldName,
        FKDVTutar.FieldName,
        FGenelToplam.FieldName,
        FIslemTipiID.FieldName,
        FTeklifNo.FieldName,
        FTeklifTarihi.FieldName,
        FTeslimTarihi.FieldName,
        FGecerlilikTarihi.FieldName,
        FMusteriKodu.FieldName,
        FMusteriAdi.FieldName,
        FAdresMusteri.FieldName,
        FSehirMusteri.FieldName,
        FPostaKodu.FieldName,
        FVergiDairesi.FieldName,
        FVergiNo.FieldName,
        FMusteriTemsilcisiID.FieldName,
        FTeklifTipiID.FieldName,
        FAdresSevkiyat.FieldName,
        FSehirSevkiyat.FieldName,
        FMuhattapAd.FieldName,
        FMuhattapSoyad.FieldName,
        FOdemeVadesi.FieldName,
        FReferans.FieldName,
        FTeslimatSuresi.FieldName,
        FTeklifDurumID.FieldName,
        FSevkTarihi.FieldName,
        FVadeGunSayisi.FieldName,
        FFaturaSevkTarihi.FieldName,
        FParaBirimi.FieldName,
        FDolarKur.FieldName,
        FEuroKur.FieldName,
        FOdemeBaslangicDonemiID.FieldName,
        FTeslimSartiID.FieldName,
        FGonderimSekliID.FieldName,
        FGonderimSekliDetay.FieldName,
        FOdemeSekliID.FieldName,
        FAciklama.FieldName,
        FProformaNo.FieldName,
        FArayanKisiID.FieldName,
        FAramaTarihi.FieldName,
        FSonrakiAksiyonTarihi.FieldName,
        FAksiyonNotu.FieldName,
        FTevkifatKodu.FieldName,
        FTevkifatPay.FieldName,
        FTevkifatPayda.FieldName,
        FIhracKayitKodu.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FSiparisID);
      NewParamForQuery(QueryOfInsert, FIrsaliyeID);
      NewParamForQuery(QueryOfInsert, FFaturaID);
      NewParamForQuery(QueryOfInsert, FIsSiparislesti);
      NewParamForQuery(QueryOfInsert, FIsTaslak);
      NewParamForQuery(QueryOfInsert, FIsEFatura);
      NewParamForQuery(QueryOfInsert, FTutar);
      NewParamForQuery(QueryOfInsert, FIskontoTutar);
      NewParamForQuery(QueryOfInsert, FAraToplam);
      NewParamForQuery(QueryOfInsert, FGenelIskontoTutar);
      NewParamForQuery(QueryOfInsert, FKDVTutar);
      NewParamForQuery(QueryOfInsert, FGenelToplam);
      NewParamForQuery(QueryOfInsert, FIslemTipiID);
      NewParamForQuery(QueryOfInsert, FTeklifNo);
      NewParamForQuery(QueryOfInsert, FTeklifTarihi);
      NewParamForQuery(QueryOfInsert, FTeslimTarihi);
      NewParamForQuery(QueryOfInsert, FGecerlilikTarihi);
      NewParamForQuery(QueryOfInsert, FMusteriKodu);
      NewParamForQuery(QueryOfInsert, FMusteriAdi);
      NewParamForQuery(QueryOfInsert, FAdresMusteri);
      NewParamForQuery(QueryOfInsert, FSehirMusteri);
      NewParamForQuery(QueryOfInsert, FPostaKodu);
      NewParamForQuery(QueryOfInsert, FVergiDairesi);
      NewParamForQuery(QueryOfInsert, FVergiNo);
      NewParamForQuery(QueryOfInsert, FMusteriTemsilcisiID);
      NewParamForQuery(QueryOfInsert, FTeklifTipiID);
      NewParamForQuery(QueryOfInsert, FAdresSevkiyat);
      NewParamForQuery(QueryOfInsert, FSehirSevkiyat);
      NewParamForQuery(QueryOfInsert, FMuhattapAd);
      NewParamForQuery(QueryOfInsert, FMuhattapSoyad);
      NewParamForQuery(QueryOfInsert, FOdemeVadesi);
      NewParamForQuery(QueryOfInsert, FReferans);
      NewParamForQuery(QueryOfInsert, FTeslimatSuresi);
      NewParamForQuery(QueryOfInsert, FTeklifDurumID);
      NewParamForQuery(QueryOfInsert, FSevkTarihi);
      NewParamForQuery(QueryOfInsert, FVadeGunSayisi);
      NewParamForQuery(QueryOfInsert, FFaturaSevkTarihi);
      NewParamForQuery(QueryOfInsert, FParaBirimi);
      NewParamForQuery(QueryOfInsert, FDolarKur);
      NewParamForQuery(QueryOfInsert, FEuroKur);
      NewParamForQuery(QueryOfInsert, FOdemeBaslangicDonemiID);
      NewParamForQuery(QueryOfInsert, FTeslimSartiID);
      NewParamForQuery(QueryOfInsert, FGonderimSekliID);
      NewParamForQuery(QueryOfInsert, FGonderimSekliDetay);
      NewParamForQuery(QueryOfInsert, FOdemeSekliID);
      NewParamForQuery(QueryOfInsert, FAciklama);
      NewParamForQuery(QueryOfInsert, FProformaNo);
      NewParamForQuery(QueryOfInsert, FArayanKisiID);
      NewParamForQuery(QueryOfInsert, FAramaTarihi);
      NewParamForQuery(QueryOfInsert, FSonrakiAksiyonTarihi);
      NewParamForQuery(QueryOfInsert, FAksiyonNotu);
      NewParamForQuery(QueryOfInsert, FTevkifatKodu);
      NewParamForQuery(QueryOfInsert, FTevkifatPay);
      NewParamForQuery(QueryOfInsert, FTevkifatPayda);
      NewParamForQuery(QueryOfInsert, FIhracKayitKodu);

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

procedure TSatisTeklif.RefreshHeader;
var
  n1: Integer;
//  vTutarOndalik: Integer;
  vOndalikliHane: TAyarHaneSayisi;
//  vAgirlikliOpsiyon, vNetTutar: Double;
begin
  vOndalikliHane := TAyarHaneSayisi.Create(Self.Database);
  try
    Self.SortDetaylar;

    vOndalikliHane.SelectToList('', False, False);
//    vTutarOndalik := vOndalikliHane.SatisTutar.Value;

//    Self.ToplamTutar              := 0;
//    Self.ToplamIskontoTutar       := 0;
//    Self.ToplamGenelIskontoTutar  := 0;
//    Self.ToplamKDVTutar           := 0;
//    Self.GenelToplam              := 0;
//
//    Self.OrtalamaOpsiyon := 0;
//    vAgirlikliOpsiyon := 0;
//
    for n1 := 0 to Self.ListDetay.Count-1 do
    begin
//      vNetTutar := TGenel.RoundToX( (TTeklifDetay(self.ListDetay[nIndex]).NetFiyat * TTeklifDetay(self.ListDetay[nIndex]).Miktar), (-1)* tutar_ondalik);
//
//      self.ToplamTutar        := self.ToplamTutar        + TTeklifDetay(self.ListDetay[nIndex]).Tutar;
//      self.ToplamIskontoTutar := self.ToplamIskontoTutar + TTeklifDetay(self.ListDetay[nIndex]).Tutar - netTutar;
//      self.ToplamKDVTutar     := self.ToplamKDVTutar     + TTeklifDetay(self.ListDetay[nIndex]).KDVTutar;
//      self.GenelToplam        := self.GenelToplam        + TTeklifDetay(self.ListDetay[nIndex]).ToplamTutar;
//
//      dAgirlikliOpsiyon := dAgirlikliOpsiyon + (TTeklifDetay(self.ListDetay[nIndex]).Opsiyon * (TTeklifDetay(self.ListDetay[nIndex]).Tutar - TTeklifDetay(self.ListDetay[nIndex]).IskontoTutar + TTeklifDetay(self.ListDetay[nIndex]).KDVTutar));
    end;
//
//    //son 2 haneyi (ondalikli_hane.SatimTutar) dikkate alacak þekilde yuvarla sonucu, veri tabanýnda bu þekilde tutmaya çalýþýyoruz
//    self.ToplamTutar              := TGenel.RoundToX(self.ToplamTutar,              -1*(tutar_ondalik));
//    self.ToplamIskontoTutar       := TGenel.RoundToX(self.ToplamIskontoTutar,       -1*(tutar_ondalik));
//    self.ToplamGenelIskontoTutar  := TGenel.RoundToX(self.ToplamGenelIskontoTutar,  -1*(tutar_ondalik));
//    self.ToplamKDVTutar           := TGenel.RoundToX(self.ToplamKDVTutar,           -1*(tutar_ondalik));
//    self.GenelToplam              := TGenel.RoundToX(self.GenelToplam,              -1*(tutar_ondalik));
//
//
//    // Added by FERHAT 25.12.2015 17:40:00
//    //oran varsa oran hesabýný yaparak kulan. Oran yoksa ve tutar varsa tutara göre hesapla.
//    //fatura altý iskonto tutar için eklendi
//    if (not Self.CheckFarkliKDV) and (not Self.IsAlim) then
//    begin
//      if Self.GenelIskontoOrani <> 0 then
//      begin
//        //alt iskonto oranýna göre tutarý hesapla
//        Self.ToplamGenelIskontoTutar  := (Self.ToplamTutar - Self.ToplamIskontoTutar) * (Self.GenelIskontoOrani / 100);
//        self.ToplamGenelIskontoTutar  := TGenel.RoundToX(self.ToplamGenelIskontoTutar,  -1*(tutar_ondalik));
//      end
//      else
//      if Self.GenelIskontoTutar <> 0 then
//      begin
//        //alt iskonto oran yerine direkt tutar bilgisini al
//        Self.ToplamGenelIskontoTutar   := Self.GenelIskontoTutar;
//        self.ToplamGenelIskontoTutar  := TGenel.RoundToX(self.ToplamGenelIskontoTutar,  -1*(tutar_ondalik));
//      end;
//
//
//      if (Self.GenelIskontoOrani <> 0)
//      or (Self.GenelIskontoTutar <> 0) then
//      begin
//        //alt iskonto tutar düþerek kdv yi hesapla
//        if Self.ListDetay.Count > 0 then
//          Self.ToplamKDVTutar           := (self.ToplamTutar - self.ToplamIskontoTutar - Self.ToplamGenelIskontoTutar) * (TTeklifDetay(Self.ListDetay[0]).Kdv / 100)
//        else
//          Self.ToplamKDVTutar           := (self.ToplamTutar - self.ToplamIskontoTutar - Self.ToplamGenelIskontoTutar) * (0);
//        self.ToplamKDVTutar           := TGenel.RoundToX(self.ToplamKDVTutar,           -1*(tutar_ondalik));
//
//        //hesaplanan kdv ile genel toplamý hesapla
//        self.GenelToplam              := (self.ToplamTutar - self.ToplamIskontoTutar - Self.ToplamGenelIskontoTutar) + Self.ToplamKDVTutar;
//        self.GenelToplam              := TGenel.RoundToX(self.GenelToplam,              -1*(tutar_ondalik));
//      end;
//    end
//    else
//    begin
//      Self.GenelIskontoOrani        := 0;
//      Self.GenelIskontoTutar        := 0;
//      Self.ToplamGenelIskontoTutar  := 0;
//    end;
//
//
//    if (self.GenelToplam > 0) then
//    begin
//      self.OrtalamaOpsiyon  := Round(dAgirlikliOpsiyon / self.GenelToplam);
//    end;
  finally
    vOndalikliHane.Free;
  end;
end;

procedure TSatisTeklif.RefreshHeaderPublic;
begin
  //
end;

procedure TSatisTeklif.RemoveDetay(pTable: TTable);
begin
  if pTable.Id.Value > 0 then
    ListSilinenDetay.Add(pTable);
  ListDetay.Remove(pTable);
  RefreshHeader;
end;

procedure TSatisTeklif.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FSiparisID.FieldName,
        FIrsaliyeID.FieldName,
        FFaturaID.FieldName,
        FIsSiparislesti.FieldName,
        FIsTaslak.FieldName,
        FIsEFatura.FieldName,
        FTutar.FieldName,
        FIskontoTutar.FieldName,
        FAraToplam.FieldName,
        FGenelIskontoTutar.FieldName,
        FKDVTutar.FieldName,
        FGenelToplam.FieldName,
        FIslemTipiID.FieldName,
        FTeklifNo.FieldName,
        FTeklifTarihi.FieldName,
        FTeslimTarihi.FieldName,
        FGecerlilikTarihi.FieldName,
        FMusteriKodu.FieldName,
        FMusteriAdi.FieldName,
        FAdresMusteri.FieldName,
        FSehirMusteri.FieldName,
        FPostaKodu.FieldName,
        FVergiDairesi.FieldName,
        FVergiNo.FieldName,
        FMusteriTemsilcisiID.FieldName,
        FTeklifTipiID.FieldName,
        FAdresSevkiyat.FieldName,
        FSehirSevkiyat.FieldName,
        FMuhattapAd.FieldName,
        FMuhattapSoyad.FieldName,
        FOdemeVadesi.FieldName,
        FReferans.FieldName,
        FTeslimatSuresi.FieldName,
        FTeklifDurumID.FieldName,
        FSevkTarihi.FieldName,
        FVadeGunSayisi.FieldName,
        FFaturaSevkTarihi.FieldName,
        FParaBirimi.FieldName,
        FDolarKur.FieldName,
        FEuroKur.FieldName,
        FOdemeBaslangicDonemiID.FieldName,
        FTeslimSartiID.FieldName,
        FGonderimSekliID.FieldName,
        FGonderimSekliDetay.FieldName,
        FOdemeSekliID.FieldName,
        FAciklama.FieldName,
        FProformaNo.FieldName,
        FArayanKisiID.FieldName,
        FAramaTarihi.FieldName,
        FSonrakiAksiyonTarihi.FieldName,
        FAksiyonNotu.FieldName,
        FTevkifatKodu.FieldName,
        FTevkifatPay.FieldName,
        FTevkifatPayda.FieldName,
        FIhracKayitKodu.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FSiparisID);
      NewParamForQuery(QueryOfUpdate, FIrsaliyeID);
      NewParamForQuery(QueryOfUpdate, FFaturaID);
      NewParamForQuery(QueryOfUpdate, FIsSiparislesti);
      NewParamForQuery(QueryOfUpdate, FIsTaslak);
      NewParamForQuery(QueryOfUpdate, FIsEFatura);
      NewParamForQuery(QueryOfUpdate, FTutar);
      NewParamForQuery(QueryOfUpdate, FIskontoTutar);
      NewParamForQuery(QueryOfUpdate, FAraToplam);
      NewParamForQuery(QueryOfUpdate, FGenelIskontoTutar);
      NewParamForQuery(QueryOfUpdate, FKDVTutar);
      NewParamForQuery(QueryOfUpdate, FGenelToplam);
      NewParamForQuery(QueryOfUpdate, FIslemTipiID);
      NewParamForQuery(QueryOfUpdate, FTeklifNo);
      NewParamForQuery(QueryOfUpdate, FTeklifTarihi);
      NewParamForQuery(QueryOfUpdate, FTeslimTarihi);
      NewParamForQuery(QueryOfUpdate, FGecerlilikTarihi);
      NewParamForQuery(QueryOfUpdate, FMusteriKodu);
      NewParamForQuery(QueryOfUpdate, FMusteriAdi);
      NewParamForQuery(QueryOfUpdate, FAdresMusteri);
      NewParamForQuery(QueryOfUpdate, FSehirMusteri);
      NewParamForQuery(QueryOfUpdate, FPostaKodu);
      NewParamForQuery(QueryOfUpdate, FVergiDairesi);
      NewParamForQuery(QueryOfUpdate, FVergiNo);
      NewParamForQuery(QueryOfUpdate, FMusteriTemsilcisiID);
      NewParamForQuery(QueryOfUpdate, FTeklifTipiID);
      NewParamForQuery(QueryOfUpdate, FAdresSevkiyat);
      NewParamForQuery(QueryOfUpdate, FSehirSevkiyat);
      NewParamForQuery(QueryOfUpdate, FMuhattapAd);
      NewParamForQuery(QueryOfUpdate, FMuhattapSoyad);
      NewParamForQuery(QueryOfUpdate, FOdemeVadesi);
      NewParamForQuery(QueryOfUpdate, FReferans);
      NewParamForQuery(QueryOfUpdate, FTeslimatSuresi);
      NewParamForQuery(QueryOfUpdate, FTeklifDurumID);
      NewParamForQuery(QueryOfUpdate, FSevkTarihi);
      NewParamForQuery(QueryOfUpdate, FVadeGunSayisi);
      NewParamForQuery(QueryOfUpdate, FFaturaSevkTarihi);
      NewParamForQuery(QueryOfUpdate, FParaBirimi);
      NewParamForQuery(QueryOfUpdate, FDolarKur);
      NewParamForQuery(QueryOfUpdate, FEuroKur);
      NewParamForQuery(QueryOfUpdate, FOdemeBaslangicDonemiID);
      NewParamForQuery(QueryOfUpdate, FTeslimSartiID);
      NewParamForQuery(QueryOfUpdate, FGonderimSekliID);
      NewParamForQuery(QueryOfUpdate, FGonderimSekliDetay);
      NewParamForQuery(QueryOfUpdate, FOdemeSekliID);
      NewParamForQuery(QueryOfUpdate, FAciklama);
      NewParamForQuery(QueryOfUpdate, FProformaNo);
      NewParamForQuery(QueryOfUpdate, FArayanKisiID);
      NewParamForQuery(QueryOfUpdate, FAramaTarihi);
      NewParamForQuery(QueryOfUpdate, FSonrakiAksiyonTarihi);
      NewParamForQuery(QueryOfUpdate, FAksiyonNotu);
      NewParamForQuery(QueryOfUpdate, FTevkifatKodu);
      NewParamForQuery(QueryOfUpdate, FTevkifatPay);
      NewParamForQuery(QueryOfUpdate, FTevkifatPayda);
      NewParamForQuery(QueryOfUpdate, FIhracKayitKodu);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TSatisTeklif.AddDetay(pTable: TTable);
begin
  Self.ListDetay.Add(pTable);
end;

procedure TSatisTeklif.AnaUrunOzetFiyatlandir;
begin
  //
end;

procedure TSatisTeklif.BusinessDelete(pPermissionControl: Boolean);
begin
  inherited;
  //
end;

procedure TSatisTeklif.BusinessInsert(out pID: Integer;
  var pPermissionControl: Boolean);
var
  n1, vID: Integer;
begin
  Self.Insert(vID, True);

  for n1 := 0 to Self.ListDetay.Count-1 do
  begin
    TSatisTeklifDetay(Self.ListDetay[n1]).HeaderID.Value := vID;
    TSatisTeklifDetay(Self.ListDetay[n1]).Insert(vID, True);
  end;
end;

procedure TSatisTeklif.BusinessSelect(pFilter: string; pLock,
  pPermissionControl: Boolean);
var
  vTeklifDetay: TSatisTeklifDetay;
  n1: Integer;
begin
  FreeDetayListContent;

  Self.SelectToList(pFilter, pLock, pPermissionControl);
  
  vTeklifDetay := TSatisTeklifDetay.Create(Database);
  try
    vTeklifDetay.SelectToList(' AND ' + vTeklifDetay.TableName + '.' + vTeklifDetay.HeaderID.FieldName + '=' + VarToStr(Self.Id.Value), pLock, pPermissionControl);
    for n1 := 0 to vTeklifDetay.List.Count-1 do
    begin
      Self.ListDetay.Add(TSatisTeklifDetay(vTeklifDetay.List[n1]).Clone);
    end;
  finally
    vTeklifDetay.Free;
  end;
end;

procedure TSatisTeklif.BusinessUpdate(pPermissionControl: Boolean);
var
  n1, vID: Integer;
begin
  Self.Update(True);

  for n1 := 0 to Self.ListDetay.Count-1 do
  begin
    TSatisTeklifDetay(Self.ListDetay[n1]).HeaderID.Value := Self.Id.Value;

    if TSatisTeklifDetay(Self.ListDetay[n1]).Id.Value > 0 then
    begin
      TSatisTeklifDetay(Self.ListDetay[n1]).Update(True);
    end
    else
    begin
      TSatisTeklifDetay(Self.ListDetay[n1]).Insert(vID, True);
    end;
  end;

  for n1 := 0 to Self.ListSilinenDetay.Count-1 do
    if TSatisTeklifDetay(Self.ListSilinenDetay[n1]).Id.Value > 0 then
      TSatisTeklifDetay(Self.ListSilinenDetay[n1]).Delete(True);
end;

function TSatisTeklif.CheckFarkliKDV: Boolean;
begin
  Result := False;
end;

procedure TSatisTeklif.UpdateAlisTeklifOnayi(pAlisOnayi: Boolean);
begin
  //
end;

procedure TSatisTeklif.UpdateDetay(pTable: TTable);
begin
  inherited;
  //
end;

function TSatisTeklif.ValidateDetay(pTable: TTable): Boolean;
begin
  raise Exception.Create('DesteklenmeyenIslem');
end;

function TSatisTeklif.ValidateTasiyiciDetayMiktar(pMalKodu: string;
  pMiktar: Double; pTasiyiciDetayID: Integer): Boolean;
begin
  Result := False;
end;

procedure TSatisTeklif.Clear();
begin
  inherited;

  FSiparisID.Value := 0;
  FIrsaliyeID.Value := 0;
  FFaturaID.Value := 0;
  FIsSiparislesti.Value := False;
  FIsTaslak.Value := False;
  FIsEFatura.Value := False;
  FTutar.Value := 0;
  FIskontoTutar.Value := 0;
  FAraToplam.Value := 0;
  FGenelIskontoTutar.Value := 0;
  FKDVTutar.Value := 0;
  FGenelToplam.Value := 0;
  FIslemTipiID.Value := 0;
  FIslemTipi.Value := '';
  FTeklifNo.Value := '';
  FTeklifTarihi.Value := 0;
  FTeslimTarihi.Value := 0;
  FGecerlilikTarihi.Value := 0;
  FMusteriKodu.Value := '';
  FMusteriAdi.Value := '';
  FAdresMusteri.Value := '';
  FSehirMusteri.Value := '';
  FPostaKodu.Value := '';
  FVergiDairesi.Value := '';
  FVergiNo.Value := '';
  FMusteriTemsilcisiID.Value := 0;
  FMusteriTemsilcisi.Value := '';
  FTeklifTipiID.Value := 0;
  FTeklifTipi.Value := '';
  FAdresSevkiyat.Value := '';
  FSehirSevkiyat.Value := '';
  FMuhattapAd.Value := '';
  FMuhattapSoyad.Value := '';
  FOdemeVadesi.Value := '';
  FReferans.Value := '';
  FTeslimatSuresi.Value := '';
  FTeklifDurumID.Value := 0;
  FTeklifDurum.Value := '';
  FSevkTarihi.Value := 0;
  FVadeGunSayisi.Value := '';
  FFaturaSevkTarihi.Value := 0;
  FParaBirimi.Value := '';
  FDolarKur.Value := 0;
  FEuroKur.Value := 0;
  FOdemeBaslangicDonemiID.Value := 0;
  FOdemeBaslangicDonemi.Value := '';
  FTeslimSartiID.Value := 0;
  FTeslimSarti.Value := '';
  FGonderimSekliID.Value := 0;
  FGonderimSekli.Value := '';
  FGonderimSekliDetay.Value := '';
  FOdemeSekliID.Value := 0;
  FOdemeSekli.Value := '';
  FAciklama.Value := '';
  FProformaNo.Value := 0;
  FArayanKisiID.Value := 0;
  FArayanKisi.Value := '';
  FAramaTarihi.Value := 0;
  FSonrakiAksiyonTarihi.Value := 0;
  FAksiyonNotu.Value := '';
  FTevkifatKodu.Value := '';
  FTevkifatPay.Value := 0;
  FTevkifatPayda.Value := 0;
  FIhracKayitKodu.Value := '';
  //veri tabaný alaný deðil
  FOrtakIskonto.Value := 0;
  FOrtakKDV.Value := 0;
end;

function TSatisTeklif.Clone():TTable;
begin
  Result := TSatisTeklif.Create(Database);

  Self.Id.Clone(TSatisTeklif(Result).Id);

  FSiparisID.Clone(TSatisTeklif(Result).FSiparisID);
  FIrsaliyeID.Clone(TSatisTeklif(Result).FIrsaliyeID);
  FFaturaID.Clone(TSatisTeklif(Result).FFaturaID);
  FIsSiparislesti.Clone(TSatisTeklif(Result).FIsSiparislesti);
  FIsTaslak.Clone(TSatisTeklif(Result).FIsTaslak);
  FIsEFatura.Clone(TSatisTeklif(Result).FIsEFatura);
  FTutar.Clone(TSatisTeklif(Result).FTutar);
  FIskontoTutar.Clone(TSatisTeklif(Result).FIskontoTutar);
  FAraToplam.Clone(TSatisTeklif(Result).FAraToplam);
  FGenelIskontoTutar.Clone(TSatisTeklif(Result).FGenelIskontoTutar);
  FKDVTutar.Clone(TSatisTeklif(Result).FKDVTutar);
  FGenelToplam.Clone(TSatisTeklif(Result).FGenelToplam);
  FIslemTipiID.Clone(TSatisTeklif(Result).FIslemTipiID);
  FIslemTipi.Clone(TSatisTeklif(Result).FIslemTipi);
  FTeklifNo.Clone(TSatisTeklif(Result).FTeklifNo);
  FTeklifTarihi.Clone(TSatisTeklif(Result).FTeklifTarihi);
  FTeslimTarihi.Clone(TSatisTeklif(Result).FTeslimTarihi);
  FGecerlilikTarihi.Clone(TSatisTeklif(Result).FGecerlilikTarihi);
  FMusteriKodu.Clone(TSatisTeklif(Result).FMusteriKodu);
  FMusteriAdi.Clone(TSatisTeklif(Result).FMusteriAdi);
  FAdresMusteri.Clone(TSatisTeklif(Result).FAdresMusteri);
  FSehirMusteri.Clone(TSatisTeklif(Result).FSehirMusteri);
  FPostaKodu.Clone(TSatisTeklif(Result).FPostaKodu);
  FVergiDairesi.Clone(TSatisTeklif(Result).FVergiDairesi);
  FVergiNo.Clone(TSatisTeklif(Result).FVergiNo);
  FMusteriTemsilcisiID.Clone(TSatisTeklif(Result).FMusteriTemsilcisiID);
  FMusteriTemsilcisi.Clone(TSatisTeklif(Result).FMusteriTemsilcisi);
  FTeklifTipiID.Clone(TSatisTeklif(Result).FTeklifTipiID);
  FTeklifTipi.Clone(TSatisTeklif(Result).FTeklifTipi);
  FAdresSevkiyat.Clone(TSatisTeklif(Result).FAdresSevkiyat);
  FSehirSevkiyat.Clone(TSatisTeklif(Result).FSehirSevkiyat);
  FMuhattapAd.Clone(TSatisTeklif(Result).FMuhattapAd);
  FMuhattapSoyad.Clone(TSatisTeklif(Result).FMuhattapSoyad);
  FOdemeVadesi.Clone(TSatisTeklif(Result).FOdemeVadesi);
  FReferans.Clone(TSatisTeklif(Result).FReferans);
  FTeslimatSuresi.Clone(TSatisTeklif(Result).FTeslimatSuresi);
  FTeklifDurumID.Clone(TSatisTeklif(Result).FTeklifDurumID);
  FTeklifDurum.Clone(TSatisTeklif(Result).FTeklifDurum);
  FSevkTarihi.Clone(TSatisTeklif(Result).FSevkTarihi);
  FVadeGunSayisi.Clone(TSatisTeklif(Result).FVadeGunSayisi);
  FFaturaSevkTarihi.Clone(TSatisTeklif(Result).FFaturaSevkTarihi);
  FParaBirimi.Clone(TSatisTeklif(Result).FParaBirimi);
  FDolarKur.Clone(TSatisTeklif(Result).FDolarKur);
  FEuroKur.Clone(TSatisTeklif(Result).FEuroKur);
  FOdemeBaslangicDonemiID.Clone(TSatisTeklif(Result).FOdemeBaslangicDonemiID);
  FOdemeBaslangicDonemi.Clone(TSatisTeklif(Result).FOdemeBaslangicDonemi);
  FTeslimSartiID.Clone(TSatisTeklif(Result).FTeslimSartiID);
  FTeslimSarti.Clone(TSatisTeklif(Result).FTeslimSarti);
  FGonderimSekliID.Clone(TSatisTeklif(Result).FGonderimSekliID);
  FGonderimSekli.Clone(TSatisTeklif(Result).FGonderimSekli);
  FGonderimSekliDetay.Clone(TSatisTeklif(Result).FGonderimSekliDetay);
  FOdemeSekliID.Clone(TSatisTeklif(Result).FOdemeSekliID);
  FOdemeSekli.Clone(TSatisTeklif(Result).FOdemeSekli);
  FAciklama.Clone(TSatisTeklif(Result).FAciklama);
  FProformaNo.Clone(TSatisTeklif(Result).FProformaNo);
  FArayanKisiID.Clone(TSatisTeklif(Result).FArayanKisiID);
  FArayanKisi.Clone(TSatisTeklif(Result).FArayanKisi);
  FAramaTarihi.Clone(TSatisTeklif(Result).FAramaTarihi);
  FSonrakiAksiyonTarihi.Clone(TSatisTeklif(Result).FSonrakiAksiyonTarihi);
  FAksiyonNotu.Clone(TSatisTeklif(Result).FAksiyonNotu);
  FTevkifatKodu.Clone(TSatisTeklif(Result).FTevkifatKodu);
  FTevkifatPay.Clone(TSatisTeklif(Result).FTevkifatPay);
  FTevkifatPayda.Clone(TSatisTeklif(Result).FTevkifatPayda);
  FIhracKayitKodu.Clone(TSatisTeklif(Result).FIhracKayitKodu);
  //veri tabaný alaný deðil
  FOrtakIskonto.Clone(TSatisTeklif(Result).FOrtakIskonto);
  FOrtakKDV.Clone(TSatisTeklif(Result).FOrtakKDV);
end;

function TSatisTeklif.ContainsAnaUrun: Boolean;
begin
  Result := False;
end;

end.
