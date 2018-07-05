unit Ths.Erp.Database.Table.SysGridColWidth;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants, Data.DB,
  Ths.Erp.Database,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field;

type
  TSysGridColWidth = class(TTable)
  private
    FTableName: TFieldDB;
    FColumnName: TFieldDB;
    FColumnWidth: TFieldDB;
    FSequenceNo: TFieldDB;
    //veri tabaný alaný deðil
    FSequenceStatus: TSequenceStatus;
    FOldValue: Integer;
  protected
    procedure BusinessUpdate(pPermissionControl: Boolean); override;
  published
    constructor Create(OwnerDatabase:TDatabase);override;

    function GetMaxSequenceNo(pTableName: string): Integer;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property TableName1: TFieldDB read FTableName write FTableName;
    Property ColumnName: TFieldDB read FColumnName write FColumnName;
    property ColumnWidth: TFieldDB read FColumnWidth write FColumnWidth;
    property SequenceNo: TFieldDB read FSequenceNo write FSequenceNo;
    //veri tabaný alaný deðil
    property SequenceStatus: TSequenceStatus read FSequenceStatus write FSequenceStatus;
    property OldValue: Integer read FOldValue write FOldValue;
  end;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton;

constructor TSysGridColWidth.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_grid_col_width';
  SourceCode := '1000';

  FTableName := TFieldDB.Create('table_name', ftString, '');
  FColumnName := TFieldDB.Create('column_name', ftString, '');
  FColumnWidth := TFieldDB.Create('column_width', ftInteger, 0);
  FSequenceNo := TFieldDB.Create('sequence_no', ftInteger, 0);

  FSequenceStatus := ssDegisimYok;
  FOldValue := 0;
end;

function TSysGridColWidth.GetMaxSequenceNo(pTableName: string): Integer;
var
  vGridColWidth: TSysGridColWidth;
begin
  Result := 0;
  vGridColWidth := TSysGridColWidth.Create(Database);
  try
    vGridColWidth.SelectToList(' AND ' + TableName + '.' + TableName1.FieldName + '=' + QuotedStr(pTableName) + ' ORDER BY sequence_no DESC ', False, False);
    if vGridColWidth.List.Count > 0 then
      Result := TSysGridColWidth(vGridColWidth.List[0]).FSequenceNo.Value;
  finally
    vGridColWidth.Free;
  end;
end;

procedure TSysGridColWidth.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FTableName.FieldName,
          TableName + '.' + FColumnName.FieldName,
          TableName + '.' + FColumnWidth.FieldName,
          TableName + '.' + FSequenceNo.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField(Self.Id.FieldName).DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField(FTableName.FieldName).DisplayLabel := 'TABLE NAME';
      Self.DataSource.DataSet.FindField(FColumnName.FieldName).DisplayLabel := 'COLUMN NAME';
      Self.DataSource.DataSet.FindField(FColumnWidth.FieldName).DisplayLabel := 'COLUMN WIDTH';
      Self.DataSource.DataSet.FindField(FSequenceNo.FieldName).DisplayLabel := 'SEQUENCE NO';
	  end;
  end;
end;

procedure TSysGridColWidth.SelectToList(pFilter: string; pLock: Boolean;
  pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName, [
          TableName + '.' + Self.Id.FieldName,
          TableName + '.' + FTableName.FieldName,
          TableName + '.' + FColumnName.FieldName,
          TableName + '.' + FColumnWidth.FieldName,
          TableName + '.' + FSequenceNo.FieldName
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id.Value := GetVarToFormatedValue(FieldByName(Self.Id.FieldName).DataType, FieldByName(Self.Id.FieldName).Value);

		    FTableName.Value := GetVarToFormatedValue(FieldByName(FTableName.FieldName).DataType, FieldByName(FTableName.FieldName).Value);
        FColumnName.Value := GetVarToFormatedValue(FieldByName(FColumnName.FieldName).DataType, FieldByName(FColumnName.FieldName).Value);
        FColumnWidth.Value := GetVarToFormatedValue(FieldByName(FColumnWidth.FieldName).DataType, FieldByName(FColumnWidth.FieldName).Value);
        FSequenceNo.Value := GetVarToFormatedValue(FieldByName(FSequenceNo.FieldName).DataType, FieldByName(FSequenceNo.FieldName).Value);

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TSysGridColWidth.Insert(out pID: Integer;
  pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLInsertCmd(TableName, QUERY_PARAM_CHAR, [
        FTableName.FieldName,
        FColumnName.FieldName,
        FColumnWidth.FieldName,
        FSequenceNo.FieldName
      ]);

      ParamByName(FTableName.FieldName).Value := GetVarToFormatedValue(FTableName.FieldType, FTableName.Value);
      ParamByName(FColumnName.FieldName).Value := GetVarToFormatedValue(FColumnName.FieldType, FColumnName.Value);
      ParamByName(FColumnWidth.FieldName).Value := GetVarToFormatedValue(FColumnWidth.FieldType, FColumnWidth.Value);
      ParamByName(FSequenceNo.FieldName).Value := GetVarToFormatedValue(FSequenceNo.FieldType, FSequenceNo.Value);

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

procedure TSysGridColWidth.Update(pPermissionControl: Boolean=True);
begin
  if IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Database.GetSQLUpdateCmd(TableName, QUERY_PARAM_CHAR, [
        FTableName.FieldName,
        FColumnName.FieldName,
        FColumnWidth.FieldName,
        FSequenceNo.FieldName
      ]);

      ParamByName(FTableName.FieldName).Value := GetVarToFormatedValue(FTableName.FieldType, FTableName.Value);
      ParamByName(FColumnName.FieldName).Value := GetVarToFormatedValue(FColumnName.FieldType, FColumnName.Value);
      ParamByName(FColumnWidth.FieldName).Value := GetVarToFormatedValue(FColumnWidth.FieldType, FColumnWidth.Value);
      ParamByName(FSequenceNo.FieldName).Value := GetVarToFormatedValue(FSequenceNo.FieldType, FSequenceNo.Value);

		  ParamByName(Self.Id.FieldName).Value := GetVarToFormatedValue(Self.Id.FieldType, Self.Id.Value);

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

procedure TSysGridColWidth.BusinessUpdate(pPermissionControl: Boolean);
var
  vGridColWidth: TSysGridColWidth;
  n1: Integer;
begin
  vGridColWidth := TSysGridColWidth.Create(Database);
  try
    if FSequenceStatus = ssArtis then
    begin
      vGridColWidth.SelectToList(
        ' and ' + TableName + '.' + FTableName.FieldName + '=' + QuotedStr(FTableName.Value) +
        ' and ' + TableName + '.' + FSequenceNo.FieldName + ' between ' + IntToStr(FOldValue) + ' AND ' + FSequenceNo.Value +
        ' and ' + TableName + '.' + Self.Id.FieldName + '<>' + IntToStr(Self.Id.Value) +
        ' ORDER BY ' + FSequenceNo.FieldName + ' ASC ', False, False);

      FSequenceNo.Value := FSequenceNo.Value + 1000;
      Self.Update();

      for n1 := 0 to vGridColWidth.List.Count-1 do
      begin
        if (FSequenceNo.Value - 1000) <> (OldValue+n1) then
        begin
          TSysGridColWidth(vGridColWidth.List[n1]).SequenceNo.Value := OldValue+n1;
          TSysGridColWidth(vGridColWidth.List[n1]).Update();
        end;
      end;

      FSequenceNo.Value := FSequenceNo.Value - 1000;
    end
    else if FSequenceStatus = ssAzalma then
    begin
      vGridColWidth.SelectToList(
          ' and ' + TableName + '.' + FTableName.FieldName + '=' + QuotedStr(FTableName.Value) +
          ' and ' + TableName + '.' + FSequenceNo.FieldName + ' between ' + FSequenceNo.Value + ' AND ' + IntToStr(FOldValue) +
          ' and ' + TableName + '.' + Self.Id.FieldName + '<>' + IntToStr(Self.Id.Value) +
          ' ORDER BY ' + FSequenceNo.FieldName + ' ASC ', False, False);

      FSequenceNo.Value := FSequenceNo.Value + 1000;
      Self.Update();

      for n1 := 0 to vGridColWidth.List.Count-1 do
      begin
        if (FSequenceNo.Value - 1000) <> (OldValue+n1) then
        begin
          TSysGridColWidth(vGridColWidth.List[n1]).SequenceNo.Value := (FSequenceNo.Value - 1000) + 1 + n1+100;
          TSysGridColWidth(vGridColWidth.List[n1]).Update();
        end;
      end;

      for n1 := 0 to vGridColWidth.List.Count-1 do
      begin
        if (FSequenceNo.Value - 1000) <> (FSequenceNo.Value - 1000) + 1 + n1 then
        begin
          TSysGridColWidth(vGridColWidth.List[n1]).SequenceNo.Value := (FSequenceNo.Value - 1000) + 1 + n1;
          TSysGridColWidth(vGridColWidth.List[n1]).Update();
        end;
      end;

      FSequenceNo.Value := FSequenceNo.Value - 1000;
    end;

    Self.Update();
  finally
    vGridColWidth.Free;
  end;
end;

procedure TSysGridColWidth.Clear();
begin
  inherited;
  FTableName.Value := '';
  FColumnName.Value := '';
  FColumnWidth.Value := 0;
  FSequenceNo.Value := 0;

  FSequenceStatus := ssDegisimYok;
  FOldValue := 0;
end;

function TSysGridColWidth.Clone():TTable;
begin
  Result := TSysGridColWidth.Create(Database);

  Self.Id.Clone(TSysGridColWidth(Result).Id);

  FTableName.Clone(TSysGridColWidth(Result).FTableName);
  FColumnName.Clone(TSysGridColWidth(Result).FColumnName);
  FColumnWidth.Clone(TSysGridColWidth(Result).FColumnWidth);
  FSequenceNo.Clone(TSysGridColWidth(Result).FSequenceNo);

  TSysGridColWidth(Result).FSequenceStatus := FSequenceStatus;
  TSysGridColWidth(Result).FOldValue := FOldValue;
end;

end.
