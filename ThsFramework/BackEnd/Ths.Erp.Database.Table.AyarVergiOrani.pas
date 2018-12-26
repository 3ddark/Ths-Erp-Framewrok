unit Ths.Erp.Database.Table.AyarVergiOrani;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TAyarVergiOrani = class(TTable)
  private
    FVergiOrani: TFieldDB;
    FSatisVergiHesapKodu: TFieldDB;
    FSatisIadeVergiHesapKodu: TFieldDB;
    FAlisVergiHesapKodu: TFieldDB;
    FAlisIadeVergiHesapKodu: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property VergiOrani: TFieldDB read FVergiOrani write FVergiOrani;
    Property SatisVergiHesapKodu: TFieldDB read FSatisVergiHesapKodu write FSatisVergiHesapKodu;
    Property SatisIadeVergiHesapKodu: TFieldDB read FSatisIadeVergiHesapKodu write FSatisIadeVergiHesapKodu;
    Property AlisVergiHesapKodu: TFieldDB read FAlisVergiHesapKodu write FAlisVergiHesapKodu;
    Property AlisIadeVergiHesapKodu: TFieldDB read FAlisIadeVergiHesapKodu write FAlisIadeVergiHesapKodu;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAyarVergiOrani.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ayar_vergi_orani';
  SourceCode := '1000';

  FVergiOrani := TFieldDB.Create('vergi_orani', ftFloat, 0, 2, False);
  FSatisVergiHesapKodu := TFieldDB.Create('satis_vergi_hesap_kodu', ftString, '');
  FSatisIadeVergiHesapKodu := TFieldDB.Create('satis_iade_vergi_hesap_kodu', ftString, '');
  FAlisVergiHesapKodu := TFieldDB.Create('alis_vergi_hesap_kodu', ftString, '');
  FAlisIadeVergiHesapKodu := TFieldDB.Create('alis_iade_vergi_hesap_kodu', ftString, '');
end;

procedure TAyarVergiOrani.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FVergiOrani.FieldName,
        TableName + '.' + FSatisVergiHesapKodu.FieldName,
        TableName + '.' + FSatisIadeVergiHesapKodu.FieldName,
        TableName + '.' + FAlisVergiHesapKodu.FieldName,
        TableName + '.' + FAlisIadeVergiHesapKodu.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FVergiOrani.FieldName).DisplayLabel := 'Vergi Oraný';
      Self.DataSource.DataSet.FindField(FSatisVergiHesapKodu.FieldName).DisplayLabel := 'Satýþ Vergi Hesap Kodu';
      Self.DataSource.DataSet.FindField(FSatisIadeVergiHesapKodu.FieldName).DisplayLabel := 'Satýþ Ýade Vergi Hesap Kodu';
      Self.DataSource.DataSet.FindField(FAlisVergiHesapKodu.FieldName).DisplayLabel := 'Alýþ Vergi Hesap Kodu';
      Self.DataSource.DataSet.FindField(FAlisIadeVergiHesapKodu.FieldName).DisplayLabel := 'Alýþ Ýade Vergi Hesap Kodu';
    end;
  end;
end;

procedure TAyarVergiOrani.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FVergiOrani.FieldName,
        TableName + '.' + FSatisVergiHesapKodu.FieldName,
        TableName + '.' + FSatisIadeVergiHesapKodu.FieldName,
        TableName + '.' + FAlisVergiHesapKodu.FieldName,
        TableName + '.' + FAlisIadeVergiHesapKodu.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FVergiOrani.Value := FormatedVariantVal(FieldByName(FVergiOrani.FieldName).DataType, FieldByName(FVergiOrani.FieldName).Value);
        FSatisVergiHesapKodu.Value := FormatedVariantVal(FieldByName(FSatisVergiHesapKodu.FieldName).DataType, FieldByName(FSatisVergiHesapKodu.FieldName).Value);
        FSatisIadeVergiHesapKodu.Value := FormatedVariantVal(FieldByName(FSatisIadeVergiHesapKodu.FieldName).DataType, FieldByName(FSatisIadeVergiHesapKodu.FieldName).Value);
        FAlisVergiHesapKodu.Value := FormatedVariantVal(FieldByName(FAlisVergiHesapKodu.FieldName).DataType, FieldByName(FAlisVergiHesapKodu.FieldName).Value);
        FAlisIadeVergiHesapKodu.Value := FormatedVariantVal(FieldByName(FAlisIadeVergiHesapKodu.FieldName).DataType, FieldByName(FAlisIadeVergiHesapKodu.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAyarVergiOrani.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FVergiOrani.FieldName,
        FSatisVergiHesapKodu.FieldName,
        FSatisIadeVergiHesapKodu.FieldName,
        FAlisVergiHesapKodu.FieldName,
        FAlisIadeVergiHesapKodu.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FVergiOrani);
      NewParamForQuery(QueryOfInsert, FSatisVergiHesapKodu);
      NewParamForQuery(QueryOfInsert, FSatisIadeVergiHesapKodu);
      NewParamForQuery(QueryOfInsert, FAlisVergiHesapKodu);
      NewParamForQuery(QueryOfInsert, FAlisIadeVergiHesapKodu);

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

procedure TAyarVergiOrani.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FVergiOrani.FieldName,
        FSatisVergiHesapKodu.FieldName,
        FSatisIadeVergiHesapKodu.FieldName,
        FAlisVergiHesapKodu.FieldName,
        FAlisIadeVergiHesapKodu.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FVergiOrani);
      NewParamForQuery(QueryOfUpdate, FSatisVergiHesapKodu);
      NewParamForQuery(QueryOfUpdate, FSatisIadeVergiHesapKodu);
      NewParamForQuery(QueryOfUpdate, FAlisVergiHesapKodu);
      NewParamForQuery(QueryOfUpdate, FAlisIadeVergiHesapKodu);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TAyarVergiOrani.Clone():TTable;
begin
  Result := TAyarVergiOrani.Create(Database);

  Self.Id.Clone(TAyarVergiOrani(Result).Id);

  FVergiOrani.Clone(TAyarVergiOrani(Result).FVergiOrani);
  FSatisVergiHesapKodu.Clone(TAyarVergiOrani(Result).FSatisVergiHesapKodu);
  FSatisIadeVergiHesapKodu.Clone(TAyarVergiOrani(Result).FSatisIadeVergiHesapKodu);
  FAlisVergiHesapKodu.Clone(TAyarVergiOrani(Result).FAlisVergiHesapKodu);
  FAlisIadeVergiHesapKodu.Clone(TAyarVergiOrani(Result).FAlisIadeVergiHesapKodu);
end;

end.
