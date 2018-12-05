unit Ths.Erp.Database.Table.SysApplicationSettings;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB, Vcl.Graphics,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TSysApplicationSettings = class(TTable)
  private
    FLogo: TFieldDB;
    FUnvan: TFieldDB;
    FTel1: TFieldDB;
    FTel2: TFieldDB;
    FTel3: TFieldDB;
    FTel4: TFieldDB;
    FTel5: TFieldDB;
    FFax1: TFieldDB;
    FFax2: TFieldDB;
    FMersisNo: TFieldDB;
    FWebSitesi: TFieldDB;
    FEPostaAdresi: TFieldDB;
    FVergiDairesi: TFieldDB;
    FVergiNo: TFieldDB;
    FFormRengi: TFieldDB;
    FDonem: TFieldDB;
    FMukellefTipi: TFieldDB;
    FUlkeID: TFieldDB;
    FSehirID: TFieldDB;
    FIlce: TFieldDB;
    FMahalle: TFieldDB;
    FCadde: TFieldDB;
    FSokak: TFieldDB;
    FPostaKodu: TFieldDB;
    FBina: TFieldDB;
    FKapiNo: TFieldDB;
    FSistemDili: TFieldDB;
    FMailSunucuAdres: TFieldDB;
    FMailSunucuKullanici: TFieldDB;
    FMailSunucuSifre: TFieldDB;
    FMailSunucuPort: TFieldDB;
    FGridColor1: TFieldDB;
    FGridColor2: TFieldDB;
    FGridColorActive: TFieldDB;
    FCryptKey: TFieldDB;
  protected
  published
    //database alaný deðil
    FLogoVal: TBitmap;

    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;
    procedure Delete(pPermissionControl: Boolean = True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property Logo: TFieldDB read FLogo write FLogo;
    Property Unvan: TFieldDB read FUnvan write FUnvan;
    Property Tel1: TFieldDB read FTel1 write FTel1;
    Property Tel2: TFieldDB read FTel2 write FTel2;
    Property Tel3: TFieldDB read FTel3 write FTel3;
    Property Tel4: TFieldDB read FTel4 write FTel4;
    Property Tel5: TFieldDB read FTel5 write FTel5;
    Property Fax1: TFieldDB read FFax1 write FFax1;
    Property Fax2: TFieldDB read FFax2 write FFax2;
    Property MersisNo: TFieldDB read FMersisNo write FMersisNo;
    Property WebSitesi: TFieldDB read FWebSitesi write FWebSitesi;
    Property EPostaAdresi: TFieldDB read FEPostaAdresi write FEPostaAdresi;
    Property VergiDairesi: TFieldDB read FVergiDairesi write FVergiDairesi;
    Property VergiNo: TFieldDB read FVergiNo write FVergiNo;
    Property FormRengi: TFieldDB read FFormRengi write FFormRengi;
    Property Donem: TFieldDB read FDonem write FDonem;
    Property MukellefTipi: TFieldDB read FMukellefTipi write FMukellefTipi;
    Property UlkeID: TFieldDB read FUlkeID write FUlkeID;
    Property SehirID: TFieldDB read FSehirID write FSehirID;
    Property Ilce: TFieldDB read FIlce write FIlce;
    Property Mahalle: TFieldDB read FMahalle write FMahalle;
    Property Cadde: TFieldDB read FCadde write FCadde;
    Property Sokak: TFieldDB read FSokak write FSokak;
    Property PostaKodu: TFieldDB read FPostaKodu write FPostaKodu;
    Property Bina: TFieldDB read FBina write FBina;
    Property KapiNo: TFieldDB read FKapiNo write FKapiNo;
    Property SistemDili: TFieldDB read FSistemDili write FSistemDili;
    Property MailSunucuAdres: TFieldDB read FMailSunucuAdres write FMailSunucuAdres;
    Property MailSunucuKullanici: TFieldDB read FMailSunucuKullanici write FMailSunucuKullanici;
    Property MailSunucuSifre: TFieldDB read FMailSunucuSifre write FMailSunucuSifre;
    Property MailSunucuPort: TFieldDB read FMailSunucuPort write FMailSunucuPort;
    Property GridColor1: TFieldDB read FGridColor1 write FGridColor1;
    Property GridColor2: TFieldDB read FGridColor2 write FGridColor2;
    Property GridColorActive: TFieldDB read FGridColorActive write FGridColorActive;
    Property CryptKey: TfieldDB read FCryptKey write FCryptKey;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Functions;

constructor TSysApplicationSettings.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_application_settings';
  SourceCode := '1';

  FLogo := TFieldDB.Create('logo', ftBlob, null);
  FUnvan := TFieldDB.Create('unvan', ftString, '');
  FTel1 := TFieldDB.Create('tel1', ftString, '');
  FTel2 := TFieldDB.Create('tel2', ftString, '');
  FTel3 := TFieldDB.Create('tel3', ftString, '');
  FTel4 := TFieldDB.Create('Tel4', ftString, '');
  FTel5 := TFieldDB.Create('tel5', ftString, '');
  FFax1 := TFieldDB.Create('fax1', ftString, '');
  FFax2 := TFieldDB.Create('fax2', ftString, '');
  FMersisNo := TFieldDB.Create('mersis_no', ftString, '');
  FWebSitesi := TFieldDB.Create('web_sitesi', ftString, '');
  FEPostaAdresi := TFieldDB.Create('eposta_adresi', ftString, '');
  FVergiDairesi := TFieldDB.Create('vergi_dairesi', ftString, '');
  FVergiNo := TFieldDB.Create('vergi_no', ftString, '');
  FFormRengi := TFieldDB.Create('form_rengi', ftInteger, 0);
  FDonem := TFieldDB.Create('donem', ftInteger, 0);
  FMukellefTipi := TFieldDB.Create('mukellef_tipi', ftString, '');
  FUlkeID := TFieldDB.Create('ulke_id', ftInteger, 0);
  FSehirID := TFieldDB.Create('sehir_id', ftInteger, 0);
  FIlce := TFieldDB.Create('ilce', ftString, '');
  FMahalle := TFieldDB.Create('Mahalle', ftString, '');
  FCadde := TFieldDB.Create('cadde', ftString, '');
  FSokak := TFieldDB.Create('sokak', ftString, '');
  FPostaKodu := TFieldDB.Create('posta_kodu', ftString, '');
  FBina := TFieldDB.Create('bina', ftString, '');
  FKapiNo := TFieldDB.Create('kapi_no', ftString, '');
  FSistemDili := TFieldDB.Create('sistem_dili', ftString, '');
  FMailSunucuAdres := TFieldDB.Create('mail_sunucu_adres', ftString, '');
  FMailSunucuKullanici := TFieldDB.Create('mail_sunucu_kullanici', ftString, '');
  FMailSunucuSifre := TFieldDB.Create('mail_sunucu_sifre', ftString, '');
  FMailSunucuPort := TFieldDB.Create('mail_sunucu_port', ftInteger, 0);
  FGridColor1 := TFieldDB.Create('grid_color_1', ftInteger, 0);
  FGridColor2 := TFieldDB.Create('grid_color_2', ftInteger, 0);
  FGridColorActive := TFieldDB.Create('grid_color_active', ftInteger, 0);
  FCryptKey := TFieldDB.Create('crypt_key', ftInteger, 0);
end;

procedure TSysApplicationSettings.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FLogo.FieldName,
        TableName + '.' + FUnvan.FieldName,
        TableName + '.' + FTel1.FieldName,
        TableName + '.' + FTel2.FieldName,
        TableName + '.' + FTel3.FieldName,
        TableName + '.' + FTel4.FieldName,
        TableName + '.' + FTel5.FieldName,
        TableName + '.' + FFax1.FieldName,
        TableName + '.' + FFax2.FieldName,
        TableName + '.' + FMersisNo.FieldName,
        TableName + '.' + FWebSitesi.FieldName,
        TableName + '.' + FEPostaAdresi.FieldName,
        TableName + '.' + FVergiDairesi.FieldName,
        TableName + '.' + FVergiNo.FieldName,
        TableName + '.' + FFormRengi.FieldName,
        TableName + '.' + FDonem.FieldName,
        TableName + '.' + FMukellefTipi.FieldName,
        TableName + '.' + FUlkeID.FieldName,
        TableName + '.' + FSehirID.FieldName,
        TableName + '.' + FIlce.FieldName,
        TableName + '.' + FMahalle.FieldName,
        TableName + '.' + FCadde.FieldName,
        TableName + '.' + FSokak.FieldName,
        TableName + '.' + FPostaKodu.FieldName,
        TableName + '.' + FBina.FieldName,
        TableName + '.' + FKapiNo.FieldName,
        TableName + '.' + FSistemDili.FieldName,
        TableName + '.' + FMailSunucuAdres.FieldName,
        TableName + '.' + FMailSunucuKullanici.FieldName,
        TableName + '.' + FMailSunucuSifre.FieldName,
        TableName + '.' + FMailSunucuPort.FieldName,
        TableName + '.' + FGridColor1.FieldName,
        TableName + '.' + FGridColor2.FieldName,
        TableName + '.' + FGridColorActive.FieldName,
        TableName + '.' + FCryptKey.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FLogo.FieldName).DisplayLabel := 'Logo';
      Self.DataSource.DataSet.FindField(FUnvan.FieldName).DisplayLabel := 'Ünvan';
      Self.DataSource.DataSet.FindField(FTel1.FieldName).DisplayLabel := 'Tel1';
      Self.DataSource.DataSet.FindField(FTel2.FieldName).DisplayLabel := 'Tel2';
      Self.DataSource.DataSet.FindField(FTel3.FieldName).DisplayLabel := 'Tel3';
      Self.DataSource.DataSet.FindField(FTel4.FieldName).DisplayLabel := 'Tel4';
      Self.DataSource.DataSet.FindField(FTel5.FieldName).DisplayLabel := 'Tel5';
      Self.DataSource.DataSet.FindField(FFax1.FieldName).DisplayLabel := 'Faks1';
      Self.DataSource.DataSet.FindField(FFax2.FieldName).DisplayLabel := 'Faks2';
      Self.DataSource.DataSet.FindField(FMersisNo.FieldName).DisplayLabel := 'Mersis No';
      Self.DataSource.DataSet.FindField(FWebSitesi.FieldName).DisplayLabel := 'Web Sitesi';
      Self.DataSource.DataSet.FindField(FEPostaAdresi.FieldName).DisplayLabel := 'e-Posta Adresi';
      Self.DataSource.DataSet.FindField(FVergiDairesi.FieldName).DisplayLabel := 'Vergi Dairesi';
      Self.DataSource.DataSet.FindField(FVergiNo.FieldName).DisplayLabel := 'Vergi No';
      Self.DataSource.DataSet.FindField(FFormRengi.FieldName).DisplayLabel := 'Form Rengi';
      Self.DataSource.DataSet.FindField(FDonem.FieldName).DisplayLabel := 'Dönem';
      Self.DataSource.DataSet.FindField(FMukellefTipi.FieldName).DisplayLabel := 'Mükellef Tipi';
      Self.DataSource.DataSet.FindField(FUlkeID.FieldName).DisplayLabel := 'Ülke ID';
      Self.DataSource.DataSet.FindField(FSehirID.FieldName).DisplayLabel := 'Þehir ID';
      Self.DataSource.DataSet.FindField(FIlce.FieldName).DisplayLabel := 'Ýlçe';
      Self.DataSource.DataSet.FindField(FMahalle.FieldName).DisplayLabel := 'Mahalle';
      Self.DataSource.DataSet.FindField(FCadde.FieldName).DisplayLabel := 'Cadde';
      Self.DataSource.DataSet.FindField(FSokak.FieldName).DisplayLabel := 'Sokak';
      Self.DataSource.DataSet.FindField(FPostaKodu.FieldName).DisplayLabel := 'Posta Kodu';
      Self.DataSource.DataSet.FindField(FBina.FieldName).DisplayLabel := 'Bina';
      Self.DataSource.DataSet.FindField(FKapiNo.FieldName).DisplayLabel := 'Kapý No';
      Self.DataSource.DataSet.FindField(FSistemDili.FieldName).DisplayLabel := 'Sistem Dili';
      Self.DataSource.DataSet.FindField(FMailSunucuAdres.FieldName).DisplayLabel := 'Mail Gönderecek Adres';
      Self.DataSource.DataSet.FindField(FMailSunucuKullanici.FieldName).DisplayLabel := 'Mail Sunucu Kullanýcý';
      Self.DataSource.DataSet.FindField(FMailSunucuSifre.FieldName).DisplayLabel := 'Mail Sunucu Þifre';
      Self.DataSource.DataSet.FindField(FMailSunucuPort.FieldName).DisplayLabel := 'Mail Sunucu Port';
      Self.DataSource.DataSet.FindField(FGridColor1.FieldName).DisplayLabel := 'Grid Rengi 1';
      Self.DataSource.DataSet.FindField(FGridColor2.FieldName).DisplayLabel := 'Grid Rengi 2';
      Self.DataSource.DataSet.FindField(FGridColorActive.FieldName).DisplayLabel := 'Grid Rengi Aktif';
      Self.DataSource.DataSet.FindField(FCryptKey.FieldName).DisplayLabel := 'Þifreleme Anahtarý';
    end;
  end;
end;

procedure TSysApplicationSettings.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FLogo.FieldName,
        TableName + '.' + FUnvan.FieldName,
        TableName + '.' + FTel1.FieldName,
        TableName + '.' + FTel2.FieldName,
        TableName + '.' + FTel3.FieldName,
        TableName + '.' + FTel4.FieldName,
        TableName + '.' + FTel5.FieldName,
        TableName + '.' + FFax1.FieldName,
        TableName + '.' + FFax2.FieldName,
        TableName + '.' + FMersisNo.FieldName,
        TableName + '.' + FWebSitesi.FieldName,
        TableName + '.' + FEPostaAdresi.FieldName,
        TableName + '.' + FVergiDairesi.FieldName,
        TableName + '.' + FVergiNo.FieldName,
        TableName + '.' + FFormRengi.FieldName,
        TableName + '.' + FDonem.FieldName,
        TableName + '.' + FMukellefTipi.FieldName,
        TableName + '.' + FUlkeID.FieldName,
        TableName + '.' + FSehirID.FieldName,
        TableName + '.' + FIlce.FieldName,
        TableName + '.' + FMahalle.FieldName,
        TableName + '.' + FCadde.FieldName,
        TableName + '.' + FSokak.FieldName,
        TableName + '.' + FPostaKodu.FieldName,
        TableName + '.' + FBina.FieldName,
        TableName + '.' + FKapiNo.FieldName,
        TableName + '.' + FSistemDili.FieldName,
        TableName + '.' + FMailSunucuAdres.FieldName,
        TableName + '.' + FMailSunucuKullanici.FieldName,
        TableName + '.' + FMailSunucuSifre.FieldName,
        TableName + '.' + FMailSunucuPort.FieldName,
        TableName + '.' + FGridColor1.FieldName,
        TableName + '.' + FGridColor2.FieldName,
        TableName + '.' + FGridColorActive.FieldName,
        TableName + '.' + FCryptKey.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FLogo.Value := FormatedVariantVal(FieldByName(FLogo.FieldName).DataType, FieldByName(FLogo.FieldName).Value);
        FUnvan.Value := FormatedVariantVal(FieldByName(FUnvan.FieldName).DataType, FieldByName(FUnvan.FieldName).Value);
        FTel1.Value := FormatedVariantVal(FieldByName(FTel1.FieldName).DataType, FieldByName(FTel1.FieldName).Value);
        FTel2.Value := FormatedVariantVal(FieldByName(FTel2.FieldName).DataType, FieldByName(FTel2.FieldName).Value);
        FTel3.Value := FormatedVariantVal(FieldByName(FTel3.FieldName).DataType, FieldByName(FTel3.FieldName).Value);
        FTel4.Value := FormatedVariantVal(FieldByName(FTel4.FieldName).DataType, FieldByName(FTel4.FieldName).Value);
        FTel5.Value := FormatedVariantVal(FieldByName(FTel5.FieldName).DataType, FieldByName(FTel5.FieldName).Value);
        FFax1.Value := FormatedVariantVal(FieldByName(FFax1.FieldName).DataType, FieldByName(FFax1.FieldName).Value);
        FFax2.Value := FormatedVariantVal(FieldByName(FFax2.FieldName).DataType, FieldByName(FFax2.FieldName).Value);
        FMersisNo.Value := FormatedVariantVal(FieldByName(FMersisNo.FieldName).DataType, FieldByName(FMersisNo.FieldName).Value);
        FWebSitesi.Value := FormatedVariantVal(FieldByName(FWebSitesi.FieldName).DataType, FieldByName(FWebSitesi.FieldName).Value);
        FEPostaAdresi.Value := FormatedVariantVal(FieldByName(FEPostaAdresi.FieldName).DataType, FieldByName(FEPostaAdresi.FieldName).Value);
        FVergiDairesi.Value := FormatedVariantVal(FieldByName(FVergiDairesi.FieldName).DataType, FieldByName(FVergiDairesi.FieldName).Value);
        FVergiNo.Value := FormatedVariantVal(FieldByName(FVergiNo.FieldName).DataType, FieldByName(FVergiNo.FieldName).Value);
        FFormRengi.Value := FormatedVariantVal(FieldByName(FFormRengi.FieldName).DataType, FieldByName(FFormRengi.FieldName).Value);
        FDonem.Value := FormatedVariantVal(FieldByName(FDonem.FieldName).DataType, FieldByName(FDonem.FieldName).Value);
        FMukellefTipi.Value := FormatedVariantVal(FieldByName(FMukellefTipi.FieldName).DataType, FieldByName(FMukellefTipi.FieldName).Value);
        FUlkeID.Value := FormatedVariantVal(FieldByName(FUlkeID.FieldName).DataType, FieldByName(FUlkeID.FieldName).Value);
        FSehirID.Value := FormatedVariantVal(FieldByName(FSehirID.FieldName).DataType, FieldByName(FSehirID.FieldName).Value);
        FIlce.Value := FormatedVariantVal(FieldByName(FIlce.FieldName).DataType, FieldByName(FIlce.FieldName).Value);
        FMahalle.Value := FormatedVariantVal(FieldByName(FMahalle.FieldName).DataType, FieldByName(FMahalle.FieldName).Value);
        FCadde.Value := FormatedVariantVal(FieldByName(FCadde.FieldName).DataType, FieldByName(FCadde.FieldName).Value);
        FSokak.Value := FormatedVariantVal(FieldByName(FSokak.FieldName).DataType, FieldByName(FSokak.FieldName).Value);
        FPostaKodu.Value := FormatedVariantVal(FieldByName(FPostaKodu.FieldName).DataType, FieldByName(FPostaKodu.FieldName).Value);
        FBina.Value := FormatedVariantVal(FieldByName(FBina.FieldName).DataType, FieldByName(FBina.FieldName).Value);
        FKapiNo.Value := FormatedVariantVal(FieldByName(FKapiNo.FieldName).DataType, FieldByName(FKapiNo.FieldName).Value);
        FSistemDili.Value := FormatedVariantVal(FieldByName(FSistemDili.FieldName).DataType, FieldByName(FSistemDili.FieldName).Value);
        FMailSunucuAdres.Value := FormatedVariantVal(FieldByName(FMailSunucuAdres.FieldName).DataType, FieldByName(FMailSunucuAdres.FieldName).Value);
        FMailSunucuKullanici.Value := FormatedVariantVal(FieldByName(FMailSunucuKullanici.FieldName).DataType, FieldByName(FMailSunucuKullanici.FieldName).Value);
        FMailSunucuSifre.Value := FormatedVariantVal(FieldByName(FMailSunucuSifre.FieldName).DataType, FieldByName(FMailSunucuSifre.FieldName).Value);
        FMailSunucuPort.Value := FormatedVariantVal(FieldByName(FMailSunucuPort.FieldName).DataType, FieldByName(FMailSunucuPort.FieldName).Value);
        FGridColor1.Value := FormatedVariantVal(FieldByName(FGridColor1.FieldName).DataType, FieldByName(FGridColor1.FieldName).Value);
        FGridColor2.Value := FormatedVariantVal(FieldByName(FGridColor2.FieldName).DataType, FieldByName(FGridColor2.FieldName).Value);
        FGridColorActive.Value := FormatedVariantVal(FieldByName(FGridColorActive.FieldName).DataType, FieldByName(FGridColorActive.FieldName).Value);
        FCryptKey.Value := FormatedVariantVal(FieldByName(FCryptKey.FieldName).DataType, FieldByName(FCryptKey.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TSysApplicationSettings.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FLogo.FieldName,
        FUnvan.FieldName,
        FTel1.FieldName,
        FTel2.FieldName,
        FTel3.FieldName,
        FTel4.FieldName,
        FTel5.FieldName,
        FFax1.FieldName,
        FFax2.FieldName,
        FMersisNo.FieldName,
        FWebSitesi.FieldName,
        FEPostaAdresi.FieldName,
        FVergiDairesi.FieldName,
        FVergiNo.FieldName,
        FFormRengi.FieldName,
        FDonem.FieldName,
        FMukellefTipi.FieldName,
        FUlkeID.FieldName,
        FSehirID.FieldName,
        FIlce.FieldName,
        FMahalle.FieldName,
        FCadde.FieldName,
        FSokak.FieldName,
        FPostaKodu.FieldName,
        FBina.FieldName,
        FKapiNo.FieldName,
        FSistemDili.FieldName,
        FMailSunucuAdres.FieldName,
        FMailSunucuKullanici.FieldName,
        FMailSunucuSifre.FieldName,
        FMailSunucuPort.FieldName,
        FGridColor1.FieldName,
        FGridColor2.FieldName,
        FGridColorActive.FieldName,
        FCryptKey.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FLogo);
      NewParamForQuery(QueryOfInsert, FUnvan);
      NewParamForQuery(QueryOfInsert, FTel1);
      NewParamForQuery(QueryOfInsert, FTel2);
      NewParamForQuery(QueryOfInsert, FTel3);
      NewParamForQuery(QueryOfInsert, FTel4);
      NewParamForQuery(QueryOfInsert, FTel5);
      NewParamForQuery(QueryOfInsert, FFax1);
      NewParamForQuery(QueryOfInsert, FFax2);
      NewParamForQuery(QueryOfInsert, FMersisNo);
      NewParamForQuery(QueryOfInsert, FWebSitesi);
      NewParamForQuery(QueryOfInsert, FEPostaAdresi);
      NewParamForQuery(QueryOfInsert, FVergiDairesi);
      NewParamForQuery(QueryOfInsert, FVergiNo);
      NewParamForQuery(QueryOfInsert, FFormRengi);
      NewParamForQuery(QueryOfInsert, FDonem);
      NewParamForQuery(QueryOfInsert, FMukellefTipi);
      NewParamForQuery(QueryOfInsert, FUlkeID);
      NewParamForQuery(QueryOfInsert, FSehirID);
      NewParamForQuery(QueryOfInsert, FIlce);
      NewParamForQuery(QueryOfInsert, FMahalle);
      NewParamForQuery(QueryOfInsert, FCadde);
      NewParamForQuery(QueryOfInsert, FSokak);
      NewParamForQuery(QueryOfInsert, FPostaKodu);
      NewParamForQuery(QueryOfInsert, FBina);
      NewParamForQuery(QueryOfInsert, FKapiNo);
      NewParamForQuery(QueryOfInsert, FSistemDili);
      NewParamForQuery(QueryOfInsert, FMailSunucuAdres);
      NewParamForQuery(QueryOfInsert, FMailSunucuKullanici);
      NewParamForQuery(QueryOfInsert, FMailSunucuSifre);
      NewParamForQuery(QueryOfInsert, FMailSunucuPort);
      NewParamForQuery(QueryOfInsert, FGridColor1);
      NewParamForQuery(QueryOfInsert, FGridColor2);
      NewParamForQuery(QueryOfInsert, FGridColorActive);
      NewParamForQuery(QueryOfInsert, FCryptKey);

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

procedure TSysApplicationSettings.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FLogo.FieldName,
        FUnvan.FieldName,
        FTel1.FieldName,
        FTel2.FieldName,
        FTel3.FieldName,
        FTel4.FieldName,
        FTel5.FieldName,
        FFax1.FieldName,
        FFax2.FieldName,
        FMersisNo.FieldName,
        FWebSitesi.FieldName,
        FEPostaAdresi.FieldName,
        FVergiDairesi.FieldName,
        FVergiNo.FieldName,
        FFormRengi.FieldName,
        FDonem.FieldName,
        FMukellefTipi.FieldName,
        FUlkeID.FieldName,
        FSehirID.FieldName,
        FIlce.FieldName,
        FMahalle.FieldName,
        FCadde.FieldName,
        FSokak.FieldName,
        FPostaKodu.FieldName,
        FBina.FieldName,
        FKapiNo.FieldName,
        FSistemDili.FieldName,
        FMailSunucuAdres.FieldName,
        FMailSunucuKullanici.FieldName,
        FMailSunucuSifre.FieldName,
        FMailSunucuPort.FieldName,
        FGridColor1.FieldName,
        FGridColor2.FieldName,
        FGridColorActive.FieldName,
        FCryptKey.FieldName
      ]);

      FLogoVal.SaveToFile('logo_dmp.bmp');
      try
        ParamByName(FLogo.FieldName).LoadFromFile('logo_dmp.bmp', ftBlob);
      finally
        DeleteFile('logo_dmp.bmp');
      end;

      NewParamForQuery(QueryOfUpdate, FLogo);
      NewParamForQuery(QueryOfUpdate, FUnvan);
      NewParamForQuery(QueryOfUpdate, FTel1);
      NewParamForQuery(QueryOfUpdate, FTel2);
      NewParamForQuery(QueryOfUpdate, FTel3);
      NewParamForQuery(QueryOfUpdate, FTel4);
      NewParamForQuery(QueryOfUpdate, FTel5);
      NewParamForQuery(QueryOfUpdate, FFax1);
      NewParamForQuery(QueryOfUpdate, FFax2);
      NewParamForQuery(QueryOfUpdate, FMersisNo);
      NewParamForQuery(QueryOfUpdate, FWebSitesi);
      NewParamForQuery(QueryOfUpdate, FEPostaAdresi);
      NewParamForQuery(QueryOfUpdate, FVergiDairesi);
      NewParamForQuery(QueryOfUpdate, FVergiNo);
      NewParamForQuery(QueryOfUpdate, FFormRengi);
      NewParamForQuery(QueryOfUpdate, FDonem);
      NewParamForQuery(QueryOfUpdate, FMukellefTipi);
      NewParamForQuery(QueryOfUpdate, FUlkeID);
      NewParamForQuery(QueryOfUpdate, FSehirID);
      NewParamForQuery(QueryOfUpdate, FIlce);
      NewParamForQuery(QueryOfUpdate, FMahalle);
      NewParamForQuery(QueryOfUpdate, FCadde);
      NewParamForQuery(QueryOfUpdate, FSokak);
      NewParamForQuery(QueryOfUpdate, FPostaKodu);
      NewParamForQuery(QueryOfUpdate, FBina);
      NewParamForQuery(QueryOfUpdate, FKapiNo);
      NewParamForQuery(QueryOfUpdate, FSistemDili);
      NewParamForQuery(QueryOfUpdate, FMailSunucuAdres);
      NewParamForQuery(QueryOfUpdate, FMailSunucuKullanici);
      NewParamForQuery(QueryOfUpdate, FMailSunucuSifre);
      NewParamForQuery(QueryOfUpdate, FMailSunucuPort);
      NewParamForQuery(QueryOfUpdate, FGridColor1);
      NewParamForQuery(QueryOfUpdate, FGridColor2);
      NewParamForQuery(QueryOfUpdate, FGridColorActive);
      NewParamForQuery(QueryOfUpdate, FCryptKey);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TSysApplicationSettings.Delete(pPermissionControl: Boolean);
begin
  raise Exception.Create(
      TranslateText('Unsupported process!', FrameworkLang.MessageUnsupportedProcess, LngMessage, LngSystem) + AddLBs + self.ClassName);
end;

procedure TSysApplicationSettings.Clear();
begin
  inherited;

  FLogo.Value := null;
  FUnvan.Value := '';
  FTel1.Value := '';
  FTel2.Value := '';
  FTel3.Value := '';
  FTel4.Value := '';
  FTel5.Value := '';
  FFax1.Value := '';
  FFax2.Value := '';
  FMersisNo.Value := '';
  FWebSitesi.Value := '';
  FEPostaAdresi.Value := '';
  FVergiDairesi.Value := '';
  FVergiNo.Value := '';
  FFormRengi.Value := 0;
  FDonem.Value := 0;
  FMukellefTipi.Value := '';
  FUlkeID.Value := 0;
  FSehirID.Value := 0;
  FIlce.Value := '';
  FMahalle.Value := '';
  FCadde.Value := '';
  FSokak.Value := '';
  FPostaKodu.Value := '';
  FBina.Value := '';
  FKapiNo.Value := '';
  FSistemDili.Value := '';
  FMailSunucuAdres.Value := '';
  FMailSunucuKullanici.Value := '';
  FMailSunucuSifre.Value := '';
  FMailSunucuPort.Value := 0;
  FGridColor1.Value := 0;
  FGridColor2.Value := 0;
  FGridColorActive.Value := 0;
  FCryptKey.Value := 0;
end;

function TSysApplicationSettings.Clone():TTable;
begin
  Result := TSysApplicationSettings.Create(Database);

  Self.Id.Clone(TSysApplicationSettings(Result).Id);

  FLogo.Clone(TSysApplicationSettings(Result).FLogo);
  FUnvan.Clone(TSysApplicationSettings(Result).FUnvan);
  FTel1.Clone(TSysApplicationSettings(Result).FTel1);
  FTel2.Clone(TSysApplicationSettings(Result).FTel2);
  FTel3.Clone(TSysApplicationSettings(Result).FTel3);
  FTel4.Clone(TSysApplicationSettings(Result).FTel4);
  FTel5.Clone(TSysApplicationSettings(Result).FTel5);
  FFax1.Clone(TSysApplicationSettings(Result).FFax1);
  FFax2.Clone(TSysApplicationSettings(Result).FFax2);
  FMersisNo.Clone(TSysApplicationSettings(Result).FMersisNo);
  FWebSitesi.Clone(TSysApplicationSettings(Result).FWebSitesi);
  FEPostaAdresi.Clone(TSysApplicationSettings(Result).FEPostaAdresi);
  FVergiDairesi.Clone(TSysApplicationSettings(Result).FVergiDairesi);
  FVergiNo.Clone(TSysApplicationSettings(Result).FVergiNo);
  FFormRengi.Clone(TSysApplicationSettings(Result).FFormRengi);
  FDonem.Clone(TSysApplicationSettings(Result).FDonem);
  FMukellefTipi.Clone(TSysApplicationSettings(Result).FMukellefTipi);
  FUlkeID.Clone(TSysApplicationSettings(Result).FUlkeID);
  FSehirID.Clone(TSysApplicationSettings(Result).FSehirID);
  FIlce.Clone(TSysApplicationSettings(Result).FIlce);
  FMahalle.Clone(TSysApplicationSettings(Result).FMahalle);
  FCadde.Clone(TSysApplicationSettings(Result).FCadde);
  FSokak.Clone(TSysApplicationSettings(Result).FSokak);
  FPostaKodu.Clone(TSysApplicationSettings(Result).FPostaKodu);
  FBina.Clone(TSysApplicationSettings(Result).FBina);
  FKapiNo.Clone(TSysApplicationSettings(Result).FKapiNo);
  FSistemDili.Clone(TSysApplicationSettings(Result).FSistemDili);
  FMailSunucuAdres.Clone(TSysApplicationSettings(Result).FMailSunucuAdres);
  FMailSunucuKullanici.Clone(TSysApplicationSettings(Result).FMailSunucuKullanici);
  FMailSunucuSifre.Clone(TSysApplicationSettings(Result).FMailSunucuSifre);
  FMailSunucuPort.Clone(TSysApplicationSettings(Result).FMailSunucuPort);
  FGridColor1.Clone(TSysApplicationSettings(Result).FGridColor1);
  FGridColor2.Clone(TSysApplicationSettings(Result).FGridColor2);
  FGridColorActive.Clone(TSysApplicationSettings(Result).FGridColorActive);
  FCryptKey.Clone(TSysApplicationSettings(Result).FCryptKey);
end;

end.
