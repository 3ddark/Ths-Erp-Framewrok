unit Ths.Erp.Database.Table.SysLangContents;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TSysLangContents = class(TTable)
  private
    FLang: TFieldDB;
    FCode: TFieldDB;
    FValue: TFieldDB;
    FIsFactorySettings: TFieldDB;
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

    property Lang: TFieldDB read FLang write FLang;
    property Code: TFieldDB read FCode write FCode;
    property Value: TFieldDB read FValue write FValue;
    property IsFactorySettings: TFieldDB read FIsFactorySettings write FIsFactorySettings;
  end;

implementation

uses
  Ths.Erp.Constants;

constructor TSysLangContents.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_lang_contents';
  SourceCode := '1000';

  FLang := TFieldDB.Create('lang', ftString, '');
  FCode := TFieldDB.Create('code', ftString, '');
  FValue := TFieldDB.Create('value', ftString, '');
  FIsFactorySettings := TFieldDB.Create('is_factory_settings', ftString, False);
end;

procedure TSysLangContents.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
    Close;
      SQL.Clear;
      SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FLang.FieldName,
        TableName + '.' + FCode.FieldName,
        TableName + '.' + FValue.FieldName,
        TableName + '.' + FIsFactorySettings.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FLang.FieldName).DisplayLabel := 'LANG';
      Self.DataSource.DataSet.FindField(FCode.FieldName).DisplayLabel := 'CODE';
      Self.DataSource.DataSet.FindField(FValue.FieldName).DisplayLabel := 'VALUE';
      Self.DataSource.DataSet.FindField(FIsFactorySettings.FieldName).DisplayLabel := 'FACTORY SETTINGS?';
    end;
  end;
end;

procedure TSysLangContents.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FLang.FieldName,
        TableName + '.' + FCode.FieldName,
        TableName + '.' + FValue.FieldName,
        TableName + '.' + FIsFactorySettings.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FieldByName(Self.Id.FieldName).AsInteger;

        Self.FLang.Value := FieldByName(FLang.FieldName).AsString;
        Self.FCode.Value := FieldByName(FCode.FieldName).AsString;
        Self.FValue.Value := FieldByName(FValue.FieldName).AsString;
        Self.FIsFactorySettings.Value := FieldByName(FIsFactorySettings.FieldName).AsBoolean;

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TSysLangContents.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Self.Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FLang.FieldName,
        FCode.FieldName,
        FValue.FieldName,
        FIsFactorySettings.FieldName
      ]);

      ParamByName(FLang.FieldName).Value := Self.FLang.Value;
      ParamByName(FCode.FieldName).Value := Self.FCode.Value;
      ParamByName(FValue.FieldName).Value := Self.FValue.Value;
      ParamByName(FIsFactorySettings.FieldName).Value := Self.FIsFactorySettings.Value;

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

procedure TSysLangContents.Update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FLang.FieldName,
        FCode.FieldName,
        FValue.FieldName,
        FIsFactorySettings.FieldName
      ]);

      ParamByName(FLang.FieldName).Value := Self.FLang.Value;
      ParamByName(FCode.FieldName).Value := Self.FCode.Value;
      ParamByName(FValue.FieldName).Value := Self.FValue.Value;
      ParamByName(FIsFactorySettings.FieldName).Value := Self.FIsFactorySettings.Value;

      ParamByName(Self.Id.FieldName).Value := Self.Id.Value;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
  Self.notify;
  end;
end;

procedure TSysLangContents.Clear();
begin
  inherited;

  Self.FLang.Value := '';
  Self.FCode.Value := '';
  Self.FValue.Value := '';
  Self.FIsFactorySettings.Value := False;
end;

function TSysLangContents.Clone():TTable;
begin
  Result := TSysLangContents.Create(Database);

  Self.Id.Clone(TSysLangContents(Result).Id);

  Self.FLang.Clone(TSysLangContents(Result).FLang);
  Self.FCode.Clone(TSysLangContents(Result).FCode);
  Self.FValue.Clone(TSysLangContents(Result).FValue);
  Self.FIsFactorySettings.Clone(TSysLangContents(Result).FIsFactorySettings);
end;

end.
