unit frmMainHesapGrubu;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  HesapGrubu = class(TTable)
  private
    FGrup: TFieldDB;
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

    property Grup: TFieldDB read FGrup write FGrup;
  end;

implementation

uses
  Ths.Erp.Constants;

constructor HesapGrubu.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'hesap_grubu';
  SourceCode := '1000';

  FGrup := TFieldDB.Create('grup', ftString, '');
end;

procedure HesapGrubu.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
    Close;
      SQL.Clear;
      SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FGrup.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FGrup.FieldName).DisplayLabel := 'GRUP';
    end;
  end;
end;

procedure HesapGrubu.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
      pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

    with QueryOfTable do
    begin
      Close;
      SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FGrup.FieldName
      ]);
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FieldByName(Self.Id.FieldName).AsInteger;

        Self.FGrup.Value := FieldByName(FGrup.FieldName).AsString;

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure HesapGrubu.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Self.Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FGrup.FieldName
      ]);

      ParamByName(FGrup.FieldName).Value := Self.FGrup.GetVarToFormatedValue;

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

procedure HesapGrubu.Update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FGrup.FieldName
      ]);

      ParamByName(FGrup.FieldName).Value := Self.FGrup.GetVarToFormatedValue;

      ParamByName(Self.Id.FieldName).Value := Self.Id.Value;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
  Self.notify;
  end;
end;

procedure HesapGrubu.Clear();
begin
  inherited;

  Self.FGrup.Value := '';
end;

function HesapGrubu.Clone():TTable;
begin
  Result := HesapGrubu.Create(Database);

  Self.Id.Clone(HesapGrubu(Result).Id);

  Self.FGrup.Clone(HesapGrubu(Result).FGrup);
end;

end.
