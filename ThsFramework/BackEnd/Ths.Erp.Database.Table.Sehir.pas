unit Ths.Erp.Database.Table.Sehir;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,

  Ths.Erp.Database.Table.Ulke;

type
  TSehir = class(TTable)
  private
    FSehirAdi: TFieldDB;
    FUlkeID: TFieldDB;
    FPlakaKodu: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    property SehirAdi: TFieldDB read FSehirAdi write FSehirAdi;
    property UlkeID: TFieldDB read FUlkeID write FUlkeID;
    property PlakaKodu: TFieldDB read FPlakaKodu write FPlakaKodu;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSehir.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sehir';
  SourceCode := '1000';

  FSehirAdi := TFieldDB.Create('sehir_adi', ftString, '', 0, False, False, False, False);
  FUlkeID := TFieldDB.Create('ulke_id', ftInteger, 0, 0, False, False, True, False);
  FUlkeID.FK.FKTable := TUlke.Create(Database);
  FUlkeID.FK.FKCol := TFieldDB.Create('ulke', TUlke(FUlkeID.FK.FKTable).UlkeAdi.FieldType, 0, 0, False, False, False, False);
  FPlakaKodu := TFieldDB.Create('plaka_kodu', ftInteger, 0, 0, False, False, False, True);
end;

procedure TSehir.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfDS do
	  begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FSehirAdi.FieldName,
          TableName + '.' + FUlkeID.FieldName,
          ColumnFromIDCol(TUlke(FUlkeID.FK.FKTable).UlkeAdi.FieldName, FUlkeID.FK.FKTable.TableName, FUlkeID.FieldName, FUlkeID.FK.FKCol.FieldName, TableName),
          TableName + '.' + FPlakaKodu.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FSehirAdi.FieldName).DisplayLabel := 'Þehir Adý';
      Self.DataSource.DataSet.FindField(FUlkeID.FieldName).DisplayLabel := 'Ülke ID';
      Self.DataSource.DataSet.FindField(FUlkeID.FK.FKCol.FieldName).DisplayLabel := 'Ülke Adý';
      Self.DataSource.DataSet.FindField(FPlakaKodu.FieldName).DisplayLabel := 'Plaka Kodu';
    end;
  end;
end;

procedure TSehir.SelectToList(pFilter: string; pLock: Boolean;
  pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE OF ' + TableName + ' NOWAIT; ';

	  with QueryOfList do
	  begin
      Close;
      SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FSehirAdi.FieldName,
          TableName + '.' + FUlkeID.FieldName,
          ColumnFromIDCol(FUlkeID.FK.FKCol.FieldName, FUlkeID.FK.FKTable.TableName, FUlkeID.FieldName, FUlkeID.FK.FKCol.FieldName, TableName),
          TableName + '.' + FPlakaKodu.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Id.FieldName).DataType, FieldByName(Id.FieldName).Value);

        FSehirAdi.Value := FormatedVariantVal(FieldByName(FSehirAdi.FieldName).DataType, FieldByName(FSehirAdi.FieldName).Value);
        FUlkeID.Value := FormatedVariantVal(FieldByName(FUlkeID.FieldName).DataType, FieldByName(FUlkeID.FieldName).Value);
        FUlkeID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FUlkeID.FK.FKCol.FieldName).DataType, FieldByName(FUlkeID.FK.FKCol.FieldName).Value);
        FPlakaKodu.Value := FormatedVariantVal(FieldByName(FPlakaKodu.FieldName).DataType, FieldByName(FPlakaKodu.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      EmptyDataSet;
      Close;
	  end;
  end;
end;

procedure TSehir.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfInsert do
	  begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FSehirAdi.FieldName,
        FUlkeID.FieldName,
        FPlakaKodu.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FSehirAdi);
      NewParamForQuery(QueryOfInsert, FUlkeID);
      NewParamForQuery(QueryOfInsert, FPlakaKodu);

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

procedure TSehir.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfUpdate do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
		    FSehirAdi.FieldName,
        FUlkeID.FieldName,
        FPlakaKodu.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FSehirAdi);
      NewParamForQuery(QueryOfUpdate, FUlkeID);
      NewParamForQuery(QueryOfUpdate, FPlakaKodu);

      NewParamForQuery(QueryOfUpdate, Id);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

function TSehir.Clone():TTable;
begin
  Result := TSehir.Create(Database);

  Self.Id.Clone(TSehir(Result).Id);

  FSehirAdi.Clone(TSehir(Result).FSehirAdi);
  FUlkeID.Clone(TSehir(Result).FUlkeID);
  FPlakaKodu.Clone(TSehir(Result).FPlakaKodu);
end;

end.
