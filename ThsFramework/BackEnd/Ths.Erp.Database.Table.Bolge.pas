unit Ths.Erp.Database.Table.Bolge;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TBolge = class(TTable)
  private
    FBolgeTuruID: TFieldDB;
    FBolgeTuru: TFieldDB;
    FBolge: TFieldDB;
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

    Property BolgeTuruID: TFieldDB read FBolgeTuruID write FBolgeTuruID;
    Property BolgeTuru: TFieldDB read FBolgeTuru write FBolgeTuru;
    Property Bolge: TFieldDB read FBolge write FBolge;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TBolge.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'bolge';
  SourceCode := '1000';

  FBolgeTuruID := TFieldDB.Create('bolge_turu_id', ftInteger, 0);
  FBolgeTuru := TFieldDB.Create('bolge_turu', ftString, '');
  FBolge := TFieldDB.Create('bolge', ftString, '');
end;

procedure TBolge.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        TableName + '.' + FBolgeTuruID.FieldName,
        TableName + '.' + FBolgeTuru.FieldName,
        TableName + '.' + FBolge.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FBolgeTuruID.FieldName).DisplayLabel := 'Bölge Türü ID';
      Self.DataSource.DataSet.FindField(FBolgeTuru.FieldName).DisplayLabel := 'Bölge Türü';
      Self.DataSource.DataSet.FindField(FBolge.FieldName).DisplayLabel := 'Bölge';
    end;
  end;
end;

procedure TBolge.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + FBolgeTuruID.FieldName,
        TableName + '.' + FBolgeTuru.FieldName,
        TableName + '.' + FBolge.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FBolgeTuruID.Value := FormatedVariantVal(FieldByName(FBolgeTuruID.FieldName).DataType, FieldByName(FBolgeTuruID.FieldName).Value);
        FBolgeTuru.Value := FormatedVariantVal(FieldByName(FBolgeTuru.FieldName).DataType, FieldByName(FBolgeTuru.FieldName).Value);
        FBolge.Value := FormatedVariantVal(FieldByName(FBolge.FieldName).DataType, FieldByName(FBolge.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TBolge.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FBolgeTuruID.FieldName,
        FBolgeTuru.FieldName,
        FBolge.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FBolgeTuruID);
      NewParamForQuery(QueryOfInsert, FBolgeTuru);
      NewParamForQuery(QueryOfInsert, FBolge);

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

procedure TBolge.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FBolgeTuruID.FieldName,
        FBolgeTuru.FieldName,
        FBolge.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FBolgeTuruID);
      NewParamForQuery(QueryOfUpdate, FBolgeTuru);
      NewParamForQuery(QueryOfUpdate, FBolge);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

procedure TBolge.Clear();
begin
  inherited;

  FBolgeTuruID.Value := 0;
  FBolgeTuru.Value := '';
  FBolge.Value := '';
end;

function TBolge.Clone():TTable;
begin
  Result := TBolge.Create(Database);

  Self.Id.Clone(TBolge(Result).Id);

  FBolgeTuruID.Clone(TBolge(Result).FBolgeTuruID);
  FBolgeTuru.Clone(TBolge(Result).FBolgeTuru);
  FBolge.Clone(TBolge(Result).FBolge);
end;

end.
