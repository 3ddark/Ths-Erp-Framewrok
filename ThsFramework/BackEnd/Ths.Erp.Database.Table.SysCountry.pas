unit Ths.Erp.Database.Table.SysCountry;

interface

{$I ThsERP.inc}

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TSysCountry = class(TTable)
  private
    FCountryCode: TFieldDB;
    FCountryName: TFieldDB;
    FISOYear: TFieldDB;
    FISOCCTLDCode: TFieldDB;
    FIsEUMember: TFieldDB;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    function Clone():TTable;override;

    property CountryCode: TFieldDB read FCountryCode write FCountryCode;
    Property CountryName: TFieldDB read FCountryName write FCountryName;
    Property ISOYear: TFieldDB read FISOYear write FISOYear;
    Property ISOCCTLDCode: TFieldDB read FISOCCTLDCode write FISOCCTLDCode;
    Property IsEUMember: TFieldDB read FIsEUMember write FIsEUMember;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSysCountry.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_country';
  SourceCode := '1000';

  FCountryCode := TFieldDB.Create('country_code', ftString, '');
  FCountryName := TFieldDB.Create('country_name', ftString, '');
  FISOYear := TFieldDB.Create('iso_year', ftInteger, 0);
  FISOCCTLDCode := TFieldDB.Create('iso_cctld_code', ftString, '');
  FIsEUMember := TFieldDB.Create('is_eu_member', ftBoolean, False);
end;

procedure TSysCountry.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfDS do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FCountryCode.FieldName,
          getRawDataByLang(TableName, FCountryName.FieldName),
          TableName + '.' + FIsoYear.FieldName,
          TableName + '.' + FISOCCTLDCode.FieldName,
          TableName + '.' + FIsEUMember.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FCountryCode.FieldName).DisplayLabel := 'Country Code';
      Self.DataSource.DataSet.FindField(FCountryName.FieldName).DisplayLabel := 'Country Name';
      Self.DataSource.DataSet.FindField(FISOYear.FieldName).DisplayLabel := 'Year';
      Self.DataSource.DataSet.FindField(FISOCCTLDCode.FieldName).DisplayLabel := 'Cctld Code';
      Self.DataSource.DataSet.FindField(FIsEUMember.FieldName).DisplayLabel := 'Member EU';
	  end;
  end;
end;

procedure TSysCountry.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
          TableName + '.' + FCountryCode.FieldName,
          getRawDataByLang(TableName, FCountryName.FieldName),
          TableName + '.' + FISOYear.FieldName,
          TableName + '.' + FISOCCTLDCode.FieldName,
          TableName + '.' + FIsEUMember.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

		    FCountryCode.Value := FormatedVariantVal(FieldByName(FCountryCode.FieldName).DataType, FieldByName(FCountryCode.FieldName).Value);
        FCountryName.Value := FormatedVariantVal(FieldByName(FCountryName.FieldName).DataType, FieldByName(FCountryName.FieldName).Value);
        FISOYear.Value := FormatedVariantVal(FieldByName(FISOYear.FieldName).DataType, FieldByName(FISOYear.FieldName).Value);
        FISOCCTLDCode.Value := FormatedVariantVal(FieldByName(FISOCCTLDCode.FieldName).DataType, FieldByName(FISOCCTLDCode.FieldName).Value);
        FIsEUMember.Value := FormatedVariantVal(FieldByName(FIsEUMember.FieldName).DataType, FieldByName(FIsEUMember.FieldName).Value);

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TSysCountry.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfInsert do
	  begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FCountryCode.FieldName,
        FCountryName.FieldName,
        FISOYear.FieldName,
        FISOCCTLDCode.FieldName,
        FIsEUMember.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FCountryCode);
      NewParamForQuery(QueryOfInsert, FCountryName);
      NewParamForQuery(QueryOfInsert, FISOYear);
      NewParamForQuery(QueryOfInsert, FISOCCTLDCode);
      NewParamForQuery(QueryOfInsert, FIsEUMember);

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

procedure TSysCountry.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfUpdate do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
		    FCountryCode.FieldName,
        FCountryName.FieldName,
        FISOYear.FieldName,
        FISOCCTLDCode.FieldName,
        FIsEUMember.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FCountryCode);
      NewParamForQuery(QueryOfUpdate, FCountryName);
      NewParamForQuery(QueryOfUpdate, FISOYear);
      NewParamForQuery(QueryOfUpdate, FISOCCTLDCode);
      NewParamForQuery(QueryOfUpdate, FIsEUMember);

      NewParamForQuery(QueryOfUpdate, Id);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

function TSysCountry.Clone():TTable;
begin
  Result := TSysCountry.Create(Database);

  Self.Id.Clone(TSysCountry(Result).Id);

  FCountryCode.Clone(TSysCountry(Result).FCountryCode);
  FCountryName.Clone(TSysCountry(Result).FCountryName);
  FISOYear.Clone(TSysCountry(Result).FISOYear);
  FISOCCTLDCode.Clone(TSysCountry(Result).FISOCCTLDCode);
  FIsEUMember.Clone(TSysCountry(Result).FIsEUMember);
end;

end.
