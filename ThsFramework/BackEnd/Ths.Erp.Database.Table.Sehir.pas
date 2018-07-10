unit Ths.Erp.Database.Table.Sehir;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TSehir = class(TTable)
  private
    FSehirAdi: TFieldDB;
    FUlkeAdi: TFieldDB;
    FPlakaKodu: TFieldDB;
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

    property SehirAdi: TFieldDB read FSehirAdi write FSehirAdi;
    property UlkeAdi: TFieldDB read FUlkeAdi write FUlkeAdi;
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
  SourceCode := '1003';

  FSehirAdi := TFieldDB.Create('sehir_adi', ftString, '');
  FUlkeAdi := TFieldDB.Create('ulke_adi', ftString, '');
  FPlakaKodu := TFieldDB.Create('plaka_kodu', ftInteger, 0);
end;

procedure TSehir.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FSehirAdi.FieldName,
          TableName + '.' + FUlkeAdi.FieldName,
          TableName + '.' + FPlakaKodu.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FSehirAdi.FieldName).DisplayLabel := 'CITY NAME';
      Self.DataSource.DataSet.FindField(FUlkeAdi.FieldName).DisplayLabel := 'COUNTRY NAME';
      Self.DataSource.DataSet.FindField(FPlakaKodu.FieldName).DisplayLabel := 'PLAKA KODU';
	  end;
  end;
end;

procedure TSehir.SelectToList(pFilter: string; pLock: Boolean;
  pPermissionControl: Boolean=True);
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
          TableName + '.' + FSehirAdi.FieldName,
          TableName + '.' + FUlkeAdi.FieldName,
          TableName + '.' + FPlakaKodu.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id.Value := GetVarToFormatedValue(FieldByName(Id.FieldName).DataType, FieldByName(Id.FieldName).Value);

		    FSehirAdi.Value := GetVarToFormatedValue(FieldByName(FSehirAdi.FieldName).DataType, FieldByName(FSehirAdi.FieldName).Value);
        FUlkeAdi.Value := GetVarToFormatedValue(FieldByName(FUlkeAdi.FieldName).DataType, FieldByName(FUlkeAdi.FieldName).Value);
        FPlakaKodu.Value := GetVarToFormatedValue(FieldByName(FPlakaKodu.FieldName).DataType, FieldByName(FPlakaKodu.FieldName).Value);

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
	  with QueryOfTable do
	  begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FSehirAdi.FieldName,
        FUlkeAdi.FieldName
      ]);

      ParamByName(FSehirAdi.FieldName).Value := GetVarToFormatedValue(FSehirAdi.FieldType, FSehirAdi.Value);
      ParamByName(FUlkeAdi.FieldName).Value := GetVarToFormatedValue(FUlkeAdi.FieldType, FUlkeAdi.Value);
      ParamByName(FPlakaKodu.FieldName).Value := GetVarToFormatedValue(FPlakaKodu.FieldType, FPlakaKodu.Value);

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

procedure TSehir.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
		    FSehirAdi.FieldName,
        FUlkeAdi.FieldName,
        FPlakaKodu.FieldName
      ]);

      ParamByName(FSehirAdi.FieldName).Value := GetVarToFormatedValue(FSehirAdi.FieldType, FSehirAdi.Value);
      ParamByName(FUlkeAdi.FieldName).Value := GetVarToFormatedValue(FUlkeAdi.FieldType, FUlkeAdi.Value);
      ParamByName(FPlakaKodu.FieldName).Value := GetVarToFormatedValue(FPlakaKodu.FieldType, FPlakaKodu.Value);

		  ParamByName(Self.Id.FieldName).Value := GetVarToFormatedValue(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

procedure TSehir.Clear();
begin
  inherited;
  FSehirAdi.Value := '';
  FUlkeAdi.Value := '';
  PlakaKodu.Value := '';
end;

function TSehir.Clone():TTable;
begin
  Result := TSehir.Create(Database);

  Self.Id.Clone(TSehir(Result).Id);

  FSehirAdi.Clone(TSehir(Result).FSehirAdi);
  FUlkeAdi.Clone(TSehir(Result).FUlkeAdi);
  FPlakaKodu.Clone(TSehir(Result).FPlakaKodu);
end;

end.
