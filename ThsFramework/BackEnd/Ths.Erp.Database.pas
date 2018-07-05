unit Ths.Erp.Database;

interface
{
do$$
begin
--ilk bilgi notify name ikinci bilgi ise notify degeri
--delphi tarafýnda notify name bilgisini fdeventalerter içinde names kýsmýna dolduruyoruz.
--örnek aþaðýdaki notify çalýþtýrýlýnca firedac tarafýnda bildirim oluþuyor.
  perform pg_notify('stok', 'ferhat');
end$$;

procedure TForm1.FDEventAlerter1Alert(ASender: TFDCustomEventAlerter;
  const AEventName: string; const AArgument: Variant);
var
  sMesaj: string;
  n1: Integer;
begin
  ShowMessage(AEventName);
  if VarIsArray( AArgument ) then
    for n1 := VarArrayLowBound(AArgument, 1) to VarArrayHighBound(AArgument, 1) do
      if n1 = 0 then
        sMesaj := sMesaj + 'Process ID (pID):' + VarToStr(AArgument[n1]) + ', '
      else if n1 = 1 then
        sMesaj := sMesaj + 'Notify Value:' + VarToStr(AArgument[n1]) + ', ';
  Memo1.Lines.Add( sMesaj )
end;

SELECT --i.ipaddr,
a.client_addr, a.*
FROM pg_stat_activity AS a
WHERE procpid = (SELECT pg_backend_pid())
}

uses
  System.DateUtils, System.StrUtils, System.Classes, System.SysUtils,
  System.Variants, Forms,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Ths.Erp.Database.Connection.Settings;

{$M+}
type
  TPermissionType = (ptRead, ptAddRecord, ptUpdate, ptDelete, ptSpeacial);

type
  TDatabase = class
  private
    FConnection: TFDConnection;
    FConnSetting: TConnSettings;
    FQueryOfDatabase: TFDQuery;

    FTranscationIsStarted: Boolean;
    FNewRecordId: Integer;
  protected
    property QueryOfDataBase: TFDQuery read FQueryOfDatabase;

    procedure ConnAfterCommit(Sender: TObject);
    procedure ConnAfterRollback(Sender: TObject);
    procedure ConnAfterStartTransaction(Sender: TObject);
    procedure ConnBeforeCommit(Sender: TObject);
    procedure ConnBeforeRollback(Sender: TObject);
    procedure ConnBeforeStartTransaction(Sender: TObject);
  public
    property Connection: TFDConnection read FConnection write FConnection;
    property TranscationIsStarted: Boolean read FTranscationIsStarted write FTranscationIsStarted;
    property NewRecordId: Integer read FNewRecordId write FNewRecordId;
    property ConnSetting: TConnSettings read FConnSetting write FConnSetting;

    constructor Create;
    function GetNewRecordId():Integer;

    //get easy SELECT ... FROM ... sql code
    function GetSQLSelectCmd(pTableName: string; pArrFieldNames: TArray<string>):string;
    //get easy INSERT INTO .. (...) VALUES(...) RETURNIN ID
    function GetSQLInsertCmd(pTableName: string; pParamDelimiter: Char; pArrFieldNames: TArray<string>): string;
    //get easy UPDATE .. SET ..... WHERE id=...
    function GetSQLUpdateCmd(pTableName: string; pParamDelimiter: Char; pArrFieldNames: TArray<string>): string;
    //if don't want 0, '' value call this routine (string '' = null) (integer or double 0 = null)
    procedure SetQueryParamsDefaultValue(pQuery: TFDQuery; pInput: Boolean = True);

    function NewQuery(): TFDQuery;
  published
    destructor Destroy();Override;
    function GetToday(OnlyTime: Boolean = True):TDateTime;
    function GetNow():TDateTime;
    procedure runCustomSQL(pSQL: string);
    procedure ConfigureConnection();
  end;

implementation

uses
  Ths.Erp.Database.Singleton;

{ TDatabase }

procedure TDatabase.ConfigureConnection();
begin
  FConnection.AfterStartTransaction  := ConnAfterStartTransaction;
  FConnection.AfterCommit            := ConnAfterCommit;
  FConnection.AfterRollback          := ConnAfterRollback;
  FConnection.BeforeStartTransaction := ConnBeforeStartTransaction;
  FConnection.BeforeCommit           := ConnBeforeCommit;
  FConnection.BeforeRollback         := ConnBeforeRollback;


  if FConnection.Connected then
    FConnection.Close;

  FConnection.Name := 'Connection';

  FConnection.Params.Clear;

  FConnection.Params.Add('DriverID=PG');
  FConnection.Params.Add('CharacterSet=UTF8');
  FConnection.Params.Add('Server=' + FConnSetting.SQLServer);
  FConnection.Params.Add('Database=' + FConnSetting.DatabaseName);
  FConnection.Params.Add('User_Name=' + 'ths_admin');
  FConnection.Params.Add('Password=' + 'THSERP');
  FConnection.Params.Add('Port=' + FConnSetting.DBPortNo.ToString);
  FConnection.Params.Add('ApplicationName=' + 'THS ERP Framework');
  FConnection.LoginPrompt := False;
end;

procedure TDatabase.ConnAfterCommit(Sender: TObject);
begin
  TranscationIsStarted := False;
end;

procedure TDatabase.ConnAfterRollback(Sender: TObject);
begin
  TranscationIsStarted := False;
end;

procedure TDatabase.ConnAfterStartTransaction(Sender: TObject);
begin
//
end;

procedure TDatabase.ConnBeforeCommit(Sender: TObject);
begin
//
end;

procedure TDatabase.ConnBeforeRollback(Sender: TObject);
begin
//
end;

procedure TDatabase.ConnBeforeStartTransaction(Sender: TObject);
begin
  TranscationIsStarted := True;
end;

constructor TDatabase.Create();
begin
  if Self.FConnection <> nil then
    Abort
  else
  begin
    inherited;
    Self.FConnection := TFDConnection.Create(nil);

    Self.FQueryOfDatabase := NewQuery;

    Self.ConnSetting := TConnSettings.Create;
    Self.ConnSetting.ReadFromFile;
    TranscationIsStarted := False;
  end;
end;

destructor TDatabase.Destroy;
begin
  FreeAndNil(FConnSetting);
  FreeAndNil(FQueryOfDatabase);
  FreeAndNil(FConnection);
  inherited;
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
  pArrFieldNames: TArray<string>): string;
var
  nIndex: Integer;
  sFields, sParams: string;
  vSQL: TStringList;
begin
  vSQL := TStringList.Create;
  Result := '';
  try
    sFields := '';
    sParams := '';

    vSQL.Add('INSERT INTO ' + pTableName + '(');

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

    vSQL.Add(sFields);
    vSQL.Add(') VALUES (');
    vSQL.Add(sParams);
    vSQL.Add(') RETURNING id;');

    if (sFields = '') then
      raise Exception.Create('Database fields not found!');
  finally
    Result := vSQL.Text;
    vSQL.Free;
  end;
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

  Result := 'SELECT ' + Result + ' FROM ' + pTableName + ' ';
end;

function TDatabase.GetSQLUpdateCmd(pTableName: string; pParamDelimiter: Char;
  pArrFieldNames: TArray<string>): string;
var
  nIndex: Integer;
  sFields: string;
  vSQL: TStringList;
begin
  vSQL := TStringList.Create;
  Result := '';
  try
    sFields := '';

    vSQL.Add('UPDATE ' + pTableName + ' SET ');

    for nIndex := 0 to Length(pArrFieldNames)-1 do
    begin
      if pArrFieldNames[nIndex] <> '' then
        sFields := sFields + pArrFieldNames[nIndex] + '=' + pParamDelimiter +
            RightStr(pArrFieldNames[nIndex], Length(pArrFieldNames[nIndex])- Pos('.', pArrFieldNames[nIndex])) + ', ';

      if (nIndex = Length(pArrFieldNames)-1) and (sFields <> '') then
        sFields := LeftStr(sFields, Length(sFields)-2);
    end;

    if sFields = '' then
      raise Exception.Create('Database fields not found!');

    vSQL.Add(sFields);

    vSQL.Add(' WHERE id=:id;');
  finally
    Result := vSQL.Text;
    vSQL.Free;
  end;
end;

function TDatabase.GetToday(OnlyTime: Boolean = True): TDateTime;
begin
  Result := 0;
  with QueryOfDataBase do
  begin
    Close;
    SQL.Text := 'SELECT CURRENT_DATE;';
    Open;
    while NOT EOF do
    begin
      Result := Fields.Fields[0].AsDateTime;
      Next;
    end;
    EmptyDataSet;
    Close;
  end;

  if OnlyTime then
    Result := TimeOf(Result);
end;

function TDatabase.NewQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.ResourceOptions.DirectExecute := True;
  Result.Connection := Self.FConnection;
end;

procedure TDatabase.runCustomSQL(pSQL: string);
begin
  if pSQL <> '' then
  begin
    with QueryOfDataBase do
    begin
      Close;
      SQL.Text := pSQL;
      ExecSQL;

      SQL.Clear;
      Close;
    end;
  end;
end;

procedure TDatabase.SetQueryParamsDefaultValue(pQuery: TFDQuery; pInput: Boolean = True);
var
  nIndex: Integer;
begin
  for nIndex := 0 to pQuery.ParamCount-1 do
  begin
    pQuery.Params.Items[nIndex].ParamType := ptInput;

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

end.
