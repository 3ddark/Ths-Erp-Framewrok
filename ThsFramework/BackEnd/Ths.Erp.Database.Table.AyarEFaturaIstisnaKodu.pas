unit Ths.Erp.Database.Table.AyarEFaturaIstisnaKodu;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TAyarEFaturaIstisnaKodu = class(TTable)
  private
    FKod: TFieldDB;
    FAciklama: TFieldDB;
    FIsTamIstisna: TFieldDB;
    FFaturaTipID: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property Kod: TFieldDB read FKod write FKod;
    Property Aciklama: TFieldDB read FAciklama write FAciklama;
    Property IsTamIstisna: TFieldDB read FIsTamIstisna write FIsTamIstisna;
    Property FaturaTipID: TFieldDB read FFaturaTipID write FFaturaTipID;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.AyarEFaturaFaturaTipi;

constructor TAyarEFaturaIstisnaKodu.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ayar_efatura_istisna_kodu';
  SourceCode := '1000';

  FKod := TFieldDB.Create('kod', ftString, '', 0, False, False);
  FAciklama := TFieldDB.Create('aciklama', ftString, '', 0, False, False);
  FIsTamIstisna := TFieldDB.Create('is_tam_istisna', ftBoolean, False, 0, False, False);
  FFaturaTipID := TFieldDB.Create('fatura_tip_id', ftInteger, 0, 0, True, False);
  FFaturaTipID.FK.FKTable := TAyarEFaturaFaturaTipi.Create(Database);
  FFaturaTipID.FK.FKCol := TFieldDB.Create('fatura_tipi', ftString, '', 0, False, False);
end;

procedure TAyarEFaturaIstisnaKodu.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FKod.FieldName,
        TableName + '.' + FAciklama.FieldName,
        TableName + '.' + FIsTamIstisna.FieldName,
        TableName + '.' + FFaturaTipID.FieldName,
        ColumnFromIDCol(TAyarEFaturaFaturaTipi(FFaturaTipID.FK.FKTable).Tip.FieldName, FFaturaTipID.FK.FKTable.TableName, FFaturaTipID.FieldName, FFaturaTipID.FK.FKCol.FieldName, TableName)
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FKod.FieldName).DisplayLabel := 'Kod';
      Self.DataSource.DataSet.FindField(FAciklama.FieldName).DisplayLabel := 'A��klama';
      Self.DataSource.DataSet.FindField(FIsTamIstisna.FieldName).DisplayLabel := 'Tam �stisna?';
      Self.DataSource.DataSet.FindField(FFaturaTipID.FieldName).DisplayLabel := 'Fatura Tip ID';
      Self.DataSource.DataSet.FindField(FFaturaTipID.FK.FKCol.FieldName).DisplayLabel := 'Fatura Tipi';
    end;
  end;
end;

procedure TAyarEFaturaIstisnaKodu.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FKod.FieldName,
        TableName + '.' + FAciklama.FieldName,
        TableName + '.' + FIsTamIstisna.FieldName,
        TableName + '.' + FFaturaTipID.FieldName,
        ColumnFromIDCol(TAyarEFaturaFaturaTipi(FFaturaTipID.FK.FKTable).Tip.FieldName, FFaturaTipID.FK.FKTable.TableName, FFaturaTipID.FieldName, FFaturaTipID.FK.FKCol.FieldName, TableName)
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FKod.Value := FormatedVariantVal(FieldByName(FKod.FieldName).DataType, FieldByName(FKod.FieldName).Value);
        FAciklama.Value := FormatedVariantVal(FieldByName(FAciklama.FieldName).DataType, FieldByName(FAciklama.FieldName).Value);
        FIsTamIstisna.Value := FormatedVariantVal(FieldByName(FIsTamIstisna.FieldName).DataType, FieldByName(FIsTamIstisna.FieldName).Value);
        FFaturaTipID.Value := FormatedVariantVal(FieldByName(FFaturaTipID.FieldName).DataType, FieldByName(FFaturaTipID.FieldName).Value);
        FFaturaTipID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FFaturaTipID.FK.FKCol.FieldName).DataType, FieldByName(FFaturaTipID.FK.FKCol.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAyarEFaturaIstisnaKodu.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FKod.FieldName,
        FAciklama.FieldName,
        FIsTamIstisna.FieldName,
        FFaturaTipID.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FKod);
      NewParamForQuery(QueryOfInsert, FAciklama);
      NewParamForQuery(QueryOfInsert, FIsTamIstisna);
      NewParamForQuery(QueryOfInsert, FFaturaTipID);

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

procedure TAyarEFaturaIstisnaKodu.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FKod.FieldName,
        FAciklama.FieldName,
        FIsTamIstisna.FieldName,
        FFaturaTipID.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FKod);
      NewParamForQuery(QueryOfUpdate, FAciklama);
      NewParamForQuery(QueryOfUpdate, FFaturaTipID);
      NewParamForQuery(QueryOfUpdate, FIsTamIstisna);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TAyarEFaturaIstisnaKodu.Clone():TTable;
begin
  Result := TAyarEFaturaIstisnaKodu.Create(Database);

  Self.Id.Clone(TAyarEFaturaIstisnaKodu(Result).Id);

  FKod.Clone(TAyarEFaturaIstisnaKodu(Result).FKod);
  FAciklama.Clone(TAyarEFaturaIstisnaKodu(Result).FAciklama);
  FIsTamIstisna.Clone(TAyarEFaturaIstisnaKodu(Result).FIsTamIstisna);
  FFaturaTipID.Clone(TAyarEFaturaIstisnaKodu(Result).FFaturaTipID);
end;

end.
