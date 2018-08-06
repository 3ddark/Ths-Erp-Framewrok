unit Ths.Erp.Database.Table.SysLangGuiContent;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TSysLangGuiContent = class(TTable)
  private
    FLang: TFieldDB;
    FCode: TFieldDB;
    FContentType: TFieldDB;
    FTableName: TFieldDB;
    FValue: TFieldDB;
    FIsFactorySetting: TFieldDB;
  protected
    procedure BusinessInsert(out pID: Integer; var pPermissionControl: Boolean); override;
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
    property ContentType: TFieldDB read FContentType write FContentType;
    property TableName1: TFieldDB read FTableName write FTableName;
    property Value: TFieldDB read FValue write FValue;
    property IsFactorySetting: TFieldDB read FIsFactorySetting write FIsFactorySetting;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSysLangGuiContent.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_lang_gui_content';
  SourceCode := '1';

  FLang := TFieldDB.Create('lang', ftString, '');
  FCode := TFieldDB.Create('code', ftString, '');
  FContentType := TFieldDB.Create('content_type', ftString, '');
  FTableName := TFieldDB.Create('table_name', ftString, '');
  FValue := TFieldDB.Create('value', ftString, '');
  FIsFactorySetting := TFieldDB.Create('is_factory_setting', ftBoolean, False);
end;

procedure TSysLangGuiContent.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
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
        TableName + '.' + FContentType.FieldName,
        TableName + '.' + FTableName.FieldName,
        TableName + '.' + FValue.FieldName + '::varchar ',
        TableName + '.' + FIsFactorySetting.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FLang.FieldName).DisplayLabel := 'LANG';
      Self.DataSource.DataSet.FindField(FCode.FieldName).DisplayLabel := 'CODE';
      Self.DataSource.DataSet.FindField(FContentType.FieldName).DisplayLabel := 'CONTENT TYPE';
      Self.DataSource.DataSet.FindField(FTableName.FieldName).DisplayLabel := 'TABLE NAME';
      Self.DataSource.DataSet.FindField(FValue.FieldName).DisplayLabel := 'VALUE';
      Self.DataSource.DataSet.FindField(FIsFactorySetting.FieldName).DisplayLabel := 'FACTORY SETTING?';
    end;
  end;
end;

procedure TSysLangGuiContent.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FContentType.FieldName,
        TableName + '.' + FTableName.FieldName,
        TableName + '.' + FValue.FieldName,
        TableName + '.' + FIsFactorySetting.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FLang.Value := FormatedVariantVal(FieldByName(FLang.FieldName).DataType, FieldByName(FLang.FieldName).Value);
        FCode.Value := FormatedVariantVal(FieldByName(FCode.FieldName).DataType, FieldByName(FCode.FieldName).Value);
        FContentType.Value := FormatedVariantVal(FieldByName(FContentType.FieldName).DataType, FieldByName(FContentType.FieldName).Value);
        FTableName.Value := FormatedVariantVal(FieldByName(FTableName.FieldName).DataType, FieldByName(FTableName.FieldName).Value);
        FValue.Value := FormatedVariantVal(FieldByName(FValue.FieldName).DataType, FieldByName(FValue.FieldName).Value);
        FIsFactorySetting.Value := FormatedVariantVal(FieldByName(FIsFactorySetting.FieldName).DataType, FieldByName(FIsFactorySetting.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TSysLangGuiContent.Insert(out pID: Integer; pPermissionControl: Boolean=True);
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
        FContentType.FieldName,
        FTableName.FieldName,
        FValue.FieldName,
        FIsFactorySetting.FieldName
      ]);

      ParamByName(FLang.FieldName).Value := FormatedVariantVal(FLang.FieldType, FLang.Value);
      ParamByName(FCode.FieldName).Value := FormatedVariantVal(FCode.FieldType, FCode.Value);
      ParamByName(FContentType.FieldName).Value := FormatedVariantVal(FContentType.FieldType, FContentType.Value);
      ParamByName(FTableName.FieldName).Value := FormatedVariantVal(FTableName.FieldType, FTableName.Value);
      ParamByName(FValue.FieldName).Value := FormatedVariantVal(FValue.FieldType, FValue.Value);
      ParamByName(FIsFactorySetting.FieldName).Value := FormatedVariantVal(FIsFactorySetting.FieldType, FIsFactorySetting.Value);

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

procedure TSysLangGuiContent.Update(pPermissionControl: Boolean=True);
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
        FContentType.FieldName,
        FTableName.FieldName,
        FValue.FieldName,
        FIsFactorySetting.FieldName
      ]);

      ParamByName(FLang.FieldName).Value := FormatedVariantVal(FLang.FieldType, FLang.Value);
      ParamByName(FCode.FieldName).Value := FormatedVariantVal(FCode.FieldType, FCode.Value);
      ParamByName(FContentType.FieldName).Value := FormatedVariantVal(FContentType.FieldType, FContentType.Value);
      ParamByName(FTableName.FieldName).Value := FormatedVariantVal(FTableName.FieldType, FTableName.Value);
      ParamByName(FValue.FieldName).Value := FormatedVariantVal(FValue.FieldType, FValue.Value);
      ParamByName(FIsFactorySetting.FieldName).Value := FormatedVariantVal(FIsFactorySetting.FieldType, FIsFactorySetting.Value);

      ParamByName(Self.Id.FieldName).Value := FormatedVariantVal(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      ExecSQL;
      Close;
    end;
  Self.notify;
  end;
end;

procedure TSysLangGuiContent.BusinessInsert(out pID: Integer;
  var pPermissionControl: Boolean);
var
  vSysLangGuiContent: TSysLangGuiContent;
  vDmpFilter: string;
begin
  vSysLangGuiContent := TSysLangGuiContent.Create(Self.Database);
  try
    if FormatedVariantVal(FTableName.FieldType, FTableName.Value) <> '' then
      vDmpFilter := ' AND table_name=' + QuotedStr(FormatedVariantVal(FTableName.FieldType, FTableName.Value));

    vSysLangGuiContent.SelectToList(' AND lang=' + QuotedStr(FormatedVariantVal(FLang.FieldType, FLang.Value)) +
                                 ' AND code=' + QuotedStr(FormatedVariantVal(FCode.FieldType, FCode.Value)) +
                                 ' AND content_type=' + QuotedStr(FormatedVariantVal(FContentType.FieldType, FContentType.Value)) +
                                 vDmpFilter, False, False);
    if vSysLangGuiContent.List.Count = 1 then
    begin
      Self.Id.Value := vSysLangGuiContent.Id.Value;
      Self.Update()
    end
    else
      Self.Insert(pID);
  finally
    vSysLangGuiContent.Free;
  end;
end;

procedure TSysLangGuiContent.Clear();
begin
  inherited;
  FLang.Value := '';
  FCode.Value := '';
  FContentType.Value := '';
  FTableName.Value := '';
  FValue.Value := '';
  FIsFactorySetting.Value := False;
end;

function TSysLangGuiContent.Clone():TTable;
begin
  Result := TSysLangGuiContent.Create(Database);

  Self.Id.Clone(TSysLangGuiContent(Result).Id);

  FLang.Clone(TSysLangGuiContent(Result).FLang);
  FCode.Clone(TSysLangGuiContent(Result).FCode);
  FContentType.Clone(TSysLangGuiContent(Result).FContentType);
  FTableName.Clone(TSysLangGuiContent(Result).FTableName);
  FValue.Clone(TSysLangGuiContent(Result).FValue);
  FIsFactorySetting.Clone(TSysLangGuiContent(Result).FIsFactorySetting);
end;

end.
