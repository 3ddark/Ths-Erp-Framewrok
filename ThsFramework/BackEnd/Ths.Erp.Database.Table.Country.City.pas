unit Ths.Erp.Database.Table.Country.City;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TCity = class(TTable)
  private
    FCityName          : TFieldDB;
    FCountryName       : TFieldDB;
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

    Property CityName : TFieldDB read FCityName write FCityName;
    Property CountryName : TFieldDB read FCountryName write FCountryName;
  end;

implementation

uses
  Ths.Erp.Constants;

constructor TCity.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'city';
  SourceCode := '1003';

  Self.FCityName := TFieldDB.Create('city_name', ftString, '');
  Self.FCountryName := TFieldDB.Create('country_name', ftString, '');
end;

procedure TCity.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FCityName.FieldName,
          TableName + '.' + FCountryName.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FCityName.FieldName).DisplayLabel := 'CITY NAME';
      Self.DataSource.DataSet.FindField(FCountryName.FieldName).DisplayLabel := 'COUNTRY NAME';
	  end;
  end;
end;

procedure TCity.SelectToList(pFilter: string; pLock: Boolean;
  pPermissionControl: Boolean=True);
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
          TableName + '.' + FCityName.FieldName,
          TableName + '.' + FCountryName.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id.Value := FieldByName(Self.Id.FieldName).AsInteger;
		    Self.FCityName.Value := FieldByName(FCityName.FieldName).AsString;
        Self.FCountryName.Value := FieldByName(FCountryName.FieldName).AsString;

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TCity.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
      Close;
      SQL.Clear;
      SQL.Text := Self.Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FCityName.FieldName,
        FCountryName.FieldName
      ]);

      ParamByName(FCityName.FieldName).Value := Self.FCityName.Value;
      ParamByName(FCountryName.FieldName).Value := Self.FCountryName.Value;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      Open;
      if (Fields.Count > 0) and (not Fields.Fields[0].IsNull) then
        pID := Fields.FieldByName(Self.Id.FieldName).AsInteger
      else
        pID := 0;

      EmptyDataSet;
      Close;
	  end;
    Self.notify;
  end;
end;

procedure TCity.Update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
		    FCityName.FieldName,
        FCountryName.FieldName
      ]);

      ParamByName(FCityName.FieldName).Value := Self.FCityName.Value;
      ParamByName(FCountryName.FieldName).Value := Self.FCountryName.Value;

		  ParamByName(Self.Id.FieldName).Value := Self.Id.Value;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

procedure TCity.Clear();
begin
  inherited;
  self.FCityName.Value := '';
  self.FCountryName.Value := '';
end;

function TCity.Clone():TTable;
begin
  Result := TCity.Create(Database);

  Self.Id.Clone(TCity(Result).Id);

  Self.FCityName.Clone(TCity(Result).FCityName);
  Self.FCountryName.Clone(TCity(Result).FCountryName);
end;

end.
