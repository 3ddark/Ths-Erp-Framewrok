unit Ths.Erp.Database.Table.HesapKarti;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table

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
  , Ths.Erp.Database.Table.Adres
  ;

type
  THesapKarti = class(TTable)
  private
    FHesapKodu: TFieldDB;
    FHesapIsmi: TFieldDB;
    FMuhasebeKodu: TFieldDB;
    FHesapTipiID: TFieldDB;
    FHesapGrubuID: TFieldDB;
    FBolgeID: TFieldDB;
    FTemsilciGrubuID: TFieldDB;
    FMukellefTipiID: TFieldDB;
    FMusteriTemsilcisiID: TFieldDB;
    FAdresID: TFieldDB;
    FMukellefAdi: TFieldDB;
    FMukellefIkinciAdi: TFieldDB;
    FMukellefSoyadi: TFieldDB;
    FVergiDairesi: TFieldDB;
    FVergiNo: TFieldDB;
    FParaBirimi: TFieldDB;
    FIban: TFieldDB;
    FIbanPara: TFieldDB;
    FNaceKodu: TFieldDB;
    FIsEFaturaHesabi: TFieldDB;
    FEFaturaPKName: TFieldDB;
    FYetkili1: TFieldDB;
    FYetkili1Tel: TFieldDB;
    FYetkili2: TFieldDB;
    FYetkili2Tel: TFieldDB;
    FYetkili3: TFieldDB;
    FYetkili3Tel: TFieldDB;
    FFaks: TFieldDB;
    FMuhasebeTelefon: TFieldDB;
    FMuhasebeEPosta: TFieldDB;
    FMuhasebeYetkili: TFieldDB;
    FOzelBilgi: TFieldDB;
    FOdemeVadeGunSayisi: TFieldDB;
    FIsAcikHesap: TFieldDB;
    FKrediLimiti: TFieldDB;
    FHesapIskonto: TFieldDB;
    FAdres: TAdres;
  protected
    procedure BusinessSelect(pFilter: string; pLock: Boolean; pPermissionControl: Boolean); override;
    procedure BusinessInsert(out pID: Integer; var pPermissionControl: Boolean); override;
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property HesapKodu: TFieldDB read FHesapKodu write FHesapKodu;
    Property HesapIsmi: TFieldDB read FHesapIsmi write FHesapIsmi;
    Property MuhasebeKodu: TFieldDB read FMuhasebeKodu write FMuhasebeKodu;
    Property HesapTipiID: TFieldDB read FHesapTipiID write FHesapTipiID;
    Property HesapGrubuID: TFieldDB read FHesapGrubuID write FHesapGrubuID;
    Property BolgeID: TFieldDB read FBolgeID write FBolgeID;
    Property TemsilciGrubuID: TFieldDB read FTemsilciGrubuID write FTemsilciGrubuID;
    Property MukellefTipiID: TFieldDB read FMukellefTipiID write FMukellefTipiID;
    Property MusteriTemsilcisiID: TFieldDB read FMusteriTemsilcisiID write FMusteriTemsilcisiID;
    Property AdresID: TFieldDB read FAdresID write FAdresID;
    Property MukellefAdi: TFieldDB read FMukellefAdi write FMukellefAdi;
    Property MukellefIkinciAdi: TFieldDB read FMukellefIkinciAdi write FMukellefIkinciAdi;
    Property MukellefSoyadi: TFieldDB read FMukellefSoyadi write FMukellefSoyadi;
    Property VergiDairesi: TFieldDB read FVergiDairesi write FVergiDairesi;
    Property VergiNo: TFieldDB read FVergiNo write FVergiNo;
    Property ParaBirimi: TFieldDB read FParaBirimi write FParaBirimi;
    Property Iban: TFieldDB read FIban write FIban;
    Property IbanPara: TFieldDB read FIbanPara write FIbanPara;
    Property NaceKodu: TFieldDB read FNaceKodu write FNaceKodu;
    Property IsEFaturaHesabi: TFieldDB read FIsEFaturaHesabi write FIsEFaturaHesabi;
    Property EFaturaPKName: TFieldDB read FEFaturaPKName write FEFaturaPKName;
    Property Yetkili1: TFieldDB read FYetkili1 write FYetkili1;
    Property Yetkili1Tel: TFieldDB read FYetkili1Tel write FYetkili1Tel;
    Property Yetkili2: TFieldDB read FYetkili2 write FYetkili2;
    Property Yetkili2Tel: TFieldDB read FYetkili2Tel write FYetkili2Tel;
    Property Yetkili3: TFieldDB read FYetkili3 write FYetkili3;
    Property Yetkili3Tel: TFieldDB read FYetkili3Tel write FYetkili3Tel;
    Property Faks: TFieldDB read FFaks write FFaks;
    Property MuhasebeTelefon: TFieldDB read FMuhasebeTelefon write FMuhasebeTelefon;
    Property MuhasebeEPosta: TFieldDB read FMuhasebeEPosta write FMuhasebeEPosta;
    Property MuhasebeYetkili: TFieldDB read FMuhasebeYetkili write FMuhasebeYetkili;
    Property OzelBilgi: TFieldDB read FOzelBilgi write FOzelBilgi;
    Property OdemeVadeGunSayisi: TFieldDB read FOdemeVadeGunSayisi write FOdemeVadeGunSayisi;
    Property IsAcikHesap: TFieldDB read FIsAcikHesap write FIsAcikHesap;
    Property KrediLimiti: TFieldDB read FKrediLimiti write FKrediLimiti;
    Property HesapIskonto: TFieldDB read FHesapIskonto write FHesapIskonto;
    Property Adres: TAdres read FAdres write FAdres;
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

  FHesapKodu := TFieldDB.Create('hesap_kodu', ftString, '', 0, False, True, False, False);
  FHesapIsmi := TFieldDB.Create('hesap_ismi', ftString, '', 0, False, False, False, False);
  FMuhasebeKodu := TFieldDB.Create('muhasebe_kodu', ftString, '', 0, False, True, False, False);
  FHesapTipiID := TFieldDB.Create('hesap_tipi_id', ftInteger, 0, 0, False, False, True, False);
  FHesapTipiID.FK.FKTable := TAyarHesapTipi.Create(Database);
  FHesapTipiID.FK.FKCol := TFieldDB.Create(TAyarHesapTipi(FHesapTipiID.FK.FKTable).HesapTipi.FieldName, TAyarHesapTipi(FHesapTipiID.FK.FKTable).HesapTipi.FieldType, '', 0, False, False, False, False);
  FHesapGrubuID := TFieldDB.Create('hesap_grubu_id', ftInteger, 0, 0, False, False, True, False);
  FHesapGrubuID.FK.FKTable := THesapGrubu.Create(Database);
  FHesapGrubuID.FK.FKCol := TFieldDB.Create(THesapGrubu(FHesapGrubuID.FK.FKTable).Grup.FieldName, THesapGrubu(FHesapGrubuID.FK.FKTable).Grup.FieldType, '', 0, False, False, False, False);
  FBolgeID := TFieldDB.Create('bolge_id', ftInteger, 0, 0, False, False, True, False);
  FBolgeID.FK.FKTable := TBolge.Create(Database);
  FBolgeID.FK.FKCol := TFieldDB.Create(TBolge(FBolgeID.FK.FKTable).BolgeAdi.FieldName, TBolge(FBolgeID.FK.FKTable).BolgeAdi.FieldType, '', 0, False, False, False, False);
  FTemsilciGrubuId := TFieldDB.Create('temsilci_grubu_id', ftInteger, 0, 0, False, False, True, True);
  FTemsilciGrubuId.FK.FKTable := TMusteriTemsilciGrubu.Create(Database);
  FTemsilciGrubuId.FK.FKCol := TFieldDB.Create(TMusteriTemsilciGrubu(FTemsilciGrubuID.FK.FKTable).TemsilciGrupAdi.FieldName, TMusteriTemsilciGrubu(FTemsilciGrubuID.FK.FKTable).TemsilciGrupAdi.FieldType, '', 0, False, False, False, False);
  FMukellefTipiID := TFieldDB.Create('mukellef_tipi_id', ftInteger, 0, 0, False, False, True, False);
  FMukellefTipiID.FK.FKTable := TAyarMukellefTipi.Create(Database);
  FMukellefTipiID.FK.FKCol := TFieldDB.Create(TAyarMukellefTipi(FMukellefTipiID.FK.FKTable).Deger.FieldName, TAyarMukellefTipi(FMukellefTipiID.FK.FKTable).Deger.FieldType, '', 0, False, False, False, False);
  FMusteriTemsilcisiID := TFieldDB.Create('musteri_temsilcisi_id', ftInteger, 0, 0, False, False, True, False);
  FMusteriTemsilcisiID.FK.FKTable := TPersonelKarti.Create(Database);
  FMusteriTemsilcisiID.FK.FKCol := TFieldDB.Create(TPersonelKarti(FMusteriTemsilcisiID.FK.FKTable).PersonelAd.FieldName, TPersonelKarti(FMusteriTemsilcisiID.FK.FKTable).PersonelAd.FieldType, '', 0, False, False, False, False);
  FAdresID := TFieldDB.Create('adres_id', ftInteger, 0, 0, False, False, False, False);
  FMukellefAdi := TFieldDB.Create('mukellef_adi', ftString, '', 0, False, False, False, True);
  FMukellefIkinciAdi := TFieldDB.Create('mukellef_ikinci_adi', ftString, '', 0, False, False, False, True);
  FMukellefSoyadi := TFieldDB.Create('mukellef_soyadi', ftString, '', 0, False, False, False, True);
  FVergiDairesi := TFieldDB.Create('vergi_dairesi', ftString, '', 0, False, False, False, True);
  FVergiNo := TFieldDB.Create('vergi_no', ftString, '', 0, False, False, False, True);
  FParaBirimi := TFieldDB.Create('para_birimi', ftString, '', 0, False, False, False, False);
  FIban := TFieldDB.Create('iban', ftString, '', 0, False, False, False, True);
  FIbanPara := TFieldDB.Create('iban_para', ftString, '', 0, False, False, False, False);
  FNaceKodu := TFieldDB.Create('nace_kodu', ftString, '', 0, False, False, False, True);
  FIsEFaturaHesabi := TFieldDB.Create('is_efatura_hesabi', ftBoolean, False, 0, False, False, False, False);
  FEFaturaPKName := TFieldDB.Create('efatura_pk_name', ftString, '', 0, False, False, False, False);
  FYetkili1 := TFieldDB.Create('yetkili1', ftString, '', 0, False, False, False, True);
  FYetkili1Tel := TFieldDB.Create('yetkili1_tel', ftString, '', 0, False, False, False, True);
  FYetkili2 := TFieldDB.Create('yetkili2', ftString, '', 0, False, False, False, True);
  FYetkili2Tel := TFieldDB.Create('yetkili2_tel', ftString, '', 0, False, False, False, True);
  FYetkili3 := TFieldDB.Create('yetkili3', ftString, '', 0, False, False, False, True);
  FYetkili3Tel := TFieldDB.Create('yetkili3_tel', ftString, '', 0, False, False, False, True);
  FFaks := TFieldDB.Create('faks', ftString, '', 0, False, False, False, True);
  FMuhasebeTelefon := TFieldDB.Create('muhasebe_telefon', ftString, '', 0, False, False, False, True);
  FMuhasebeEPosta := TFieldDB.Create('muhasebe_eposta', ftString, '', 0, False, False, False, True);
  FMuhasebeYetkili := TFieldDB.Create('muhasebe_yetkili', ftString, '', 0, False, False, False, True);
  FOzelBilgi := TFieldDB.Create('ozel_bilgi', ftString, '', 0, False, False, False, True);
  FOdemeVadeGunSayisi := TFieldDB.Create('odeme_vade_gun_sayisi', ftInteger, 0, 0, False, False, False, True);
  FIsAcikHesap := TFieldDB.Create('is_acik_hesap', ftBoolean, False, 0, False, False, False, True);
  FKrediLimiti := TFieldDB.Create('kredi_limiti', ftFloat, 0, 0, False, False, False, True);
  FHesapIskonto := TFieldDB.Create('hesap_iskonto', ftFloat, 0, 0, False, False, False, True);

  FAdres := TAdres.Create(Database);
end;

procedure THesapKarti.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName + ', ' + FAdres.TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FHesapKodu.FieldName,
        TableName + '.' + FHesapIsmi.FieldName,
        TableName + '.' + FMuhasebeKodu.FieldName,
        TableName + '.' + FHesapTipiID.FieldName,
        ColumnFromIDCol(TAyarHesapTipi(FHesapTipiID.FK.FKTable).HesapTipi.FieldName, FHesapTipiID.FK.FKTable.TableName, FHesapTipiID.FieldName, FHesapTipiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FHesapGrubuID.FieldName,
        ColumnFromIDCol(THesapGrubu(FHesapGrubuID.FK.FKTable).Grup.FieldName, FHesapGrubuID.FK.FKTable.TableName, FHesapGrubuID.FieldName, FHesapGrubuID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FBolgeID.FieldName,
        ColumnFromIDCol(TBolge(FBolgeID.FK.FKTable).BolgeAdi.FieldName, FBolgeID.FK.FKTable.TableName, FBolgeID.FieldName, FBolgeID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FTemsilciGrubuId.FieldName,
        ColumnFromIDCol(TMusteriTemsilciGrubu(FTemsilciGrubuId.FK.FKTable).TemsilciGrupAdi.FieldName, FTemsilciGrubuId.FK.FKTable.TableName, FTemsilciGrubuId.FieldName, FTemsilciGrubuId.FK.FKCol.FieldName, TableName),
        TableName + '.' + FMukellefTipiID.FieldName,
        ColumnFromIDCol(TAyarMukellefTipi(FMukellefTipiID.FK.FKTable).Deger.FieldName, FMukellefTipiID.FK.FKTable.TableName, FMukellefTipiID.FieldName, FMukellefTipiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FMusteriTemsilcisiID.FieldName,
        ColumnFromIDCol(TPersonelKarti(FMusteriTemsilcisiID.FK.FKTable).PersonelAd.FieldName, FMusteriTemsilcisiID.FK.FKTable.TableName, FMusteriTemsilcisiID.FieldName, FMusteriTemsilcisiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FAdresID.FieldName,
        TableName + '.' + FMukellefAdi.FieldName,
        TableName + '.' + FMukellefIkinciAdi.FieldName,
        TableName + '.' + FMukellefSoyadi.FieldName,
        TableName + '.' + FVergiDairesi.FieldName,
        TableName + '.' + FVergiNo.FieldName,
        TableName + '.' + FParaBirimi.FieldName,
        TableName + '.' + FIban.FieldName,
        TableName + '.' + FIbanPara.FieldName,
        TableName + '.' + FNaceKodu.FieldName,
        TableName + '.' + FIsEFaturaHesabi.FieldName,
        TableName + '.' + FEFaturaPKName.FieldName,
        TableName + '.' + FYetkili1.FieldName,
        TableName + '.' + FYetkili1Tel.FieldName,
        TableName + '.' + FYetkili2.FieldName,
        TableName + '.' + FYetkili2Tel.FieldName,
        TableName + '.' + FYetkili3.FieldName,
        TableName + '.' + FYetkili3Tel.FieldName,
        TableName + '.' + FFaks.FieldName,
        TableName + '.' + FMuhasebeTelefon.FieldName,
        TableName + '.' + FMuhasebeEPosta.FieldName,
        TableName + '.' + FMuhasebeYetkili.FieldName,
        TableName + '.' + FOzelBilgi.FieldName,
        TableName + '.' + FOdemeVadeGunSayisi.FieldName,
        TableName + '.' + FIsAcikHesap.FieldName,
        TableName + '.' + FKrediLimiti.FieldName,
        TableName + '.' + FHesapIskonto.FieldName,
        FAdres.TableName + '.' + FAdres.UlkeID.FieldName,
        ColumnFromIDCol(TUlke(FAdres.UlkeID.FK.FKTable).UlkeAdi.FieldName, FAdres.UlkeID.FK.FKTable.TableName, FAdres.UlkeID.FieldName, FAdres.UlkeID.FK.FKCol.FieldName, FAdres.TableName),
        FAdres.TableName + '.' + FAdres.SehirID.FieldName,
        ColumnFromIDCol(TSehir(FAdres.SehirID.FK.FKTable).SehirAdi.FieldName, FAdres.SehirID.FK.FKTable.TableName, FAdres.SehirID.FieldName, FAdres.SehirID.FK.FKCol.FieldName, FAdres.TableName),
        FAdres.TableName + '.' + FAdres.Ilce.FieldName,
        FAdres.TableName + '.' + FAdres.Mahalle.FieldName,
        FAdres.TableName + '.' + FAdres.Cadde.FieldName,
        FAdres.TableName + '.' + FAdres.Sokak.FieldName,
        FAdres.TableName + '.' + FAdres.Bina.FieldName,
        FAdres.TableName + '.' + FAdres.KapiNo.FieldName,
        FAdres.TableName + '.' + FAdres.PostaKutusu.FieldName,
        FAdres.TableName + '.' + FAdres.PostaKodu.FieldName,
        FAdres.TableName + '.' + FAdres.WebSitesi.FieldName,
        FAdres.TableName + '.' + FAdres.ePostaAdresi.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FHesapKodu.FieldName).DisplayLabel := 'Hesap Kodu';
      Self.DataSource.DataSet.FindField(FHesapIsmi.FieldName).DisplayLabel := 'Hesap Ýsmi';
      Self.DataSource.DataSet.FindField(FMuhasebeKodu.FieldName).DisplayLabel := 'Muhasebe Kodu';
      Self.DataSource.DataSet.FindField(FHesapTipiID.FieldName).DisplayLabel := 'Hesap Tipi ID';
      Self.DataSource.DataSet.FindField(FHesapTipiID.FK.FKCol.FieldName).DisplayLabel := 'Hesap Tipi';
      Self.DataSource.DataSet.FindField(FHesapGrubuID.FieldName).DisplayLabel := 'Hesap Grubu ID';
      Self.DataSource.DataSet.FindField(FHesapGrubuID.FK.FKCol.FieldName).DisplayLabel := 'Hesap Grubu';
      Self.DataSource.DataSet.FindField(FBolgeID.FieldName).DisplayLabel := 'Bölge ID';
      Self.DataSource.DataSet.FindField(FBolgeID.FK.FKCol.FieldName).DisplayLabel := 'Bölge';
      Self.DataSource.DataSet.FindField(FTemsilciGrubuId.FieldName).DisplayLabel := 'Temsilci Grubu ID';
      Self.DataSource.DataSet.FindField(FTemsilciGrubuId.FK.FKCol.FieldName).DisplayLabel := 'Temsilci Grubu';
      Self.DataSource.DataSet.FindField(FMukellefTipiID.FieldName).DisplayLabel := 'Mukellef Tipi ID';
      Self.DataSource.DataSet.FindField(FMukellefTipiID.FK.FKCol.FieldName).DisplayLabel := 'Mükellef Tipi';
      Self.DataSource.DataSet.FindField(FMusteriTemsilcisiID.FieldName).DisplayLabel := 'Müþteri Temsilcisi ID';
      Self.DataSource.DataSet.FindField(FMusteriTemsilcisiID.FK.FKCol.FieldName).DisplayLabel := 'Müþteri Temsilcisi';
      Self.DataSource.DataSet.FindField(FAdresID.FieldName).DisplayLabel := 'Adres ID';
      Self.DataSource.DataSet.FindField(FMukellefAdi.FieldName).DisplayLabel := 'Mükellef Adý';
      Self.DataSource.DataSet.FindField(FMukellefIkinciAdi.FieldName).DisplayLabel := 'Mükellef Ýkinci Adý';
      Self.DataSource.DataSet.FindField(FMukellefSoyadi.FieldName).DisplayLabel := 'Mükellef Soyadý';
      Self.DataSource.DataSet.FindField(FVergiDairesi.FieldName).DisplayLabel := 'Vergi Dairesi';
      Self.DataSource.DataSet.FindField(FVergiNo.FieldName).DisplayLabel := 'Vergi No';
      Self.DataSource.DataSet.FindField(FParaBirimi.FieldName).DisplayLabel := 'Para Birimi';
      Self.DataSource.DataSet.FindField(FIban.FieldName).DisplayLabel := 'IBAN Numarasý';
      Self.DataSource.DataSet.FindField(FIbanPara.FieldName).DisplayLabel := 'IBAN Para Birimi';
      Self.DataSource.DataSet.FindField(FNaceKodu.FieldName).DisplayLabel := 'Nace Kodu';
      Self.DataSource.DataSet.FindField(FIsEFaturaHesabi.FieldName).DisplayLabel := 'E-Fatura Hesabý?';
      Self.DataSource.DataSet.FindField(FEFaturaPKName.FieldName).DisplayLabel := 'E-Fatura Posta Kutusu';
      Self.DataSource.DataSet.FindField(FYetkili1.FieldName).DisplayLabel := 'Yetkili 1';
      Self.DataSource.DataSet.FindField(FYetkili1Tel.FieldName).DisplayLabel := 'Yetkili 1 Telefon';
      Self.DataSource.DataSet.FindField(FYetkili2.FieldName).DisplayLabel := 'Yetkili 2';
      Self.DataSource.DataSet.FindField(FYetkili2Tel.FieldName).DisplayLabel := 'Yetkili 2 Telefon';
      Self.DataSource.DataSet.FindField(FYetkili3.FieldName).DisplayLabel := 'Yetkili 3';
      Self.DataSource.DataSet.FindField(FYetkili3Tel.FieldName).DisplayLabel := 'Yetkili 3 Telefon';
      Self.DataSource.DataSet.FindField(FFaks.FieldName).DisplayLabel := 'Faks';
      Self.DataSource.DataSet.FindField(FMuhasebeTelefon.FieldName).DisplayLabel := 'Muhasebe Telefon';
      Self.DataSource.DataSet.FindField(FMuhasebeEPosta.FieldName).DisplayLabel := 'Muhasebe E-Posta';
      Self.DataSource.DataSet.FindField(FMuhasebeYetkili.FieldName).DisplayLabel := 'Muhasebe Yetkili';
      Self.DataSource.DataSet.FindField(FOzelBilgi.FieldName).DisplayLabel := 'Özel Bilgi';
      Self.DataSource.DataSet.FindField(FOdemeVadeGunSayisi.FieldName).DisplayLabel := 'Ödeme Vade Gün Sayýsý';
      Self.DataSource.DataSet.FindField(FIsAcikHesap.FieldName).DisplayLabel := 'Açýk Hesap?';
      Self.DataSource.DataSet.FindField(FKrediLimiti.FieldName).DisplayLabel := 'Kredi Limiti';
      Self.DataSource.DataSet.FindField(FHesapIskonto.FieldName).DisplayLabel := 'Hesap Ýskonto';
      Self.DataSource.DataSet.FindField(FAdres.UlkeID.FieldName).DisplayLabel := 'Ülke ID';
      Self.DataSource.DataSet.FindField(FAdres.UlkeID.FK.FKCol.FieldName).DisplayLabel := 'Ülke';
      Self.DataSource.DataSet.FindField(FAdres.SehirID.FieldName).DisplayLabel := 'Þehir ID';
      Self.DataSource.DataSet.FindField(FAdres.SehirID.FK.FKCol.FieldName).DisplayLabel := 'Þehir';
      Self.DataSource.DataSet.FindField(FAdres.Ilce.FieldName).DisplayLabel := 'Ýlçe';
      Self.DataSource.DataSet.FindField(FAdres.Mahalle.FieldName).DisplayLabel := 'Mahalle';
      Self.DataSource.DataSet.FindField(FAdres.Cadde.FieldName).DisplayLabel := 'Cadde';
      Self.DataSource.DataSet.FindField(FAdres.Sokak.FieldName).DisplayLabel := 'Sokak';
      Self.DataSource.DataSet.FindField(FAdres.Bina.FieldName).DisplayLabel := 'Bina';
      Self.DataSource.DataSet.FindField(FAdres.KapiNo.FieldName).DisplayLabel := 'Kapý No';
      Self.DataSource.DataSet.FindField(FAdres.PostaKutusu.FieldName).DisplayLabel := 'Posta Kutusu';
      Self.DataSource.DataSet.FindField(FAdres.PostaKodu.FieldName).DisplayLabel := 'Posta Kodu';
      Self.DataSource.DataSet.FindField(FAdres.WebSitesi.FieldName).DisplayLabel := 'Web';
      Self.DataSource.DataSet.FindField(FAdres.ePostaAdresi.FieldName).DisplayLabel := 'e-Posta';

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
        TableName + '.' + FHesapTipiID.FieldName,
        ColumnFromIDCol(TAyarHesapTipi(FHesapTipiID.FK.FKTable).HesapTipi.FieldName, FHesapTipiID.FK.FKTable.TableName, FHesapTipiID.FieldName, FHesapTipiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FHesapKodu.FieldName,
        TableName + '.' + FHesapIsmi.FieldName,
        TableName + '.' + FHesapGrubuID.FieldName,
        ColumnFromIDCol(THesapGrubu(FHesapGrubuID.FK.FKTable).Grup.FieldName, FHesapGrubuID.FK.FKTable.TableName, FHesapGrubuID.FieldName, FHesapGrubuID.FK.FKCol.FieldName, TableName)
//        TableName + '.' + FBolgeID.FieldName,
//        ColumnFromIDCol(TBolge(FBolgeID.FK.FKTable).BolgeAdi.FieldName, FBolgeID.FK.FKTable.TableName, FBolgeID.FieldName, FBolgeID.FK.FKColName, TableName),
//        TableName + '.' + FTemsilciGrubuId.FieldName,
//        ColumnFromIDCol(TMusteriTemsilciGrubu(FTemsilciGrubuId.FK.FKTable).TemsilciGrupAdi.FieldName, FTemsilciGrubuId.FK.FKTable.TableName, FTemsilciGrubuId.FieldName, FTemsilciGrubuId.FK.FKColName, TableName),
//        TableName + '.' + FMukellefTipiID.FieldName,
//        ColumnFromIDCol(TAyarMukellefTipi(FMukellefTipiID.FK.FKTable).Deger.FieldName, FMukellefTipiID.FK.FKTable.TableName, FMukellefTipiID.FieldName, FMukellefTipiID.FK.FKColName, TableName),
//        TableName + '.' + FMukellefAdi.FieldName,
//        TableName + '.' + FMukellefIkinciAdi.FieldName,
//        TableName + '.' + FMukellefSoyadi.FieldName,
//        TableName + '.' + FVergiDairesi.FieldName,
//        TableName + '.' + FVergiNo.FieldName,
//        TableName + '.' + FParaBirimi.FieldName,
//        TableName + '.' + FIban.FieldName,
//        TableName + '.' + FIbanPara.FieldName,
//        TableName + '.' + FMusteriTemsilcisiID.FieldName,
//        ColumnFromIDCol(TPersonelKarti(FMusteriTemsilcisiID.FK.FKTable).PersonelAd.FieldName, FMusteriTemsilcisiID.FK.FKTable.TableName, FMusteriTemsilcisiID.FieldName, FMusteriTemsilcisiID.FK.FKColName, TableName),
//        TableName + '.' + FNaceKodu.FieldName,
//        TableName + '.' + FIsEFaturaHesabi.FieldName,
//        TableName + '.' + FUlkeID.FieldName,
//        ColumnFromIDCol(TUlke(FUlkeID.FK.FKTable).UlkeAdi.FieldName, FUlkeID.FK.FKTable.TableName, FUlkeID.FieldName, FUlkeID.FK.FKColName, TableName),
//        TableName + '.' + FSehirID.FieldName,
//        ColumnFromIDCol(TSehir(FSehirID.FK.FKTable).SehirAdi.FieldName, FSehirID.FK.FKTable.TableName, FSehirID.FieldName, FSehirID.FK.FKColName, TableName),
//        TableName + '.' + FIlce.FieldName,
//        TableName + '.' + FMahalle.FieldName,
//        TableName + '.' + FCadde.FieldName,
//        TableName + '.' + FSokak.FieldName,
//        TableName + '.' + FBina.FieldName,
//        TableName + '.' + FKapiNo.FieldName,
//        TableName + '.' + FPostaKutusu.FieldName,
//        TableName + '.' + FPostaKodu.FieldName,
//        TableName + '.' + FYetkili1.FieldName,
//        TableName + '.' + FYetkili1Tel.FieldName,
//        TableName + '.' + FYetkili2.FieldName,
//        TableName + '.' + FYetkili2Tel.FieldName,
//        TableName + '.' + FTelefon1.FieldName,
//        TableName + '.' + FTelefon2.FieldName,
//        TableName + '.' + FTelefon3.FieldName,
//        TableName + '.' + FFaks.FieldName,
//        TableName + '.' + FMuhasebeTelefon.FieldName,
//        TableName + '.' + FMuhasebeEPosta.FieldName,
//        TableName + '.' + FMuhasebeYetkili.FieldName,
//        TableName + '.' + FWebSitesi.FieldName,
//        TableName + '.' + FePostaAdresi.FieldName,
//        TableName + '.' + FOzelBilgi.FieldName,
//        TableName + '.' + FOdemeVadeGunSayisi.FieldName,
//        TableName + '.' + FIsAcikHesap.FieldName,
//        TableName + '.' + FKrediLimiti.FieldName,
//        TableName + '.' + FHesapIskonto.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FHesapTipiID.Value := FormatedVariantVal(FieldByName(FHesapTipiID.FieldName).DataType, FieldByName(FHesapTipiID.FieldName).Value);
        FHesapTipiID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FHesapTipiID.FK.FKCol.FieldName).DataType, FieldByName(FHesapTipiID.FK.FKCol.FieldName).Value);
        FHesapKodu.Value := FormatedVariantVal(FieldByName(FHesapKodu.FieldName).DataType, FieldByName(FHesapKodu.FieldName).Value);
        FHesapIsmi.Value := FormatedVariantVal(FieldByName(FHesapIsmi.FieldName).DataType, FieldByName(FHesapIsmi.FieldName).Value);
        FHesapGrubuID.Value := FormatedVariantVal(FieldByName(FHesapGrubuID.FieldName).DataType, FieldByName(FHesapGrubuID.FieldName).Value);
        FHesapGrubuID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FHesapGrubuID.FK.FKCol.FieldName).DataType, FieldByName(FHesapGrubuID.FK.FKCol.FieldName).Value);
//        FBolgeID.Value := FormatedVariantVal(FieldByName(FBolgeID.FieldName).DataType, FieldByName(FBolgeID.FieldName).Value);
//        FBolgeID.FK.FKValue := FormatedVariantVal(FieldByName(FBolgeID.FK.FKColName).DataType, FieldByName(FBolgeID.FK.FKColName).Value);
//        FTemsilciGrubuID.Value := FormatedVariantVal(FieldByName(FTemsilciGrubuId.FieldName).DataType, FieldByName(FTemsilciGrubuId.FieldName).Value);
//        FTemsilciGrubuID.FK.FKValue := FormatedVariantVal(FieldByName(FTemsilciGrubuID.FK.FKColName).DataType, FieldByName(FTemsilciGrubuID.FK.FKColName).Value);
//        FMukellefTipiID.Value := FormatedVariantVal(FieldByName(FMukellefTipiID.FieldName).DataType, FieldByName(FMukellefTipiID.FieldName).Value);
//        FMukellefTipiID.FK.FKValue := FormatedVariantVal(FieldByName(FMukellefTipiID.FK.FKColName).DataType, FieldByName(FMukellefTipiID.FK.FKColName).Value);
//        FMukellefAdi.Value := FormatedVariantVal(FieldByName(FMukellefAdi.FieldName).DataType, FieldByName(FMukellefAdi.FieldName).Value);
//        FMukellefIkinciAdi.Value := FormatedVariantVal(FieldByName(FMukellefIkinciAdi.FieldName).DataType, FieldByName(FMukellefIkinciAdi.FieldName).Value);
//        FMukellefSoyadi.Value := FormatedVariantVal(FieldByName(FMukellefSoyadi.FieldName).DataType, FieldByName(FMukellefSoyadi.FieldName).Value);
//        FVergiDairesi.Value := FormatedVariantVal(FieldByName(FVergiDairesi.FieldName).DataType, FieldByName(FVergiDairesi.FieldName).Value);
//        FVergiNo.Value := FormatedVariantVal(FieldByName(FVergiNo.FieldName).DataType, FieldByName(FVergiNo.FieldName).Value);
//        FParaBirimi.Value := FormatedVariantVal(FieldByName(FParaBirimi.FieldName).DataType, FieldByName(FParaBirimi.FieldName).Value);
//        FIban.Value := FormatedVariantVal(FieldByName(FIban.FieldName).DataType, FieldByName(FIban.FieldName).Value);
//        FIbanPara.Value := FormatedVariantVal(FieldByName(FIbanPara.FieldName).DataType, FieldByName(FIbanPara.FieldName).Value);
//        FMusteriTemsilcisiID.Value := FormatedVariantVal(FieldByName(FMusteriTemsilcisiID.FieldName).DataType, FieldByName(FMusteriTemsilcisiID.FieldName).Value);
//        FMusteriTemsilcisiID.FK.FKValue := FormatedVariantVal(FieldByName(FMusteriTemsilcisiID.FK.FKColName).DataType, FieldByName(FMusteriTemsilcisiID.FK.FKColName).Value);
//        FNaceKodu.Value := FormatedVariantVal(FieldByName(FNaceKodu.FieldName).DataType, FieldByName(FNaceKodu.FieldName).Value);
//        FIsEFaturaHesabi.Value := FormatedVariantVal(FieldByName(FIsEFaturaHesabi.FieldName).DataType, FieldByName(FIsEFaturaHesabi.FieldName).Value);
//        FUlkeID.Value := FormatedVariantVal(FieldByName(FUlkeID.FieldName).DataType, FieldByName(FUlkeID.FieldName).Value);
//        FUlkeID.FK.FKValue := FormatedVariantVal(FieldByName(FUlkeID.FK.FKColName).DataType, FieldByName(FUlkeID.FK.FKColName).Value);
//        FSehirID.Value := FormatedVariantVal(FieldByName(FSehirID.FieldName).DataType, FieldByName(FSehirID.FieldName).Value);
//        FSehirID.FK.FKValue := FormatedVariantVal(FieldByName(FSehirID.FK.FKColName).DataType, FieldByName(FSehirID.FK.FKColName).Value);
//        FIlce.Value := FormatedVariantVal(FieldByName(FIlce.FieldName).DataType, FieldByName(FIlce.FieldName).Value);
//        FMahalle.Value := FormatedVariantVal(FieldByName(FMahalle.FieldName).DataType, FieldByName(FMahalle.FieldName).Value);
//        FCadde.Value := FormatedVariantVal(FieldByName(FCadde.FieldName).DataType, FieldByName(FCadde.FieldName).Value);
//        FSokak.Value := FormatedVariantVal(FieldByName(FSokak.FieldName).DataType, FieldByName(FSokak.FieldName).Value);
//        FBina.Value := FormatedVariantVal(FieldByName(FBina.FieldName).DataType, FieldByName(FBina.FieldName).Value);
//        FKapiNo.Value := FormatedVariantVal(FieldByName(FKapiNo.FieldName).DataType, FieldByName(FKapiNo.FieldName).Value);
//        FPostaKutusu.Value := FormatedVariantVal(FieldByName(FPostaKutusu.FieldName).DataType, FieldByName(FPostaKutusu.FieldName).Value);
//        FPostaKodu.Value := FormatedVariantVal(FieldByName(FPostaKodu.FieldName).DataType, FieldByName(FPostaKodu.FieldName).Value);
//        FYetkili1.Value := FormatedVariantVal(FieldByName(FYetkili1.FieldName).DataType, FieldByName(FYetkili1.FieldName).Value);
//        FYetkili1Tel.Value := FormatedVariantVal(FieldByName(FYetkili1Tel.FieldName).DataType, FieldByName(FYetkili1Tel.FieldName).Value);
//        FYetkili2.Value := FormatedVariantVal(FieldByName(FYetkili2.FieldName).DataType, FieldByName(FYetkili2.FieldName).Value);
//        FYetkili2Tel.Value := FormatedVariantVal(FieldByName(FYetkili2Tel.FieldName).DataType, FieldByName(FYetkili2Tel.FieldName).Value);
//        FTelefon1.Value := FormatedVariantVal(FieldByName(FTelefon1.FieldName).DataType, FieldByName(FTelefon1.FieldName).Value);
//        FTelefon2.Value := FormatedVariantVal(FieldByName(FTelefon2.FieldName).DataType, FieldByName(FTelefon2.FieldName).Value);
//        FTelefon3.Value := FormatedVariantVal(FieldByName(FTelefon3.FieldName).DataType, FieldByName(FTelefon3.FieldName).Value);
//        FFaks.Value := FormatedVariantVal(FieldByName(FFaks.FieldName).DataType, FieldByName(FFaks.FieldName).Value);
//        FMuhasebeTelefon.Value := FormatedVariantVal(FieldByName(FMuhasebeTelefon.FieldName).DataType, FieldByName(FMuhasebeTelefon.FieldName).Value);
//        FMuhasebeEPosta.Value := FormatedVariantVal(FieldByName(FMuhasebeEPosta.FieldName).DataType, FieldByName(FMuhasebeEPosta.FieldName).Value);
//        FMuhasebeYetkili.Value := FormatedVariantVal(FieldByName(FMuhasebeYetkili.FieldName).DataType, FieldByName(FMuhasebeYetkili.FieldName).Value);
//        FWebSitesi.Value := FormatedVariantVal(FieldByName(FWebSitesi.FieldName).DataType, FieldByName(FWebSitesi.FieldName).Value);
//        FePostaAdresi.Value := FormatedVariantVal(FieldByName(FePostaAdresi.FieldName).DataType, FieldByName(FePostaAdresi.FieldName).Value);
//        FOzelBilgi.Value := FormatedVariantVal(FieldByName(FOzelBilgi.FieldName).DataType, FieldByName(FOzelBilgi.FieldName).Value);
//        FOdemeVadeGunSayisi.Value := FormatedVariantVal(FieldByName(FOdemeVadeGunSayisi.FieldName).DataType, FieldByName(FOdemeVadeGunSayisi.FieldName).Value);
//        FIsAcikHesap.Value := FormatedVariantVal(FieldByName(FIsAcikHesap.FieldName).DataType, FieldByName(FIsAcikHesap.FieldName).Value);
//        FKrediLimiti.Value := FormatedVariantVal(FieldByName(FKrediLimiti.FieldName).DataType, FieldByName(FKrediLimiti.FieldName).Value);
//        FHesapIskonto.Value := FormatedVariantVal(FieldByName(FHesapIskonto.FieldName).DataType, FieldByName(FHesapIskonto.FieldName).Value);
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
        FMuhasebeKodu.FieldName,
        FHesapTipiID.FieldName,
        FHesapGrubuID.FieldName,
        FBolgeID.FieldName,
        FTemsilciGrubuId.FieldName,
        FMukellefTipiID.FieldName,
        FMusteriTemsilcisiID.FieldName,
        FAdresID.FieldName,
        FMukellefAdi.FieldName,
        FMukellefIkinciAdi.FieldName,
        FMukellefSoyadi.FieldName,
        FVergiDairesi.FieldName,
        FVergiNo.FieldName,
        FParaBirimi.FieldName,
        FIban.FieldName,
        FIbanPara.FieldName,
        FNaceKodu.FieldName,
        FIsEFaturaHesabi.FieldName,
        FEFaturaPKName.FieldName,
        FYetkili1.FieldName,
        FYetkili1Tel.FieldName,
        FYetkili2.FieldName,
        FYetkili2Tel.FieldName,
        FYetkili3.FieldName,
        FYetkili3Tel.FieldName,
        FFaks.FieldName,
        FMuhasebeTelefon.FieldName,
        FMuhasebeEPosta.FieldName,
        FMuhasebeYetkili.FieldName,
        FOzelBilgi.FieldName,
        FOdemeVadeGunSayisi.FieldName,
        FIsAcikHesap.FieldName,
        FKrediLimiti.FieldName,
        FHesapIskonto.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FHesapKodu);
      NewParamForQuery(QueryOfInsert, FHesapIsmi);
      NewParamForQuery(QueryOfInsert, FMuhasebeKodu);
      NewParamForQuery(QueryOfInsert, FHesapTipiID);
      NewParamForQuery(QueryOfInsert, FHesapGrubuID);
      NewParamForQuery(QueryOfInsert, FBolgeID);
      NewParamForQuery(QueryOfInsert, FTemsilciGrubuId);
      NewParamForQuery(QueryOfInsert, FMukellefTipiID);
      NewParamForQuery(QueryOfInsert, FMusteriTemsilcisiID);
      NewParamForQuery(QueryOfInsert, FAdresID);
      NewParamForQuery(QueryOfInsert, FMukellefAdi);
      NewParamForQuery(QueryOfInsert, FMukellefIkinciAdi);
      NewParamForQuery(QueryOfInsert, FMukellefSoyadi);
      NewParamForQuery(QueryOfInsert, FVergiDairesi);
      NewParamForQuery(QueryOfInsert, FVergiNo);
      NewParamForQuery(QueryOfInsert, FParaBirimi);
      NewParamForQuery(QueryOfInsert, FIban);
      NewParamForQuery(QueryOfInsert, FIbanPara);
      NewParamForQuery(QueryOfInsert, FNaceKodu);
      NewParamForQuery(QueryOfInsert, FIsEFaturaHesabi);
      NewParamForQuery(QueryOfInsert, FEFaturaPKName);
      NewParamForQuery(QueryOfInsert, FYetkili1);
      NewParamForQuery(QueryOfInsert, FYetkili1Tel);
      NewParamForQuery(QueryOfInsert, FYetkili2);
      NewParamForQuery(QueryOfInsert, FYetkili2Tel);
      NewParamForQuery(QueryOfInsert, FYetkili3);
      NewParamForQuery(QueryOfInsert, FYetkili3Tel);
      NewParamForQuery(QueryOfInsert, FFaks);
      NewParamForQuery(QueryOfInsert, FMuhasebeTelefon);
      NewParamForQuery(QueryOfInsert, FMuhasebeEPosta);
      NewParamForQuery(QueryOfInsert, FMuhasebeYetkili);
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
        FHesapKodu.FieldName,
        FHesapIsmi.FieldName,
        FMuhasebeKodu.FieldName,
        FHesapTipiID.FieldName,
        FHesapGrubuID.FieldName,
        FBolgeID.FieldName,
        FTemsilciGrubuId.FieldName,
        FMukellefTipiID.FieldName,
        FMusteriTemsilcisiID.FieldName,
        FAdresID.FieldName,
        FMukellefAdi.FieldName,
        FMukellefIkinciAdi.FieldName,
        FMukellefSoyadi.FieldName,
        FVergiDairesi.FieldName,
        FVergiNo.FieldName,
        FParaBirimi.FieldName,
        FIban.FieldName,
        FIbanPara.FieldName,
        FNaceKodu.FieldName,
        FIsEFaturaHesabi.FieldName,
        FEFaturaPKName.FieldName,
        FYetkili1.FieldName,
        FYetkili1Tel.FieldName,
        FYetkili2.FieldName,
        FYetkili2Tel.FieldName,
        FYetkili3.FieldName,
        FYetkili3Tel.FieldName,
        FFaks.FieldName,
        FMuhasebeTelefon.FieldName,
        FMuhasebeEPosta.FieldName,
        FMuhasebeYetkili.FieldName,
        FOzelBilgi.FieldName,
        FOdemeVadeGunSayisi.FieldName,
        FIsAcikHesap.FieldName,
        FKrediLimiti.FieldName,
        FHesapIskonto.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FHesapKodu);
      NewParamForQuery(QueryOfUpdate, FHesapIsmi);
      NewParamForQuery(QueryOfUpdate, FMuhasebeKodu);
      NewParamForQuery(QueryOfUpdate, FHesapTipiID);
      NewParamForQuery(QueryOfUpdate, FHesapGrubuID);
      NewParamForQuery(QueryOfUpdate, FBolgeID);
      NewParamForQuery(QueryOfUpdate, FTemsilciGrubuId);
      NewParamForQuery(QueryOfUpdate, FMukellefTipiID);
      NewParamForQuery(QueryOfUpdate, FMusteriTemsilcisiID);
      NewParamForQuery(QueryOfUpdate, FAdresID);
      NewParamForQuery(QueryOfUpdate, FMukellefAdi);
      NewParamForQuery(QueryOfUpdate, FMukellefIkinciAdi);
      NewParamForQuery(QueryOfUpdate, FMukellefSoyadi);
      NewParamForQuery(QueryOfUpdate, FVergiDairesi);
      NewParamForQuery(QueryOfUpdate, FVergiNo);
      NewParamForQuery(QueryOfUpdate, FParaBirimi);
      NewParamForQuery(QueryOfUpdate, FIban);
      NewParamForQuery(QueryOfUpdate, FIbanPara);
      NewParamForQuery(QueryOfUpdate, FNaceKodu);
      NewParamForQuery(QueryOfUpdate, FIsEFaturaHesabi);
      NewParamForQuery(QueryOfUpdate, FEFaturaPKName);
      NewParamForQuery(QueryOfUpdate, FYetkili1);
      NewParamForQuery(QueryOfUpdate, FYetkili1Tel);
      NewParamForQuery(QueryOfUpdate, FYetkili2);
      NewParamForQuery(QueryOfUpdate, FYetkili2Tel);
      NewParamForQuery(QueryOfUpdate, FYetkili3);
      NewParamForQuery(QueryOfUpdate, FYetkili3Tel);
      NewParamForQuery(QueryOfUpdate, FFaks);
      NewParamForQuery(QueryOfUpdate, FMuhasebeTelefon);
      NewParamForQuery(QueryOfUpdate, FMuhasebeEPosta);
      NewParamForQuery(QueryOfUpdate, FMuhasebeYetkili);
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

procedure THesapKarti.BusinessInsert(out pID: Integer; var pPermissionControl: Boolean);
begin
  Self.Adres.Insert(pID, False);
  Self.AdresID.Value := pID;
  Self.Insert(pID, pPermissionControl);
end;

procedure THesapKarti.BusinessSelect(pFilter: string; pLock, pPermissionControl: Boolean);
begin
  inherited;
end;

function THesapKarti.Clone():TTable;
begin
  Result := THesapKarti.Create(Database);

  Self.Id.Clone(THesapKarti(Result).Id);

  FHesapKodu.Clone(THesapKarti(Result).FHesapKodu);
  FHesapIsmi.Clone(THesapKarti(Result).FHesapIsmi);
  FMuhasebeKodu.Clone(THesapKarti(Result).FMuhasebeKodu);
  FHesapTipiID.Clone(THesapKarti(Result).FHesapTipiID);
  FHesapGrubuID.Clone(THesapKarti(Result).FHesapGrubuID);
  FBolgeID.Clone(THesapKarti(Result).FBolgeID);
  FTemsilciGrubuId.Clone(THesapKarti(Result).FTemsilciGrubuId);
  FMukellefTipiID.Clone(THesapKarti(Result).FMukellefTipiID);
  FMusteriTemsilcisiID.Clone(THesapKarti(Result).FMusteriTemsilcisiID);
  FAdresID.Clone(THesapKarti(Result).FAdresID);
  FMukellefAdi.Clone(THesapKarti(Result).FMukellefAdi);
  FMukellefIkinciAdi.Clone(THesapKarti(Result).FMukellefIkinciAdi);
  FMukellefSoyadi.Clone(THesapKarti(Result).FMukellefSoyadi);
  FVergiDairesi.Clone(THesapKarti(Result).FVergiDairesi);
  FVergiNo.Clone(THesapKarti(Result).FVergiNo);
  FParaBirimi.Clone(THesapKarti(Result).FParaBirimi);
  FIban.Clone(THesapKarti(Result).FIban);
  FIbanPara.Clone(THesapKarti(Result).FIbanPara);
  FNaceKodu.Clone(THesapKarti(Result).FNaceKodu);
  FIsEFaturaHesabi.Clone(THesapKarti(Result).FIsEFaturaHesabi);
  FEFaturaPKName.Clone(THesapKarti(Result).FEFaturaPKName);
  FYetkili1.Clone(THesapKarti(Result).FYetkili1);
  FYetkili1Tel.Clone(THesapKarti(Result).FYetkili1Tel);
  FYetkili2.Clone(THesapKarti(Result).FYetkili2);
  FYetkili2Tel.Clone(THesapKarti(Result).FYetkili2Tel);
  FYetkili3.Clone(THesapKarti(Result).FYetkili3);
  FYetkili3Tel.Clone(THesapKarti(Result).FYetkili3Tel);
  FFaks.Clone(THesapKarti(Result).FFaks);
  FMuhasebeTelefon.Clone(THesapKarti(Result).FMuhasebeTelefon);
  FMuhasebeEPosta.Clone(THesapKarti(Result).FMuhasebeEPosta);
  FMuhasebeYetkili.Clone(THesapKarti(Result).FMuhasebeYetkili);
  FOzelBilgi.Clone(THesapKarti(Result).FOzelBilgi);
  FOdemeVadeGunSayisi.Clone(THesapKarti(Result).FOdemeVadeGunSayisi);
  FIsAcikHesap.Clone(THesapKarti(Result).FIsAcikHesap);
  FKrediLimiti.Clone(THesapKarti(Result).FKrediLimiti);
  FHesapIskonto.Clone(THesapKarti(Result).FHesapIskonto);

  THesapKarti(Result).FAdres.SelectToList(' AND ' + FAdres.TableName + '.' + FAdres.Id.FieldName + '=' + VarToStr(FAdresID.Value), False, False);
end;

end.
