unit Ths.Erp.Database;

interface

uses
  System.DateUtils, System.StrUtils, System.Classes, System.SysUtils, System.Variants,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Ths.Erp.Database.Connection;

{$M+}
type
  TPermissionType = (ptRead, ptWrite, ptDelete, ptSpeacial);

type
  TDatabase = class
  private
    FConnection: TConnection;
    FQueryOfDatabase: TFDQuery;

    FHasTransactionBegun: Boolean;
    FNewRecordId: Integer;
  protected
    property QueryOfDataBase: TFDQuery read FQueryOfDatabase;
  public
    constructor Create();
    property Connection: TConnection read FConnection write FConnection;

    property HasTransactionBegun: Boolean read FHasTransactionBegun write FHasTransactionBegun;
    property NewRecordId: Integer read FNewRecordId write FNewRecordId;

    function GetNewRecordId():Integer;
    function GetSQLSelectCmd(pTableName: string; pArrFieldNames: TArray<string>):string;
    function GetSQLInsertCmd(pTableName: string; pParamDelimiter: Char; pArrFieldNames: TArray<string>): TStringList;
    function GetSQLUpdateCmd(pTableName: string; pParamDelimiter: Char; pArrFieldNames: TArray<string>): TStringList;
    procedure SetQueryParamsDefaultValue(pQuery: TFDQuery);

    function SQLQuery(sql_text: string):string;
  published
    destructor Destroy();Override;
    function GetToday(OnlyTime: Boolean = True):TDateTime;
    function GetNow():TDateTime;
    function IsAuthorized(pPermissionSourceCode: string; pPermissionType: TPermissionType; pPermissionControl: Boolean): Boolean;
    function GetMaxChar(pTableName, pColName: string; pDefaultMaxChar: Integer):Integer;
  end;

implementation

uses                           
  Ths.Erp.Database.Table.Users;

{ TDatabase }

constructor TDatabase.Create();
begin
  FConnection := TConnection.Create;
end;

destructor TDatabase.Destroy;
begin
  //
  inherited;
end;

function TDatabase.GetMaxChar(pTableName, pColName: string;
  pDefaultMaxChar: Integer): Integer;
begin
  Result := 0;
  with QueryOfDataBase do
  begin
    Close;
    SQL.Text :=
      'SELECT character_maximum_length FROM view_columns ' +
                ' WHERE table_name=' + QuotedStr(pTableName) + ' AND column_name=' + QuotedStr(pColName);
    Open;
    while NOT EOF do
    begin
      if not Fields.Fields[0].IsNull then
        Result := Fields.Fields[0].AsInteger;
      Next;
    end;
    EmptyDataSet;
    Close;
  end;

  if Result = 0 then
    Result := pDefaultMaxChar;
end;

function TDatabase.GetNewRecordId: Integer;
begin
  Dec(FNewRecordId, 1);
  Result := FNewRecordId;
end;

function TDatabase.GetNow(): TDateTime;
begin
  Result:=0;
  with QueryOfDataBase do
  begin
    Close;
    SQL.Text := 'SELECT NOW();';
    Open;
    while NOT EOF do
    begin
      Result     := Fields.Fields[0].AsDateTime;
      Next;
    end;
    EmptyDataSet;
    Close;
  end;
end;

function TDatabase.GetSQLInsertCmd(pTableName: string; pParamDelimiter: Char;
  pArrFieldNames: TArray<string>): TStringList;
var
  nIndex: Integer;
  sFields, sParams: string;
begin
  Result := TStringList.Create;
  Result.Clear;
  sFields := '';
  sParams := '';

  Result.Add('INSERT INTO ' + pTableName + '(');

  for nIndex := 0 to Length(pArrFieldNames)-1 do
  begin
    if pArrFieldNames[nIndex] <> '' then
    begin
      sFields := sFields + pArrFieldNames[nIndex] + ',';
      sParams := sParams + pParamDelimiter + pArrFieldNames[nIndex] + ',';
    end;

    if (nIndex = Length(pArrFieldNames)-1) and (sFields <> '') then
      sFields := LeftStr(sFields, Length(sFields)-1);

    if (nIndex = Length(pArrFieldNames)-1) and (sParams <> '') then
      sParams := LeftStr(sParams, Length(sParams)-1);
  end;

  Result.Add(sFields);
  Result.Add(') VALUES (');
  Result.Add(sParams);
  Result.Add(') RETURNING id;');

  if (sFields = '') then
    raise Exception.Create('Database fields not found!');
end;

function TDatabase.GetSQLSelectCmd(pTableName: string;
  pArrFieldNames: TArray<string>): string;
var
  nIndex: Integer;
begin
  if Length(pArrFieldNames) =0 then
    raise Exception.Create('Database fields are not defined!' + sLineBreak +
                           'This process cannot be done');

  Result := '';
  for nIndex := 0 to Length(pArrFieldNames)-1 do
  begin
    if pArrFieldNames[nIndex] <> '' then
        Result := Result + pArrFieldNames[nIndex] + ', ';

    //son elemansa virgülü sil
    if (nIndex = Length(pArrFieldNames)-1) and (Result <> '') then
      Result := LeftStr(Result, Length(Result)-2);
  end;

  Result := 'SELECT ' + Result + ' FROM ' + pTableName;
end;

function TDatabase.GetSQLUpdateCmd(pTableName: string; pParamDelimiter: Char;
  pArrFieldNames: TArray<string>): TStringList;
var
  nIndex: Integer;
  sFields: string;
begin
  Result := TStringList.Create;
  Result.Clear;
  sFields := '';

  Result.Add('UPDATE ' + pTableName + ' SET ');

  for nIndex := 0 to Length(pArrFieldNames)-1 do
  begin
    if pArrFieldNames[nIndex] <> '' then
      sFields := sFields + pArrFieldNames[nIndex] + '=' + pParamDelimiter + pArrFieldNames[nIndex] + ',';

    if (nIndex = Length(pArrFieldNames)-1) and (sFields <> '') then
      sFields := LeftStr(sFields, Length(sFields)-1);
  end;

  Result.Add(sFields);

  Result.Add(' WHERE id=:id;');

  if sFields = '' then
    raise Exception.Create('Database fields not found!');
end;

function TDatabase.GetToday(OnlyTime: Boolean = True): TDateTime;
begin
  Result:=0;
  with QueryOfDataBase do
  begin
    Close;
    SQL.Text := 'SELECT CURRENT_DATE;';
    Open;
    while NOT EOF do
    begin
      Result     := Fields.Fields[0].AsDateTime;
      Next;
    end;
    EmptyDataSet;
    Close;
  end;

  if OnlyTime then
    Result := TimeOf(Result);
end;

function TDatabase.IsAuthorized(pPermissionSourceCode: string;
  pPermissionType: TPermissionType; pPermissionControl: Boolean): Boolean;
var
  vFilter: string;
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

    with QueryOfDataBase do
    begin
      Close;
      SQL.Text := GetSQLSelectCmd('sys_user_access_right', [
        'id', 'validity', 'permission_source_code', 'is_read', 'is_write',
        'is_delete', 'is_special', 'user_name']) +
      ' WHERE permission_source_code=' + QuotedStr(pPermissionSourceCode) + ' and user_name ' + vFilter;
      Open;                                                                       
      while NOT EOF do
      begin
        Result     := Fields.Fields[0].AsBoolean;
        Next;
      end;
      EmptyDataSet;
      Close;
    end;
  end  
  else
  begin
    Result := True;
  end;
end;

procedure TDatabase.SetQueryParamsDefaultValue(pQuery: TFDQuery);
var
  nIndex: Integer;
begin
  for nIndex := 0 to pQuery.ParamCount-1 do
  begin
    if (pQuery.Params.Items[nIndex].DataType = ftString)
    or (pQuery.Params.Items[nIndex].DataType = ftMemo)
    or (pQuery.Params.Items[nIndex].DataType = ftWideString)
    or (pQuery.Params.Items[nIndex].DataType = ftWideMemo)
    or (pQuery.Params.Items[nIndex].DataType = ftFixedChar)
    or (pQuery.Params.Items[nIndex].DataType = ftFixedWideChar)
    then
    begin
      if pQuery.Params.Items[nIndex].Value = '' then
        pQuery.Params.Items[nIndex].Value := Null;
    end
    else
    if (pQuery.Params.Items[nIndex].DataType = ftSmallint)
    or (pQuery.Params.Items[nIndex].DataType = ftInteger)
    or (pQuery.Params.Items[nIndex].DataType = ftWord)
    or (pQuery.Params.Items[nIndex].DataType = ftFloat)
    or (pQuery.Params.Items[nIndex].DataType = ftCurrency)
    or (pQuery.Params.Items[nIndex].DataType = ftBCD)
    or (pQuery.Params.Items[nIndex].DataType = ftBytes)
    or (pQuery.Params.Items[nIndex].DataType = ftLargeint)
    or (pQuery.Params.Items[nIndex].DataType = ftLongWord)
    or (pQuery.Params.Items[nIndex].DataType = ftShortint)
    or (pQuery.Params.Items[nIndex].DataType = ftByte)
    then
    begin
      if pQuery.Params.Items[nIndex].Value = 0 then
        pQuery.Params.Items[nIndex].Value := Null;
    end
    else
    if (pQuery.Params.Items[nIndex].DataType = ftDate)
    or (pQuery.Params.Items[nIndex].DataType = ftTime)
    or (pQuery.Params.Items[nIndex].DataType = ftDateTime)
    or (pQuery.Params.Items[nIndex].DataType = ftTimeStamp)
    then
    begin
      if pQuery.Params.Items[nIndex].Value = 0 then
        pQuery.Params.Items[nIndex].Value := Null;
    end;
  end;
end;

function TDatabase.SQLQuery(sql_text: string): string;
begin
  Result := '';
end;

end.
