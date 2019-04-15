unit Ths.Erp.Database.Table.SatisTeklifDetay;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TSatisTeklifDetay = class(TTable)
  private
    FHeaderID: TFieldDB;
    FSiparisDetayID: TFieldDB;
    FIrsaliyeDetayID: TFieldDB;
    FFaturaDetayID: TFieldDB;
    FStokKodu: TFieldDB;
    FStokAciklama: TFieldDB;
    FAciklama: TFieldDB;
    FReferans: TFieldDB;
    FMiktar: TFieldDB;
    FOlcuBirimi: TFieldDB;
    FIskontoOrani: TFieldDB;
    FFiyat: TFieldDB;
    FNetFiyat: TFieldDB;
    FTutar: TFieldDB;
    FIskontoTutar: TFieldDB;
    FNetTutar: TFieldDB;
    FKdvOrani: TFieldDB;
    FKdvTutar: TFieldDB;
    FToplamTutar: TFieldDB;
    FVadeGun: TFieldDB;
    FIsAnaUrun: TFieldDB;
    FAnaUrunID: TFieldDB;
    FReferansAnaUrunID: TFieldDB;
    FTransferHesapKodu: TFieldDB;
    FKdvTransferHesapKodu: TFieldDB;
    FVergiKodu: TFieldDB;
    FVergiMuafiyetKodu: TFieldDB;
    FDigerVergiKodu: TFieldDB;
    FGtipNo: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property HeaderID: TFieldDB read FHeaderID write FHeaderID;
    Property SiparisDetayID: TFieldDB read FSiparisDetayID write FSiparisDetayID;
    Property IrsaliyeDetayID: TFieldDB read FIrsaliyeDetayID write FIrsaliyeDetayID;
    Property FaturaDetayID: TFieldDB read FFaturaDetayID write FFaturaDetayID;
    Property StokKodu: TFieldDB read FStokKodu write FStokKodu;
    Property StokAciklama: TFieldDB read FStokAciklama write FStokAciklama;
    Property Aciklama: TFieldDB read FAciklama write FAciklama;
    Property Referans: TFieldDB read FReferans write FReferans;
    Property Miktar: TFieldDB read FMiktar write FMiktar;
    Property OlcuBirimi: TFieldDB read FOlcuBirimi write FOlcuBirimi;
    Property IskontoOrani: TFieldDB read FIskontoOrani write FIskontoOrani;
    Property Fiyat: TFieldDB read FFiyat write FFiyat;
    Property NetFiyat: TFieldDB read FNetFiyat write FNetFiyat;
    Property Tutar: TFieldDB read FTutar write FTutar;
    Property IskontoTutar: TFieldDB read FIskontoTutar write FIskontoTutar;
    Property NetTutar: TFieldDB read FNetTutar write FNetTutar;
    Property KdvOrani: TFieldDB read FKdvOrani write FKdvOrani;
    Property KdvTutar: TFieldDB read FKdvTutar write FKdvTutar;
    Property ToplamTutar: TFieldDB read FToplamTutar write FToplamTutar;
    Property VadeGun: TFieldDB read FVadeGun write FVadeGun;
    Property IsAnaUrun: TFieldDB read FIsAnaUrun write FIsAnaUrun;
    Property AnaUrunID: TFieldDB read FAnaUrunID write FAnaUrunID;
    Property ReferansAnaUrunID: TFieldDB read FReferansAnaUrunID write FReferansAnaUrunID;
    Property TransferHesapKodu: TFieldDB read FTransferHesapKodu write FTransferHesapKodu;
    Property KdvTransferHesapKodu: TFieldDB read FKdvTransferHesapKodu write FKdvTransferHesapKodu;
    Property VergiKodu: TFieldDB read FVergiKodu write FVergiKodu;
    Property VergiMuafiyetKodu: TFieldDB read FVergiMuafiyetKodu write FVergiMuafiyetKodu;
    Property DigerVergiKodu: TFieldDB read FDigerVergiKodu write FDigerVergiKodu;
    Property GtipNo: TFieldDB read FGtipNo write FGtipNo;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSatisTeklifDetay.Create(OwnerDatabase:TDatabase);
begin
  TableName := 'satis_teklif_detay';
  SourceCode := '1000';

  inherited Create(OwnerDatabase);

  FHeaderID := TFieldDB.Create('header_id', ftInteger, 0);
  FSiparisDetayID := TFieldDB.Create('siparis_detay_id', ftInteger, 0);
  FIrsaliyeDetayID := TFieldDB.Create('irsaliye_detay_id', ftInteger, 0);
  FFaturaDetayID := TFieldDB.Create('fatura_detay_id', ftInteger, 0);
  FStokKodu := TFieldDB.Create('stok_kodu', ftString, '');
  FStokAciklama := TFieldDB.Create('stok_aciklama', ftString, '');
  FAciklama := TFieldDB.Create('aciklama', ftString, '');
  FReferans := TFieldDB.Create('referans', ftString, '');
  FMiktar := TFieldDB.Create('miktar', ftFloat, 0);
  FOlcuBirimi := TFieldDB.Create('olcu_birimi', ftString, '');
  FIskontoOrani := TFieldDB.Create('iskonto_orani', ftFloat, 0);
  FFiyat := TFieldDB.Create('fiyat', ftFloat, 0);
  FNetFiyat := TFieldDB.Create('net_fiyat', ftFloat, 0);
  FTutar := TFieldDB.Create('tutar', ftFloat, 0);
  FIskontoTutar := TFieldDB.Create('iskonto_tutar', ftFloat, 0);
  FNetTutar := TFieldDB.Create('net_tutar', ftFloat, 0);
  FKdvOrani := TFieldDB.Create('kdv_orani', ftFloat, 0);
  FKdvTutar := TFieldDB.Create('kdv_tutar', ftFloat, 0);
  FToplamTutar := TFieldDB.Create('toplam_tutar', ftFloat, 0);
  FVadeGun := TFieldDB.Create('vade_gun', ftFloat, 0);
  FIsAnaUrun := TFieldDB.Create('is_ana_urun', ftBoolean, 0);
  FAnaUrunID := TFieldDB.Create('ana_urun_id', ftInteger, 0);
  FReferansAnaUrunID := TFieldDB.Create('referans_ana_urun_id', ftInteger, 0);
  FTransferHesapKodu := TFieldDB.Create('transfer_hesap_kodu', ftString, '');
  FKdvTransferHesapKodu := TFieldDB.Create('kdv_transfer_hesap_kodu', ftString, '');
  FVergiKodu := TFieldDB.Create('vergi_kodu', ftString, '');
  FVergiMuafiyetKodu := TFieldDB.Create('vergi_muafiyet_kodu', ftString, '');
  FDigerVergiKodu := TFieldDB.Create('diger_vergi_kodu', ftString, '');
  FGtipNo := TFieldDB.Create('gtip_no', ftString, '');
end;

procedure TSatisTeklifDetay.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FHeaderID.FieldName,
        TableName + '.' + FSiparisDetayID.FieldName,
        TableName + '.' + FIrsaliyeDetayID.FieldName,
        TableName + '.' + FFaturaDetayID.FieldName,
        TableName + '.' + FStokKodu.FieldName,
        TableName + '.' + FStokAciklama.FieldName,
        TableName + '.' + FAciklama.FieldName,
        TableName + '.' + FReferans.FieldName,
        TableName + '.' + FMiktar.FieldName,
        TableName + '.' + FOlcuBirimi.FieldName,
        TableName + '.' + FIskontoOrani.FieldName,
        TableName + '.' + FFiyat.FieldName,
        TableName + '.' + FNetFiyat.FieldName,
        TableName + '.' + FTutar.FieldName,
        TableName + '.' + FIskontoTutar.FieldName,
        TableName + '.' + FNetTutar.FieldName,
        TableName + '.' + FKdvOrani.FieldName,
        TableName + '.' + FKdvTutar.FieldName,
        TableName + '.' + FToplamTutar.FieldName,
        TableName + '.' + FVadeGun.FieldName,
        TableName + '.' + FIsAnaUrun.FieldName,
        TableName + '.' + FAnaUrunID.FieldName,
        TableName + '.' + FReferansAnaUrunID.FieldName,
        TableName + '.' + FTransferHesapKodu.FieldName,
        TableName + '.' + FKdvTransferHesapKodu.FieldName,
        TableName + '.' + FVergiKodu.FieldName,
        TableName + '.' + FVergiMuafiyetKodu.FieldName,
        TableName + '.' + FDigerVergiKodu.FieldName,
        TableName + '.' + FGtipNo.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FHeaderID.FieldName).DisplayLabel := 'Header ID';
      Self.DataSource.DataSet.FindField(FSiparisDetayID.FieldName).DisplayLabel := 'Sipariþ Detay ID';
      Self.DataSource.DataSet.FindField(FIrsaliyeDetayID.FieldName).DisplayLabel := 'Ýrsaliye Detay ID';
      Self.DataSource.DataSet.FindField(FFaturaDetayID.FieldName).DisplayLabel := 'Fatura Detay ID';
      Self.DataSource.DataSet.FindField(FStokKodu.FieldName).DisplayLabel := 'Stok Kodu';
      Self.DataSource.DataSet.FindField(FStokAciklama.FieldName).DisplayLabel := 'Stok Açýklama';
      Self.DataSource.DataSet.FindField(FAciklama.FieldName).DisplayLabel := 'Açýklama';
      Self.DataSource.DataSet.FindField(FReferans.FieldName).DisplayLabel := 'Referans';
      Self.DataSource.DataSet.FindField(FMiktar.FieldName).DisplayLabel := 'Miktar';
      Self.DataSource.DataSet.FindField(FOlcuBirimi.FieldName).DisplayLabel := 'Ölçü Birimi';
      Self.DataSource.DataSet.FindField(FIskontoOrani.FieldName).DisplayLabel := 'Ýskonto Oraný';
      Self.DataSource.DataSet.FindField(FFiyat.FieldName).DisplayLabel := 'Fiyat';
      Self.DataSource.DataSet.FindField(FNetFiyat.FieldName).DisplayLabel := 'Net Fiyat';
      Self.DataSource.DataSet.FindField(FTutar.FieldName).DisplayLabel := 'Tutar';
      Self.DataSource.DataSet.FindField(FIskontoTutar.FieldName).DisplayLabel := 'Ýskonto Tutar';
      Self.DataSource.DataSet.FindField(FNetTutar.FieldName).DisplayLabel := 'Net Tutar';
      Self.DataSource.DataSet.FindField(FKdvOrani.FieldName).DisplayLabel := 'Kdv Oraný';
      Self.DataSource.DataSet.FindField(FKdvTutar.FieldName).DisplayLabel := 'Kdv Tutar';
      Self.DataSource.DataSet.FindField(FToplamTutar.FieldName).DisplayLabel := 'Toplam Tutar';
      Self.DataSource.DataSet.FindField(FVadeGun.FieldName).DisplayLabel := 'Vade Gün';
      Self.DataSource.DataSet.FindField(FIsAnaUrun.FieldName).DisplayLabel := 'Ana Ürün?';
      Self.DataSource.DataSet.FindField(FAnaUrunID.FieldName).DisplayLabel := 'Ana Ürün ID';
      Self.DataSource.DataSet.FindField(FReferansAnaUrunID.FieldName).DisplayLabel := 'Referans Ana Ürün ID';
      Self.DataSource.DataSet.FindField(FTransferHesapKodu.FieldName).DisplayLabel := 'Transfer Hesap Kodu';
      Self.DataSource.DataSet.FindField(FKdvTransferHesapKodu.FieldName).DisplayLabel := 'Kdv Transfer Hesap Kodu';
      Self.DataSource.DataSet.FindField(FVergiKodu.FieldName).DisplayLabel := 'Vergi Kodu';
      Self.DataSource.DataSet.FindField(FVergiMuafiyetKodu.FieldName).DisplayLabel := 'Vergi Muafiyet Kodu';
      Self.DataSource.DataSet.FindField(FDigerVergiKodu.FieldName).DisplayLabel := 'Diðer Vergi Kodu';
      Self.DataSource.DataSet.FindField(FGtipNo.FieldName).DisplayLabel := 'Gtip No';
    end;
  end;
end;

procedure TSatisTeklifDetay.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE OF ' + TableName + ' NOWAIT';

    with QueryOfList do
    begin
      Close;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FHeaderID.FieldName,
        TableName + '.' + FSiparisDetayID.FieldName,
        TableName + '.' + FIrsaliyeDetayID.FieldName,
        TableName + '.' + FFaturaDetayID.FieldName,
        TableName + '.' + FStokKodu.FieldName,
        TableName + '.' + FStokAciklama.FieldName,
        TableName + '.' + FAciklama.FieldName,
        TableName + '.' + FReferans.FieldName,
        TableName + '.' + FMiktar.FieldName,
        TableName + '.' + FOlcuBirimi.FieldName,
        TableName + '.' + FIskontoOrani.FieldName,
        TableName + '.' + FFiyat.FieldName,
        TableName + '.' + FNetFiyat.FieldName,
        TableName + '.' + FTutar.FieldName,
        TableName + '.' + FIskontoTutar.FieldName,
        TableName + '.' + FNetTutar.FieldName,
        TableName + '.' + FKdvOrani.FieldName,
        TableName + '.' + FKdvTutar.FieldName,
        TableName + '.' + FToplamTutar.FieldName,
        TableName + '.' + FVadeGun.FieldName,
        TableName + '.' + FIsAnaUrun.FieldName,
        TableName + '.' + FAnaUrunID.FieldName,
        TableName + '.' + FReferansAnaUrunID.FieldName,
        TableName + '.' + FTransferHesapKodu.FieldName,
        TableName + '.' + FKdvTransferHesapKodu.FieldName,
        TableName + '.' + FVergiKodu.FieldName,
        TableName + '.' + FVergiMuafiyetKodu.FieldName,
        TableName + '.' + FDigerVergiKodu.FieldName,
        TableName + '.' + FGtipNo.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FHeaderID.Value := FormatedVariantVal(FieldByName(FHeaderID.FieldName).DataType, FieldByName(FHeaderID.FieldName).Value);
        FSiparisDetayID.Value := FormatedVariantVal(FieldByName(FSiparisDetayID.FieldName).DataType, FieldByName(FSiparisDetayID.FieldName).Value);
        FIrsaliyeDetayID.Value := FormatedVariantVal(FieldByName(FIrsaliyeDetayID.FieldName).DataType, FieldByName(FIrsaliyeDetayID.FieldName).Value);
        FFaturaDetayID.Value := FormatedVariantVal(FieldByName(FFaturaDetayID.FieldName).DataType, FieldByName(FFaturaDetayID.FieldName).Value);
        FStokKodu.Value := FormatedVariantVal(FieldByName(FStokKodu.FieldName).DataType, FieldByName(FStokKodu.FieldName).Value);
        FStokAciklama.Value := FormatedVariantVal(FieldByName(FStokAciklama.FieldName).DataType, FieldByName(FStokAciklama.FieldName).Value);
        FAciklama.Value := FormatedVariantVal(FieldByName(FAciklama.FieldName).DataType, FieldByName(FAciklama.FieldName).Value);
        FReferans.Value := FormatedVariantVal(FieldByName(FReferans.FieldName).DataType, FieldByName(FReferans.FieldName).Value);
        FMiktar.Value := FormatedVariantVal(FieldByName(FMiktar.FieldName).DataType, FieldByName(FMiktar.FieldName).Value);
        FOlcuBirimi.Value := FormatedVariantVal(FieldByName(FOlcuBirimi.FieldName).DataType, FieldByName(FOlcuBirimi.FieldName).Value);
        FIskontoOrani.Value := FormatedVariantVal(FieldByName(FIskontoOrani.FieldName).DataType, FieldByName(FIskontoOrani.FieldName).Value);
        FFiyat.Value := FormatedVariantVal(FieldByName(FFiyat.FieldName).DataType, FieldByName(FFiyat.FieldName).Value);
        FNetFiyat.Value := FormatedVariantVal(FieldByName(FNetFiyat.FieldName).DataType, FieldByName(FNetFiyat.FieldName).Value);
        FTutar.Value := FormatedVariantVal(FieldByName(FTutar.FieldName).DataType, FieldByName(FTutar.FieldName).Value);
        FIskontoTutar.Value := FormatedVariantVal(FieldByName(FIskontoTutar.FieldName).DataType, FieldByName(FIskontoTutar.FieldName).Value);
        FNetTutar.Value := FormatedVariantVal(FieldByName(FNetTutar.FieldName).DataType, FieldByName(FNetTutar.FieldName).Value);
        FKdvOrani.Value := FormatedVariantVal(FieldByName(FKdvOrani.FieldName).DataType, FieldByName(FKdvOrani.FieldName).Value);
        FKdvTutar.Value := FormatedVariantVal(FieldByName(FKdvTutar.FieldName).DataType, FieldByName(FKdvTutar.FieldName).Value);
        FToplamTutar.Value := FormatedVariantVal(FieldByName(FToplamTutar.FieldName).DataType, FieldByName(FToplamTutar.FieldName).Value);
        FVadeGun.Value := FormatedVariantVal(FieldByName(FVadeGun.FieldName).DataType, FieldByName(FVadeGun.FieldName).Value);
        FIsAnaUrun.Value := FormatedVariantVal(FieldByName(FIsAnaUrun.FieldName).DataType, FieldByName(FIsAnaUrun.FieldName).Value);
        FAnaUrunID.Value := FormatedVariantVal(FieldByName(FAnaUrunID.FieldName).DataType, FieldByName(FAnaUrunID.FieldName).Value);
        FReferansAnaUrunID.Value := FormatedVariantVal(FieldByName(FReferansAnaUrunID.FieldName).DataType, FieldByName(FReferansAnaUrunID.FieldName).Value);
        FTransferHesapKodu.Value := FormatedVariantVal(FieldByName(FTransferHesapKodu.FieldName).DataType, FieldByName(FTransferHesapKodu.FieldName).Value);
        FKdvTransferHesapKodu.Value := FormatedVariantVal(FieldByName(FKdvTransferHesapKodu.FieldName).DataType, FieldByName(FKdvTransferHesapKodu.FieldName).Value);
        FVergiKodu.Value := FormatedVariantVal(FieldByName(FVergiKodu.FieldName).DataType, FieldByName(FVergiKodu.FieldName).Value);
        FVergiMuafiyetKodu.Value := FormatedVariantVal(FieldByName(FVergiMuafiyetKodu.FieldName).DataType, FieldByName(FVergiMuafiyetKodu.FieldName).Value);
        FDigerVergiKodu.Value := FormatedVariantVal(FieldByName(FDigerVergiKodu.FieldName).DataType, FieldByName(FDigerVergiKodu.FieldName).Value);
        FGtipNo.Value := FormatedVariantVal(FieldByName(FGtipNo.FieldName).DataType, FieldByName(FGtipNo.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TSatisTeklifDetay.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FHeaderID.FieldName,
        FSiparisDetayID.FieldName,
        FIrsaliyeDetayID.FieldName,
        FFaturaDetayID.FieldName,
        FStokKodu.FieldName,
        FStokAciklama.FieldName,
        FAciklama.FieldName,
        FReferans.FieldName,
        FMiktar.FieldName,
        FOlcuBirimi.FieldName,
        FIskontoOrani.FieldName,
        FFiyat.FieldName,
        FNetFiyat.FieldName,
        FTutar.FieldName,
        FIskontoTutar.FieldName,
        FNetTutar.FieldName,
        FKdvOrani.FieldName,
        FKdvTutar.FieldName,
        FToplamTutar.FieldName,
        FVadeGun.FieldName,
        FIsAnaUrun.FieldName,
        FAnaUrunID.FieldName,
        FReferansAnaUrunID.FieldName,
        FTransferHesapKodu.FieldName,
        FKdvTransferHesapKodu.FieldName,
        FVergiKodu.FieldName,
        FVergiMuafiyetKodu.FieldName,
        FDigerVergiKodu.FieldName,
        FGtipNo.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FHeaderID);
      NewParamForQuery(QueryOfInsert, FSiparisDetayID);
      NewParamForQuery(QueryOfInsert, FIrsaliyeDetayID);
      NewParamForQuery(QueryOfInsert, FFaturaDetayID);
      NewParamForQuery(QueryOfInsert, FStokKodu);
      NewParamForQuery(QueryOfInsert, FStokAciklama);
      NewParamForQuery(QueryOfInsert, FAciklama);
      NewParamForQuery(QueryOfInsert, FReferans);
      NewParamForQuery(QueryOfInsert, FMiktar);
      NewParamForQuery(QueryOfInsert, FOlcuBirimi);
      NewParamForQuery(QueryOfInsert, FIskontoOrani);
      NewParamForQuery(QueryOfInsert, FFiyat);
      NewParamForQuery(QueryOfInsert, FNetFiyat);
      NewParamForQuery(QueryOfInsert, FTutar);
      NewParamForQuery(QueryOfInsert, FIskontoTutar);
      NewParamForQuery(QueryOfInsert, FNetTutar);
      NewParamForQuery(QueryOfInsert, FKdvOrani);
      NewParamForQuery(QueryOfInsert, FKdvTutar);
      NewParamForQuery(QueryOfInsert, FToplamTutar);
      NewParamForQuery(QueryOfInsert, FVadeGun);
      NewParamForQuery(QueryOfInsert, FIsAnaUrun);
      NewParamForQuery(QueryOfInsert, FAnaUrunID);
      NewParamForQuery(QueryOfInsert, FReferansAnaUrunID);
      NewParamForQuery(QueryOfInsert, FTransferHesapKodu);
      NewParamForQuery(QueryOfInsert, FKdvTransferHesapKodu);
      NewParamForQuery(QueryOfInsert, FVergiKodu);
      NewParamForQuery(QueryOfInsert, FVergiMuafiyetKodu);
      NewParamForQuery(QueryOfInsert, FDigerVergiKodu);
      NewParamForQuery(QueryOfInsert, FGtipNo);

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

procedure TSatisTeklifDetay.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FHeaderID.FieldName,
        FSiparisDetayID.FieldName,
        FIrsaliyeDetayID.FieldName,
        FFaturaDetayID.FieldName,
        FStokKodu.FieldName,
        FStokAciklama.FieldName,
        FAciklama.FieldName,
        FReferans.FieldName,
        FMiktar.FieldName,
        FOlcuBirimi.FieldName,
        FIskontoOrani.FieldName,
        FFiyat.FieldName,
        FNetFiyat.FieldName,
        FTutar.FieldName,
        FIskontoTutar.FieldName,
        FNetTutar.FieldName,
        FKdvOrani.FieldName,
        FKdvTutar.FieldName,
        FToplamTutar.FieldName,
        FVadeGun.FieldName,
        FIsAnaUrun.FieldName,
        FAnaUrunID.FieldName,
        FReferansAnaUrunID.FieldName,
        FTransferHesapKodu.FieldName,
        FKdvTransferHesapKodu.FieldName,
        FVergiKodu.FieldName,
        FVergiMuafiyetKodu.FieldName,
        FDigerVergiKodu.FieldName,
        FGtipNo.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FHeaderID);
      NewParamForQuery(QueryOfUpdate, FSiparisDetayID);
      NewParamForQuery(QueryOfUpdate, FIrsaliyeDetayID);
      NewParamForQuery(QueryOfUpdate, FFaturaDetayID);
      NewParamForQuery(QueryOfUpdate, FStokKodu);
      NewParamForQuery(QueryOfUpdate, FStokAciklama);
      NewParamForQuery(QueryOfUpdate, FAciklama);
      NewParamForQuery(QueryOfUpdate, FReferans);
      NewParamForQuery(QueryOfUpdate, FMiktar);
      NewParamForQuery(QueryOfUpdate, FOlcuBirimi);
      NewParamForQuery(QueryOfUpdate, FIskontoOrani);
      NewParamForQuery(QueryOfUpdate, FFiyat);
      NewParamForQuery(QueryOfUpdate, FNetFiyat);
      NewParamForQuery(QueryOfUpdate, FTutar);
      NewParamForQuery(QueryOfUpdate, FIskontoTutar);
      NewParamForQuery(QueryOfUpdate, FNetTutar);
      NewParamForQuery(QueryOfUpdate, FKdvOrani);
      NewParamForQuery(QueryOfUpdate, FKdvTutar);
      NewParamForQuery(QueryOfUpdate, FToplamTutar);
      NewParamForQuery(QueryOfUpdate, FVadeGun);
      NewParamForQuery(QueryOfUpdate, FIsAnaUrun);
      NewParamForQuery(QueryOfUpdate, FAnaUrunID);
      NewParamForQuery(QueryOfUpdate, FReferansAnaUrunID);
      NewParamForQuery(QueryOfUpdate, FTransferHesapKodu);
      NewParamForQuery(QueryOfUpdate, FKdvTransferHesapKodu);
      NewParamForQuery(QueryOfUpdate, FVergiKodu);
      NewParamForQuery(QueryOfUpdate, FVergiMuafiyetKodu);
      NewParamForQuery(QueryOfUpdate, FDigerVergiKodu);
      NewParamForQuery(QueryOfUpdate, FGtipNo);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TSatisTeklifDetay.Clone():TTable;
begin
  Result := TSatisTeklifDetay.Create(Database);

  Self.Id.Clone(TSatisTeklifDetay(Result).Id);

  FHeaderID.Clone(TSatisTeklifDetay(Result).FHeaderID);
  FSiparisDetayID.Clone(TSatisTeklifDetay(Result).FSiparisDetayID);
  FIrsaliyeDetayID.Clone(TSatisTeklifDetay(Result).FIrsaliyeDetayID);
  FFaturaDetayID.Clone(TSatisTeklifDetay(Result).FFaturaDetayID);
  FStokKodu.Clone(TSatisTeklifDetay(Result).FStokKodu);
  FStokAciklama.Clone(TSatisTeklifDetay(Result).FStokAciklama);
  FAciklama.Clone(TSatisTeklifDetay(Result).FAciklama);
  FReferans.Clone(TSatisTeklifDetay(Result).FReferans);
  FMiktar.Clone(TSatisTeklifDetay(Result).FMiktar);
  FOlcuBirimi.Clone(TSatisTeklifDetay(Result).FOlcuBirimi);
  FIskontoOrani.Clone(TSatisTeklifDetay(Result).FIskontoOrani);
  FFiyat.Clone(TSatisTeklifDetay(Result).FFiyat);
  FNetFiyat.Clone(TSatisTeklifDetay(Result).FNetFiyat);
  FTutar.Clone(TSatisTeklifDetay(Result).FTutar);
  FIskontoTutar.Clone(TSatisTeklifDetay(Result).FIskontoTutar);
  FNetTutar.Clone(TSatisTeklifDetay(Result).FNetTutar);
  FKdvOrani.Clone(TSatisTeklifDetay(Result).FKdvOrani);
  FKdvTutar.Clone(TSatisTeklifDetay(Result).FKdvTutar);
  FToplamTutar.Clone(TSatisTeklifDetay(Result).FToplamTutar);
  FVadeGun.Clone(TSatisTeklifDetay(Result).FVadeGun);
  FIsAnaUrun.Clone(TSatisTeklifDetay(Result).FIsAnaUrun);
  FAnaUrunID.Clone(TSatisTeklifDetay(Result).FAnaUrunID);
  FReferansAnaUrunID.Clone(TSatisTeklifDetay(Result).FReferansAnaUrunID);
  FTransferHesapKodu.Clone(TSatisTeklifDetay(Result).FTransferHesapKodu);
  FKdvTransferHesapKodu.Clone(TSatisTeklifDetay(Result).FKdvTransferHesapKodu);
  FVergiKodu.Clone(TSatisTeklifDetay(Result).FVergiKodu);
  FVergiMuafiyetKodu.Clone(TSatisTeklifDetay(Result).FVergiMuafiyetKodu);
  FDigerVergiKodu.Clone(TSatisTeklifDetay(Result).FDigerVergiKodu);
  FGtipNo.Clone(TSatisTeklifDetay(Result).FGtipNo);
end;

end.
