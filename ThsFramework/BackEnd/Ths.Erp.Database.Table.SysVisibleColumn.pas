unit Ths.Erp.Database.Table.SysVisibleColumn;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TSysVisibleColumns = class(TTable)
  private
    FTableName        : string;
    FColumnName       : string;
    FColumnWidth      : Integer;
    FIsPercentageColoredBar: Boolean;
    FPercentageMin    : Double;
    FPercentageMax    : Double;
    FIsColoredNumber  : Boolean;
    FColoredNumberMin : Double;
    FColoredNumberMax : Double;
    FIsRequired       : Boolean;
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

    Property TableName1             : string      read FTableName               write FTableName;
    Property ColumnName             : string      read FColumnName              write FColumnName;
    property ColumnWidth            : Integer     read FColumnWidth             write FColumnWidth;
    property IsPercentageColoredBar : Boolean     read FIsPercentageColoredBar  write FIsPercentageColoredBar;
    property PercentageMin          : Double      read FPercentageMin           write FPercentageMin;
    property PercentageMax          : Double      read FPercentageMax           write FPercentageMax;
    property IsColoredNumber        : Boolean     read FIsColoredNumber         write FIsColoredNumber;
    property ColoredNumberMin       : Double      read FColoredNumberMin        write FColoredNumberMin;
    property ColoredNumberMax       : Double      read FColoredNumberMax        write FColoredNumberMax;
    property IsRequired             : Boolean     read FIsRequired              write FIsRequired;
  end;

implementation

constructor TSysVisibleColumns.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_visible_columns';
  Self.PermissionSourceCode := 'AYARLAR';
end;

procedure TSysVisibleColumns.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if Database.IsAuthorized(Self.PermissionSourceCode, ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName,
        [TableName + '.' + 'id',
        TableName + '.' + 'validity',
        TableName + '.' + 'table_name',
        TableName + '.' + 'column_name',
        TableName + '.' + 'column_width']) +
        ' WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField('id').DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField('validity').DisplayLabel := 'VALIDITY';
      Self.DataSource.DataSet.FindField('table_name').DisplayLabel := 'TABLE NAME';
      Self.DataSource.DataSet.FindField('column_name').DisplayLabel := 'COLUMN NAME';
      Self.DataSource.DataSet.FindField('column_width').DisplayLabel := 'COLUMN WIDTH';
	  end;
  end
  else
    raise Exception.Create('Bu kaynaða eriþim hakkýnýz yok! : ' + Self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.PermissionSourceCode);
end;

procedure TSysVisibleColumns.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if Database.IsAuthorized(Self.PermissionSourceCode, ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName,
        [TableName + '.' + 'id',
        TableName + '.' + 'validity',
        TableName + '.' + 'table_name',
        TableName + '.' + 'column_name',
        TableName + '.' + 'column_width']) +
        ' WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id            := FieldByName('id').AsInteger;
		    Self.Validity      := FieldByName('validity').AsBoolean;

		    Self.FTableName    := FieldByName('table_name').AsString;
        Self.FColumnName   := FieldByName('column_name').AsString;
        Self.FColumnWidth  := FieldByName('column_width').AsInteger;

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

procedure TSysVisibleColumns.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if Database.IsAuthorized(Self.PermissionSourceCode, ptWrite, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLInsertCmd(TableName, ':',
        ['table_name', 'column_name', 'column_width']).Text;

		  if (Self.FTableName <> '') then
		    ParamByName('table_name').Value := Self.FTableName;
      if (Self.FColumnName <> '') then
		    ParamByName('column_name').Value := Self.FColumnName;
      if (Self.FColumnWidth <> 0) then
		    ParamByName('column_width').Value := Self.FColumnWidth;

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

procedure TSysVisibleColumns.Update(pPermissionControl: Boolean=True);
begin
  if Database.IsAuthorized(Self.PermissionSourceCode, ptWrite, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, ':',
        ['validity', 'table_name', 'column_name', 'column_width']).Text;

      ParamByName('table_name').Value := Self.FTableName;
      ParamByName('column_name').Value := Self.FColumnName;
      ParamByName('column_width').Value := Self.FColumnWidth;

		  ParamByName('validity').Value := Self.Validity;
		  ParamByName('id').Value := Self.Id;

      Self.Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end
  else
    raise Exception.Create('Bu kaynaðý güncelleme hakkýnýz yok! : ' + Self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.PermissionSourceCode);
end;

procedure TSysVisibleColumns.Clear();
begin
  inherited;
  Self.FTableName := '';
  Self.FColumnName := '';
  Self.FColumnWidth := 0;
end;

function TSysVisibleColumns.Clone():TTable;
begin
  Result := TSysVisibleColumns.Create(Database);
  TSysVisibleColumns(Result).FTableName       := Self.FTableName;
  TSysVisibleColumns(Result).FColumnName      := Self.FColumnName;
  TSysVisibleColumns(Result).FColumnWidth     := Self.FColumnWidth;

  TSysVisibleColumns(Result).Id               := Self.Id;
  TSysVisibleColumns(Result).Validity         := Self.Validity;

  TSysVisibleColumns(Result).PermissionSourceCode := Self.PermissionSourceCode;
end;

end.
