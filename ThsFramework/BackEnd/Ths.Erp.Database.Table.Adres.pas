unit Ths.Erp.Database.Table.Adres;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table

  , Ths.Erp.Database.Table.Ulke
  , Ths.Erp.Database.Table.Sehir
  ;

type
  TAdres = class(TTable)
  private
    FUlkeID: TFieldDB;
    FSehirID: TFieldDB;
    FIlce: TFieldDB;
    FMahalle: TFieldDB;
    FCadde: TFieldDB;
    FSokak: TFieldDB;
    FBina: TFieldDB;
    FKapiNo: TFieldDB;
    FPostaKutusu: TFieldDB;
    FPostaKodu: TFieldDB;
    FWebSitesi: TFieldDB;
    FePostaAdresi: TFieldDB;
  protected
    procedure BusinessSelect(pFilter: string; pLock: Boolean;
      pPermissionControl: Boolean); override;
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property UlkeID: TFieldDB read FUlkeID write FUlkeID;
    Property SehirID: TFieldDB read FSehirID write FSehirID;
    Property Ilce: TFieldDB read FIlce write FIlce;
    Property Mahalle: TFieldDB read FMahalle write FMahalle;
    Property Cadde: TFieldDB read FCadde write FCadde;
    Property Sokak: TFieldDB read FSokak write FSokak;
    Property Bina: TFieldDB read FBina write FBina;
    Property KapiNo: TFieldDB read FKapiNo write FKapiNo;
    Property PostaKutusu: TFieldDB read FPostaKutusu write FPostaKutusu;
    Property PostaKodu: TFieldDB read FPostaKodu write FPostaKodu;
    Property WebSitesi: TFieldDB read FWebSitesi write FWebSitesi;
    Property ePostaAdresi: TFieldDB read FePostaAdresi write FePostaAdresi;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAdres.Create(OwnerDatabase:TDatabase);
begin
  TableName := 'adres';
  SourceCode := '1000';

  inherited Create(OwnerDatabase);

  FUlkeID := TFieldDB.Create('ulke_id', ftInteger, 0, 0, True, False);
  FUlkeID.FK.FKTable := TUlke.Create(Database);
  FUlkeID.FK.FKCol := TFieldDB.Create('ulke', TUlke(FUlkeID.FK.FKTable).UlkeAdi.FieldType, '', 0, False, False);
  FSehirID := TFieldDB.Create('sehir_id', ftInteger, 0, 0, True, False);
  FSehirID.FK.FKTable := TSehir.Create(Database);
  FSehirID.FK.FKCol := TFieldDB.Create('sehir', TSehir(FSehirID.FK.FKTable).SehirAdi.FieldType, '', 0, False, False);
  FIlce := TFieldDB.Create('ilce', ftString, '', 0, False, True);
  FMahalle := TFieldDB.Create('mahalle', ftString, '', 0, False, True);
  FCadde := TFieldDB.Create('cadde', ftString, '', 0, False, True);
  FSokak := TFieldDB.Create('sokak', ftString, '', 0, False, True);
  FBina := TFieldDB.Create('bina', ftString, '', 0, False, True);
  FKapiNo := TFieldDB.Create('kapi_no', ftString, '', 0, False, True);
  FPostaKutusu := TFieldDB.Create('posta_kutusu', ftString, '', 0, False, True);
  FPostaKodu := TFieldDB.Create('posta_kodu', ftString, '', 0, False, True);
  FWebSitesi := TFieldDB.Create('web_sitesi', ftString, '', 0, False, True);
  FePostaAdresi := TFieldDB.Create('eposta_adresi', ftString, '', 0, False, True);
end;

procedure TAdres.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FUlkeID.FieldName,
        ColumnFromIDCol(TUlke(FUlkeID.FK.FKTable).UlkeAdi.FieldName, FUlkeID.FK.FKTable.TableName, FUlkeID.FieldName, FUlkeID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FSehirID.FieldName,
        ColumnFromIDCol(TSehir(FSehirID.FK.FKTable).SehirAdi.FieldName, FSehirID.FK.FKTable.TableName, FSehirID.FieldName, FSehirID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FIlce.FieldName,
        TableName + '.' + FMahalle.FieldName,
        TableName + '.' + FCadde.FieldName,
        TableName + '.' + FSokak.FieldName,
        TableName + '.' + FBina.FieldName,
        TableName + '.' + FKapiNo.FieldName,
        TableName + '.' + FPostaKutusu.FieldName,
        TableName + '.' + FPostaKodu.FieldName,
        TableName + '.' + FWebSitesi.FieldName,
        TableName + '.' + FePostaAdresi.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FUlkeID.FieldName).DisplayLabel := 'Ülke ID';
      Self.DataSource.DataSet.FindField(FUlkeID.FK.FKCol.FieldName).DisplayLabel := 'Ülke';
      Self.DataSource.DataSet.FindField(FSehirID.FieldName).DisplayLabel := 'Þehir ID';
      Self.DataSource.DataSet.FindField(FSehirID.FK.FKCol.FieldName).DisplayLabel := 'Þehir';
      Self.DataSource.DataSet.FindField(FIlce.FieldName).DisplayLabel := 'Ýlçe';
      Self.DataSource.DataSet.FindField(FMahalle.FieldName).DisplayLabel := 'Mahalle';
      Self.DataSource.DataSet.FindField(FCadde.FieldName).DisplayLabel := 'Cadde';
      Self.DataSource.DataSet.FindField(FSokak.FieldName).DisplayLabel := 'Sokak';
      Self.DataSource.DataSet.FindField(FBina.FieldName).DisplayLabel := 'Bina';
      Self.DataSource.DataSet.FindField(FKapiNo.FieldName).DisplayLabel := 'Kapý No';
      Self.DataSource.DataSet.FindField(FPostaKutusu.FieldName).DisplayLabel := 'Posta Kutusu';
      Self.DataSource.DataSet.FindField(FPostaKodu.FieldName).DisplayLabel := 'Posta Kodu';
      Self.DataSource.DataSet.FindField(FWebSitesi.FieldName).DisplayLabel := 'Web Sitesi';
      Self.DataSource.DataSet.FindField(FePostaAdresi.FieldName).DisplayLabel := 'E-Posta Adresi';
    end;
  end;
end;

procedure TAdres.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FUlkeID.FieldName,
        ColumnFromIDCol(TUlke(FUlkeID.FK.FKTable).UlkeAdi.FieldName, FUlkeID.FK.FKTable.TableName, FUlkeID.FieldName, FUlkeID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FSehirID.FieldName,
        ColumnFromIDCol(TSehir(FSehirID.FK.FKTable).SehirAdi.FieldName, FSehirID.FK.FKTable.TableName, FSehirID.FieldName, FSehirID.FK.FKCol.FieldName, TableName),
        TableName + '.' + FIlce.FieldName,
        TableName + '.' + FMahalle.FieldName,
        TableName + '.' + FCadde.FieldName,
        TableName + '.' + FSokak.FieldName,
        TableName + '.' + FBina.FieldName,
        TableName + '.' + FKapiNo.FieldName,
        TableName + '.' + FPostaKutusu.FieldName,
        TableName + '.' + FPostaKodu.FieldName,
        TableName + '.' + FWebSitesi.FieldName,
        TableName + '.' + FePostaAdresi.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FUlkeID.Value := FormatedVariantVal(FieldByName(FUlkeID.FieldName).DataType, FieldByName(FUlkeID.FieldName).Value);
        FUlkeID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FUlkeID.FK.FKCol.FieldName).DataType, FieldByName(FUlkeID.FK.FKCol.FieldName).Value);
        FSehirID.Value := FormatedVariantVal(FieldByName(FSehirID.FieldName).DataType, FieldByName(FSehirID.FieldName).Value);
        FSehirID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FSehirID.FK.FKCol.FieldName).DataType, FieldByName(FSehirID.FK.FKCol.FieldName).Value);
        FIlce.Value := FormatedVariantVal(FieldByName(FIlce.FieldName).DataType, FieldByName(FIlce.FieldName).Value);
        FMahalle.Value := FormatedVariantVal(FieldByName(FMahalle.FieldName).DataType, FieldByName(FMahalle.FieldName).Value);
        FCadde.Value := FormatedVariantVal(FieldByName(FCadde.FieldName).DataType, FieldByName(FCadde.FieldName).Value);
        FSokak.Value := FormatedVariantVal(FieldByName(FSokak.FieldName).DataType, FieldByName(FSokak.FieldName).Value);
        FBina.Value := FormatedVariantVal(FieldByName(FBina.FieldName).DataType, FieldByName(FBina.FieldName).Value);
        FKapiNo.Value := FormatedVariantVal(FieldByName(FKapiNo.FieldName).DataType, FieldByName(FKapiNo.FieldName).Value);
        FPostaKutusu.Value := FormatedVariantVal(FieldByName(FPostaKutusu.FieldName).DataType, FieldByName(FPostaKutusu.FieldName).Value);
        FPostaKodu.Value := FormatedVariantVal(FieldByName(FPostaKodu.FieldName).DataType, FieldByName(FPostaKodu.FieldName).Value);
        FWebSitesi.Value := FormatedVariantVal(FieldByName(FWebSitesi.FieldName).DataType, FieldByName(FWebSitesi.FieldName).Value);
        FePostaAdresi.Value := FormatedVariantVal(FieldByName(FePostaAdresi.FieldName).DataType, FieldByName(FePostaAdresi.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAdres.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
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
        FWebSitesi.FieldName,
        FePostaAdresi.FieldName
      ]);

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
      NewParamForQuery(QueryOfInsert, FWebSitesi);
      NewParamForQuery(QueryOfInsert, FePostaAdresi);

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

procedure TAdres.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
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
        FWebSitesi.FieldName,
        FePostaAdresi.FieldName
      ]);

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
      NewParamForQuery(QueryOfUpdate, FWebSitesi);
      NewParamForQuery(QueryOfUpdate, FePostaAdresi);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TAdres.BusinessSelect(pFilter: string; pLock, pPermissionControl: Boolean);
var
  n1: Integer;
begin
  inherited;
  for n1 := 0 to Self.List.Count-1 do
  begin
    if Assigned(TAdres(Self.List[n1]).FUlkeID.FK.FKTable) then
      TAdres(Self.List[n1]).FUlkeID.FK.FKTable.SelectToList(
          ' AND ' + TAdres(Self.List[n1]).FUlkeID.FK.FKTable.TableName + '.' +
                    TUlke(TAdres(Self.List[n1]).FUlkeID.FK.FKTable).Id.FieldName + '=' + IntToStr(TAdres(Self.List[n1]).FUlkeID.Value), False, False);
    if Assigned(TAdres(Self.List[n1]).FSehirID.FK.FKTable) then
      TAdres(Self.List[n1]).FSehirID.FK.FKTable.SelectToList(
          ' AND ' + TAdres(Self.List[n1]).FSehirID.FK.FKTable.TableName + '.' +
                    TSehir(TAdres(Self.List[n1]).FSehirID.FK.FKTable).Id.FieldName + '=' + IntToStr(TAdres(Self.List[n1]).FSehirID.Value), False, False);
  end;
end;

function TAdres.Clone():TTable;
begin
  Result := TAdres.Create(Database);

  Self.Id.Clone(TAdres(Result).Id);

  FUlkeID.Clone(TAdres(Result).FUlkeID);
  FSehirID.Clone(TAdres(Result).FSehirID);
  FIlce.Clone(TAdres(Result).FIlce);
  FMahalle.Clone(TAdres(Result).FMahalle);
  FCadde.Clone(TAdres(Result).FCadde);
  FSokak.Clone(TAdres(Result).FSokak);
  FBina.Clone(TAdres(Result).FBina);
  FKapiNo.Clone(TAdres(Result).FKapiNo);
  FPostaKutusu.Clone(TAdres(Result).FPostaKutusu);
  FPostaKodu.Clone(TAdres(Result).FPostaKodu);
  FWebSitesi.Clone(TAdres(Result).FWebSitesi);
  FePostaAdresi.Clone(TAdres(Result).FePostaAdresi);
end;

end.
