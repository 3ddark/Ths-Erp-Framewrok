unit Ths.Erp.Database.Table.PersonelBilgisi;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TPersonelBilgisi = class(TTable)
  private
    FIsActive: TFieldDB;
    FPersonelAd: TFieldDB;
    FPersonelSoyad: TFieldDB;
    FTelefon1: TFieldDB;
    FTelefon2: TFieldDB;
    FPersonelTipiID: TFieldDB;
    FPersonelTipi: TFieldDB;
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
    FAskerlikDurumu: TFieldDB;
    FMedeniDurumuID: TFieldDB;
    FMedeniDurumu: TFieldDB;
    FCocukSayisi: TFieldDB;
    FYakinAdSoyad: TFieldDB;
    FYakinTelefon: TFieldDB;
    FEvAdresi: TFieldDB;
  protected
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
    Property Telefon1: TFieldDB read FTelefon1 write FTelefon1;
    Property Telefon2: TFieldDB read FTelefon2 write FTelefon2;
    Property PersonelTipiID: TFieldDB read FPersonelTipiID write FPersonelTipiID;
    Property PersonelTipi: TFieldDB read FPersonelTipi write FPersonelTipi;
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
    Property AskerlikDurumu: TFieldDB read FAskerlikDurumu write FAskerlikDurumu;
    Property MedeniDurumuID: TFieldDB read FMedeniDurumuID write FMedeniDurumuID;
    Property MedeniDurumu: TFieldDB read FMedeniDurumu write FMedeniDurumu;
    Property CocukSayisi: TFieldDB read FCocukSayisi write FCocukSayisi;
    Property YakinAdSoyad: TFieldDB read FYakinAdSoyad write FYakinAdSoyad;
    Property YakinTelefon: TFieldDB read FYakinTelefon write FYakinTelefon;
    Property EvAdresi: TFieldDB read FEvAdresi write FEvAdresi;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TPersonelBilgisi.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'personel_bilgisi';
  SourceCode := '1021';

  FIsActive := TFieldDB.Create('is_active', ftBoolean, 0);
  FPersonelAd := TFieldDB.Create('personel_ad', ftString, '');
  FPersonelSoyad := TFieldDB.Create('personel_soyad', ftString, '');
  FTelefon1 := TFieldDB.Create('telefon1', ftString, '');
  FTelefon2 := TFieldDB.Create('telefon2', ftString, '');
  FPersonelTipiID := TFieldDB.Create('personel_tipi_id', ftInteger, 0);
  FPersonelTipi := TFieldDB.Create('personel_tipi', ftString, '');
  FBolum := TFieldDB.Create('bolum', ftString, '');
  FBirimID := TFieldDB.Create('birim_id', ftString, '');
  FBirim := TFieldDB.Create('birim', ftString, '');
  FGorevID := TFieldDB.Create('gorev_id', ftString, '');
  FGorev := TFieldDB.Create('gorev', ftString, '');
  FMailAdresi := TFieldDB.Create('mail_adresi', ftString, '');
  FDogumTarihi := TFieldDB.Create('dogum_tarihi', ftDate, 0);
  FKanGrubu := TFieldDB.Create('kan_grubu', ftString, '');
  FCinsiyetID := TFieldDB.Create('cinsiyet_id', ftInteger, 0);
  FCinsiyet := TFieldDB.Create('cinsiyet', ftString, '');
  FAskerlikDurumID := TFieldDB.Create('askerlik_durumu_id', ftString, '');
  FAskerlikDurumu := TFieldDB.Create('askerlik_durumu', ftString, '');
  FMedeniDurumuID := TFieldDB.Create('medeni_durumu_id', ftString, '');
  FMedeniDurumu := TFieldDB.Create('medeni_durumu', ftString, '');
  FCocukSayisi := TFieldDB.Create('cocuk_sayisi', ftInteger, 0);
  FYakinAdSoyad := TFieldDB.Create('Yakýn Ad Soyad', ftString, '');
  FYakinTelefon := TFieldDB.Create('yakin_telefon', ftString, '');
  FEvAdresi := TFieldDB.Create('ev_adresi', ftString, '');
end;

procedure TPersonelBilgisi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FIsActive.FieldName,
        TableName + '.' + FPersonelAd.FieldName,
        TableName + '.' + FPersonelSoyad.FieldName,
        TableName + '.' + FTelefon1.FieldName,
        TableName + '.' + FTelefon2.FieldName,
        TableName + '.' + FPersonelTipiID.FieldName,
        TableName + '.' + FPersonelTipi.FieldName,
        TableName + '.' + FBolum.FieldName,
        TableName + '.' + FBirimID.FieldName,
        TableName + '.' + FBirim.FieldName,
        TableName + '.' + FGorevID.FieldName,
        TableName + '.' + FGorev.FieldName,
        TableName + '.' + FMailAdresi.FieldName,
        TableName + '.' + FDogumTarihi.FieldName,
        TableName + '.' + FKanGrubu.FieldName,
        TableName + '.' + FCinsiyetID.FieldName,
        TableName + '.' + FCinsiyet.FieldName,
        TableName + '.' + FAskerlikDurumID.FieldName,
        TableName + '.' + FAskerlikDurumu.FieldName,
        TableName + '.' + FMedeniDurumuID.FieldName,
        TableName + '.' + FMedeniDurumu.FieldName,
        TableName + '.' + FCocukSayisi.FieldName,
        TableName + '.' + FYakinAdSoyad.FieldName,
        TableName + '.' + FYakinTelefon.FieldName,
        TableName + '.' + FEvAdresi.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FIsActive.FieldName).DisplayLabel := 'Aktif?';
      Self.DataSource.DataSet.FindField(FPersonelAd.FieldName).DisplayLabel := 'Personel Ad';
      Self.DataSource.DataSet.FindField(FPersonelSoyad.FieldName).DisplayLabel := 'Personel Soyad';
      Self.DataSource.DataSet.FindField(FTelefon1.FieldName).DisplayLabel := 'Telefon 1';
      Self.DataSource.DataSet.FindField(FTelefon2.FieldName).DisplayLabel := 'Telefon 2';
      Self.DataSource.DataSet.FindField(FPersonelTipiID.FieldName).DisplayLabel := 'Telefon Tipi ID';
      Self.DataSource.DataSet.FindField(FPersonelTipi.FieldName).DisplayLabel := 'Personel Tipi';
      Self.DataSource.DataSet.FindField(FBolum.FieldName).DisplayLabel := 'Bölüm';
      Self.DataSource.DataSet.FindField(FBirimID.FieldName).DisplayLabel := 'Birim ID';
      Self.DataSource.DataSet.FindField(FBirim.FieldName).DisplayLabel := 'Birim';
      Self.DataSource.DataSet.FindField(FGorevID.FieldName).DisplayLabel := 'Görev';
      Self.DataSource.DataSet.FindField(FGorev.FieldName).DisplayLabel := 'Görev';
      Self.DataSource.DataSet.FindField(FMailAdresi.FieldName).DisplayLabel := 'e-Posta Adresi';
      Self.DataSource.DataSet.FindField(FDogumTarihi.FieldName).DisplayLabel := 'Doðum Tarihi';
      Self.DataSource.DataSet.FindField(FKanGrubu.FieldName).DisplayLabel := 'Kan Grubu';
      Self.DataSource.DataSet.FindField(FCinsiyetID.FieldName).DisplayLabel := 'Cinsiyet ID';
      Self.DataSource.DataSet.FindField(FCinsiyet.FieldName).DisplayLabel := 'Cinsiyet';
      Self.DataSource.DataSet.FindField(FAskerlikDurumID.FieldName).DisplayLabel := 'Askerlik Durumu ID';
      Self.DataSource.DataSet.FindField(FAskerlikDurumu.FieldName).DisplayLabel := 'Askerlik Durumu';
      Self.DataSource.DataSet.FindField(FMedeniDurumuID.FieldName).DisplayLabel := 'Medeni Durumu ID';
      Self.DataSource.DataSet.FindField(FMedeniDurumu.FieldName).DisplayLabel := 'Medeni Durumu';
      Self.DataSource.DataSet.FindField(FCocukSayisi.FieldName).DisplayLabel := 'Çocuk Sayýsý';
      Self.DataSource.DataSet.FindField(FYakinAdSoyad.FieldName).DisplayLabel := 'Yakýn Ad-Soyad';
      Self.DataSource.DataSet.FindField(FYakinTelefon.FieldName).DisplayLabel := 'Yakýn Telefon';
      Self.DataSource.DataSet.FindField(FEvAdresi.FieldName).DisplayLabel := 'Ev Adresi';
    end;
  end;
end;

procedure TPersonelBilgisi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
      pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

    with QueryOfTable do
    begin
      Close;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FIsActive.FieldName,
        TableName + '.' + FPersonelAd.FieldName,
        TableName + '.' + FPersonelSoyad.FieldName,
        TableName + '.' + FTelefon1.FieldName,
        TableName + '.' + FTelefon2.FieldName,
        TableName + '.' + FPersonelTipiID.FieldName,
        TableName + '.' + FPersonelTipi.FieldName,
        TableName + '.' + FBolum.FieldName,
        TableName + '.' + FBirimID.FieldName,
        TableName + '.' + FBirim.FieldName,
        TableName + '.' + FGorevID.FieldName,
        TableName + '.' + FGorev.FieldName,
        TableName + '.' + FMailAdresi.FieldName,
        TableName + '.' + FDogumTarihi.FieldName,
        TableName + '.' + FKanGrubu.FieldName,
        TableName + '.' + FCinsiyetID.FieldName,
        TableName + '.' + FCinsiyet.FieldName,
        TableName + '.' + FAskerlikDurumID.FieldName,
        TableName + '.' + FAskerlikDurumu.FieldName,
        TableName + '.' + FMedeniDurumuID.FieldName,
        TableName + '.' + FMedeniDurumu.FieldName,
        TableName + '.' + FCocukSayisi.FieldName,
        TableName + '.' + FYakinAdSoyad.FieldName,
        TableName + '.' + FYakinTelefon.FieldName,
        TableName + '.' + FEvAdresi.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := GetVarToFormatedValue(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FIsActive.Value := GetVarToFormatedValue(FieldByName(FIsActive.FieldName).DataType, FieldByName(FIsActive.FieldName).Value);
        FPersonelAd.Value := GetVarToFormatedValue(FieldByName(FPersonelAd.FieldName).DataType, FieldByName(FPersonelAd.FieldName).Value);
        FPersonelSoyad.Value := GetVarToFormatedValue(FieldByName(FPersonelSoyad.FieldName).DataType, FieldByName(FPersonelSoyad.FieldName).Value);
        FTelefon1.Value := GetVarToFormatedValue(FieldByName(FTelefon1.FieldName).DataType, FieldByName(FTelefon1.FieldName).Value);
        FTelefon2.Value := GetVarToFormatedValue(FieldByName(FTelefon2.FieldName).DataType, FieldByName(FTelefon2.FieldName).Value);
        FPersonelTipiID.Value := GetVarToFormatedValue(FieldByName(FPersonelTipiID.FieldName).DataType, FieldByName(FPersonelTipiID.FieldName).Value);
        FPersonelTipi.Value := GetVarToFormatedValue(FieldByName(FPersonelTipi.FieldName).DataType, FieldByName(FPersonelTipi.FieldName).Value);
        FBolum.Value := GetVarToFormatedValue(FieldByName(FBolum.FieldName).DataType, FieldByName(FBolum.FieldName).Value);
        FBirimID.Value := GetVarToFormatedValue(FieldByName(FBirimID.FieldName).DataType, FieldByName(FBirimID.FieldName).Value);
        FBirim.Value := GetVarToFormatedValue(FieldByName(FBirim.FieldName).DataType, FieldByName(FBirim.FieldName).Value);
        FGorevID.Value := GetVarToFormatedValue(FieldByName(FGorevID.FieldName).DataType, FieldByName(FGorevID.FieldName).Value);
        FGorev.Value := GetVarToFormatedValue(FieldByName(FGorev.FieldName).DataType, FieldByName(FGorev.FieldName).Value);
        FMailAdresi.Value := GetVarToFormatedValue(FieldByName(FMailAdresi.FieldName).DataType, FieldByName(FMailAdresi.FieldName).Value);
        FDogumTarihi.Value := GetVarToFormatedValue(FieldByName(FDogumTarihi.FieldName).DataType, FieldByName(FDogumTarihi.FieldName).Value);
        FKanGrubu.Value := GetVarToFormatedValue(FieldByName(FKanGrubu.FieldName).DataType, FieldByName(FKanGrubu.FieldName).Value);
        FCinsiyetID.Value := GetVarToFormatedValue(FieldByName(FCinsiyetID.FieldName).DataType, FieldByName(FCinsiyetID.FieldName).Value);
        FCinsiyet.Value := GetVarToFormatedValue(FieldByName(FCinsiyet.FieldName).DataType, FieldByName(FCinsiyet.FieldName).Value);
        FAskerlikDurumID.Value := GetVarToFormatedValue(FieldByName(FAskerlikDurumID.FieldName).DataType, FieldByName(FAskerlikDurumID.FieldName).Value);
        FAskerlikDurumu.Value := GetVarToFormatedValue(FieldByName(FAskerlikDurumu.FieldName).DataType, FieldByName(FAskerlikDurumu.FieldName).Value);
        FMedeniDurumuID.Value := GetVarToFormatedValue(FieldByName(FMedeniDurumuID.FieldName).DataType, FieldByName(FMedeniDurumuID.FieldName).Value);
        FMedeniDurumu.Value := GetVarToFormatedValue(FieldByName(FMedeniDurumu.FieldName).DataType, FieldByName(FMedeniDurumu.FieldName).Value);
        FCocukSayisi.Value := GetVarToFormatedValue(FieldByName(FCocukSayisi.FieldName).DataType, FieldByName(FCocukSayisi.FieldName).Value);
        FYakinAdSoyad.Value := GetVarToFormatedValue(FieldByName(FYakinAdSoyad.FieldName).DataType, FieldByName(FYakinAdSoyad.FieldName).Value);
        FYakinTelefon.Value := GetVarToFormatedValue(FieldByName(FYakinTelefon.FieldName).DataType, FieldByName(FYakinTelefon.FieldName).Value);
        FEvAdresi.Value := GetVarToFormatedValue(FieldByName(FEvAdresi.FieldName).DataType, FieldByName(FEvAdresi.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TPersonelBilgisi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
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
        FPersonelTipi.FieldName,
        FBolum.FieldName,
        FBirimID.FieldName,
        FBirim.FieldName,
        FGorevID.FieldName,
        FGorev.FieldName,
        FMailAdresi.FieldName,
        FDogumTarihi.FieldName,
        FKanGrubu.FieldName,
        FCinsiyetID.FieldName,
        FCinsiyet.FieldName,
        FAskerlikDurumID.FieldName,
        FAskerlikDurumu.FieldName,
        FMedeniDurumuID.FieldName,
        FMedeniDurumu.FieldName,
        FCocukSayisi.FieldName,
        FYakinAdSoyad.FieldName,
        FYakinTelefon.FieldName,
        FEvAdresi.FieldName
      ]);

      ParamByName(FIsActive.FieldName).Value := GetVarToFormatedValue(FIsActive.FieldType, FIsActive.Value);
      ParamByName(FPersonelAd.FieldName).Value := GetVarToFormatedValue(FPersonelAd.FieldType, FPersonelAd.Value);
      ParamByName(FPersonelSoyad.FieldName).Value := GetVarToFormatedValue(FPersonelSoyad.FieldType, FPersonelSoyad.Value);
      ParamByName(FTelefon1.FieldName).Value := GetVarToFormatedValue(FTelefon1.FieldType, FTelefon1.Value);
      ParamByName(FTelefon2.FieldName).Value := GetVarToFormatedValue(FTelefon2.FieldType, FTelefon2.Value);
      ParamByName(FPersonelTipiID.FieldName).Value := GetVarToFormatedValue(FPersonelTipiID.FieldType, FPersonelTipiID.Value);
      ParamByName(FPersonelTipi.FieldName).Value := GetVarToFormatedValue(FPersonelTipi.FieldType, FPersonelTipi.Value);
      ParamByName(FBolum.FieldName).Value := GetVarToFormatedValue(FBolum.FieldType, FBolum.Value);
      ParamByName(FBirimID.FieldName).Value := GetVarToFormatedValue(FBirimID.FieldType, FBirimID.Value);
      ParamByName(FBirim.FieldName).Value := GetVarToFormatedValue(FBirim.FieldType, FBirim.Value);
      ParamByName(FGorevID.FieldName).Value := GetVarToFormatedValue(FGorevID.FieldType, FGorevID.Value);
      ParamByName(FGorev.FieldName).Value := GetVarToFormatedValue(FGorev.FieldType, FGorev.Value);
      ParamByName(FMailAdresi.FieldName).Value := GetVarToFormatedValue(FMailAdresi.FieldType, FMailAdresi.Value);
      ParamByName(FDogumTarihi.FieldName).Value := GetVarToFormatedValue(FDogumTarihi.FieldType, FDogumTarihi.Value);
      ParamByName(FKanGrubu.FieldName).Value := GetVarToFormatedValue(FKanGrubu.FieldType, FKanGrubu.Value);
      ParamByName(FCinsiyetID.FieldName).Value := GetVarToFormatedValue(FCinsiyetID.FieldType, FCinsiyetID.Value);
      ParamByName(FCinsiyet.FieldName).Value := GetVarToFormatedValue(FCinsiyet.FieldType, FCinsiyet.Value);
      ParamByName(FAskerlikDurumID.FieldName).Value := GetVarToFormatedValue(FAskerlikDurumID.FieldType, FAskerlikDurumID.Value);
      ParamByName(FAskerlikDurumu.FieldName).Value := GetVarToFormatedValue(FAskerlikDurumu.FieldType, FAskerlikDurumu.Value);
      ParamByName(FMedeniDurumuID.FieldName).Value := GetVarToFormatedValue(FMedeniDurumuID.FieldType, FMedeniDurumuID.Value);
      ParamByName(FMedeniDurumu.FieldName).Value := GetVarToFormatedValue(FMedeniDurumu.FieldType, FMedeniDurumu.Value);
      ParamByName(FCocukSayisi.FieldName).Value := GetVarToFormatedValue(FCocukSayisi.FieldType, FCocukSayisi.Value);
      ParamByName(FYakinAdSoyad.FieldName).Value := GetVarToFormatedValue(FYakinAdSoyad.FieldType, FYakinAdSoyad.Value);
      ParamByName(FYakinTelefon.FieldName).Value := GetVarToFormatedValue(FYakinTelefon.FieldType, FYakinTelefon.Value);
      ParamByName(FEvAdresi.FieldName).Value := GetVarToFormatedValue(FEvAdresi.FieldType, FEvAdresi.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

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

procedure TPersonelBilgisi.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
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
        FPersonelTipi.FieldName,
        FBolum.FieldName,
        FBirimID.FieldName,
        FBirim.FieldName,
        FGorevID.FieldName,
        FGorev.FieldName,
        FMailAdresi.FieldName,
        FDogumTarihi.FieldName,
        FKanGrubu.FieldName,
        FCinsiyetID.FieldName,
        FCinsiyet.FieldName,
        FAskerlikDurumID.FieldName,
        FAskerlikDurumu.FieldName,
        FMedeniDurumuID.FieldName,
        FMedeniDurumu.FieldName,
        FCocukSayisi.FieldName,
        FYakinAdSoyad.FieldName,
        FYakinTelefon.FieldName,
        FEvAdresi.FieldName
      ]);

      ParamByName(FIsActive.FieldName).Value := GetVarToFormatedValue(FIsActive.FieldType, FIsActive.Value);
      ParamByName(FPersonelAd.FieldName).Value := GetVarToFormatedValue(FPersonelAd.FieldType, FPersonelAd.Value);
      ParamByName(FPersonelSoyad.FieldName).Value := GetVarToFormatedValue(FPersonelSoyad.FieldType, FPersonelSoyad.Value);
      ParamByName(FTelefon1.FieldName).Value := GetVarToFormatedValue(FTelefon1.FieldType, FTelefon1.Value);
      ParamByName(FTelefon2.FieldName).Value := GetVarToFormatedValue(FTelefon2.FieldType, FTelefon2.Value);
      ParamByName(FPersonelTipiID.FieldName).Value := GetVarToFormatedValue(FPersonelTipiID.FieldType, FPersonelTipiID.Value);
      ParamByName(FPersonelTipi.FieldName).Value := GetVarToFormatedValue(FPersonelTipi.FieldType, FPersonelTipi.Value);
      ParamByName(FBolum.FieldName).Value := GetVarToFormatedValue(FBolum.FieldType, FBolum.Value);
      ParamByName(FBirimID.FieldName).Value := GetVarToFormatedValue(FBirimID.FieldType, FBirimID.Value);
      ParamByName(FBirim.FieldName).Value := GetVarToFormatedValue(FBirim.FieldType, FBirim.Value);
      ParamByName(FGorevID.FieldName).Value := GetVarToFormatedValue(FGorevID.FieldType, FGorevID.Value);
      ParamByName(FGorev.FieldName).Value := GetVarToFormatedValue(FGorev.FieldType, FGorev.Value);
      ParamByName(FMailAdresi.FieldName).Value := GetVarToFormatedValue(FMailAdresi.FieldType, FMailAdresi.Value);
      ParamByName(FDogumTarihi.FieldName).Value := GetVarToFormatedValue(FDogumTarihi.FieldType, FDogumTarihi.Value);
      ParamByName(FKanGrubu.FieldName).Value := GetVarToFormatedValue(FKanGrubu.FieldType, FKanGrubu.Value);
      ParamByName(FCinsiyetID.FieldName).Value := GetVarToFormatedValue(FCinsiyetID.FieldType, FCinsiyetID.Value);
      ParamByName(FCinsiyet.FieldName).Value := GetVarToFormatedValue(FCinsiyet.FieldType, FCinsiyet.Value);
      ParamByName(FAskerlikDurumID.FieldName).Value := GetVarToFormatedValue(FAskerlikDurumID.FieldType, FAskerlikDurumID.Value);
      ParamByName(FAskerlikDurumu.FieldName).Value := GetVarToFormatedValue(FAskerlikDurumu.FieldType, FAskerlikDurumu.Value);
      ParamByName(FMedeniDurumuID.FieldName).Value := GetVarToFormatedValue(FMedeniDurumuID.FieldType, FMedeniDurumuID.Value);
      ParamByName(FMedeniDurumu.FieldName).Value := GetVarToFormatedValue(FMedeniDurumu.FieldType, FMedeniDurumu.Value);
      ParamByName(FCocukSayisi.FieldName).Value := GetVarToFormatedValue(FCocukSayisi.FieldType, FCocukSayisi.Value);
      ParamByName(FYakinAdSoyad.FieldName).Value := GetVarToFormatedValue(FYakinAdSoyad.FieldType, FYakinAdSoyad.Value);
      ParamByName(FYakinTelefon.FieldName).Value := GetVarToFormatedValue(FYakinTelefon.FieldType, FYakinTelefon.Value);
      ParamByName(FEvAdresi.FieldName).Value := GetVarToFormatedValue(FEvAdresi.FieldType, FEvAdresi.Value);

      ParamByName(Self.Id.FieldName).Value := GetVarToFormatedValue(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TPersonelBilgisi.Clear();
begin
  inherited;

  FIsActive.Value := 0;
  FPersonelAd.Value := '';
  FPersonelSoyad.Value := '';
  FTelefon1.Value := '';
  FTelefon2.Value := '';
  FPersonelTipiID.Value := 0;
  FPersonelTipi.Value := '';
  FBolum.Value := '';
  FBirimID.Value := '';
  FBirim.Value := '';
  FGorevID.Value := '';
  FGorev.Value := '';
  FMailAdresi.Value := '';
  FDogumTarihi.Value := 0;
  FKanGrubu.Value := '';
  FCinsiyetID.Value := 0;
  FCinsiyet.Value := '';
  FAskerlikDurumID.Value := '';
  FAskerlikDurumu.Value := '';
  FMedeniDurumuID.Value := '';
  FMedeniDurumu.Value := '';
  FCocukSayisi.Value := 0;
  FYakinAdSoyad.Value := '';
  FYakinTelefon.Value := '';
  FEvAdresi.Value := '';
end;

function TPersonelBilgisi.Clone():TTable;
begin
  Result := TPersonelBilgisi.Create(Database);

  Self.Id.Clone(TPersonelBilgisi(Result).Id);

  FIsActive.Clone(TPersonelBilgisi(Result).FIsActive);
  FPersonelAd.Clone(TPersonelBilgisi(Result).FPersonelAd);
  FPersonelSoyad.Clone(TPersonelBilgisi(Result).FPersonelSoyad);
  FTelefon1.Clone(TPersonelBilgisi(Result).FTelefon1);
  FTelefon2.Clone(TPersonelBilgisi(Result).FTelefon2);
  FPersonelTipiID.Clone(TPersonelBilgisi(Result).FPersonelTipiID);
  FPersonelTipi.Clone(TPersonelBilgisi(Result).FPersonelTipi);
  FBolum.Clone(TPersonelBilgisi(Result).FBolum);
  FBirimID.Clone(TPersonelBilgisi(Result).FBirimID);
  FBirim.Clone(TPersonelBilgisi(Result).FBirim);
  FGorevID.Clone(TPersonelBilgisi(Result).FGorevID);
  FGorev.Clone(TPersonelBilgisi(Result).FGorev);
  FMailAdresi.Clone(TPersonelBilgisi(Result).FMailAdresi);
  FDogumTarihi.Clone(TPersonelBilgisi(Result).FDogumTarihi);
  FKanGrubu.Clone(TPersonelBilgisi(Result).FKanGrubu);
  FCinsiyetID.Clone(TPersonelBilgisi(Result).FCinsiyetID);
  FCinsiyet.Clone(TPersonelBilgisi(Result).FCinsiyet);
  FAskerlikDurumID.Clone(TPersonelBilgisi(Result).FAskerlikDurumID);
  FAskerlikDurumu.Clone(TPersonelBilgisi(Result).FAskerlikDurumu);
  FMedeniDurumuID.Clone(TPersonelBilgisi(Result).FMedeniDurumuID);
  FMedeniDurumu.Clone(TPersonelBilgisi(Result).FMedeniDurumu);
  FCocukSayisi.Clone(TPersonelBilgisi(Result).FCocukSayisi);
  FYakinAdSoyad.Clone(TPersonelBilgisi(Result).FYakinAdSoyad);
  FYakinTelefon.Clone(TPersonelBilgisi(Result).FYakinTelefon);
  FEvAdresi.Clone(TPersonelBilgisi(Result).FEvAdresi);
end;

end.
