unit Ths.Erp.Database.Table.AyarPrsEhliyetTipi;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TAyarPrsEhliyetTipi = class(TTable)
  private
    FEhliyetTipi: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property EhliyetTipi: TFieldDB read FEhliyetTipi write FEhliyetTipi;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAyarPrsEhliyetTipi.Create(OwnerDatabase:TDatabase);
begin
  TableName := 'ayar_prs_ehliyet_tipi';
  SourceCode := '1000';

  inherited Create(OwnerDatabase);

  FEhliyetTipi := TFieldDB.Create('ehliyet_tipi', ftString, '');
end;

procedure TAyarPrsEhliyetTipi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        getRawDataByLang(TableName, FEhliyetTipi.FieldName)
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FEhliyetTipi.FieldName).DisplayLabel := 'Ehliyet Tipi';
    end;
  end;
end;

procedure TAyarPrsEhliyetTipi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        getRawDataByLang(TableName, FEhliyetTipi.FieldName)
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FEhliyetTipi.Value := FormatedVariantVal(FieldByName(FEhliyetTipi.FieldName).DataType, FieldByName(FEhliyetTipi.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAyarPrsEhliyetTipi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FEhliyetTipi.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FEhliyetTipi);

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

procedure TAyarPrsEhliyetTipi.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FEhliyetTipi.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FEhliyetTipi);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TAyarPrsEhliyetTipi.Clone():TTable;
begin
  Result := TAyarPrsEhliyetTipi.Create(Database);

  Self.Id.Clone(TAyarPrsEhliyetTipi(Result).Id);

  FEhliyetTipi.Clone(TAyarPrsEhliyetTipi(Result).FEhliyetTipi);
end;

end.
