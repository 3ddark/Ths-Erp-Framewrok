unit Ths.Erp.Database.Table.PersonelKarti;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field,
  Ths.Erp.Database.Table.AyarPersonelTipi,
  Ths.Erp.Database.Table.AyarPersonelBolum,
  Ths.Erp.Database.Table.AyarPersonelBirim,
  Ths.Erp.Database.Table.AyarPersonelGorev,
  Ths.Erp.Database.Table.AyarPersonelCinsiyet,
  Ths.Erp.Database.Table.AyarPersonelAskerlikDurumu,
  Ths.Erp.Database.Table.AyarPersonelMedeniDurum,
  Ths.Erp.Database.Table.PersonelTasimaServisi;

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
    FPersonelTipi: TFieldDB;
    FBolumID: TFieldDB;
    FBolum: TFieldDB;
    FBirimID: TFieldDB;
    FBirim: TFieldDB;
    FGorevID: TFieldDB;
    FGorev: TFieldDB;
    FMailAdresi: TFieldDB;
    FDogumTarihi: TFieldDB;
    FKanGrubu: TFieldDB;
    FCinsiyetID: TFieldDB;
    FCinsiyet: TFieldDB;
    FAskerlikDurumID: TFieldDB;
    FAskerlikDurum: TFieldDB;
    FMedeniDurumID: TFieldDB;
    FMedeniDurum: TFieldDB;
    FCocukSayisi: TFieldDB;
    FYakinAdSoyad: TFieldDB;
    FYakinTelefon: TFieldDB;
    FEvAdresi: TFieldDB;
    FAyakkabiNo: TFieldDB;
    FElbiseBedeni: TFieldDB;
    FGenelNot: TFieldDB;
    FServisID: TFieldDB;
    FServis: TFieldDB;
    FOzelNot: TFieldDB;
    FBrutMaas: TFieldDB;
    FIkramiyeSayisi: TFieldDB;
    FIkramiyeMiktar: TFieldDB;
    FTCKimlikNo: TFieldDB;
  protected
    vAyarPersonelTipi: TAyarPersonelTipi;
    vAyarPersonelBolum: TAyarPersonelBolum;
    vAyarPersonelBirim: TAyarPersonelBirim;
    vAyarPersonelGorev: TAyarPersonelGorev;
    vAyarPersonelCinsiyet: TAyarPersonelCinsiyet;
    vAyarPersonelAskerlikDurumu: TAyarPersonelAskerlikDurumu;
    vAyarPersonelMedeniDurum: TAyarPersonelMedeniDurum;
    vAyarPersonelServis: TPersonelTasimaServis;
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property IsActive: TFieldDB read FIsActive write FIsActive;
    Property PersonelAd: TFieldDB read FPersonelAd write FPersonelAd;
    Property PersonelSoyad: TFieldDB read FPersonelSoyad write FPersonelSoyad;
    Property PersonelAdSoyad: TFieldDB read FPersonelAdSoyad write FPersonelAdSoyad;
    Property Telefon1: TFieldDB read FTelefon1 write FTelefon1;
    Property Telefon2: TFieldDB read FTelefon2 write FTelefon2;
    Property PersonelTipiID: TFieldDB read FPersonelTipiID write FPersonelTipiID;
    Property PersonelTipi: TFieldDB read FPersonelTipi write FPersonelTipi;
    Property BolumID: TFieldDB read FBolumID write FBolumID;
    Property Bolum: TFieldDB read FBolum write FBolum;
    Property BirimID: TFieldDB read FBirimID write FBirimID;
    Property Birim: TFieldDB read FBirim write FBirim;
    Property GorevID: TFieldDB read FGorevID write FGorevID;
    Property Gorev: TFieldDB read FGorev write FGorev;
    Property MailAdresi: TFieldDB read FMailAdresi write FMailAdresi;
    Property DogumTarihi: TFieldDB read FDogumTarihi write FDogumTarihi;
    Property KanGrubu: TFieldDB read FKanGrubu write FKanGrubu;
    Property CinsiyetID: TFieldDB read FCinsiyetID write FCinsiyetID;
    Property Cinsiyet: TFieldDB read FCinsiyet write FCinsiyet;
    Property AskerlikDurumID: TFieldDB read FAskerlikDurumID write FAskerlikDurumID;
    Property AskerlikDurum: TFieldDB read FAskerlikDurum write FAskerlikDurum;
    Property MedeniDurumID: TFieldDB read FMedeniDurumID write FMedeniDurumID;
    Property MedeniDurum: TFieldDB read FMedeniDurum write FMedeniDurum;
    Property CocukSayisi: TFieldDB read FCocukSayisi write FCocukSayisi;
    Property YakinAdSoyad: TFieldDB read FYakinAdSoyad write FYakinAdSoyad;
    Property YakinTelefon: TFieldDB read FYakinTelefon write FYakinTelefon;
    Property EvAdresi: TFieldDB read FEvAdresi write FEvAdresi;
    Property AyakkabiNo: TFieldDB read FAyakkabiNo write FAyakkabiNo;
    Property ElbiseBedeni: TFieldDB read FElbiseBedeni write FElbiseBedeni;
    Property GenelNot: TFieldDB read FGenelNot write FGenelNot;
    Property ServisID: TFieldDB read FServisID write FServisID;
    Property Servis: TFieldDB read FServis write FServis;
    Property OzelNot: TFieldDB read FOzelNot write FOzelNot;
    property BrutMaas: TFieldDB read FBrutMaas write FBrutMaas;
    property IkramiyeSayisi: TFieldDB read FIkramiyeSayisi write FIkramiyeSayisi;
    property IkramiyeMiktar: TFieldDB read FIkramiyeMiktar write FIkramiyeMiktar;
    property TCKimlikNo: TFieldDB read FTCKimlikNo write FTCKimlikNo;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TPersonelKarti.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'personel_karti';
  SourceCode := '1021';

  FIsActive := TFieldDB.Create('is_active', ftBoolean, 0);
  FPersonelAd := TFieldDB.Create('personel_ad', ftString, '');
  FPersonelSoyad := TFieldDB.Create('personel_soyad', ftString, '');
  FPersonelAdSoyad := TFieldDB.Create('personel_ad_soyad', ftString, '');
  FPersonelTipiID := TFieldDB.Create('personel_tipi_id', ftInteger, 0);
  FPersonelTipi := TFieldDB.Create('personel_tipi', ftString, '');
  FBolumID := TFieldDB.Create('bolum_id', ftInteger, '');
  FBolum := TFieldDB.Create('bolum', ftString, '');
  FBirimID := TFieldDB.Create('birim_id', ftInteger, '');
  FBirim := TFieldDB.Create('birim', ftString, '');
  FGorevID := TFieldDB.Create('gorev_id', ftInteger, '');
  FGorev := TFieldDB.Create('gorev', ftString, '');

  FTelefon1 := TFieldDB.Create('telefon1', ftString, '');
  FTelefon2 := TFieldDB.Create('telefon2', ftString, '');

  FMailAdresi := TFieldDB.Create('mail_adresi', ftString, '');
  FDogumTarihi := TFieldDB.Create('dogum_tarihi', ftDate, 0);
  FKanGrubu := TFieldDB.Create('kan_grubu', ftString, '');
  FCinsiyetID := TFieldDB.Create('cinsiyet_id', ftInteger, 0);
  FCinsiyet := TFieldDB.Create('cinsiyet', ftString, '');
  FAskerlikDurumID := TFieldDB.Create('askerlik_durum_id', ftInteger, '');
  FAskerlikDurum := TFieldDB.Create('askerlik_durum', ftString, '');
  FMedeniDurumID := TFieldDB.Create('medeni_durum_id', ftInteger, '');
  FMedeniDurum := TFieldDB.Create('medeni_durum', ftString, '');
  FCocukSayisi := TFieldDB.Create('cocuk_sayisi', ftInteger, 0);
  FYakinAdSoyad := TFieldDB.Create('yakin_ad_soyad', ftString, '');
  FYakinTelefon := TFieldDB.Create('yakin_telefon', ftString, '');
  FEvAdresi := TFieldDB.Create('ev_adresi', ftString, '');
  FAyakkabiNo := TFieldDB.Create('ayakkabi_no', ftInteger, '');
  FElbiseBedeni := TFieldDB.Create('elbise_bedeni', ftString, '');
  FGenelNot := TFieldDB.Create('genel_not', ftString, '');
  FServisID := TFieldDB.Create('servis_id', ftInteger, '');
  FServis := TFieldDB.Create('servis', ftString, '');
  FOzelNot := TFieldDB.Create('ozel_not', ftString, '');
  FBrutMaas := TFieldDB.Create('brut_maas', ftFloat, '');
  FIkramiyeSayisi := TFieldDB.Create('ikramiye_sayisi', ftInteger, '');
  FIkramiyeMiktar := TFieldDB.Create('ikramiye_miktar', ftFloat, '');
  FTCKimlikNo := TFieldDB.Create('tc_kimlik_no', ftString, '');
end;

procedure TPersonelKarti.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      vAyarPersonelTipi := TAyarPersonelTipi.Create(Database);
      vAyarPersonelBolum := TAyarPersonelBolum.Create(Database);
      vAyarPersonelBirim := TAyarPersonelBirim.Create(Database);
      vAyarPersonelGorev := TAyarPersonelGorev.Create(Database);
      vAyarPersonelCinsiyet := TAyarPersonelCinsiyet.Create(Database);
      vAyarPersonelAskerlikDurumu := TAyarPersonelAskerlikDurumu.Create(Database);
      vAyarPersonelMedeniDurum := TAyarPersonelMedeniDurum.Create(Database);
      vAyarPersonelServis := TPersonelTasimaServis.Create(Database);
      try
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FIsActive.FieldName,
          TableName + '.' + FPersonelAd.FieldName,
          TableName + '.' + FPersonelSoyad.FieldName,
          '(' + TableName + '.' + FPersonelAd.FieldName + ' || '' '' || ' + TableName + '.' + FPersonelSoyad.FieldName + ') AS ' + FPersonelAdSoyad.FieldName,
          TableName + '.' + FTelefon1.FieldName,
          TableName + '.' + FTelefon2.FieldName,
          TableName + '.' + FPersonelTipiID.FieldName,
          ColumnFromIDCol(vAyarPersonelTipi.Deger.FieldName, vAyarPersonelTipi.TableName, FPersonelTipiID.FieldName, FPersonelTipi.FieldName, TableName),
          TableName + '.' + FBolumID.FieldName,
          ColumnFromIDCol(vAyarPersonelBolum.Bolum.FieldName, vAyarPersonelBolum.TableName, FBolumID.FieldName, FBolum.FieldName, TableName),
          TableName + '.' + FBirimID.FieldName,
          ColumnFromIDCol(vAyarPersonelBirim.Birim.FieldName, vAyarPersonelBirim.TableName, FBirimID.FieldName, FBirim.FieldName, TableName),
          TableName + '.' + FGorevID.FieldName,
          ColumnFromIDCol(vAyarPersonelGorev.Gorev.FieldName, vAyarPersonelGorev.TableName, FGorevID.FieldName, FGorev.FieldName, TableName),
          TableName + '.' + FMailAdresi.FieldName,
          TableName + '.' + FDogumTarihi.FieldName,
          TableName + '.' + FKanGrubu.FieldName,
          TableName + '.' + FCinsiyetID.FieldName,
          ColumnFromIDCol(vAyarPersonelCinsiyet.Deger.FieldName, vAyarPersonelCinsiyet.TableName, FCinsiyetID.FieldName, FCinsiyet.FieldName, TableName),
          TableName + '.' + FAskerlikDurumID.FieldName,
          ColumnFromIDCol(vAyarPersonelAskerlikDurumu.Deger.FieldName, vAyarPersonelAskerlikDurumu.TableName, FAskerlikDurumID.FieldName, FAskerlikDurum.FieldName, TableName),
          TableName + '.' + FMedeniDurumID.FieldName,
          ColumnFromIDCol(vAyarPersonelMedeniDurum.Deger.FieldName, vAyarPersonelMedeniDurum.TableName, FMedeniDurumID.FieldName, FMedeniDurum.FieldName, TableName),
          TableName + '.' + FCocukSayisi.FieldName,
          TableName + '.' + FYakinAdSoyad.FieldName,
          TableName + '.' + FYakinTelefon.FieldName,
          TableName + '.' + FEvAdresi.FieldName,
          TableName + '.' + FAyakkabiNo.FieldName,
          TableName + '.' + FElbiseBedeni.FieldName,
          TableName + '.' + FGenelNot.FieldName,
          TableName + '.' + FServisID.FieldName,
          ColumnFromIDCol(vAyarPersonelServis.ServisAdi.FieldName, vAyarPersonelServis.TableName, FServisID.FieldName, FServis.FieldName, TableName),
          TableName + '.' + FOzelNot.FieldName,
          TableName + '.' + FBrutMaas.FieldName,
          TableName + '.' + FIkramiyeSayisi.FieldName,
          TableName + '.' + FIkramiyeMiktar.FieldName,
          TableName + '.' + FTCKimlikNo.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;
        Active := True;

        Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
        Self.DataSource.DataSet.FindField(FIsActive.FieldName).DisplayLabel := 'Aktif?';
        Self.DataSource.DataSet.FindField(FPersonelAd.FieldName).DisplayLabel := 'Personel Ad';
        Self.DataSource.DataSet.FindField(FPersonelSoyad.FieldName).DisplayLabel := 'Personel Soyad';
        Self.DataSource.DataSet.FindField(FPersonelAdSoyad.FieldName).DisplayLabel := 'Personel Ad Soyad';
        Self.DataSource.DataSet.FindField(FTelefon1.FieldName).DisplayLabel := 'Telefon 1';
        Self.DataSource.DataSet.FindField(FTelefon2.FieldName).DisplayLabel := 'Telefon 2';
        Self.DataSource.DataSet.FindField(FPersonelTipiID.FieldName).DisplayLabel := 'Telefon Tipi ID';
        Self.DataSource.DataSet.FindField(FPersonelTipi.FieldName).DisplayLabel := 'Personel Tipi';
        Self.DataSource.DataSet.FindField(FBolumID.FieldName).DisplayLabel := 'Bölüm ID';
        Self.DataSource.DataSet.FindField(FBolum.FieldName).DisplayLabel := 'Bölüm';
        Self.DataSource.DataSet.FindField(FBirimID.FieldName).DisplayLabel := 'Birim ID';
        Self.DataSource.DataSet.FindField(FBirim.FieldName).DisplayLabel := 'Birim';
        Self.DataSource.DataSet.FindField(FGorevID.FieldName).DisplayLabel := 'Görev ID';
        Self.DataSource.DataSet.FindField(FGorev.FieldName).DisplayLabel := 'Görev';
        Self.DataSource.DataSet.FindField(FMailAdresi.FieldName).DisplayLabel := 'e-Posta Adresi';
        Self.DataSource.DataSet.FindField(FDogumTarihi.FieldName).DisplayLabel := 'Doðum Tarihi';
        Self.DataSource.DataSet.FindField(FKanGrubu.FieldName).DisplayLabel := 'Kan Grubu';
        Self.DataSource.DataSet.FindField(FCinsiyetID.FieldName).DisplayLabel := 'Cinsiyet ID';
        Self.DataSource.DataSet.FindField(FCinsiyet.FieldName).DisplayLabel := 'Cinsiyet';
        Self.DataSource.DataSet.FindField(FAskerlikDurumID.FieldName).DisplayLabel := 'Askerlik Durumu ID';
        Self.DataSource.DataSet.FindField(FAskerlikDurum.FieldName).DisplayLabel := 'Askerlik Durumu';
        Self.DataSource.DataSet.FindField(FMedeniDurumID.FieldName).DisplayLabel := 'Medeni Durumu ID';
        Self.DataSource.DataSet.FindField(FMedeniDurum.FieldName).DisplayLabel := 'Medeni Durumu';
        Self.DataSource.DataSet.FindField(FCocukSayisi.FieldName).DisplayLabel := 'Çocuk Sayýsý';
        Self.DataSource.DataSet.FindField(FYakinAdSoyad.FieldName).DisplayLabel := 'Yakýn Ad-Soyad';
        Self.DataSource.DataSet.FindField(FYakinTelefon.FieldName).DisplayLabel := 'Yakýn Telefon';
        Self.DataSource.DataSet.FindField(FEvAdresi.FieldName).DisplayLabel := 'Ev Adresi';
        Self.DataSource.DataSet.FindField(FAyakkabiNo.FieldName).DisplayLabel := 'Ayakkabý No';
        Self.DataSource.DataSet.FindField(FElbiseBedeni.FieldName).DisplayLabel := 'Elbise Bedeni';
        Self.DataSource.DataSet.FindField(FGenelNot.FieldName).DisplayLabel := 'Genel Not';
        Self.DataSource.DataSet.FindField(FServisID.FieldName).DisplayLabel := 'Servis ID';
        Self.DataSource.DataSet.FindField(FServis.FieldName).DisplayLabel := 'Servis';
        Self.DataSource.DataSet.FindField(FOzelNot.FieldName).DisplayLabel := 'Özel Not';
        Self.DataSource.DataSet.FindField(FBrutMaas.FieldName).DisplayLabel := 'Brüt Maaþ';
        Self.DataSource.DataSet.FindField(FIkramiyeSayisi.FieldName).DisplayLabel := 'Ýkramiye Sayýsý';
        Self.DataSource.DataSet.FindField(FIkramiyeMiktar.FieldName).DisplayLabel := 'Ýkramiye Miktar';
        Self.DataSource.DataSet.FindField(FTCKimlikNo.FieldName).DisplayLabel := 'TC Kimlik No';
      finally
        vAyarPersonelTipi.Free;
        vAyarPersonelBolum.Free;
        vAyarPersonelBirim.Free;
        vAyarPersonelGorev.Free;
        vAyarPersonelCinsiyet.Free;
        vAyarPersonelAskerlikDurumu.Free;
        vAyarPersonelMedeniDurum.Free;
        vAyarPersonelServis.Free;
      end;
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
      vAyarPersonelTipi := TAyarPersonelTipi.Create(Database);
      vAyarPersonelBolum := TAyarPersonelBolum.Create(Database);
      vAyarPersonelBirim := TAyarPersonelBirim.Create(Database);
      vAyarPersonelGorev := TAyarPersonelGorev.Create(Database);
      vAyarPersonelCinsiyet := TAyarPersonelCinsiyet.Create(Database);
      vAyarPersonelAskerlikDurumu := TAyarPersonelAskerlikDurumu.Create(Database);
      vAyarPersonelMedeniDurum := TAyarPersonelMedeniDurum.Create(Database);
      vAyarPersonelServis := TPersonelTasimaServis.Create(Database);
      try
        Close;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FIsActive.FieldName,
          TableName + '.' + FPersonelAd.FieldName,
          TableName + '.' + FPersonelSoyad.FieldName,
          '(' + TableName + '.' + FPersonelAd.FieldName + ' || '' '' || ' + TableName + '.' + FPersonelSoyad.FieldName + ') AS ' + FPersonelAdSoyad.FieldName,
          TableName + '.' + FTelefon1.FieldName,
          TableName + '.' + FTelefon2.FieldName,
          TableName + '.' + FPersonelTipiID.FieldName,
          ColumnFromIDCol(vAyarPersonelTipi.Deger.FieldName, vAyarPersonelTipi.TableName, FPersonelTipiID.FieldName, FPersonelTipi.FieldName, TableName),
          TableName + '.' + FBolumID.FieldName,
          ColumnFromIDCol(vAyarPersonelBolum.Bolum.FieldName, vAyarPersonelBolum.TableName, FBolumID.FieldName, FBolum.FieldName, TableName),
          TableName + '.' + FBirimID.FieldName,
          ColumnFromIDCol(vAyarPersonelBirim.Birim.FieldName, vAyarPersonelBirim.TableName, FBirimID.FieldName, FBirim.FieldName, TableName),
          TableName + '.' + FGorevID.FieldName,
          ColumnFromIDCol(vAyarPersonelGorev.Gorev.FieldName, vAyarPersonelGorev.TableName, FGorevID.FieldName, FGorev.FieldName, TableName),
          TableName + '.' + FMailAdresi.FieldName,
          TableName + '.' + FDogumTarihi.FieldName,
          TableName + '.' + FKanGrubu.FieldName,
          TableName + '.' + FCinsiyetID.FieldName,
          ColumnFromIDCol(vAyarPersonelCinsiyet.Deger.FieldName, vAyarPersonelCinsiyet.TableName, FCinsiyetID.FieldName, FCinsiyet.FieldName, TableName),
          TableName + '.' + FAskerlikDurumID.FieldName,
          ColumnFromIDCol(vAyarPersonelAskerlikDurumu.Deger.FieldName, vAyarPersonelAskerlikDurumu.TableName, FAskerlikDurumID.FieldName, FAskerlikDurum.FieldName, TableName),
          TableName + '.' + FMedeniDurumID.FieldName,
          ColumnFromIDCol(vAyarPersonelMedeniDurum.Deger.FieldName, vAyarPersonelMedeniDurum.TableName, FMedeniDurumID.FieldName, FMedeniDurum.FieldName, TableName),
          TableName + '.' + FCocukSayisi.FieldName,
          TableName + '.' + FYakinAdSoyad.FieldName,
          TableName + '.' + FYakinTelefon.FieldName,
          TableName + '.' + FEvAdresi.FieldName,
          TableName + '.' + FAyakkabiNo.FieldName,
          TableName + '.' + FElbiseBedeni.FieldName,
          TableName + '.' + FGenelNot.FieldName,
          TableName + '.' + FServisID.FieldName,
          ColumnFromIDCol(vAyarPersonelServis.ServisAdi.FieldName, vAyarPersonelServis.TableName, FServisID.FieldName, FServis.FieldName, TableName),
          TableName + '.' + FOzelNot.FieldName,
          TableName + '.' + FBrutMaas.FieldName,
          TableName + '.' + FIkramiyeSayisi.FieldName,
          TableName + '.' + FIkramiyeMiktar.FieldName,
          TableName + '.' + FTCKimlikNo.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
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
          FPersonelTipi.Value := FormatedVariantVal(FieldByName(FPersonelTipi.FieldName).DataType, FieldByName(FPersonelTipi.FieldName).Value);
          FBolumID.Value := FormatedVariantVal(FieldByName(FBolumID.FieldName).DataType, FieldByName(FBolumID.FieldName).Value);
          FBolum.Value := FormatedVariantVal(FieldByName(FBolum.FieldName).DataType, FieldByName(FBolum.FieldName).Value);
          FBirimID.Value := FormatedVariantVal(FieldByName(FBirimID.FieldName).DataType, FieldByName(FBirimID.FieldName).Value);
          FBirim.Value := FormatedVariantVal(FieldByName(FBirim.FieldName).DataType, FieldByName(FBirim.FieldName).Value);
          FGorevID.Value := FormatedVariantVal(FieldByName(FGorevID.FieldName).DataType, FieldByName(FGorevID.FieldName).Value);
          FGorev.Value := FormatedVariantVal(FieldByName(FGorev.FieldName).DataType, FieldByName(FGorev.FieldName).Value);
          FMailAdresi.Value := FormatedVariantVal(FieldByName(FMailAdresi.FieldName).DataType, FieldByName(FMailAdresi.FieldName).Value);
          FDogumTarihi.Value := FormatedVariantVal(FieldByName(FDogumTarihi.FieldName).DataType, FieldByName(FDogumTarihi.FieldName).Value);
          FKanGrubu.Value := FormatedVariantVal(FieldByName(FKanGrubu.FieldName).DataType, FieldByName(FKanGrubu.FieldName).Value);
          FCinsiyetID.Value := FormatedVariantVal(FieldByName(FCinsiyetID.FieldName).DataType, FieldByName(FCinsiyetID.FieldName).Value);
          FCinsiyet.Value := FormatedVariantVal(FieldByName(FCinsiyet.FieldName).DataType, FieldByName(FCinsiyet.FieldName).Value);
          FAskerlikDurumID.Value := FormatedVariantVal(FieldByName(FAskerlikDurumID.FieldName).DataType, FieldByName(FAskerlikDurumID.FieldName).Value);
          FAskerlikDurum.Value := FormatedVariantVal(FieldByName(FAskerlikDurum.FieldName).DataType, FieldByName(FAskerlikDurum.FieldName).Value);
          FMedeniDurumID.Value := FormatedVariantVal(FieldByName(FMedeniDurumID.FieldName).DataType, FieldByName(FMedeniDurumID.FieldName).Value);
          FMedeniDurum.Value := FormatedVariantVal(FieldByName(FMedeniDurum.FieldName).DataType, FieldByName(FMedeniDurum.FieldName).Value);
          FCocukSayisi.Value := FormatedVariantVal(FieldByName(FCocukSayisi.FieldName).DataType, FieldByName(FCocukSayisi.FieldName).Value);
          FYakinAdSoyad.Value := FormatedVariantVal(FieldByName(FYakinAdSoyad.FieldName).DataType, FieldByName(FYakinAdSoyad.FieldName).Value);
          FYakinTelefon.Value := FormatedVariantVal(FieldByName(FYakinTelefon.FieldName).DataType, FieldByName(FYakinTelefon.FieldName).Value);
          FEvAdresi.Value := FormatedVariantVal(FieldByName(FEvAdresi.FieldName).DataType, FieldByName(FEvAdresi.FieldName).Value);
          FAyakkabiNo.Value := FormatedVariantVal(FieldByName(FAyakkabiNo.FieldName).DataType, FieldByName(FAyakkabiNo.FieldName).Value);
          FElbiseBedeni.Value := FormatedVariantVal(FieldByName(FElbiseBedeni.FieldName).DataType, FieldByName(FElbiseBedeni.FieldName).Value);
          FGenelNot.Value := FormatedVariantVal(FieldByName(FGenelNot.FieldName).DataType, FieldByName(FGenelNot.FieldName).Value);
          FServisID.Value := FormatedVariantVal(FieldByName(FServisID.FieldName).DataType, FieldByName(FServisID.FieldName).Value);
          FServis.Value := FormatedVariantVal(FieldByName(FServis.FieldName).DataType, FieldByName(FServis.FieldName).Value);
          FOzelNot.Value := FormatedVariantVal(FieldByName(FOzelNot.FieldName).DataType, FieldByName(FOzelNot.FieldName).Value);
          FBrutMaas.Value := FormatedVariantVal(FieldByName(FBrutMaas.FieldName).DataType, FieldByName(FBrutMaas.FieldName).Value);
          FIkramiyeSayisi.Value := FormatedVariantVal(FieldByName(FIkramiyeSayisi.FieldName).DataType, FieldByName(FIkramiyeSayisi.FieldName).Value);
          FIkramiyeMiktar.Value := FormatedVariantVal(FieldByName(FIkramiyeMiktar.FieldName).DataType, FieldByName(FIkramiyeMiktar.FieldName).Value);
          FTCKimlikNo.Value := FormatedVariantVal(FieldByName(FTCKimlikNo.FieldName).DataType, FieldByName(FTCKimlikNo.FieldName).Value);

          List.Add(Self.Clone());

          Next;
        end;
        Close;
      finally
        vAyarPersonelTipi.Free;
        vAyarPersonelBolum.Free;
        vAyarPersonelBirim.Free;
        vAyarPersonelGorev.Free;
        vAyarPersonelCinsiyet.Free;
        vAyarPersonelAskerlikDurumu.Free;
        vAyarPersonelMedeniDurum.Free;
        vAyarPersonelServis.Free;
      end;
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
        FEvAdresi.FieldName,
        FAyakkabiNo.FieldName,
        FElbiseBedeni.FieldName,
        FGenelNot.FieldName,
        FServisID.FieldName,
        FOzelNot.FieldName,
        FBrutMaas.FieldName,
        FIkramiyeSayisi.FieldName,
        FIkramiyeMiktar.FieldName,
        FTCKimlikNo.FieldName
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
      NewParamForQuery(QueryOfInsert, FEvAdresi);
      NewParamForQuery(QueryOfInsert, FAyakkabiNo);
      NewParamForQuery(QueryOfInsert, FElbiseBedeni);
      NewParamForQuery(QueryOfInsert, FGenelNot);
      NewParamForQuery(QueryOfInsert, FServisID);
      NewParamForQuery(QueryOfInsert, FOzelNot);
      NewParamForQuery(QueryOfInsert, FBrutMaas);
      NewParamForQuery(QueryOfInsert, FIkramiyeSayisi);
      NewParamForQuery(QueryOfInsert, FIkramiyeMiktar);
      NewParamForQuery(QueryOfInsert, FTCKimlikNo);
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
        FEvAdresi.FieldName,
        FAyakkabiNo.FieldName,
        FElbiseBedeni.FieldName,
        FGenelNot.FieldName,
        FServisID.FieldName,
        FOzelNot.FieldName,
        FBrutMaas.FieldName,
        FIkramiyeSayisi.FieldName,
        FIkramiyeMiktar.FieldName,
        FTCKimlikNo.FieldName
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
      NewParamForQuery(QueryOfUpdate, FEvAdresi);
      NewParamForQuery(QueryOfUpdate, FAyakkabiNo);
      NewParamForQuery(QueryOfUpdate, FElbiseBedeni);
      NewParamForQuery(QueryOfUpdate, FGenelNot);
      NewParamForQuery(QueryOfUpdate, FServisID);
      NewParamForQuery(QueryOfUpdate, FOzelNot);
      NewParamForQuery(QueryOfUpdate, FBrutMaas);
      NewParamForQuery(QueryOfUpdate, FIkramiyeSayisi);
      NewParamForQuery(QueryOfUpdate, FIkramiyeMiktar);
      NewParamForQuery(QueryOfUpdate, FTCKimlikNo);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TPersonelKarti.Clear();
begin
  inherited;

  FIsActive.Value := False;
  FPersonelAd.Value := '';
  FPersonelSoyad.Value := '';
  FPersonelAdSoyad.Value := '';
  FTelefon1.Value := '';
  FTelefon2.Value := '';
  FPersonelTipiID.Value := 0;
  FPersonelTipi.Value := '';
  FBolumID.Value := 0;
  FBolum.Value := '';
  FBirimID.Value := 0;
  FBirim.Value := '';
  FGorevID.Value := 0;
  FGorev.Value := '';
  FMailAdresi.Value := '';
  FDogumTarihi.Value := 0;
  FKanGrubu.Value := '';
  FCinsiyetID.Value := 0;
  FCinsiyet.Value := '';
  FAskerlikDurumID.Value := 0;
  FAskerlikDurum.Value := '';
  FMedeniDurumID.Value := 0;
  FMedeniDurum.Value := '';
  FCocukSayisi.Value := 0;
  FYakinAdSoyad.Value := '';
  FYakinTelefon.Value := '';
  FEvAdresi.Value := '';
  FAyakkabiNo.Value := 0;
  FElbiseBedeni.Value := '';
  FGenelNot.Value := '';
  FServisID.Value := 0;
  FServis.Value := '';
  FOzelNot.Value := '';
  FBrutMaas.Value := 0;
  FIkramiyeSayisi.Value := 0;
  FIkramiyeMiktar.Value := 0;
  FTCKimlikNo.Value := '';
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
  FPersonelTipi.Clone(TPersonelKarti(Result).FPersonelTipi);
  FBolumID.Clone(TPersonelKarti(Result).FBolumID);
  FBolum.Clone(TPersonelKarti(Result).FBolum);
  FBirimID.Clone(TPersonelKarti(Result).FBirimID);
  FBirim.Clone(TPersonelKarti(Result).FBirim);
  FGorevID.Clone(TPersonelKarti(Result).FGorevID);
  FGorev.Clone(TPersonelKarti(Result).FGorev);
  FMailAdresi.Clone(TPersonelKarti(Result).FMailAdresi);
  FDogumTarihi.Clone(TPersonelKarti(Result).FDogumTarihi);
  FKanGrubu.Clone(TPersonelKarti(Result).FKanGrubu);
  FCinsiyetID.Clone(TPersonelKarti(Result).FCinsiyetID);
  FCinsiyet.Clone(TPersonelKarti(Result).FCinsiyet);
  FAskerlikDurumID.Clone(TPersonelKarti(Result).FAskerlikDurumID);
  FAskerlikDurum.Clone(TPersonelKarti(Result).FAskerlikDurum);
  FMedeniDurumID.Clone(TPersonelKarti(Result).FMedeniDurumID);
  FMedeniDurum.Clone(TPersonelKarti(Result).FMedeniDurum);
  FCocukSayisi.Clone(TPersonelKarti(Result).FCocukSayisi);
  FYakinAdSoyad.Clone(TPersonelKarti(Result).FYakinAdSoyad);
  FYakinTelefon.Clone(TPersonelKarti(Result).FYakinTelefon);
  FEvAdresi.Clone(TPersonelKarti(Result).FEvAdresi);
  FAyakkabiNo.Clone(TPersonelKarti(Result).FAyakkabiNo);
  FElbiseBedeni.Clone(TPersonelKarti(Result).FElbiseBedeni);
  FGenelNot.Clone(TPersonelKarti(Result).FGenelNot);
  FServisID.Clone(TPersonelKarti(Result).FServisID);
  FServis.Clone(TPersonelKarti(Result).FServis);
  FOzelNot.Clone(TPersonelKarti(Result).FOzelNot);
  FBrutMaas.Clone(TPersonelKarti(Result).FBrutMaas);
  FIkramiyeSayisi.Clone(TPersonelKarti(Result).FIkramiyeSayisi);
  FIkramiyeMiktar.Clone(TPersonelKarti(Result).FIkramiyeMiktar);
  FTCKimlikNo.Clone(TPersonelKarti(Result).FTCKimlikNo);
end;

end.
