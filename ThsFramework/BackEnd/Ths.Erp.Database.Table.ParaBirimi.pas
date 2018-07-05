unit Ths.Erp.Database.Table.ParaBirimi;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TParaBirimi = class(TTable)
  private
    FKod: TFieldDB;
    FSembol: TFieldDB;
    FAciklama: TFieldDB;
    FIsVarsayilan: TFieldDB;
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

    property Kod: TFieldDB read FKod write FKod;
    property Sembol: TFieldDB read FSembol write FSembol;
    property Aciklama: TFieldDB read FAciklama write FAciklama;
    property IsVarsayilan: TFieldDB read FIsVarsayilan write FIsVarsayilan;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TParaBirimi.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'para_birimi';
  SourceCode := '1001';

  FKod := TFieldDB.Create('kod', ftString, '');
  FSembol := TFieldDB.Create('sembol', ftString, '');
  FAciklama := TFieldDB.Create('aciklama', ftString, '');
  FIsVarsayilan := TFieldDB.Create('is_varsayilan', ftBoolean, False);
end;

procedure TParaBirimi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FKod.FieldName,
          TableName + '.' + FSembol.FieldName,
          TableName + '.' + FAciklama.FieldName,
          TableName + '.' + FIsVarsayilan.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FKod.FieldName).DisplayLabel := 'KOD';
      Self.DataSource.DataSet.FindField(FSembol.FieldName).DisplayLabel := 'SEMBOL';
      Self.DataSource.DataSet.FindField(FAciklama.FieldName).DisplayLabel := 'AÇIKLAMA';
      Self.DataSource.DataSet.FindField(FIsVarsayilan.FieldName).DisplayLabel := 'VARSAYILAN?';
	  end;
  end;
end;

procedure TParaBirimi.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
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
          TableName + '.' + FKod.FieldName,
          TableName + '.' + FSembol.FieldName,
          TableName + '.' + FAciklama.FieldName,
          TableName + '.' + FIsVarsayilan.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id.Value := GetVarToFormatedValue(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

		    FKod.Value := GetVarToFormatedValue(FieldByName(FKod.FieldName).DataType, FieldByName(FKod.FieldName).Value);
        FSembol.Value := GetVarToFormatedValue(FieldByName(FSembol.FieldName).DataType, FieldByName(FSembol.FieldName).Value);
        FAciklama.Value := GetVarToFormatedValue(FieldByName(FAciklama.FieldName).DataType, FieldByName(FAciklama.FieldName).Value);
        FIsVarsayilan.Value := GetVarToFormatedValue(FieldByName(FIsVarsayilan.FieldName).DataType, FieldByName(FIsVarsayilan.FieldName).Value);

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TParaBirimi.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FKod.FieldName,
        FSembol.FieldName,
        FAciklama.FieldName,
        FIsVarsayilan.FieldName
      ]);

      ParamByName(FKod.FieldName).Value := GetVarToFormatedValue(FKod.FieldType, FKod.Value);
      ParamByName(FSembol.FieldName).Value := GetVarToFormatedValue(FSembol.FieldType, FSembol.Value);
      ParamByName(FAciklama.FieldName).Value := GetVarToFormatedValue(FAciklama.FieldType, FAciklama.Value);
      ParamByName(FIsVarsayilan.FieldName).Value := GetVarToFormatedValue(FIsVarsayilan.FieldType, FIsVarsayilan.Value);

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

procedure TParaBirimi.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FKod.FieldName,
        FSembol.FieldName,
        FAciklama.FieldName,
        FIsVarsayilan.FieldName
      ]);

      ParamByName(FKod.FieldName).Value := GetVarToFormatedValue(FKod.FieldType, FKod.Value);
      ParamByName(FSembol.FieldName).Value := GetVarToFormatedValue(FSembol.FieldType, FSembol.Value);
      ParamByName(FAciklama.FieldName).Value := GetVarToFormatedValue(FAciklama.FieldType, FAciklama.Value);
      ParamByName(FIsVarsayilan.FieldName).Value := GetVarToFormatedValue(FIsVarsayilan.FieldType, FIsVarsayilan.Value);

		  ParamByName(Self.Id.FieldName).Value := GetVarToFormatedValue(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

procedure TParaBirimi.BusinessUpdate(pPermissionControl: Boolean);
var
  vPara: TParaBirimi;
  n1: Integer;
begin
  if (IsVarsayilan.Value) then
  begin
    vPara := TParaBirimi.Create(Database);
    try
      vPara.SelectToList('', False, False);
      for n1 := 0 to vPara.List.Count-1 do
      begin
        TParaBirimi(vPara.List[n1]).IsVarsayilan.Value := False;
        TParaBirimi(vPara.List[n1]).Update;
      end;
    finally
      vPara.Free;
    end;
  end;
  Self.Update();
end;

procedure TParaBirimi.Clear();
begin
  inherited;
  FKod.Value := '';
  FSembol.Value := '';
  FAciklama.Value := '';
  FIsVarsayilan.Value := False;
end;

function TParaBirimi.Clone():TTable;
begin
  Result := TParaBirimi.Create(Database);

  Self.Id.Clone(TParaBirimi(Result).Id);

  FKod.Clone(TParaBirimi(Result).FKod);
  FSembol.Clone(TParaBirimi(Result).FSembol);
  FAciklama.Clone(TParaBirimi(Result).FAciklama);
  FIsVarsayilan.Clone(TParaBirimi(Result).FIsVarsayilan);
end;

end.
