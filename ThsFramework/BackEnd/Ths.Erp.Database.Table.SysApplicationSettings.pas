unit Ths.Erp.Database.Table.SysApplicationSettings;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB, Vcl.Graphics,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TSysApplicationSettings = class(TTable)
  private
    FLogo: TFieldDB;
    FCopanyName: TFieldDB;
    FPhone1: TFieldDB;
    FPhone2: TFieldDB;
    FPhone3: TFieldDB;
    FPhone4: TFieldDB;
    FPhone5: TFieldDB;
    FFax1: TFieldDB;
    FFax2: TFieldDB;
    FMersisNo: TFieldDB;
    FWebSite: TFieldDB;
    FEMail: TFieldDB;
    FTaxAdministration: TFieldDB;
    FTaxNo: TFieldDB;
    FFormColor: TFieldDB;
    FPeriod: TFieldDB;
    FTaxPayerType: TFieldDB;
    FCountryID: TFieldDB;
    FCityID: TFieldDB;
    FTown: TFieldDB;
    FDistrict: TFieldDB;
    FRoad: TFieldDB;
    FStreet: TFieldDB;
    FPostCode: TFieldDB;
    FBuildingName: TFieldDB;
    FDoorNo: TFieldDB;
    FAppMainLang: TFieldDB;
    FMailHostName: TFieldDB;
    FMailHostUser: TFieldDB;
    FMailHostPass: TFieldDB;
    FMailHostSmtpPort: TFieldDB;
    FGridColor1: TFieldDB;
    FGridColor2: TFieldDB;
    FGridColorActive: TFieldDB;
    FCryptKey: TFieldDB;
    FIsUseQualityFormNumber: TFieldDB;
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

    function Clone():TTable;override;

    Property Logo: TFieldDB read FLogo write FLogo;
    Property CompanyName: TFieldDB read FCopanyName write FCopanyName;
    Property Phone1: TFieldDB read FPhone1 write FPhone1;
    Property Phone2: TFieldDB read FPhone2 write FPhone2;
    Property Phone3: TFieldDB read FPhone3 write FPhone3;
    Property Phone4: TFieldDB read FPhone4 write FPhone4;
    Property Phone5: TFieldDB read FPhone5 write FPhone5;
    Property Fax1: TFieldDB read FFax1 write FFax1;
    Property Fax2: TFieldDB read FFax2 write FFax2;
    Property MersisNo: TFieldDB read FMersisNo write FMersisNo;
    Property WebSite: TFieldDB read FWebSite write FWebSite;
    Property EMail: TFieldDB read FEMail write FEMail;
    Property TaxAdministration: TFieldDB read FTaxAdministration write FTaxAdministration;
    Property TaxNo: TFieldDB read FTaxNo write FTaxNo;
    Property FormColor: TFieldDB read FFormColor write FFormColor;
    Property Period: TFieldDB read FPeriod write FPeriod;
    Property TaxPayerType: TFieldDB read FTaxPayerType write FTaxPayerType;
    Property CountryID: TFieldDB read FCountryID write FCountryID;
    Property CityID: TFieldDB read FCityID write FCityID;
    Property Town: TFieldDB read FTown write FTown;
    Property District: TFieldDB read FDistrict write FDistrict;
    Property Road: TFieldDB read FRoad write FRoad;
    Property Street: TFieldDB read FStreet write FStreet;
    Property PostCode: TFieldDB read FPostCode write FPostCode;
    Property BuildingName: TFieldDB read FBuildingName write FBuildingName;
    Property DoorNo: TFieldDB read FDoorNo write FDoorNo;
    Property AppMainLang: TFieldDB read FAppMainLang write FAppMainLang;
    Property MailHostName: TFieldDB read FMailHostName write FMailHostName;
    Property MailHostUser: TFieldDB read FMailHostUser write FMailHostUser;
    Property MailHostPass: TFieldDB read FMailHostPass write FMailHostPass;
    Property MailHostSmtpPort: TFieldDB read FMailHostSmtpPort write FMailHostSmtpPort;
    Property GridColor1: TFieldDB read FGridColor1 write FGridColor1;
    Property GridColor2: TFieldDB read FGridColor2 write FGridColor2;
    Property GridColorActive: TFieldDB read FGridColorActive write FGridColorActive;
    Property CryptKey: TFieldDB read FCryptKey write FCryptKey;
    Property IsUseQualityFormNumber: TFieldDB read FIsUseQualityFormNumber write FIsUseQualityFormNumber;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Functions,
  Ths.Erp.Database.Table.Ulke,
  Ths.Erp.Database.Table.Sehir;

constructor TSysApplicationSettings.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_application_settings';
  SourceCode := '1';

  FLogo := TFieldDB.Create('logo', ftBlob, null);
  FCopanyName := TFieldDB.Create('company_name', ftString, '');
  FPhone1 := TFieldDB.Create('phone1', ftString, '');
  FPhone2 := TFieldDB.Create('phone2', ftString, '');
  FPhone3 := TFieldDB.Create('phone3', ftString, '');
  FPhone4 := TFieldDB.Create('phone4', ftString, '');
  FPhone5 := TFieldDB.Create('phone5', ftString, '');
  FFax1 := TFieldDB.Create('fax1', ftString, '');
  FFax2 := TFieldDB.Create('fax2', ftString, '');
  FMersisNo := TFieldDB.Create('mersis_no', ftString, '');
  FWebSite := TFieldDB.Create('web_site', ftString, '');
  FEMail := TFieldDB.Create('email', ftString, '');
  FTaxAdministration := TFieldDB.Create('tax_administration', ftString, '');
  FTaxNo := TFieldDB.Create('tax_no', ftString, '');
  FFormColor := TFieldDB.Create('form_color', ftInteger, 0);
  FPeriod := TFieldDB.Create('period', ftInteger, 0);
  FTaxPayerType := TFieldDB.Create('taxpayer_type', ftString, '');

  FCountryID := TFieldDB.Create('country_id', ftInteger, 0, 0, True, False);
  FCountryID.FK.FKTable := TUlke.Create(Database);
  FCountryID.FK.FKCol := TFieldDB.Create(TUlke(FCountryID.FK.FKTable).UlkeAdi.FieldName, TUlke(FCountryID.FK.FKTable).UlkeAdi.FieldType, '', 0, False, False);

  FCityID := TFieldDB.Create('city_id', ftInteger, 0, 0, True, False);
  FCityID.FK.FKTable := TSehir.Create(Database);
  FCityID.FK.FKCol := TFieldDB.Create(TSehir(FCityID.FK.FKTable).SehirAdi.FieldName, TSehir(FCityID.FK.FKTable).SehirAdi.FieldType, '', 0, False, False);

  FTown := TFieldDB.Create('town', ftString, '');
  FDistrict := TFieldDB.Create('district', ftString, '');
  FRoad := TFieldDB.Create('road', ftString, '');
  FStreet := TFieldDB.Create('street', ftString, '');
  FPostCode := TFieldDB.Create('post_code', ftString, '');
  FBuildingName := TFieldDB.Create('building_name', ftString, '');
  FDoorNo := TFieldDB.Create('door_no', ftString, '');
  FAppMainLang := TFieldDB.Create('app_main_lang', ftString, '');
  FMailHostName := TFieldDB.Create('mail_host_name', ftString, '');
  FMailHostUser := TFieldDB.Create('mail_host_user', ftString, '');
  FMailHostPass := TFieldDB.Create('mail_host_pass', ftString, '');
  FMailHostSmtpPort := TFieldDB.Create('mail_host_smtp_port', ftInteger, 0);
  FGridColor1 := TFieldDB.Create('grid_color_1', ftInteger, 0);
  FGridColor2 := TFieldDB.Create('grid_color_2', ftInteger, 0);
  FGridColorActive := TFieldDB.Create('grid_color_active', ftInteger, 0);
  FCryptKey := TFieldDB.Create('crypt_key', ftInteger, 0);
  FIsUseQualityFormNumber := TFieldDB.Create('is_use_quality_form_number', ftBoolean, False);
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
        TableName + '.' + FCopanyName.FieldName,
        TableName + '.' + FPhone1.FieldName,
        TableName + '.' + FPhone2.FieldName,
        TableName + '.' + FPhone3.FieldName,
        TableName + '.' + FPhone4.FieldName,
        TableName + '.' + FPhone5.FieldName,
        TableName + '.' + FFax1.FieldName,
        TableName + '.' + FFax2.FieldName,
        TableName + '.' + FMersisNo.FieldName,
        TableName + '.' + FWebSite.FieldName,
        TableName + '.' + FEMail.FieldName,
        TableName + '.' + FTaxAdministration.FieldName,
        TableName + '.' + FTaxNo.FieldName,
        TableName + '.' + FFormColor.FieldName,
        TableName + '.' + FPeriod.FieldName,
        TableName + '.' + FTaxPayerType.FieldName,
        TableName + '.' + FCountryID.FieldName,
        TableName + '.' + FCityID.FieldName,
        TableName + '.' + FTown.FieldName,
        TableName + '.' + FDistrict.FieldName,
        TableName + '.' + FRoad.FieldName,
        TableName + '.' + FStreet.FieldName,
        TableName + '.' + FPostCode.FieldName,
        TableName + '.' + FBuildingName.FieldName,
        TableName + '.' + FDoorNo.FieldName,
        TableName + '.' + FAppMainLang.FieldName,
        TableName + '.' + FMailHostName.FieldName,
        TableName + '.' + FMailHostUser.FieldName,
        TableName + '.' + FMailHostPass.FieldName,
        TableName + '.' + FMailHostSmtpPort.FieldName,
        TableName + '.' + FGridColor1.FieldName,
        TableName + '.' + FGridColor2.FieldName,
        TableName + '.' + FGridColorActive.FieldName,
        TableName + '.' + FCryptKey.FieldName,
        TableName + '.' + FIsUseQualityFormNumber.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

//      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
//      Self.DataSource.DataSet.FindField(FLogo.FieldName).DisplayLabel := 'Logo';
//      Self.DataSource.DataSet.FindField(FUnvan.FieldName).DisplayLabel := 'Ünvan';
//      Self.DataSource.DataSet.FindField(FTel1.FieldName).DisplayLabel := 'Tel1';
//      Self.DataSource.DataSet.FindField(FTel2.FieldName).DisplayLabel := 'Tel2';
//      Self.DataSource.DataSet.FindField(FTel3.FieldName).DisplayLabel := 'Tel3';
//      Self.DataSource.DataSet.FindField(FTel4.FieldName).DisplayLabel := 'Tel4';
//      Self.DataSource.DataSet.FindField(FTel5.FieldName).DisplayLabel := 'Tel5';
//      Self.DataSource.DataSet.FindField(FFax1.FieldName).DisplayLabel := 'Faks1';
//      Self.DataSource.DataSet.FindField(FFax2.FieldName).DisplayLabel := 'Faks2';
//      Self.DataSource.DataSet.FindField(FMersisNo.FieldName).DisplayLabel := 'Mersis No';
//      Self.DataSource.DataSet.FindField(FWebSitesi.FieldName).DisplayLabel := 'Web Sitesi';
//      Self.DataSource.DataSet.FindField(FEPostaAdresi.FieldName).DisplayLabel := 'e-Posta Adresi';
//      Self.DataSource.DataSet.FindField(FVergiDairesi.FieldName).DisplayLabel := 'Vergi Dairesi';
//      Self.DataSource.DataSet.FindField(FVergiNo.FieldName).DisplayLabel := 'Vergi No';
//      Self.DataSource.DataSet.FindField(FFormRengi.FieldName).DisplayLabel := 'Form Rengi';
//      Self.DataSource.DataSet.FindField(FDonem.FieldName).DisplayLabel := 'Dönem';
//      Self.DataSource.DataSet.FindField(FMukellefTipi.FieldName).DisplayLabel := 'Mükellef Tipi';
//      Self.DataSource.DataSet.FindField(FUlkeID.FieldName).DisplayLabel := 'Ülke ID';
//      Self.DataSource.DataSet.FindField(FSehirID.FieldName).DisplayLabel := 'Þehir ID';
//      Self.DataSource.DataSet.FindField(FIlce.FieldName).DisplayLabel := 'Ýlçe';
//      Self.DataSource.DataSet.FindField(FMahalle.FieldName).DisplayLabel := 'Mahalle';
//      Self.DataSource.DataSet.FindField(FCadde.FieldName).DisplayLabel := 'Cadde';
//      Self.DataSource.DataSet.FindField(FSokak.FieldName).DisplayLabel := 'Sokak';
//      Self.DataSource.DataSet.FindField(FPostaKodu.FieldName).DisplayLabel := 'Posta Kodu';
//      Self.DataSource.DataSet.FindField(FBina.FieldName).DisplayLabel := 'Bina';
//      Self.DataSource.DataSet.FindField(FKapiNo.FieldName).DisplayLabel := 'Kapý No';
//      Self.DataSource.DataSet.FindField(FSistemDili.FieldName).DisplayLabel := 'Sistem Dili';
//      Self.DataSource.DataSet.FindField(FMailSunucuAdres.FieldName).DisplayLabel := 'Mail Gönderecek Adres';
//      Self.DataSource.DataSet.FindField(FMailSunucuKullanici.FieldName).DisplayLabel := 'Mail Sunucu Kullanýcý';
//      Self.DataSource.DataSet.FindField(FMailSunucuSifre.FieldName).DisplayLabel := 'Mail Sunucu Þifre';
//      Self.DataSource.DataSet.FindField(FMailSunucuPort.FieldName).DisplayLabel := 'Mail Sunucu Port';
//      Self.DataSource.DataSet.FindField(FGridColor1.FieldName).DisplayLabel := 'Grid Rengi 1';
//      Self.DataSource.DataSet.FindField(FGridColor2.FieldName).DisplayLabel := 'Grid Rengi 2';
//      Self.DataSource.DataSet.FindField(FGridColorActive.FieldName).DisplayLabel := 'Grid Rengi Aktif';
//      Self.DataSource.DataSet.FindField(FCryptKey.FieldName).DisplayLabel := 'Þifreleme Anahtarý';
//      Self.DataSource.DataSet.FindField(FIsKaliteFormNumarasiKullan.FieldName).DisplayLabel := 'Kalite Form Numarasý Kullanýlsýn mý?';
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
        TableName + '.' + FCopanyName.FieldName,
        TableName + '.' + FPhone1.FieldName,
        TableName + '.' + FPhone2.FieldName,
        TableName + '.' + FPhone3.FieldName,
        TableName + '.' + FPhone4.FieldName,
        TableName + '.' + FPhone5.FieldName,
        TableName + '.' + FFax1.FieldName,
        TableName + '.' + FFax2.FieldName,
        TableName + '.' + FMersisNo.FieldName,
        TableName + '.' + FWebSite.FieldName,
        TableName + '.' + FEMail.FieldName,
        TableName + '.' + FTaxAdministration.FieldName,
        TableName + '.' + FTaxNo.FieldName,
        TableName + '.' + FFormColor.FieldName,
        TableName + '.' + FPeriod.FieldName,
        TableName + '.' + FTaxPayerType.FieldName,
        TableName + '.' + FCountryID.FieldName,
        TableName + '.' + FCityID.FieldName,
        TableName + '.' + FTown.FieldName,
        TableName + '.' + FDistrict.FieldName,
        TableName + '.' + FRoad.FieldName,
        TableName + '.' + FStreet.FieldName,
        TableName + '.' + FPostCode.FieldName,
        TableName + '.' + FBuildingName.FieldName,
        TableName + '.' + FDoorNo.FieldName,
        TableName + '.' + FAppMainLang.FieldName,
        TableName + '.' + FMailHostName.FieldName,
        TableName + '.' + FMailHostUser.FieldName,
        TableName + '.' + FMailHostPass.FieldName,
        TableName + '.' + FMailHostSmtpPort.FieldName,
        TableName + '.' + FGridColor1.FieldName,
        TableName + '.' + FGridColor2.FieldName,
        TableName + '.' + FGridColorActive.FieldName,
        TableName + '.' + FCryptKey.FieldName,
        TableName + '.' + FIsUseQualityFormNumber.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        PrepareTableClassFromQuery(QueryOfList);
//        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);
//
//        FLogo.Value := FormatedVariantVal(FieldByName(FLogo.FieldName).DataType, FieldByName(FLogo.FieldName).Value);
//        FUnvan.Value := FormatedVariantVal(FieldByName(FUnvan.FieldName).DataType, FieldByName(FUnvan.FieldName).Value);
//        FTel1.Value := FormatedVariantVal(FieldByName(FTel1.FieldName).DataType, FieldByName(FTel1.FieldName).Value);
//        FTel2.Value := FormatedVariantVal(FieldByName(FTel2.FieldName).DataType, FieldByName(FTel2.FieldName).Value);
//        FTel3.Value := FormatedVariantVal(FieldByName(FTel3.FieldName).DataType, FieldByName(FTel3.FieldName).Value);
//        FTel4.Value := FormatedVariantVal(FieldByName(FTel4.FieldName).DataType, FieldByName(FTel4.FieldName).Value);
//        FTel5.Value := FormatedVariantVal(FieldByName(FTel5.FieldName).DataType, FieldByName(FTel5.FieldName).Value);
//        FFax1.Value := FormatedVariantVal(FieldByName(FFax1.FieldName).DataType, FieldByName(FFax1.FieldName).Value);
//        FFax2.Value := FormatedVariantVal(FieldByName(FFax2.FieldName).DataType, FieldByName(FFax2.FieldName).Value);
//        FMersisNo.Value := FormatedVariantVal(FieldByName(FMersisNo.FieldName).DataType, FieldByName(FMersisNo.FieldName).Value);
//        FWebSitesi.Value := FormatedVariantVal(FieldByName(FWebSitesi.FieldName).DataType, FieldByName(FWebSitesi.FieldName).Value);
//        FEPostaAdresi.Value := FormatedVariantVal(FieldByName(FEPostaAdresi.FieldName).DataType, FieldByName(FEPostaAdresi.FieldName).Value);
//        FVergiDairesi.Value := FormatedVariantVal(FieldByName(FVergiDairesi.FieldName).DataType, FieldByName(FVergiDairesi.FieldName).Value);
//        FVergiNo.Value := FormatedVariantVal(FieldByName(FVergiNo.FieldName).DataType, FieldByName(FVergiNo.FieldName).Value);
//        FFormRengi.Value := FormatedVariantVal(FieldByName(FFormRengi.FieldName).DataType, FieldByName(FFormRengi.FieldName).Value);
//        FDonem.Value := FormatedVariantVal(FieldByName(FDonem.FieldName).DataType, FieldByName(FDonem.FieldName).Value);
//        FMukellefTipi.Value := FormatedVariantVal(FieldByName(FMukellefTipi.FieldName).DataType, FieldByName(FMukellefTipi.FieldName).Value);
//        FUlkeID.Value := FormatedVariantVal(FieldByName(FUlkeID.FieldName).DataType, FieldByName(FUlkeID.FieldName).Value);
//        FSehirID.Value := FormatedVariantVal(FieldByName(FSehirID.FieldName).DataType, FieldByName(FSehirID.FieldName).Value);
//        FIlce.Value := FormatedVariantVal(FieldByName(FIlce.FieldName).DataType, FieldByName(FIlce.FieldName).Value);
//        FMahalle.Value := FormatedVariantVal(FieldByName(FMahalle.FieldName).DataType, FieldByName(FMahalle.FieldName).Value);
//        FCadde.Value := FormatedVariantVal(FieldByName(FCadde.FieldName).DataType, FieldByName(FCadde.FieldName).Value);
//        FSokak.Value := FormatedVariantVal(FieldByName(FSokak.FieldName).DataType, FieldByName(FSokak.FieldName).Value);
//        FPostaKodu.Value := FormatedVariantVal(FieldByName(FPostaKodu.FieldName).DataType, FieldByName(FPostaKodu.FieldName).Value);
//        FBina.Value := FormatedVariantVal(FieldByName(FBina.FieldName).DataType, FieldByName(FBina.FieldName).Value);
//        FKapiNo.Value := FormatedVariantVal(FieldByName(FKapiNo.FieldName).DataType, FieldByName(FKapiNo.FieldName).Value);
//        FSistemDili.Value := FormatedVariantVal(FieldByName(FSistemDili.FieldName).DataType, FieldByName(FSistemDili.FieldName).Value);
//        FMailSunucuAdres.Value := FormatedVariantVal(FieldByName(FMailSunucuAdres.FieldName).DataType, FieldByName(FMailSunucuAdres.FieldName).Value);
//        FMailSunucuKullanici.Value := FormatedVariantVal(FieldByName(FMailSunucuKullanici.FieldName).DataType, FieldByName(FMailSunucuKullanici.FieldName).Value);
//        FMailSunucuSifre.Value := FormatedVariantVal(FieldByName(FMailSunucuSifre.FieldName).DataType, FieldByName(FMailSunucuSifre.FieldName).Value);
//        FMailSunucuPort.Value := FormatedVariantVal(FieldByName(FMailSunucuPort.FieldName).DataType, FieldByName(FMailSunucuPort.FieldName).Value);
//        FGridColor1.Value := FormatedVariantVal(FieldByName(FGridColor1.FieldName).DataType, FieldByName(FGridColor1.FieldName).Value);
//        FGridColor2.Value := FormatedVariantVal(FieldByName(FGridColor2.FieldName).DataType, FieldByName(FGridColor2.FieldName).Value);
//        FGridColorActive.Value := FormatedVariantVal(FieldByName(FGridColorActive.FieldName).DataType, FieldByName(FGridColorActive.FieldName).Value);
//        FCryptKey.Value := FormatedVariantVal(FieldByName(FCryptKey.FieldName).DataType, FieldByName(FCryptKey.FieldName).Value);
//        FIsKaliteFormNumarasiKullan.Value := FormatedVariantVal(FieldByName(FIsKaliteFormNumarasiKullan.FieldName).DataType, FieldByName(FIsKaliteFormNumarasiKullan.FieldName).Value);

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
        FCopanyName.FieldName,
        FPhone1.FieldName,
        FPhone2.FieldName,
        FPhone3.FieldName,
        FPhone4.FieldName,
        FPhone5.FieldName,
        FFax1.FieldName,
        FFax2.FieldName,
        FMersisNo.FieldName,
        FWebSite.FieldName,
        FEMail.FieldName,
        FTaxAdministration.FieldName,
        FTaxNo.FieldName,
        FFormColor.FieldName,
        FPeriod.FieldName,
        FTaxPayerType.FieldName,
        FCountryID.FieldName,
        FCityID.FieldName,
        FTown.FieldName,
        FDistrict.FieldName,
        FRoad.FieldName,
        FStreet.FieldName,
        FPostCode.FieldName,
        FBuildingName.FieldName,
        FDoorNo.FieldName,
        FAppMainLang.FieldName,
        FMailHostName.FieldName,
        FMailHostUser.FieldName,
        FMailHostPass.FieldName,
        FMailHostSmtpPort.FieldName,
        FGridColor1.FieldName,
        FGridColor2.FieldName,
        FGridColorActive.FieldName,
        FCryptKey.FieldName,
        FIsUseQualityFormNumber.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FLogo);
      NewParamForQuery(QueryOfInsert, FCopanyName);
      NewParamForQuery(QueryOfInsert, FPhone1);
      NewParamForQuery(QueryOfInsert, FPhone2);
      NewParamForQuery(QueryOfInsert, FPhone3);
      NewParamForQuery(QueryOfInsert, FPhone4);
      NewParamForQuery(QueryOfInsert, FPhone5);
      NewParamForQuery(QueryOfInsert, FFax1);
      NewParamForQuery(QueryOfInsert, FFax2);
      NewParamForQuery(QueryOfInsert, FMersisNo);
      NewParamForQuery(QueryOfInsert, FWebSite);
      NewParamForQuery(QueryOfInsert, FEMail);
      NewParamForQuery(QueryOfInsert, FTaxAdministration);
      NewParamForQuery(QueryOfInsert, FTaxNo);
      NewParamForQuery(QueryOfInsert, FFormColor);
      NewParamForQuery(QueryOfInsert, FPeriod);
      NewParamForQuery(QueryOfInsert, FTaxPayerType);
      NewParamForQuery(QueryOfInsert, FCountryID);
      NewParamForQuery(QueryOfInsert, FCityID);
      NewParamForQuery(QueryOfInsert, FTown);
      NewParamForQuery(QueryOfInsert, FDistrict);
      NewParamForQuery(QueryOfInsert, FRoad);
      NewParamForQuery(QueryOfInsert, FStreet);
      NewParamForQuery(QueryOfInsert, FPostCode);
      NewParamForQuery(QueryOfInsert, FBuildingName);
      NewParamForQuery(QueryOfInsert, FDoorNo);
      NewParamForQuery(QueryOfInsert, FAppMainLang);
      NewParamForQuery(QueryOfInsert, FMailHostName);
      NewParamForQuery(QueryOfInsert, FMailHostUser);
      NewParamForQuery(QueryOfInsert, FMailHostPass);
      NewParamForQuery(QueryOfInsert, FMailHostSmtpPort);
      NewParamForQuery(QueryOfInsert, FGridColor1);
      NewParamForQuery(QueryOfInsert, FGridColor2);
      NewParamForQuery(QueryOfInsert, FGridColorActive);
      NewParamForQuery(QueryOfInsert, FCryptKey);
      NewParamForQuery(QueryOfInsert, FIsUseQualityFormNumber);

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
        FCopanyName.FieldName,
        FPhone1.FieldName,
        FPhone2.FieldName,
        FPhone3.FieldName,
        FPhone4.FieldName,
        FPhone5.FieldName,
        FFax1.FieldName,
        FFax2.FieldName,
        FMersisNo.FieldName,
        FWebSite.FieldName,
        FEMail.FieldName,
        FTaxAdministration.FieldName,
        FTaxNo.FieldName,
        FFormColor.FieldName,
        FPeriod.FieldName,
        FTaxPayerType.FieldName,
        FCountryID.FieldName,
        FCityID.FieldName,
        FTown.FieldName,
        FDistrict.FieldName,
        FRoad.FieldName,
        FStreet.FieldName,
        FPostCode.FieldName,
        FBuildingName.FieldName,
        FDoorNo.FieldName,
        FAppMainLang.FieldName,
        FMailHostName.FieldName,
        FMailHostUser.FieldName,
        FMailHostPass.FieldName,
        FMailHostSmtpPort.FieldName,
        FGridColor1.FieldName,
        FGridColor2.FieldName,
        FGridColorActive.FieldName,
        FCryptKey.FieldName,
        FIsUseQualityFormNumber.FieldName
      ]);

      FLogoVal.SaveToFile('logo_dmp.bmp');
      try
        ParamByName(FLogo.FieldName).LoadFromFile('logo_dmp.bmp', ftBlob);
      finally
        DeleteFile('logo_dmp.bmp');
      end;

      NewParamForQuery(QueryOfUpdate, FLogo);
      NewParamForQuery(QueryOfUpdate, FCopanyName);
      NewParamForQuery(QueryOfUpdate, FPhone1);
      NewParamForQuery(QueryOfUpdate, FPhone2);
      NewParamForQuery(QueryOfUpdate, FPhone3);
      NewParamForQuery(QueryOfUpdate, FPhone4);
      NewParamForQuery(QueryOfUpdate, FPhone5);
      NewParamForQuery(QueryOfUpdate, FFax1);
      NewParamForQuery(QueryOfUpdate, FFax2);
      NewParamForQuery(QueryOfUpdate, FMersisNo);
      NewParamForQuery(QueryOfUpdate, FWebSite);
      NewParamForQuery(QueryOfUpdate, FEMail);
      NewParamForQuery(QueryOfUpdate, FTaxAdministration);
      NewParamForQuery(QueryOfUpdate, FTaxNo);
      NewParamForQuery(QueryOfUpdate, FFormColor);
      NewParamForQuery(QueryOfUpdate, FPeriod);
      NewParamForQuery(QueryOfUpdate, FTaxPayerType);
      NewParamForQuery(QueryOfUpdate, FCountryID);
      NewParamForQuery(QueryOfUpdate, FCityID);
      NewParamForQuery(QueryOfUpdate, FTown);
      NewParamForQuery(QueryOfUpdate, FDistrict);
      NewParamForQuery(QueryOfUpdate, FRoad);
      NewParamForQuery(QueryOfUpdate, FStreet);
      NewParamForQuery(QueryOfUpdate, FPostCode);
      NewParamForQuery(QueryOfUpdate, FBuildingName);
      NewParamForQuery(QueryOfUpdate, FDoorNo);
      NewParamForQuery(QueryOfUpdate, FAppMainLang);
      NewParamForQuery(QueryOfUpdate, FMailHostName);
      NewParamForQuery(QueryOfUpdate, FMailHostUser);
      NewParamForQuery(QueryOfUpdate, FMailHostPass);
      NewParamForQuery(QueryOfUpdate, FMailHostSmtpPort);
      NewParamForQuery(QueryOfUpdate, FGridColor1);
      NewParamForQuery(QueryOfUpdate, FGridColor2);
      NewParamForQuery(QueryOfUpdate, FGridColorActive);
      NewParamForQuery(QueryOfUpdate, FCryptKey);
      NewParamForQuery(QueryOfUpdate, FIsUseQualityFormNumber);

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
    TranslateText('Bu bilgiler için silme iþlemi yapýlamaz!', FrameworkLang.MessageUnsupportedProcess, LngMsgData, LngSystem) + AddLBs + self.ClassName);
end;

function TSysApplicationSettings.Clone():TTable;
begin
  Result := TSysApplicationSettings.Create(Database);

  Self.Id.Clone(TSysApplicationSettings(Result).Id);

  FLogo.Clone(TSysApplicationSettings(Result).FLogo);
  FCopanyName.Clone(TSysApplicationSettings(Result).FCopanyName);
  FPhone1.Clone(TSysApplicationSettings(Result).FPhone1);
  FPhone2.Clone(TSysApplicationSettings(Result).FPhone2);
  FPhone3.Clone(TSysApplicationSettings(Result).FPhone3);
  FPhone4.Clone(TSysApplicationSettings(Result).FPhone4);
  FPhone5.Clone(TSysApplicationSettings(Result).FPhone5);
  FFax1.Clone(TSysApplicationSettings(Result).FFax1);
  FFax2.Clone(TSysApplicationSettings(Result).FFax2);
  FMersisNo.Clone(TSysApplicationSettings(Result).FMersisNo);
  FWebSite.Clone(TSysApplicationSettings(Result).FWebSite);
  FEMail.Clone(TSysApplicationSettings(Result).FEMail);
  FTaxAdministration.Clone(TSysApplicationSettings(Result).FTaxAdministration);
  FTaxNo.Clone(TSysApplicationSettings(Result).FTaxNo);
  FFormColor.Clone(TSysApplicationSettings(Result).FFormColor);
  FPeriod.Clone(TSysApplicationSettings(Result).FPeriod);
  FTaxPayerType.Clone(TSysApplicationSettings(Result).FTaxPayerType);
  FCountryID.Clone(TSysApplicationSettings(Result).FCountryID);
  FCityID.Clone(TSysApplicationSettings(Result).FCityID);
  FTown.Clone(TSysApplicationSettings(Result).FTown);
  FDistrict.Clone(TSysApplicationSettings(Result).FDistrict);
  FRoad.Clone(TSysApplicationSettings(Result).FRoad);
  FStreet.Clone(TSysApplicationSettings(Result).FStreet);
  FPostCode.Clone(TSysApplicationSettings(Result).FPostCode);
  FBuildingName.Clone(TSysApplicationSettings(Result).FBuildingName);
  FDoorNo.Clone(TSysApplicationSettings(Result).FDoorNo);
  FAppMainLang.Clone(TSysApplicationSettings(Result).FAppMainLang);
  FMailHostName.Clone(TSysApplicationSettings(Result).FMailHostName);
  FMailHostUser.Clone(TSysApplicationSettings(Result).FMailHostUser);
  FMailHostPass.Clone(TSysApplicationSettings(Result).FMailHostPass);
  FMailHostSmtpPort.Clone(TSysApplicationSettings(Result).FMailHostSmtpPort);
  FGridColor1.Clone(TSysApplicationSettings(Result).FGridColor1);
  FGridColor2.Clone(TSysApplicationSettings(Result).FGridColor2);
  FGridColorActive.Clone(TSysApplicationSettings(Result).FGridColorActive);
  FCryptKey.Clone(TSysApplicationSettings(Result).FCryptKey);
  FIsUseQualityFormNumber.Clone(TSysApplicationSettings(Result).FIsUseQualityFormNumber);
end;

end.
