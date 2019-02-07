unit Ths.Erp.Database.Table.PersonelKarti;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  System.Variants, FireDAC.Stan.Param, FireDAC.Stan.Option, Data.DB,
  System.Rtti,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.AyarPrsPersonelTipi,
  Ths.Erp.Database.Table.AyarPrsBolum,
  Ths.Erp.Database.Table.AyarPrsBirim,
  Ths.Erp.Database.Table.AyarPrsGorev,
  Ths.Erp.Database.Table.AyarPrsCinsiyet,
  Ths.Erp.Database.Table.AyarPrsAskerlikDurumu,
  Ths.Erp.Database.Table.AyarPrsMedeniDurum,
  Ths.Erp.Database.Table.PersonelTasimaServisi,
  Ths.Erp.Database.Table.Adres,
  Ths.Erp.Database.Table.Ulke,
  Ths.Erp.Database.Table.Sehir;

type
  TPersonelKarti = class(TTable)
  private
    FIsActive: TFieldDB;
    FPersonelAd: TFieldDB;
    FPersonelSoyad: TFieldDB;
    FPersonelAdSoyad: TFieldDB;
    FTelefon1: TFieldDB;
    FTelefon2: TFieldDB;
    FPersonelTipiID: TFieldDB;
    FBolumID: TFieldDB;
    FBirimID: TFieldDB;
    FGorevID: TFieldDB;
    FMailAdresi: TFieldDB;
    FDogumTarihi: TFieldDB;
    FKanGrubu: TFieldDB;
    FCinsiyetID: TFieldDB;
    FAskerlikDurumID: TFieldDB;
    FMedeniDurumID: TFieldDB;
    FCocukSayisi: TFieldDB;
    FYakinAdSoyad: TFieldDB;
    FYakinTelefon: TFieldDB;
    FAyakkabiNo: TFieldDB;
    FElbiseBedeni: TFieldDB;
    FGenelNot: TFieldDB;
    FServisID: TFieldDB;
    FOzelNot: TFieldDB;
    FBrutMaas: TFieldDB;
    FIkramiyeSayisi: TFieldDB;
    FIkramiyeMiktar: TFieldDB;
    FTCKimlikNo: TFieldDB;
    FAdresID: TFieldDB;
    FAdres: TAdres;
  protected
    procedure BusinessInsert(out pID: Integer; var pPermissionControl: Boolean); override;
    procedure BusinessSelect(pFilter: string; pLock: Boolean; pPermissionControl: Boolean); override;
    procedure BusinessDelete(pPermissionControl: Boolean); override;
    procedure BusinessUpdate(pPermissionControl: Boolean); override;
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property IsActive: TFieldDB read FIsActive write FIsActive;
    Property PersonelAd: TFieldDB read FPersonelAd write FPersonelAd;
    Property PersonelSoyad: TFieldDB read FPersonelSoyad write FPersonelSoyad;
    Property PersonelAdSoyad: TFieldDB read FPersonelAdSoyad write FPersonelAdSoyad;
    Property Telefon1: TFieldDB read FTelefon1 write FTelefon1;
    Property Telefon2: TFieldDB read FTelefon2 write FTelefon2;
    Property PersonelTipiID: TFieldDB read FPersonelTipiID write FPersonelTipiID;
    Property BolumID: TFieldDB read FBolumID write FBolumID;
    Property BirimID: TFieldDB read FBirimID write FBirimID;
    Property GorevID: TFieldDB read FGorevID write FGorevID;
    Property MailAdresi: TFieldDB read FMailAdresi write FMailAdresi;
    Property DogumTarihi: TFieldDB read FDogumTarihi write FDogumTarihi;
    Property KanGrubu: TFieldDB read FKanGrubu write FKanGrubu;
    Property CinsiyetID: TFieldDB read FCinsiyetID write FCinsiyetID;
    Property AskerlikDurumID: TFieldDB read FAskerlikDurumID write FAskerlikDurumID;
    Property MedeniDurumID: TFieldDB read FMedeniDurumID write FMedeniDurumID;
    Property CocukSayisi: TFieldDB read FCocukSayisi write FCocukSayisi;
    Property YakinAdSoyad: TFieldDB read FYakinAdSoyad write FYakinAdSoyad;
    Property YakinTelefon: TFieldDB read FYakinTelefon write FYakinTelefon;
    Property AyakkabiNo: TFieldDB read FAyakkabiNo write FAyakkabiNo;
    Property ElbiseBedeni: TFieldDB read FElbiseBedeni write FElbiseBedeni;
    Property GenelNot: TFieldDB read FGenelNot write FGenelNot;
    Property ServisID: TFieldDB read FServisID write FServisID;
    Property OzelNot: TFieldDB read FOzelNot write FOzelNot;
    property BrutMaas: TFieldDB read FBrutMaas write FBrutMaas;
    property IkramiyeSayisi: TFieldDB read FIkramiyeSayisi write FIkramiyeSayisi;
    property IkramiyeMiktar: TFieldDB read FIkramiyeMiktar write FIkramiyeMiktar;
    property TCKimlikNo: TFieldDB read FTCKimlikNo write FTCKimlikNo;
    Property AdresID: TFieldDB read FAdresID write FAdresID;
    Property Adres: TAdres read FAdres write FAdres;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TPersonelKarti.Create(OwnerDatabase:TDatabase);
begin
  TableName := 'personel_karti';
  SourceCode := '1021';

  inherited Create(OwnerDatabase);

  FIsActive := TFieldDB.Create('is_active', ftBoolean, True, 0, False, False);
  FPersonelAd := TFieldDB.Create('personel_ad', ftString, '', 0, False, False);
  FPersonelSoyad := TFieldDB.Create('personel_soyad', ftString, '', 0, False, False);
  FPersonelAdSoyad := TFieldDB.Create('personel_ad_soyad', ftString, '', 0, False, False);

  FPersonelTipiID := TFieldDB.Create('personel_tipi_id', ftInteger, 0, 0, True, False);
  FPersonelTipiID.FK.FKTable := TAyarPrsPersonelTipi.Create(Database);
  FPersonelTipiID.FK.FKCol := TFieldDB.Create(TAyarPrsPersonelTipi(FPersonelTipiID.FK.FKTable).PersonelTipi.FieldName, TAyarPrsPersonelTipi(FPersonelTipiID.FK.FKTable).PersonelTipi.FieldType, '');

  FBolumID := TFieldDB.Create('bolum_id', ftInteger, 0, 0, True, False);
  FBolumID.FK.FKTable := TAyarPrsBolum.Create(Database);
  FBolumID.FK.FKCol := TFieldDB.Create(TAyarPrsBolum(FBolumID.FK.FKTable).Bolum.FieldName, TAyarPrsBolum(FBolumID.FK.FKTable).Bolum.FieldType, '');

  FBirimID := TFieldDB.Create('birim_id', ftInteger, 0, 0, True, False);
  FBirimID.FK.FKTable := TAyarPrsBirim.Create(Database);
  FBirimID.FK.FKCol := TFieldDB.Create(TAyarPrsBirim(FBirimID.FK.FKTable).Birim.FieldName, TAyarPrsBirim(FBirimID.FK.FKTable).Birim.FieldType, '');

  FGorevID := TFieldDB.Create('gorev_id', ftInteger, 0, 0, True, False);
  FGorevID.FK.FKTable := TAyarPrsGorev.Create(Database);
  FGorevID.FK.FKCol := TFieldDB.Create(TAyarPrsGorev(FGorevID.FK.FKTable).Gorev.FieldName, TAyarPrsGorev(FGorevID.FK.FKTable).Gorev.FieldType, '');

  FTelefon1 := TFieldDB.Create('telefon1', ftString, '', 0, False, False);
  FTelefon2 := TFieldDB.Create('telefon2', ftString, '', 0, False, False);
  FMailAdresi := TFieldDB.Create('mail_adresi', ftString, '', 0, False, False);
  FDogumTarihi := TFieldDB.Create('dogum_tarihi', ftDate, 0, 0, False, False);
  FKanGrubu := TFieldDB.Create('kan_grubu', ftString, '', 0, False, False);

  FCinsiyetID := TFieldDB.Create('cinsiyet_id', ftInteger, 0, 0, True, False);
  FCinsiyetID.FK.FKTable := TAyarPrsCinsiyet.Create(Database);
  FCinsiyetID.FK.FKCol := TFieldDB.Create(TAyarPrsCinsiyet(FCinsiyetID.FK.FKTable).Cinsiyet.FieldName, TAyarPrsCinsiyet(FCinsiyetID.FK.FKTable).Cinsiyet.FieldType, '');

  FAskerlikDurumID := TFieldDB.Create('askerlik_durum_id', ftInteger, 0, 0, True, False);
  FAskerlikDurumID.FK.FKTable := TAyarPrsAskerlikDurumu.Create(Database);
  FAskerlikDurumID.FK.FKCol := TFieldDB.Create(TAyarPrsAskerlikDurumu(FAskerlikDurumID.FK.FKTable).AskerlikDurumu.FieldName, TAyarPrsAskerlikDurumu(FAskerlikDurumID.FK.FKTable).AskerlikDurumu.FieldType, '');

  FMedeniDurumID := TFieldDB.Create('medeni_durum_id', ftInteger, 0, 0, True, False);
  FMedeniDurumID.FK.FKTable := TAyarPrsMedeniDurum.Create(Database);
  FMedeniDurumID.FK.FKCol := TFieldDB.Create(TAyarPrsMedeniDurum(FMedeniDurumID.FK.FKTable).MedeniDurum.FieldName, TAyarPrsMedeniDurum(FMedeniDurumID.FK.FKTable).MedeniDurum.FieldType, '');

  FCocukSayisi := TFieldDB.Create('cocuk_sayisi', ftInteger, 0, 0, False, False);
  FYakinAdSoyad := TFieldDB.Create('yakin_ad_soyad', ftString, '', 0, False, False);
  FYakinTelefon := TFieldDB.Create('yakin_telefon', ftString, '', 0, False, False);
  FAyakkabiNo := TFieldDB.Create('ayakkabi_no', ftInteger, 0, 0, False, False);
  FElbiseBedeni := TFieldDB.Create('elbise_bedeni', ftString, '', 0, False, False);
  FGenelNot := TFieldDB.Create('genel_not', ftString, '', 0, False, False);

  FServisID := TFieldDB.Create('servis_id', ftInteger, 0, 0, True);
  FServisID.FK.FKTable := TPersonelTasimaServis.Create(Database);
  FServisID.FK.FKCol := TFieldDB.Create(TPersonelTasimaServis(FServisID.FK.FKTable).ServisAdi.FieldName, TPersonelTasimaServis(FServisID.FK.FKTable).ServisAdi.FieldType, '');

  FOzelNot := TFieldDB.Create('ozel_not', ftString, '', 0, False, False);
  FBrutMaas := TFieldDB.Create('brut_maas', ftFloat, 0, 0, False, False);
  FIkramiyeSayisi := TFieldDB.Create('ikramiye_sayisi', ftInteger, 0, 0, False, False);
  FIkramiyeMiktar := TFieldDB.Create('ikramiye_miktar', ftFloat, 0, 0, False, False);
  FTCKimlikNo := TFieldDB.Create('tc_kimlik_no', ftString, '', 0, False, False);
  FAdresID := TFieldDB.Create('adres_id', ftInteger, 0, 0, False, False);

  FAdres := TAdres.Create(Database);
end;

procedure TPersonelKarti.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName + ', ' + FAdres.TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FIsActive.FieldName,
        TableName + '.' + FPersonelAd.FieldName,
        TableName + '.' + FPersonelSoyad.FieldName,
        '(concat(' + TableName + '.' + FPersonelAd.FieldName + ', '' '', ' + TableName + '.' + FPersonelSoyad.FieldName + '))::varchar(64) AS ' + FPersonelAdSoyad.FieldName,
        TableName + '.' + FTelefon1.FieldName,
        TableName + '.' + FTelefon2.FieldName,
        TableName + '.' + FPersonelTipiID.FieldName,
        ColumnFromIDCol(TAyarPrsPersonelTipi(FPersonelTipiID.FK.FKTable).PersonelTipi.FieldName, FPersonelTipiID.FK.FKTable.TableName, FPersonelTipiID.FieldName, FPersonelTipiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FBolumID.FieldName,
        ColumnFromIDCol(TAyarPrsBolum(FBolumID.FK.FKTable).Bolum.FieldName, FBolumID.FK.FKTable.TableName, FBolumID.FieldName, FBolumID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FBirimID.FieldName,
        ColumnFromIDCol(TAyarPrsBirim(FBirimID.FK.FKTable).Birim.FieldName, FBirimID.FK.FKTable.TableName, FBirimID.FieldName, FBirimID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FGorevID.FieldName,
        ColumnFromIDCol(TAyarPrsGorev(FGorevID.FK.FKTable).Gorev.FieldName, FGorevID.FK.FKTable.TableName, FGorevID.FieldName, FGorevID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FMailAdresi.FieldName,
        TableName + '.' + FDogumTarihi.FieldName,
        TableName + '.' + FKanGrubu.FieldName,
        TableName + '.' + FCinsiyetID.FieldName,
        ColumnFromIDCol(TAyarPrsCinsiyet(FCinsiyetID.FK.FKTable).Cinsiyet.FieldName, FCinsiyetID.FK.FKTable.TableName, FCinsiyetID.FieldName, FCinsiyetID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FAskerlikDurumID.FieldName,
        ColumnFromIDCol(TAyarPrsAskerlikDurumu(FAskerlikDurumID.FK.FKTable).AskerlikDurumu.FieldName, FAskerlikDurumID.FK.FKTable.TableName, FAskerlikDurumID.FieldName, FAskerlikDurumID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FMedeniDurumID.FieldName,
        ColumnFromIDCol(TAyarPrsMedeniDurum(FMedeniDurumID.FK.FKTable).MedeniDurum.FieldName, FMedeniDurumID.FK.FKTable.TableName, FMedeniDurumID.FieldName, FMedeniDurumID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FCocukSayisi.FieldName,
        TableName + '.' + FYakinAdSoyad.FieldName,
        TableName + '.' + FYakinTelefon.FieldName,
        TableName + '.' + FAyakkabiNo.FieldName,
        TableName + '.' + FElbiseBedeni.FieldName,
        TableName + '.' + FGenelNot.FieldName,
        TableName + '.' + FServisID.FieldName,
        ColumnFromIDCol(TPersonelTasimaServis(FServisID.FK.FKTable).ServisAdi.FieldName, FServisID.FK.FKTable.TableName, FServisID.FieldName, FServisID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FOzelNot.FieldName,
        TableName + '.' + FBrutMaas.FieldName,
        TableName + '.' + FIkramiyeSayisi.FieldName,
        TableName + '.' + FIkramiyeMiktar.FieldName,
        TableName + '.' + FTCKimlikNo.FieldName,
        TableName + '.' + FAdresID.FieldName,
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
      'WHERE adres_id=adres.id ' + pFilter;

      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FIsActive.FieldName).DisplayLabel := 'Aktif?';
      Self.DataSource.DataSet.FindField(FPersonelAd.FieldName).DisplayLabel := 'Personel Ad';
      Self.DataSource.DataSet.FindField(FPersonelSoyad.FieldName).DisplayLabel := 'Personel Soyad';
      Self.DataSource.DataSet.FindField(FPersonelAdSoyad.FieldName).DisplayLabel := 'Personel Ad Soyad';
      Self.DataSource.DataSet.FindField(FTelefon1.FieldName).DisplayLabel := 'Telefon 1';
      Self.DataSource.DataSet.FindField(FTelefon2.FieldName).DisplayLabel := 'Telefon 2';
      Self.DataSource.DataSet.FindField(FPersonelTipiID.FieldName).DisplayLabel := 'Personel Tipi ID';
      Self.DataSource.DataSet.FindField(FPersonelTipiID.FK.FKCol.FieldName).DisplayLabel := 'Personel Tipi';
      Self.DataSource.DataSet.FindField(FBolumID.FieldName).DisplayLabel := 'Bölüm ID';
      Self.DataSource.DataSet.FindField(FBolumID.FK.FKCol.FieldName).DisplayLabel := 'Bölüm';
      Self.DataSource.DataSet.FindField(FBirimID.FieldName).DisplayLabel := 'Birim ID';
      Self.DataSource.DataSet.FindField(FBirimID.FK.FKCol.FieldName).DisplayLabel := 'Birim';
      Self.DataSource.DataSet.FindField(FGorevID.FieldName).DisplayLabel := 'Görev ID';
      Self.DataSource.DataSet.FindField(FGorevID.FK.FKCol.FieldName).DisplayLabel := 'Görev';
      Self.DataSource.DataSet.FindField(FMailAdresi.FieldName).DisplayLabel := 'e-Posta Adresi';
      Self.DataSource.DataSet.FindField(FDogumTarihi.FieldName).DisplayLabel := 'Doðum Tarihi';
      Self.DataSource.DataSet.FindField(FKanGrubu.FieldName).DisplayLabel := 'Kan Grubu';
      Self.DataSource.DataSet.FindField(FCinsiyetID.FieldName).DisplayLabel := 'Cinsiyet ID';
      Self.DataSource.DataSet.FindField(FCinsiyetID.FK.FKCol.FieldName).DisplayLabel := 'Cinsiyet';
      Self.DataSource.DataSet.FindField(FAskerlikDurumID.FieldName).DisplayLabel := 'Askerlik Durumu ID';
      Self.DataSource.DataSet.FindField(FAskerlikDurumID.FK.FKCol.FieldName).DisplayLabel := 'Askerlik Durumu';
      Self.DataSource.DataSet.FindField(FMedeniDurumID.FieldName).DisplayLabel := 'Medeni Durumu ID';
      Self.DataSource.DataSet.FindField(FMedeniDurumID.FK.FKCol.FieldName).DisplayLabel := 'Medeni Durumu';
      Self.DataSource.DataSet.FindField(FCocukSayisi.FieldName).DisplayLabel := 'Çocuk Sayýsý';
      Self.DataSource.DataSet.FindField(FYakinAdSoyad.FieldName).DisplayLabel := 'Yakýn Ad-Soyad';
      Self.DataSource.DataSet.FindField(FYakinTelefon.FieldName).DisplayLabel := 'Yakýn Telefon';
      Self.DataSource.DataSet.FindField(FAyakkabiNo.FieldName).DisplayLabel := 'Ayakkabý No';
      Self.DataSource.DataSet.FindField(FElbiseBedeni.FieldName).DisplayLabel := 'Elbise Bedeni';
      Self.DataSource.DataSet.FindField(FGenelNot.FieldName).DisplayLabel := 'Genel Not';
      Self.DataSource.DataSet.FindField(FServisID.FieldName).DisplayLabel := 'Servis ID';
      Self.DataSource.DataSet.FindField(FServisID.FK.FKCol.FieldName).DisplayLabel := 'Servis';
      Self.DataSource.DataSet.FindField(FOzelNot.FieldName).DisplayLabel := 'Özel Not';
      Self.DataSource.DataSet.FindField(FBrutMaas.FieldName).DisplayLabel := 'Brüt Maaþ';
      Self.DataSource.DataSet.FindField(FIkramiyeSayisi.FieldName).DisplayLabel := 'Ýkramiye Sayýsý';
      Self.DataSource.DataSet.FindField(FIkramiyeMiktar.FieldName).DisplayLabel := 'Ýkramiye Miktar';
      Self.DataSource.DataSet.FindField(FTCKimlikNo.FieldName).DisplayLabel := 'TC Kimlik No';
      Self.DataSource.DataSet.FindField(FAdresID.FieldName).DisplayLabel := 'Adres ID';
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

procedure TPersonelKarti.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
      pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

    with QueryOfList do
    begin
      Close;
      SQL.Text := Database.GetSQLSelectCmd(TableName + ', ' + FAdres.TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FIsActive.FieldName,
        TableName + '.' + FPersonelAd.FieldName,
        TableName + '.' + FPersonelSoyad.FieldName,
        '(' + TableName + '.' + FPersonelAd.FieldName + ' || '' '' || ' + TableName + '.' + FPersonelSoyad.FieldName + ')::varchar(64) AS ' + FPersonelAdSoyad.FieldName,
        TableName + '.' + FTelefon1.FieldName,
        TableName + '.' + FTelefon2.FieldName,
        TableName + '.' + FPersonelTipiID.FieldName,
        ColumnFromIDCol(TAyarPrsPersonelTipi(FPersonelTipiID.FK.FKTable).PersonelTipi.FieldName, FPersonelTipiID.FK.FKTable.TableName, FPersonelTipiID.FieldName, FPersonelTipiID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FBolumID.FieldName,
        ColumnFromIDCol(TAyarPrsBolum(FBolumID.FK.FKTable).Bolum.FieldName, FBolumID.FK.FKTable.TableName, FBolumID.FieldName, FBolumID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FBirimID.FieldName,
        ColumnFromIDCol(TAyarPrsBirim(FBirimID.FK.FKTable).Birim.FieldName, FBirimID.FK.FKTable.TableName, FBirimID.FieldName, FBirimID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FGorevID.FieldName,
        ColumnFromIDCol(TAyarPrsGorev(FGorevID.FK.FKTable).Gorev.FieldName, FGorevID.FK.FKTable.TableName, FGorevID.FieldName, FGorevID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FMailAdresi.FieldName,
        TableName + '.' + FDogumTarihi.FieldName,
        TableName + '.' + FKanGrubu.FieldName,
        TableName + '.' + FCinsiyetID.FieldName,
        ColumnFromIDCol(TAyarPrsCinsiyet(FCinsiyetID.FK.FKTable).Cinsiyet.FieldName, FCinsiyetID.FK.FKTable.TableName, FCinsiyetID.FieldName, FCinsiyetID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FAskerlikDurumID.FieldName,
        ColumnFromIDCol(TAyarPrsAskerlikDurumu(FAskerlikDurumID.FK.FKTable).AskerlikDurumu.FieldName, FAskerlikDurumID.FK.FKTable.TableName, FAskerlikDurumID.FieldName, FAskerlikDurumID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FMedeniDurumID.FieldName,
        ColumnFromIDCol(TAyarPrsMedeniDurum(FMedeniDurumID.FK.FKTable).MedeniDurum.FieldName, FMedeniDurumID.FK.FKTable.TableName, FMedeniDurumID.FieldName, FMedeniDurumID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FCocukSayisi.FieldName,
        TableName + '.' + FYakinAdSoyad.FieldName,
        TableName + '.' + FYakinTelefon.FieldName,
        TableName + '.' + FAyakkabiNo.FieldName,
        TableName + '.' + FElbiseBedeni.FieldName,
        TableName + '.' + FGenelNot.FieldName,
        TableName + '.' + FServisID.FieldName,
        ColumnFromIDCol(TPersonelTasimaServis(FServisID.FK.FKTable).ServisAdi.FieldName, FServisID.FK.FKTable.TableName, FServisID.FieldName, FServisID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FOzelNot.FieldName,
        TableName + '.' + FBrutMaas.FieldName,
        TableName + '.' + FIkramiyeSayisi.FieldName,
        TableName + '.' + FIkramiyeMiktar.FieldName,
        TableName + '.' + FTCKimlikNo.FieldName,
        TableName + '.' + FAdresID.FieldName,
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
      'WHERE adres_id=adres.id ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);
        FIsActive.Value := FormatedVariantVal(FieldByName(FIsActive.FieldName).DataType, FieldByName(FIsActive.FieldName).Value);
        FPersonelAd.Value := FormatedVariantVal(FieldByName(FPersonelAd.FieldName).DataType, FieldByName(FPersonelAd.FieldName).Value);
        FPersonelSoyad.Value := FormatedVariantVal(FieldByName(FPersonelSoyad.FieldName).DataType, FieldByName(FPersonelSoyad.FieldName).Value);
        FPersonelAdSoyad.Value := FormatedVariantVal(FieldByName(FPersonelAdSoyad.FieldName).DataType, FieldByName(FPersonelAdSoyad.FieldName).Value);
        FTelefon1.Value := FormatedVariantVal(FieldByName(FTelefon1.FieldName).DataType, FieldByName(FTelefon1.FieldName).Value);
        FTelefon2.Value := FormatedVariantVal(FieldByName(FTelefon2.FieldName).DataType, FieldByName(FTelefon2.FieldName).Value);
        FPersonelTipiID.Value := FormatedVariantVal(FieldByName(FPersonelTipiID.FieldName).DataType, FieldByName(FPersonelTipiID.FieldName).Value);
        FPersonelTipiID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FPersonelTipiID.FK.FKCol.FieldName).DataType, FieldByName(FPersonelTipiID.FK.FKCol.FieldName).Value);
        FBolumID.Value := FormatedVariantVal(FieldByName(FBolumID.FieldName).DataType, FieldByName(FBolumID.FieldName).Value);
        FBolumID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FBolumID.FK.FKCol.FieldName).DataType, FieldByName(FBolumID.FK.FKCol.FieldName).Value);
        FBirimID.Value := FormatedVariantVal(FieldByName(FBirimID.FieldName).DataType, FieldByName(FBirimID.FieldName).Value);
        FBirimID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FBirimID.FK.FKCol.FieldName).DataType, FieldByName(FBirimID.FK.FKCol.FieldName).Value);
        FGorevID.Value := FormatedVariantVal(FieldByName(FGorevID.FieldName).DataType, FieldByName(FGorevID.FieldName).Value);
        FGorevID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FGorevID.FK.FKCol.FieldName).DataType, FieldByName(FGorevID.FK.FKCol.FieldName).Value);
        FMailAdresi.Value := FormatedVariantVal(FieldByName(FMailAdresi.FieldName).DataType, FieldByName(FMailAdresi.FieldName).Value);
        FDogumTarihi.Value := FormatedVariantVal(FieldByName(FDogumTarihi.FieldName).DataType, FieldByName(FDogumTarihi.FieldName).Value);
        FKanGrubu.Value := FormatedVariantVal(FieldByName(FKanGrubu.FieldName).DataType, FieldByName(FKanGrubu.FieldName).Value);
        FCinsiyetID.Value := FormatedVariantVal(FieldByName(FCinsiyetID.FieldName).DataType, FieldByName(FCinsiyetID.FieldName).Value);
        FCinsiyetID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FCinsiyetID.FK.FKCol.FieldName).DataType, FieldByName(FCinsiyetID.FK.FKCol.FieldName).Value);
        FAskerlikDurumID.Value := FormatedVariantVal(FieldByName(FAskerlikDurumID.FieldName).DataType, FieldByName(FAskerlikDurumID.FieldName).Value);
        FAskerlikDurumID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FAskerlikDurumID.FK.FKCol.FieldName).DataType, FieldByName(FAskerlikDurumID.FK.FKCol.FieldName).Value);
        FMedeniDurumID.Value := FormatedVariantVal(FieldByName(FMedeniDurumID.FieldName).DataType, FieldByName(FMedeniDurumID.FieldName).Value);
        FMedeniDurumID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FMedeniDurumID.FK.FKCol.FieldName).DataType, FieldByName(FMedeniDurumID.FK.FKCol.FieldName).Value);
        FCocukSayisi.Value := FormatedVariantVal(FieldByName(FCocukSayisi.FieldName).DataType, FieldByName(FCocukSayisi.FieldName).Value);
        FYakinAdSoyad.Value := FormatedVariantVal(FieldByName(FYakinAdSoyad.FieldName).DataType, FieldByName(FYakinAdSoyad.FieldName).Value);
        FYakinTelefon.Value := FormatedVariantVal(FieldByName(FYakinTelefon.FieldName).DataType, FieldByName(FYakinTelefon.FieldName).Value);
        FAyakkabiNo.Value := FormatedVariantVal(FieldByName(FAyakkabiNo.FieldName).DataType, FieldByName(FAyakkabiNo.FieldName).Value);
        FElbiseBedeni.Value := FormatedVariantVal(FieldByName(FElbiseBedeni.FieldName).DataType, FieldByName(FElbiseBedeni.FieldName).Value);
        FGenelNot.Value := FormatedVariantVal(FieldByName(FGenelNot.FieldName).DataType, FieldByName(FGenelNot.FieldName).Value);
        FServisID.Value := FormatedVariantVal(FieldByName(FServisID.FieldName).DataType, FieldByName(FServisID.FieldName).Value);
        FServisID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FServisID.FK.FKCol.FieldName).DataType, FieldByName(FServisID.FK.FKCol.FieldName).Value);
        FOzelNot.Value := FormatedVariantVal(FieldByName(FOzelNot.FieldName).DataType, FieldByName(FOzelNot.FieldName).Value);
        FBrutMaas.Value := FormatedVariantVal(FieldByName(FBrutMaas.FieldName).DataType, FieldByName(FBrutMaas.FieldName).Value);
        FIkramiyeSayisi.Value := FormatedVariantVal(FieldByName(FIkramiyeSayisi.FieldName).DataType, FieldByName(FIkramiyeSayisi.FieldName).Value);
        FIkramiyeMiktar.Value := FormatedVariantVal(FieldByName(FIkramiyeMiktar.FieldName).DataType, FieldByName(FIkramiyeMiktar.FieldName).Value);
        FTCKimlikNo.Value := FormatedVariantVal(FieldByName(FTCKimlikNo.FieldName).DataType, FieldByName(FTCKimlikNo.FieldName).Value);
        FAdresID.Value := FormatedVariantVal(FieldByName(FAdresID.FieldName).DataType, FieldByName(FAdresID.FieldName).Value);

        FAdres.UlkeID.Value := FormatedVariantVal(FieldByName(FAdres.UlkeID.FieldName).DataType, FieldByName(FAdres.UlkeID.FieldName).Value);
        FAdres.UlkeID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FAdres.UlkeID.FK.FKCol.FieldName).DataType, FieldByName(FAdres.UlkeID.FK.FKCol.FieldName).Value);
        FAdres.SehirID.Value := FormatedVariantVal(FieldByName(FAdres.SehirID.FieldName).DataType, FieldByName(FAdres.SehirID.FieldName).Value);
        FAdres.SehirID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FAdres.SehirID.FK.FKCol.FieldName).DataType, FieldByName(FAdres.SehirID.FK.FKCol.FieldName).Value);
        FAdres.Ilce.Value := FormatedVariantVal(FieldByName(FAdres.Ilce.FieldName).DataType, FieldByName(FAdres.Ilce.FieldName).Value);
        FAdres.Mahalle.Value := FormatedVariantVal(FieldByName(FAdres.Mahalle.FieldName).DataType, FieldByName(FAdres.Mahalle.FieldName).Value);
        FAdres.Cadde.Value := FormatedVariantVal(FieldByName(FAdres.Cadde.FieldName).DataType, FieldByName(FAdres.Cadde.FieldName).Value);
        FAdres.Sokak.Value := FormatedVariantVal(FieldByName(FAdres.Sokak.FieldName).DataType, FieldByName(FAdres.Sokak.FieldName).Value);
        FAdres.Bina.Value := FormatedVariantVal(FieldByName(FAdres.Bina.FieldName).DataType, FieldByName(FAdres.Bina.FieldName).Value);
        FAdres.KapiNo.Value := FormatedVariantVal(FieldByName(FAdres.KapiNo.FieldName).DataType, FieldByName(FAdres.KapiNo.FieldName).Value);
        FAdres.PostaKutusu.Value := FormatedVariantVal(FieldByName(FAdres.PostaKutusu.FieldName).DataType, FieldByName(FAdres.PostaKutusu.FieldName).Value);
        FAdres.PostaKodu.Value := FormatedVariantVal(FieldByName(FAdres.PostaKodu.FieldName).DataType, FieldByName(FAdres.PostaKodu.FieldName).Value);
        FAdres.WebSitesi.Value := FormatedVariantVal(FieldByName(FAdres.WebSitesi.FieldName).DataType, FieldByName(FAdres.WebSitesi.FieldName).Value);
        FAdres.ePostaAdresi.Value := FormatedVariantVal(FieldByName(FAdres.ePostaAdresi.FieldName).DataType, FieldByName(FAdres.ePostaAdresi.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TPersonelKarti.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FIsActive.FieldName,
        FPersonelAd.FieldName,
        FPersonelSoyad.FieldName,
        FTelefon1.FieldName,
        FTelefon2.FieldName,
        FPersonelTipiID.FieldName,
        FBolumID.FieldName,
        FBirimID.FieldName,
        FGorevID.FieldName,
        FMailAdresi.FieldName,
        FDogumTarihi.FieldName,
        FKanGrubu.FieldName,
        FCinsiyetID.FieldName,
        FAskerlikDurumID.FieldName,
        FMedeniDurumID.FieldName,
        FCocukSayisi.FieldName,
        FYakinAdSoyad.FieldName,
        FYakinTelefon.FieldName,
        FAyakkabiNo.FieldName,
        FElbiseBedeni.FieldName,
        FGenelNot.FieldName,
        FServisID.FieldName,
        FOzelNot.FieldName,
        FBrutMaas.FieldName,
        FIkramiyeSayisi.FieldName,
        FIkramiyeMiktar.FieldName,
        FTCKimlikNo.FieldName,
        FAdresID.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FIsActive);
      NewParamForQuery(QueryOfInsert, FPersonelAd);
      NewParamForQuery(QueryOfInsert, FPersonelSoyad);
      NewParamForQuery(QueryOfInsert, FTelefon1);
      NewParamForQuery(QueryOfInsert, FTelefon2);
      NewParamForQuery(QueryOfInsert, FPersonelTipiID);
      NewParamForQuery(QueryOfInsert, FBolumID);
      NewParamForQuery(QueryOfInsert, FBirimID);
      NewParamForQuery(QueryOfInsert, FGorevID);
      NewParamForQuery(QueryOfInsert, FMailAdresi);
      NewParamForQuery(QueryOfInsert, FDogumTarihi);
      NewParamForQuery(QueryOfInsert, FKanGrubu);
      NewParamForQuery(QueryOfInsert, FCinsiyetID);
      NewParamForQuery(QueryOfInsert, FAskerlikDurumID);
      NewParamForQuery(QueryOfInsert, FMedeniDurumID);
      NewParamForQuery(QueryOfInsert, FCocukSayisi);
      NewParamForQuery(QueryOfInsert, FYakinAdSoyad);
      NewParamForQuery(QueryOfInsert, FYakinTelefon);
      NewParamForQuery(QueryOfInsert, FAyakkabiNo);
      NewParamForQuery(QueryOfInsert, FElbiseBedeni);
      NewParamForQuery(QueryOfInsert, FGenelNot);
      NewParamForQuery(QueryOfInsert, FServisID);
      NewParamForQuery(QueryOfInsert, FOzelNot);
      NewParamForQuery(QueryOfInsert, FBrutMaas);
      NewParamForQuery(QueryOfInsert, FIkramiyeSayisi);
      NewParamForQuery(QueryOfInsert, FIkramiyeMiktar);
      NewParamForQuery(QueryOfInsert, FTCKimlikNo);
      NewParamForQuery(QueryOfInsert, FAdresID);

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

procedure TPersonelKarti.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FIsActive.FieldName,
        FPersonelAd.FieldName,
        FPersonelSoyad.FieldName,
        FTelefon1.FieldName,
        FTelefon2.FieldName,
        FPersonelTipiID.FieldName,
        FBolumID.FieldName,
        FBirimID.FieldName,
        FGorevID.FieldName,
        FMailAdresi.FieldName,
        FDogumTarihi.FieldName,
        FKanGrubu.FieldName,
        FCinsiyetID.FieldName,
        FAskerlikDurumID.FieldName,
        FMedeniDurumID.FieldName,
        FCocukSayisi.FieldName,
        FYakinAdSoyad.FieldName,
        FYakinTelefon.FieldName,
        FAyakkabiNo.FieldName,
        FElbiseBedeni.FieldName,
        FGenelNot.FieldName,
        FServisID.FieldName,
        FOzelNot.FieldName,
        FBrutMaas.FieldName,
        FIkramiyeSayisi.FieldName,
        FIkramiyeMiktar.FieldName,
        FTCKimlikNo.FieldName,
        FAdresID.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FIsActive);
      NewParamForQuery(QueryOfUpdate, FPersonelAd);
      NewParamForQuery(QueryOfUpdate, FPersonelSoyad);
      NewParamForQuery(QueryOfUpdate, FTelefon1);
      NewParamForQuery(QueryOfUpdate, FTelefon2);
      NewParamForQuery(QueryOfUpdate, FPersonelTipiID);
      NewParamForQuery(QueryOfUpdate, FBolumID);
      NewParamForQuery(QueryOfUpdate, FBirimID);
      NewParamForQuery(QueryOfUpdate, FGorevID);
      NewParamForQuery(QueryOfUpdate, FMailAdresi);
      NewParamForQuery(QueryOfUpdate, FDogumTarihi);
      NewParamForQuery(QueryOfUpdate, FKanGrubu);
      NewParamForQuery(QueryOfUpdate, FCinsiyetID);
      NewParamForQuery(QueryOfUpdate, FAskerlikDurumID);
      NewParamForQuery(QueryOfUpdate, FMedeniDurumID);
      NewParamForQuery(QueryOfUpdate, FCocukSayisi);
      NewParamForQuery(QueryOfUpdate, FYakinAdSoyad);
      NewParamForQuery(QueryOfUpdate, FYakinTelefon);
      NewParamForQuery(QueryOfUpdate, FAyakkabiNo);
      NewParamForQuery(QueryOfUpdate, FElbiseBedeni);
      NewParamForQuery(QueryOfUpdate, FGenelNot);
      NewParamForQuery(QueryOfUpdate, FServisID);
      NewParamForQuery(QueryOfUpdate, FOzelNot);
      NewParamForQuery(QueryOfUpdate, FBrutMaas);
      NewParamForQuery(QueryOfUpdate, FIkramiyeSayisi);
      NewParamForQuery(QueryOfUpdate, FIkramiyeMiktar);
      NewParamForQuery(QueryOfUpdate, FTCKimlikNo);
      NewParamForQuery(QueryOfUpdate, FAdresID);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.Notify;
  end;
end;

procedure TPersonelKarti.BusinessDelete(pPermissionControl: Boolean);
begin
  Self.Adres.Delete(False);
  inherited;
end;

procedure TPersonelKarti.BusinessInsert(out pID: Integer; var pPermissionControl: Boolean);
begin
  Self.Adres.SpInsert.ExecProc;
  Self.AdresID.Value := Self.Adres.SpInsert.ParamByName('result').AsInteger;
  Self.SpInsert.ExecProc;
  pID := Self.SpInsert.ParamByName('result').AsInteger;

  Self.Adres.Insert(pID, False);
  Self.AdresID.Value := pID;
  Self.Insert(pID, pPermissionControl);
end;

procedure TPersonelKarti.BusinessSelect(pFilter: string; pLock, pPermissionControl: Boolean);
var
  n1: Integer;
begin
  inherited;
  for n1 := 0 to Self.List.Count-1 do
  begin
    TPersonelKarti(Self.List[n1]).Adres.SelectToList(' AND ' + FAdres.TableName + '.' + FAdres.Id.FieldName + '=' + VarToStr(TPersonelKarti(Self.List[n1]).FAdresID.Value), False, False);
  end;
end;

procedure TPersonelKarti.BusinessUpdate(pPermissionControl: Boolean);
begin
  Self.Adres.Update(False);
  Self.Update(pPermissionControl);
end;

function TPersonelKarti.Clone():TTable;
begin
  Result := TPersonelKarti.Create(Database);

  Self.Id.Clone(TPersonelKarti(Result).Id);

  FIsActive.Clone(TPersonelKarti(Result).FIsActive);
  FPersonelAd.Clone(TPersonelKarti(Result).FPersonelAd);
  FPersonelSoyad.Clone(TPersonelKarti(Result).FPersonelSoyad);
  FPersonelAdSoyad.Clone(TPersonelKarti(Result).FPersonelAdSoyad);
  FTelefon1.Clone(TPersonelKarti(Result).FTelefon1);
  FTelefon2.Clone(TPersonelKarti(Result).FTelefon2);
  FPersonelTipiID.Clone(TPersonelKarti(Result).FPersonelTipiID);
  FBolumID.Clone(TPersonelKarti(Result).FBolumID);
  FBirimID.Clone(TPersonelKarti(Result).FBirimID);
  FGorevID.Clone(TPersonelKarti(Result).FGorevID);
  FMailAdresi.Clone(TPersonelKarti(Result).FMailAdresi);
  FDogumTarihi.Clone(TPersonelKarti(Result).FDogumTarihi);
  FKanGrubu.Clone(TPersonelKarti(Result).FKanGrubu);
  FCinsiyetID.Clone(TPersonelKarti(Result).FCinsiyetID);
  FAskerlikDurumID.Clone(TPersonelKarti(Result).FAskerlikDurumID);
  FMedeniDurumID.Clone(TPersonelKarti(Result).FMedeniDurumID);
  FCocukSayisi.Clone(TPersonelKarti(Result).FCocukSayisi);
  FYakinAdSoyad.Clone(TPersonelKarti(Result).FYakinAdSoyad);
  FYakinTelefon.Clone(TPersonelKarti(Result).FYakinTelefon);
  FAyakkabiNo.Clone(TPersonelKarti(Result).FAyakkabiNo);
  FElbiseBedeni.Clone(TPersonelKarti(Result).FElbiseBedeni);
  FGenelNot.Clone(TPersonelKarti(Result).FGenelNot);
  FServisID.Clone(TPersonelKarti(Result).FServisID);
  FOzelNot.Clone(TPersonelKarti(Result).FOzelNot);
  FBrutMaas.Clone(TPersonelKarti(Result).FBrutMaas);
  FIkramiyeSayisi.Clone(TPersonelKarti(Result).FIkramiyeSayisi);
  FIkramiyeMiktar.Clone(TPersonelKarti(Result).FIkramiyeMiktar);
  FTCKimlikNo.Clone(TPersonelKarti(Result).FTCKimlikNo);
  FAdresID.Clone(TPersonelKarti(Result).FAdresID);

  TPersonelKarti(Result).FAdres.SelectToList(' AND ' + FAdres.TableName + '.' + FAdres.Id.FieldName + '=' + VarToStr(FAdresID.Value), False, False);
end;

end.
