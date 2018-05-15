unit Ths.Erp.Database.Table;

interface

uses
  Forms, SysUtils, Classes, Dialogs, WinSock,
  FireDAC.Stan.Param, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  Ths.Erp.Database;

//const
//  COLUMN_ID       = 0;
//  COLUMN_VALIDITY = 1;

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
    //for user permission control
    FPermissionSourceCode : string;
    //table record row id
    FId                   : Integer;
    //for a virtual delete true normal false virtual deleted record
    FValidity             : Boolean;
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

    procedure TableAccessDeny(pAction: TTableAction);
    function GetPermissionNameFromCode(pPermissionCode: string): string;
  published
    constructor Create(OwnerDatabase: TDatabase);virtual;
    destructor Destroy();override;

    function IsAuthorized(pPermissionSourceCode: string;
      pPermissionType: TPermissionType; pPermissionControl: Boolean; pTableAction: TTableAction): Boolean;
  public
    property TableName: string read FTableName write FTableName;
    property Id: Integer read FId write FId;
    property Validity: Boolean read FValidity write FValidity;
    property PermissionSourceCode: string read FPermissionSourceCode write FPermissionSourceCode;

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
  uSpecialFunctions;

{ TTable }

procedure TTable.BusinessDelete(pPermissionControl: Boolean);
begin
  self.Delete(pPermissionControl);
end;

procedure TTable.BusinessInsert(out pID: Integer; var pPermissionControl: Boolean);
begin
  self.Insert(pID, pPermissionControl);
end;

procedure TTable.BusinessSelect(pFilter: string; pLock, pPermissionControl: Boolean);
begin
  self.SelectToList(pFilter, pLock, pPermissionControl);
end;

procedure TTable.BusinessUpdate(pPermissionControl: Boolean);
begin
  self.Update(pPermissionControl);
end;

procedure TTable.Clear;
begin
  Id        := 0;
  Validity  := True;
end;

constructor TTable.Create(OwnerDatabase: TDatabase);
begin
  FDatabase := OwnerDatabase;

  FList                       := TList.Create();
  FList.Clear();

  FQueryOfTable               := TFDQuery.Create(nil);
  FQueryOfTable.Connection    := FDatabase.Connection;

  FQueryOfOther               := TFDQuery.Create(nil);
  FQueryOfOther.Connection    := FDatabase.Connection;

  FDataSource                 := TDataSource.Create(nil);
  FDataSource.DataSet         := FQueryOfTable;
  FDataSource.Enabled         := True;
  FDataSource.AutoEdit        := True;
  FDataSource.Tag             := 0;

  PermissionSourceCode        := '';

  Self.Id                     := FDatabase.GetNewRecordId();
  Self.Validity               := True;
end;

procedure TTable.Delete(pPermissionControl: Boolean);
begin
  if Self.IsAuthorized(Self.PermissionSourceCode, ptDelete, pPermissionControl, taDelete) then
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

function TTable.GetPermissionNameFromCode(pPermissionCode: string): string;
begin
  raise Exception.Create('FERHAT buradaki kodu düzenle. tablo adý ve çalýþmasýný düzelt.');
  Result := '';
  with QueryOfTable do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'Select permission_source_name FROM xxx WHERE permission_source_code=' + QuotedStr(pPermissionCode);
    Open;
    Result := Fields.Fields[0].AsString;
    Close;
  end;
end;

function TTable.IsAuthorized(pPermissionSourceCode: string;
  pPermissionType: TPermissionType; pPermissionControl: Boolean;
  pTableAction: TTableAction): Boolean;
var
  vFilter: string;
  vMessage: string;
begin
  Result := False;
  if pPermissionControl then
  begin
    vFilter := '';
    if pPermissionType = ptRead then
      vFilter := ' and is_read=true '
    else if pPermissionType = ptWrite then
      vFilter := ' and is_write=true '
    else if pPermissionType = ptDelete then
      vFilter := ' and is_delete=true '
    else if pPermissionType = ptSpeacial then
      vFilter := ' and is_special=true ';

    with QueryOfOther do
    begin
      Close;
      SQL.Text := Self.Database.GetSQLSelectCmd('sys_user_access_right', [
        'id', 'validity', 'permission_source_code', 'is_read', 'is_write',
        'is_delete', 'is_special', 'user_name']) +
      ' WHERE permission_source_code=' + QuotedStr(pPermissionSourceCode) + ' and user_name ' + vFilter;
      Open;
      while NOT EOF do
      begin
        Result     := Fields.Fields[3].AsBoolean;
        Next;
      end;
      EmptyDataSet;
      Close;
    end;

    if not Result then
    begin
      vMessage := '';
      if pTableAction = taSelect then
        vMessage := 'SELECT'
      else if pTableAction = taInsert then
        vMessage := 'INSERT'
      else if pTableAction = taUpdate then
        vMessage := 'UPDATE'
      else if pTableAction = taDelete then
        vMessage := 'DELETE';

      raise Exception.Create(
        'Process ' + vMessage + TSpecialFunctions.AddLineBreak(2) +
        'There is no access to this resource! : ' + Self.TableName + Self.ClassName + sLineBreak +
        'Missing Permission Source Name: ' + Self.PermissionSourceCode + ' ' + Self.GetPermissionNameFromCode(Self.PermissionSourceCode));
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
  Result := False;
end;

function TTable.LogicalInsert(out pID: Integer; pWithBegin, pWithCommit,
  pPermissionControl: Boolean): Boolean;
begin
  Result := False;
end;

function TTable.LogicalSelect(pFilter: string; pLock, pWithBegin,
  pPermissionControl: Boolean): Boolean;
begin
  Result := False;
end;

function TTable.LogicalUpdate(pWithCommit, pPermissionControl: Boolean): Boolean;
begin
  Result := False;
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

procedure TTable.TableAccessDeny(pAction: TTableAction);
var
  vMessage: string;
begin
  vMessage := '';
  if pAction = taSelect then
    vMessage := 'SELECT'
  else if pAction = taInsert then
    vMessage := 'INSERT'
  else if pAction = taUpdate then
    vMessage := 'UPDATE'
  else if pAction = taDelete then
    vMessage := 'DELETE';

  raise Exception.Create(
    'Process ' + vMessage + TSpecialFunctions.AddLineBreak(2) +
    'There is no access to this resource! : ' + Self.TableName + Self.ClassName + sLineBreak +
    'Eksik olan eriþim hakký: ' + Self.PermissionSourceCode);
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
