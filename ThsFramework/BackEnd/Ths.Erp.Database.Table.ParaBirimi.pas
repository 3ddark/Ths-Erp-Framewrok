unit Ths.Erp.Database.Table.ParaBirimi;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

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
  SourceCode := '1000';

  FKod := TFieldDB.Create('kod', ftString, '');
  FSembol := TFieldDB.Create('sembol', ftString, '');
  FAciklama := TFieldDB.Create('aciklama', ftString, '');
  FIsVarsayilan := TFieldDB.Create('is_varsayilan', ftBoolean, False);
end;

procedure TParaBirimi.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfDS do
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

	  with QueryOfList do
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
		    Self.Id.Value := FormatedVariantVal(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

		    FKod.Value := FormatedVariantVal(FieldByName(FKod.FieldName).DataType, FieldByName(FKod.FieldName).Value);
        FSembol.Value := FormatedVariantVal(FieldByName(FSembol.FieldName).DataType, FieldByName(FSembol.FieldName).Value);
        FAciklama.Value := FormatedVariantVal(FieldByName(FAciklama.FieldName).DataType, FieldByName(FAciklama.FieldName).Value);
        FIsVarsayilan.Value := FormatedVariantVal(FieldByName(FIsVarsayilan.FieldName).DataType, FieldByName(FIsVarsayilan.FieldName).Value);

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
	  with QueryOfInsert do
	  begin
      Close;
      SQL.Clear;
      SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FKod.FieldName,
        FSembol.FieldName,
        FAciklama.FieldName,
        FIsVarsayilan.FieldName
      ]);

      NewParamForQuery(QueryOfInsert, FKod);
      NewParamForQuery(QueryOfInsert, FSembol);
      NewParamForQuery(QueryOfInsert, FAciklama);
      NewParamForQuery(QueryOfInsert, FIsVarsayilan);

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
	  with QueryOfUpdate do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FKod.FieldName,
        FSembol.FieldName,
        FAciklama.FieldName,
        FIsVarsayilan.FieldName
      ]);

      NewParamForQuery(QueryOfUpdate, FKod);
      NewParamForQuery(QueryOfUpdate, FSembol);
      NewParamForQuery(QueryOfUpdate, FAciklama);
      NewParamForQuery(QueryOfUpdate, FIsVarsayilan);

      NewParamForQuery(QueryOfUpdate, Id);

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
