unit Ths.Erp.Database.Singleton;

interface

{$I ThsERP.inc}

uses
  System.IniFiles, System.SysUtils, System.Classes, System.StrUtils,
  System.Math, System.Variants,
  Winapi.Windows, Winapi.Messages,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ImgList,
  Vcl.Imaging.PngImage, Vcl.DBGrids,
  Data.DB, FireDAC.Stan.Param, FireDAC.Comp.Client

  , Ths.Erp.Helper.Edit
  , Ths.Erp.Database
  , Ths.Erp.Database.Table
  , Ths.Erp.Database.Table.SysUser
  , Ths.Erp.Database.Table.SysLang
  , Ths.Erp.Database.Table.AyarHaneSayisi
  , Ths.Erp.Database.Table.SysApplicationSettings
  , Ths.Erp.Database.Table.SysApplicationSettingsOther;

type
  TSingletonDB = class(TObject)
  strict private
    class var FInstance: TSingletonDB;
    constructor CreatePrivate;
  private
    FDataBase: TDatabase;
    FUser: TSysUser;
    FHaneMiktari: TAyarHaneSayisi;
    FApplicationSettings: TSysApplicationSettings;
    FApplicationSettingsOther: TSysApplicationSettingsOther;
    FSysLang: TSysLang;
    FImageList32: TImageList;
    FImageList16: TImageList;
  public
/// <summary>
///  Database sýnýfýna ulaþýlýyor. Bazý fonksiyonlar burada GetToday GetNow veya runCustomSQL gibi
/// </summary>
    property DataBase: TDatabase read FDataBase write FDataBase;

/// <summary>
///  Giriþ yapan kullanýcý bilgilerine bu tablo bilgisinden ulaþalýyor.
///  <example>
///   <code lang="Delphi">TSingletonDB.GetInstance.User.UserName.Value</code>
///  </example>
/// </summary>
    property User: TSysUser read FUser write FUser;

/// <summary>
///  Virgüllü sayýlarda hane sayýsý deðerlerine buradan ulaþýlýyor. Bu ayara göre iþlemler yapýlacak.
///  <example>
///   <code lang="Delphi">TSingletonDB.GetInstance.HaneMiktari.SatisMiktar.Value</code>
///  </example>
/// </summary>
    property HaneMiktari: TAyarHaneSayisi read FHaneMiktari write FHaneMiktari;

/// <summary>
///  Uygulama ayarlarýna bu tablo bilgisinden ulaþýlýyor.
///  <example>
///   <code lang="Delphi">TSingletonDB.GetInstance.ApplicationSetting.Unvan.Value</code>
///  </example>
/// </summary>
    property ApplicationSettings: TSysApplicationSettings read FApplicationSettings write FApplicationSettings;

/// <summary>
///  Uygulamanýn özel ayarlarýna bu tablo bilgisinden ulaþýlýyor.
///  <example>
///   <code lang="Delphi">TSingletonDB.GetInstance.ApplicationSettingsOther.xxx.Value</code>
///  </example>
/// </summary>
    property ApplicationSettingsOther: TSysApplicationSettingsOther read FApplicationSettingsOther write FApplicationSettingsOther;

/// <summary>
///  Uygulama açýlýrken hangi dil ile açýþmýþsa o dilin bilgileri alýnýyor.
///  <example>
///   <code lang="Delphi">TSingletonDB.GetInstance.SysLang.Langeuage.Valye</code>
///  </example>
/// </summary>
    property SysLang: TSysLang read FSysLang write FSysLang;

/// <summary>
///  32x32 px boyutunda kullanýlan resimleri saklamak için kullanýlýyor. Genelde butonlarda kullanýlýyor.
/// </summary>
    property ImageList32: TImageList read FImageList32 write FImageList32;

/// <summary>
///  16x16 px boyutunda kullanýlan resimleri saklamak için kullanýlýyor. Genelde menülerde kullanýlýyor.
/// </summary>
    property ImageList16: TImageList read FImageList16 write FImageList16;

    constructor Create;
    class function GetInstance(): TSingletonDB;

    destructor Destroy; override;

    function GetGridDefaultOrderFilter(pKey: string; pIsOrder: Boolean): string;
    function GetIsRequired(pTableName, pFieldName: string): Boolean;
    function GetMaxLength(pTableName, pFieldName: string): Integer;
    function GetQualityFormNo(pTableName: string; pIsInput: Boolean): string;

    procedure FillColNameForColWidth(pComboBox: TComboBox; pTableName: string);
    function GetDistinctColumnName(pTableName: string): TStringList;

    function AddImalgeToImageList(pFileName: string; pList: TImageList; out pImageIndex: Integer): Boolean;

    function FillComboFromLangData(pComboBox: TComboBox; pBaseTableName, pBaseColName: string; pRowID: Integer): string;
  end;

  function ColumnFromIDCol(pRawTableColName, pRawTableName, pDataColName,
      pVirtualColName, pDataTableName: string; pIsIDReference: Boolean = True; pIsNumericVal: Boolean = False): string;
  function TranslateText(pDefault, pCode, pTip: string; pTable: string=''): string;

  function FormatedVariantVal(pType: TFieldType; pVal: Variant): Variant; overload;
  function FormatedVariantVal(pField: TFieldDB): Variant; overload;

  function Login(pUserName,pPassword: string): Integer;
  function ReplaceToRealColOrTableName(const pTableName: string): string;
  function ReplaceRealColOrTableNameTo(const pTableName: string): string;
  function getFormCaptionByLang(pFormName, pDefaultVal: string): string;

  /// <summary>
  ///   Parametre girilen Tablo adý ve Tablodaki Column Name bilgisine göre
  ///  sys_lang_data tablosundan programýn açýlan dil ayarýna göre column
  ///  bilgsini döndürüyor. Bunu fonksiyon tek baþýna kullanýlamaz.
  ///  Bu fonksiyon SELECT kodlarý içinde kullanýlýr.
  ///  <param name="pBaseTableName">Database Table Name</param>
  ///  <param name="pBaseColName">Database Table Column Name</param>
  ///  <example>
  ///   <code lang="Delphi">getRawDataByLang(TableName, FBirim.FieldName)</code>
  ///  </example>
  /// </summary>
  function getRawDataByLang(pBaseTableName, pBaseColName: string): string;

  /// <summary>
  ///  Ýstenilen Query ye Parametre eklemek için kullanýlýyor. Insert ve Update kodlarý içinde kullanýlýyor.
  ///  <param name="pQuery">FireDac Query</param>
  ///  <param name="pField">FieldDB tipindeki Field</param>
  ///  <example>
  ///   <code lang="Delphi">NewParamForQuery(QueryOfInsert, FBirim)</code>
  ///  </example>
  /// </summary>
  procedure NewParamForQuery(pQuery: TFDQuery; pField: TFieldDB);

  /// <summary>
  ///  Bu fonksiyon DBGrid üzerinde gösterilen sütunlarýn geniþlik deðerini deðiþtirmek için kullanýlýr.
  ///  Yaptýðý iþ hýzlýca <b>sys_grid_col_width</b> tablosundaki <b>column_width</b>
  ///  deðerini hýzlýca güncellemek için kullanýlýr. Açýk DBGrid(output form)
  ///  ekranýndaki sütun geniþliðinin hýzlýca görselden ayarlamak için bu fonksiyon yazildi.
  ///  <param name="pTableName">Database Table Name</param>
  ///  <param name="pColName">Database Table Column Name</param>
  ///  <param name="pColWidth">DBGrid Column Width</param>
  ///  <example>
  ///   <code lang="Delphi">UpdateColWidth(olcu_birimi, birim, 100)</code>
  ///  </example>
  /// </summary>
  function UpdateColWidth(pTableName: string; pGrid: TDBGrid): Boolean;
var
  SingletonDB: TSingletonDB;
  vLangContent, vLangContent2: string;

implementation

uses
    Ths.Erp.Database.Table.View.SysViewColumns
  , Ths.Erp.Database.Table.SysGridDefaultOrderFilter
  , Ths.Erp.Constants
  , Ths.Erp.Database.Table.SysGridColWidth
  , Ths.Erp.Database.Table.SysQualityFormNumber
  , Ths.Erp.Functions
  ;

function FormatedVariantVal(pType: TFieldType; pVal: Variant): Variant;
var
  vValueInt: Integer;
  vValueDouble: Double;
  vValueBool: Boolean;
  vValueDateTime: TDateTime;
begin
  if (pType = ftString)
  or (pType = ftMemo)
  or (pType = ftWideString)
  or (pType = ftWideMemo)
  or (pType = ftWideString)
  then
    Result := IfThen(not VarIsNull(pVal), VarToStr(pVal), '')
  else
  if (pType = ftSmallint)
  or (pType = ftShortint)
  or (pType = ftInteger)
  or (pType = ftLargeint)
  or (pType = ftWord)
  then
  begin
    if not VarIsNull(pVal) then
      Result := IfThen(TryStrToInt(pVal, vValueInt), VarToStr(pVal).ToInteger, 0)
    else
      Result := 0;
  end
  else if (pType = ftDate) then
  begin
    if not VarIsNull(pVal) then
    begin
      if TryStrToDate(pVal, vValueDateTime) then
        Result := DateToStr(VarToDateTime(pVal))
      else
        Result := 0;
    end
    else
      Result := 0;
  end
  else if (pType = ftDateTime) then
  begin
    if not VarIsNull(pVal) then
    begin
      if TryStrToDateTime(pVal, vValueDateTime) then
        Result := DateTimeToStr(VarToDateTime(pVal))
      else
        Result := 0;
    end
    else
      Result := 0;
  end
  else if (pType = ftTime) then
  begin
    if not VarIsNull(pVal) then
    begin
      if TryStrToTime(pVal, vValueDateTime) then
        Result := TimeToStr(VarToDateTime(pVal))
      else
        Result := 0;
    end
    else
      Result := 0;
  end
  else if (pType = ftTimeStamp) then
  begin
    if not VarIsNull(pVal) then
    begin
      if TryStrToTime(pVal, vValueDateTime) then
        Result := DateTimeToStr(VarToDateTime(pVal))
      else
        Result := 0;
    end
    else
      Result := 0;
  end
  else
  if (pType = ftFloat)
  or (pType = ftCurrency)
  or (pType = ftSingle)
  or (pType = ftBCD)
  or (pType = ftFMTBcd)
  then
  begin
    if not VarIsNull(pVal) then
      Result := IfThen(TryStrToFloat(pVal, vValueDouble), VarToStr(pVal).ToDouble, 0.0)
    else
      Result := 0.0;
  end
  else if (pType = ftBoolean) then
  begin
    if not VarIsNull(pVal) then
    begin
      if TryStrToBool(pVal, vValueBool) then
        Result := VarToStr(pVal).ToBoolean
      else
        Result := False;
    end
    else
      Result := False;
  end
  else if (pType = ftBlob) then
    Result := pVal
  else
    Result := pVal;
end;

function FormatedVariantVal(pField: TFieldDB): Variant;
var
  vValueInt: Integer;
  vValueDouble: Double;
  vValueBool: Boolean;
  vValueDateTime: TDateTime;
begin
  if (pField.FieldType = ftString)
  or (pField.FieldType = ftMemo)
  or (pField.FieldType = ftWideString)
  or (pField.FieldType = ftWideMemo)
  or (pField.FieldType = ftWideString)
  then
    Result := IfThen(not VarIsNull(pField.Value), VarToStr(pField.Value), '')
  else
  if (pField.FieldType = ftSmallint)
  or (pField.FieldType = ftShortint)
  or (pField.FieldType = ftInteger)
  or (pField.FieldType = ftLargeint)
  or (pField.FieldType = ftWord)
  then
  begin
    if not VarIsNull(pField.Value) then
      Result := IfThen(TryStrToInt(pField.Value, vValueInt), VarToStr(pField.Value).ToInteger, 0)
    else
      Result := 0;
  end
  else if (pField.FieldType = ftDate) then
  begin
    if not VarIsNull(pField.Value) then
      Result := IfThen(TryStrToDate(pField.Value, vValueDateTime), StrToDate(VarToStr(pField.Value)), 0)
    else
      Result := 0;
  end
  else if (pField.FieldType = ftDateTime) then
  begin
    if not VarIsNull(pField.Value) then
      Result := IfThen(TryStrToDateTime(pField.Value, vValueDateTime), StrToDateTime(VarToStr(pField.Value)), 0)
    else
      Result := 0;
  end
  else
  if (pField.FieldType = ftTime)
  or (pField.FieldType = ftTimeStamp)
  then
  begin
    if not VarIsNull(pField.Value) then
      Result := IfThen(TryStrToTime(pField.Value, vValueDateTime), StrToTime(VarToStr(pField.Value)), 0)
    else
      Result := 0;
  end
  else
  if (pField.FieldType = ftFloat)
  or (pField.FieldType = ftCurrency)
  or (pField.FieldType = ftSingle)
  or (pField.FieldType = ftBCD)
  or (pField.FieldType = ftFMTBcd)
  then
  begin
    if not VarIsNull(pField.Value) then
      Result := IfThen(TryStrToFloat(pField.Value, vValueDouble), VarToStr(pField.Value).ToDouble, 0.0)
    else
      Result := 0.0;
  end
  else if (pField.FieldType = ftBoolean) then
  begin
    if not VarIsNull(pField.Value) then
    begin
      if TryStrToBool(pField.Value, vValueBool) then
        Result := VarToStr(pField.Value).ToBoolean
      else
        Result := False;
    end
    else
      Result := False;
  end
  else if (pField.FieldType = ftBlob) then
    Result := pField.Value
  else
    Result := pField.Value;
end;

function ColumnFromIDCol(pRawTableColName, pRawTableName, pDataColName,
    pVirtualColName, pDataTableName: string; pIsIDReference: Boolean = True;
    pIsNumericVal: Boolean = False): string;
var
  vSP: TFDStoredProc;
  vRefColName: string;
begin
  if pIsIDReference then
    vRefColName := 'id'
  else
    vRefColName := pRawTableColName;

  if pIsNumericVal then
    Result := '(SELECT raw' + pRawTableName + '.' + pRawTableColName + ' FROM ' + pRawTableName + ' as raw' + pRawTableName +
              ' WHERE raw' + pRawTableName + '.' + vRefColName + '=' + pDataTableName + '.' + pDataColName + ') as ' + pVirtualColName
  else
  begin
    vSP := TSingletonDB.GetInstance.DataBase.NewStoredProcedure;
    try
      vSP.StoredProcName := 'get_lang_text';
      vSP.Prepare;
      vSP.ParamByName('_default_value').Value := '';
      vSP.ParamByName('_table_name').Value := QuotedStr(pRawTableName);
      vSP.ParamByName('_column_name').Value := QuotedStr(pRawTableColName);
      vSP.ParamByName('_row_id').Value := IntToStr(0);
      vSP.ParamByName('_lang').Value := QuotedStr(TSingletonDB.GetInstance.DataBase.ConnSetting.Language);
      vSP.ExecProc;
      Result := vSP.ParamByName('result').AsString;

      Result :=
          'get_lang_text(' +
            '(SELECT raw' + pRawTableName + '.' + pRawTableColName + ' FROM ' + pRawTableName + ' as raw' + pRawTableName +
            ' WHERE raw' + pRawTableName + '.' + vRefColName + '=' + pDataTableName + '.' + pDataColName + ')' + ',' +
            QuotedStr(pRawTableName) + ',' +
            QuotedStr(pRawTableColName) + ', ' +
            pDataColName + ', ' +
            QuotedStr(TSingletonDB.GetInstance.DataBase.ConnSetting.Language) + ') as ' + pVirtualColName;
    finally
      vSP.Free;
    end;
  end;
end;

//function ColumnFromOtherTable(pTableNameData, pColNameData, pKeyColNameData,
//    pTableNameOther, pColNameOtherData, pTableName, pVirtualColName: string): string;
//begin
//
// 'SELECT bolum FROM ayar_personel_bolum WHERE id=(SELECT bolum_id FROM ayar_personel_birim WHERE id=2)'
//
//  Result := '(SELECT raw' + pRawTableName + '.' + pRawTableColName + ' FROM ' + pRawTableName + ' as raw' + pRawTableName +
//            ' WHERE raw' + pRawTableName + '.id=' + pDataTableName + '.' + pDataColName + ') as ' + pVirtualColName
//end;

function TranslateText(pDefault, pCode, pTip: string; pTable: string=''): string;
var
  Query: TFDQuery;
  vFilter: string;
begin
  Result := pDefault;

  vFilter := 'lang=' + QUERY_PARAM_CHAR + 'lang AND code=' + QUERY_PARAM_CHAR + 'code AND content_type=' + QUERY_PARAM_CHAR + 'content_type';

  if pTable <> '' then
    vFilter := vFilter + ' AND table_name=' + QUERY_PARAM_CHAR + 'table_name';

  if TSingletonDB.GetInstance.DataBase.Connection.Connected then
  begin
    Query := TSingletonDB.GetInstance.DataBase.NewQuery;
    try
      with Query do
      begin
        Close;
        SQL.Text := 'SELECT val FROM sys_lang_gui_content ' +
                    'WHERE 1=1 AND ' + vFilter;
        ParamByName('lang').Value := TSingletonDB.GetInstance.DataBase.ConnSetting.Language;
        ParamByName('code').Value := pCode;
        ParamByName('content_type').Value := pTip;
        if pTable <> '' then
          ParamByName('table_name').Value := pTable;
        Open;

        if not (Fields.Fields[0].IsNull) then
          Result := Fields.Fields[0].AsString;

        if Result = '' then
          Result := pDefault;

        EmptyDataSet;
        Close;
      end;
    finally
      Query.Free;
    end;
  end;
end;

function Login(pUserName, pPassword: string): Integer;
begin
  Result := 0;
end;

function ReplaceToRealColOrTableName(const pTableName: string): string;
begin
  Result := StringReplace(pTableName, ' ', '_', [rfReplaceAll]);
  Result := LowerCase(Result);
end;

function ReplaceRealColOrTableNameTo(const pTableName: string): string;
var
  n1: Integer;
  vDump: string;
begin
  vDump := StringReplace(pTableName, '_', ' ', [rfReplaceAll]);

  if vDump = '' then
    Result := ''
  else
  begin
    Result := Uppercase(vDump[1]);
    for n1 := 2 to Length(vDump) do
    begin
      if vDump[n1-1] = ' ' then
        Result := Result + Uppercase(vDump[n1])
      else
        Result := Result + Lowercase(vDump[n1]);
    end;
  end;

end;

function getRawDataByLang(pBaseTableName, pBaseColName: string): string;
begin
  if TSingletonDB.GetInstance.DataBase.ConnSetting.Language <> TSingletonDB.GetInstance.ApplicationSettings.AppMainLang.Value then
  begin
    Result :=
    'get_lang_text(' + pBaseColName + ', ' + QuotedStr(pBaseTableName) + ', ' +
      QuotedStr(pBaseColName) + ', id, ' +
      QuotedStr(TSingletonDB.GetInstance.DataBase.ConnSetting.Language) + ')::varchar as ' + pBaseColName;
  end
  else
    Result := pBaseTableName + '.' + pBaseColName;
                                                                                                           {
    '(SELECT ' +
    '  CASE WHEN ' +
		'    (SELECT b.val FROM sys_lang_data_content b ' +
        ' WHERE b.table_name=' + QuotedStr(pBaseTableName) +
          ' AND b.column_name=' + QuotedStr(pBaseColName) +
          ' AND b.lang=' + QuotedStr(TSingletonDB.GetInstance.DataBase.ConnSetting.Language) +
          ' AND b.row_id = ' + pBaseTableName + '.id) IS NULL THEN ' + pBaseTableName + '.' + pBaseColName +
		'  ELSE ' +
		'    (SELECT b.val FROM sys_lang_data_content b ' +
        ' WHERE b.table_name=' + QuotedStr(pBaseTableName) +
          ' AND b.column_name=' + QuotedStr(pBaseColName) +
          ' AND b.lang=' + QuotedStr(TSingletonDB.GetInstance.DataBase.ConnSetting.Language) +
          ' AND b.row_id = ' + pBaseTableName + '.id)' +
		'  END ' +
	  ')::varchar as ' + pBaseColName                                                                         }
end;

function getFormCaptionByLang(pFormName, pDefaultVal: string): string;
begin
  Result := TranslateText(pDefaultVal, pFormName, LngFormCaption);
end;

procedure NewParamForQuery(pQuery: TFDQuery; pField: TFieldDB);
begin
  pQuery.Params.ParamByName(pField.FieldName).DataType := pField.FieldType;
  pQuery.Params.ParamByName(pField.FieldName).Value := FormatedVariantVal(pField.FieldType, pField.Value);
  if pField.IsNullable or pField.IsFK then
  begin
    if (pField.FieldType = ftString)
    or (pField.FieldType = ftMemo)
    or (pField.FieldType = ftWideString)
    or (pField.FieldType = ftWideMemo)
    or (pField.FieldType = ftWord)
    then
    begin
      if pQuery.Params.ParamByName(pField.FieldName).Value = '' then
        pQuery.Params.ParamByName(pField.FieldName).Value := Null
    end
    else
    if (pField.FieldType = ftSmallint)
    or (pField.FieldType = ftShortint)
    or (pField.FieldType = ftInteger)
    or (pField.FieldType = ftLargeint)
    or (pField.FieldType = ftByte)
    then
    begin
      if pQuery.Params.ParamByName(pField.FieldName).Value = 0 then
        pQuery.Params.ParamByName(pField.FieldName).Value := Null
    end
    else if (pField.FieldType = ftDate) then
    begin
      if pQuery.Params.ParamByName(pField.FieldName).Value = 0 then
        pQuery.Params.ParamByName(pField.FieldName).Value := Null
    end
    else if (pField.FieldType = ftDateTime) then
    begin
      if pQuery.Params.ParamByName(pField.FieldName).Value = 0 then
        pQuery.Params.ParamByName(pField.FieldName).Value := Null
    end
    else
    if (pField.FieldType = ftTime)
    or (pField.FieldType = ftTimeStamp)
    then
    begin
      if pQuery.Params.ParamByName(pField.FieldName).Value = 0 then
        pQuery.Params.ParamByName(pField.FieldName).Value := Null;
    end
    else
    if (pField.FieldType = ftFloat)
    or (pField.FieldType = ftCurrency)
    or (pField.FieldType = ftSingle)
    or (pField.FieldType = ftBCD)
    or (pField.FieldType = ftFMTBcd)
    then
    begin
      if pQuery.Params.ParamByName(pField.FieldName).Value = 0 then
        pQuery.Params.ParamByName(pField.FieldName).Value := Null;
    end;

    if pQuery.Params.ParamByName(pField.FieldName).Value = Null then
      pQuery.Params.ParamByName(pField.FieldName).DataType := pField.FieldType;
  end;
end;

function UpdateColWidth(pTableName: string; pGrid: TDBGrid): Boolean;
var
  vSysGridColWidth: TSysGridColWidth;
  n1, n2: Integer;
begin
  Result := True;
  try
    vSysGridColWidth := TSysGridColWidth.Create(TSingletonDB.GetInstance.DataBase);
    try
      vSysGridColWidth.Clear;
      vSysGridColWidth.SelectToList(' AND ' + vSysGridColWidth.TableName + '.' + vSysGridColWidth.TableName1.FieldName + '=' + QuotedStr(ReplaceRealColOrTableNameTo(pTableName)), False, False);

      for n1 := 0 to pGrid.Columns.Count-1 do
        if pGrid.Columns[n1].Visible then
          for n2 := 0 to vSysGridColWidth.List.Count-1 do
            if TSysGridColWidth(vSysGridColWidth.List[n2]).ColumnName.Value = ReplaceRealColOrTableNameTo(pGrid.Columns[n1].FieldName) then
            begin
              TSysGridColWidth(vSysGridColWidth.List[n2]).ColumnWidth.Value := pGrid.Columns[n1].Width;
              TSysGridColWidth(vSysGridColWidth.List[n2]).Update(False);
            end;
    finally
      vSysGridColWidth.Free;
    end;
  except
    Result := False;
  end;
end;

function TSingletonDB.AddImalgeToImageList(pFileName: string; pList: TImageList;
  out pImageIndex: Integer): Boolean;
var
  mImage: TPicture;
  mImagePng: TPngImage;
  mBitmap: TBitmap;
Begin
  Result := False;
  pImageIndex := -1;
  if pList <> nil then
  begin
    if FileExists(pFilename, True) then
    begin
      mImage := TPicture.Create;
      mImagePng := TPngImage.Create;
      try
        try
          //dosya bulunamazsa hata vermemesi için try except yapýldý
          mImagePng.LoadFromFile(pFileName);
          mImage.Graphic := mImagePng;
        except
        end;


        if (mImage.Width > 0) and (mImage.Height > 0) then
        begin
          mBitmap := TBitmap.Create;
          try
            mBitmap.Assign(mImage.Graphic);

            pImageIndex := pList.add(mBitmap, nil);
            Result := True;
          finally
            mBitmap.Free;
          end;
        end
      finally
        mImage.Free;
        mImagePng.Free;
      end;
    end;
  end;
end;

constructor TSingletonDB.Create();
begin
  raise Exception.Create('Object Singleton');
end;

constructor TSingletonDB.CreatePrivate;
var
  nIndex: Integer;
  vPath: string;

  procedure AddImageToImageList(pImageList: TImageList);
  begin
    AddImalgeToImageList(vPath + 'accept' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'add' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'add_data' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'application' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'archive' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'attachment' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'back' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'calculator' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'calendar' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'chart' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'clock' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'close' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'col_width' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'comment' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'community_users' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'computer' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'copy' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'customer' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'database' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'down' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'excel_exports' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'excel_imports' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'favorite' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'file_doc' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'file_pdf' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'file_xls' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'filter' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'filter_add' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'filter_clear' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'folder' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'forward_new_mail' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'help' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'home' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'image' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'info' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'lang' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'lock' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'mail' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'money' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'movie' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'next' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'note' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'page' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'page_search' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'pause' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'play' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'port' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'preview' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'print' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'process' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'record' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'remove' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'repeat' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'rss' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'search' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'server' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'stock' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'stock_add' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'stock_delete' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'sum' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'up' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'user_he' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'user_password' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'user_she' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'users' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'warning' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'period' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'quality' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'exchange_rate' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'bank' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'bank_branch' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'city' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'country' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'stock_room' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'measure_unit' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'duration_finance' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'settings' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'sort_asc' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
    AddImalgeToImageList(vPath + 'sort_desc' + '.' + FILE_EXTENSION_PNG, pImageList, nIndex);
  end;
begin
  inherited Create;

  if Self.FDataBase = nil then
    FDataBase := TDatabase.Create;

  if Self.FUser = nil then
    FUser := TSysUser.Create(Self.FDataBase);

  if Self.FHaneMiktari = nil then
    FHaneMiktari := TAyarHaneSayisi.Create(Self.FDataBase);

  if Self.FApplicationSettings = nil then
    FApplicationSettings := TSysApplicationSettings.Create(Self.FDataBase);

  if Self.FApplicationSettingsOther = nil then
    FApplicationSettingsOther := TSysApplicationSettingsOther.Create(Self.FDataBase);

  if Self.FSysLang = nil then
    FSysLang := TSysLang.Create(Self.DataBase);

  if Self.ImageList32 = nil then
  begin
    FImageList32 := TImageList.Create(nil);
    FImageList32.Clear;
    FImageList32.SetSize(32, 32);
    FImageList32.Masked := False;
    FImageList32.ColorDepth := cd32Bit;
    FImageList32.DrawingStyle := dsTransparent;

    vPath := ExtractFilePath(Application.ExeName) + PATH_ICONS_32 + '/';
    AddImageToImageList(FImageList32);
  end;

  if Self.ImageList16 = nil then
  begin
    FImageList16 := TImageList.Create(nil);
    FImageList16.Clear;
    FImageList16.SetSize(16, 16);
    FImageList16.Masked := False;
    FImageList16.ColorDepth := cd32Bit;
    FImageList16.DrawingStyle := dsTransparent;

    vPath := ExtractFilePath(Application.ExeName) + PATH_ICONS_16 + '/';
    AddImageToImageList(FImageList16);
  end;
end;

destructor TSingletonDB.Destroy();
begin
  if SingletonDB <> Self then
    SingletonDB := nil;
 
  if Assigned(FUser) then
    FUser.Free;
  if Assigned(FHaneMiktari) then
    FHaneMiktari.Free;
  if Assigned(FDataBase) then
    FDataBase.Free;
  if Assigned(FApplicationSettings) then
    FApplicationSettings.Free;
  if Assigned(FApplicationSettingsOther) then
    FApplicationSettingsOther.Free;
  if Assigned(FSysLang) then
    FSysLang.Free;
  if Assigned(FImageList32) then
    FImageList32.Free;
  if Assigned(FImageList16) then
    FImageList16.Free;

  inherited Destroy;
end;

class function TSingletonDB.GetInstance: TSingletonDB;
begin
  if not Assigned(FInstance) then
    FInstance := TSingletonDB.CreatePrivate;
  Result := FInstance;
end;

function TSingletonDB.GetGridDefaultOrderFilter(pKey: string; pIsOrder: Boolean): string;
var
  vSysGridDefaultOrderFilter: TSysGridDefaultOrderFilter;
  vOrderFilter: string;
begin
  Result := '';
  if pIsOrder then
    vOrderFilter := ' and is_order=True'
  else
    vOrderFilter := ' and is_order=False';

  vSysGridDefaultOrderFilter := TSysGridDefaultOrderFilter.Create(DataBase);
  try
    vSysGridDefaultOrderFilter.SelectToList(vOrderFilter + ' and key=' + QuotedStr(pKey), False, False);
    if vSysGridDefaultOrderFilter.List.Count=1 then
      Result := TSysGridDefaultOrderFilter(vSysGridDefaultOrderFilter.List[0]).Value.Value;
  finally
    vSysGridDefaultOrderFilter.Free;
  end;

  if Trim(Result) <> '' then
    if not pIsOrder then
      Result := ' AND ' + Result;
end;

function TSingletonDB.GetIsRequired(pTableName, pFieldName: string): Boolean;
var
  vSysInputGui: TSysViewColumns;
begin
  Result := False;

  vSysInputGui := TSysViewColumns.Create(DataBase);
  try
    vSysInputGui.SelectToList(' and table_name=' + QuotedStr(ReplaceRealColOrTableNameTo(pTableName)) +
                              ' and column_name=' + QuotedStr(ReplaceRealColOrTableNameTo(pFieldName)), False, False);
    if vSysInputGui.List.Count=1 then
      Result := TSysViewColumns(vSysInputGui.List[0]).IsNullable.Value = 'NO';
  finally
    vSysInputGui.Free;
  end;
end;

function TSingletonDB.FillComboFromLangData(pComboBox: TComboBox; pBaseTableName,
    pBaseColName: string; pRowID: Integer): string;
begin
  pComboBox.Clear;
  with DataBase.NewQuery do
  try
    Close;
    SQL.Text :=
        'SELECT ' +
        ' CASE ' +
        '   WHEN b.val IS NULL THEN a.' + pBaseColName + ' ' +
        '   ELSE b.val ' +
        ' END as value ' +
        'FROM public.' + pBaseTableName + ' a ' +
        'LEFT JOIN sys_lang_data_content b ON b.row_id = a.id ' +
        '   AND b.table_name = ' + QuotedStr( ReplaceRealColOrTableNameTo(pBaseTableName) ) + ' ' +
        '   AND b.lang=' + QuotedStr(DataBase.ConnSetting.Language);
    Open;
    while NOT EOF do
    begin
      pComboBox.Items.Add(Fields.Fields[0].AsString);
      Next;
    end;
    EmptyDataSet;
    Close;
  finally
    Free;
  end;
end;

function TSingletonDB.GetMaxLength(pTableName, pFieldName: string): Integer;
var
  vSysInputGui: TSysViewColumns;
begin
  Result := 0;

  vSysInputGui := TSysViewColumns.Create(DataBase);
  try
    vSysInputGui.SelectToList(' and table_name=' + QuotedStr(ReplaceRealColOrTableNameTo(pTableName)) +
                              ' and column_name=' + QuotedStr(ReplaceRealColOrTableNameTo(pFieldName)), False, False);
    if vSysInputGui.List.Count=1 then
      Result := TSysViewColumns(vSysInputGui.List[0]).CharacterMaximumLength.Value;
  finally
    vSysInputGui.Free;
  end;
end;

function TSingletonDB.GetQualityFormNo(pTableName: string; pIsInput: Boolean): string;
var
  vQualityFormNo: TSysQualityFormNumber;
begin
  Result := '';
  pTableName := ReplaceRealColOrTableNameTo(pTableName);

  if DataBase.Connection.Connected then
  begin
    vQualityFormNo := TSysQualityFormNumber.Create(DataBase);
    try

      vQualityFormNo.SelectToList(' AND ' + vQualityFormNo.TableName1.FieldName + '=' + QuotedStr(pTableName) +
                                  ' AND ' + vQualityFormNo.IsInputForm.FieldName + '=' + TFunctions.BoolToStr(pIsInput) , False, False);

      if vQualityFormNo.List.Count = 1 then
        Result := TFunctions.VarToStr(vQualityFormNo.FormNo.Value);
    finally
      vQualityFormNo.Free;
    end;
  end;
end;

function TSingletonDB.GetDistinctColumnName(pTableName: string): TStringList;
begin
  Result := TStringList.Create;
  Result.BeginUpdate;
  with DataBase.NewQuery do
  try
    Close;
    SQL.Text := 'SELECT distinct v.column_name FROM sys_view_columns v ' +
                ' LEFT JOIN sys_grid_col_width a ON a.table_name=v.table_name and a.column_name = v.column_name ' +
                ' WHERE v.table_name=' + QuotedStr(pTableName) + ' and a.column_name is null ';
    Open;
    while NOT EOF do
    begin
      Result.Add( Fields.Fields[0].AsString );
      Next;
    end;
    EmptyDataSet;
    Close;
  finally
    Free;
  end;
  Result.EndUpdate;
end;

procedure TSingletonDB.FillColNameForColWidth(pComboBox: TComboBox; pTableName: string);
begin
  pComboBox.Clear;

  with DataBase.NewQuery do
  try
    Close;
    SQL.Text := 'SELECT distinct v.column_name, ordinal_position FROM sys_view_columns v ' +
                'LEFT JOIN sys_grid_col_width a ON a.table_name=v.table_name and a.column_name = v.column_name ' +
                'WHERE v.table_name=' + QuotedStr(pTableName) + ' and a.column_name is null ' +
                'GROUP BY v.column_name, ordinal_position ' +
                'ORDER BY ordinal_position ASC ';
    Open;
    while NOT EOF do
    begin
      pComboBox.Items.Add( Fields.Fields[0].AsString );
      Next;
    end;
    EmptyDataSet;
    Close;
  finally
    Free;
  end;
end;

end.
