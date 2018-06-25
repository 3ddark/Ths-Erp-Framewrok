unit Ths.Erp.Database.Table.SysLang;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TSysLang = class(TTable)
  private
    FLanguage: TFieldDB;
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

    property Language: TFieldDB read FLanguage write FLanguage;
  end;

implementation

uses
  Ths.Erp.Constants;

constructor TSysLang.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_lang';
  SourceCode := '1000';

  FLanguage := TFieldDB.Create('language', ftString, '');
end;

procedure TSysLang.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
    Close;
      SQL.Clear;
      SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FLanguage.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FLanguage.FieldName).DisplayLabel := 'LANGUAGE';
    end;
  end;
end;

procedure TSysLang.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FLanguage.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FieldByName(Self.Id.FieldName).AsInteger;

        Self.FLanguage.Value := FieldByName(FLanguage.FieldName).AsString;

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TSysLang.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Self.Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FLanguage.FieldName
      ]);

      ParamByName(FLanguage.FieldName).Value := Self.FLanguage.Value;

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

procedure TSysLang.Update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FLanguage.FieldName
      ]);

      ParamByName(FLanguage.FieldName).Value := Self.FLanguage.Value;

      ParamByName(Self.Id.FieldName).Value := Self.Id.Value;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
  Self.notify;
  end;
end;

procedure TSysLang.Clear();
begin
  inherited;

  Self.FLanguage.Value := '';
end;

function TSysLang.Clone():TTable;
begin
  Result := TSysLang.Create(Database);

  Self.Id.Clone(TSysLang(Result).Id);

  Self.FLanguage.Clone(TSysLang(Result).FLanguage);
end;

end.

