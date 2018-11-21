unit Ths.Erp.Database.Table.MusteriTemsilciGrubu;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TMusteriTemsilciGrubu = class(TTable)
  private
    FTemsilciGrupAdi: TFieldDB;
    FGecmisOcak: TFieldDB;
    FGecmisSubat: TFieldDB;
    FGecmisMart: TFieldDB;
    FGecmisNisan: TFieldDB;
    FGecmisMayis: TFieldDB;
    FGecmisHaziran: TFieldDB;
    FGecmisTemmuz: TFieldDB;
    FGecmisAgustos: TFieldDB;
    FGecmisEylul: TFieldDB;
    FGecmisEkim: TFieldDB;
    FGecmisKasim: TFieldDB;
    FGecmisAralik: TFieldDB;
    FHedefOcak: TFieldDB;
    FHedefSubat: TFieldDB;
    FHedefMart: TFieldDB;
    FHedefNisan: TFieldDB;
    FHedefMayis: TFieldDB;
    FHedefHaziran: TFieldDB;
    FHedefTemmuz: TFieldDB;
    FHedefAgustos: TFieldDB;
    FHedefEylul: TFieldDB;
    FHedefEkim: TFieldDB;
    FHedefKasim: TFieldDB;
    FHedefAralik: TFieldDB;
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

    Property TemsilciGrupAdi: TFieldDB read FTemsilciGrupAdi write FTemsilciGrupAdi;
    Property GecmisOcak: TFieldDB read FGecmisOcak write FGecmisOcak;
    Property GecmisSubat: TFieldDB read FGecmisSubat write FGecmisSubat;
    Property GecmisMart: TFieldDB read FGecmisMart write FGecmisMart;
    Property GecmisNisan: TFieldDB read FGecmisNisan write FGecmisNisan;
    Property GecmisMayis: TFieldDB read FGecmisMayis write FGecmisMayis;
    Property GecmisHaziran: TFieldDB read FGecmisHaziran write FGecmisHaziran;
    Property GecmisTemmuz: TFieldDB read FGecmisTemmuz write FGecmisTemmuz;
    Property GecmisAgustos: TFieldDB read FGecmisAgustos write FGecmisAgustos;
    Property GecmisEylul: TFieldDB read FGecmisEylul write FGecmisEylul;
    Property GecmisEkim: TFieldDB read FGecmisEkim write FGecmisEkim;
    Property GecmisKasim: TFieldDB read FGecmisKasim write FGecmisKasim;
    Property GecmisAralik: TFieldDB read FGecmisAralik write FGecmisAralik;
    Property HedefOcak: TFieldDB read FHedefOcak write FHedefOcak;
    Property HedefSubat: TFieldDB read FHedefSubat write FHedefSubat;
    Property HedefMart: TFieldDB read FHedefMart write FHedefMart;
    Property HedefNisan: TFieldDB read FHedefNisan write FHedefNisan;
    Property HedefMayis: TFieldDB read FHedefMayis write FHedefMayis;
    Property HedefHaziran: TFieldDB read FHedefHaziran write FHedefHaziran;
    Property HedefTemmuz: TFieldDB read FHedefTemmuz write FHedefTemmuz;
    Property HedefAgustos: TFieldDB read FHedefAgustos write FHedefAgustos;
    Property HedefEylul: TFieldDB read FHedefEylul write FHedefEylul;
    Property HedefEkim: TFieldDB read FHedefEkim write FHedefEkim;
    Property HedefKasim: TFieldDB read FHedefKasim write FHedefKasim;
    Property HedefAralik: TFieldDB read FHedefAralik write FHedefAralik;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TMusteriTemsilciGrubu.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'musteri_temsilci_grubu';
  SourceCode := '1000';

  FTemsilciGrupAdi := TFieldDB.Create('temsilci_grup_adi', ftString, '');
  FGecmisOcak := TFieldDB.Create('gecmis_ocak', ftFloat, 0);
  FGecmisSubat := TFieldDB.Create('gecmis_subat', ftFloat, 0);
  FGecmisMart := TFieldDB.Create('gecmis_mart', ftFloat, 0);
  FGecmisNisan := TFieldDB.Create('gecmis_nisan', ftFloat, 0);
  FGecmisMayis := TFieldDB.Create('gecmis_mayis', ftFloat, 0);
  FGecmisHaziran := TFieldDB.Create('gecmis_haziran', ftFloat, 0);
  FGecmisTemmuz := TFieldDB.Create('gecmis_temmuz', ftFloat, 0);
  FGecmisAgustos := TFieldDB.Create('gecmis_agustos', ftFloat, 0);
  FGecmisEylul := TFieldDB.Create('gecmis_eylul', ftFloat, 0);
  FGecmisEkim := TFieldDB.Create('gecmis_ekim', ftFloat, 0);
  FGecmisKasim := TFieldDB.Create('gecmis_kasim', ftFloat, 0);
  FGecmisAralik := TFieldDB.Create('gecmis_aralik', ftFloat, 0);
  FHedefOcak := TFieldDB.Create('hedef_ocak', ftFloat, 0);
  FHedefSubat := TFieldDB.Create('hedef_subat', ftFloat, 0);
  FHedefMart := TFieldDB.Create('hedef_mart', ftFloat, 0);
  FHedefNisan := TFieldDB.Create('hedef_nisan', ftFloat, 0);
  FHedefMayis := TFieldDB.Create('hedef_mayis', ftFloat, 0);
  FHedefHaziran := TFieldDB.Create('hedef_haziran', ftFloat, 0);
  FHedefTemmuz := TFieldDB.Create('hedef_temmuz', ftFloat, 0);
  FHedefAgustos := TFieldDB.Create('hedef_agustos', ftFloat, 0);
  FHedefEylul := TFieldDB.Create('hedef_eylul', ftFloat, 0);
  FHedefEkim := TFieldDB.Create('hedef_ekim', ftFloat, 0);
  FHedefKasim := TFieldDB.Create('hedef_kasim', ftFloat, 0);
  FHedefAralik := TFieldDB.Create('hedef_aralik', ftFloat, 0);
end;

procedure TMusteriTemsilciGrubu.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FTemsilciGrupAdi.FieldName,
        TableName + '.' + FGecmisOcak.FieldName,
        TableName + '.' + FGecmisSubat.FieldName,
        TableName + '.' + FGecmisMart.FieldName,
        TableName + '.' + FGecmisNisan.FieldName,
        TableName + '.' + FGecmisMayis.FieldName,
        TableName + '.' + FGecmisHaziran.FieldName,
        TableName + '.' + FGecmisTemmuz.FieldName,
        TableName + '.' + FGecmisAgustos.FieldName,
        TableName + '.' + FGecmisEylul.FieldName,
        TableName + '.' + FGecmisEkim.FieldName,
        TableName + '.' + FGecmisKasim.FieldName,
        TableName + '.' + FGecmisAralik.FieldName,
        TableName + '.' + FHedefOcak.FieldName,
        TableName + '.' + FHedefSubat.FieldName,
        TableName + '.' + FHedefMart.FieldName,
        TableName + '.' + FHedefNisan.FieldName,
        TableName + '.' + FHedefMayis.FieldName,
        TableName + '.' + FHedefHaziran.FieldName,
        TableName + '.' + FHedefTemmuz.FieldName,
        TableName + '.' + FHedefAgustos.FieldName,
        TableName + '.' + FHedefEylul.FieldName,
        TableName + '.' + FHedefEkim.FieldName,
        TableName + '.' + FHedefKasim.FieldName,
        TableName + '.' + FHedefAralik.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FTemsilciGrupAdi.FieldName).DisplayLabel := 'Temsilci Grup Adý';
      Self.DataSource.DataSet.FindField(FGecmisOcak.FieldName).DisplayLabel := 'Geçmiþ Ocak';
      Self.DataSource.DataSet.FindField(FGecmisSubat.FieldName).DisplayLabel := 'Geçmiþ Þubat';
      Self.DataSource.DataSet.FindField(FGecmisMart.FieldName).DisplayLabel := 'Geçmiþ Mart';
      Self.DataSource.DataSet.FindField(FGecmisNisan.FieldName).DisplayLabel := 'Geçmiþ Nisan';
      Self.DataSource.DataSet.FindField(FGecmisMayis.FieldName).DisplayLabel := 'Geçmiþ Mayýs';
      Self.DataSource.DataSet.FindField(FGecmisHaziran.FieldName).DisplayLabel := 'Geçmiþ Haziran';
      Self.DataSource.DataSet.FindField(FGecmisTemmuz.FieldName).DisplayLabel := 'Geçmiþ Temmuz';
      Self.DataSource.DataSet.FindField(FGecmisAgustos.FieldName).DisplayLabel := 'Geçmiþ Aðustos';
      Self.DataSource.DataSet.FindField(FGecmisEylul.FieldName).DisplayLabel := 'Geçmiþ Eylül';
      Self.DataSource.DataSet.FindField(FGecmisEkim.FieldName).DisplayLabel := 'Geçmiþ Ekim';
      Self.DataSource.DataSet.FindField(FGecmisKasim.FieldName).DisplayLabel := 'Geçmiþ Kasým';
      Self.DataSource.DataSet.FindField(FGecmisAralik.FieldName).DisplayLabel := 'Geçmiþ Aralýk';
      Self.DataSource.DataSet.FindField(FHedefOcak.FieldName).DisplayLabel := 'Hedef Ocak';
      Self.DataSource.DataSet.FindField(FHedefSubat.FieldName).DisplayLabel := 'Hedef Þubat';
      Self.DataSource.DataSet.FindField(FHedefMart.FieldName).DisplayLabel := 'Hedef Mart';
      Self.DataSource.DataSet.FindField(FHedefNisan.FieldName).DisplayLabel := 'Hedef Nisan';
      Self.DataSource.DataSet.FindField(FHedefMayis.FieldName).DisplayLabel := 'Hedef Mayýs';
      Self.DataSource.DataSet.FindField(FHedefHaziran.FieldName).DisplayLabel := 'Hedef Haziran';
      Self.DataSource.DataSet.FindField(FHedefTemmuz.FieldName).DisplayLabel := 'Hedef Temmuz';
      Self.DataSource.DataSet.FindField(FHedefAgustos.FieldName).DisplayLabel := 'Hedef Aðustos';
      Self.DataSource.DataSet.FindField(FHedefEylul.FieldName).DisplayLabel := 'Hedef Eylül';
      Self.DataSource.DataSet.FindField(FHedefEkim.FieldName).DisplayLabel := 'Hedef Ekim';
      Self.DataSource.DataSet.FindField(FHedefKasim.FieldName).DisplayLabel := 'Hedef Kasým';
      Self.DataSource.DataSet.FindField(FHedefAralik.FieldName).DisplayLabel := 'Hedef Aralýk';
    end;
  end;
end;

procedure TMusteriTemsilciGrubu.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FTemsilciGrupAdi.FieldName,
        TableName + '.' + FGecmisOcak.FieldName,
        TableName + '.' + FGecmisSubat.FieldName,
        TableName + '.' + FGecmisMart.FieldName,
        TableName + '.' + FGecmisNisan.FieldName,
        TableName + '.' + FGecmisMayis.FieldName,
        TableName + '.' + FGecmisHaziran.FieldName,
        TableName + '.' + FGecmisTemmuz.FieldName,
        TableName + '.' + FGecmisAgustos.FieldName,
        TableName + '.' + FGecmisEylul.FieldName,
        TableName + '.' + FGecmisEkim.FieldName,
        TableName + '.' + FGecmisKasim.FieldName,
        TableName + '.' + FGecmisAralik.FieldName,
        TableName + '.' + FHedefOcak.FieldName,
        TableName + '.' + FHedefSubat.FieldName,
        TableName + '.' + FHedefMart.FieldName,
        TableName + '.' + FHedefNisan.FieldName,
        TableName + '.' + FHedefMayis.FieldName,
        TableName + '.' + FHedefHaziran.FieldName,
        TableName + '.' + FHedefTemmuz.FieldName,
        TableName + '.' + FHedefAgustos.FieldName,
        TableName + '.' + FHedefEylul.FieldName,
        TableName + '.' + FHedefEkim.FieldName,
        TableName + '.' + FHedefKasim.FieldName,
        TableName + '.' + FHedefAralik.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FTemsilciGrupAdi.Value := FormatedVariantVal(FieldByName(FTemsilciGrupAdi.FieldName).DataType, FieldByName(FTemsilciGrupAdi.FieldName).Value);
        FGecmisOcak.Value := FormatedVariantVal(FieldByName(FGecmisOcak.FieldName).DataType, FieldByName(FGecmisOcak.FieldName).Value);
        FGecmisSubat.Value := FormatedVariantVal(FieldByName(FGecmisSubat.FieldName).DataType, FieldByName(FGecmisSubat.FieldName).Value);
        FGecmisMart.Value := FormatedVariantVal(FieldByName(FGecmisMart.FieldName).DataType, FieldByName(FGecmisMart.FieldName).Value);
        FGecmisNisan.Value := FormatedVariantVal(FieldByName(FGecmisNisan.FieldName).DataType, FieldByName(FGecmisNisan.FieldName).Value);
        FGecmisMayis.Value := FormatedVariantVal(FieldByName(FGecmisMayis.FieldName).DataType, FieldByName(FGecmisMayis.FieldName).Value);
        FGecmisHaziran.Value := FormatedVariantVal(FieldByName(FGecmisHaziran.FieldName).DataType, FieldByName(FGecmisHaziran.FieldName).Value);
        FGecmisTemmuz.Value := FormatedVariantVal(FieldByName(FGecmisTemmuz.FieldName).DataType, FieldByName(FGecmisTemmuz.FieldName).Value);
        FGecmisAgustos.Value := FormatedVariantVal(FieldByName(FGecmisAgustos.FieldName).DataType, FieldByName(FGecmisAgustos.FieldName).Value);
        FGecmisEylul.Value := FormatedVariantVal(FieldByName(FGecmisEylul.FieldName).DataType, FieldByName(FGecmisEylul.FieldName).Value);
        FGecmisEkim.Value := FormatedVariantVal(FieldByName(FGecmisEkim.FieldName).DataType, FieldByName(FGecmisEkim.FieldName).Value);
        FGecmisKasim.Value := FormatedVariantVal(FieldByName(FGecmisKasim.FieldName).DataType, FieldByName(FGecmisKasim.FieldName).Value);
        FGecmisAralik.Value := FormatedVariantVal(FieldByName(FGecmisAralik.FieldName).DataType, FieldByName(FGecmisAralik.FieldName).Value);
        FHedefOcak.Value := FormatedVariantVal(FieldByName(FHedefOcak.FieldName).DataType, FieldByName(FHedefOcak.FieldName).Value);
        FHedefSubat.Value := FormatedVariantVal(FieldByName(FHedefSubat.FieldName).DataType, FieldByName(FHedefSubat.FieldName).Value);
        FHedefMart.Value := FormatedVariantVal(FieldByName(FHedefMart.FieldName).DataType, FieldByName(FHedefMart.FieldName).Value);
        FHedefNisan.Value := FormatedVariantVal(FieldByName(FHedefNisan.FieldName).DataType, FieldByName(FHedefNisan.FieldName).Value);
        FHedefMayis.Value := FormatedVariantVal(FieldByName(FHedefMayis.FieldName).DataType, FieldByName(FHedefMayis.FieldName).Value);
        FHedefHaziran.Value := FormatedVariantVal(FieldByName(FHedefHaziran.FieldName).DataType, FieldByName(FHedefHaziran.FieldName).Value);
        FHedefTemmuz.Value := FormatedVariantVal(FieldByName(FHedefTemmuz.FieldName).DataType, FieldByName(FHedefTemmuz.FieldName).Value);
        FHedefAgustos.Value := FormatedVariantVal(FieldByName(FHedefAgustos.FieldName).DataType, FieldByName(FHedefAgustos.FieldName).Value);
        FHedefEylul.Value := FormatedVariantVal(FieldByName(FHedefEylul.FieldName).DataType, FieldByName(FHedefEylul.FieldName).Value);
        FHedefEkim.Value := FormatedVariantVal(FieldByName(FHedefEkim.FieldName).DataType, FieldByName(FHedefEkim.FieldName).Value);
        FHedefKasim.Value := FormatedVariantVal(FieldByName(FHedefKasim.FieldName).DataType, FieldByName(FHedefKasim.FieldName).Value);
        FHedefAralik.Value := FormatedVariantVal(FieldByName(FHedefAralik.FieldName).DataType, FieldByName(FHedefAralik.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TMusteriTemsilciGrubu.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTemsilciGrupAdi.FieldName,
        FGecmisOcak.FieldName,
        FGecmisSubat.FieldName,
        FGecmisMart.FieldName,
        FGecmisNisan.FieldName,
        FGecmisMayis.FieldName,
        FGecmisHaziran.FieldName,
        FGecmisTemmuz.FieldName,
        FGecmisAgustos.FieldName,
        FGecmisEylul.FieldName,
        FGecmisEkim.FieldName,
        FGecmisKasim.FieldName,
        FGecmisAralik.FieldName,
        FHedefOcak.FieldName,
        FHedefSubat.FieldName,
        FHedefMart.FieldName,
        FHedefNisan.FieldName,
        FHedefMayis.FieldName,
        FHedefHaziran.FieldName,
        FHedefTemmuz.FieldName,
        FHedefAgustos.FieldName,
        FHedefEylul.FieldName,
        FHedefEkim.FieldName,
        FHedefKasim.FieldName,
        FHedefAralik.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FTemsilciGrupAdi);
      NewParamForQuery(QueryOfInsert, FGecmisOcak);
      NewParamForQuery(QueryOfInsert, FGecmisSubat);
      NewParamForQuery(QueryOfInsert, FGecmisMart);
      NewParamForQuery(QueryOfInsert, FGecmisNisan);
      NewParamForQuery(QueryOfInsert, FGecmisMayis);
      NewParamForQuery(QueryOfInsert, FGecmisHaziran);
      NewParamForQuery(QueryOfInsert, FGecmisTemmuz);
      NewParamForQuery(QueryOfInsert, FGecmisAgustos);
      NewParamForQuery(QueryOfInsert, FGecmisEylul);
      NewParamForQuery(QueryOfInsert, FGecmisEkim);
      NewParamForQuery(QueryOfInsert, FGecmisKasim);
      NewParamForQuery(QueryOfInsert, FGecmisAralik);
      NewParamForQuery(QueryOfInsert, FHedefOcak);
      NewParamForQuery(QueryOfInsert, FHedefSubat);
      NewParamForQuery(QueryOfInsert, FHedefMart);
      NewParamForQuery(QueryOfInsert, FHedefNisan);
      NewParamForQuery(QueryOfInsert, FHedefMayis);
      NewParamForQuery(QueryOfInsert, FHedefHaziran);
      NewParamForQuery(QueryOfInsert, FHedefTemmuz);
      NewParamForQuery(QueryOfInsert, FHedefAgustos);
      NewParamForQuery(QueryOfInsert, FHedefEylul);
      NewParamForQuery(QueryOfInsert, FHedefEkim);
      NewParamForQuery(QueryOfInsert, FHedefKasim);
      NewParamForQuery(QueryOfInsert, FHedefAralik);

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

procedure TMusteriTemsilciGrubu.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTemsilciGrupAdi.FieldName,
        FGecmisOcak.FieldName,
        FGecmisSubat.FieldName,
        FGecmisMart.FieldName,
        FGecmisNisan.FieldName,
        FGecmisMayis.FieldName,
        FGecmisHaziran.FieldName,
        FGecmisTemmuz.FieldName,
        FGecmisAgustos.FieldName,
        FGecmisEylul.FieldName,
        FGecmisEkim.FieldName,
        FGecmisKasim.FieldName,
        FGecmisAralik.FieldName,
        FHedefOcak.FieldName,
        FHedefSubat.FieldName,
        FHedefMart.FieldName,
        FHedefNisan.FieldName,
        FHedefMayis.FieldName,
        FHedefHaziran.FieldName,
        FHedefTemmuz.FieldName,
        FHedefAgustos.FieldName,
        FHedefEylul.FieldName,
        FHedefEkim.FieldName,
        FHedefKasim.FieldName,
        FHedefAralik.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FTemsilciGrupAdi);
      NewParamForQuery(QueryOfUpdate, FGecmisOcak);
      NewParamForQuery(QueryOfUpdate, FGecmisSubat);
      NewParamForQuery(QueryOfUpdate, FGecmisMart);
      NewParamForQuery(QueryOfUpdate, FGecmisNisan);
      NewParamForQuery(QueryOfUpdate, FGecmisMayis);
      NewParamForQuery(QueryOfUpdate, FGecmisHaziran);
      NewParamForQuery(QueryOfUpdate, FGecmisTemmuz);
      NewParamForQuery(QueryOfUpdate, FGecmisAgustos);
      NewParamForQuery(QueryOfUpdate, FGecmisEylul);
      NewParamForQuery(QueryOfUpdate, FGecmisEkim);
      NewParamForQuery(QueryOfUpdate, FGecmisKasim);
      NewParamForQuery(QueryOfUpdate, FGecmisAralik);
      NewParamForQuery(QueryOfUpdate, FHedefOcak);
      NewParamForQuery(QueryOfUpdate, FHedefSubat);
      NewParamForQuery(QueryOfUpdate, FHedefMart);
      NewParamForQuery(QueryOfUpdate, FHedefNisan);
      NewParamForQuery(QueryOfUpdate, FHedefMayis);
      NewParamForQuery(QueryOfUpdate, FHedefHaziran);
      NewParamForQuery(QueryOfUpdate, FHedefTemmuz);
      NewParamForQuery(QueryOfUpdate, FHedefAgustos);
      NewParamForQuery(QueryOfUpdate, FHedefEylul);
      NewParamForQuery(QueryOfUpdate, FHedefEkim);
      NewParamForQuery(QueryOfUpdate, FHedefKasim);
      NewParamForQuery(QueryOfUpdate, FHedefAralik);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TMusteriTemsilciGrubu.Clear();
begin
  inherited;

  FTemsilciGrupAdi.Value := '';
  FGecmisOcak.Value := 0;
  FGecmisSubat.Value := 0;
  FGecmisMart.Value := 0;
  FGecmisNisan.Value := 0;
  FGecmisMayis.Value := 0;
  FGecmisHaziran.Value := 0;
  FGecmisTemmuz.Value := 0;
  FGecmisAgustos.Value := 0;
  FGecmisEylul.Value := 0;
  FGecmisEkim.Value := 0;
  FGecmisKasim.Value := 0;
  FGecmisAralik.Value := 0;
  FHedefOcak.Value := 0;
  FHedefSubat.Value := 0;
  FHedefMart.Value := 0;
  FHedefNisan.Value := 0;
  FHedefMayis.Value := 0;
  FHedefHaziran.Value := 0;
  FHedefTemmuz.Value := 0;
  FHedefAgustos.Value := 0;
  FHedefEylul.Value := 0;
  FHedefEkim.Value := 0;
  FHedefKasim.Value := 0;
  FHedefAralik.Value := 0;
end;

function TMusteriTemsilciGrubu.Clone():TTable;
begin
  Result := TMusteriTemsilciGrubu.Create(Database);

  Self.Id.Clone(TMusteriTemsilciGrubu(Result).Id);

  FTemsilciGrupAdi.Clone(TMusteriTemsilciGrubu(Result).FTemsilciGrupAdi);
  FGecmisOcak.Clone(TMusteriTemsilciGrubu(Result).FGecmisOcak);
  FGecmisSubat.Clone(TMusteriTemsilciGrubu(Result).FGecmisSubat);
  FGecmisMart.Clone(TMusteriTemsilciGrubu(Result).FGecmisMart);
  FGecmisNisan.Clone(TMusteriTemsilciGrubu(Result).FGecmisNisan);
  FGecmisMayis.Clone(TMusteriTemsilciGrubu(Result).FGecmisMayis);
  FGecmisHaziran.Clone(TMusteriTemsilciGrubu(Result).FGecmisHaziran);
  FGecmisTemmuz.Clone(TMusteriTemsilciGrubu(Result).FGecmisTemmuz);
  FGecmisAgustos.Clone(TMusteriTemsilciGrubu(Result).FGecmisAgustos);
  FGecmisEylul.Clone(TMusteriTemsilciGrubu(Result).FGecmisEylul);
  FGecmisEkim.Clone(TMusteriTemsilciGrubu(Result).FGecmisEkim);
  FGecmisKasim.Clone(TMusteriTemsilciGrubu(Result).FGecmisKasim);
  FGecmisAralik.Clone(TMusteriTemsilciGrubu(Result).FGecmisAralik);
  FHedefOcak.Clone(TMusteriTemsilciGrubu(Result).FHedefOcak);
  FHedefSubat.Clone(TMusteriTemsilciGrubu(Result).FHedefSubat);
  FHedefMart.Clone(TMusteriTemsilciGrubu(Result).FHedefMart);
  FHedefNisan.Clone(TMusteriTemsilciGrubu(Result).FHedefNisan);
  FHedefMayis.Clone(TMusteriTemsilciGrubu(Result).FHedefMayis);
  FHedefHaziran.Clone(TMusteriTemsilciGrubu(Result).FHedefHaziran);
  FHedefTemmuz.Clone(TMusteriTemsilciGrubu(Result).FHedefTemmuz);
  FHedefAgustos.Clone(TMusteriTemsilciGrubu(Result).FHedefAgustos);
  FHedefEylul.Clone(TMusteriTemsilciGrubu(Result).FHedefEylul);
  FHedefEkim.Clone(TMusteriTemsilciGrubu(Result).FHedefEkim);
  FHedefKasim.Clone(TMusteriTemsilciGrubu(Result).FHedefKasim);
  FHedefAralik.Clone(TMusteriTemsilciGrubu(Result).FHedefAralik);
end;

end.
