unit Ths.Erp.Database.Table.AyarPrsCinsiyet;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TAyarPrsCinsiyet = class(TTable)
  private
    FCinsiyet: TFieldDB;
    FIsMan: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property Cinsiyet: TFieldDB read FCinsiyet write FCinsiyet;
    Property IsMan: TFieldDB read FIsMan write FIsMan;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAyarPrsCinsiyet.Create(OwnerDatabase:TDatabase);
begin
  TableName := 'ayar_prs_cinsiyet';
  SourceCode := '1000';

  inherited Create(OwnerDatabase);

  FCinsiyet := TFieldDB.Create('cinsiyet', ftString, '', 0, False, False);
  FIsMan := TFieldDB.Create('is_man', ftBoolean, False, 0, False, False);
end;

procedure TAyarPrsCinsiyet.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        getRawDataByLang(TableName, FCinsiyet.FieldName),
        TableName + '.' + FIsMan.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FCinsiyet.FieldName).DisplayLabel := 'Cinsiyet';
      Self.DataSource.DataSet.FindField(FIsMan.FieldName).DisplayLabel := 'Erkek?';
    end;
  end;
end;

procedure TAyarPrsCinsiyet.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        getRawDataByLang(TableName, FCinsiyet.FieldName),
        TableName + '.' + FIsMan.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FCinsiyet.Value := FormatedVariantVal(FieldByName(FCinsiyet.FieldName).DataType, FieldByName(FCinsiyet.FieldName).Value);
        FIsMan.Value := FormatedVariantVal(FieldByName(FIsMan.FieldName).DataType, FieldByName(FIsMan.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAyarPrsCinsiyet.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    {$IFDEF CRUD_MODE_SP}
      SpInsert.ExecProc;
      pID := SpInsert.ParamByName('result').AsInteger;
      Self.Notify;
    {$ELSE IFDEF CRUD_MODE_PURE_SQL}
      with QueryOfInsert do
      begin
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
          FCinsiyet.FieldName,
          FIsMan.FieldName
        ]);

        NewParamForQuery(QueryOfInsert, FCinsiyet);
        NewParamForQuery(QueryOfInsert, FIsMan);

        Open;
        if (Fields.Count > 0) and (not Fields.FieldByName(Self.Id.FieldName).IsNull) then
          pID := Fields.FieldByName(Self.Id.FieldName).AsInteger
        else
          pID := 0;

        EmptyDataSet;
        Close;
      end;
      Self.Notify;
    {$ENDIF}
  end;
end;

procedure TAyarPrsCinsiyet.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    {$IFDEF CRUD_MODE_SP}
      SpUpdate.ExecProc;
      Self.Notify;
    {$ELSE IFDEF CRUD_MODE_PURE_SQL}
      with QueryOfUpdate do
      begin
        Close;
        SQL.Clear;
        SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
          FCinsiyet.FieldName,
          FIsMan.FieldName
        ]);

        NewParamForQuery(QueryOfUpdate, FCinsiyet);
        NewParamForQuery(QueryOfUpdate, FIsMan);

        NewParamForQuery(QueryOfUpdate, Id);

        ExecSQL;
        Close;
      end;
      Self.Notify;
    {$ENDIF}
  end;
end;

function TAyarPrsCinsiyet.Clone():TTable;
begin
  Result := TAyarPrsCinsiyet.Create(Database);

  Self.Id.Clone(TAyarPrsCinsiyet(Result).Id);

  FCinsiyet.Clone(TAyarPrsCinsiyet(Result).FCinsiyet);
  FIsMan.Clone(TAyarPrsCinsiyet(Result).FIsMan);
end;

end.
