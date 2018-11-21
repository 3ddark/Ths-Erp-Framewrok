unit Ths.Erp.Database.Table.AyarMukellefTipi;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TAyarMukellefTipi = class(TTable)
  private
    FDeger: TFieldDB;
    FIsDefault: TFieldDB;
  protected
    procedure BusinessInsert(out pID: Integer; var pPermissionControl: Boolean);
      override;
    procedure BusinessUpdate(pPermissionControl: Boolean); override;
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
    Property IsDefault: TFieldDB read FIsDefault write FIsDefault;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAyarMukellefTipi.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ayar_mukellef_tipi';
  SourceCode := '1000';

  FDeger := TFieldDB.Create('deger', ftString, '');
  FIsDefault := TFieldDB.Create('is_default', ftBoolean, False);
end;

procedure TAyarMukellefTipi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FDeger.FieldName,
        TableName + '.' + FIsDefault.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'Id';
      Self.DataSource.DataSet.FindField(FDeger.FieldName).DisplayLabel := 'Deðer';
      Self.DataSource.DataSet.FindField(FIsDefault.FieldName).DisplayLabel := 'Varsayýlan?';
    end;
  end;
end;

procedure TAyarMukellefTipi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FDeger.FieldName,
        TableName + '.' + FIsDefault.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FDeger.Value := FormatedVariantVal(FieldByName(FDeger.FieldName).DataType, FieldByName(FDeger.FieldName).Value);
        FIsDefault.Value := FormatedVariantVal(FieldByName(FIsDefault.FieldName).DataType, FieldByName(FIsDefault.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAyarMukellefTipi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FDeger.FieldName,
        FIsDefault.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FDeger);
      NewParamForQuery(QueryOfInsert, FIsDefault);

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

procedure TAyarMukellefTipi.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FDeger.FieldName, FIsDefault.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FDeger);
      NewParamForQuery(QueryOfUpdate, FIsDefault);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TAyarMukellefTipi.BusinessInsert(out pID: Integer;
  var pPermissionControl: Boolean);
var
  mukellef: TAyarMukellefTipi;
  n1: Integer;
begin
  if Self.IsDefault.Value then
  begin
    mukellef := TAyarMukellefTipi.Create(Database);
    try
      mukellef.SelectToList('', False, False);
      for n1 := 0 to mukellef.List.Count-1 do
      begin
        TAyarMukellefTipi(mukellef.List[n1]).IsDefault.Value := False;
        TAyarMukellefTipi(mukellef.List[n1]).Update(pPermissionControl);
      end;
    finally
      mukellef.Free;
    end;
  end;
  Self.Insert(pID, pPermissionControl);
end;

procedure TAyarMukellefTipi.BusinessUpdate(pPermissionControl: Boolean);
var
  mukellef: TAyarMukellefTipi;
  n1: Integer;
begin
  if Self.IsDefault.Value then
  begin
    mukellef := TAyarMukellefTipi.Create(Database);
    try
      mukellef.SelectToList('', False, False);
      for n1 := 0 to mukellef.List.Count-1 do
      begin
        TAyarMukellefTipi(mukellef.List[n1]).IsDefault.Value := False;
        TAyarMukellefTipi(mukellef.List[n1]).Update(pPermissionControl);
      end;
    finally
      mukellef.Free;
    end;
  end;
  Self.Update(pPermissionControl);
end;

procedure TAyarMukellefTipi.Clear();
begin
  inherited;

  FDeger.Value := '';
  FIsDefault.Value := False;
end;

function TAyarMukellefTipi.Clone():TTable;
begin
  Result := TAyarMukellefTipi.Create(Database);

  Self.Id.Clone(TAyarMukellefTipi(Result).Id);

  FDeger.Clone(TAyarMukellefTipi(Result).FDeger);
  FIsDefault.Clone(TAyarMukellefTipi(Result).FIsDefault);
end;

end.
