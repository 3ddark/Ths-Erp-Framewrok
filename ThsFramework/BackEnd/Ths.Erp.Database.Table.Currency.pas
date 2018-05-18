unit Ths.Erp.Database.Table.Currency;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TCurrency = class(TTable)
  private
    FCode         : string;
    FSymbol       : string;
    FIsDefault    : Boolean;
    FCodeComment  : string;
  protected
    procedure BusinessUpdate(pPermissionControl: Boolean);override;
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property Code         : string    read FCode        write FCode;
    Property Symbol       : string    read FSymbol      write FSymbol;
    Property IsDefault    : Boolean   read FIsDefault   write FIsDefault;
    Property CodeComment  : string    read FCodeComment write FCodeComment;
  end;

implementation

uses
  Ths.Erp.Constants;

constructor TCurrency.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'currency';
end;

procedure TCurrency.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName,
        [TableName + '.' + 'id',
        TableName + '.' + 'code',
        TableName + '.' + 'symbol',
        TableName + '.' + 'is_default',
        TableName + '.' + 'code_comment']) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField('id').DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField('code').DisplayLabel := 'CODE';
      Self.DataSource.DataSet.FindField('symbol').DisplayLabel := 'SYMBOL';
      Self.DataSource.DataSet.FindField('is_default').DisplayLabel := 'DEFAULT?';
      Self.DataSource.DataSet.FindField('code_comment').DisplayLabel := 'CODE COMMENT';
	  end;
  end;
end;

procedure TCurrency.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
        TableName + '.' + 'code',
        TableName + '.' + 'symbol',
        TableName + '.' + 'is_default',
        TableName + '.' + 'code_comment']) +
        ' WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id           := FieldByName('id').AsInteger;

		    Self.FCode        := FieldByName('code').AsString;
        Self.FSymbol      := FieldByName('symbol').AsString;
        Self.FIsDefault   := FieldByName('is_default').AsBoolean;
        Self.FCodeComment := FieldByName('code_comment').AsString;

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TCurrency.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
      Close;
      SQL.Clear;
      SQL.Text := Self.Database.GetSQLInsertCmd(TableName, SQL_PARAM_SEPERATE,
        ['code', 'symbol', 'is_default', 'code_comment']);

      ParamByName('code').Value := Self.FCode;
      ParamByName('symbol').Value := Self.FSymbol;
      ParamByName('is_default').Value := Self.FIsDefault;
      ParamByName('code_comment').Value := Self.FCodeComment;

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

procedure TCurrency.Update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, SQL_PARAM_SEPERATE,
        ['code', 'symbol', 'is_default', 'code_comment']);

      ParamByName('code').Value := Self.FCode;
      ParamByName('symbol').Value := Self.FSymbol;
      ParamByName('is_default').Value := Self.FIsDefault;
      ParamByName('code_comment').Value := Self.FCodeComment;

		  ParamByName('id').Value := Self.Id;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

procedure TCurrency.BusinessUpdate(pPermissionControl: Boolean);
var
  vCurreny: TCurrency;
  n1: Integer;
begin
  if Self.IsDefault then
  begin
    vCurreny := TCurrency.Create(Self.Database);
    try
      vCurreny.SelectToList('', False, False);
      for n1 := 0 to vCurreny.List.Count-1 do
      begin
        TCurrency(vCurreny.List[n1]).IsDefault := False;
        TCurrency(vCurreny.List[n1]).Update;
      end;
    finally
      vCurreny.Free;
    end;
  end;
  Self.Update();
end;

procedure TCurrency.Clear();
begin
  inherited;
  Self.FCode := '';
  Self.FSymbol := '';
  Self.FIsDefault := False;
  Self.FCodeComment := '';
end;

function TCurrency.Clone():TTable;
begin
  Result := TCurrency.Create(Database);
  TCurrency(Result).FCode          := Self.FCode;
  TCurrency(Result).FSymbol        := Self.FSymbol;
  TCurrency(Result).FIsDefault     := Self.FIsDefault;
  TCurrency(Result).FCodeComment   := Self.FCodeComment;

  TCurrency(Result).Id              := Self.Id;
end;

end.
