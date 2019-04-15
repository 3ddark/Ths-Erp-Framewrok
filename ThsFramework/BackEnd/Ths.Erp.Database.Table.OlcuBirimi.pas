unit Ths.Erp.Database.Table.OlcuBirimi;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TOlcuBirimi = class(TTable)
  private
    FBirim: TFieldDB;
    FEFaturaBirim: TFieldDB;
    FBirimAciklama: TFieldDB;
    FIsFloatTip: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    Property Birim: TFieldDB read FBirim write FBirim;
    Property EFaturaBirim: TFieldDB read FEFaturaBirim write FEFaturaBirim;
    Property BirimAciklama: TFieldDB read FBirimAciklama write FBirimAciklama;
    Property IsFloatTip: TFieldDB read FIsFloatTip write FIsFloatTip;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TOlcuBirimi.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'olcu_birimi';
  SourceCode := '1000';

  FBirim := TFieldDB.Create('birim', ftString, '', 0, False, False);
  FEFaturaBirim := TFieldDB.Create('efatura_birim', ftString, '', 0, False, False);
  FBirimAciklama := TFieldDB.Create('birim_aciklama', ftString, '', 0, False, True);
  FIsFloatTip := TFieldDB.Create('is_float_tip', ftBoolean, False, 0, False, False);
end;

procedure TOlcuBirimi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
    with QueryOfDS do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
        TableName + '.' + Self.Id.FieldName,
        getRawDataByLang(TableName, FBirim.FieldName),
        TableName + '.' + FEFaturaBirim.FieldName,
        TableName + '.' + FBirimAciklama.FieldName,
        TableName + '.' + FIsFloatTip.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FBirim.FieldName).DisplayLabel := 'Birim';
      Self.DataSource.DataSet.FindField(FEFaturaBirim.FieldName).DisplayLabel := 'E-Fatura Birim';
      Self.DataSource.DataSet.FindField(FBirimAciklama.FieldName).DisplayLabel := 'Birim Açýklama';
      Self.DataSource.DataSet.FindField(FIsFloatTip.FieldName).DisplayLabel := 'Float Tip?';
    end;
  end;
end;

procedure TOlcuBirimi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        getRawDataByLang(TableName, FBirim.FieldName),
        TableName + '.' + FEFaturaBirim.FieldName,
        TableName + '.' + FBirimAciklama.FieldName,
        TableName + '.' + FIsFloatTip.FieldName
      ]) +
      'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

        FBirim.Value := FormatedVariantVal(FieldByName(FBirim.FieldName).DataType, FieldByName(FBirim.FieldName).Value);
        FEFaturaBirim.Value := FormatedVariantVal(FieldByName(FEFaturaBirim.FieldName).DataType, FieldByName(FEFaturaBirim.FieldName).Value);
        FBirimAciklama.Value := FormatedVariantVal(FieldByName(FBirimAciklama.FieldName).DataType, FieldByName(FBirimAciklama.FieldName).Value);
        FIsFloatTip.Value := FormatedVariantVal(FieldByName(FIsFloatTip.FieldName).DataType, FieldByName(FIsFloatTip.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      Close;
    end;
  end;
end;

procedure TOlcuBirimi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
    with QueryOfInsert do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FBirim.FieldName,
        FEFaturaBirim.FieldName,
        FBirimAciklama.FieldName,
        FIsFloatTip.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FBirim);
      NewParamForQuery(QueryOfInsert, FEFaturaBirim);
      NewParamForQuery(QueryOfInsert, FBirimAciklama);
      NewParamForQuery(QueryOfInsert, FIsFloatTip);

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

procedure TOlcuBirimi.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
    with QueryOfUpdate do
    begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FBirim.FieldName,
        FEFaturaBirim.FieldName,
        FBirimAciklama.FieldName,
        FIsFloatTip.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FBirim);
      NewParamForQuery(QueryOfUpdate, FEFaturaBirim);
      NewParamForQuery(QueryOfUpdate, FBirimAciklama);
      NewParamForQuery(QueryOfUpdate, FIsFloatTip);

      NewParamForQuery(QueryOfUpdate, Id);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

function TOlcuBirimi.Clone():TTable;
begin
  Result := TOlcuBirimi.Create(Database);

  Self.Id.Clone(TOlcuBirimi(Result).Id);

  FBirim.Clone(TOlcuBirimi(Result).FBirim);
  FEFaturaBirim.Clone(TOlcuBirimi(Result).FEFaturaBirim);
  FBirimAciklama.Clone(TOlcuBirimi(Result).FBirimAciklama);
  FIsFloatTip.Clone(TOlcuBirimi(Result).FIsFloatTip);
end;

end.
