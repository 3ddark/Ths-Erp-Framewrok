unit Ths.Erp.Database.Table.AyarPersonelTatilTipi;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TAyarPersonelTatilTipi = class(TTable)
  private
    FDeger: TFieldDB;
    FIsResmiTatil: TFieldDB;
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

    Property Deger: TFieldDB read FDeger write FDeger;
    Property IsResmiTatil: TFieldDB read FIsResmiTatil write FIsResmiTatil;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAyarPersonelTatilTipi.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ayar_personel_tatil_tipi';
  SourceCode := '1000';

  FDeger := TFieldDB.Create('deger', ftString, '');
  FIsResmiTatil := TFieldDB.Create('is_resmi_tatil', ftBoolean, 0);
end;

procedure TAyarPersonelTatilTipi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        getRawDataByLang(TableName, FDeger.FieldName),
        TableName + '.' + FIsResmiTatil.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FDeger.FieldName).DisplayLabel := 'Deðer';
      Self.DataSource.DataSet.FindField(FIsResmiTatil.FieldName).DisplayLabel := 'Resmi Tatil?';
    end;
  end;
end;

procedure TAyarPersonelTatilTipi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        getRawDataByLang(TableName, FDeger.FieldName),
        TableName + '.' + FIsResmiTatil.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FDeger.Value := FormatedVariantVal(FieldByName(FDeger.FieldName).DataType, FieldByName(FDeger.FieldName).Value);
        FIsResmiTatil.Value := FormatedVariantVal(FieldByName(FIsResmiTatil.FieldName).DataType, FieldByName(FIsResmiTatil.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAyarPersonelTatilTipi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FDeger.FieldName,
        FIsResmiTatil.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FDeger);
      NewParamForQuery(QueryOfInsert, FIsResmiTatil);

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

procedure TAyarPersonelTatilTipi.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FDeger.FieldName,
        FIsResmiTatil.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FDeger);
      NewParamForQuery(QueryOfUpdate, FIsResmiTatil);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TAyarPersonelTatilTipi.Clear();
begin
  inherited;

  FDeger.Value := '';
  FIsResmiTatil.Value := 0;
end;

function TAyarPersonelTatilTipi.Clone():TTable;
begin
  Result := TAyarPersonelTatilTipi.Create(Database);

  Self.Id.Clone(TAyarPersonelTatilTipi(Result).Id);

  FDeger.Clone(TAyarPersonelTatilTipi(Result).FDeger);
  FIsResmiTatil.Clone(TAyarPersonelTatilTipi(Result).FIsResmiTatil);
end;

end.
