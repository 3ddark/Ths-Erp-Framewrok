unit Ths.Erp.Database.Table.AyarPersonelBirim;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TAyarPersonelBirim = class(TTable)
  private
    FBolumID: TFieldDB;
    FBirim: TFieldDB;
    //database alaný deðil
    FBolum: TFieldDB;
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

    Property BolumID: TFieldDB read FBolumID write FBolumID;
    Property Birim: TFieldDB read FBirim write FBirim;
    //database alaný deðil
    Property Bolum: TFieldDB read FBolum write FBolum;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.AyarPersonelBolum;

constructor TAyarPersonelBirim.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ayar_personel_birim';
  SourceCode := '1020';

  FBolumID := TFieldDB.Create('bolum_id', ftInteger, '');
  FBirim := TFieldDB.Create('birim', ftString, '');
  //database alaný deðil
  FBolum := TFieldDB.Create('bolum', ftString, '');
end;

procedure TAyarPersonelBirim.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
var
  vPersonelBolum: TAyarPersonelBolum;
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    vPersonelBolum := TAyarPersonelBolum.Create(Database);
    try
      with QueryOfTable do
      begin
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FBolumID.FieldName,
          ColumnFromIDCol(vPersonelBolum.Bolum.FieldName, vPersonelBolum.TableName, FBolumID.FieldName, FBolum.FieldName, TableName),
          GetRawDataSQLByLang(TableName, FBirim.FieldName)
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;
        Active := True;

        Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
        Self.DataSource.DataSet.FindField(FBolumID.FieldName).DisplayLabel := 'Bölüm ID';
        Self.DataSource.DataSet.FindField(FBolum.FieldName).DisplayLabel := 'Bölüm';
        Self.DataSource.DataSet.FindField(FBirim.FieldName).DisplayLabel := 'Birim';
      end;
    finally
      vPersonelBolum.Free;
    end;
  end;
end;

procedure TAyarPersonelBirim.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FBolumID.FieldName,
        GetRawDataSQLByLang(TableName, FBirim.FieldName)
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FBolumID.Value := FormatedVariantVal(FieldByName(FBolumID.FieldName).DataType, FieldByName(FBolumID.FieldName).Value);
        FBirim.Value := FormatedVariantVal(FieldByName(FBirim.FieldName).DataType, FieldByName(FBirim.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAyarPersonelBirim.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FBolumID.FieldName,
        FBirim.FieldName
      ]);

      NewParamForQuery(QueryOfTable, FBolumID);
      NewParamForQuery(QueryOfTable, FBirim);

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

procedure TAyarPersonelBirim.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FBolumID.FieldName,
        FBirim.FieldName
      ]);

      NewParamForQuery(QueryOfTable, FBolumID);
      NewParamForQuery(QueryOfTable, FBirim);

      NewParamForQuery(QueryOfTable, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TAyarPersonelBirim.Clear();
begin
  inherited;

  FBolumID.Value := '';
  FBolum.Value := '';
  FBirim.Value := '';
end;

function TAyarPersonelBirim.Clone():TTable;
begin
  Result := TAyarPersonelBirim.Create(Database);

  Self.Id.Clone(TAyarPersonelBirim(Result).Id);

  FBolumID.Clone(TAyarPersonelBirim(Result).FBolumID);
  FBolum.Clone(TAyarPersonelBirim(Result).FBolum);
  FBirim.Clone(TAyarPersonelBirim(Result).FBirim);
end;

end.
