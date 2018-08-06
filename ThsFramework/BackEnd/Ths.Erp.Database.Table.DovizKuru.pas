unit Ths.Erp.Database.Table.DovizKuru;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TDovizKuru = class(TTable)
  private
    FTarih: TFieldDB;
    FParaBirimi: TFieldDB;
    FKur: TFieldDB;
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

    Property Tarih: TFieldDB read FTarih write FTarih;
    Property ParaBirimi: TFieldDB read FParaBirimi write FParaBirimi;
    Property Kur: TFieldDB read FKur write FKur;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TDovizKuru.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'doviz_kuru';
  SourceCode := '1009';

  FTarih := TFieldDB.Create('tarih', ftDate, 0);
  FParaBirimi := TFieldDB.Create('para_birimi', ftString, '');
  FKur := TFieldDB.Create('kur', ftFloat, 0);
end;

procedure TDovizKuru.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FTarih.FieldName,
        TableName + '.' + FParaBirimi.FieldName,
        TableName + '.' + FKur.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FTarih.FieldName).DisplayLabel := 'Tarih';
      Self.DataSource.DataSet.FindField(FParaBirimi.FieldName).DisplayLabel := 'Para Birimi';
      Self.DataSource.DataSet.FindField(FKur.FieldName).DisplayLabel := 'Kur';
    end;
  end;
end;

procedure TDovizKuru.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FTarih.FieldName,
        TableName + '.' + FParaBirimi.FieldName,
        TableName + '.' + FKur.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FTarih.Value := FormatedVariantVal(FieldByName(FTarih.FieldName).DataType, FieldByName(FTarih.FieldName).Value);
        FParaBirimi.Value := FormatedVariantVal(FieldByName(FParaBirimi.FieldName).DataType, FieldByName(FParaBirimi.FieldName).Value);
        FKur.Value := FormatedVariantVal(FieldByName(FKur.FieldName).DataType, FieldByName(FKur.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TDovizKuru.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTarih.FieldName,
        FParaBirimi.FieldName,
        FKur.FieldName
      ]);

      ParamByName(FTarih.FieldName).Value := FormatedVariantVal(FTarih.FieldType, FTarih.Value);
      ParamByName(FParaBirimi.FieldName).Value := FormatedVariantVal(FParaBirimi.FieldType, FParaBirimi.Value);
      ParamByName(FKur.FieldName).Value := FormatedVariantVal(FKur.FieldType, FKur.Value);

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

procedure TDovizKuru.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTarih.FieldName,
        FParaBirimi.FieldName,
        FKur.FieldName
      ]);

      ParamByName(FTarih.FieldName).Value := FormatedVariantVal(FTarih.FieldType, FTarih.Value);
      ParamByName(FParaBirimi.FieldName).Value := FormatedVariantVal(FParaBirimi.FieldType, FParaBirimi.Value);
      ParamByName(FKur.FieldName).Value := FormatedVariantVal(FKur.FieldType, FKur.Value);

      ParamByName(Self.Id.FieldName).Value := FormatedVariantVal(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TDovizKuru.Clear();
begin
  inherited;

  FTarih.Value := 0;
  FParaBirimi.Value := '';
  FKur.Value := 0;
end;

function TDovizKuru.Clone():TTable;
begin
  Result := TDovizKuru.Create(Database);

  Self.Id.Clone(TDovizKuru(Result).Id);

  FTarih.Clone(TDovizKuru(Result).FTarih);
  FParaBirimi.Clone(TDovizKuru(Result).FParaBirimi);
  FKur.Clone(TDovizKuru(Result).FKur);
end;

end.
