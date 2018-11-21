unit Ths.Erp.Database.Table.PersonelPDKSKart;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TPersonelPDKSKart = class(TTable)
  private
    FKartID: TFieldDB;
    FPersonelNo: TFieldDB;
    FKartNo: TFieldDB;
    FIsActive: TFieldDB;
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

    Property KartID: TFieldDB read FKartID write FKartID;
    Property PersonelNo: TFieldDB read FPersonelNo write FPersonelNo;
    Property KartNo: TFieldDB read FKartNo write FKartNo;
    Property IsActive: TFieldDB read FIsActive write FIsActive;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TPersonelPDKSKart.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'personel_pdks_kart';
  SourceCode := '1000';

  FKartID := TFieldDB.Create('kart_id', ftString, '');
  FPersonelNo := TFieldDB.Create('personel_ no', ftInteger, 0);
  FKartNo := TFieldDB.Create('kart_no', ftInteger, 0);
  FIsActive := TFieldDB.Create('is_active', ftBoolean, 0);
end;

procedure TPersonelPDKSKart.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FKartID.FieldName,
        TableName + '.' + FPersonelNo.FieldName,
        TableName + '.' + FKartNo.FieldName,
        TableName + '.' + FIsActive.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FKartID.FieldName).DisplayLabel := 'Kart ID';
      Self.DataSource.DataSet.FindField(FPersonelNo.FieldName).DisplayLabel := 'Personel No';
      Self.DataSource.DataSet.FindField(FKartNo.FieldName).DisplayLabel := 'Kart No';
      Self.DataSource.DataSet.FindField(FIsActive.FieldName).DisplayLabel := 'Aktif?';
    end;
  end;
end;

procedure TPersonelPDKSKart.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FKartID.FieldName,
        TableName + '.' + FPersonelNo.FieldName,
        TableName + '.' + FKartNo.FieldName,
        TableName + '.' + FIsActive.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FKartID.Value := FormatedVariantVal(FieldByName(FKartID.FieldName).DataType, FieldByName(FKartID.FieldName).Value);
        FPersonelNo.Value := FormatedVariantVal(FieldByName(FPersonelNo.FieldName).DataType, FieldByName(FPersonelNo.FieldName).Value);
        FKartNo.Value := FormatedVariantVal(FieldByName(FKartNo.FieldName).DataType, FieldByName(FKartNo.FieldName).Value);
        FIsActive.Value := FormatedVariantVal(FieldByName(FIsActive.FieldName).DataType, FieldByName(FIsActive.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TPersonelPDKSKart.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FKartID.FieldName,
        FPersonelNo.FieldName,
        FKartNo.FieldName,
        FIsActive.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FKartID);
      NewParamForQuery(QueryOfInsert, FPersonelNo);
      NewParamForQuery(QueryOfInsert, FKartNo);
      NewParamForQuery(QueryOfInsert, FIsActive);

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

procedure TPersonelPDKSKart.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FKartID.FieldName,
        FPersonelNo.FieldName,
        FKartNo.FieldName,
        FIsActive.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FKartID);
      NewParamForQuery(QueryOfUpdate, FPersonelNo);
      NewParamForQuery(QueryOfUpdate, FKartNo);
      NewParamForQuery(QueryOfUpdate, FIsActive);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TPersonelPDKSKart.Clear();
begin
  inherited;

  FKartID.Value := '';
  FPersonelNo.Value := 0;
  FKartNo.Value := 0;
  FIsActive.Value := 0;
end;

function TPersonelPDKSKart.Clone():TTable;
begin
  Result := TPersonelPDKSKart.Create(Database);

  Self.Id.Clone(TPersonelPDKSKart(Result).Id);

  FKartID.Clone(TPersonelPDKSKart(Result).FKartID);
  FPersonelNo.Clone(TPersonelPDKSKart(Result).FPersonelNo);
  FKartNo.Clone(TPersonelPDKSKart(Result).FKartNo);
  FIsActive.Clone(TPersonelPDKSKart(Result).FIsActive);
end;

end.
