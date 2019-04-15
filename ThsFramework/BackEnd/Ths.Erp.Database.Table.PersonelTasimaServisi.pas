unit Ths.Erp.Database.Table.PersonelTasimaServisi;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TPersonelTasimaServis = class(TTable)
  private
    FServisNo: TFieldDB;
    FServisAdi: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property ServisNo: TFieldDB read FServisNo write FServisNo;
    Property ServisAdi: TFieldDB read FServisAdi write FServisAdi;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TPersonelTasimaServis.Create(OwnerDatabase:TDatabase);
begin
  TableName := 'personel_tasima_servis';
  SourceCode := '1000';

  inherited Create(OwnerDatabase);

  FServisNo := TFieldDB.Create('servis_no', ftInteger, 0, 0, False, False);
  FServisAdi := TFieldDB.Create('servis_adi', ftString, '', 0, False, False);
end;

procedure TPersonelTasimaServis.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FServisNo.FieldName,
        TableName + '.' + FServisAdi.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FServisNo.FieldName).DisplayLabel := 'Servis No';
      Self.DataSource.DataSet.FindField(FServisAdi.FieldName).DisplayLabel := 'Servis Adý';
    end;
  end;
end;

procedure TPersonelTasimaServis.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FServisNo.FieldName,
        TableName + '.' + FServisAdi.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FServisNo.Value := FormatedVariantVal(FieldByName(FServisNo.FieldName).DataType, FieldByName(FServisNo.FieldName).Value);
        FServisAdi.Value := FormatedVariantVal(FieldByName(FServisAdi.FieldName).DataType, FieldByName(FServisAdi.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TPersonelTasimaServis.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FServisNo.FieldName,
        FServisAdi.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FServisNo);
      NewParamForQuery(QueryOfInsert, FServisAdi);

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

procedure TPersonelTasimaServis.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FServisNo.FieldName,
        FServisAdi.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FServisNo);
      NewParamForQuery(QueryOfUpdate, FServisAdi);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TPersonelTasimaServis.Clone():TTable;
begin
  Result := TPersonelTasimaServis.Create(Database);

  Self.Id.Clone(TPersonelTasimaServis(Result).Id);

  FServisNo.Clone(TPersonelTasimaServis(Result).FServisNo);
  FServisAdi.Clone(TPersonelTasimaServis(Result).FServisAdi);
end;

end.
