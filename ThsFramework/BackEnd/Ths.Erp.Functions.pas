unit Ths.Erp.Functions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Types, Dialogs, StdCtrls, Strutils, ExtCtrls, DB, nb30, Grids, Winapi.TlHelp32,
  Winapi.PsAPI, System.Hash, TypInfo, RTTI;

const
  CKEY1 = 53761475;
  CKEY2 = 32618110;

type
  ArrayInteger = array of Integer;

type
  TLang = record
    StatusAccept: string;
    StatusAdd: string;
    StatusCancel: string;
    StatusDelete: string;
    ButtonAccept: string;
    ButtonAdd: string;
    ButtonCancel: string;
    ButtonClose: string;
    ButtonDelete: string;
    ButtonFilter: string;
    ButtonOK: string;
    ButtonUpdate: string;
    ErrorAccessRight: string;
    ErrorDatabaseConnection: string;
    ErrorLogin: string;
    ErrorDBOther: string;
    ErrorDBNoDataFound: string;
    ErrorDBTooManyRows: string;
    ErrorDBRecordLocked: string;
    ErrorDBUnique: string;
    ErrorDBForeignKeyDeleteUpdate: string;
    ErrorDBForeignKeyUnique: string;
    ErrorDBObjectNotExist: string;
    ErrorDBUserPasswordInvalid: string;
    ErrorDBUserPasswordExpired: string;
    ErrorDBUserPasswordWillExpire: string;
    ErrorDBCmdAborted: string;
    ErrorDBServerGone: string;
    ErrorDBServerOutput: string;
    ErrorDBArrExecMalFunc: string;
    ErrorDBInvalidParams: string;
    ErrorRecordDeleted: string;
    ErrorRecordDeletedMessage: string;
    ErrorRedInputsRequired: string;
    ErrorRequiredData: string;
    GeneralConfirmationLower: string;
    GeneralConfirmationUpper: string;
    GeneralNoUpper: string;
    GeneralNoLower: string;
    GeneralYesUpper: string;
    GeneralYesLower: string;
    GeneralRecordCount: string;
    GeneralPeriod: string;
    FilterFilterCriteriaTitle: string;
    FilterLike: string;
    FilterNotLike: string;
    FilterSelectFilterFields: string;
    FilterWithEnd: string;
    FilterWithStart: string;
    MessageApplicationTerminate: string;
    MessageCloseWindow: string;
    MessageDeleteRecord: string;
    MessageUnsupportedProcess: string;
    MessageUpdateRecord: string;
    MessageUpdateColumnWidth: string;
    MessageTitleOther: string;
    MessageTitleNoDataFound: string;
    MessageTitleDataAlreadyExists: string;
    MessageTitleInsertUpdate: string;
    MessageTitleUpdateDelete: string;
    MessageTitleObjectNotFound: string;
    MessageTitleError: string;
    PopupAddLangGuiContent: string;
    PopupAddLangDataContent: string;
    PopupAddUseMultiLangData: string;
    PopupCopyRecord: string;
    PopupExcludeFilter: string;
    PopupExportExcel: string;
    PopupExportExcelAll: string;
    PopupFilter: string;
    PopupPreview: string;
    PopupPrint: string;
    PopupRemoveFilter: string;
    PopupRemoveSort: string;
    WarningActiveTransaction: string;
    WarningLockedRecord: string;
    WarningOpenWindow: string;
  end;

type
  TRoundToRange = -37..37;

type
  TObjectClone = record
    class function From<T: class>(Source: T): T; static;
  end;

type
  TFunctions = class
    class function IsNumeric(const S: string): Boolean;
    class procedure TutarHesapla(const fiyat: double; const miktar: double; const iskontoOrani: double; const kdvOrani: double; out tutar: double; out netFiyat: double; out iskontoTutar: double; out kdvTutar: double; out toplamTutar: double; ondalikli_hane: integer);
    class function SayiyiYaziyaCevir(Num: Double): string;
    class function SayiyiYaziyaCevir2(tutar: double; tur: integer; tam_birim: string = 'TL'; ondalikli_birim: string = 'KRÞ'): string;
    class function VirguldenSonraHaneSayisi(deger: double; hanesayisi: integer): string;
    class function GetMACAddress: TStringList;
    class function GetAdapterInfo(Lana: AnsiChar): string;
    class function CountNumOfCharacter(s: string; delimeter: string): integer;
    class function FloatKeyControl2(Sender: TObject; Key: Char): Char;
    class function GetSimdikiTarih(date_now: TDate): TStringList;
    class function LastPos(const SubStr: string; const strData: string): Integer;
    class function isAltDown(): Boolean;
    class function isCtrlDown(): Boolean;
    class function isShiftDown(): Boolean;
    class function GetMikroRaporTarihFormat(tarih: TDateTime): string;
    class function CLEN(S: string; N: integer): string;
    class function FILLSTR(C: Char; N: Integer): string;
    class function RSET(S: string; N: integer): string;
    class function LSET(ST: string): string;

    /// <summary>
    ///  Belirtilen dosyayý ByteArray bilgi olarak geri dönderir
    ///  Dosya adý "C:\Test\asd.xml" gibi
    /// </summary>
    class function FileToByteArray(const FileName: WideString): TArray<Byte>;

    /// <summary>
    ///  ByteArray bilgiyi verilen dosya adýnda kayýt eder.
    ///  Dosya adý "C:\Test\asd.xml" gibi
    /// </summary>
    class procedure ByteArrayToFile(const ByteArray: TBytes; const FileName: string);

    /// <summary>
    ///   Dosya yolu ile birlikte verilen dosya adýnýn disk boyutunu getirir. Bilgi Byte cinsinden gelir.
    ///   1MB için dönen deðer 1000000 olarak gelir. 15KB için 15000 gibi
    /// </summary>
    {$IFDEF MSWINDOWS}
    class function GetFileSize(pFileName: string): Int64;
    {$ENDIF MSWINDOWS}

    /// <summary>
    ///   Türkçe karakterlerde dahil olmak üzere verilen string bilgiyi büyük harfe çevirir. ý>I i>Ý olur
    /// </summary>
    class function UpperCaseTr(S: string): string;

    /// <summary>
    ///   Türkçe karakterlerde dahil olmak üzere verilen string bilgiyi küçük harfe çevirir. I>ý Ý>i olur
    /// </summary>
    class function LowerCaseTr(S: string): string;

    /// <summary>
    ///   Boolean bilgiyi string olarak döndürür. Boolean tip deðeri True ise "TRUE" string döner False ise "FALSE" string döner
    /// </summary>
    class function BoolToStr(pBool: Boolean): string;

    class function CheckIntegerInArray(pArr: ArrayInteger; pKey: Integer): Boolean;
    class function CheckStringInArray(pArr: TArray<string>; pKey: string): Boolean;
    class function GetStrHashSHA512(Str: string): string;
    class function GetFileHashSHA512(FileName: WideString): string;
    class function GetStrFromHashSHA512(pString: WideString): string;

    /// <summary>
    ///   Verilen string bilgiyi girilen key ile þifreler
    /// </summary>
    /// <remarks>
    ///  <para>Kendi Anahtar deðerimiz (0-65535 aralýðýndaki) ile bilgiyi þifrelemek için kullanýlýr.</para>
    ///  <para>Mesela kiþisel verileri koruma kanunu gereði TC Kimlik No bilgisini þifreler.</para>
    ///  <para>Aþaðýdaki örnek kod örnek olarak attýðým TC Kimlik bilgisini þifreler</para>
    ///  <code lang="Delphi">EncryptStr('30850331144', 14257); //Sonuç: 040EF0D744DA01BA36DAE5</code>
    /// </remarks>
    class function EncryptStr(const S: WideString; Key: Word): string;

    /// <summary>
    ///   EncryptStr ile þifrelenen bilginin þifresini çözmek için Key ile birlikte þifreli bilgi girilir.
    ///   Gerçek bilgi geri döner
    /// </summary>
    /// <remarks>
    ///   <para>Kendi Anahtar deðerimiz (0-65535 aralýðýndaki) ile bilgiyi þifrelemek için kullanýlýr.</para>
    ///   <para>Mesela kiþisel verileri koruma kanunu gereði þifrelenen TC Kimlik No bilgisini gerçek bilgiye çevirir.</para>
    ///   <para>Aþaðýdaki örnek kod örnek olarak attýðým þifrelenmiþ TC Kimlik bilgisini gerçek bilgiye çevirir</para>
    ///   <code lang="Delphi">EncryptStr('040EF0D744DA01BA36DAE5', 14257); //Sonuç: 30850331144</code>
    /// </remarks>
    class function DecryptStr(const S: string; Key: Word): string;

    /// <summary>
    ///
    /// </summary>
    class function FirstCaseUpper(const vStr: string): string;

    /// <summary>
    ///  Variant To Integer data convert
    /// </summary>
    class function VarToInt(const pVal: Variant): Integer; static;

    /// <summary>
    ///  Variant To string data convert
    /// </summary>
    class function VarToStr(const pVal: Variant): string; static;


    class function GetDialogColor(pColor: TColor): TColor;
    class function GetDiaglogOpen(pFilter: string; pInitialDir: string = ''): string;
    class function GetDiaglogSave(pFileName, pFilter: string; pInitialDir: string = ''): string;
    class function FTPDosyaAl(pSrcFile, pDesFile: TFileName; pFtp, pRemoteDir, pLogin, pPass: string): Boolean;


    /// <summary>
    ///   Get ProcessID By ProgramName (Include Path or Not Include)
    /// </summary>
    /// <remarks>
    ///   Burada framework içinde kullanýlan ve tekrar eden dil database tablosundan
    ///   çekilecek olan datalar için sabit bilgiler yazýldý.
    /// </remarks>
    /// <example>
    ///   Yeni Kayýt Ekle Buton baþlýðý için ButtonAdd
    /// </example>
    /// <seealso href="http://www.aaa.xxx/test">
    ///   Link verilmedi. Buradan Uður Parlayan hocama selamlar
    /// </seealso>
    class function GetPIDByProgramName(const APName: string): THandle;

    // Get Window Handle By ProgramName (Include Path or Not Include)
    class function GetHWndByProgramName(const APName: string): THandle;

    // Get Window Handle By ProcessID
    class function GetHWndByPID(const hPID: THandle): THandle;

    // Get ProcessID By Window Handle
    class function GetPIDByHWnd(const hWnd: THandle): THandle;

    // Get Process Handle By Window Handle
    class function GetProcessHndByHWnd(const hWnd: THandle): THandle;

    // Get Process Handle By Process ID
    class function GetProcessHndByPID(const hAPID: THandle): THandle;
    class function GetPathFromPID(const PID: cardinal): string;
    class function getApplicationPath(const hnwd: HWND): string;
  private
    { Private declarations }
  public
    //
  end;

/// <summary>
///   Framework içinde kullanýlan sabit dil içeriklieri için bilgilerin olduðu record.
/// </summary>
/// <remarks>
///   Burada framework içinde kullanýlan ve tekrar eden dil database tablosundan
///   çekilecek olan datalar için sabit bilgiler yazýldý.
/// </remarks>
/// <example>
///   Yeni Kayýt Ekle Buton baþlýðý için ButtonAdd
/// </example>
/// <seealso href="http://www.aaa.xxx/test">
///   Link verilmedi. Buradan Uður Parlayan hocama selamlar
/// </seealso>
function FrameworkLang: TLang;
/// <summary>
///   Birden fazla sLineBreak eklemek için kullanýlýr.
/// </summary>
/// <remarks>
///   Birden fazla sLineBreak kullanýlmak istenildiðinde bu fonksiyon yardýmcý oluyor.
///  3 tane slinebreak yazmak yerine bu fonksiyonu kullanabilirsin.
///  slinebreak + slinebreak + slinebreak
/// </remarks>
/// <example>
///   AddLBs(3)
/// </example>

function AddLBs(pCount: Integer = 1): string;
/// <summary>
///   Butonlarýn baþlýklarýný özelleþtirebildiðimiz Mesaj ekraný
/// </summary>
/// <remarks>
///   Buton baþlýklarýný özelleþtirilebildiðimiz özel MesajDiaglog formu.
///  Mesaj, Baþlýk, Buton Yazýlarý gibi herþeyi istediðimiz þekilde yazabildiðimiz
///  özel Mesaj formu
/// </remarks>
/// <example>
///   CustomMsgDlg('Are you sure you want to update record?', mtConfirmation, mbYesNo, ['Yes', 'No'], mbNo, 'Confirmation') = mrYes
/// </example>

function CustomMsgDlg(const pMsg: string; pDlgType: TMsgDlgType; pButtons: TMsgDlgButtons; pCaptions: array of string; pDefaultButton: TMsgDlgBtn; pCustomTitle: string = ''): Integer;

function ReplaceMessages(Source: string; Old, New: array of string; IsIgnoreCase: Boolean = False): string;

function EnDeCrypt(const Value: string): string;

function CheckString(const pStr: string): Boolean;

implementation

uses
Ths.Erp.Database.Table,
  Math, IdFTP, IdFTPCommon, IdAntiFreeze;

function FrameworkLang: TLang;
begin
  if Result.StatusAccept = '' then
  begin
    Result.StatusAccept := 'Accept';
    Result.StatusAdd := 'Add';
    Result.StatusCancel := 'Cancel';
    Result.StatusDelete := 'Delete';

    Result.ButtonAccept := 'Accept';
    Result.ButtonAdd := 'Add';
    Result.ButtonCancel := 'Cancel';
    Result.ButtonClose := 'Close';
    Result.ButtonDelete := 'Delete';
    Result.ButtonFilter := 'Filter';
    Result.ButtonOK := 'Ok';
    Result.ButtonUpdate := 'Update';

    Result.ErrorAccessRight := 'Access Right';
    Result.ErrorDatabaseConnection := 'Database Connection';
    Result.ErrorLogin := 'Login';
    Result.ErrorDBOther := 'Other';
    Result.ErrorDBNoDataFound := 'No Data Found';
    Result.ErrorDBTooManyRows := 'Too Many Rows';
    Result.ErrorDBRecordLocked := 'Record Locked';
    Result.ErrorDBUnique := 'Unique';
    Result.ErrorDBForeignKeyDeleteUpdate := 'Foreign Key Delete Update';
    Result.ErrorDBForeignKeyUnique := 'Foreign Key Unique';
    Result.ErrorDBObjectNotExist := 'Object Not Exist';
    Result.ErrorDBUserPasswordInvalid := 'User Password Invalid';
    Result.ErrorDBUserPasswordExpired := 'User Password Expired';
    Result.ErrorDBUserPasswordWillExpire := 'User Password Will Expire';
    Result.ErrorDBCmdAborted := 'CMD Aborted';
    Result.ErrorDBServerGone := 'Server Gone';
    Result.ErrorDBServerOutput := 'Server Output';
    Result.ErrorDBArrExecMalFunc := 'Arr Exec Mal Func';
    Result.ErrorDBInvalidParams := 'Invalid Params';
    Result.ErrorRecordDeleted := 'Record Deleted';
    Result.ErrorRecordDeletedMessage := 'Record Deleted Message';
    Result.ErrorRedInputsRequired := 'Red Inputs Required';
    Result.ErrorRequiredData := 'Required Data';

    Result.GeneralConfirmationLower := 'Confirmation Lower';
    Result.GeneralConfirmationUpper := 'Confirmation Upper';
    Result.GeneralNoLower := 'No Lower';
    Result.GeneralNoUpper := 'No Upper';
    Result.GeneralRecordCount := 'Record Count';
    Result.GeneralYesLower := 'Yes Lower';
    Result.GeneralYesUpper := 'Yes Upper';
    Result.GeneralPeriod := 'Period';

    Result.MessageApplicationTerminate := 'Application Terminate';
    Result.MessageCloseWindow := 'Close Window';
    Result.MessageDeleteRecord := 'Delete Record';
    Result.MessageUnsupportedProcess := 'Unsupported Process';
    Result.MessageUpdateRecord := 'Update Record';
    Result.MessageUpdateColumnWidth := 'Update Column Width';

    Result.MessageTitleOther := 'Other';
    Result.MessageTitleNoDataFound := 'No Data Found';
    Result.MessageTitleDataAlreadyExists := 'Data Already Exists';
    Result.MessageTitleInsertUpdate := 'Insert/Update Record';
    Result.MessageTitleUpdateDelete := 'Update/Delete Record';
    Result.MessageTitleObjectNotFound := 'Object Not Found';
    Result.MessageTitleError := 'Error';

    Result.PopupAddLangGuiContent := 'Add Lang Gui Content';
    Result.PopupAddLangDataContent := 'Add Lang Data Content';
    Result.PopupAddUseMultiLangData := 'Add Use Multi Lang Data';
    Result.PopupCopyRecord := 'Copy Record';
    Result.PopupExcludeFilter := 'Exclude Filter';
    Result.PopupExportExcel := 'Export Excel';
    Result.PopupExportExcelAll := 'Export Excel All';
    Result.PopupFilter := 'Filter';
    Result.PopupPreview := 'Preview';
    Result.PopupPrint := 'Print';
    Result.PopupRemoveFilter := 'Remove Filter';
    Result.PopupRemoveSort := 'Remove Sort';

    Result.WarningActiveTransaction := 'Active Transaction';
    Result.WarningLockedRecord := 'Locked Record';
    Result.WarningOpenWindow := 'Open Window';
  end;
end;

function AddLBs(pCount: Integer): string;
var
  n1: Integer;
begin
  for n1 := 0 to pCount - 1 do
    Result := Result + sLineBreak;
end;

function CustomMsgDlg(const pMsg: string; pDlgType: TMsgDlgType; pButtons: TMsgDlgButtons; pCaptions: array of string; pDefaultButton: TMsgDlgBtn; pCustomTitle: string = ''): Integer;
var
  vMsgDlg: TForm;
  n1, vCaptionIndex: Integer;
  vDlgButton: TButton;
begin
  vMsgDlg := CreateMessageDialog(pMsg, pDlgType, pButtons, pDefaultButton);
  vCaptionIndex := 0;

  if pCustomTitle <> '' then
    vMsgDlg.Caption := pCustomTitle;

  for n1 := 0 to vMsgDlg.ComponentCount - 1 do
  begin
   { If the object is of type TButton, then }
   { Wenn es ein Button ist, dann...}
    if (vMsgDlg.Components[n1] is TButton) then
    begin
      vDlgButton := TButton(vMsgDlg.Components[n1]);
      if vCaptionIndex > High(pCaptions) then
        Break;
      { Give a new caption from our Captions array}
      { Schreibe Beschriftung entsprechend Captions array}
      vDlgButton.Caption := pCaptions[vCaptionIndex];
      Inc(vCaptionIndex);
    end;
  end;
  Result := vMsgDlg.ShowModal;
end;

function ReplaceMessages(Source: string; Old, New: array of string; IsIgnoreCase: Boolean = False): string;
var
  n1: Integer;
begin
  Result := Source;
  if (Length(Old) > 0) and (Old[0] <> '') then
  begin
    for n1 := 0 to Length(Old) - 1 do
    begin
      if n1 = 0 then
        Result := '';

      if Old[n1] <> '' then
        if IsIgnoreCase then
          Result := Result + StringReplace(Source, Old[n1], New[n1], [rfIgnoreCase])
        else
          Result := Result + StringReplace(Source, Old[n1], New[n1], [rfReplaceAll]);
    end;
  end;

  Result := StringReplace(Result, '#br#', AddLBs, [rfReplaceAll]);
end;

function EnDeCrypt(const Value: string): string;
var
  CharIndex: integer;
begin
  Result := Value;
  for CharIndex := 1 to Length(Value) do
    Result[CharIndex] := chr(not (ord(Value[CharIndex])));
end;

function CheckString(const pStr: string): Boolean;
var
  n1: Integer;
begin
  Result := False;
  for n1 := 1 to Length(pStr) do
    if CharInSet(pStr[n1], ['a'..'z', 'A'..'Z', '_', 'ö', 'Ö', 'ç', 'Ç', 'þ', 'Þ', 'ý', 'Ý', 'ð', 'Ð', 'ü', 'Ü']) then
      Exit(True);
end;

class function TObjectClone.From<T>(Source: T): T;
var
  Context: TRttiContext;
  IsComponent, LookOutForNameProp: Boolean;
  RttiType: TRttiType;
  Method: TRttiMethod;
  MinVisibility: TMemberVisibility;
  Params: TArray<TRttiParameter>;
  Prop: TRttiProperty;
  SourceAsPointer, ResultAsPointer: Pointer;
begin
  RttiType := Context.GetType(Source.ClassType);
  //find a suitable constructor, though treat components specially
  IsComponent := (Source is TComponent);
  for Method in RttiType.GetMethods do
    if Method.IsConstructor then
    begin
      Params := Method.GetParameters;
      if Params = nil then
        Break;
      if (Length(Params) = 1) and IsComponent and (Params[0].ParamType is TRttiInstanceType) and SameText(Method.Name, 'Create') then
        Break;
    end;

  Result := nil;
  if Params = nil then
    Result := (Method.Invoke(Source.ClassType, []).AsType < T > )
  else
    Result := (Method.Invoke(Source.ClassType, [TComponent(Source).Owner]).AsType < T > );

  try
    //many VCL control properties require the Parent property to be set first
    if Source is TControl then
      TControl(Result).Parent := TControl(Source).Parent;
    //loop through the props, copying values across for ones that are read/write
    Move(Source, SourceAsPointer, SizeOf(Pointer));
    Move(Result, ResultAsPointer, SizeOf(Pointer));
    LookOutForNameProp := IsComponent and (TComponent(Source).Owner <> nil);
    if IsComponent then
      MinVisibility := mvPublished //an alternative is to build an exception list
    else
      MinVisibility := mvPublic;
    for Prop in RttiType.GetProperties do
      if (Prop.Visibility >= MinVisibility) and Prop.IsReadable and Prop.IsWritable then
        if LookOutForNameProp and (Prop.Name = 'Name') and (Prop.PropertyType is TRttiStringType) then
          LookOutForNameProp := False
        else
          Prop.SetValue(ResultAsPointer, Prop.GetValue(SourceAsPointer));
  except
    Result.Free;
    raise;
  end;
end;

class function TFunctions.IsNumeric(const S: string): Boolean;
begin
  Result := True;
  try
    StrToInt(S);
  except
    Result := False;
  end;
end;

class procedure TFunctions.TutarHesapla(const fiyat: double; const miktar: double; const iskontoOrani: double; const kdvOrani: double; out tutar: double; out netFiyat: double; out iskontoTutar: double; out kdvTutar: double; out toplamTutar: double; ondalikli_hane: integer);
begin
  tutar := miktar * fiyat;
  netFiyat := fiyat * (100.0 - iskontoOrani) / 100.0;
  iskontoTutar := (tutar * iskontoOrani) / 100.0;
  kdvTutar := (netFiyat * miktar * kdvOrani) / 100.0;
  toplamTutar := (netFiyat * miktar) + kdvTutar;
end;

class function TFunctions.SayiyiYaziyaCevir(Num: Double): string;
const
  BIRLER: array[0..9] of string = ('', 'BÝR ', 'ÝKÝ ', 'ÜÇ ', 'DÖRT ', 'BEÞ ', 'ALTI ', 'YEDÝ ', 'SEKÝZ ', 'DOKUZ ');
  ONLAR: array[0..9] of string = ('', 'ON ', 'YÝRMÝ ', 'OTUZ ', 'KIRK ', 'ELLÝ ', 'ALTMIÞ ', 'YETMÝÞ ', 'SEKSEN ', 'DOKSAN ');
  DIGER: array[0..5] of string = ('', 'BÝN ', 'MÝLYON ', 'MÝLYAR ', 'TRÝLYON ', 'KATRÝLYON ');

  function SmallNum(Num: Int64): string;
  var
    S: string;
  begin
    Result := '';
    S := IntToStr(Num);
    if (Length(S) = 1) then
      S := '00' + S
    else
    begin
      if (Length(S) = 2) then
        S := '0' + S;
    end;
    if S[1] <> '0' then
    begin
      if S[1] <> '1' then
        Result := BIRLER[StrToInt(string(S[1]))] + 'YÜZ '
      else
        Result := 'YÜZ ';
    end;
    Result := Result + ONLAR[StrToInt(string(S[2]))];
    Result := Result + BIRLER[StrToInt(string(S[3]))];
  end;

var
  i, j, n, Nm: Int64;
  S, Sn: string;
begin
  S := FormatFloat('0', Num);
  Sn := '';
  if Num = 0 then
    Sn := 'SIFIR'
  else if Length(S) < 4 then
    Sn := SmallNum(Round(Num))
  else
  begin
    i := 1;
    j := Length(S) mod 3;
    if j = 0 then
    begin
      j := 3;
      n := Length(S) div 3 - 1;
    end
    else
      n := Length(S) div 3;

    while i < Length(S) do
    begin
      Nm := StrToInt(Copy(S, i, j));

      if (Nm = 1) and (n = 1) then
      begin
        Nm := 0;
        Sn := Sn + SmallNum(Nm) + Diger[n];
      end;

      if Nm <> 0 then
        Sn := Sn + SmallNum(Nm) + Diger[n];

      i := i + j;
      j := 3;
      n := n - 1;
    end;
  end;
  Result := Sn;
end;

class function TFunctions.SayiyiYaziyaCevir2(tutar: double; tur: integer; tam_birim: string = 'TL'; ondalikli_birim: string = 'KRÞ'): string;
const
  b1: array[1..9] of string = ('BÝR', 'ÝKÝ', 'ÜÇ', 'DÖRT', 'BEÞ', 'ALTI', 'YEDÝ', 'SEKÝZ', 'DOKUZ');
  b2: array[1..9] of string = ('ON', 'YÝRMÝ', 'OTUZ', 'KIRK', 'ELLÝ', 'ALTMIÞ', 'YETMÝÞ', 'SEKSEN', 'DOKSAN');
  b3: array[1..6] of string = ('KATRÝLYON', 'TRÝLYON', 'MÝLYAR', 'MÝLYON', 'BÝN', '');
var
  gr: array[1..6] of string;
  sn: array[1..6] of string;
  bs: array[1..3] of integer;
  tutars, tutart, tutark, sonuct, sonuck: string;
  i, l: integer;
begin
  tutars := floattostr(tutar);
  if pos(',', tutars) = 0 then
    tutars := tutars + ',00';

  tutart := copy(tutars, 1, (pos(',', tutars) - 1));
  tutark := copy(tutars, (pos(',', tutars) + 1), 2);
  tutart := stringofchar('0', (18 - (length(trim(tutart))))) + tutart;
  tutark := tutark + stringofchar('0', (2 - (length(trim(tutark)))));

  for i := 1 to 6 do
    gr[i] := copy(tutart, 1 + (3 * (i - 1)), 3);

  for l := 1 to 6 do
  begin
    bs[1] := StrToInt(Copy(gr[l], 1, 1));
    if bs[1] <> 0 then
    begin
      if bs[1] <> 1 then
        sn[l] := sn[l] + b1[bs[1]] + 'YÜZ'
      else
        sn[l] := sn[l] + 'YÜZ';
    end;

    bs[2] := strtoint(copy(gr[l], 2, 1));

    if bs[2] <> 0 then
      sn[l] := sn[l] + b2[bs[2]];

    bs[3] := strtoint(copy(gr[l], 3, 1));

    if bs[3] <> 0 then
      sn[l] := sn[l] + b1[bs[3]];

    if Length(Trim(sn[l])) <> 0 then
      sn[l] := sn[l] + b3[l];
  end;

  if sn[5] = 'BÝRBÝN' then
    sn[5] := 'BÝN';

  for i := 1 to 6 do
    sonuct := sonuct + sn[i];

  if strtoint(copy(tutark, 1, 1)) <> 0 then
    sonuck := sonuck + b2[strtoint(copy(tutark, 1, 1))];

  if strtoint(copy(tutark, 2, 1)) <> 0 then
    sonuck := sonuck + b1[strtoint(copy(tutark, 2, 1))];

  if tur = 0 then
    result := sonuct + ' ' + tam_birim + ' / ' + sonuck + ' ' + ondalikli_birim;

  if tur = 1 then
    result := sonuct + ' ' + tam_birim;

  if tur = 2 then
    result := sonuck + ' ' + ondalikli_birim;
end;

class function TFunctions.VarToInt(const pVal: Variant): Integer;
begin
  Result := StrToIntDef(VarToStr(pVal), 0);
end;

class function TFunctions.VarToStr(const pVal: Variant): string;
begin
  Result := Variants.VarToStr(pVal);
end;

class function TFunctions.VirguldenSonraHaneSayisi(deger: double; hanesayisi: integer): string;
var
  strDeger: string;
begin
  if deger <> 0 then
  begin
    strDeger := FloatToStr(deger);
    if Pos(',', strDeger) > 0 then
      Result := LeftStr(strDeger, Pos(',', strDeger) + hanesayisi)
    else
      Result := strDeger;
  end
  else if deger = 0 then
  begin
    Result := '0';
  end;
end;

class function TFunctions.GetAdapterInfo(Lana: AnsiChar): string;
var
  Adapter: TAdapterStatus;
  NCB: TNCB;
begin
  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBRESET);
  NCB.ncb_lana_num := Lana;
  if Netbios(@NCB) <> Char(NRC_GOODRET) then
  begin
    Result := 'Mac Adres bulunamadý';
    Exit;
  end;
  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBASTAT);
  NCB.ncb_lana_num := Lana;
  NCB.ncb_callname := '*';
  FillChar(Adapter, SizeOf(Adapter), 0);
  NCB.ncb_buffer := @Adapter;
  NCB.ncb_length := SizeOf(Adapter);
  if Netbios(@NCB) <> Char(NRC_GOODRET) then
  begin
    Result := 'Mac Adres bulunamadý';
    Exit;
  end;
  Result := IntToHex(Byte(Adapter.adapter_address[0]), 2) + '-' + IntToHex(Byte(Adapter.adapter_address[1]), 2) + '-' + IntToHex(Byte(Adapter.adapter_address[2]), 2) + '-' + IntToHex(Byte(Adapter.adapter_address[3]), 2) + '-' + IntToHex(Byte(Adapter.adapter_address[4]), 2) + '-' + IntToHex(Byte(Adapter.adapter_address[5]), 2);
end;

class function TFunctions.GetDialogColor(pColor: TColor): TColor;
var
  vColorDialog: TColorDialog;
begin
  vColorDialog := TColorDialog.Create(nil);
  try
    vColorDialog.Color := pColor;
    vColorDialog.Execute(Application.Handle);
    Result := vColorDialog.Color;
  finally
    vColorDialog.Free;
  end;
end;

class function TFunctions.GetDiaglogOpen(pFilter: string; pInitialDir: string = ''): string;
var
  vOpenDialog: TOpenDialog;
begin
  vOpenDialog := TOpenDialog.Create(nil);
  try
    vOpenDialog.InitialDir := '%USERPROFILE%\desktop';
    vOpenDialog.Filter := pFilter;
    vOpenDialog.Execute(Application.Handle);
    Result := vOpenDialog.FileName;
  finally
    vOpenDialog.Free;
  end;
end;

class function TFunctions.GetDiaglogSave(pFileName, pFilter: string; pInitialDir: string = ''): string;
var
  vSaveDialog: TOpenDialog;
begin
  vSaveDialog := TSaveDialog.Create(nil);
  try
    vSaveDialog.Filter := pFilter;
    vSaveDialog.FileName := pFileName;
    if pInitialDir = '' then
      vSaveDialog.InitialDir := '%USERPROFILE%\desktop'
    else
      vSaveDialog.InitialDir := pInitialDir;

    vSaveDialog.Execute(Application.Handle);
    Result := vSaveDialog.FileName;
  finally
    vSaveDialog.Free;
  end;
end;

class function TFunctions.GetMACAddress: TStringList;
var
  AdapterList: TLanaEnum;
  NCB: TNCB;
  nIndex: integer;
begin
  Result := TStringList.Create;
  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBENUM);
  NCB.ncb_buffer := @AdapterList;
  NCB.ncb_length := SizeOf(AdapterList);
  Netbios(@NCB);
  if Byte(AdapterList.length) > 0 then
  begin
    for nIndex := 0 to Byte(AdapterList.length) - 1 do
    begin
      Result.Add(GetAdapterInfo(AdapterList.lana[nIndex]));
    end;
  end
//  else
//    Result := 'Mac Adres bulunamadý';
end;

class function TFunctions.CountNumOfCharacter(s: string; delimeter: string): integer;
var
  i, nFind: integer;
  letter: string;
begin
  //count := 0;
  nFind := 0;
  for i := 1 to length(s) do
  begin
    letter := s[i];
    if letter = delimeter then
      nFind := nFind + 1;
  end;
  result := nFind;
end;

class function TFunctions.GetSimdikiTarih(date_now: TDate): TStringList;
var
  wGun, wAy, wYil: word;
begin
  Result := TStringList.Create;

  DecodeDate(date_now, wYil, wAy, wGun);

  Result.Add(IntToStr(wGun));
  Result.Add(IntToStr(wAy));
  Result.Add(IntToStr(wYil));
end;

//todo ferhat
class function TFunctions.CheckIntegerInArray(pArr: ArrayInteger; pKey: Integer): Boolean;
var
  n1: Integer;
begin
  Result := False;
  for n1 := 0 to Length(pArr) - 1 do
  begin
    if pKey = pArr[n1] then
      Result := True;
    Exit;
  end;
end;

class function TFunctions.CheckStringInArray(pArr: TArray<string>; pKey: string): Boolean;
var
  n1: Integer;
begin
  Result := False;
  for n1 := 0 to Length(pArr) - 1 do
  begin
    if pKey = pArr[n1] then
      Result := True;
    Exit;
  end;
end;

class function TFunctions.CLEN(S: string; N: INTEGER): string;
var
  X: integer;
begin
  X := LENGTH(S);
  if X < N then
    CLEN := S + FILLSTR(' ', N - X)
  else
    CLEN := COPY(S, 1, N);
end;

class function TFunctions.RSET(S: string; N: integer): string;
var
  X: INTEGER;
begin
  X := LENGTH(S);
  if X < N then
    RSET := FILLSTR(' ', N - X) + S
  else
    RSET := COPY(S, 1, N);
end;

class function TFunctions.FILLSTR(C: Char; N: Integer): string;
var
  s: string;
begin
  if N < 0 then
    N := 0;
  Setlength(s, N);
  FillChar(s[1], N, C);
  FillStr := s;
end;

class function TFunctions.FirstCaseUpper(const vStr: string): string;
var
  n1: Integer;
begin
  if vStr = '' then
    Result := ''
  else
  begin
    Result := UpperCaseTr(vStr[1]);
    for n1 := 2 to Length(vStr) do
    begin
      if vStr[n1 - 1] = ' ' then
        Result := Result + UpperCaseTr(vStr[n1])
      else
        Result := Result + LowerCaseTr(vStr[n1]);
    end;
  end;
end;

class function TFunctions.LSet(st: string): string;
var
//  ch:char;
  bCon: boolean;
  i: integer;
begin
  i := 0;
  bCon := FALSE;
  repeat
    i := i + 1;
    if (i > Length(st)) or (Copy(st, i, 1) <> ' ') then
      bCon := TRUE;
  until bCon;
  Delete(st, 1, i - 1);
  LSet := st;
end;

class function TFunctions.FloatKeyControl2(Sender: TObject; Key: Char): Char;
begin
  if not CharInSet(Key, [#8, '0'..'9', FormatSettings.DecimalSeparator]) then
  begin
    Key := #0; //sadece sayý ve virgülle backspace kabul et
  end
  else if (Key = FormatSettings.DecimalSeparator) and (Pos(Key, TStringGrid(Sender).Cells[TStringGrid(Sender).Col, TStringGrid(Sender).Row]) > 0) then
  begin
    Key := #0; //ikinci virgülü alma
  end
  else if (Key = FormatSettings.DecimalSeparator) and (Length(TStringGrid(Sender).Cells[TStringGrid(Sender).Col, TStringGrid(Sender).Row]) = 0) then
  begin
    Key := #0; //, ile baþlatma
  end;
  Result := Key;
end;

class function TFunctions.LastPos(const SubStr: string; const strData: string): Integer;
begin
  Result := Pos(ReverseString(SubStr), ReverseString(strData));

  if (Result <> 0) then
    Result := ((Length(strData) - Length(SubStr)) + 1) - Result + 1;
end;

class function TFunctions.isAltDown: Boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[VK_MENU] and 128) <> 0);
end;

class function TFunctions.isCtrlDown: Boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[VK_CONTROL] and 128) <> 0);
end;

class function TFunctions.isShiftDown: Boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[VK_SHIFT] and 128) <> 0);
end;

class function TFunctions.GetMikroRaporTarihFormat(tarih: TDateTime): string;
begin
  if tarih <> 0 then
    Result := StringReplace(DateToStr(tarih), '.', '', [rfReplaceAll])
  else
    Result := '';
end;

class function TFunctions.FileToByteArray(const FileName: WideString): TArray<Byte>;
const
  BLOCK_SIZE = 1024;
var
  BytesRead, BytesToWrite, Count: integer;
  F: file of Byte;
  pTemp: Pointer;
begin
  AssignFile(F, FileName);
  Reset(F);
  try
    Count := FileSize(F);
    SetLength(Result, Count);
    pTemp := @Result[0];
    BytesRead := BLOCK_SIZE;
    while (BytesRead = BLOCK_SIZE) do
    begin
      BytesToWrite := Min(Count, BLOCK_SIZE);
      BlockRead(F, pTemp^, BytesToWrite, BytesRead);
      pTemp := Pointer(LongInt(pTemp) + BLOCK_SIZE);
      Count := Count - BytesRead;
    end;
  finally
    CloseFile(F);
  end;
end;

{$IFDEF MSWINDOWS}
class function TFunctions.GetFileSize(pFileName: string): Int64;
var
  vSearchRec: TSearchRec;
begin
{$WARN SYMBOL_PLATFORM OFF}
  //SearchRec.Size property works, but only for files less than 2GB
  if FindFirst(pFileName, faAnyFile, vSearchRec) = 0 then
    Result := Int64(vSearchRec.FindData.nFileSizeHigh) shl Int64(32) + Int64(vSearchRec.FindData.nFileSizeLow)
  else
    Result := 0;
  FindClose(vSearchRec);
{$WARN SYMBOL_PLATFORM ON}
end;
{$ENDIF MSWINDOWS}

class procedure TFunctions.ByteArrayToFile(const ByteArray: TBytes; const FileName: string);
var
  Count: Integer;
  F: file of Byte;
  pTemp: Pointer;
begin
  AssignFile(F, FileName);
  Rewrite(F);
  try
    Count := Length(ByteArray);
    pTemp := @ByteArray[0];
    BlockWrite(F, pTemp^, Count);
  finally
    CloseFile(F);
  end;
end;

class function TFunctions.UpperCaseTr(S: string): string;
begin
  Result := AnsiUpperCase(StringReplace(StringReplace(S, 'ý', 'I', [rfReplaceAll]), 'i', 'Ý', [rfReplaceAll]));
end;

class function TFunctions.LowerCaseTr(S: string): string;
begin
  Result := AnsiLowerCase(StringReplace(StringReplace(S, 'I', 'ý', [rfReplaceAll]), 'Ý', 'i', [rfReplaceAll]));
end;

class function TFunctions.BoolToStr(pBool: Boolean): string;
begin
  Result := IfThen(pBool, 'TRUE', 'FALSE');
end;

class function TFunctions.GetStrHashSHA512(Str: string): string;
var
  HashSHA: THashSHA2;
begin
  HashSHA := THashSHA2.Create;
  HashSHA.GetHashString(Str);
  Result := HashSHA.GetHashString(Str, SHA512);
end;

class function TFunctions.GetFileHashSHA512(FileName: WideString): string;
var
  HashSHA: THashSHA2;
  Stream: TStream;
  Readed: Integer;
  Buffer: PByte;
  BufLen: Integer;
begin
  HashSHA := THashSHA2.Create(SHA512);
  BufLen := 16 * 1024;
  Buffer := AllocMem(BufLen);
  try
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      while Stream.Position < Stream.Size do
      begin
        Readed := Stream.Read(Buffer^, BufLen);
        if Readed > 0 then
        begin
          HashSHA.update(Buffer^, Readed);
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeMem(Buffer)
  end;
  Result := HashSHA.HashAsString;
end;

class function TFunctions.GetStrFromHashSHA512(pString: WideString): string;
var
  HashSHA: THashSHA2;
begin
  HashSHA := THashSHA2.Create(SHA512);
  HashSHA.Update(pString);
  Result := HashSHA.GetHashString(pString);
end;

class function TFunctions.EncryptStr(const S: WideString; Key: Word): string;
var
  n1: Integer;
  vRStr: RawByteString;
  vRStrB: TBytes absolute vRStr;
begin
  Result := '';
  vRStr := UTF8Encode(S);
  for n1 := 0 to Length(vRStr) - 1 do
  begin
    vRStrB[n1] := vRStrB[n1] xor (Key shr 8);
    Key := (vRStrB[n1] + Key) * CKEY1 + CKEY2;
  end;

  for n1 := 0 to Length(vRStr) - 1 do
    Result := Result + IntToHex(vRStrB[n1], 2);
end;

class function TFunctions.DecryptStr(const S: string; Key: Word): string;
var
  n1, vTmpKey: Integer;
  vRStr: RawByteString;
  vRStrB: TBytes absolute vRStr;
  vTmpStr: string;
begin
  vTmpStr := UpperCase(S);
  SetLength(vRStr, Length(vTmpStr) div 2);
  n1 := 1;
  try
    while (n1 < Length(vTmpStr)) do
    begin
      vRStrB[n1 div 2] := StrToInt('$' + vTmpStr[n1] + vTmpStr[n1 + 1]);
      Inc(n1, 2);
    end;
  except
    Result := '';
    Exit;
  end;

  for n1 := 0 to Length(vRStr) - 1 do
  begin
    vTmpKey := vRStrB[n1];
    vRStrB[n1] := vRStrB[n1] xor (Key shr 8);
    Key := (vTmpKey + Key) * CKEY1 + CKEY2;
  end;

  Result := UTF8ToString(vRStr);
end;

class function TFunctions.FTPDosyaAl(pSrcFile, pDesFile: TFileName; pFtp, pRemoteDir, pLogin, pPass: string): Boolean;
var
  vFtp: TIdFTP;
  vIDAntiFreeze: TIDAntiFreeze;
begin
  //uses IdFTP, IdFTPCommon, IdAntiFreeze

  vFtp := TIdFTP.Create(nil);
  vIDAntiFreeze := TIDAntiFreeze.Create(nil); // büyük dosyalar inerken donma olmasýn
  try
    Result := False;
    vFtp.Host := pFtp;
    vFtp.Username := pLogin;
    vFtp.Password := pPass;
    vFtp.Passive := True;
    vFtp.Connect;

    if vFtp.Connected then
    begin
      vFtp.ChangeDir(pRemoteDir);
      try
        vFtp.TransferType := ftBinary;
        vFtp.Get(pSrcFile, pDesFile, True);
      finally
        Result := True;
      end;
      vFtp.Disconnect;
    end;
  finally
    //free edilme olayý test edilmedi
    vFtp.Free;
    vIDAntiFreeze.Free;
  end;

//kullaným örnek
{
  //baþarý ile ftp alýrsa
  if TSpecialFunctions.FTPDosyaAl('vsd.jpg', 'c:\vsd.jpg', 'ftp.aybey.com', 'public_html/uploads/', 'u8264876@aybey.com', 'BmAe1993_') then
  begin
    //dosya baþaralý bir þekilde indikten sonra yapýlacak olan iþlemler
  end;
}
end;

class function TFunctions.GetHWndByProgramName(const APName: string): THandle;
// Get Window Handle By ProgramName (Include Path or Not Include)
begin
  Result := GetHWndByPID(GetPIDByProgramName(APName));
end;

class function TFunctions.GetProcessHndByHWnd(const hWnd: THandle): THandle;
// Get Process Handle By Window Handle
var
  PID: DWORD;
  AhProcess: THandle;
begin
  if hWnd <> 0 then
  begin
    GetWindowThreadProcessID(hWnd, @PID);
    AhProcess := OpenProcess(PROCESS_ALL_ACCESS, false, PID);
    Result := AhProcess;
    CloseHandle(AhProcess);
  end
  else
    Result := 0;
end;

class function TFunctions.GetProcessHndByPID(const hAPID: THandle): THandle;
// Get Process Handle By Process ID
var
  AhProcess: THandle;
begin
  if hAPID <> 0 then
  begin
    AhProcess := OpenProcess(PROCESS_ALL_ACCESS, false, hAPID);
    Result := AhProcess;
    CloseHandle(AhProcess);
  end
  else
    Result := 0;
end;

class function TFunctions.GetPIDByHWnd(const hWnd: THandle): THandle;
// Get Window Handle By ProcessID
var
  PID: DWORD;
begin
  if hWnd <> 0 then
  begin
    GetWindowThreadProcessID(hWnd, @PID);
    Result := PID;
  end
  else
    Result := 0;
end;

class function TFunctions.GetHWndByPID(const hPID: THandle): THandle;
// Get Window Handle By ProcessID
type
  PEnumInfo = ^TEnumInfo;

  TEnumInfo = record
    ProcessID: DWORD;
    hWnd: THandle;
  end;

  function EnumWindowsProc(Wnd: DWORD; var EI: TEnumInfo): Bool; stdcall;
  var
    PID: DWORD;
  begin
    GetWindowThreadProcessID(Wnd, @PID);
    Result := (PID <> EI.ProcessID) or (not IsWindowVisible(Wnd)) or (not IsWindowEnabled(Wnd));
    if not Result then
      EI.HWND := Wnd; //break on return FALSE
  end;

  function FindMainWindow(PID: DWORD): DWORD;
  var
    EI: TEnumInfo;
  begin
    EI.ProcessID := PID;
    EI.HWND := 0;
    EnumWindows(@EnumWindowsProc, Integer(@EI));
    Result := EI.HWND;
  end;

begin
  if hPID <> 0 then
    Result := FindMainWindow(hPID)
  else
    Result := 0;
end;

class function TFunctions.GetPIDByProgramName(const APName: string): THandle;
// Get ProcessID By ProgramName (Include Path or Not Include)
var
  isFound: boolean;
  AHandle, AhProcess: THandle;
  ProcessEntry32: TProcessEntry32;
  APath: array[0..MAX_PATH] of char;
begin
  Result := 0;
  AHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    ProcessEntry32.dwSize := Sizeof(ProcessEntry32);
    isFound := Process32First(AHandle, ProcessEntry32);
    while isFound do
    begin
      AhProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, false, ProcessEntry32.th32ProcessID);
      GetModuleFileName(AhProcess, @APath[0], sizeof(APath));
      //GetModuleFileNameEx(AhProcess, 0, @APath[0], sizeof(APath));
      if (UpperCase(StrPas(APath)) = UpperCase(APName)) or (UpperCase(StrPas(ProcessEntry32.szExeFile)) = UpperCase(APName)) then
      begin
        Result := ProcessEntry32.th32ProcessID;
        break;
      end;
      isFound := Process32Next(AHandle, ProcessEntry32);
      CloseHandle(AhProcess);
    end;
  finally
    CloseHandle(AHandle);
  end;
end;

class function TFunctions.GetPathFromPID(const PID: cardinal): string;
var
  hProcess: THandle;
  path: array[0..MAX_PATH - 1] of char;
begin
  hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, false, PID);
  if hProcess <> 0 then
  try
    if GetModuleFileNameEx(hProcess, 0, path, MAX_PATH) = 0 then
      RaiseLastOSError;
    result := path;
  finally
    CloseHandle(hProcess)
  end
  else
    RaiseLastOSError;
end;

class function TFunctions.getApplicationPath(const hnwd: HWND): string;
var
  PID: DWORD;
begin
  GetWindowThreadProcessID(hnwd, @PID);
  Result := TFunctions.GetPathFromPID(PID);
end;

function AppActivate(WindowHandle: hWnd): boolean; overload;
// Activate a window by its handle
begin
  try
    SendMessage(WindowHandle, WM_SYSCOMMAND, SC_HOTKEY, WindowHandle);
    SendMessage(WindowHandle, WM_SYSCOMMAND, SC_RESTORE, WindowHandle);
    result := SetForegroundWindow(WindowHandle);
  except
    on Exception do
      Result := false;
  end;
end;

end.

