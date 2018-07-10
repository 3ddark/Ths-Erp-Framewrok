unit Ths.Erp.Database.Table.AyarEFaturaIstisnaKodu;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TAyarEFaturaIstisnaKodu = class(TTable)
  private
    FKod: TFieldDB;
    FAciklama: TFieldDB;
    FFaturaTipi: TFieldDB;
    FFaturaTipID: TFieldDB;
    FIsTamIstisna: TFieldDB;
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

    Property Kod: TFieldDB read FKod write FKod;
    Property Aciklama: TFieldDB read FAciklama write FAciklama;
    Property FaturaTipi: TFieldDB read FFaturaTipi write FFaturaTipi;
    Property FaturaTipID: TFieldDB read FFaturaTipID write FFaturaTipID;
    Property IsTamIstisna: TFieldDB read FIsTamIstisna write FIsTamIstisna;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton, Ths.Erp.Database.Table.AyarEFaturaFaturaTipi;

constructor TAyarEFaturaIstisnaKodu.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ayar_efatura_istisna_kodu';
  SourceCode := '1000';

  FKod := TFieldDB.Create('kod', ftString, '');
  FAciklama := TFieldDB.Create('aciklama', ftString, '');
  FFaturaTipi := TFieldDB.Create('fatura_tipi', ftString, '');
  FFaturaTipID := TFieldDB.Create('fatura_tip_id', ftInteger, 0);
  FIsTamIstisna := TFieldDB.Create('is_tam_istisna', ftBoolean, 0);
end;

procedure TAyarEFaturaIstisnaKodu.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
var
  vEFaturaTipi: TAyarEFaturaFaturaTipi;
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      vEFaturaTipi := TAyarEFaturaFaturaTipi.Create(Self.Database);
      try
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FKod.FieldName,
          TableName + '.' + FAciklama.FieldName,
          TSingletonDB.GetInstance.GetLangTextSQL(vEFaturaTipi.Tip.FieldName, vEFaturaTipi.TableName, FFaturaTipID.FieldName, FFaturaTipi.FieldName),
          TableName + '.' + FFaturaTipID.FieldName,
          TableName + '.' + FIsTamIstisna.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;
        Active := True;

        Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
        Self.DataSource.DataSet.FindField(FKod.FieldName).DisplayLabel := 'Kod';
        Self.DataSource.DataSet.FindField(FAciklama.FieldName).DisplayLabel := 'Açýklama';
        Self.DataSource.DataSet.FindField(FFaturaTipi.FieldName).DisplayLabel := 'Fatura Tipi';
        Self.DataSource.DataSet.FindField(FFaturaTipID.FieldName).DisplayLabel := 'Fatura Tip ID';
        Self.DataSource.DataSet.FindField(FIsTamIstisna.FieldName).DisplayLabel := 'Tam Ýstisna?';
      finally
        vEFaturaTipi.Free;
      end;
    end;
  end;
end;

procedure TAyarEFaturaIstisnaKodu.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FKod.FieldName,
        TableName + '.' + FAciklama.FieldName,
        TableName + '.' + FFaturaTipi.FieldName,
        TableName + '.' + FFaturaTipID.FieldName,
        TableName + '.' + FIsTamIstisna.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := GetVarToFormatedValue(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FKod.Value := GetVarToFormatedValue(FieldByName(FKod.FieldName).DataType, FieldByName(FKod.FieldName).Value);
        FAciklama.Value := GetVarToFormatedValue(FieldByName(FAciklama.FieldName).DataType, FieldByName(FAciklama.FieldName).Value);
        FFaturaTipi.Value := GetVarToFormatedValue(FieldByName(FFaturaTipi.FieldName).DataType, FieldByName(FFaturaTipi.FieldName).Value);
        FFaturaTipID.Value := GetVarToFormatedValue(FieldByName(FFaturaTipID.FieldName).DataType, FieldByName(FFaturaTipID.FieldName).Value);
        FIsTamIstisna.Value := GetVarToFormatedValue(FieldByName(FIsTamIstisna.FieldName).DataType, FieldByName(FIsTamIstisna.FieldName).Value);

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
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FKod.FieldName,
        FAciklama.FieldName,
        FFaturaTipi.FieldName,
        FFaturaTipID.FieldName,
        FIsTamIstisna.FieldName
      ]);

      ParamByName(FKod.FieldName).Value := GetVarToFormatedValue(FKod.FieldType, FKod.Value);
      ParamByName(FAciklama.FieldName).Value := GetVarToFormatedValue(FAciklama.FieldType, FAciklama.Value);
      ParamByName(FFaturaTipi.FieldName).Value := GetVarToFormatedValue(FFaturaTipi.FieldType, FFaturaTipi.Value);
      ParamByName(FFaturaTipID.FieldName).Value := GetVarToFormatedValue(FFaturaTipID.FieldType, FFaturaTipID.Value);
      ParamByName(FIsTamIstisna.FieldName).Value := GetVarToFormatedValue(FIsTamIstisna.FieldType, FIsTamIstisna.Value);

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

procedure TAyarEFaturaIstisnaKodu.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FKod.FieldName,
        FAciklama.FieldName,
        FFaturaTipi.FieldName,
        FFaturaTipID.FieldName,
        FIsTamIstisna.FieldName
      ]);

      ParamByName(FKod.FieldName).Value := GetVarToFormatedValue(FKod.FieldType, FKod.Value);
      ParamByName(FAciklama.FieldName).Value := GetVarToFormatedValue(FAciklama.FieldType, FAciklama.Value);
      ParamByName(FFaturaTipi.FieldName).Value := GetVarToFormatedValue(FFaturaTipi.FieldType, FFaturaTipi.Value);
      ParamByName(FFaturaTipID.FieldName).Value := GetVarToFormatedValue(FFaturaTipID.FieldType, FFaturaTipID.Value);
      ParamByName(FIsTamIstisna.FieldName).Value := GetVarToFormatedValue(FIsTamIstisna.FieldType, FIsTamIstisna.Value);

      ParamByName(Self.Id.FieldName).Value := GetVarToFormatedValue(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TAyarEFaturaIstisnaKodu.Clear();
begin
  inherited;

  FKod.Value := '';
  FAciklama.Value := '';
  FFaturaTipi.Value := '';
  FFaturaTipID.Value := 0;
  FIsTamIstisna.Value := 0;
end;

function TAyarEFaturaIstisnaKodu.Clone():TTable;
begin
  Result := TAyarEFaturaIstisnaKodu.Create(Database);

  Self.Id.Clone(TAyarEFaturaIstisnaKodu(Result).Id);

  FKod.Clone(TAyarEFaturaIstisnaKodu(Result).FKod);
  FAciklama.Clone(TAyarEFaturaIstisnaKodu(Result).FAciklama);
  FFaturaTipi.Clone(TAyarEFaturaIstisnaKodu(Result).FFaturaTipi);
  FFaturaTipID.Clone(TAyarEFaturaIstisnaKodu(Result).FFaturaTipID);
  FIsTamIstisna.Clone(TAyarEFaturaIstisnaKodu(Result).FIsTamIstisna);
end;

end.
