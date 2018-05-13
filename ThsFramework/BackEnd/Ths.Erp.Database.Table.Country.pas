unit Ths.Erp.Database.Table.Country;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TCountry = class(TTable)
  private
    FCountryCode       : string;
    FCountryName       : string;
    FISOYear           : Integer;
    FISOCCTLDCode      : string;
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

    Property CountryCode    : string    read FCountryCode        write FCountryCode;
    Property CountryName    : string    read FCountryName        write FCountryName;
    Property ISOYear        : Integer   read FISOYear            write FISOYear;
    Property ISOCCTLDCode   : string    read FISOCCTLDCode       write FISOCCTLDCode;
  end;

implementation

constructor TCountry.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'ulke';
  Self.PermissionSourceCode := 'ÜLKE';
end;

procedure TCountry.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if Database.IsAuthorized(Self.PermissionSourceCode, ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName,
        [TableName + '.' + 'id,' +
        TableName + '.' + 'validity,' +
        TableName + '.' + 'kod,' +
        TableName + '.' + 'ulke_adi,' +
        TableName + '.' + 'yil,' +
        TableName + '.' + 'cctld_kodu']) +
        ' WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField('id').DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField('validity').DisplayLabel := 'VALIDITY';
      Self.DataSource.DataSet.FindField('kod').DisplayLabel := 'KOD';
      Self.DataSource.DataSet.FindField('ulke_adi').DisplayLabel := 'ÜLKE ADI';
      Self.DataSource.DataSet.FindField('yil').DisplayLabel := 'YIL';
      Self.DataSource.DataSet.FindField('cctld_kodu').DisplayLabel := 'CCTLD KODU';
	  end;
  end
  else
    raise Exception.Create('Bu kaynaða eriþim hakkýnýz yok! : ' + Self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.PermissionSourceCode);
end;

procedure TCountry.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if Database.IsAuthorized(Self.PermissionSourceCode, ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName,
        [TableName + '.' + 'id,' +
        TableName + '.' + 'validity,' +
        TableName + '.' + 'kod,' +
        TableName + '.' + 'ulke_adi,' +
        TableName + '.' + 'yil,' +
        TableName + '.' + 'cctld_kodu']) +
        ' WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id           := FieldByName('id').AsInteger;
		    Self.Validity     := FieldByName('validity').AsBoolean;

		    Self.FCountryCode     := FieldByName('kod').AsString;
        Self.FCountryName     := FieldByName('ulke_adi').AsString;
        Self.FISOYear         := FieldByName('yil').AsInteger;
        Self.FISOCCTLDCode    := FieldByName('cctld_kodu').AsString;

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end
  else
    raise Exception.Create('Bu kaynaða eriþim hakkýnýz yok! : ' + Self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.PermissionSourceCode);
end;

procedure TCountry.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if Database.IsAuthorized(Self.PermissionSourceCode, ptWrite, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLInsertCmd(TableName, ':',
		    ['kod', 'ulke_adi', 'yil', 'cctld_kodu']).Text;

		  if (Self.FCountryCode <> '') then
		    ParamByName('kod').Value := Self.FCountryCode;
      if (Self.FCountryName <> '') then
		    ParamByName('ulke_adi').Value := Self.FCountryName;
      if (Self.FISOYear <> 0) then
		    ParamByName('yil').Value := Self.FISOYear;
      if (Self.ISOCCTLDCode <> '') then
		    ParamByName('cctld_kodu').Value := Self.ISOCCTLDCode;

		  Open;
      if (Fields.Count > 0) and (not Fields.Fields[0].IsNull) then
        pID := Fields.FieldByName('id').AsInteger
      else
        pID := 0;

		  EmptyDataSet;
		  Close;
	  end;
    Self.notify;
  end
  else
    raise Exception.Create('Bu kaynaða yazma hakkýnýz yok! : ' + Self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.PermissionSourceCode);
end;

procedure TCountry.Update(pPermissionControl: Boolean=True);
begin
  if Database.IsAuthorized(Self.PermissionSourceCode, ptWrite, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, ':',
		    ['validity', 'kod', 'ulke_adi', 'yil', 'cctld_kodu']).Text;

		  if (Self.FCountryCode <> '') then
		    ParamByName('kod').Value := Self.FCountryCode;
      if (Self.FCountryName <> '') then
		    ParamByName('ulke_adi').Value := Self.FCountryName;
      if (Self.FISOYear <> 0) then
		    ParamByName('yil').Value := Self.FISOYear;
      if (Self.FISOCCTLDCode <> '') then
		    ParamByName('cctld_kodu').Value := Self.FISOCCTLDCode;

		  ParamByName('validity').Value := Self.Validity;
		  ParamByName('id').Value := Self.Id;

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end
  else
    raise Exception.Create('Bu kaynaðý güncelleme hakkýnýz yok! : ' + Self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.PermissionSourceCode);
end;

procedure TCountry.Clear();
begin
  inherited;
  self.FCountryCode := '';
  self.FCountryName := '';
  self.FISOYear := 0;
  self.FISOCCTLDCode := '';
end;

function TCountry.Clone():TTable;
begin
  Result := TCountry.Create(Database);
  TCountry(Result).FCountryCode          := Self.FCountryCode;
  TCountry(Result).FCountryName          := Self.FCountryName;
  TCountry(Result).FISOYear              := Self.FISOYear;
  TCountry(Result).FISOCCTLDCode         := Self.FISOCCTLDCode;

  TCountry(Result).Id              := Self.Id;
  TCountry(Result).Validity        := Self.Validity;

  TCountry(Result).PermissionSourceCode      := Self.PermissionSourceCode;
end;

end.
