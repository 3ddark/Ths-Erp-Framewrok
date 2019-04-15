unit Ths.Erp.Database.Table.AyarPrsMedeniDurum;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TAyarPrsMedeniDurum = class(TTable)
  private
    FMedeniDurum: TFieldDB;
    FIsMarried: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property MedeniDurum: TFieldDB read FMedeniDurum write FMedeniDurum;
    Property IsMarried: TFieldDB read FIsMarried write FIsMarried;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TAyarPrsMedeniDurum.Create(OwnerDatabase:TDatabase);
begin
  TableName := 'ayar_prs_medeni_durum';
  SourceCode := '1000';

  inherited Create(OwnerDatabase);

  FMedeniDurum := TFieldDB.Create('medeni_durum', ftString, '', 0, False, False);
  FIsMarried := TFieldDB.Create('is_married', ftBoolean, False, 0, False, False);
end;

procedure TAyarPrsMedeniDurum.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        getRawDataByLang(TableName, FMedeniDurum.FieldName),
        TableName + '.' + FIsMarried.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FMedeniDurum.FieldName).DisplayLabel := 'Medeni Durum';
      Self.DataSource.DataSet.FindField(FIsMarried.FieldName).DisplayLabel := 'Evli?';
    end;
  end;
end;

procedure TAyarPrsMedeniDurum.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE OF ' + TableName + ' NOWAIT';

    with QueryOfList do
    begin
      Close;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        getRawDataByLang(TableName, FMedeniDurum.FieldName),
        TableName + '.' + FIsMarried.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FMedeniDurum.Value := FormatedVariantVal(FieldByName(FMedeniDurum.FieldName).DataType, FieldByName(FMedeniDurum.FieldName).Value);
        FIsMarried.Value := FormatedVariantVal(FieldByName(FIsMarried.FieldName).DataType, FieldByName(FIsMarried.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TAyarPrsMedeniDurum.Insert(out pID: Integer; pPermissionControl: Boolean=True);
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
          FMedeniDurum.FieldName,
          FIsMarried.FieldName
        ]);

        NewParamForQuery(QueryOfInsert, FMedeniDurum);
        NewParamForQuery(QueryOfInsert, FIsMarried);

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

procedure TAyarPrsMedeniDurum.Update(pPermissionControl: Boolean=True);
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
          FMedeniDurum.FieldName,
          FIsMarried.FieldName
        ]);

        NewParamForQuery(QueryOfUpdate, FMedeniDurum);
        NewParamForQuery(QueryOfUpdate, FIsMarried);

        NewParamForQuery(QueryOfUpdate, Id);

        ExecSQL;
        Close;
      end;
      Self.Notify;
    {$ENDIF}
  end;
end;

function TAyarPrsMedeniDurum.Clone():TTable;
begin
  Result := TAyarPrsMedeniDurum.Create(Database);

  Self.Id.Clone(TAyarPrsMedeniDurum(Result).Id);

  FMedeniDurum.Clone(TAyarPrsMedeniDurum(Result).FMedeniDurum);
  FIsMarried.Clone(TAyarPrsMedeniDurum(Result).FIsMarried);
end;

end.
