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
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton,
  Ths.Erp.SpecialFunctions;

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
end;

procedure TSysApplicationSettings.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
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
        TableName + '.' + FMailSunucuPort.FieldName
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
    end;
  end;
end;

procedure TSysApplicationSettings.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FMailSunucuPort.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := GetVarToFormatedValue(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FLogo.Value := GetVarToFormatedValue(FieldByName(FLogo.FieldName).DataType, FieldByName(FLogo.FieldName).Value);
        FUnvan.Value := GetVarToFormatedValue(FieldByName(FUnvan.FieldName).DataType, FieldByName(FUnvan.FieldName).Value);
        FTel1.Value := GetVarToFormatedValue(FieldByName(FTel1.FieldName).DataType, FieldByName(FTel1.FieldName).Value);
        FTel2.Value := GetVarToFormatedValue(FieldByName(FTel2.FieldName).DataType, FieldByName(FTel2.FieldName).Value);
        FTel3.Value := GetVarToFormatedValue(FieldByName(FTel3.FieldName).DataType, FieldByName(FTel3.FieldName).Value);
        FTel4.Value := GetVarToFormatedValue(FieldByName(FTel4.FieldName).DataType, FieldByName(FTel4.FieldName).Value);
        FTel5.Value := GetVarToFormatedValue(FieldByName(FTel5.FieldName).DataType, FieldByName(FTel5.FieldName).Value);
        FFax1.Value := GetVarToFormatedValue(FieldByName(FFax1.FieldName).DataType, FieldByName(FFax1.FieldName).Value);
        FFax2.Value := GetVarToFormatedValue(FieldByName(FFax2.FieldName).DataType, FieldByName(FFax2.FieldName).Value);
        FMersisNo.Value := GetVarToFormatedValue(FieldByName(FMersisNo.FieldName).DataType, FieldByName(FMersisNo.FieldName).Value);
        FWebSitesi.Value := GetVarToFormatedValue(FieldByName(FWebSitesi.FieldName).DataType, FieldByName(FWebSitesi.FieldName).Value);
        FEPostaAdresi.Value := GetVarToFormatedValue(FieldByName(FEPostaAdresi.FieldName).DataType, FieldByName(FEPostaAdresi.FieldName).Value);
        FVergiDairesi.Value := GetVarToFormatedValue(FieldByName(FVergiDairesi.FieldName).DataType, FieldByName(FVergiDairesi.FieldName).Value);
        FVergiNo.Value := GetVarToFormatedValue(FieldByName(FVergiNo.FieldName).DataType, FieldByName(FVergiNo.FieldName).Value);
        FFormRengi.Value := GetVarToFormatedValue(FieldByName(FFormRengi.FieldName).DataType, FieldByName(FFormRengi.FieldName).Value);
        FDonem.Value := GetVarToFormatedValue(FieldByName(FDonem.FieldName).DataType, FieldByName(FDonem.FieldName).Value);
        FMukellefTipi.Value := GetVarToFormatedValue(FieldByName(FMukellefTipi.FieldName).DataType, FieldByName(FMukellefTipi.FieldName).Value);
        FUlkeID.Value := GetVarToFormatedValue(FieldByName(FUlkeID.FieldName).DataType, FieldByName(FUlkeID.FieldName).Value);
        FSehirID.Value := GetVarToFormatedValue(FieldByName(FSehirID.FieldName).DataType, FieldByName(FSehirID.FieldName).Value);
        FIlce.Value := GetVarToFormatedValue(FieldByName(FIlce.FieldName).DataType, FieldByName(FIlce.FieldName).Value);
        FMahalle.Value := GetVarToFormatedValue(FieldByName(FMahalle.FieldName).DataType, FieldByName(FMahalle.FieldName).Value);
        FCadde.Value := GetVarToFormatedValue(FieldByName(FCadde.FieldName).DataType, FieldByName(FCadde.FieldName).Value);
        FSokak.Value := GetVarToFormatedValue(FieldByName(FSokak.FieldName).DataType, FieldByName(FSokak.FieldName).Value);
        FPostaKodu.Value := GetVarToFormatedValue(FieldByName(FPostaKodu.FieldName).DataType, FieldByName(FPostaKodu.FieldName).Value);
        FBina.Value := GetVarToFormatedValue(FieldByName(FBina.FieldName).DataType, FieldByName(FBina.FieldName).Value);
        FKapiNo.Value := GetVarToFormatedValue(FieldByName(FKapiNo.FieldName).DataType, FieldByName(FKapiNo.FieldName).Value);
        FSistemDili.Value := GetVarToFormatedValue(FieldByName(FSistemDili.FieldName).DataType, FieldByName(FSistemDili.FieldName).Value);
        FMailSunucuAdres.Value := GetVarToFormatedValue(FieldByName(FMailSunucuAdres.FieldName).DataType, FieldByName(FMailSunucuAdres.FieldName).Value);
        FMailSunucuKullanici.Value := GetVarToFormatedValue(FieldByName(FMailSunucuKullanici.FieldName).DataType, FieldByName(FMailSunucuKullanici.FieldName).Value);
        FMailSunucuSifre.Value := GetVarToFormatedValue(FieldByName(FMailSunucuSifre.FieldName).DataType, FieldByName(FMailSunucuSifre.FieldName).Value);
        FMailSunucuPort.Value := GetVarToFormatedValue(FieldByName(FMailSunucuPort.FieldName).DataType, FieldByName(FMailSunucuPort.FieldName).Value);

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
    with QueryOfTable do
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
        FMailSunucuPort.FieldName
      ]);

      ParamByName(FLogo.FieldName).Value := GetVarToFormatedValue(FLogo.FieldType, FLogo.Value);
      ParamByName(FUnvan.FieldName).Value := GetVarToFormatedValue(FUnvan.FieldType, FUnvan.Value);
      ParamByName(FTel1.FieldName).Value := GetVarToFormatedValue(FTel1.FieldType, FTel1.Value);
      ParamByName(FTel2.FieldName).Value := GetVarToFormatedValue(FTel2.FieldType, FTel2.Value);
      ParamByName(FTel3.FieldName).Value := GetVarToFormatedValue(FTel3.FieldType, FTel3.Value);
      ParamByName(FTel4.FieldName).Value := GetVarToFormatedValue(FTel4.FieldType, FTel4.Value);
      ParamByName(FTel5.FieldName).Value := GetVarToFormatedValue(FTel5.FieldType, FTel5.Value);
      ParamByName(FFax1.FieldName).Value := GetVarToFormatedValue(FFax1.FieldType, FFax1.Value);
      ParamByName(FFax2.FieldName).Value := GetVarToFormatedValue(FFax2.FieldType, FFax2.Value);
      ParamByName(FMersisNo.FieldName).Value := GetVarToFormatedValue(FMersisNo.FieldType, FMersisNo.Value);
      ParamByName(FWebSitesi.FieldName).Value := GetVarToFormatedValue(FWebSitesi.FieldType, FWebSitesi.Value);
      ParamByName(FEPostaAdresi.FieldName).Value := GetVarToFormatedValue(FEPostaAdresi.FieldType, FEPostaAdresi.Value);
      ParamByName(FVergiDairesi.FieldName).Value := GetVarToFormatedValue(FVergiDairesi.FieldType, FVergiDairesi.Value);
      ParamByName(FVergiNo.FieldName).Value := GetVarToFormatedValue(FVergiNo.FieldType, FVergiNo.Value);
      ParamByName(FFormRengi.FieldName).Value := GetVarToFormatedValue(FFormRengi.FieldType, FFormRengi.Value);
      ParamByName(FDonem.FieldName).Value := GetVarToFormatedValue(FDonem.FieldType, FDonem.Value);
      ParamByName(FMukellefTipi.FieldName).Value := GetVarToFormatedValue(FMukellefTipi.FieldType, FMukellefTipi.Value);
      ParamByName(FUlkeID.FieldName).Value := GetVarToFormatedValue(FUlkeID.FieldType, FUlkeID.Value);
      ParamByName(FSehirID.FieldName).Value := GetVarToFormatedValue(FSehirID.FieldType, FSehirID.Value);
      ParamByName(FIlce.FieldName).Value := GetVarToFormatedValue(FIlce.FieldType, FIlce.Value);
      ParamByName(FMahalle.FieldName).Value := GetVarToFormatedValue(FMahalle.FieldType, FMahalle.Value);
      ParamByName(FCadde.FieldName).Value := GetVarToFormatedValue(FCadde.FieldType, FCadde.Value);
      ParamByName(FSokak.FieldName).Value := GetVarToFormatedValue(FSokak.FieldType, FSokak.Value);
      ParamByName(FPostaKodu.FieldName).Value := GetVarToFormatedValue(FPostaKodu.FieldType, FPostaKodu.Value);
      ParamByName(FBina.FieldName).Value := GetVarToFormatedValue(FBina.FieldType, FBina.Value);
      ParamByName(FKapiNo.FieldName).Value := GetVarToFormatedValue(FKapiNo.FieldType, FKapiNo.Value);
      ParamByName(FSistemDili.FieldName).Value := GetVarToFormatedValue(FSistemDili.FieldType, FSistemDili.Value);
      ParamByName(FMailSunucuAdres.FieldName).Value := GetVarToFormatedValue(FMailSunucuAdres.FieldType, FMailSunucuAdres.Value);
      ParamByName(FMailSunucuKullanici.FieldName).Value := GetVarToFormatedValue(FMailSunucuKullanici.FieldType, FMailSunucuKullanici.Value);
      ParamByName(FMailSunucuSifre.FieldName).Value := GetVarToFormatedValue(FMailSunucuSifre.FieldType, FMailSunucuSifre.Value);
      ParamByName(FMailSunucuPort.FieldName).Value := GetVarToFormatedValue(FMailSunucuPort.FieldType, FMailSunucuPort.Value);

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

procedure TSysApplicationSettings.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
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
        FMailSunucuPort.FieldName
      ]);

      FLogoVal.SaveToFile('logo_dmp.bmp');
      try
        ParamByName(FLogo.FieldName).LoadFromFile('logo_dmp.bmp', ftBlob);
      finally
        DeleteFile('logo_dmp.bmp');
      end;

      ParamByName(FUnvan.FieldName).Value := GetVarToFormatedValue(FUnvan.FieldType, FUnvan.Value);
      ParamByName(FTel1.FieldName).Value := GetVarToFormatedValue(FTel1.FieldType, FTel1.Value);
      ParamByName(FTel2.FieldName).Value := GetVarToFormatedValue(FTel2.FieldType, FTel2.Value);
      ParamByName(FTel3.FieldName).Value := GetVarToFormatedValue(FTel3.FieldType, FTel3.Value);
      ParamByName(FTel4.FieldName).Value := GetVarToFormatedValue(FTel4.FieldType, FTel4.Value);
      ParamByName(FTel5.FieldName).Value := GetVarToFormatedValue(FTel5.FieldType, FTel5.Value);
      ParamByName(FFax1.FieldName).Value := GetVarToFormatedValue(FFax1.FieldType, FFax1.Value);
      ParamByName(FFax2.FieldName).Value := GetVarToFormatedValue(FFax2.FieldType, FFax2.Value);
      ParamByName(FMersisNo.FieldName).Value := GetVarToFormatedValue(FMersisNo.FieldType, FMersisNo.Value);
      ParamByName(FWebSitesi.FieldName).Value := GetVarToFormatedValue(FWebSitesi.FieldType, FWebSitesi.Value);
      ParamByName(FEPostaAdresi.FieldName).Value := GetVarToFormatedValue(FEPostaAdresi.FieldType, FEPostaAdresi.Value);
      ParamByName(FVergiDairesi.FieldName).Value := GetVarToFormatedValue(FVergiDairesi.FieldType, FVergiDairesi.Value);
      ParamByName(FVergiNo.FieldName).Value := GetVarToFormatedValue(FVergiNo.FieldType, FVergiNo.Value);
      ParamByName(FFormRengi.FieldName).Value := GetVarToFormatedValue(FFormRengi.FieldType, FFormRengi.Value);
      ParamByName(FDonem.FieldName).Value := GetVarToFormatedValue(FDonem.FieldType, FDonem.Value);
      ParamByName(FMukellefTipi.FieldName).Value := GetVarToFormatedValue(FMukellefTipi.FieldType, FMukellefTipi.Value);
      ParamByName(FUlkeID.FieldName).Value := GetVarToFormatedValue(FUlkeID.FieldType, FUlkeID.Value);
      ParamByName(FSehirID.FieldName).Value := GetVarToFormatedValue(FSehirID.FieldType, FSehirID.Value);
      ParamByName(FIlce.FieldName).Value := GetVarToFormatedValue(FIlce.FieldType, FIlce.Value);
      ParamByName(FMahalle.FieldName).Value := GetVarToFormatedValue(FMahalle.FieldType, FMahalle.Value);
      ParamByName(FCadde.FieldName).Value := GetVarToFormatedValue(FCadde.FieldType, FCadde.Value);
      ParamByName(FSokak.FieldName).Value := GetVarToFormatedValue(FSokak.FieldType, FSokak.Value);
      ParamByName(FPostaKodu.FieldName).Value := GetVarToFormatedValue(FPostaKodu.FieldType, FPostaKodu.Value);
      ParamByName(FBina.FieldName).Value := GetVarToFormatedValue(FBina.FieldType, FBina.Value);
      ParamByName(FKapiNo.FieldName).Value := GetVarToFormatedValue(FKapiNo.FieldType, FKapiNo.Value);
      ParamByName(FSistemDili.FieldName).Value := GetVarToFormatedValue(FSistemDili.FieldType, FSistemDili.Value);
      ParamByName(FMailSunucuAdres.FieldName).Value := GetVarToFormatedValue(FMailSunucuAdres.FieldType, FMailSunucuAdres.Value);
      ParamByName(FMailSunucuKullanici.FieldName).Value := GetVarToFormatedValue(FMailSunucuKullanici.FieldType, FMailSunucuKullanici.Value);
      ParamByName(FMailSunucuSifre.FieldName).Value := GetVarToFormatedValue(FMailSunucuSifre.FieldType, FMailSunucuSifre.Value);
      ParamByName(FMailSunucuPort.FieldName).Value := GetVarToFormatedValue(FMailSunucuPort.FieldType, FMailSunucuPort.Value);

      ParamByName(Self.Id.FieldName).Value := GetVarToFormatedValue(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TSysApplicationSettings.Delete(pPermissionControl: Boolean);
begin
  raise Exception.Create(
      GetTextFromLang('Unsupported process!', FrameworkLang.MessageUnsupportedProcess, LngMessage, LngSystem) + AddLBs + self.ClassName);
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
end;

end.
