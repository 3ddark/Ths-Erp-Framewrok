unit Ths.Erp.Database.Table.HesapPlani;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  THesapPlani = class(TTable)
  private
    FTekDuzenKodu: TFieldDB;
    FPlanKodu: TFieldDB;
    FAciklama: TFieldDB;
    FSeviyeSayisi: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property TekDuzenKodu: TFieldDB read FTekDuzenKodu write FTekDuzenKodu;
    Property Aciklama: TFieldDB read FAciklama write FAciklama;
    Property PlanKodu: TFieldDB read FPlanKodu write FPlanKodu;
    Property SeviyeSayisi: TFieldDB read FSeviyeSayisi write FSeviyeSayisi;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor THesapPlani.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'hesap_plani';
  SourceCode := '1000';

  FTekDuzenKodu := TFieldDB.Create('tek_duzen_kodu', ftString, '');
  FPlanKodu := TFieldDB.Create('plan_kodu', ftString, '');
  FAciklama := TFieldDB.Create('aciklama', ftString, '');
  FSeviyeSayisi := TFieldDB.Create('seviye_sayisi', ftInteger, 0);
end;

procedure THesapPlani.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FTekDuzenKodu.FieldName,
        TableName + '.' + FPlanKodu.FieldName,
        TableName + '.' + FAciklama.FieldName,
        TableName + '.' + FSeviyeSayisi.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FTekDuzenKodu.FieldName).DisplayLabel := 'Tek Düzen Kodu';
      Self.DataSource.DataSet.FindField(FPlanKodu.FieldName).DisplayLabel := 'Plan Kodu';
      Self.DataSource.DataSet.FindField(FAciklama.FieldName).DisplayLabel := 'Açýklama';
      Self.DataSource.DataSet.FindField(FSeviyeSayisi.FieldName).DisplayLabel := 'Seviye Sayýsý';
    end;
  end;
end;

procedure THesapPlani.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FTekDuzenKodu.FieldName,
        TableName + '.' + FPlanKodu.FieldName,
        TableName + '.' + FAciklama.FieldName,
        TableName + '.' + FSeviyeSayisi.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FTekDuzenKodu.Value := FormatedVariantVal(FieldByName(FTekDuzenKodu.FieldName).DataType, FieldByName(FTekDuzenKodu.FieldName).Value);
        FPlanKodu.Value := FormatedVariantVal(FieldByName(FPlanKodu.FieldName).DataType, FieldByName(FPlanKodu.FieldName).Value);
        FAciklama.Value := FormatedVariantVal(FieldByName(FAciklama.FieldName).DataType, FieldByName(FAciklama.FieldName).Value);
        FSeviyeSayisi.Value := FormatedVariantVal(FieldByName(FSeviyeSayisi.FieldName).DataType, FieldByName(FSeviyeSayisi.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure THesapPlani.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTekDuzenKodu.FieldName,
        FAciklama.FieldName,
        FPlanKodu.FieldName,
        FSeviyeSayisi.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FTekDuzenKodu);
      NewParamForQuery(QueryOfInsert, FPlanKodu);
      NewParamForQuery(QueryOfInsert, FAciklama);
      NewParamForQuery(QueryOfInsert, FSeviyeSayisi);

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

procedure THesapPlani.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTekDuzenKodu.FieldName,
        FAciklama.FieldName,
        FPlanKodu.FieldName,
        FSeviyeSayisi.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FTekDuzenKodu);
      NewParamForQuery(QueryOfUpdate, FAciklama);
      NewParamForQuery(QueryOfUpdate, FPlanKodu);
      NewParamForQuery(QueryOfUpdate, FSeviyeSayisi);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function THesapPlani.Clone():TTable;
begin
  Result := THesapPlani.Create(Database);

  Self.Id.Clone(THesapPlani(Result).Id);

  FTekDuzenKodu.Clone(THesapPlani(Result).FTekDuzenKodu);
  FAciklama.Clone(THesapPlani(Result).FAciklama);
  FPlanKodu.Clone(THesapPlani(Result).FPlanKodu);
  FSeviyeSayisi.Clone(THesapPlani(Result).FSeviyeSayisi);
end;

end.
