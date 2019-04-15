unit Ths.Erp.Database.Table.SysCity;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TSysCity = class(TTable)
  private
    FCityName: TFieldDB;
    FCarPlateCode: TFieldDB;
    FCountryID: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    property CityName: TFieldDB read FCityName write FCityName;
    property CountryID: TFieldDB read FCountryID write FCountryID;
    property CarPlateCode: TFieldDB read FCarPlateCode write FCarPlateCode;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.SysCountry;

constructor TSysCity.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_city';
  SourceCode := '1000';

  FCityName := TFieldDB.Create('city_name', ftString, '');
  FCountryID := TFieldDB.Create('country_id', ftInteger, 0, 0, True, False);
  FCountryID.FK.FKTable := TSysCountry.Create(Database);
  FCountryID.FK.FKCol := TFieldDB.Create(TSysCountry(FCountryID.FK.FKTable).CountryName.FieldName, TSysCountry(FCountryID.FK.FKTable).CountryName.FieldType, '');
  FCarPlateCode := TFieldDB.Create('car_plate_code', ftInteger, 0);
end;

procedure TSysCity.SelectToDatasource(pFilter: string;
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
          TableName + '.' + FCityName.FieldName,
          TableName + '.' + FCarPlateCode.FieldName,
          TableName + '.' + FCountryID.FieldName,
          ColumnFromIDCol(FCountryID.FK.FKCol.FieldName, FCountryID.FK.FKTable.TableName, FCountryID.FieldName, FCountryID.FK.FKCol.FieldName, TableName)
        ]) +
        'WHERE 1=1 ' + pFilter;
      Open;
      Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FCityName.FieldName).DisplayLabel := 'City Name';
      Self.DataSource.DataSet.FindField(FCarPlateCode.FieldName).DisplayLabel := 'Car Plate Code';
      Self.DataSource.DataSet.FindField(FCountryID.FieldName).DisplayLabel := 'Country ID';
      Self.DataSource.DataSet.FindField(FCountryID.FK.FKCol.FieldName).DisplayLabel := 'Country Name';
    end;
  end;
end;

procedure TSysCity.SelectToList(pFilter: string; pLock: Boolean;
  pPermissionControl: Boolean=True);
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
          TableName + '.' + FCityName.FieldName,
          TableName + '.' + FCarPlateCode.FieldName,
          TableName + '.' + FCountryID.FieldName,
          ColumnFromIDCol(FCountryID.FK.FKCol.FieldName, FCountryID.FK.FKTable.TableName, FCountryID.FieldName, FCountryID.FK.FKCol.FieldName, TableName)
        ]) +
        'WHERE 1=1 ' + pFilter;
      Open;

      FreeListContent();
      List.Clear;
      while NOT EOF do
      begin
        Self.Id.Value := FormatedVariantVal(FieldByName(Id.FieldName).DataType, FieldByName(Id.FieldName).Value);

        FCityName.Value := FormatedVariantVal(FieldByName(FCityName.FieldName).DataType, FieldByName(FCityName.FieldName).Value);
        FCarPlateCode.Value := FormatedVariantVal(FieldByName(FCarPlateCode.FieldName).DataType, FieldByName(FCarPlateCode.FieldName).Value);
        FCountryID.Value := FormatedVariantVal(FieldByName(FCountryID.FieldName).DataType, FieldByName(FCountryID.FieldName).Value);
        FCountryID.FK.FKCol.Value := FormatedVariantVal(FieldByName(FCountryID.FK.FKCol.FieldName).DataType, FieldByName(FCountryID.FK.FKCol.FieldName).Value);

        List.Add(Self.Clone());

        Next;
      end;
      EmptyDataSet;
      Close;
	  end;
  end;
end;

procedure TSysCity.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfInsert do
	  begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FCityName.FieldName,
        FCarPlateCode.FieldName,
        FCountryID.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FCityName);
      NewParamForQuery(QueryOfInsert, FCarPlateCode);
      NewParamForQuery(QueryOfInsert, FCountryID);

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

procedure TSysCity.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfUpdate do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
		    FCityName.FieldName,
        FCarPlateCode.FieldName,
        FCountryID.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FCityName);
      NewParamForQuery(QueryOfUpdate, FCarPlateCode);
      NewParamForQuery(QueryOfUpdate, FCountryID);

      NewParamForQuery(QueryOfUpdate, Id);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

function TSysCity.Clone():TTable;
begin
  Result := TSysCity.Create(Database);

  Self.Id.Clone(TSysCity(Result).Id);

  FCityName.Clone(TSysCity(Result).FCityName);
  FCarPlateCode.Clone(TSysCity(Result).FCarPlateCode);
  FCountryID.Clone(TSysCity(Result).FCountryID);
end;

end.
