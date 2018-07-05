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
    FIsFactorySetting: TFieldDB;
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
    property IsFactorySetting: TFieldDB read FIsFactorySetting write FIsFactorySetting;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSysLangContents.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_lang_contents';
  SourceCode := '1000';

  FLang := TFieldDB.Create('lang', ftString, '');
  FCode := TFieldDB.Create('code', ftString, '');
  FValue := TFieldDB.Create('value', ftString, '');
  FIsFactorySetting := TFieldDB.Create('is_factory_setting', ftBoolean, False);
end;

procedure TSysLangContents.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
    Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FLang.FieldName,
        TableName + '.' + FCode.FieldName,
        TableName + '.' + FValue.FieldName + '::varchar ',
        TableName + '.' + FIsFactorySetting.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FLang.FieldName).DisplayLabel := 'LANG';
      Self.DataSource.DataSet.FindField(FCode.FieldName).DisplayLabel := 'CODE';
      Self.DataSource.DataSet.FindField(FValue.FieldName).DisplayLabel := 'VALUE';
      Self.DataSource.DataSet.FindField(FIsFactorySetting.FieldName).DisplayLabel := 'FACTORY SETTING?';
    end;
  end;
end;

procedure TSysLangContents.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FLang.FieldName,
        TableName + '.' + FCode.FieldName,
        TableName + '.' + FValue.FieldName,
        TableName + '.' + FIsFactorySetting.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := GetVarToFormatedValue(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FLang.Value := GetVarToFormatedValue(FieldByName(FLang.FieldName).DataType, FieldByName(FLang.FieldName).Value);
        FCode.Value := GetVarToFormatedValue(FieldByName(FCode.FieldName).DataType, FieldByName(FCode.FieldName).Value);
        FValue.Value := GetVarToFormatedValue(FieldByName(FValue.FieldName).DataType, FieldByName(FValue.FieldName).Value);
        FIsFactorySetting.Value := GetVarToFormatedValue(FieldByName(FIsFactorySetting.FieldName).DataType, FieldByName(FIsFactorySetting.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TSysLangContents.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FLang.FieldName,
        FCode.FieldName,
        FValue.FieldName,
        FIsFactorySetting.FieldName
      ]);

      ParamByName(FLang.FieldName).Value := GetVarToFormatedValue(FLang.FieldType, FLang.Value);
      ParamByName(FCode.FieldName).Value := GetVarToFormatedValue(FCode.FieldType, FCode.Value);
      ParamByName(FValue.FieldName).Value := GetVarToFormatedValue(FValue.FieldType, FValue.Value);
      ParamByName(FIsFactorySetting.FieldName).Value := GetVarToFormatedValue(FIsFactorySetting.FieldType, FIsFactorySetting.Value);

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
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FLang.FieldName,
        FCode.FieldName,
        FValue.FieldName,
        FIsFactorySetting.FieldName
      ]);

      ParamByName(FLang.FieldName).Value := GetVarToFormatedValue(FLang.FieldType, FLang.Value);
      ParamByName(FCode.FieldName).Value := GetVarToFormatedValue(FCode.FieldType, FCode.Value);
      ParamByName(FValue.FieldName).Value := GetVarToFormatedValue(FValue.FieldType, FValue.Value);
      ParamByName(FIsFactorySetting.FieldName).Value := GetVarToFormatedValue(FIsFactorySetting.FieldType, FIsFactorySetting.Value);

      ParamByName(Self.Id.FieldName).Value := GetVarToFormatedValue(Self.Id.FieldType, Self.Id.Value);

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
  FLang.Value := '';
  FCode.Value := '';
  FValue.Value := '';
  FIsFactorySetting.Value := False;
end;

function TSysLangContents.Clone():TTable;
begin
  Result := TSysLangContents.Create(Database);

  Self.Id.Clone(TSysLangContents(Result).Id);

  FLang.Clone(TSysLangContents(Result).FLang);
  FCode.Clone(TSysLangContents(Result).FCode);
  FValue.Clone(TSysLangContents(Result).FValue);
  FIsFactorySetting.Clone(TSysLangContents(Result).FIsFactorySetting);
end;

end.
