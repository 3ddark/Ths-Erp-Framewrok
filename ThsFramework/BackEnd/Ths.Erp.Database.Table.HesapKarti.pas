unit Ths.Erp.Database.Table.HesapKarti;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field

  , Ths.Erp.Database.Table.HesapGrubu
  , Ths.Erp.Database.Table.AyarHesapTipi
  , Ths.Erp.Database.Table.PersonelKarti
  , Ths.Erp.Database.Table.Bolge
  , Ths.Erp.Database.Table.HesapPlani
  , Ths.Erp.Database.Table.AyarMukellefTipi
  , Ths.Erp.Database.Table.Ulke
  , Ths.Erp.Database.Table.Sehir
  , Ths.Erp.Database.Table.MusteriTemsilciGrubu
  , Ths.Erp.Database.Table.ParaBirimi
  ;

type
  THesapKarti = class(TTable)
  private
    FHesapTipiID: TFieldDB;
    FHesapTipi: TFieldDB;
    FHesapKodu: TFieldDB;
    FHesapIsmi: TFieldDB;
    FHesapGrubuID: TFieldDB;
    FHesapGrubu: TFieldDB;
    FBolgeID: TFieldDB;
    FBolge: TFieldDB;
    FTemsilciGrubuId: TFieldDB;
    FTemsilciGrubu: TFieldDB;
    FMukellefTipiID: TFieldDB;
    FMukellefTipi: TFieldDB;
    FMukellefAdi: TFieldDB;
    FMukellefIkinciAdi: TFieldDB;
    FMukellefSoyadi: TFieldDB;
    FVergiDairesi: TFieldDB;
    FVergiNo: TFieldDB;
    FParaBirimi: TFieldDB;
    FIban: TFieldDB;
    FIbanPara: TFieldDB;
    FMusteriTemsilcisiID: TFieldDB;
    FMusteriTemsilcisi: TFieldDB;
    FNaceKodu: TFieldDB;
    FIsEFaturaHesabi: TFieldDB;
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
    FPostaKutusu: TFieldDB;
    FPostaKodu: TFieldDB;
    FYetkili1: TFieldDB;
    FYetkili1Tel: TFieldDB;
    FYetkili2: TFieldDB;
    FYetkili2Tel: TFieldDB;
    FTelefon1: TFieldDB;
    FTelefon2: TFieldDB;
    FTelefon3: TFieldDB;
    FFaks: TFieldDB;
    FMuhasebeTelefon: TFieldDB;
    FMuhasebeEPosta: TFieldDB;
    FMuhasebeYetkili: TFieldDB;
    FWebSitesi: TFieldDB;
    FePostaAdresi: TFieldDB;
    FOzelBilgi: TFieldDB;
    FOdemeVadeGunSayisi: TFieldDB;
    FIsAcikHesap: TFieldDB;
    FKrediLimiti: TFieldDB;
    FHesapIskonto: TFieldDB;
  protected
    vAyarHesapTipi: TAyarHesapTipi;
    vHesapGrubu: THesapGrubu;
    vBolge: TBolge;
    vMusteriTemsilciGrubu: TMusteriTemsilciGrubu;
    vMukellefTipi: TAyarMukellefTipi;
    vMusteriTemsilcisi: TPersonelKarti;
    vUlke: TUlke;
    vSehir: TSehir;
    vHesapPlani: THesapPlani;
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property HesapTipiID: TFieldDB read FHesapTipiID write FHesapTipiID;
    Property HesapTipi: TFieldDB read FHesapTipi write FHesapTipi;
    Property HesapKodu: TFieldDB read FHesapKodu write FHesapKodu;
    Property HesapIsmi: TFieldDB read FHesapIsmi write FHesapIsmi;
    Property HesapGrubuID: TFieldDB read FHesapGrubuID write FHesapGrubuID;
    Property HesapGrubu: TFieldDB read FHesapGrubu write FHesapGrubu;
    Property BolgeID: TFieldDB read FBolgeID write FBolgeID;
    Property Bolge: TFieldDB read FBolge write FBolge;
    Property TemsilciGrubuId: TFieldDB read FTemsilciGrubuId write FTemsilciGrubuId;
    Property TemsilciGrubu: TFieldDB read FTemsilciGrubu write FTemsilciGrubu;
    Property MukellefTipiID: TFieldDB read FMukellefTipiID write FMukellefTipiID;
    Property MukellefTipi: TFieldDB read FMukellefTipi write FMukellefTipi;
    Property MukellefAdi: TFieldDB read FMukellefAdi write FMukellefAdi;
    Property MukellefIkinciAdi: TFieldDB read FMukellefIkinciAdi write FMukellefIkinciAdi;
    Property MukellefSoyadi: TFieldDB read FMukellefSoyadi write FMukellefSoyadi;
    Property VergiDairesi: TFieldDB read FVergiDairesi write FVergiDairesi;
    Property VergiNo: TFieldDB read FVergiNo write FVergiNo;
    Property ParaBirimi: TFieldDB read FParaBirimi write FParaBirimi;
    Property Iban: TFieldDB read FIban write FIban;
    Property IbanPara: TFieldDB read FIbanPara write FIbanPara;
    Property MusteriTemsilcisiID: TFieldDB read FMusteriTemsilcisiID write FMusteriTemsilcisiID;
    Property MusteriTemsilcisi: TFieldDB read FMusteriTemsilcisi write FMusteriTemsilcisi;
    Property NaceKodu: TFieldDB read FNaceKodu write FNaceKodu;
    Property IsEFaturaHesabi: TFieldDB read FIsEFaturaHesabi write FIsEFaturaHesabi;
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
    Property PostaKutusu: TFieldDB read FPostaKutusu write FPostaKutusu;
    Property PostaKodu: TFieldDB read FPostaKodu write FPostaKodu;
    Property Yetkili1: TFieldDB read FYetkili1 write FYetkili1;
    Property Yetkili1Tel: TFieldDB read FYetkili1Tel write FYetkili1Tel;
    Property Yetkili2: TFieldDB read FYetkili2 write FYetkili2;
    Property Yetkili2Tel: TFieldDB read FYetkili2Tel write FYetkili2Tel;
    Property Telefon1: TFieldDB read FTelefon1 write FTelefon1;
    Property Telefon2: TFieldDB read FTelefon2 write FTelefon2;
    Property Telefon3: TFieldDB read FTelefon3 write FTelefon3;
    Property Faks: TFieldDB read FFaks write FFaks;
    Property MuhasebeTelefon: TFieldDB read FMuhasebeTelefon write FMuhasebeTelefon;
    Property MuhasebeEPosta: TFieldDB read FMuhasebeEPosta write FMuhasebeEPosta;
    Property MuhasebeYetkili: TFieldDB read FMuhasebeYetkili write FMuhasebeYetkili;
    Property WebSitesi: TFieldDB read FWebSitesi write FWebSitesi;
    Property ePostaAdresi: TFieldDB read FePostaAdresi write FePostaAdresi;
    Property OzelBilgi: TFieldDB read FOzelBilgi write FOzelBilgi;
    Property OdemeVadeGunSayisi: TFieldDB read FOdemeVadeGunSayisi write FOdemeVadeGunSayisi;
    Property IsAcikHesap: TFieldDB read FIsAcikHesap write FIsAcikHesap;
    Property KrediLimiti: TFieldDB read FKrediLimiti write FKrediLimiti;
    Property HesapIskonto: TFieldDB read FHesapIskonto write FHesapIskonto;
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

  FHesapTipiID := TFieldDB.Create('hesap_tipi_id', ftInteger, 0);
  FHesapTipi := TFieldDB.Create('hesap_tipi', ftString, '');
  FHesapKodu := TFieldDB.Create('hesap_kodu', ftString, '');
  FHesapIsmi := TFieldDB.Create('hesap_ismi', ftString, '');
  FHesapGrubuID := TFieldDB.Create('hesap_grubu_id', ftInteger, 0);
  FHesapGrubu := TFieldDB.Create('hesap_grubu', ftString, '');
  FBolgeID := TFieldDB.Create('bolge_id', ftInteger, 0);
  FBolge := TFieldDB.Create('bolge', ftString, '');
  FTemsilciGrubuId := TFieldDB.Create('temsilci_grubu_id', ftInteger, 0);
  FTemsilciGrubu := TFieldDB.Create('temsilci_grubu', ftString, '');
  FMukellefTipiID := TFieldDB.Create('mukellef_tipi_id', ftInteger, 0);
  FMukellefTipi := TFieldDB.Create('mukellef_tipi', ftString, '');
  FMukellefAdi := TFieldDB.Create('mukellef_adi', ftString, '');
  FMukellefIkinciAdi := TFieldDB.Create('mukellef_ikinci_adi', ftString, '');
  FMukellefSoyadi := TFieldDB.Create('mukellef_soyadi', ftString, '');
  FVergiDairesi := TFieldDB.Create('vergi_dairesi', ftString, '');
  FVergiNo := TFieldDB.Create('vergi_no', ftString, '');
  FParaBirimi := TFieldDB.Create('para_birimi', ftString, '');
  FIban := TFieldDB.Create('iban', ftString, '');
  FIbanPara := TFieldDB.Create('iban_para', ftString, '');
  FMusteriTemsilcisiID := TFieldDB.Create('musteri_temsilcisi_id', ftInteger, 0);
  FMusteriTemsilcisi := TFieldDB.Create('musteri_temsilcisi', ftString, '');
  FNaceKodu := TFieldDB.Create('nace_kodu', ftString, '');
  FIsEFaturaHesabi := TFieldDB.Create('is_efatura_hesabi', ftBoolean, False);
  FUlkeID := TFieldDB.Create('ulke_id', ftInteger, 0);
  FUlke := TFieldDB.Create('ulke', ftString, '');
  FSehirID := TFieldDB.Create('sehir_id', ftInteger, 0);
  FSehir := TFieldDB.Create('sehir', ftString, '');
  FIlce := TFieldDB.Create('ilce', ftString, '');
  FMahalle := TFieldDB.Create('mahalle', ftString, '');
  FCadde := TFieldDB.Create('cadde', ftString, '');
  FSokak := TFieldDB.Create('sokak', ftString, '');
  FBina := TFieldDB.Create('bina', ftString, '');
  FKapiNo := TFieldDB.Create('kapi_no', ftString, '');
  FPostaKutusu := TFieldDB.Create('posta_kutusu', ftString, '');
  FPostaKodu := TFieldDB.Create('posta_kodu', ftString, '');
  FYetkili1 := TFieldDB.Create('yetkili1', ftString, '');
  FYetkili1Tel := TFieldDB.Create('yetkili1_tel', ftString, '');
  FYetkili2 := TFieldDB.Create('yetkili2', ftString, '');
  FYetkili2Tel := TFieldDB.Create('yetkili2_tel', ftString, '');
  FTelefon1 := TFieldDB.Create('telefon1', ftString, '');
  FTelefon2 := TFieldDB.Create('telefon2', ftString, '');
  FTelefon3 := TFieldDB.Create('telefon3', ftString, '');
  FFaks := TFieldDB.Create('faks', ftString, '');
  FMuhasebeTelefon := TFieldDB.Create('muhasebe_telefon', ftString, '');
  FMuhasebeEPosta := TFieldDB.Create('muhasebe_eposta', ftString, '');
  FMuhasebeYetkili := TFieldDB.Create('muhasebe_yetkili', ftString, '');
  FWebSitesi := TFieldDB.Create('web_sitesi', ftString, '');
  FePostaAdresi := TFieldDB.Create('eposta_adresi', ftString, '');
  FOzelBilgi := TFieldDB.Create('ozel_bilgi', ftString, '');
  FOdemeVadeGunSayisi := TFieldDB.Create('odeme_vade_gun_sayisi', ftInteger, 0);
  FIsAcikHesap := TFieldDB.Create('is_acik_hesap', ftBoolean, False);
  FKrediLimiti := TFieldDB.Create('kredi_limiti', ftFloat, 0);
  FHesapIskonto := TFieldDB.Create('hesap_iskonto', ftFloat, 0);
end;

procedure THesapKarti.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      vAyarHesapTipi := TAyarHesapTipi.Create(Database);
      vHesapGrubu := THesapGrubu.Create(Database);
      vBolge := TBolge.Create(Database);
      vMusteriTemsilciGrubu := TMusteriTemsilciGrubu.Create(Database);
      vMukellefTipi := TAyarMukellefTipi.Create(Database);
      vMusteriTemsilcisi := TPersonelKarti.Create(Database);
      vUlke := TUlke.Create(Database);
      vSehir := TSehir.Create(Database);
      try
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FHesapTipiID.FieldName,
          ColumnFromIDCol(vAyarHesapTipi.Deger.FieldName, vAyarHesapTipi.TableName, FHesapTipiID.FieldName, FHesapTipi.FieldName, TableName),
          TableName + '.' + FHesapKodu.FieldName,
          TableName + '.' + FHesapIsmi.FieldName,
          TableName + '.' + FHesapGrubuID.FieldName,
          ColumnFromIDCol(vHesapGrubu.Grup.FieldName, vHesapGrubu.TableName, FHesapGrubuID.FieldName, FHesapGrubu.FieldName, TableName),
          TableName + '.' + FBolgeID.FieldName,
          ColumnFromIDCol(vBolge.BolgeAdi.FieldName, vBolge.TableName, FBolgeID.FieldName, FBolge.FieldName, TableName),
          TableName + '.' + FTemsilciGrubuId.FieldName,
          ColumnFromIDCol(vMusteriTemsilciGrubu.TemsilciGrupAdi.FieldName, vMusteriTemsilciGrubu.TableName, FTemsilciGrubuId.FieldName, FTemsilciGrubu.FieldName, TableName),
          TableName + '.' + FMukellefTipiID.FieldName,
          ColumnFromIDCol(vMukellefTipi.Deger.FieldName, vMukellefTipi.TableName, FMukellefTipiID.FieldName, FMukellefTipi.FieldName, TableName),
          TableName + '.' + FMukellefAdi.FieldName,
          TableName + '.' + FMukellefIkinciAdi.FieldName,
          TableName + '.' + FMukellefSoyadi.FieldName,
          TableName + '.' + FVergiDairesi.FieldName,
          TableName + '.' + FVergiNo.FieldName,
          TableName + '.' + FParaBirimi.FieldName,
          TableName + '.' + FIban.FieldName,
          TableName + '.' + FIbanPara.FieldName,
          TableName + '.' + FMusteriTemsilcisiID.FieldName,
          TableName + '.' + FNaceKodu.FieldName,
          TableName + '.' + FIsEFaturaHesabi.FieldName,
          TableName + '.' + FUlkeID.FieldName,
          ColumnFromIDCol(vUlke.UlkeAdi.FieldName, vUlke.TableName, FUlkeID.FieldName, FUlke.FieldName, TableName),
          TableName + '.' + FSehirID.FieldName,
          ColumnFromIDCol(vSehir.SehirAdi.FieldName, vSehir.TableName, FSehirID.FieldName, FSehir.FieldName, TableName),
          TableName + '.' + FIlce.FieldName,
          TableName + '.' + FMahalle.FieldName,
          TableName + '.' + FCadde.FieldName,
          TableName + '.' + FSokak.FieldName,
          TableName + '.' + FBina.FieldName,
          TableName + '.' + FKapiNo.FieldName,
          TableName + '.' + FPostaKutusu.FieldName,
          TableName + '.' + FPostaKodu.FieldName,
          TableName + '.' + FYetkili1.FieldName,
          TableName + '.' + FYetkili1Tel.FieldName,
          TableName + '.' + FYetkili2.FieldName,
          TableName + '.' + FYetkili2Tel.FieldName,
          TableName + '.' + FTelefon1.FieldName,
          TableName + '.' + FTelefon2.FieldName,
          TableName + '.' + FTelefon3.FieldName,
          TableName + '.' + FFaks.FieldName,
          TableName + '.' + FMuhasebeTelefon.FieldName,
          TableName + '.' + FMuhasebeEPosta.FieldName,
          TableName + '.' + FMuhasebeYetkili.FieldName,
          TableName + '.' + FWebSitesi.FieldName,
          TableName + '.' + FePostaAdresi.FieldName,
          TableName + '.' + FOzelBilgi.FieldName,
          TableName + '.' + FOdemeVadeGunSayisi.FieldName,
          TableName + '.' + FIsAcikHesap.FieldName,
          TableName + '.' + FKrediLimiti.FieldName,
          TableName + '.' + FHesapIskonto.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;
        Active := True;

        Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
        Self.DataSource.DataSet.FindField(FHesapTipiID.FieldName).DisplayLabel := 'Hesap Tipi ID';
        Self.DataSource.DataSet.FindField(FHesapTipi.FieldName).DisplayLabel := 'Hesap Tipi';
        Self.DataSource.DataSet.FindField(FHesapKodu.FieldName).DisplayLabel := 'Hesap Kodu';
        Self.DataSource.DataSet.FindField(FHesapIsmi.FieldName).DisplayLabel := 'Hesap Ýsmi';
        Self.DataSource.DataSet.FindField(FHesapGrubuID.FieldName).DisplayLabel := 'Hesap Grubu ID';
        Self.DataSource.DataSet.FindField(FHesapGrubu.FieldName).DisplayLabel := 'Hesap Grubu';
        Self.DataSource.DataSet.FindField(FBolgeID.FieldName).DisplayLabel := 'Bölge ID';
        Self.DataSource.DataSet.FindField(FBolge.FieldName).DisplayLabel := 'Bölge';
        Self.DataSource.DataSet.FindField(FTemsilciGrubuId.FieldName).DisplayLabel := 'Temsilci Grubu ID';
        Self.DataSource.DataSet.FindField(FTemsilciGrubu.FieldName).DisplayLabel := 'Temsilci Grubu';
        Self.DataSource.DataSet.FindField(FMukellefTipiID.FieldName).DisplayLabel := 'Mukellef Tipi ID';
        Self.DataSource.DataSet.FindField(FMukellefTipi.FieldName).DisplayLabel := 'Mükellef Tipi';
        Self.DataSource.DataSet.FindField(FMukellefAdi.FieldName).DisplayLabel := 'Mükellef Adý';
        Self.DataSource.DataSet.FindField(FMukellefIkinciAdi.FieldName).DisplayLabel := 'Mükellef Ýkinci Adý';
        Self.DataSource.DataSet.FindField(FMukellefSoyadi.FieldName).DisplayLabel := 'Mükellef Soyadý';
        Self.DataSource.DataSet.FindField(FVergiDairesi.FieldName).DisplayLabel := 'Vergi Dairesi';
        Self.DataSource.DataSet.FindField(FVergiNo.FieldName).DisplayLabel := 'Vergi No';
        Self.DataSource.DataSet.FindField(FParaBirimi.FieldName).DisplayLabel := 'Para Birimi';
        Self.DataSource.DataSet.FindField(FIban.FieldName).DisplayLabel := 'IBAN Numarasý';
        Self.DataSource.DataSet.FindField(FIbanPara.FieldName).DisplayLabel := 'IBAN Para Birimi';
        Self.DataSource.DataSet.FindField(FMusteriTemsilcisiID.FieldName).DisplayLabel := 'Müþteri Temsilcisi ID';
        Self.DataSource.DataSet.FindField(FMusteriTemsilcisi.FieldName).DisplayLabel := 'Müþteri Temsilcisi';
        Self.DataSource.DataSet.FindField(FNaceKodu.FieldName).DisplayLabel := 'Nace Kodu';
        Self.DataSource.DataSet.FindField(FIsEFaturaHesabi.FieldName).DisplayLabel := 'E-Fatura Hesabý?';
        Self.DataSource.DataSet.FindField(FUlkeID.FieldName).DisplayLabel := 'Ulke ID';
        Self.DataSource.DataSet.FindField(FUlke.FieldName).DisplayLabel := 'Ülke';
        Self.DataSource.DataSet.FindField(FSehirID.FieldName).DisplayLabel := 'Þehir ID';
        Self.DataSource.DataSet.FindField(FSehir.FieldName).DisplayLabel := 'Þehir';
        Self.DataSource.DataSet.FindField(FIlce.FieldName).DisplayLabel := 'Ýlçe';
        Self.DataSource.DataSet.FindField(FMahalle.FieldName).DisplayLabel := 'Mahalle';
        Self.DataSource.DataSet.FindField(FCadde.FieldName).DisplayLabel := 'Cadde';
        Self.DataSource.DataSet.FindField(FSokak.FieldName).DisplayLabel := 'Sokak';
        Self.DataSource.DataSet.FindField(FBina.FieldName).DisplayLabel := 'Bina';
        Self.DataSource.DataSet.FindField(FKapiNo.FieldName).DisplayLabel := 'Kapý No';
        Self.DataSource.DataSet.FindField(FPostaKutusu.FieldName).DisplayLabel := 'Posta Kutusu';
        Self.DataSource.DataSet.FindField(FPostaKodu.FieldName).DisplayLabel := 'Posta Kodu';
        Self.DataSource.DataSet.FindField(FYetkili1.FieldName).DisplayLabel := 'Yetkili 1';
        Self.DataSource.DataSet.FindField(FYetkili1Tel.FieldName).DisplayLabel := 'Yetkili 1 Telefon';
        Self.DataSource.DataSet.FindField(FYetkili2.FieldName).DisplayLabel := 'Yetkili 2';
        Self.DataSource.DataSet.FindField(FYetkili2Tel.FieldName).DisplayLabel := 'Yetkili 2 Telefon';
        Self.DataSource.DataSet.FindField(FTelefon1.FieldName).DisplayLabel := 'Telefon 1';
        Self.DataSource.DataSet.FindField(FTelefon2.FieldName).DisplayLabel := 'Telefon 2';
        Self.DataSource.DataSet.FindField(FTelefon3.FieldName).DisplayLabel := 'Telefon 3';
        Self.DataSource.DataSet.FindField(FFaks.FieldName).DisplayLabel := 'Faks';
        Self.DataSource.DataSet.FindField(FMuhasebeTelefon.FieldName).DisplayLabel := 'Muhasebe Telefon';
        Self.DataSource.DataSet.FindField(FMuhasebeEPosta.FieldName).DisplayLabel := 'Muhasebe E-Posta';
        Self.DataSource.DataSet.FindField(FMuhasebeYetkili.FieldName).DisplayLabel := 'Muhasebe Yetkili';
        Self.DataSource.DataSet.FindField(FWebSitesi.FieldName).DisplayLabel := 'Web Sitesi';
        Self.DataSource.DataSet.FindField(FePostaAdresi.FieldName).DisplayLabel := 'E-Posta Adresi';
        Self.DataSource.DataSet.FindField(FOzelBilgi.FieldName).DisplayLabel := 'Özel Bilgi';
        Self.DataSource.DataSet.FindField(FOdemeVadeGunSayisi.FieldName).DisplayLabel := 'Ödeme Vade Gün Sayýsý';
        Self.DataSource.DataSet.FindField(FIsAcikHesap.FieldName).DisplayLabel := 'Açýk Hesap?';
        Self.DataSource.DataSet.FindField(FKrediLimiti.FieldName).DisplayLabel := 'Kredi Limiti';
        Self.DataSource.DataSet.FindField(FHesapIskonto.FieldName).DisplayLabel := 'Hesap Ýskonto';
      finally
        vAyarHesapTipi.Free;
        vHesapGrubu.Free;
        vBolge.Free;
        vMusteriTemsilciGrubu.Free;
        vMukellefTipi.Free;
        vMusteriTemsilcisi.Free;
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
      vAyarHesapTipi := TAyarHesapTipi.Create(Database);
      vHesapGrubu := THesapGrubu.Create(Database);
      vBolge := TBolge.Create(Database);
      vMusteriTemsilciGrubu := TMusteriTemsilciGrubu.Create(Database);
      vMukellefTipi := TAyarMukellefTipi.Create(Database);
      vMusteriTemsilcisi := TPersonelKarti.Create(Database);
      vUlke := TUlke.Create(Database);
      vSehir := TSehir.Create(Database);
      try
        Close;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FHesapTipiID.FieldName,
          ColumnFromIDCol(vAyarHesapTipi.Deger.FieldName, vAyarHesapTipi.TableName, FHesapTipiID.FieldName, FHesapTipi.FieldName, TableName),
          TableName + '.' + FHesapKodu.FieldName,
          TableName + '.' + FHesapIsmi.FieldName,
          TableName + '.' + FHesapGrubuID.FieldName,
          ColumnFromIDCol(vHesapGrubu.Grup.FieldName, vHesapGrubu.TableName, FHesapGrubuID.FieldName, FHesapGrubu.FieldName, TableName),
          TableName + '.' + FBolgeID.FieldName,
          ColumnFromIDCol(vBolge.BolgeAdi.FieldName, vBolge.TableName, FBolgeID.FieldName, FBolge.FieldName, TableName),
          TableName + '.' + FTemsilciGrubuId.FieldName,
          ColumnFromIDCol(vMusteriTemsilciGrubu.TemsilciGrupAdi.FieldName, vMusteriTemsilciGrubu.TableName, FTemsilciGrubuId.FieldName, FTemsilciGrubu.FieldName, TableName),
          TableName + '.' + FMukellefTipiID.FieldName,
          ColumnFromIDCol(vMukellefTipi.Deger.FieldName, vMukellefTipi.TableName, FMukellefTipiID.FieldName, FMukellefTipi.FieldName, TableName),
          TableName + '.' + FMukellefAdi.FieldName,
          TableName + '.' + FMukellefIkinciAdi.FieldName,
          TableName + '.' + FMukellefSoyadi.FieldName,
          TableName + '.' + FVergiDairesi.FieldName,
          TableName + '.' + FVergiNo.FieldName,
          TableName + '.' + FParaBirimi.FieldName,
          TableName + '.' + FIban.FieldName,
          TableName + '.' + FIbanPara.FieldName,
          TableName + '.' + FMusteriTemsilcisiID.FieldName,
          TableName + '.' + FNaceKodu.FieldName,
          TableName + '.' + FIsEFaturaHesabi.FieldName,
          TableName + '.' + FUlkeID.FieldName,
          ColumnFromIDCol(vUlke.UlkeAdi.FieldName, vUlke.TableName, FUlkeID.FieldName, FUlke.FieldName, TableName),
          TableName + '.' + FSehirID.FieldName,
          ColumnFromIDCol(vSehir.SehirAdi.FieldName, vSehir.TableName, FSehirID.FieldName, FSehir.FieldName, TableName),
          TableName + '.' + FIlce.FieldName,
          TableName + '.' + FMahalle.FieldName,
          TableName + '.' + FCadde.FieldName,
          TableName + '.' + FSokak.FieldName,
          TableName + '.' + FBina.FieldName,
          TableName + '.' + FKapiNo.FieldName,
          TableName + '.' + FPostaKutusu.FieldName,
          TableName + '.' + FPostaKodu.FieldName,
          TableName + '.' + FYetkili1.FieldName,
          TableName + '.' + FYetkili1Tel.FieldName,
          TableName + '.' + FYetkili2.FieldName,
          TableName + '.' + FYetkili2Tel.FieldName,
          TableName + '.' + FTelefon1.FieldName,
          TableName + '.' + FTelefon2.FieldName,
          TableName + '.' + FTelefon3.FieldName,
          TableName + '.' + FFaks.FieldName,
          TableName + '.' + FMuhasebeTelefon.FieldName,
          TableName + '.' + FMuhasebeEPosta.FieldName,
          TableName + '.' + FMuhasebeYetkili.FieldName,
          TableName + '.' + FWebSitesi.FieldName,
          TableName + '.' + FePostaAdresi.FieldName,
          TableName + '.' + FOzelBilgi.FieldName,
          TableName + '.' + FOdemeVadeGunSayisi.FieldName,
          TableName + '.' + FIsAcikHesap.FieldName,
          TableName + '.' + FKrediLimiti.FieldName,
          TableName + '.' + FHesapIskonto.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;

        FreeListContent();
        List.Clear;
        while NOT EOF do
        begin
          Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

          FHesapTipiID.Value := FormatedVariantVal(FieldByName(FHesapTipiID.FieldName).DataType, FieldByName(FHesapTipiID.FieldName).Value);
          FHesapTipi.Value := FormatedVariantVal(FieldByName(FHesapTipi.FieldName).DataType, FieldByName(FHesapTipi.FieldName).Value);
          FHesapKodu.Value := FormatedVariantVal(FieldByName(FHesapKodu.FieldName).DataType, FieldByName(FHesapKodu.FieldName).Value);
          FHesapIsmi.Value := FormatedVariantVal(FieldByName(FHesapIsmi.FieldName).DataType, FieldByName(FHesapIsmi.FieldName).Value);
          FHesapGrubuID.Value := FormatedVariantVal(FieldByName(FHesapGrubuID.FieldName).DataType, FieldByName(FHesapGrubuID.FieldName).Value);
          FHesapGrubu.Value := FormatedVariantVal(FieldByName(FHesapGrubu.FieldName).DataType, FieldByName(FHesapGrubu.FieldName).Value);
          FBolgeID.Value := FormatedVariantVal(FieldByName(FBolgeID.FieldName).DataType, FieldByName(FBolgeID.FieldName).Value);
          FBolge.Value := FormatedVariantVal(FieldByName(FBolge.FieldName).DataType, FieldByName(FBolge.FieldName).Value);
          FTemsilciGrubuId.Value := FormatedVariantVal(FieldByName(FTemsilciGrubuId.FieldName).DataType, FieldByName(FTemsilciGrubuId.FieldName).Value);
          FTemsilciGrubu.Value := FormatedVariantVal(FieldByName(FTemsilciGrubu.FieldName).DataType, FieldByName(FTemsilciGrubu.FieldName).Value);
          FMukellefTipiID.Value := FormatedVariantVal(FieldByName(FMukellefTipiID.FieldName).DataType, FieldByName(FMukellefTipiID.FieldName).Value);
          FMukellefTipi.Value := FormatedVariantVal(FieldByName(FMukellefTipi.FieldName).DataType, FieldByName(FMukellefTipi.FieldName).Value);
          FMukellefAdi.Value := FormatedVariantVal(FieldByName(FMukellefAdi.FieldName).DataType, FieldByName(FMukellefAdi.FieldName).Value);
          FMukellefIkinciAdi.Value := FormatedVariantVal(FieldByName(FMukellefIkinciAdi.FieldName).DataType, FieldByName(FMukellefIkinciAdi.FieldName).Value);
          FMukellefSoyadi.Value := FormatedVariantVal(FieldByName(FMukellefSoyadi.FieldName).DataType, FieldByName(FMukellefSoyadi.FieldName).Value);
          FVergiDairesi.Value := FormatedVariantVal(FieldByName(FVergiDairesi.FieldName).DataType, FieldByName(FVergiDairesi.FieldName).Value);
          FVergiNo.Value := FormatedVariantVal(FieldByName(FVergiNo.FieldName).DataType, FieldByName(FVergiNo.FieldName).Value);
          FParaBirimi.Value := FormatedVariantVal(FieldByName(FParaBirimi.FieldName).DataType, FieldByName(FParaBirimi.FieldName).Value);
          FIban.Value := FormatedVariantVal(FieldByName(FIban.FieldName).DataType, FieldByName(FIban.FieldName).Value);
          FIbanPara.Value := FormatedVariantVal(FieldByName(FIbanPara.FieldName).DataType, FieldByName(FIbanPara.FieldName).Value);
          FMusteriTemsilcisiID.Value := FormatedVariantVal(FieldByName(FMusteriTemsilcisiID.FieldName).DataType, FieldByName(FMusteriTemsilcisiID.FieldName).Value);
          FMusteriTemsilcisi.Value := FormatedVariantVal(FieldByName(FMusteriTemsilcisi.FieldName).DataType, FieldByName(FMusteriTemsilcisi.FieldName).Value);
          FNaceKodu.Value := FormatedVariantVal(FieldByName(FNaceKodu.FieldName).DataType, FieldByName(FNaceKodu.FieldName).Value);
          FIsEFaturaHesabi.Value := FormatedVariantVal(FieldByName(FIsEFaturaHesabi.FieldName).DataType, FieldByName(FIsEFaturaHesabi.FieldName).Value);
          FUlkeID.Value := FormatedVariantVal(FieldByName(FUlkeID.FieldName).DataType, FieldByName(FUlkeID.FieldName).Value);
          FUlke.Value := FormatedVariantVal(FieldByName(FUlke.FieldName).DataType, FieldByName(FUlke.FieldName).Value);
          FSehirID.Value := FormatedVariantVal(FieldByName(FSehirID.FieldName).DataType, FieldByName(FSehirID.FieldName).Value);
          FSehir.Value := FormatedVariantVal(FieldByName(FSehir.FieldName).DataType, FieldByName(FSehir.FieldName).Value);
          FIlce.Value := FormatedVariantVal(FieldByName(FIlce.FieldName).DataType, FieldByName(FIlce.FieldName).Value);
          FMahalle.Value := FormatedVariantVal(FieldByName(FMahalle.FieldName).DataType, FieldByName(FMahalle.FieldName).Value);
          FCadde.Value := FormatedVariantVal(FieldByName(FCadde.FieldName).DataType, FieldByName(FCadde.FieldName).Value);
          FSokak.Value := FormatedVariantVal(FieldByName(FSokak.FieldName).DataType, FieldByName(FSokak.FieldName).Value);
          FBina.Value := FormatedVariantVal(FieldByName(FBina.FieldName).DataType, FieldByName(FBina.FieldName).Value);
          FKapiNo.Value := FormatedVariantVal(FieldByName(FKapiNo.FieldName).DataType, FieldByName(FKapiNo.FieldName).Value);
          FPostaKutusu.Value := FormatedVariantVal(FieldByName(FPostaKutusu.FieldName).DataType, FieldByName(FPostaKutusu.FieldName).Value);
          FPostaKodu.Value := FormatedVariantVal(FieldByName(FPostaKodu.FieldName).DataType, FieldByName(FPostaKodu.FieldName).Value);
          FYetkili1.Value := FormatedVariantVal(FieldByName(FYetkili1.FieldName).DataType, FieldByName(FYetkili1.FieldName).Value);
          FYetkili1Tel.Value := FormatedVariantVal(FieldByName(FYetkili1Tel.FieldName).DataType, FieldByName(FYetkili1Tel.FieldName).Value);
          FYetkili2.Value := FormatedVariantVal(FieldByName(FYetkili2.FieldName).DataType, FieldByName(FYetkili2.FieldName).Value);
          FYetkili2Tel.Value := FormatedVariantVal(FieldByName(FYetkili2Tel.FieldName).DataType, FieldByName(FYetkili2Tel.FieldName).Value);
          FTelefon1.Value := FormatedVariantVal(FieldByName(FTelefon1.FieldName).DataType, FieldByName(FTelefon1.FieldName).Value);
          FTelefon2.Value := FormatedVariantVal(FieldByName(FTelefon2.FieldName).DataType, FieldByName(FTelefon2.FieldName).Value);
          FTelefon3.Value := FormatedVariantVal(FieldByName(FTelefon3.FieldName).DataType, FieldByName(FTelefon3.FieldName).Value);
          FFaks.Value := FormatedVariantVal(FieldByName(FFaks.FieldName).DataType, FieldByName(FFaks.FieldName).Value);
          FMuhasebeTelefon.Value := FormatedVariantVal(FieldByName(FMuhasebeTelefon.FieldName).DataType, FieldByName(FMuhasebeTelefon.FieldName).Value);
          FMuhasebeEPosta.Value := FormatedVariantVal(FieldByName(FMuhasebeEPosta.FieldName).DataType, FieldByName(FMuhasebeEPosta.FieldName).Value);
          FMuhasebeYetkili.Value := FormatedVariantVal(FieldByName(FMuhasebeYetkili.FieldName).DataType, FieldByName(FMuhasebeYetkili.FieldName).Value);
          FWebSitesi.Value := FormatedVariantVal(FieldByName(FWebSitesi.FieldName).DataType, FieldByName(FWebSitesi.FieldName).Value);
          FePostaAdresi.Value := FormatedVariantVal(FieldByName(FePostaAdresi.FieldName).DataType, FieldByName(FePostaAdresi.FieldName).Value);
          FOzelBilgi.Value := FormatedVariantVal(FieldByName(FOzelBilgi.FieldName).DataType, FieldByName(FOzelBilgi.FieldName).Value);
          FOdemeVadeGunSayisi.Value := FormatedVariantVal(FieldByName(FOdemeVadeGunSayisi.FieldName).DataType, FieldByName(FOdemeVadeGunSayisi.FieldName).Value);
          FIsAcikHesap.Value := FormatedVariantVal(FieldByName(FIsAcikHesap.FieldName).DataType, FieldByName(FIsAcikHesap.FieldName).Value);
          FKrediLimiti.Value := FormatedVariantVal(FieldByName(FKrediLimiti.FieldName).DataType, FieldByName(FKrediLimiti.FieldName).Value);
          FHesapIskonto.Value := FormatedVariantVal(FieldByName(FHesapIskonto.FieldName).DataType, FieldByName(FHesapIskonto.FieldName).Value);

          List.Add(Self.Clone());

          Next;
        end;
        Close;
      finally
        vAyarHesapTipi.Free;
        vHesapGrubu.Free;
        vBolge.Free;
        vMusteriTemsilciGrubu.Free;
        vMukellefTipi.Free;
        vMusteriTemsilcisi.Free;
        vUlke.Free;
        vSehir.Free;
      end;
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
        FHesapTipiID.FieldName,
        FHesapTipi.FieldName,
        FHesapKodu.FieldName,
        FHesapIsmi.FieldName,
        FHesapGrubuID.FieldName,
        FBolgeID.FieldName,
        FTemsilciGrubuId.FieldName,
        FMukellefTipiID.FieldName,
        FMukellefAdi.FieldName,
        FMukellefIkinciAdi.FieldName,
        FMukellefSoyadi.FieldName,
        FVergiDairesi.FieldName,
        FVergiNo.FieldName,
        FParaBirimi.FieldName,
        FIban.FieldName,
        FIbanPara.FieldName,
        FMusteriTemsilcisiID.FieldName,
        FNaceKodu.FieldName,
        FIsEFaturaHesabi.FieldName,
        FUlkeID.FieldName,
        FSehirID.FieldName,
        FIlce.FieldName,
        FMahalle.FieldName,
        FCadde.FieldName,
        FSokak.FieldName,
        FBina.FieldName,
        FKapiNo.FieldName,
        FPostaKutusu.FieldName,
        FPostaKodu.FieldName,
        FYetkili1.FieldName,
        FYetkili1Tel.FieldName,
        FYetkili2.FieldName,
        FYetkili2Tel.FieldName,
        FTelefon1.FieldName,
        FTelefon2.FieldName,
        FTelefon3.FieldName,
        FFaks.FieldName,
        FMuhasebeTelefon.FieldName,
        FMuhasebeEPosta.FieldName,
        FMuhasebeYetkili.FieldName,
        FWebSitesi.FieldName,
        FePostaAdresi.FieldName,
        FOzelBilgi.FieldName,
        FOdemeVadeGunSayisi.FieldName,
        FIsAcikHesap.FieldName,
        FKrediLimiti.FieldName,
        FHesapIskonto.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FHesapTipiID);
      NewParamForQuery(QueryOfInsert, FHesapTipi);
      NewParamForQuery(QueryOfInsert, FHesapKodu);
      NewParamForQuery(QueryOfInsert, FHesapIsmi);
      NewParamForQuery(QueryOfInsert, FHesapGrubuID);
      NewParamForQuery(QueryOfInsert, FBolgeID);
      NewParamForQuery(QueryOfInsert, FTemsilciGrubuId);
      NewParamForQuery(QueryOfInsert, FMukellefTipiID);
      NewParamForQuery(QueryOfInsert, FMukellefAdi);
      NewParamForQuery(QueryOfInsert, FMukellefIkinciAdi);
      NewParamForQuery(QueryOfInsert, FMukellefSoyadi);
      NewParamForQuery(QueryOfInsert, FVergiDairesi);
      NewParamForQuery(QueryOfInsert, FVergiNo);
      NewParamForQuery(QueryOfInsert, FParaBirimi);
      NewParamForQuery(QueryOfInsert, FIban);
      NewParamForQuery(QueryOfInsert, FIbanPara);
      NewParamForQuery(QueryOfInsert, FMusteriTemsilcisiID);
      NewParamForQuery(QueryOfInsert, FNaceKodu);
      NewParamForQuery(QueryOfInsert, FIsEFaturaHesabi);
      NewParamForQuery(QueryOfInsert, FUlkeID);
      NewParamForQuery(QueryOfInsert, FSehirID);
      NewParamForQuery(QueryOfInsert, FIlce);
      NewParamForQuery(QueryOfInsert, FMahalle);
      NewParamForQuery(QueryOfInsert, FCadde);
      NewParamForQuery(QueryOfInsert, FSokak);
      NewParamForQuery(QueryOfInsert, FBina);
      NewParamForQuery(QueryOfInsert, FKapiNo);
      NewParamForQuery(QueryOfInsert, FPostaKutusu);
      NewParamForQuery(QueryOfInsert, FPostaKodu);
      NewParamForQuery(QueryOfInsert, FYetkili1);
      NewParamForQuery(QueryOfInsert, FYetkili1Tel);
      NewParamForQuery(QueryOfInsert, FYetkili2);
      NewParamForQuery(QueryOfInsert, FYetkili2Tel);
      NewParamForQuery(QueryOfInsert, FTelefon1);
      NewParamForQuery(QueryOfInsert, FTelefon2);
      NewParamForQuery(QueryOfInsert, FTelefon3);
      NewParamForQuery(QueryOfInsert, FFaks);
      NewParamForQuery(QueryOfInsert, FMuhasebeTelefon);
      NewParamForQuery(QueryOfInsert, FMuhasebeEPosta);
      NewParamForQuery(QueryOfInsert, FMuhasebeYetkili);
      NewParamForQuery(QueryOfInsert, FWebSitesi);
      NewParamForQuery(QueryOfInsert, FePostaAdresi);
      NewParamForQuery(QueryOfInsert, FOzelBilgi);
      NewParamForQuery(QueryOfInsert, FOdemeVadeGunSayisi);
      NewParamForQuery(QueryOfInsert, FIsAcikHesap);
      NewParamForQuery(QueryOfInsert, FKrediLimiti);
      NewParamForQuery(QueryOfInsert, FHesapIskonto);

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
        FHesapTipiID.FieldName,
        FHesapTipi.FieldName,
        FHesapKodu.FieldName,
        FHesapIsmi.FieldName,
        FHesapGrubuID.FieldName,
        FBolgeID.FieldName,
        FTemsilciGrubuId.FieldName,
        FMukellefTipiID.FieldName,
        FMukellefAdi.FieldName,
        FMukellefIkinciAdi.FieldName,
        FMukellefSoyadi.FieldName,
        FVergiDairesi.FieldName,
        FVergiNo.FieldName,
        FParaBirimi.FieldName,
        FIban.FieldName,
        FIbanPara.FieldName,
        FMusteriTemsilcisiID.FieldName,
        FNaceKodu.FieldName,
        FIsEFaturaHesabi.FieldName,
        FUlkeID.FieldName,
        FSehirID.FieldName,
        FIlce.FieldName,
        FMahalle.FieldName,
        FCadde.FieldName,
        FSokak.FieldName,
        FBina.FieldName,
        FKapiNo.FieldName,
        FPostaKutusu.FieldName,
        FPostaKodu.FieldName,
        FYetkili1.FieldName,
        FYetkili1Tel.FieldName,
        FYetkili2.FieldName,
        FYetkili2Tel.FieldName,
        FTelefon1.FieldName,
        FTelefon2.FieldName,
        FTelefon3.FieldName,
        FFaks.FieldName,
        FMuhasebeTelefon.FieldName,
        FMuhasebeEPosta.FieldName,
        FMuhasebeYetkili.FieldName,
        FWebSitesi.FieldName,
        FePostaAdresi.FieldName,
        FOzelBilgi.FieldName,
        FOdemeVadeGunSayisi.FieldName,
        FIsAcikHesap.FieldName,
        FKrediLimiti.FieldName,
        FHesapIskonto.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FHesapTipiID);
      NewParamForQuery(QueryOfUpdate, FHesapTipi);
      NewParamForQuery(QueryOfUpdate, FHesapKodu);
      NewParamForQuery(QueryOfUpdate, FHesapIsmi);
      NewParamForQuery(QueryOfUpdate, FHesapGrubuID);
      NewParamForQuery(QueryOfUpdate, FBolgeID);
      NewParamForQuery(QueryOfUpdate, FTemsilciGrubuId);
      NewParamForQuery(QueryOfUpdate, FMukellefTipiID);
      NewParamForQuery(QueryOfUpdate, FMukellefAdi);
      NewParamForQuery(QueryOfUpdate, FMukellefIkinciAdi);
      NewParamForQuery(QueryOfUpdate, FMukellefSoyadi);
      NewParamForQuery(QueryOfUpdate, FVergiDairesi);
      NewParamForQuery(QueryOfUpdate, FVergiNo);
      NewParamForQuery(QueryOfUpdate, FParaBirimi);
      NewParamForQuery(QueryOfUpdate, FIban);
      NewParamForQuery(QueryOfUpdate, FIbanPara);
      NewParamForQuery(QueryOfUpdate, FMusteriTemsilcisiID);
      NewParamForQuery(QueryOfUpdate, FNaceKodu);
      NewParamForQuery(QueryOfUpdate, FIsEFaturaHesabi);
      NewParamForQuery(QueryOfUpdate, FUlkeID);
      NewParamForQuery(QueryOfUpdate, FSehirID);
      NewParamForQuery(QueryOfUpdate, FIlce);
      NewParamForQuery(QueryOfUpdate, FMahalle);
      NewParamForQuery(QueryOfUpdate, FCadde);
      NewParamForQuery(QueryOfUpdate, FSokak);
      NewParamForQuery(QueryOfUpdate, FBina);
      NewParamForQuery(QueryOfUpdate, FKapiNo);
      NewParamForQuery(QueryOfUpdate, FPostaKutusu);
      NewParamForQuery(QueryOfUpdate, FPostaKodu);
      NewParamForQuery(QueryOfUpdate, FYetkili1);
      NewParamForQuery(QueryOfUpdate, FYetkili1Tel);
      NewParamForQuery(QueryOfUpdate, FYetkili2);
      NewParamForQuery(QueryOfUpdate, FYetkili2Tel);
      NewParamForQuery(QueryOfUpdate, FTelefon1);
      NewParamForQuery(QueryOfUpdate, FTelefon2);
      NewParamForQuery(QueryOfUpdate, FTelefon3);
      NewParamForQuery(QueryOfUpdate, FFaks);
      NewParamForQuery(QueryOfUpdate, FMuhasebeTelefon);
      NewParamForQuery(QueryOfUpdate, FMuhasebeEPosta);
      NewParamForQuery(QueryOfUpdate, FMuhasebeYetkili);
      NewParamForQuery(QueryOfUpdate, FWebSitesi);
      NewParamForQuery(QueryOfUpdate, FePostaAdresi);
      NewParamForQuery(QueryOfUpdate, FOzelBilgi);
      NewParamForQuery(QueryOfUpdate, FOdemeVadeGunSayisi);
      NewParamForQuery(QueryOfUpdate, FIsAcikHesap);
      NewParamForQuery(QueryOfUpdate, FKrediLimiti);
      NewParamForQuery(QueryOfUpdate, FHesapIskonto);

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
  FHesapTipiID.Value := 0;
  FHesapTipi.Value := '';
  FHesapKodu.Value := '';
  FHesapIsmi.Value := '';
  FHesapGrubuID.Value := 0;
  FBolgeID.Value := 0;
  FTemsilciGrubuID.Value := 0;
  FMukellefTipiID.Value := 0;
  FMukellefAdi.Value := '';
  FMukellefIkinciAdi.Value := '';
  FMukellefSoyadi.Value := '';
  FVergiDairesi.Value := '';
  FVergiNo.Value := '';
  FParaBirimi.Value := '';
  FIban.Value := '';
  FIbanPara.Value := '';
  FMusteriTemsilcisiID.Value := 0;
  FNaceKodu.Value := '';
  FIsEFaturaHesabi.Value := False;
  FUlkeID.Value := 0;
  FSehirID.Value := 0;
  FIlce.Value := '';
  FMahalle.Value := '';
  FCadde.Value := '';
  FSokak.Value := '';
  FBina.Value := '';
  FKapiNo.Value := '';
  FPostaKutusu.Value := '';
  FPostaKodu.Value := '';
  FYetkili1.Value := '';
  FYetkili1Tel.Value := '';
  FYetkili2.Value := '';
  FYetkili2Tel.Value := '';
  FTelefon1.Value := '';
  FTelefon2.Value := '';
  FTelefon3.Value := '';
  FFaks.Value := '';
  FMuhasebeTelefon.Value := '';
  FMuhasebeEPosta.Value := '';
  FMuhasebeYetkili.Value := '';
  FWebSitesi.Value := '';
  FePostaAdresi.Value := '';
  FOzelBilgi.Value := '';
  FOdemeVadeGunSayisi.Value := 0;
  FIsAcikHesap.Value := False;
  FKrediLimiti.Value := 0;
  FHesapIskonto.Value := 0;
end;

function THesapKarti.Clone():TTable;
begin
  Result := THesapKarti.Create(Database);

  Self.Id.Clone(THesapKarti(Result).Id);

  FHesapTipiID.Clone(THesapKarti(Result).FHesapTipiID);
  FHesapTipi.Clone(THesapKarti(Result).FHesapTipi);
  FHesapKodu.Clone(THesapKarti(Result).FHesapKodu);
  FHesapIsmi.Clone(THesapKarti(Result).FHesapIsmi);
  FHesapGrubuID.Clone(THesapKarti(Result).FHesapGrubuID);
  FBolgeID.Clone(THesapKarti(Result).FBolgeID);
  FTemsilciGrubuId.Clone(THesapKarti(Result).FTemsilciGrubuId);
  FMukellefTipiID.Clone(THesapKarti(Result).FMukellefTipiID);
  FMukellefAdi.Clone(THesapKarti(Result).FMukellefAdi);
  FMukellefIkinciAdi.Clone(THesapKarti(Result).FMukellefIkinciAdi);
  FMukellefSoyadi.Clone(THesapKarti(Result).FMukellefSoyadi);
  FVergiDairesi.Clone(THesapKarti(Result).FVergiDairesi);
  FVergiNo.Clone(THesapKarti(Result).FVergiNo);
  FParaBirimi.Clone(THesapKarti(Result).FParaBirimi);
  FIban.Clone(THesapKarti(Result).FIban);
  FIbanPara.Clone(THesapKarti(Result).FIbanPara);
  FMusteriTemsilcisiID.Clone(THesapKarti(Result).FMusteriTemsilcisiID);
  FNaceKodu.Clone(THesapKarti(Result).FNaceKodu);
  FIsEFaturaHesabi.Clone(THesapKarti(Result).FIsEFaturaHesabi);
  FUlkeID.Clone(THesapKarti(Result).FUlkeID);
  FSehirID.Clone(THesapKarti(Result).FSehirID);
  FIlce.Clone(THesapKarti(Result).FIlce);
  FMahalle.Clone(THesapKarti(Result).FMahalle);
  FCadde.Clone(THesapKarti(Result).FCadde);
  FSokak.Clone(THesapKarti(Result).FSokak);
  FBina.Clone(THesapKarti(Result).FBina);
  FKapiNo.Clone(THesapKarti(Result).FKapiNo);
  FPostaKutusu.Clone(THesapKarti(Result).FPostaKutusu);
  FPostaKodu.Clone(THesapKarti(Result).FPostaKodu);
  FYetkili1.Clone(THesapKarti(Result).FYetkili1);
  FYetkili1Tel.Clone(THesapKarti(Result).FYetkili1Tel);
  FYetkili2.Clone(THesapKarti(Result).FYetkili2);
  FYetkili2Tel.Clone(THesapKarti(Result).FYetkili2Tel);
  FTelefon1.Clone(THesapKarti(Result).FTelefon1);
  FTelefon2.Clone(THesapKarti(Result).FTelefon2);
  FTelefon3.Clone(THesapKarti(Result).FTelefon3);
  FFaks.Clone(THesapKarti(Result).FFaks);
  FMuhasebeTelefon.Clone(THesapKarti(Result).FMuhasebeTelefon);
  FMuhasebeEPosta.Clone(THesapKarti(Result).FMuhasebeEPosta);
  FMuhasebeYetkili.Clone(THesapKarti(Result).FMuhasebeYetkili);
  FWebSitesi.Clone(THesapKarti(Result).FWebSitesi);
  FePostaAdresi.Clone(THesapKarti(Result).FePostaAdresi);
  FOzelBilgi.Clone(THesapKarti(Result).FOzelBilgi);
  FOdemeVadeGunSayisi.Clone(THesapKarti(Result).FOdemeVadeGunSayisi);
  FIsAcikHesap.Clone(THesapKarti(Result).FIsAcikHesap);
  FKrediLimiti.Clone(THesapKarti(Result).FKrediLimiti);
  FHesapIskonto.Clone(THesapKarti(Result).FHesapIskonto);
end;

end.
