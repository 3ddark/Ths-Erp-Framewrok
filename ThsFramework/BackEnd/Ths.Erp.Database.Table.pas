unit Ths.Erp.Database.Table;

interface

uses
  Forms, SysUtils, Windows, Classes, Dialogs, Messages, StrUtils,
  System.Variants, Graphics, Controls, StdCtrls, ExtCtrls, ComCtrls,
  System.UITypes, WinSock, System.Rtti,
  FireDAC.Stan.Param, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Error,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Combobox,
  Ths.Erp.Helper.Memo,

  Ths.Erp.Database;

{$M+}
type
  TProductPrice = (ppNone, ppSales, ppBuying, ppRawBuying, ppExport);
  TTableAction = (taSelect, taInsert, taUpdate, taDelete);
  TSequenceStatus = (ssArtis, ssAzalma, ssDegisimYok);

  TTable = class; //for forward declaration
  TFieldDB = class; //for forward declaration

  TForeingKey = class
  private
    FFKTable: TTable;
    FFKCol: TFieldDB;
  public
    constructor Create();
    destructor Destroy; override;
    property FKTable: TTable read FFKTable write FFKTable;
    property FKCol: TFieldDB read FFKCol write FFKCol;
  end;

  TFieldDB = class
  private
    FFieldName: string;
    FFieldType: TFieldType;
    FValue: Variant;
    FSize: Integer;
    FIsPK: Boolean;
    FIsUnique: Boolean;
    FIsNullable: Boolean;
    FIsFK: Boolean;
    FFK: TForeingKey;
  public
    destructor Destroy; override;
    property FieldName: string read FFieldName write FFieldName;
    property FieldType: TFieldType read FFieldType write FFieldType;
    property Value: Variant read FValue write FValue;
    property Size: Integer read FSize write FSize default 0;
    property IsPK: Boolean read FIsPK write FIsPK default False;
    property IsUnique: Boolean read FIsUnique write FIsUnique default False;
    property IsNullable: Boolean read FIsNullable write FIsNullable default True;
    property IsFK: Boolean read FIsFK write FIsFK default False;
    property FK: TForeingKey read FFK write FFK;

    constructor Create(const pFieldName: string; const pFieldType: TFieldType;
      const pValue: Variant; const pMaxLength: Integer=0; const pIsFK: Boolean=False; const pIsNullable: Boolean=True);

    procedure Clone(var pField: TFieldDB);
    procedure SetControlProperty(const pTableName: string; pControl: TWinControl);
  end;

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
    FStoredProc: TFDStoredProc;
    FStoredProcDS: TDataSource;

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
    property StoredProc: TFDStoredProc read FStoredProc write FStoredProc;
    property StoredProcDS: TDataSource read FStoredProcDS;

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
  Ths.Erp.Functions,
  Ths.Erp.Database.Singleton;

constructor TForeingKey.Create;
begin
  inherited;
  FFKTable := nil;
  FFKCol := nil;
end;

destructor TForeingKey.Destroy;
begin
  if Assigned(FFKCol) then
    FFKCol.Free;
  if Assigned(FFKTable) then
    FFKTable.Free;
  inherited;
end;

constructor TFieldDB.Create(const pFieldName: string; const pFieldType: TFieldType;
  const pValue: Variant; const pMaxLength: Integer=0; const pIsFK: Boolean=False; const pIsNullable: Boolean=True);
begin
  FFieldName := pFieldName;
  FFieldType := pFieldType;
  FValue := pValue;
  FSize := pMaxLength;
  FIsPK := False;
  FIsUnique := False;
  FIsFK := pIsFK;
  FIsNullable := pIsNullable;
  if FIsFK then
    FFK := TForeingKey.Create;
end;

destructor TFieldDB.Destroy;
begin
  if Assigned(FFK) then
    FFK.Free;
  inherited;
end;

procedure TFieldDB.Clone(var pField: TFieldDB);
begin
  pField.FFieldName := Self.FFieldName;
  pField.FieldType := Self.FieldType;
  pField.FValue := Self.FValue;
  pField.FSize := Self.FSize;
  pField.FIsPK := Self.FIsPK;
  pField.FIsUnique := Self.FIsUnique;
  pField.FIsFK := Self.FIsFK;
  pField.FIsNullable := Self.FIsNullable;
  if pField.FIsFK then
  begin
    if Assigned(pField.FK) then
      pField.FK.Free;
    pField.FK := TForeingKey.Create;
    //önce create ediyoruz sonra bilgileri clone ile alýyoruz
    pField.FK.FFKCol := TFieldDB.Create('', ftString, '');
    Self.FK.FFKCol.Clone(pField.FK.FFKCol);

    pField.FK.FFKTable := Self.FK.FFKTable.Clone;
    pField.FK.FKTable.SelectToList(' AND ' + pField.FK.FKTable.TableName + '.' + pField.FK.FKTable.Id.FieldName + '=' + VarToStr(pField.Value), False, False);
  end;
end;

procedure TFieldDB.SetControlProperty(const pTableName: string; pControl: TWinControl);
var
  vAktifDonem: Integer;
  vFieldType: TFieldType;
begin
  vAktifDonem := FormatedVariantVal(TSingletonDB.GetInstance.ApplicationSetting.Donem.FieldType, TSingletonDB.GetInstance.ApplicationSetting.Donem.Value);
  if pControl.ClassType = TEdit then
  begin
    with pControl as TEdit do
    begin
      Clear;
      thsActiveYear := vAktifDonem;
      thsCaseUpLowSupportTr := True;
      CharCase := ecUpperCase;
      thsRequiredData := TSingletonDB.GetInstance.GetIsRequired(pTableName, Self.FFieldName);
      thsDBFieldName := Self.FFieldName;
      vFieldType := Self.FFieldType;

      if Self.IsFK then
      begin
        if Assigned(Self.FK.FFKTable) and Assigned(Self.FK.FFKCol) then
          MaxLength := TSingletonDB.GetInstance.GetMaxLength(Self.FK.FFKTable.TableName, Self.FK.FFKCol.FFieldName)
        else
          raise Exception.Create('Foreing Key özelliði aktif edilmiþ. Fakat FKTable/FKCol tanýmlanmamýþ.');
      end
      else
        MaxLength := TSingletonDB.GetInstance.GetMaxLength(pTableName, Self.FFieldName);

      if vFieldType = ftString then
        thsInputDataType := itString
      else
      if (vFieldType = ftInteger)
      or (vFieldType = ftSmallint)
      or (vFieldType = ftShortint)
      or (vFieldType = ftLargeint)
      or (vFieldType = ftWord)
      then
        thsInputDataType := itInteger
      else
      if (vFieldType = ftFloat) then
        thsInputDataType := itFloat
      else
      if (vFieldType = ftCurrency) then
        thsInputDataType := itMoney
      else
      if (vFieldType = ftDate)
      or (vFieldType = ftDateTime)
      then
        thsInputDataType := itDate;
    end;
  end
  else
  if pControl.ClassType = TCombobox then
  begin
    with pControl as TCombobox do
    begin
      Clear;
      thsActiveYear := vAktifDonem;
      thsCaseUpLowSupportTr := True;
      CharCase := ecUpperCase;

      if Self.IsFK then
      begin
        if Assigned(Self.FK.FFKTable) and Assigned(Self.FK.FFKCol) then
        begin
          thsDBFieldName := Self.FK.FFKCol.FFieldName;
          thsRequiredData := TSingletonDB.GetInstance.GetIsRequired(Self.FK.FFKTable.TableName, Self.FK.FFKCol.FFieldName);
          MaxLength := TSingletonDB.GetInstance.GetMaxLength(Self.FK.FFKTable.TableName, Self.FK.FFKCol.FFieldName);
          vFieldType := Self.FK.FFKCol.FFieldType;
        end
        else
          raise Exception.Create('Foreing Key özelliði aktif edilmiþ. Fakat FKTable/FKCol tanýmlanmamýþ.');
      end
      else
      begin
        thsDBFieldName := Self.FFieldName;
        thsRequiredData := TSingletonDB.GetInstance.GetIsRequired(pTableName, Self.FFieldName);
        MaxLength := TSingletonDB.GetInstance.GetMaxLength(pTableName, Self.FFieldName);
        vFieldType := Self.FFieldType;
      end;

      if vFieldType = ftString then
        thsInputDataType := itString
      else
      if (vFieldType = ftInteger)
      or (vFieldType = ftSmallint)
      or (vFieldType = ftShortint)
      or (vFieldType = ftLargeint)
      or (vFieldType = ftWord)
      then
        thsInputDataType := itInteger
      else
      if (vFieldType = ftFloat) then
        thsInputDataType := itFloat
      else
      if (vFieldType = ftCurrency) then
        thsInputDataType := itMoney
      else
      if (vFieldType = ftDate)
      or (vFieldType = ftDateTime)
      then
        thsInputDataType := itDate;
    end;
  end
  else
  if pControl.ClassType = TMemo then
  begin
    with pControl as TMemo do
    begin
      Clear;
      thsActiveYear := vAktifDonem;
      thsCaseUpLowSupportTr := True;
      CharCase := ecUpperCase;

      if Self.IsFK then
      begin
        if Assigned(Self.FK.FFKTable) and Assigned(Self.FK.FFKCol) then
        begin
          thsDBFieldName := Self.FK.FFKCol.FFieldName;
          thsRequiredData := TSingletonDB.GetInstance.GetIsRequired(Self.FK.FFKTable.TableName, Self.FK.FFKCol.FFieldName);
          MaxLength := TSingletonDB.GetInstance.GetMaxLength(Self.FK.FFKTable.TableName, Self.FK.FFKCol.FFieldName);
          vFieldType := Self.FK.FFKCol.FFieldType;
        end
        else
          raise Exception.Create('Foreing Key özelliði aktif edilmiþ. Fakat FKTable/FKCol tanýmlanmamýþ.');
      end
      else
      begin
        thsDBFieldName := Self.FFieldName;
        thsRequiredData := TSingletonDB.GetInstance.GetIsRequired(pTableName, Self.FFieldName);
        MaxLength := TSingletonDB.GetInstance.GetMaxLength(pTableName, Self.FFieldName);
        vFieldType := Self.FFieldType;
      end;

      if vFieldType = ftString then
        thsInputDataType := itString
      else
      if (vFieldType = ftInteger)
      or (vFieldType = ftSmallint)
      or (vFieldType = ftShortint)
      or (vFieldType = ftLargeint)
      or (vFieldType = ftWord)
      then
        thsInputDataType := itInteger
      else
      if (vFieldType = ftFloat) then
        thsInputDataType := itFloat
      else
      if (vFieldType = ftCurrency) then
        thsInputDataType := itMoney
      else
      if (vFieldType = ftDate)
      or (vFieldType = ftDateTime)
      then
        thsInputDataType := itDate;
    end;
  end;
end;

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
var
  ctx: TRttiContext;
  typ: TRttiType;
  fld: TRttiField;
  AValue: TValue;
  AObject: TObject;
begin
//  Id.Value := 0;
  typ := ctx.GetType(Self.ClassType);
  if Assigned(typ) then
    for fld in typ.GetFields do
      if Assigned(fld) then
        if fld.FieldType is TRttiInstanceType then
        begin
          //TFieldDB olup olmadýðýný burada kontrol edebileceðimiz gibi aþaðýda da kontrol edebilirdik.
          if TRttiInstanceType(fld.FieldType).MetaclassType.InheritsFrom(TFieldDB) then
          begin
            AValue := fld.GetValue(Self);
            AObject := nil;
            if not AValue.IsEmpty then
              AObject := AValue.AsObject;

            if Assigned(AObject) then
              if AObject.InheritsFrom(TFieldDB) then  //TFieldDB olup olmadýðýný burada da kontrol edebiliriz.
              begin
                if (TFieldDB(AObject).FieldType = ftString)
                or (TFieldDB(AObject).FieldType = ftWideString)
                or (TFieldDB(AObject).FieldType = ftMemo)
                or (TFieldDB(AObject).FieldType = ftWideMemo)
                or (TFieldDB(AObject).FieldType = ftBytes)
                or (TFieldDB(AObject).FieldType = ftFmtMemo)
                or (TFieldDB(AObject).FieldType = ftFixedChar)
                or (TFieldDB(AObject).FieldType = ftFixedWideChar)
                then
                  TFieldDB(AObject).Value := ''
                else
                if (TFieldDB(AObject).FieldType = ftSmallint)
                or (TFieldDB(AObject).FieldType = ftInteger)
                or (TFieldDB(AObject).FieldType = ftWord)
                or (TFieldDB(AObject).FieldType = ftFloat)
                or (TFieldDB(AObject).FieldType = ftCurrency)
                or (TFieldDB(AObject).FieldType = ftBCD)
                or (TFieldDB(AObject).FieldType = ftDate)
                or (TFieldDB(AObject).FieldType = ftTime)
                or (TFieldDB(AObject).FieldType = ftDateTime)
                or (TFieldDB(AObject).FieldType = ftBytes)
                or (TFieldDB(AObject).FieldType = ftVarBytes)
                or (TFieldDB(AObject).FieldType = ftAutoInc)
                or (TFieldDB(AObject).FieldType = ftLargeint)
                or (TFieldDB(AObject).FieldType = ftTimeStamp)
                or (TFieldDB(AObject).FieldType = ftShortint)
                or (TFieldDB(AObject).FieldType = ftByte)
                then
                  TFieldDB(AObject).Value := 0
                else
                if (TFieldDB(AObject).FieldType = ftBoolean) then
                  TFieldDB(AObject).Value := False
                else
                if (TFieldDB(AObject).FieldType = ftBlob) then
                  TFieldDB(AObject).Value := Null;
              end;
          end;
        end;
end;

function TTable.Clone: TTable;
//var
//  ctx: TRttiContext;
//  typ: TRttiType;
//  fld: TRttiField;
//  prp: TRttiProperty;
//  AValue: TValue;
//  AObject: TObject;
begin
  Result := nil;
//  Result := TObjectClone.From(Self);

//  typ := ctx.GetType(Self.ClassType);
//  if Assigned(typ) then
//    for prp in typ.GetProperties do
//      if Assigned(prp) then
//        if prp.PropertyType is TRttiInstanceType then
//        begin
//          //TFieldDB olup olmadýðýný burada kontrol edebileceðimiz gibi aþaðýda da kontrol edebilirdik.
//          if TRttiInstanceType(prp.PropertyType).MetaclassType.InheritsFrom(TFieldDB) then
//          begin
//            AValue := prp.GetValue(Self);
//            AObject := nil;
//            if not AValue.IsEmpty then
//              AObject := AValue.AsObject;
//
//            if Assigned(AObject) then
//              if AObject.InheritsFrom(TTable) then  //TFieldDB olup olmadýðýný burada da kontrol edebiliriz.
//                TFieldDB(AObject).Value := '';
//          end;
//        end;
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

  FStoredProc := FDatabase.NewStoredProcedure;
  FStoredProcDS := FDatabase.NewDataSource(FStoredProc);
  FDataSource := FDatabase.NewDataSource(FQueryOfDS);

  Id := TFieldDB.Create('id', ftInteger, 0, 0, False, False);
  Id.IsPK := True;
  Id.IsUnique := True;
  Id.Value := FDatabase.GetNewRecordId();
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
//    vRtf := vRtt.GetField('FAdres');
    //ana sýnýfa ait bütün alanlarý free yapýyor
    if (vRtf.FieldType.Name = TFieldDB.ClassName) then
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
    end
    else
    begin
      if Assigned(vRtf.FieldType.BaseType) then
      begin
        //ana sýnýf içinde kullan diðer tablo sýnýflarýný free ediyor.
        //örnek THesapKartý içinde kullanýlan TAdres sýnýfýný burada free yapýyor
        if (vRtf.FieldType.BaseType.Name = TTable.ClassName) then
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

  FStoredProcDS.Free;
  FStoredProc.Free;

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
