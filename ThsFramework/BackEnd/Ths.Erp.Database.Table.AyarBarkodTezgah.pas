unit Ths.Erp.Database.Table.AyarBarkodTezgah;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field,
  Ths.Erp.Database.Table.Ambar;

type
  TAyarBarkodTezgah = class(TTable)
  private
    FTezgahAdi: TFieldDB;
    FAmbarID: TFieldDB;
    FAmbar: TFieldDB;
  protected
    vAmbar: TAmbar;
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property TezgahAdi: TFieldDB read FTezgahAdi write FTezgahAdi;
    Property AmbarID: TFieldDB read FAmbarID write FAmbarID;
    Property Ambar: TFieldDB read FAmbar write FAmbar;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAyarBarkodTezgah.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ayar_barkod_tezgah';
  SourceCode := '1000';

  FTezgahAdi := TFieldDB.Create('tezgah_adi', ftString, '');
  FAmbarID := TFieldDB.Create('ambar_id', ftInteger, 0);
  FAmbar := TFieldDB.Create('ambar', ftString, '');
end;

procedure TAyarBarkodTezgah.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    vAmbar := TAmbar.Create(Database);
    try
      with QueryOfTable do
      begin
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          GetRawDataSQLByLang(TableName, FTezgahAdi.FieldName),
          TableName + '.' + FAmbarID.FieldName,
          ColumnFromIDCol(vAmbar.AmbarAdi.FieldName, vAmbar.TableName, FAmbarID.FieldName, FAmbar.FieldName)
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;
        Active := True;

        Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
        Self.DataSource.DataSet.FindField(FTezgahAdi.FieldName).DisplayLabel := 'Tezgah Adý';
        Self.DataSource.DataSet.FindField(FAmbarID.FieldName).DisplayLabel := 'Ambar ID';
        Self.DataSource.DataSet.FindField(FAmbar.FieldName).DisplayLabel := 'Ambar';
      end;
    finally
      vAmbar.Free;
    end;
  end;
end;

procedure TAyarBarkodTezgah.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
      pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

    vAmbar := TAmbar.Create(Database);
    try
      with QueryOfTable do
      begin
        Close;
        SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          GetRawDataSQLByLang(TableName, FTezgahAdi.FieldName),
          TableName + '.' + FAmbarID.FieldName,
          ColumnFromIDCol(vAmbar.AmbarAdi.FieldName, vAmbar.TableName, FAmbarID.FieldName, FAmbar.FieldName)
        ]) +
        'WHERE 1=1 ' + pFilter;
        Open;

        FreeListContent();
        List.Clear;
        while NOT EOF do
        begin
          Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

          FTezgahAdi.Value := FormatedVariantVal(FieldByName(FTezgahAdi.FieldName).DataType, FieldByName(FTezgahAdi.FieldName).Value);
          FAmbarID.Value := FormatedVariantVal(FieldByName(FAmbarID.FieldName).DataType, FieldByName(FAmbarID.FieldName).Value);
          FAmbar.Value := FormatedVariantVal(FieldByName(FAmbar.FieldName).DataType, FieldByName(FAmbar.FieldName).Value);

          List.Add(Self.Clone());

          Next;
        end;
        Close;
      end;
    finally
      vAmbar.Free;
    end;
  end;
end;

procedure TAyarBarkodTezgah.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTezgahAdi.FieldName,
        FAmbarID.FieldName
      ]);

      ParamByName(FTezgahAdi.FieldName).Value := FormatedVariantVal(FTezgahAdi.FieldType, FTezgahAdi.Value);
      ParamByName(FAmbarID.FieldName).Value := FormatedVariantVal(FAmbarID.FieldType, FAmbarID.Value);

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

procedure TAyarBarkodTezgah.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTezgahAdi.FieldName,
        FAmbarID.FieldName
      ]);

      ParamByName(FTezgahAdi.FieldName).Value := FormatedVariantVal(FTezgahAdi.FieldType, FTezgahAdi.Value);
      ParamByName(FAmbarID.FieldName).Value := FormatedVariantVal(FAmbarID.FieldType, FAmbarID.Value);

      ParamByName(Self.Id.FieldName).Value := FormatedVariantVal(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TAyarBarkodTezgah.Clear();
begin
  inherited;

  FTezgahAdi.Value := '';
  FAmbarID.Value := 0;
  FAmbar.Value := '';
end;

function TAyarBarkodTezgah.Clone():TTable;
begin
  Result := TAyarBarkodTezgah.Create(Database);

  Self.Id.Clone(TAyarBarkodTezgah(Result).Id);

  FTezgahAdi.Clone(TAyarBarkodTezgah(Result).FTezgahAdi);
  FAmbarID.Clone(TAyarBarkodTezgah(Result).FAmbarID);
  FAmbar.Clone(TAyarBarkodTezgah(Result).FAmbar);
end;

end.
