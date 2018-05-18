unit Ths.Erp.Database.Table.Country.City;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TCity = class(TTable)
  private
    FCityName          : string;
    FCountryName       : string;
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

    Property CityName       : string    read FCityName           write FCityName;
    Property CountryName    : string    read FCountryName        write FCountryName;
  end;

implementation

uses
  Ths.Erp.Constants;

constructor TCity.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'city';
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
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName,
        [TableName + '.' + 'id',
        TableName + '.' + 'city_name',
        TableName + '.' + 'country_name']) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField('id').DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField('city_name').DisplayLabel := 'CITY NAME';
      Self.DataSource.DataSet.FindField('country_name').DisplayLabel := 'COUNTRY NAME';
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
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName,
        [TableName + '.' + 'id',
        TableName + '.' + 'city_name',
        TableName + '.' + 'country_name']) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id            := FieldByName('id').AsInteger;
		    Self.FCityName     := FieldByName('city_name').AsString;
        Self.FCountryName  := FieldByName('country_name').AsString;

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
      SQL.Text := Self.Database.GetSQLInsertCmd(TableName, SQL_PARAM_SEPERATE,
        ['city_name', 'country_name']);

      ParamByName('city_name').Value := Self.FCityName;
      ParamByName('country_name').Value := Self.FCountryName;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

      Open;
      if (Fields.Count > 0) and (not Fields.Fields[0].IsNull) then
        pID := Fields.FieldByName('id').AsInteger
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
		  SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, SQL_PARAM_SEPERATE,
		    ['city_name', 'country_name']);

      ParamByName('city_name').Value := Self.FCityName;
      ParamByName('country_name').Value := Self.FCountryName;

		  ParamByName('id').Value := Self.Id;

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
  self.FCityName := '';
  self.FCountryName := '';
end;

function TCity.Clone():TTable;
begin
  Result := TCity.Create(Database);
  TCity(Result).FCityName          := Self.FCityName;
  TCity(Result).FCountryName       := Self.FCountryName;

  TCity(Result).Id              := Self.Id;
end;

end.
