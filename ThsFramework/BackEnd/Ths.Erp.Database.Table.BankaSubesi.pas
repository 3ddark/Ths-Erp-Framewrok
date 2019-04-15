unit Ths.Erp.Database.Table.BankaSubesi;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Banka,
  Ths.Erp.Database.Table.SysCity;

type
  TBankaSubesi = class(TTable)
  private
    FBankaID: TFieldDB;
    FSubeKodu: TFieldDB;
    FSubeAdi: TFieldDB;
    FSubeIlID: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property BankaID: TFieldDB read FBankaID write FBankaID;
    Property SubeKodu: TFieldDB read FSubeKodu write FSubeKodu;
    Property SubeAdi: TFieldDB read FSubeAdi write FSubeAdi;
    Property SubeIlID: TFieldDB read FSubeIlID write FSubeIlID;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TBankaSubesi.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'banka_subesi';
  SourceCode := '1010';

  FBankaID := TFieldDB.Create('banka_id', ftInteger, 0);
  FSubeKodu := TFieldDB.Create('sube_kodu', ftInteger, 0);
  FSubeAdi := TFieldDB.Create('sube_adi', ftString, '');
  FSubeIlID := TFieldDB.Create('sube_il_id', ftInteger, 0);
end;

procedure TBankaSubesi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FBankaID.FieldName,
        TableName + '.' + FSubeKodu.FieldName,
        TableName + '.' + FSubeAdi.FieldName,
        TableName + '.' + FSubeIlID.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FBankaID.FieldName).DisplayLabel := 'Banka ID';
      Self.DataSource.DataSet.FindField(FSubeKodu.FieldName).DisplayLabel := 'Þube Kodu';
      Self.DataSource.DataSet.FindField(FSubeAdi.FieldName).DisplayLabel := 'Þube Adý';
      Self.DataSource.DataSet.FindField(FSubeIlID.FieldName).DisplayLabel := 'Þube Ýl ID';
    end;
  end;
end;

procedure TBankaSubesi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FBankaID.FieldName,
        TableName + '.' + FSubeKodu.FieldName,
        TableName + '.' + FSubeAdi.FieldName,
        TableName + '.' + FSubeIlID.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FBankaID.Value := FormatedVariantVal(FieldByName(FBankaID.FieldName).DataType, FieldByName(FBankaID.FieldName).Value);
        FSubeKodu.Value := FormatedVariantVal(FieldByName(FSubeKodu.FieldName).DataType, FieldByName(FSubeKodu.FieldName).Value);
        FSubeAdi.Value := FormatedVariantVal(FieldByName(FSubeAdi.FieldName).DataType, FieldByName(FSubeAdi.FieldName).Value);
        FSubeIlID.Value := FormatedVariantVal(FieldByName(FSubeIlID.FieldName).DataType, FieldByName(FSubeIlID.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
    end;
  end;
end;

procedure TBankaSubesi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FBankaID.FieldName,
        FSubeKodu.FieldName,
        FSubeAdi.FieldName,
        FSubeIlID.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FBankaID);
      NewParamForQuery(QueryOfInsert, FSubeKodu);
      NewParamForQuery(QueryOfInsert, FSubeAdi);
      NewParamForQuery(QueryOfInsert, FSubeIlID);

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

procedure TBankaSubesi.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FBankaID.FieldName,
        FSubeKodu.FieldName,
        FSubeAdi.FieldName,
        FSubeIlID.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FBankaID);
      NewParamForQuery(QueryOfUpdate, FSubeKodu);
      NewParamForQuery(QueryOfUpdate, FSubeAdi);
      NewParamForQuery(QueryOfUpdate, FSubeIlID);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TBankaSubesi.Clone():TTable;
begin
  Result := TBankaSubesi.Create(Database);

  Self.Id.Clone(TBankaSubesi(Result).Id);

  FBankaID.Clone(TBankaSubesi(Result).FBankaID);
  FSubeKodu.Clone(TBankaSubesi(Result).FSubeKodu);
  FSubeAdi.Clone(TBankaSubesi(Result).FSubeAdi);
  FSubeIlID.Clone(TBankaSubesi(Result).FSubeIlID);
end;

end.
