unit Ths.Erp.Database.Table;

interface

uses
  Forms, SysUtils, Classes, Dialogs, WinSock, System.Rtti, System.UITypes,
  StrUtils,
  FireDAC.Stan.Param, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Stan.Error,
  Ths.Erp.Database,
  Ths.Erp.Database.Table.Field;

type
  TProductPrice = (ppNone, ppSales, ppBuying, ppRawBuying, ppExport);

type
  TTableAction = (taSelect, taInsert, taUpdate, taDelete);

type
  TSequenceStatus = (ssArtis, ssAzalma, ssDegisimYok);

type
  {$M+}
  TTable = class
  private
    //database table name
    FTableName: string;
    FSourceCode: string;
    //table record row id
//    FId: TFieldDB;
    //pointer singleton database
    FDatabase: TDatabase;
  protected
    //record list storage in selected rows
    FList: TList;
    //for dbgrid use
    FDataSource: TDataSource;
    //FDatabase: TDatabase;
    FQueryOfDS: TFDQuery;
    FQueryOfList: TFDQuery;
    FQueryOfInsert: TFDQuery;
    FQueryOfUpdate: TFDQuery;
    FQueryOfDelete: TFDQuery;
    //for other special sql execute
    FQueryOfOther: TFDQuery;

    procedure FreeListContent();virtual;

    //protected business function
    procedure BusinessSelect(pFilter: string; pLock, pPermissionControl: Boolean);virtual;
    procedure BusinessInsert(out pID: Integer; var pPermissionControl: Boolean);virtual;
    procedure BusinessUpdate(pPermissionControl: Boolean);virtual;
    procedure BusinessDelete(pPermissionControl: Boolean);virtual;

  published
    constructor Create(pOwnerDatabase: TDatabase); virtual;
    destructor Destroy(); override;

    function IsAuthorized(pPermissionType: TPermissionType;
        pPermissionControl: Boolean; pShowException: Boolean = True): Boolean;
  public
    Id: TFieldDB;
    property TableName: string read FTableName write FTableName;
    property SourceCode: string read FSourceCode write FSourceCode;

    property List: TList read FList;
    property DataSource: TDataSource read FDataSource;
    //property Database: TDatabase read FDatabase;
    property QueryOfDS: TFDQuery read FQueryOfDS write FQueryOfDS;
    property QueryOfList: TFDQuery read FQueryOfList write FQueryOfList;
    property QueryOfInsert: TFDQuery read FQueryOfInsert write FQueryOfInsert;
    property QueryOfUpdate: TFDQuery read FQueryOfUpdate write FQueryOfUpdate;
    property QueryOfDelete: TFDQuery read FQueryOfDelete write FQueryOfDelete;
    property QueryOfOther: TFDQuery read FQueryOfOther write FQueryOfOther;

    property Database: TDatabase read FDatabase;

    //for Postgres
    procedure Listen();virtual;
    procedure Unlisten();virtual;
    procedure Notify();virtual;

    //get records from the database for dbgrid
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);Virtual;Abstract;
    //get records from the database into the list
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);Virtual;Abstract;
    //insert record to database
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); Virtual;Abstract;
    //update record to database
    procedure Update(pPermissionControl: Boolean=True); Virtual;Abstract;
    //delete record from the database
    procedure Delete(pPermissionControl: Boolean=True); Virtual;
    //clear to class attributes
    procedure Clear();Virtual;
    //clone to class attribute into new class
    function Clone():TTable;Virtual;//abstract;

    //public business functions
    function LogicalSelect(pFilter: string; pLock, pWithBegin, pPermissionControl: Boolean):Boolean;virtual;
    function LogicalInsert(out pID: Integer; pWithBegin, pWithCommit, pPermissionControl: Boolean):Boolean;virtual;
    function LogicalUpdate(pWithCommit, pPermissionControl: Boolean):Boolean;virtual;
    function LogicalDelete(pWithCommit, pPermissionControl: Boolean):Boolean;virtual;

    //Datalar çok dilli þekilde kullanýlacaksa bu ayar true yapýlýr.
    function IsMultiLangData(): Boolean;
  end;

implementation

uses
  Ths.Erp.SpecialFunctions,
  Ths.Erp.Database.Singleton;

{ TTable }

procedure TTable.BusinessDelete(pPermissionControl: Boolean);
begin
  Self.Delete(pPermissionControl);
end;

procedure TTable.BusinessInsert(out pID: Integer; var pPermissionControl: Boolean);
begin
  Self.Insert(pID, pPermissionControl);
end;

procedure TTable.BusinessSelect(pFilter: string; pLock, pPermissionControl: Boolean);
begin
  Self.SelectToList(pFilter, pLock, pPermissionControl);
end;

procedure TTable.BusinessUpdate(pPermissionControl: Boolean);
begin
  Self.Update(pPermissionControl);
end;

procedure TTable.Clear;
begin
  Id.Value := 0;
end;

function TTable.Clone: TTable;
begin
  Result := TTable(TObjectClone.From(Self));
end;

constructor TTable.Create(pOwnerDatabase: TDatabase);
begin
  FDatabase := pOwnerDatabase;

  FList := TList.Create();
  FList.Clear();

  FQueryOfDS := FDatabase.NewQuery;
  FQueryOfList := FDatabase.NewQuery;
  FQueryOfInsert := FDatabase.NewQuery;
  FQueryOfUpdate := FDatabase.NewQuery;
  FQueryOfDelete := FDatabase.NewQuery;
  FQueryOfOther := FDatabase.NewQuery;

  FDataSource := TDataSource.Create(nil);
  FDataSource.DataSet := FQueryOfDS;
  FDataSource.Enabled := True;
  FDataSource.AutoEdit := True;
  FDataSource.Tag := 0;

  Self.Id := TFieldDB.Create('id', ftInteger, 0, 0, False, False);
  Self.Id.Value := FDatabase.GetNewRecordId();
end;

procedure TTable.Delete(pPermissionControl: Boolean);
begin
  if Self.IsAuthorized(ptDelete, pPermissionControl) then
  begin
    with QueryOfDelete do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'DELETE FROM ' + TableName + ' WHERE id=:id;';
      ParamByName(Self.Id.FieldName).Value := FormatedVariantVal(Self.Id.FieldType, Self.Id.Value);

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

destructor TTable.Destroy;
var
  vCtx : TRttiContext;
  vRtm : TRttiMethod;
  vRtf : TRttiField;
  vRtt : TRttiType;
begin
  vCtx := TRttiContext.Create;
  vRtt := vCtx.GetType(Self.ClassType);
  for vRtf in vRtt.GetFields do
  begin
    if vRtf.FieldType.Name = 'TFieldDB' then
    begin
      for vRtm in vRtf.FieldType.GetMethods('Destroy') do
      begin
        if vRtm.IsDestructor then
        begin
          vRtm.Invoke(vRtf.GetValue(Self), []);
          vRtf.SetValue(Self, nil);
          break;
        end;
      end;
    end;
  end;

  FreeListContent();

  FList.Free;
  FDataSource.Free;

  FQueryOfDS.Free;
  FQueryOfList.Free;
  FQueryOfInsert.Free;
  FQueryOfUpdate.Free;
  FQueryOfDelete.Free;
  FQueryOfOther.Free;

  FDatabase := nil;

  inherited;
end;

procedure TTable.FreeListContent;
var
  nIndex: Integer;
begin
  for nIndex := 0 to List.Count -1 do
  begin
    TTable(List[nIndex]).Free;
  end;
  List.Clear;
end;

function TTable.IsAuthorized(pPermissionType: TPermissionType;
  pPermissionControl: Boolean; pShowException: Boolean = True): Boolean;
var
  vField, vFilter, vMessage, vSourceCode, vSourceName: string;
begin
  Result := False;
  if pPermissionControl then
  begin
    vField := '';
    vFilter := '';
    vMessage := '';
    if pPermissionType = ptRead then
    begin
      vField := 'is_read,';
      vFilter := ' and is_read=true ';
      vMessage := 'SELECT';
    end
    else if pPermissionType = ptAddRecord then
    begin
      vField := 'is_add_record,';
      vFilter := ' and is_add_record=true ';
      vMessage := 'INSERT';
    end
    else if pPermissionType = ptUpdate then
    begin
      vField := 'is_update,';
      vFilter := ' and is_update=true ';
      vMessage := 'UPDATE';
    end
    else if pPermissionType = ptDelete then
    begin
      vField := 'is_delete,';
      vFilter := ' and is_delete=true ';
      vMessage := 'DELETE';
    end
    else if pPermissionType = ptSpeacial then
    begin
      vField := 'is_special,';
      vFilter := ' and is_special=true ';
      vMessage := 'SPECIAL';
    end;

    with QueryOfOther do
    begin
      Close;
      SQL.Text :=
        'SELECT ' + vField + ' uar.source_code, source_name ' +
        'FROM public.sys_user_access_right uar ' +
        'LEFT JOIN sys_permission_source ps ON ps.source_code = uar.source_code ' +
        'WHERE uar.source_code=' + QuotedStr(FSourceCode) +
         ' and user_name=' + QuotedStr(TSingletonDB.GetInstance.User.UserName.Value) + vFilter;
      Open;
      while NOT EOF do
      begin
        Result := Fields.Fields[0].AsBoolean;
        vSourceCode := Fields.Fields[1].AsString;
        vSourceName := Fields.Fields[2].AsString;

        Next;
      end;
      EmptyDataSet;
      Close;
    end;

    if not Result then
    begin
      if pShowException then
        raise Exception.Create(
          'Process ' + vMessage + AddLBs(2) +
          'There is no access to this resource! : ' + Self.TableName + ' ' + Self.ClassName + sLineBreak +
          'Missing Permission Source Code: ' + Self.FSourceCode);
    end;
  end
  else
  begin
    Result := True;
  end;
end;

function TTable.IsMultiLangData: Boolean;
begin
  Result := False;
  with TSingletonDB.GetInstance.DataBase.NewQuery do
  try
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT * FROM sys_multi_lang_data_table_list WHERE table_name=' + QuotedStr(ReplaceRealColOrTableNameTo(Self.TableName));
    Open;

    if RecordCount = 1 then
      Result := True;

    Close;
  finally
    Free;
  end;
end;

procedure TTable.Listen;
begin
  with QueryOfOther do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'listen ' + self.TableName + ';';
    ExecSQL;
    Close;
  end;
end;

function TTable.LogicalDelete(pWithCommit, pPermissionControl: Boolean): Boolean;
begin
  Result := True;
  try
    Self.BusinessDelete(pPermissionControl);
    if pWithCommit then
      Self.Database.Connection.Commit;
  except
    Result := False;
  end;
end;

function TTable.LogicalInsert(out pID: Integer; pWithBegin, pWithCommit,
  pPermissionControl: Boolean): Boolean;
begin
  Result := True;
  try
    if pWithBegin then
      Self.Database.Connection.StartTransaction;
    Self.BusinessInsert(pID, pPermissionControl);
    Self.Id.Value := pID;
    if pWithCommit then
      Self.Database.Connection.Commit;
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      Result := False;
      Self.Database.Connection.Rollback;
    end;
  end;
end;

function TTable.LogicalSelect(pFilter: string; pLock, pWithBegin,
  pPermissionControl: Boolean): Boolean;
begin
  Result := True;
  try
    if not pLock then
      pWithBegin := False;

    if pWithBegin then
      Self.Database.Connection.StartTransaction;
    self.BusinessSelect(pFilter, pLock, pPermissionControl);
  except
    on E: Exception do
    begin
      Result := False;
      Self.Database.Connection.Rollback;
    end;
  end;
end;

function TTable.LogicalUpdate(pWithCommit, pPermissionControl: Boolean): Boolean;
begin
  Result := True;
  try
    Self.BusinessUpdate(pPermissionControl);
    if pWithCommit then
      Self.Database.Connection.Commit;
  except
    on E: Exception do
    begin
      Result := False;
      Self.Database.Connection.Rollback;
    end;
  end;
end;

procedure TTable.Notify;
begin
  with QueryOfOther do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'notify ' + self.TableName + ';';
    ExecSQL;
    Close;
  end;
end;

procedure TTable.Unlisten;
begin
  with QueryOfOther do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'unlisten ' + self.TableName + ';';
    ExecSQL;
    Close;
  end;
end;

end.
