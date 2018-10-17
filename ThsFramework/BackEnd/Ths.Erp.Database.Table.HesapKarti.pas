unit Ths.Erp.Database.Table.HesapKarti;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field,

  Ths.Erp.Database.Table.HesapGrubu,
  Ths.Erp.Database.Table.AyarHesapTipi,
  Ths.Erp.Database.Table.PersonelKarti,
  Ths.Erp.Database.Table.Bolge,
  Ths.Erp.Database.Table.HesapPlani,
  Ths.Erp.Database.Table.AyarMukellefTipi,
  Ths.Erp.Database.Table.Ulke,
  Ths.Erp.Database.Table.Sehir
  ;

type
  THesapKarti = class(TTable)
  private
    FHesapKodu: TFieldDB;
    FHesapIsmi: TFieldDB;
    FHesapGrubuID: TFieldDB;
    FHesapGrubu: TFieldDB;
    FYetkiliKisi1: TFieldDB;
    FYetkiliKisi1Tel: TFieldDB;
    FYetkiliKisi2: TFieldDB;
    FYetkiliKisi2Tel: TFieldDB;
    FTelefon1: TFieldDB;
    FTelefon2: TFieldDB;
    FTelefon3: TFieldDB;
    FFaks: TFieldDB;
    FHesapIskonto: TFieldDB;
    FOzelBilgi: TFieldDB;
    FParaBirimi: TFieldDB;
    FHesapTipiID: TFieldDB;
    FHesapTipi: TFieldDB;
    FMusteriTemsilcisiID: TFieldDB;
    FMusteriTemsilcisi: TFieldDB;
    FBolgeID: TFieldDB;
    FBolge: TFieldDB;
    FMuhasebePlanKodu: TFieldDB;
    FKrediLimiti: TFieldDB;
    FIsEFaturaHesabi: TFieldDB;
    FOdemeVadeGunSayisi: TFieldDB;
    FVergiDairesi: TFieldDB;
    FVergiNo: TFieldDB;
    FMukellefTipiID: TFieldDB;
    FMukellefTipi: TFieldDB;
    FMukellefAdi: TFieldDB;
    FMukellefIkinciAdi: TFieldDB;
    FMukellefSoyadi: TFieldDB;
    FNaceKodu: TFieldDB;
    FWebSitesi: TFieldDB;
    FePostaAdresi: TFieldDB;
    FUlkeID: TFieldDB;
    FUlke: TFieldDB;
    FSehirID: TFieldDB;
    FSehir: TFieldDB;
    FIlce: TFieldDB;
    FMahalle: TFieldDB;
    FCadde: TFieldDB;
    FSokak: TFieldDB;
    FBina: TFieldDB;
    FKapiNo: TFieldDB;
    FPostaKodu: TFieldDB;
    FPostaKutusu: TFieldDB;
    FIbanNo: TFieldDB;
    FIbanParaBirimi: TFieldDB;
    FKategoriID: TFieldDB;
    FKategori: TFieldDB;
    FTemsilciGrubuId: TFieldDB;
    FTemsilciGrubu: TFieldDB;
    FMuhasebeTelefon: TFieldDB;
    FMuhasebeEPosta: TFieldDB;
    FIsAcikHesap: TFieldDB;
  protected
    vHesapGrubu: THesapGrubu;
    vAyarHesapTipi: TAyarHesapTipi;
    vMusteriTemsilcisi: TPersonelKarti;
    vBolge: TBolge;
    vHesapPlani: THesapPlani;
    vAyarMukellefTipi: TAyarMukellefTipi;
    vUlke: TUlke;
    vSehir: TSehir;
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property HesapKodu: TFieldDB read FHesapKodu write FHesapKodu;
    Property HesapIsmi: TFieldDB read FHesapIsmi write FHesapIsmi;
    Property HesapGrubuID: TFieldDB read FHesapGrubuID write FHesapGrubuID;
    Property HesapGrubu: TFieldDB read FHesapGrubu write FHesapGrubu;
    Property YetkiliKisi1: TFieldDB read FYetkiliKisi1 write FYetkiliKisi1;
    Property YetkiliKisi1Tel: TFieldDB read FYetkiliKisi1Tel write FYetkiliKisi1Tel;
    Property YetkiliKisi2: TFieldDB read FYetkiliKisi2 write FYetkiliKisi2;
    Property YetkiliKisi2Tel: TFieldDB read FYetkiliKisi2Tel write FYetkiliKisi2Tel;
    Property Telefon1: TFieldDB read FTelefon1 write FTelefon1;
    Property Telefon2: TFieldDB read FTelefon2 write FTelefon2;
    Property Telefon3: TFieldDB read FTelefon3 write FTelefon3;
    Property Faks: TFieldDB read FFaks write FFaks;
    Property HesapIskonto: TFieldDB read FHesapIskonto write FHesapIskonto;
    Property OzelBilgi: TFieldDB read FOzelBilgi write FOzelBilgi;
    Property ParaBirimi: TFieldDB read FParaBirimi write FParaBirimi;
    Property HesapTipiID: TFieldDB read FHesapTipiID write FHesapTipiID;
    Property HesapTipi: TFieldDB read FHesapTipi write FHesapTipi;
    Property MusteriTemsilcisiID: TFieldDB read FMusteriTemsilcisiID write FMusteriTemsilcisiID;
    Property MusteriTemsilcisi: TFieldDB read FMusteriTemsilcisi write FMusteriTemsilcisi;
    Property BolgeID: TFieldDB read FBolgeID write FBolgeID;
    Property Bolge: TFieldDB read FBolge write FBolge;
    Property MuhasebePlanKodu: TFieldDB read FMuhasebePlanKodu write FMuhasebePlanKodu;
    Property KrediLimiti: TFieldDB read FKrediLimiti write FKrediLimiti;
    Property IsEFaturaHesabi: TFieldDB read FIsEFaturaHesabi write FIsEFaturaHesabi;
    Property OdemeVadeGunSayisi: TFieldDB read FOdemeVadeGunSayisi write FOdemeVadeGunSayisi;
    Property VergiDairesi: TFieldDB read FVergiDairesi write FVergiDairesi;
    Property VergiNo: TFieldDB read FVergiNo write FVergiNo;
    Property MukellefTipiID: TFieldDB read FMukellefTipiID write FMukellefTipiID;
    Property MukellefTipi: TFieldDB read FMukellefTipi write FMukellefTipi;
    Property MukellefAdi: TFieldDB read FMukellefAdi write FMukellefAdi;
    Property MukellefIkinciAdi: TFieldDB read FMukellefIkinciAdi write FMukellefIkinciAdi;
    Property MukellefSoyadi: TFieldDB read FMukellefSoyadi write FMukellefSoyadi;
    Property NaceKodu: TFieldDB read FNaceKodu write FNaceKodu;
    Property WebSitesi: TFieldDB read FWebSitesi write FWebSitesi;
    Property ePostaAdresi: TFieldDB read FePostaAdresi write FePostaAdresi;
    Property UlkeID: TFieldDB read FUlkeID write FUlkeID;
    Property Ulke: TFieldDB read FUlke write FUlke;
    Property SehirID: TFieldDB read FSehirID write FSehirID;
    Property Sehir: TFieldDB read FSehir write FSehir;
    Property Ilce: TFieldDB read FIlce write FIlce;
    Property Mahalle: TFieldDB read FMahalle write FMahalle;
    Property Cadde: TFieldDB read FCadde write FCadde;
    Property Sokak: TFieldDB read FSokak write FSokak;
    Property Bina: TFieldDB read FBina write FBina;
    Property KapiNo: TFieldDB read FKapiNo write FKapiNo;
    Property PostaKodu: TFieldDB read FPostaKodu write FPostaKodu;
    Property PostaKutusu: TFieldDB read FPostaKutusu write FPostaKutusu;
    Property IbanNo: TFieldDB read FIbanNo write FIbanNo;
    Property IbanParaBirimi: TFieldDB read FIbanParaBirimi write FIbanParaBirimi;
    Property KategoriID: TFieldDB read FKategoriID write FKategoriID;
    Property Kategori: TFieldDB read FKategori write FKategori;
    Property TemsilciGrubuId: TFieldDB read FTemsilciGrubuId write FTemsilciGrubuId;
    Property TemsilciGrubu: TFieldDB read FTemsilciGrubu write FTemsilciGrubu;
    Property MuhasebeTelefon: TFieldDB read FMuhasebeTelefon write FMuhasebeTelefon;
    Property MuhasebeEPosta: TFieldDB read FMuhasebeEPosta write FMuhasebeEPosta;
    Property IsAcikHesap: TFieldDB read FIsAcikHesap write FIsAcikHesap;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor THesapKarti.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'hesap_karti';
  SourceCode := '1000';

  FHesapKodu := TFieldDB.Create('hesap_kodu', ftString, '');
  FHesapIsmi := TFieldDB.Create('hesap_ismi', ftString, '');
  FHesapGrubuID := TFieldDB.Create('hesap_grubu_id', ftInteger, 0);
  FHesapGrubu := TFieldDB.Create('hesap_grubu', ftString, '');
  FMukellefTipiID := TFieldDB.Create('mukellef_tipi_id', ftInteger, 0);
  FMukellefTipi := TFieldDB.Create('mukellef_tipi', ftInteger, 0);
  FMukellefAdi := TFieldDB.Create('mukellef_adi', ftString, '');
  FMukellefIkinciAdi := TFieldDB.Create('mukellef_ikinci_adi', ftString, '');
  FMukellefSoyadi := TFieldDB.Create('mukellef_soyadi', ftString, '');
  FUlkeID := TFieldDB.Create('ulke_id', ftInteger, 0);
  FUlke := TFieldDB.Create('ulke', ftString, '');
  FSehirID := TFieldDB.Create('sehir_id', ftInteger, 0);
  FSehir := TFieldDB.Create('sehir', ftString, '');
  FVergiDairesi := TFieldDB.Create('vergi_dairesi', ftString, '');
  FVergiNo := TFieldDB.Create('vergi_no', ftString, '');
  FIlce := TFieldDB.Create('ilce', ftString, '');
  FMahalle := TFieldDB.Create('mahalle', ftString, '');
  FCadde := TFieldDB.Create('cadde', ftString, '');
  FSokak := TFieldDB.Create('sokak', ftString, '');
  FBina := TFieldDB.Create('bina', ftString, '');
  FKapiNo := TFieldDB.Create('kapi_no', ftString, '');
  FPostaKodu := TFieldDB.Create('posta_kodu', ftString, '');
  FPostaKutusu := TFieldDB.Create('posta_kutusu', ftString, '');
  FTelefon1 := TFieldDB.Create('telefon1', ftString, '');
  FTelefon2 := TFieldDB.Create('telefon2', ftString, '');
  FTelefon3 := TFieldDB.Create('telefon3', ftString, '');
  FFaks := TFieldDB.Create('faks', ftString, '');
  FYetkiliKisi1 := TFieldDB.Create('yetkili_kisi1', ftString, '');
  FYetkiliKisi2 := TFieldDB.Create('yetkili_kisi2', ftString, '');
  FWebSitesi := TFieldDB.Create('web_sitesi', ftString, '');
  FePostaAdresi := TFieldDB.Create('eposta_adresi', ftString, '');
  FMuhasebeTelefon := TFieldDB.Create('muhasebe_telefon', ftString, '');
  FMuhasebeEPosta := TFieldDB.Create('muhasebe_eposta', ftString, '');
  FNaceKodu := TFieldDB.Create('nace_kodu', ftString, '');
  FParaBirimi := TFieldDB.Create('para_birimi', ftString, '');
  FOzelBilgi := TFieldDB.Create('ozel_bilgi', ftString, '');
  FOdemeVadeGunSayisi := TFieldDB.Create('odeme_vade_gun_sayisi', ftInteger, 0);
  FBolgeID := TFieldDB.Create('bolge_id', ftInteger, 0);
  FBolge := TFieldDB.Create('bolge', ftString, '');
  FIsEFaturaHesabi := TFieldDB.Create('is_efatura_hesabi', ftBoolean, 0);
  FIsAcikHesap := TFieldDB.Create('is_acik_hesap', ftBoolean, 0);
  FKrediLimiti := TFieldDB.Create('kredi_limiti', ftFloat, 0);
  FKategoriID := TFieldDB.Create('kategori_id', ftInteger, 0);
  FKategori := TFieldDB.Create('kategori', ftString, '');
  FTemsilciGrubuId := TFieldDB.Create('temsilci_grubu_id', ftInteger, 0);
  FTemsilciGrubu := TFieldDB.Create('temsilci_grubu', ftString, '');
  FMusteriTemsilcisiID := TFieldDB.Create('musteri_temsilcisi_id', ftInteger, 0);
  FMusteriTemsilcisi := TFieldDB.Create('musteri_temsilcisi', ftString, '');
  FIbanNo := TFieldDB.Create('iban_no', ftString, '');
  FIbanParaBirimi := TFieldDB.Create('iban_para_birimi', ftString, '');
  FMuhasebePlanKodu := TFieldDB.Create('muhasebe_plan_kodu', ftString, '');
end;

procedure THesapKarti.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      vHesapGrubu := THesapGrubu.Create(Database);
      vAyarHesapTipi := TAyarHesapTipi.Create(Database);
      vMusteriTemsilcisi := TPersonelKarti.Create(Database);
      vBolge := TBolge.Create(Database);
      vHesapPlani := THesapPlani.Create(Database);
      vAyarMukellefTipi := TAyarMukellefTipi.Create(Database);
      vUlke := TUlke.Create(Database);
      vSehir := TSehir.Create(Database);
      try
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FHesapKodu.FieldName,
          TableName + '.' + FHesapIsmi.FieldName,
          TableName + '.' + FHesapGrubuID.FieldName,
          TableName + '.' + FHesapGrubu.FieldName,
          TableName + '.' + FMukellefTipiID.FieldName,
          TableName + '.' + FMukellefTipi.FieldName,
          TableName + '.' + FMukellefAdi.FieldName,
          TableName + '.' + FMukellefIkinciAdi.FieldName,
          TableName + '.' + FMukellefSoyadi.FieldName,
          TableName + '.' + FUlkeID.FieldName,
          TableName + '.' + FUlke.FieldName,
          TableName + '.' + FSehirID.FieldName,
          TableName + '.' + FSehir.FieldName,
          TableName + '.' + FVergiDairesi.FieldName,
          TableName + '.' + FVergiNo.FieldName,
          TableName + '.' + FIlce.FieldName,
          TableName + '.' + FMahalle.FieldName,
          TableName + '.' + FCadde.FieldName,
          TableName + '.' + FSokak.FieldName,
          TableName + '.' + FBina.FieldName,
          TableName + '.' + FKapiNo.FieldName,
          TableName + '.' + FPostaKodu.FieldName,
          TableName + '.' + FPostaKutusu.FieldName,
          TableName + '.' + FTelefon1.FieldName,
          TableName + '.' + FTelefon2.FieldName,
          TableName + '.' + FTelefon3.FieldName,
          TableName + '.' + FFaks.FieldName,
          TableName + '.' + FYetkiliKisi1.FieldName,
          TableName + '.' + FYetkiliKisi2.FieldName,
          TableName + '.' + FWebSitesi.FieldName,
          TableName + '.' + FePostaAdresi.FieldName,
          TableName + '.' + FMuhasebeTelefon.FieldName,
          TableName + '.' + FMuhasebeEPosta.FieldName,
          TableName + '.' + FNaceKodu.FieldName,
          TableName + '.' + FParaBirimi.FieldName,
          TableName + '.' + FOzelBilgi.FieldName,
          TableName + '.' + FOdemeVadeGunSayisi.FieldName,
          TableName + '.' + FBolgeID.FieldName,
          TableName + '.' + FBolge.FieldName,
          TableName + '.' + FIsEFaturaHesabi.FieldName,
          TableName + '.' + FIsAcikHesap.FieldName,
          TableName + '.' + FKrediLimiti.FieldName,
          TableName + '.' + FKategoriID.FieldName,
          TableName + '.' + FKategori.FieldName,
          TableName + '.' + FTemsilciGrubuId.FieldName,
          TableName + '.' + FTemsilciGrubu.FieldName,
          TableName + '.' + FMusteriTemsilcisiID.FieldName,
          TableName + '.' + FMusteriTemsilcisi.FieldName,
          TableName + '.' + FIbanNo.FieldName,
          TableName + '.' + FIbanParaBirimi.FieldName,
          TableName + '.' + FMuhasebePlanKodu.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;
        Active := True;

        Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
        Self.DataSource.DataSet.FindField(FHesapKodu.FieldName).DisplayLabel := 'Hesap Kodu';
        Self.DataSource.DataSet.FindField(FHesapIsmi.FieldName).DisplayLabel := 'Hesap Ýsmi';
        Self.DataSource.DataSet.FindField(FHesapGrubuID.FieldName).DisplayLabel := 'Hesap Grubu ID';
        Self.DataSource.DataSet.FindField(FHesapGrubu.FieldName).DisplayLabel := 'Hesap Grubu';
        Self.DataSource.DataSet.FindField(FMukellefTipiID.FieldName).DisplayLabel := 'Mukellef Tipi ID';
        Self.DataSource.DataSet.FindField(FMukellefTipi.FieldName).DisplayLabel := 'Mükellef Tipi';
        Self.DataSource.DataSet.FindField(FMukellefAdi.FieldName).DisplayLabel := 'Mükellef Adý';
        Self.DataSource.DataSet.FindField(FMukellefIkinciAdi.FieldName).DisplayLabel := 'Mükellef Ýkinci Adý';
        Self.DataSource.DataSet.FindField(FMukellefSoyadi.FieldName).DisplayLabel := 'Mükellef Soyadý';
        Self.DataSource.DataSet.FindField(FUlkeID.FieldName).DisplayLabel := 'Ulke ID';
        Self.DataSource.DataSet.FindField(FUlke.FieldName).DisplayLabel := 'Ülke';
        Self.DataSource.DataSet.FindField(FSehirID.FieldName).DisplayLabel := 'Þehir ID';
        Self.DataSource.DataSet.FindField(FSehir.FieldName).DisplayLabel := 'Þehir';
        Self.DataSource.DataSet.FindField(FVergiDairesi.FieldName).DisplayLabel := 'Vergi Dairesi';
        Self.DataSource.DataSet.FindField(FVergiNo.FieldName).DisplayLabel := 'Vergi No';
        Self.DataSource.DataSet.FindField(FIlce.FieldName).DisplayLabel := 'Ýlçe';
        Self.DataSource.DataSet.FindField(FMahalle.FieldName).DisplayLabel := 'Mahalle';
        Self.DataSource.DataSet.FindField(FCadde.FieldName).DisplayLabel := 'Cadde';
        Self.DataSource.DataSet.FindField(FSokak.FieldName).DisplayLabel := 'Sokak';
        Self.DataSource.DataSet.FindField(FBina.FieldName).DisplayLabel := 'Bina';
        Self.DataSource.DataSet.FindField(FKapiNo.FieldName).DisplayLabel := 'Kapý No';
        Self.DataSource.DataSet.FindField(FPostaKodu.FieldName).DisplayLabel := 'Posta Kodu';
        Self.DataSource.DataSet.FindField(FPostaKutusu.FieldName).DisplayLabel := 'Posta Kutusu';
        Self.DataSource.DataSet.FindField(FTelefon1.FieldName).DisplayLabel := 'Telefon 1';
        Self.DataSource.DataSet.FindField(FTelefon2.FieldName).DisplayLabel := 'Telefon 2';
        Self.DataSource.DataSet.FindField(FTelefon3.FieldName).DisplayLabel := 'Telefon 3';
        Self.DataSource.DataSet.FindField(FFaks.FieldName).DisplayLabel := 'Faks';
        Self.DataSource.DataSet.FindField(FYetkiliKisi1.FieldName).DisplayLabel := 'Yetkili Kiþi 1';
        Self.DataSource.DataSet.FindField(FYetkiliKisi2.FieldName).DisplayLabel := 'Yetkili Kisi 2';
        Self.DataSource.DataSet.FindField(FWebSitesi.FieldName).DisplayLabel := 'Web Sitesi';
        Self.DataSource.DataSet.FindField(FePostaAdresi.FieldName).DisplayLabel := 'E-Posta Adresi';
        Self.DataSource.DataSet.FindField(FMuhasebeTelefon.FieldName).DisplayLabel := 'Muhasebe Telefon';
        Self.DataSource.DataSet.FindField(FMuhasebeEPosta.FieldName).DisplayLabel := 'Muhasebe E-Posta';
        Self.DataSource.DataSet.FindField(FNaceKodu.FieldName).DisplayLabel := 'Nace Kodu';
        Self.DataSource.DataSet.FindField(FParaBirimi.FieldName).DisplayLabel := 'Para Birimi';
        Self.DataSource.DataSet.FindField(FOzelBilgi.FieldName).DisplayLabel := 'Özel Bilgi';
        Self.DataSource.DataSet.FindField(FOdemeVadeGunSayisi.FieldName).DisplayLabel := 'Ödeme Vade Gün Sayýsý';
        Self.DataSource.DataSet.FindField(FBolgeID.FieldName).DisplayLabel := 'Bölge ID';
        Self.DataSource.DataSet.FindField(FBolge.FieldName).DisplayLabel := 'Bölge';
        Self.DataSource.DataSet.FindField(FIsEFaturaHesabi.FieldName).DisplayLabel := 'E-Fatura Hesabý?';
        Self.DataSource.DataSet.FindField(FIsAcikHesap.FieldName).DisplayLabel := 'Açýk Hesap?';
        Self.DataSource.DataSet.FindField(FKrediLimiti.FieldName).DisplayLabel := 'Kredi Limiti';
        Self.DataSource.DataSet.FindField(FKategoriID.FieldName).DisplayLabel := 'Kategori ID';
        Self.DataSource.DataSet.FindField(FKategori.FieldName).DisplayLabel := 'Kategori';
        Self.DataSource.DataSet.FindField(FTemsilciGrubuId.FieldName).DisplayLabel := 'Temsilci Grubu ID';
        Self.DataSource.DataSet.FindField(FTemsilciGrubu.FieldName).DisplayLabel := 'Temsilci Grubu';
        Self.DataSource.DataSet.FindField(FMusteriTemsilcisiID.FieldName).DisplayLabel := 'Müþteri Temsilcisi ID';
        Self.DataSource.DataSet.FindField(FMusteriTemsilcisi.FieldName).DisplayLabel := 'Müþteri Temsilcisi';
        Self.DataSource.DataSet.FindField(FIbanNo.FieldName).DisplayLabel := 'IBAN Numarasý';
        Self.DataSource.DataSet.FindField(FIbanParaBirimi.FieldName).DisplayLabel := 'IBAN Para Birimi';
        Self.DataSource.DataSet.FindField(FMuhasebePlanKodu.FieldName).DisplayLabel := 'Muhasebe Plan Kodu';
      finally
        vHesapGrubu.Free;
        vAyarHesapTipi.Free;
        vMusteriTemsilcisi.Free;
        vBolge.Free;
        vHesapPlani.Free;
        vAyarMukellefTipi.Free;
        vUlke.Free;
        vSehir.Free;
      end;
    end;
  end;
end;

procedure THesapKarti.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FHesapKodu.FieldName,
        TableName + '.' + FHesapIsmi.FieldName,
        TableName + '.' + FHesapGrubuID.FieldName,
        TableName + '.' + FHesapGrubu.FieldName,
        TableName + '.' + FMukellefTipiID.FieldName,
        TableName + '.' + FMukellefTipi.FieldName,
        TableName + '.' + FMukellefAdi.FieldName,
        TableName + '.' + FMukellefIkinciAdi.FieldName,
        TableName + '.' + FMukellefSoyadi.FieldName,
        TableName + '.' + FUlkeID.FieldName,
        TableName + '.' + FUlke.FieldName,
        TableName + '.' + FSehirID.FieldName,
        TableName + '.' + FSehir.FieldName,
        TableName + '.' + FVergiDairesi.FieldName,
        TableName + '.' + FVergiNo.FieldName,
        TableName + '.' + FIlce.FieldName,
        TableName + '.' + FMahalle.FieldName,
        TableName + '.' + FCadde.FieldName,
        TableName + '.' + FSokak.FieldName,
        TableName + '.' + FBina.FieldName,
        TableName + '.' + FKapiNo.FieldName,
        TableName + '.' + FPostaKodu.FieldName,
        TableName + '.' + FPostaKutusu.FieldName,
        TableName + '.' + FTelefon1.FieldName,
        TableName + '.' + FTelefon2.FieldName,
        TableName + '.' + FTelefon3.FieldName,
        TableName + '.' + FFaks.FieldName,
        TableName + '.' + FYetkiliKisi1.FieldName,
        TableName + '.' + FYetkiliKisi2.FieldName,
        TableName + '.' + FWebSitesi.FieldName,
        TableName + '.' + FePostaAdresi.FieldName,
        TableName + '.' + FMuhasebeTelefon.FieldName,
        TableName + '.' + FMuhasebeEPosta.FieldName,
        TableName + '.' + FNaceKodu.FieldName,
        TableName + '.' + FParaBirimi.FieldName,
        TableName + '.' + FOzelBilgi.FieldName,
        TableName + '.' + FOdemeVadeGunSayisi.FieldName,
        TableName + '.' + FBolgeID.FieldName,
        TableName + '.' + FBolge.FieldName,
        TableName + '.' + FIsEFaturaHesabi.FieldName,
        TableName + '.' + FIsAcikHesap.FieldName,
        TableName + '.' + FKrediLimiti.FieldName,
        TableName + '.' + FKategoriID.FieldName,
        TableName + '.' + FKategori.FieldName,
        TableName + '.' + FTemsilciGrubuId.FieldName,
        TableName + '.' + FTemsilciGrubu.FieldName,
        TableName + '.' + FMusteriTemsilcisiID.FieldName,
        TableName + '.' + FMusteriTemsilcisi.FieldName,
        TableName + '.' + FIbanNo.FieldName,
        TableName + '.' + FIbanParaBirimi.FieldName,
        TableName + '.' + FMuhasebePlanKodu.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FHesapKodu.Value := FormatedVariantVal(FieldByName(FHesapKodu.FieldName).DataType, FieldByName(FHesapKodu.FieldName).Value);
        FHesapIsmi.Value := FormatedVariantVal(FieldByName(FHesapIsmi.FieldName).DataType, FieldByName(FHesapIsmi.FieldName).Value);
        FHesapGrubuID.Value := FormatedVariantVal(FieldByName(FHesapGrubuID.FieldName).DataType, FieldByName(FHesapGrubuID.FieldName).Value);
        FHesapGrubu.Value := FormatedVariantVal(FieldByName(FHesapGrubu.FieldName).DataType, FieldByName(FHesapGrubu.FieldName).Value);
        FMukellefTipiID.Value := FormatedVariantVal(FieldByName(FMukellefTipiID.FieldName).DataType, FieldByName(FMukellefTipiID.FieldName).Value);
        FMukellefTipi.Value := FormatedVariantVal(FieldByName(FMukellefTipi.FieldName).DataType, FieldByName(FMukellefTipi.FieldName).Value);
        FMukellefAdi.Value := FormatedVariantVal(FieldByName(FMukellefAdi.FieldName).DataType, FieldByName(FMukellefAdi.FieldName).Value);
        FMukellefIkinciAdi.Value := FormatedVariantVal(FieldByName(FMukellefIkinciAdi.FieldName).DataType, FieldByName(FMukellefIkinciAdi.FieldName).Value);
        FMukellefSoyadi.Value := FormatedVariantVal(FieldByName(FMukellefSoyadi.FieldName).DataType, FieldByName(FMukellefSoyadi.FieldName).Value);
        FUlkeID.Value := FormatedVariantVal(FieldByName(FUlkeID.FieldName).DataType, FieldByName(FUlkeID.FieldName).Value);
        FUlke.Value := FormatedVariantVal(FieldByName(FUlke.FieldName).DataType, FieldByName(FUlke.FieldName).Value);
        FSehirID.Value := FormatedVariantVal(FieldByName(FSehirID.FieldName).DataType, FieldByName(FSehirID.FieldName).Value);
        FSehir.Value := FormatedVariantVal(FieldByName(FSehir.FieldName).DataType, FieldByName(FSehir.FieldName).Value);
        FVergiDairesi.Value := FormatedVariantVal(FieldByName(FVergiDairesi.FieldName).DataType, FieldByName(FVergiDairesi.FieldName).Value);
        FVergiNo.Value := FormatedVariantVal(FieldByName(FVergiNo.FieldName).DataType, FieldByName(FVergiNo.FieldName).Value);
        FIlce.Value := FormatedVariantVal(FieldByName(FIlce.FieldName).DataType, FieldByName(FIlce.FieldName).Value);
        FMahalle.Value := FormatedVariantVal(FieldByName(FMahalle.FieldName).DataType, FieldByName(FMahalle.FieldName).Value);
        FCadde.Value := FormatedVariantVal(FieldByName(FCadde.FieldName).DataType, FieldByName(FCadde.FieldName).Value);
        FSokak.Value := FormatedVariantVal(FieldByName(FSokak.FieldName).DataType, FieldByName(FSokak.FieldName).Value);
        FBina.Value := FormatedVariantVal(FieldByName(FBina.FieldName).DataType, FieldByName(FBina.FieldName).Value);
        FKapiNo.Value := FormatedVariantVal(FieldByName(FKapiNo.FieldName).DataType, FieldByName(FKapiNo.FieldName).Value);
        FPostaKodu.Value := FormatedVariantVal(FieldByName(FPostaKodu.FieldName).DataType, FieldByName(FPostaKodu.FieldName).Value);
        FPostaKutusu.Value := FormatedVariantVal(FieldByName(FPostaKutusu.FieldName).DataType, FieldByName(FPostaKutusu.FieldName).Value);
        FTelefon1.Value := FormatedVariantVal(FieldByName(FTelefon1.FieldName).DataType, FieldByName(FTelefon1.FieldName).Value);
        FTelefon2.Value := FormatedVariantVal(FieldByName(FTelefon2.FieldName).DataType, FieldByName(FTelefon2.FieldName).Value);
        FTelefon3.Value := FormatedVariantVal(FieldByName(FTelefon3.FieldName).DataType, FieldByName(FTelefon3.FieldName).Value);
        FFaks.Value := FormatedVariantVal(FieldByName(FFaks.FieldName).DataType, FieldByName(FFaks.FieldName).Value);
        FYetkiliKisi1.Value := FormatedVariantVal(FieldByName(FYetkiliKisi1.FieldName).DataType, FieldByName(FYetkiliKisi1.FieldName).Value);
        FYetkiliKisi2.Value := FormatedVariantVal(FieldByName(FYetkiliKisi2.FieldName).DataType, FieldByName(FYetkiliKisi2.FieldName).Value);
        FWebSitesi.Value := FormatedVariantVal(FieldByName(FWebSitesi.FieldName).DataType, FieldByName(FWebSitesi.FieldName).Value);
        FePostaAdresi.Value := FormatedVariantVal(FieldByName(FePostaAdresi.FieldName).DataType, FieldByName(FePostaAdresi.FieldName).Value);
        FMuhasebeTelefon.Value := FormatedVariantVal(FieldByName(FMuhasebeTelefon.FieldName).DataType, FieldByName(FMuhasebeTelefon.FieldName).Value);
        FMuhasebeEPosta.Value := FormatedVariantVal(FieldByName(FMuhasebeEPosta.FieldName).DataType, FieldByName(FMuhasebeEPosta.FieldName).Value);
        FNaceKodu.Value := FormatedVariantVal(FieldByName(FNaceKodu.FieldName).DataType, FieldByName(FNaceKodu.FieldName).Value);
        FParaBirimi.Value := FormatedVariantVal(FieldByName(FParaBirimi.FieldName).DataType, FieldByName(FParaBirimi.FieldName).Value);
        FOzelBilgi.Value := FormatedVariantVal(FieldByName(FOzelBilgi.FieldName).DataType, FieldByName(FOzelBilgi.FieldName).Value);
        FOdemeVadeGunSayisi.Value := FormatedVariantVal(FieldByName(FOdemeVadeGunSayisi.FieldName).DataType, FieldByName(FOdemeVadeGunSayisi.FieldName).Value);
        FBolgeID.Value := FormatedVariantVal(FieldByName(FBolgeID.FieldName).DataType, FieldByName(FBolgeID.FieldName).Value);
        FBolge.Value := FormatedVariantVal(FieldByName(FBolge.FieldName).DataType, FieldByName(FBolge.FieldName).Value);
        FIsEFaturaHesabi.Value := FormatedVariantVal(FieldByName(FIsEFaturaHesabi.FieldName).DataType, FieldByName(FIsEFaturaHesabi.FieldName).Value);
        FIsAcikHesap.Value := FormatedVariantVal(FieldByName(FIsAcikHesap.FieldName).DataType, FieldByName(FIsAcikHesap.FieldName).Value);
        FKrediLimiti.Value := FormatedVariantVal(FieldByName(FKrediLimiti.FieldName).DataType, FieldByName(FKrediLimiti.FieldName).Value);
        FKategoriID.Value := FormatedVariantVal(FieldByName(FKategoriID.FieldName).DataType, FieldByName(FKategoriID.FieldName).Value);
        FKategori.Value := FormatedVariantVal(FieldByName(FKategori.FieldName).DataType, FieldByName(FKategori.FieldName).Value);
        FTemsilciGrubuId.Value := FormatedVariantVal(FieldByName(FTemsilciGrubuId.FieldName).DataType, FieldByName(FTemsilciGrubuId.FieldName).Value);
        FTemsilciGrubu.Value := FormatedVariantVal(FieldByName(FTemsilciGrubu.FieldName).DataType, FieldByName(FTemsilciGrubu.FieldName).Value);
        FMusteriTemsilcisiID.Value := FormatedVariantVal(FieldByName(FMusteriTemsilcisiID.FieldName).DataType, FieldByName(FMusteriTemsilcisiID.FieldName).Value);
        FMusteriTemsilcisi.Value := FormatedVariantVal(FieldByName(FMusteriTemsilcisi.FieldName).DataType, FieldByName(FMusteriTemsilcisi.FieldName).Value);
        FIbanNo.Value := FormatedVariantVal(FieldByName(FIbanNo.FieldName).DataType, FieldByName(FIbanNo.FieldName).Value);
        FIbanParaBirimi.Value := FormatedVariantVal(FieldByName(FIbanParaBirimi.FieldName).DataType, FieldByName(FIbanParaBirimi.FieldName).Value);
        FMuhasebePlanKodu.Value := FormatedVariantVal(FieldByName(FMuhasebePlanKodu.FieldName).DataType, FieldByName(FMuhasebePlanKodu.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure THesapKarti.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FHesapKodu.FieldName,
        FHesapIsmi.FieldName,
        FHesapGrubuID.FieldName,
        FHesapGrubu.FieldName,
        FMukellefTipiID.FieldName,
        FMukellefTipi.FieldName,
        FMukellefAdi.FieldName,
        FMukellefIkinciAdi.FieldName,
        FMukellefSoyadi.FieldName,
        FUlkeID.FieldName,
        FUlke.FieldName,
        FSehirID.FieldName,
        FSehir.FieldName,
        FVergiDairesi.FieldName,
        FVergiNo.FieldName,
        FIlce.FieldName,
        FMahalle.FieldName,
        FCadde.FieldName,
        FSokak.FieldName,
        FBina.FieldName,
        FKapiNo.FieldName,
        FPostaKodu.FieldName,
        FPostaKutusu.FieldName,
        FTelefon1.FieldName,
        FTelefon2.FieldName,
        FTelefon3.FieldName,
        FFaks.FieldName,
        FYetkiliKisi1.FieldName,
        FYetkiliKisi2.FieldName,
        FWebSitesi.FieldName,
        FePostaAdresi.FieldName,
        FMuhasebeTelefon.FieldName,
        FMuhasebeEPosta.FieldName,
        FNaceKodu.FieldName,
        FParaBirimi.FieldName,
        FOzelBilgi.FieldName,
        FOdemeVadeGunSayisi.FieldName,
        FBolgeID.FieldName,
        FBolge.FieldName,
        FIsEFaturaHesabi.FieldName,
        FIsAcikHesap.FieldName,
        FKrediLimiti.FieldName,
        FKategoriID.FieldName,
        FKategori.FieldName,
        FTemsilciGrubuId.FieldName,
        FTemsilciGrubu.FieldName,
        FMusteriTemsilcisiID.FieldName,
        FMusteriTemsilcisi.FieldName,
        FIbanNo.FieldName,
        FIbanParaBirimi.FieldName,
        FMuhasebePlanKodu.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FHesapKodu);
      NewParamForQuery(QueryOfInsert, FHesapIsmi);
      NewParamForQuery(QueryOfInsert, FHesapGrubuID);
      NewParamForQuery(QueryOfInsert, FHesapGrubu);
      NewParamForQuery(QueryOfInsert, FMukellefTipiID);
      NewParamForQuery(QueryOfInsert, FMukellefTipi);
      NewParamForQuery(QueryOfInsert, FMukellefAdi);
      NewParamForQuery(QueryOfInsert, FMukellefIkinciAdi);
      NewParamForQuery(QueryOfInsert, FMukellefSoyadi);
      NewParamForQuery(QueryOfInsert, FUlkeID);
      NewParamForQuery(QueryOfInsert, FUlke);
      NewParamForQuery(QueryOfInsert, FSehirID);
      NewParamForQuery(QueryOfInsert, FSehir);
      NewParamForQuery(QueryOfInsert, FVergiDairesi);
      NewParamForQuery(QueryOfInsert, FVergiNo);
      NewParamForQuery(QueryOfInsert, FIlce);
      NewParamForQuery(QueryOfInsert, FMahalle);
      NewParamForQuery(QueryOfInsert, FCadde);
      NewParamForQuery(QueryOfInsert, FSokak);
      NewParamForQuery(QueryOfInsert, FBina);
      NewParamForQuery(QueryOfInsert, FKapiNo);
      NewParamForQuery(QueryOfInsert, FPostaKodu);
      NewParamForQuery(QueryOfInsert, FPostaKutusu);
      NewParamForQuery(QueryOfInsert, FTelefon1);
      NewParamForQuery(QueryOfInsert, FTelefon2);
      NewParamForQuery(QueryOfInsert, FTelefon3);
      NewParamForQuery(QueryOfInsert, FFaks);
      NewParamForQuery(QueryOfInsert, FYetkiliKisi1);
      NewParamForQuery(QueryOfInsert, FYetkiliKisi2);
      NewParamForQuery(QueryOfInsert, FWebSitesi);
      NewParamForQuery(QueryOfInsert, FePostaAdresi);
      NewParamForQuery(QueryOfInsert, FMuhasebeTelefon);
      NewParamForQuery(QueryOfInsert, FMuhasebeEPosta);
      NewParamForQuery(QueryOfInsert, FNaceKodu);
      NewParamForQuery(QueryOfInsert, FParaBirimi);
      NewParamForQuery(QueryOfInsert, FOzelBilgi);
      NewParamForQuery(QueryOfInsert, FOdemeVadeGunSayisi);
      NewParamForQuery(QueryOfInsert, FBolgeID);
      NewParamForQuery(QueryOfInsert, FBolge);
      NewParamForQuery(QueryOfInsert, FIsEFaturaHesabi);
      NewParamForQuery(QueryOfInsert, FIsAcikHesap);
      NewParamForQuery(QueryOfInsert, FKrediLimiti);
      NewParamForQuery(QueryOfInsert, FKategoriID);
      NewParamForQuery(QueryOfInsert, FKategori);
      NewParamForQuery(QueryOfInsert, FTemsilciGrubuId);
      NewParamForQuery(QueryOfInsert, FTemsilciGrubu);
      NewParamForQuery(QueryOfInsert, FMusteriTemsilcisiID);
      NewParamForQuery(QueryOfInsert, FMusteriTemsilcisi);
      NewParamForQuery(QueryOfInsert, FIbanNo);
      NewParamForQuery(QueryOfInsert, FIbanParaBirimi);
      NewParamForQuery(QueryOfInsert, FMuhasebePlanKodu);

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

procedure THesapKarti.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FHesapKodu.FieldName,
        FHesapIsmi.FieldName,
        FHesapGrubuID.FieldName,
        FHesapGrubu.FieldName,
        FMukellefTipiID.FieldName,
        FMukellefTipi.FieldName,
        FMukellefAdi.FieldName,
        FMukellefIkinciAdi.FieldName,
        FMukellefSoyadi.FieldName,
        FUlkeID.FieldName,
        FUlke.FieldName,
        FSehirID.FieldName,
        FSehir.FieldName,
        FVergiDairesi.FieldName,
        FVergiNo.FieldName,
        FIlce.FieldName,
        FMahalle.FieldName,
        FCadde.FieldName,
        FSokak.FieldName,
        FBina.FieldName,
        FKapiNo.FieldName,
        FPostaKodu.FieldName,
        FPostaKutusu.FieldName,
        FTelefon1.FieldName,
        FTelefon2.FieldName,
        FTelefon3.FieldName,
        FFaks.FieldName,
        FYetkiliKisi1.FieldName,
        FYetkiliKisi2.FieldName,
        FWebSitesi.FieldName,
        FePostaAdresi.FieldName,
        FMuhasebeTelefon.FieldName,
        FMuhasebeEPosta.FieldName,
        FNaceKodu.FieldName,
        FParaBirimi.FieldName,
        FOzelBilgi.FieldName,
        FOdemeVadeGunSayisi.FieldName,
        FBolgeID.FieldName,
        FBolge.FieldName,
        FIsEFaturaHesabi.FieldName,
        FIsAcikHesap.FieldName,
        FKrediLimiti.FieldName,
        FKategoriID.FieldName,
        FKategori.FieldName,
        FTemsilciGrubuId.FieldName,
        FTemsilciGrubu.FieldName,
        FMusteriTemsilcisiID.FieldName,
        FMusteriTemsilcisi.FieldName,
        FIbanNo.FieldName,
        FIbanParaBirimi.FieldName,
        FMuhasebePlanKodu.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FHesapKodu);
      NewParamForQuery(QueryOfUpdate, FHesapIsmi);
      NewParamForQuery(QueryOfUpdate, FHesapGrubuID);
      NewParamForQuery(QueryOfUpdate, FHesapGrubu);
      NewParamForQuery(QueryOfUpdate, FMukellefTipiID);
      NewParamForQuery(QueryOfUpdate, FMukellefTipi);
      NewParamForQuery(QueryOfUpdate, FMukellefAdi);
      NewParamForQuery(QueryOfUpdate, FMukellefIkinciAdi);
      NewParamForQuery(QueryOfUpdate, FMukellefSoyadi);
      NewParamForQuery(QueryOfUpdate, FUlkeID);
      NewParamForQuery(QueryOfUpdate, FUlke);
      NewParamForQuery(QueryOfUpdate, FSehirID);
      NewParamForQuery(QueryOfUpdate, FSehir);
      NewParamForQuery(QueryOfUpdate, FVergiDairesi);
      NewParamForQuery(QueryOfUpdate, FVergiNo);
      NewParamForQuery(QueryOfUpdate, FIlce);
      NewParamForQuery(QueryOfUpdate, FMahalle);
      NewParamForQuery(QueryOfUpdate, FCadde);
      NewParamForQuery(QueryOfUpdate, FSokak);
      NewParamForQuery(QueryOfUpdate, FBina);
      NewParamForQuery(QueryOfUpdate, FKapiNo);
      NewParamForQuery(QueryOfUpdate, FPostaKodu);
      NewParamForQuery(QueryOfUpdate, FPostaKutusu);
      NewParamForQuery(QueryOfUpdate, FTelefon1);
      NewParamForQuery(QueryOfUpdate, FTelefon2);
      NewParamForQuery(QueryOfUpdate, FTelefon3);
      NewParamForQuery(QueryOfUpdate, FFaks);
      NewParamForQuery(QueryOfUpdate, FYetkiliKisi1);
      NewParamForQuery(QueryOfUpdate, FYetkiliKisi2);
      NewParamForQuery(QueryOfUpdate, FWebSitesi);
      NewParamForQuery(QueryOfUpdate, FePostaAdresi);
      NewParamForQuery(QueryOfUpdate, FMuhasebeTelefon);
      NewParamForQuery(QueryOfUpdate, FMuhasebeEPosta);
      NewParamForQuery(QueryOfUpdate, FNaceKodu);
      NewParamForQuery(QueryOfUpdate, FParaBirimi);
      NewParamForQuery(QueryOfUpdate, FOzelBilgi);
      NewParamForQuery(QueryOfUpdate, FOdemeVadeGunSayisi);
      NewParamForQuery(QueryOfUpdate, FBolgeID);
      NewParamForQuery(QueryOfUpdate, FBolge);
      NewParamForQuery(QueryOfUpdate, FIsEFaturaHesabi);
      NewParamForQuery(QueryOfUpdate, FIsAcikHesap);
      NewParamForQuery(QueryOfUpdate, FKrediLimiti);
      NewParamForQuery(QueryOfUpdate, FKategoriID);
      NewParamForQuery(QueryOfUpdate, FKategori);
      NewParamForQuery(QueryOfUpdate, FTemsilciGrubuId);
      NewParamForQuery(QueryOfUpdate, FTemsilciGrubu);
      NewParamForQuery(QueryOfUpdate, FMusteriTemsilcisiID);
      NewParamForQuery(QueryOfUpdate, FMusteriTemsilcisi);
      NewParamForQuery(QueryOfUpdate, FIbanNo);
      NewParamForQuery(QueryOfUpdate, FIbanParaBirimi);
      NewParamForQuery(QueryOfUpdate, FMuhasebePlanKodu);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure THesapKarti.Clear();
begin
  inherited;

  FHesapKodu.Value := '';
  FHesapIsmi.Value := '';
  FHesapGrubuID.Value := 0;
  FHesapGrubu.Value := '';
  FMukellefTipiID.Value := 0;
  FMukellefTipi.Value := 0;
  FMukellefAdi.Value := '';
  FMukellefIkinciAdi.Value := '';
  FMukellefSoyadi.Value := '';
  FUlkeID.Value := 0;
  FUlke.Value := '';
  FSehirID.Value := 0;
  FSehir.Value := '';
  FVergiDairesi.Value := '';
  FVergiNo.Value := '';
  FIlce.Value := '';
  FMahalle.Value := '';
  FCadde.Value := '';
  FSokak.Value := '';
  FBina.Value := '';
  FKapiNo.Value := '';
  FPostaKodu.Value := '';
  FPostaKutusu.Value := '';
  FTelefon1.Value := '';
  FTelefon2.Value := '';
  FTelefon3.Value := '';
  FFaks.Value := '';
  FYetkiliKisi1.Value := '';
  FYetkiliKisi2.Value := '';
  FWebSitesi.Value := '';
  FePostaAdresi.Value := '';
  FMuhasebeTelefon.Value := '';
  FMuhasebeEPosta.Value := '';
  FNaceKodu.Value := '';
  FParaBirimi.Value := '';
  FOzelBilgi.Value := '';
  FOdemeVadeGunSayisi.Value := 0;
  FBolgeID.Value := 0;
  FBolge.Value := '';
  FIsEFaturaHesabi.Value := 0;
  FIsAcikHesap.Value := 0;
  FKrediLimiti.Value := 0;
  FKategoriID.Value := 0;
  FKategori.Value := '';
  FTemsilciGrubuId.Value := 0;
  FTemsilciGrubu.Value := '';
  FMusteriTemsilcisiID.Value := 0;
  FMusteriTemsilcisi.Value := '';
  FIbanNo.Value := '';
  FIbanParaBirimi.Value := '';
  FMuhasebePlanKodu.Value := '';
end;

function THesapKarti.Clone():TTable;
begin
  Result := THesapKarti.Create(Database);

  Self.Id.Clone(THesapKarti(Result).Id);

  FHesapKodu.Clone(THesapKarti(Result).FHesapKodu);
  FHesapIsmi.Clone(THesapKarti(Result).FHesapIsmi);
  FHesapGrubuID.Clone(THesapKarti(Result).FHesapGrubuID);
  FHesapGrubu.Clone(THesapKarti(Result).FHesapGrubu);
  FMukellefTipiID.Clone(THesapKarti(Result).FMukellefTipiID);
  FMukellefTipi.Clone(THesapKarti(Result).FMukellefTipi);
  FMukellefAdi.Clone(THesapKarti(Result).FMukellefAdi);
  FMukellefIkinciAdi.Clone(THesapKarti(Result).FMukellefIkinciAdi);
  FMukellefSoyadi.Clone(THesapKarti(Result).FMukellefSoyadi);
  FUlkeID.Clone(THesapKarti(Result).FUlkeID);
  FUlke.Clone(THesapKarti(Result).FUlke);
  FSehirID.Clone(THesapKarti(Result).FSehirID);
  FSehir.Clone(THesapKarti(Result).FSehir);
  FVergiDairesi.Clone(THesapKarti(Result).FVergiDairesi);
  FVergiNo.Clone(THesapKarti(Result).FVergiNo);
  FIlce.Clone(THesapKarti(Result).FIlce);
  FMahalle.Clone(THesapKarti(Result).FMahalle);
  FCadde.Clone(THesapKarti(Result).FCadde);
  FSokak.Clone(THesapKarti(Result).FSokak);
  FBina.Clone(THesapKarti(Result).FBina);
  FKapiNo.Clone(THesapKarti(Result).FKapiNo);
  FPostaKodu.Clone(THesapKarti(Result).FPostaKodu);
  FPostaKutusu.Clone(THesapKarti(Result).FPostaKutusu);
  FTelefon1.Clone(THesapKarti(Result).FTelefon1);
  FTelefon2.Clone(THesapKarti(Result).FTelefon2);
  FTelefon3.Clone(THesapKarti(Result).FTelefon3);
  FFaks.Clone(THesapKarti(Result).FFaks);
  FYetkiliKisi1.Clone(THesapKarti(Result).FYetkiliKisi1);
  FYetkiliKisi2.Clone(THesapKarti(Result).FYetkiliKisi2);
  FWebSitesi.Clone(THesapKarti(Result).FWebSitesi);
  FePostaAdresi.Clone(THesapKarti(Result).FePostaAdresi);
  FMuhasebeTelefon.Clone(THesapKarti(Result).FMuhasebeTelefon);
  FMuhasebeEPosta.Clone(THesapKarti(Result).FMuhasebeEPosta);
  FNaceKodu.Clone(THesapKarti(Result).FNaceKodu);
  FParaBirimi.Clone(THesapKarti(Result).FParaBirimi);
  FOzelBilgi.Clone(THesapKarti(Result).FOzelBilgi);
  FOdemeVadeGunSayisi.Clone(THesapKarti(Result).FOdemeVadeGunSayisi);
  FBolgeID.Clone(THesapKarti(Result).FBolgeID);
  FBolge.Clone(THesapKarti(Result).FBolge);
  FIsEFaturaHesabi.Clone(THesapKarti(Result).FIsEFaturaHesabi);
  FIsAcikHesap.Clone(THesapKarti(Result).FIsAcikHesap);
  FKrediLimiti.Clone(THesapKarti(Result).FKrediLimiti);
  FKategoriID.Clone(THesapKarti(Result).FKategoriID);
  FKategori.Clone(THesapKarti(Result).FKategori);
  FTemsilciGrubuId.Clone(THesapKarti(Result).FTemsilciGrubuId);
  FTemsilciGrubu.Clone(THesapKarti(Result).FTemsilciGrubu);
  FMusteriTemsilcisiID.Clone(THesapKarti(Result).FMusteriTemsilcisiID);
  FMusteriTemsilcisi.Clone(THesapKarti(Result).FMusteriTemsilcisi);
  FIbanNo.Clone(THesapKarti(Result).FIbanNo);
  FIbanParaBirimi.Clone(THesapKarti(Result).FIbanParaBirimi);
  FMuhasebePlanKodu.Clone(THesapKarti(Result).FMuhasebePlanKodu);
end;

end.
