unit Ths.Erp.Database.Table.AyarBarkodSeriNoTuru;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TAyarBarkodSeriNoTuru = class(TTable)
  private
    FTur: TFieldDB;
    FAciklama: TFieldDB;
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

    Property Tur: TFieldDB read FTur write FTur;
    Property Aciklama: TFieldDB read FAciklama write FAciklama;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAyarBarkodSeriNoTuru.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ayar_barkod_serino_turu';
  SourceCode := '1000';

  FTur := TFieldDB.Create('tur', ftString, '');
  FAciklama := TFieldDB.Create('aciklama', ftString, '');
end;

procedure TAyarBarkodSeriNoTuru.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FTur.FieldName,
        TableName + '.' + FAciklama.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FTur.FieldName).DisplayLabel := 'Tür';
      Self.DataSource.DataSet.FindField(FAciklama.FieldName).DisplayLabel := 'Açýklama';
    end;
  end;
end;

procedure TAyarBarkodSeriNoTuru.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FTur.FieldName,
        TableName + '.' + FAciklama.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FTur.Value := FormatedVariantVal(FieldByName(FTur.FieldName).DataType, FieldByName(FTur.FieldName).Value);
        FAciklama.Value := FormatedVariantVal(FieldByName(FAciklama.FieldName).DataType, FieldByName(FAciklama.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAyarBarkodSeriNoTuru.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTur.FieldName,
        FAciklama.FieldName
      ]);

      ParamByName(FTur.FieldName).Value := FormatedVariantVal(FTur.FieldType, FTur.Value);
      ParamByName(FAciklama.FieldName).Value := FormatedVariantVal(FAciklama.FieldType, FAciklama.Value);

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

procedure TAyarBarkodSeriNoTuru.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTur.FieldName,
        FAciklama.FieldName
      ]);

      ParamByName(FTur.FieldName).Value := FormatedVariantVal(FTur.FieldType, FTur.Value);
      ParamByName(FAciklama.FieldName).Value := FormatedVariantVal(FAciklama.FieldType, FAciklama.Value);

      ParamByName(Self.Id.FieldName).Value := FormatedVariantVal(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TAyarBarkodSeriNoTuru.Clear();
begin
  inherited;

  FTur.Value := '';
  FAciklama.Value := '';
end;

function TAyarBarkodSeriNoTuru.Clone():TTable;
begin
  Result := TAyarBarkodSeriNoTuru.Create(Database);

  Self.Id.Clone(TAyarBarkodSeriNoTuru(Result).Id);

  FTur.Clone(TAyarBarkodSeriNoTuru(Result).FTur);
  FAciklama.Clone(TAyarBarkodSeriNoTuru(Result).FAciklama);
end;

end.
