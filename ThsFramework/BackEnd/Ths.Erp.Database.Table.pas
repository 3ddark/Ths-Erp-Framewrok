unit Ths.Erp.Database.Table;

interface

uses
  Forms, SysUtils, Classes, Dialogs, WinSock,
  FireDAC.Stan.Param, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  Ths.Erp.Database;

type
  TProductPrice = (ppNone, ppSales, ppBuying, ppRawBuying, ppExport);

type
  TTableAction = (taSelect, taInsert, taUpdate, taDelete);

type
  {$M+}
  TTable = class
  private
    //database table name
    FTableName            : string;
    //table record row id
    FId                   : Integer;
    //pointer singleton database
    FDatabase             : TDatabase;
  protected
    //record list storage in selected rows
    FList                 : TList;
    //for dbgrid use
    FDataSource           : TDataSource;
    //FDatabase             : TDatabase;
    //for dbgrid or selecttolist query execute
    FQueryOfTable         : TFDQuery;
    //for other special sql execute
    FQueryOfOther         : TFDQuery;

    procedure FreeListContent();virtual;

    //protected business function
    procedure BusinessSelect(pFilter: string; pLock, pPermissionControl: Boolean);virtual;
    procedure BusinessInsert(out pID: Integer; var pPermissionControl: Boolean);virtual;
    procedure BusinessUpdate(pPermissionControl: Boolean);virtual;
    procedure BusinessDelete(pPermissionControl: Boolean);virtual;
  published
    constructor Create(OwnerDatabase: TDatabase);virtual;
    destructor Destroy();override;

    function IsAuthorized(pPermissionType: TPermissionType;
      pPermissionControl: Boolean; pShowException: Boolean = True): Boolean;
  public
    property TableName: string read FTableName write FTableName;
    property Id: Integer read FId write FId;

    property List: TList read FList;
    property DataSource: TDataSource read FDataSource;
    //property Database: TDatabase read FDatabase;
    property QueryOfTable: TFDQuery read FQueryOfTable write FQueryOfTable;
    property QueryOfOther: TFDQuery read FQueryOfOther;
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
    function Clone():TTable;Virtual;abstract;

    //public business functions
    function LogicalSelect(pFilter: string; pLock, pWithBegin, pPermissionControl: Boolean):Boolean;virtual;
    function LogicalInsert(out pID: Integer; pWithBegin, pWithCommit, pPermissionControl: Boolean):Boolean;virtual;
    function LogicalUpdate(pWithCommit, pPermissionControl: Boolean):Boolean;virtual;
    function LogicalDelete(pWithCommit, pPermissionControl: Boolean):Boolean;virtual;
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
  Id := 0;
end;

constructor TTable.Create(OwnerDatabase: TDatabase);
begin
  FDatabase := OwnerDatabase;

  FList                       := TList.Create();
  FList.Clear();

  FQueryOfTable               := FDatabase.NewQuery;
  FQueryOfOther               := FDatabase.NewQuery;

  FDataSource                 := TDataSource.Create(nil);
  FDataSource.DataSet         := FQueryOfTable;
  FDataSource.Enabled         := True;
  FDataSource.AutoEdit        := True;
  FDataSource.Tag             := 0;

  Self.Id                     := FDatabase.GetNewRecordId();
end;

procedure TTable.Delete(pPermissionControl: Boolean);
begin
  if Self.IsAuthorized(ptDelete, pPermissionControl) then
  begin
    with QueryOfTable do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'DELETE FROM ' + TableName + ' WHERE id=:id;';
      ParamByName('id').Value := self.Id;

      ExecSQL;
      Close;
    end;
    Self.notify;
  end;
end;

destructor TTable.Destroy;
begin
  FreeListContent();

  FList.Free;
  FDataSource.Free;
  FQueryOfTable.Free;
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
        'SELECT ' + vField + ' source_code, source_name ' +
        'FROM public.sys_user_access_right uar' +
        'LEFT JOIN sys_permission_source ps ON ps.source_code = permission_source_code ' +
        'WHERE table_name=' + QuotedStr(TableName) +
         ' and user_name=' + QuotedStr(SingletonDB.User.UserName) + vFilter;
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
          'Process ' + vMessage + TSpecialFunctions.AddLineBreak(2) +
          'There is no access to this resource! : ' + Self.TableName + ' ' + Self.ClassName + sLineBreak +
          'Missing Permission Source Name: ' + vSourceCode + ' ' + vSourceName);
    end;
  end
  else
  begin
    Result := True;
  end;
end;

procedure TTable.Listen;
begin
  with QueryOfTable do
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
    on E: Exception do
    begin
      Result := False;
      Self.Database.Connection.Rollback;
    end;
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
    Self.Id := pID;
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
  with QueryOfTable do
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
  with QueryOfTable do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'unlisten ' + self.TableName + ';';
    ExecSQL;
    Close;
  end;
end;

end.
