unit Ths.Erp.Database.Table.Currency;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TCurrency = class(TTable)
  private
    FCode         : TFieldDB;
    FSymbol       : TFieldDB;
    FIsDefault    : TFieldDB;
    FCodeComment  : TFieldDB;
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

    Property Code         : TFieldDB  read FCode        write FCode;
    Property Symbol       : TFieldDB  read FSymbol      write FSymbol;
    Property IsDefault    : TFieldDB  read FIsDefault   write FIsDefault;
    Property CodeComment  : TFieldDB  read FCodeComment write FCodeComment;
  end;

implementation

uses
  Ths.Erp.Constants;

constructor TCurrency.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'currency';
  SourceCode := '1001';

  Self.FCode := TFieldDB.Create('code', ftString, '');
  Self.FSymbol := TFieldDB.Create('symbol', ftString, '');
  Self.FIsDefault := TFieldDB.Create('is_default', ftBoolean, False);
  Self.FCodeComment := TFieldDB.Create('code_comment', ftString, '');
end;

procedure TCurrency.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FCode.FieldName,
          TableName + '.' + FSymbol.FieldName,
          TableName + '.' + FIsDefault.FieldName,
          TableName + '.' + FCodeComment.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FCode.FieldName).DisplayLabel := 'CODE';
      Self.DataSource.DataSet.FindField(FSymbol.FieldName).DisplayLabel := 'SYMBOL';
      Self.DataSource.DataSet.FindField(FIsDefault.FieldName).DisplayLabel := 'DEFAULT?';
      Self.DataSource.DataSet.FindField(FCodeComment.FieldName).DisplayLabel := 'CODE COMMENT';
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
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FCode.FieldName,
          TableName + '.' + FSymbol.FieldName,
          TableName + '.' + FIsDefault.FieldName,
          TableName + '.' + FCodeComment.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id.Value := FieldByName(Self.Id.FieldName).AsInteger;

		    Self.FCode.Value := FieldByName(FCode.FieldName).AsString;
        Self.FSymbol.Value := FieldByName(FSymbol.FieldName).AsString;
        Self.FIsDefault.Value := FieldByName(FIsDefault.FieldName).AsBoolean;
        Self.FCodeComment.Value := FieldByName(FCodeComment.FieldName).AsString;

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
      SQL.Text := Self.Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FCode.FieldName,
        FSymbol.FieldName,
        FIsDefault.FieldName,
        FCodeComment.FieldName
      ]);

      ParamByName(Fcode.FieldName).Value := Self.FCode.Value;
      ParamByName(FSymbol.FieldName).Value := Self.FSymbol.Value;
      ParamByName(FIsDefault.FieldName).Value := Self.FIsDefault.Value;
      ParamByName(FCodeComment.FieldName).Value := Self.FCodeComment.Value;

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

procedure TCurrency.Update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FCode.FieldName,
        FSymbol.FieldName,
        FIsDefault.FieldName,
        FCodeComment.FieldName
      ]);

      ParamByName(FCode.FieldName).Value := Self.FCode.Value;
      ParamByName(FSymbol.FieldName).Value := Self.FSymbol.Value;
      ParamByName(FIsDefault.FieldName).Value := Self.FIsDefault.Value;
      ParamByName(FCodeComment.FieldName).Value := Self.FCodeComment.Value;

		  ParamByName(Self.Id.FieldName).Value := Self.Id.Value;

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
  if (Self.IsDefault.Value) then
  begin
    vCurreny := TCurrency.Create(Self.Database);
    try
      vCurreny.SelectToList('', False, False);
      for n1 := 0 to vCurreny.List.Count-1 do
      begin
        TCurrency(vCurreny.List[n1]).IsDefault.Value := False;
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
  Self.FCode.Value := '';
  Self.FSymbol.Value := '';
  Self.FIsDefault.Value := False;
  Self.FCodeComment.Value := '';
end;

function TCurrency.Clone():TTable;
begin
  Result := TCurrency.Create(Database);

  Self.Id.Clone(TCurrency(Result).Id);

  Self.FCode.Clone(TCurrency(Result).FCode);
  Self.FSymbol.Clone(TCurrency(Result).FSymbol);
  Self.FIsDefault.Clone(TCurrency(Result).FIsDefault);
  Self.FCodeComment.Clone(TCurrency(Result).FCodeComment);
end;

end.
