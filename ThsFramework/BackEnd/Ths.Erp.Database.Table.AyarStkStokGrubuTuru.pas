unit Ths.Erp.Database.Table.AyarStkStokGrubuTuru;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TAyarStkStokGrubuTuru = class(TTable)
  private
    FStokGrubuTur: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property StokGrubuTur: TFieldDB read FStokGrubuTur write FStokGrubuTur;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAyarStkStokGrubuTuru.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ayar_stk_stok_grubu_turu';
  SourceCode := '1000';

  FStokGrubuTur := TFieldDB.Create('stok_grubu_tur', ftString, '');
end;

procedure TAyarStkStokGrubuTuru.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FStokGrubuTur.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FStokGrubuTur.FieldName).DisplayLabel := 'Tür';
    end;
  end;
end;

procedure TAyarStkStokGrubuTuru.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FStokGrubuTur.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FStokGrubuTur.Value := FormatedVariantVal(FieldByName(FStokGrubuTur.FieldName).DataType, FieldByName(FStokGrubuTur.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAyarStkStokGrubuTuru.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FStokGrubuTur.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FStokGrubuTur);

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

procedure TAyarStkStokGrubuTuru.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FStokGrubuTur.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FStokGrubuTur);

      NewParamForQuery(QueryOfUpdate, Id);
      
      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TAyarStkStokGrubuTuru.Clone():TTable;
begin
  Result := TAyarStkStokGrubuTuru.Create(Database);

  Self.Id.Clone(TAyarStkStokGrubuTuru(Result).Id);

  FStokGrubuTur.Clone(TAyarStkStokGrubuTuru(Result).FStokGrubuTur);
end;

end.
