unit Ths.Erp.Database.Table.Country;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TCountry = class(TTable)
  private
    FCountryCode : TFieldDB;
    FCountryName : TFieldDB;
    FISOYear : TFieldDB;
    FISOCCTLDCode : TFieldDB;
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

    property CountryCode: TFieldDB read FCountryCode write FCountryCode;
    Property CountryName: TFieldDB read FCountryName write FCountryName;
    Property ISOYear : TFieldDB read FISOYear write FISOYear;
    Property ISOCCTLDCode : TFieldDB read FISOCCTLDCode write FISOCCTLDCode;
  end;

implementation

uses
  Ths.Erp.Constants;

constructor TCountry.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'country';
  SourceCode := '1002';

  FCountryCode := TFieldDB.Create('country_code', ftString, '');
  FCountryName := TFieldDB.Create('country_name', ftString, '');
  FISOYear := TFieldDB.Create('iso_year', ftInteger, '');
  FISOCCTLDCode := TFieldDB.Create('iso_cctld_code', ftString, '');
end;

procedure TCountry.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FCountryCode.FieldName,
          TableName + '.' + FCountryName.FieldName,
          TableName + '.' + FIsoYear.FieldName,
          TableName + '.' + FISOCCTLDCode.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FCountryCode.FieldName).DisplayLabel := 'COUNTRY CODE';
      Self.DataSource.DataSet.FindField(FCountryName.FieldName).DisplayLabel := 'COUNTRY NAME';
      Self.DataSource.DataSet.FindField(FISOYear.FieldName).DisplayLabel := 'YEAR';
      Self.DataSource.DataSet.FindField(FISOCCTLDCode.FieldName).DisplayLabel := 'CCTLD CODE';
	  end;
  end;
end;

procedure TCountry.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FCountryCode.FieldName,
          TableName + '.' + FCountryName.FieldName,
          TableName + '.' + FISOYear.FieldName,
          TableName + '.' + FISOCCTLDCode.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id.Value := FieldByName(Self.Id.FieldName).AsInteger;

		    Self.FCountryCode.Value := FieldByName(FCountryCode.FieldName).AsString;
        Self.FCountryName.Value := FieldByName(FCountryName.FieldName).AsString;
        Self.FISOYear.Value := FieldByName(FISOYear.FieldName).AsInteger;
        Self.FISOCCTLDCode.Value := FieldByName(FISOCCTLDCode.FieldName).AsString;

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TCountry.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
      Close;
      SQL.Clear;
      SQL.Text := Self.Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FCountryCode.FieldName,
        FCountryName.FieldName,
        FISOYear.FieldName,
        FISOCCTLDCode.FieldName
      ]);

      ParamByName(FCountryCode.FieldName).Value := Self.FCountryCode.Value;
      ParamByName(FCountryName.FieldName).Value := Self.FCountryName.Value;
      ParamByName(FISOYear.FieldName).Value := Self.FISOYear.Value;
      ParamByName(ISOCCTLDCode.FieldName).Value := Self.ISOCCTLDCode.Value;

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

procedure TCountry.Update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
		    FCountryCode.FieldName,
        FCountryName.FieldName,
        FISOYear.FieldName,
        ISOCCTLDCode.FieldName
      ]);

      ParamByName(FCountryCode.FieldName).Value := Self.FCountryCode.Value;
      ParamByName(FCountryName.FieldName).Value := Self.FCountryName.Value;
      ParamByName(FISOYear.FieldName).Value := Self.FISOYear.Value;
      ParamByName(FISOCCTLDCode.FieldName).Value := Self.FISOCCTLDCode.Value;

		  ParamByName(Self.Id.FieldName).Value := Self.Id.Value;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

procedure TCountry.Clear();
begin
  inherited;
  self.FCountryCode.Value := '';
  self.FCountryName.Value := '';
  self.FISOYear.Value := 0;
  self.FISOCCTLDCode.Value := '';
end;

function TCountry.Clone():TTable;
begin
  Result := TCountry.Create(Database);

  Self.Id.Clone(TCountry(Result).Id);

  Self.FCountryCode.Clone(TCountry(Result).FCountryCode);
  Self.FCountryName.Clone(TCountry(Result).FCountryName);
  Self.FISOYear.Clone(TCountry(Result).FISOYear);
  Self.FISOCCTLDCode.Clone(TCountry(Result).FISOCCTLDCode);
end;

end.
