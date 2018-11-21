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
  System.Variants, Forms, Vcl.Dialogs,
  System.Rtti,
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
    procedure ConnDatabaseErrors(ASender, AInitiator: TObject; var AException: Exception);
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

    function NewQuery(pConnection: TFDConnection = nil): TFDQuery;
    function NewConnection(): TFDConnection;

    function getVarsayilanParaBirimi(): string;
  published
    destructor Destroy();Override;
    function GetToday(OnlyTime: Boolean = True):TDateTime;
    function GetNow():TDateTime;
    procedure runCustomSQL(pSQL: string);
    procedure ConfigureConnection();
  end;

implementation

uses
  Ths.Erp.Functions,
  Ths.Erp.Constants,
  Ths.Erp.Database.Singleton, Ths.Erp.Database.Table.ParaBirimi, Ths.Erp.Database.Table;

{ TDatabase }

procedure TDatabase.ConfigureConnection();
begin
  FConnection.AfterStartTransaction  := ConnAfterStartTransaction;
  FConnection.AfterCommit            := ConnAfterCommit;
  FConnection.AfterRollback          := ConnAfterRollback;
  FConnection.BeforeStartTransaction := ConnBeforeStartTransaction;
  FConnection.BeforeCommit           := ConnBeforeCommit;
  FConnection.BeforeRollback         := ConnBeforeRollback;
  FConnection.OnError                := ConnDatabaseErrors;

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

procedure TDatabase.ConnDatabaseErrors(ASender, AInitiator: TObject; var AException: Exception);
var
  oExc: EFDDBEngineException;

  vTableName, vColumnName, vData, vDataUnique, vTemp: string;
  vStart, vEnd: Integer;
begin
  if AException is EFDDBEngineException then
  begin
    FConnection.Rollback;

    oExc := EFDDBEngineException(AException);

    if oExc.Kind = ekOther then
    begin
      if Pos('could not obtain lock on row in relation', oExc.Message) > 0 then
      begin
        CustomMsgDlg(TranslateText('Kayýt þu anda baþka bir kullanýcý tarafýndan kullanýlýyor. Lütfen daha sonra tekrar deneyin.', FrameworkLang.ErrorDBRecordLocked, LngError, LngSystem),
          mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK,
          TranslateText('Diðer', FrameworkLang.MessageTitleOther, LngMessageTitle, LngSystem));
      end
      else
      begin
        CustomMsgDlg(TranslateText('Diðer', FrameworkLang.ErrorDBOther, LngError, LngSystem),
          mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK,
          TranslateText('Diðer', FrameworkLang.MessageTitleOther, LngMessageTitle, LngSystem));
      end;
    end
    else if oExc.Kind = ekNoDataFound then
    begin
      CustomMsgDlg(TranslateText('Eriþmeye çalýþtýðýnýz bilgi silinmiþ veya deðiþtirilmiþ.', FrameworkLang.ErrorDBNoDataFound, LngError, LngSystem),
        mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK,
        TranslateText('Bilgi bulunamadý', FrameworkLang.MessageTitleNoDataFound, LngMessageTitle, LngSystem));
     end
    else if oExc.Kind = ekTooManyRows then
    begin
      CustomMsgDlg(TranslateText('Çok fazla kayýt geliyor!', FrameworkLang.ErrorDBTooManyRows, LngError, LngSystem),
        mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK,
        TranslateText('Bilgi bulunamadý', FrameworkLang.MessageTitleNoDataFound, LngMessageTitle, LngSystem));
    end
    else if oExc.Kind = ekRecordLocked then
    begin
      CustomMsgDlg(TranslateText('Kayýt þu anda baþka bir kullanýcý tarafýndan kullanýlýyor. Lütfen daha sonra tekrar deneyin.', FrameworkLang.ErrorDBRecordLocked, LngError, LngSystem),
        mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK,
        TranslateText('Diðer', FrameworkLang.MessageTitleOther, LngMessageTitle, LngSystem));
    end
    else if (oExc.Kind = ekUKViolated) then
    begin
      vStart := Pos(')=(', oExc.Message) + Length(')=(');
      vEnd := PosEx(')', oExc.Message, vStart+1);
      if vStart > 0 then
        vDataUnique := '"' + MidStr(oExc.Message, vStart, vEnd-vStart) + '"';

      vTemp := TranslateText('Girdiðiniz deðer var.' + AddLBs + 'Lütfen daha önce girilmemiþ bir deðer girin.' + AddLBs +
        vDataUnique + ' isimli bilgi zaten var.', FrameworkLang.ErrorDBUnique, LngError, LngSystem);
      vTemp := ReplaceMessages(vTemp, ['#par1#'], [vDataUnique]);

      CustomMsgDlg(vTemp, mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK,
        TranslateText('Varolan Kayýt', FrameworkLang.MessageTitleDataAlreadyExists, LngMessageTitle, LngSystem));
    end
    else if oExc.Kind = ekFKViolated then
    begin
      if Pos('update or delete', oExc.Message) > 0 then
      begin
        vStart := Pos('" on table "', oExc.Message) + Length('" on table "');
        vEnd := PosEx('"', oExc.Message, vStart+1);
        if vStart > 0 then
          vTableName := '"' + ReplaceRealColOrTableNameTo(MidStr(oExc.Message, vStart, vEnd-vStart)) + '"';

        vTemp := TranslateText('Bu kayýt silinemez veya güncellenemez.' + AddLBs + vTableName + ' isimli tabloda kullanýlýyor', FrameworkLang.ErrorDBForeignKeyDeleteUpdate, LngError, LngSystem);
        vTemp := ReplaceMessages(vTemp, ['#par1#'], [vTableName]);
        CustomMsgDlg(vTemp,
          mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK,
          TranslateText('Güncelleme/Silme Hatasý', FrameworkLang.MessageTitleUpdateDelete, LngMessageTitle, LngSystem));
      end
      else
      if Pos('is not present in table', oExc.Message) > 0 then
      begin
        vStart := Pos('is not present in table "', oExc.Message) + Length('is not present in table "');
        vEnd := PosEx('".', oExc.Message, vStart+1);
        if vStart > 0 then
          vTableName := '"' + ReplaceRealColOrTableNameTo(MidStr(oExc.Message, vStart, vEnd-vStart)) + '"';

        vStart := Pos('Key (', oExc.Message) + Length('Key (');
        vEnd := PosEx(')=(', oExc.Message, vStart+1);
        if vStart > 0 then
          vColumnName := '"' + ReplaceRealColOrTableNameTo(MidStr(oExc.Message, vStart, vEnd-vStart)) + '"';

        vStart := Pos(')=(', oExc.Message) + Length(')=(');
        vEnd := PosEx(') is not present in table "', oExc.Message, vStart+1);
        if vStart > 0 then
          vData := '"' + MidStr(oExc.Message, vStart, vEnd-vStart) + '"';

        vTemp := TranslateText('Kullanmak istediðiniz ' + vColumnName + '=' + vData + ' bilgisi ' + vTableName + ' tablosunda kayýtlý deðil', FrameworkLang.ErrorDBForeignKeyUnique, LngError, LngSystem);
        vTemp := ReplaceMessages(vTemp, ['#par1#', '#par2#', '#par3#'], [vColumnName, vData, vTableName]);
        CustomMsgDlg(vTemp,
          mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK,
          TranslateText('Ekleme/Güncelleme Hatasý', FrameworkLang.MessageTitleInsertUpdate, LngMessageTitle, LngSystem));
      end;
    end
    else if oExc.Kind = ekObjNotExists then
    begin
      CustomMsgDlg(TranslateText('Kullanýlan Obje mevcut deðil', FrameworkLang.ErrorDBObjectNotExist, LngError, LngSystem),
        mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK,
        TranslateText('Obje Mevcut Deðil', FrameworkLang.MessageTitleObjectNotFound, LngMessageTitle, LngSystem));
    end
    else if oExc.Kind = ekUserPwdInvalid then
    begin

    end
    else if oExc.Kind = ekUserPwdExpired then
    begin
    end
    else if oExc.Kind = ekUserPwdWillExpire then
    begin
    end
    else if oExc.Kind = ekCmdAborted then
    begin
      CustomMsgDlg(TranslateText('Komut iptal edildi', FrameworkLang.ErrorDBCmdAborted, LngError, LngSystem),
        mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK, '');
    end
    else if oExc.Kind = ekServerGone then
    begin
      CustomMsgDlg(TranslateText('Sunucuya ulaþýlamýyor.', FrameworkLang.ErrorDBServerGone, LngError, LngSystem),
        mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK, '');
    end
    else if oExc.Kind = ekServerOutput then
    begin
    end
    else if oExc.Kind = ekArrExecMalfunc then
    begin
    end
    else if oExc.Kind = ekInvalidParams then
    begin
      CustomMsgDlg(TranslateText('Hatalý parametre kullanýmý', FrameworkLang.ErrorDBInvalidParams, LngError, LngSystem),
        mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK, '');
    end
  end;
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

function TDatabase.getVarsayilanParaBirimi: string;
var
  vQuery: TFDQuery;
  vPara: TParaBirimi;
begin
  Result := '';
  vQuery := NewQuery;
  vPara := TParaBirimi.Create(TSingletonDB.GetInstance.DataBase);
  try
    with vQuery do
    begin
      Close;
      SQL.Text :=
        'SELECT ' + vPara.Kod.FieldName + ' ' +
        'FROM ' + vPara.TableName + ' ' +
        'WHERE ' + vPara.IsVarsayilan.FieldName + '=true;';
      Open;
      while NOT EOF do
      begin
        Result := Fields.Fields[0].AsString;
        Next;
      end;
      EmptyDataSet;
      Close;
    end;
  finally
    vQuery.Destroy;
    vPara.Free;
  end;
end;

function TDatabase.NewConnection: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
end;

function TDatabase.NewQuery(pConnection: TFDConnection): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.ResourceOptions.DirectExecute := True;
  Result.FetchOptions.Mode := fmAll;
  Result.FormatOptions.StrsEmpty2Null := True;
  if pConnection = nil then
    Result.Connection := Self.FConnection
  else
    Result.Connection := pConnection;
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

  pQuery.SQL.Text := StringReplace(pQuery.SQL.Text, #$D#$A, '', [rfReplaceAll]);
end;

end.
