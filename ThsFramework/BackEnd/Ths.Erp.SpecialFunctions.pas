unit Ths.Erp.SpecialFunctions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Types,
  Dialogs, StdCtrls, Strutils, ExtCtrls, DB, nb30, Grids;

type
  TRoundToRange = -37..37;

type
  TSpecialFunctions = class
    class function IsNumeric(const S: string):Boolean;

    class procedure TutarHesapla(const fiyat:double; const miktar:double; const iskontoOrani:double; const kdvOrani:double; Out tutar:double; out netFiyat:double; out iskontoTutar:double; out kdvTutar:double; out toplamTutar:double; ondalikli_hane:integer);

    class function SayiyiYaziyaCevir(Num : Double) : String;
    class function SayiyiYaziyaCevir2(tutar:double; tur:integer; tam_birim:string='TL'; ondalikli_birim:string='KRÞ'):string;
    class function VirguldenSonraHaneSayisi(deger:double; hanesayisi:integer):string;
    class function GetMACAddress: TStringList;
    class function GetAdapterInfo(Lana: AnsiChar): String;
    class function CountNumOfCharacter(s: string; delimeter:string):integer;
    class function FloatKeyControl2(Sender:TObject; Key:Char):Char;
    class function GetSimdikiTarih(date_now:TDate):TStringList;

    class function LastPos(const SubStr: String; const strData: String): Integer;

    class function isAltDown():Boolean;
    class function isCtrlDown():Boolean;
    class function isShiftDown():Boolean;

    class function GetMikroRaporTarihFormat(tarih : TDateTime):string;

    class function CLEN(S:string; N:integer):string;
    class function FILLSTR(C : Char; N :Integer):string;
    class function RSET(S :string; N: integer):string;
    class function LSET(ST:STRING):STRING;

    class function FileToByteArray(const FileName: WideString): TArray<Byte>;
    class procedure ByteArrayToFile(const ByteArray: TBytes; const FileName: string);

    class function UpperCaseTr(S:String):String;
    class function myBoolToStr(pBool: Boolean): string;

    class function AddLineBreak(pCount: Integer = 1): string;
    class function CustomMsgDlg(const pMsg: string; pDlgType: TMsgDlgType;
      pButtons: TMsgDlgButtons; pCaptions: array of string;
      pDefaultButton:TMsgDlgBtn;
      pCustomTitle: string = ''): Integer;
  private
    { Private declarations }
  public
    //
  end;

implementation

uses
  Math;

class function TSpecialFunctions.IsNumeric(const S: string):Boolean;
begin
  Result := True;
  try
    StrToInt(S);
  except
    Result := False;
  end;
end;

class procedure TSpecialFunctions.TutarHesapla(const fiyat:double; const miktar:double; const iskontoOrani:double; const kdvOrani:double; Out tutar:double; out netFiyat:double; out iskontoTutar:double; out kdvTutar:double; out toplamTutar:double; ondalikli_hane:integer);
begin
  tutar         := miktar * fiyat;
  netFiyat      := fiyat * (100.0 - iskontoOrani) / 100.0;
  iskontoTutar  := (tutar * iskontoOrani) / 100.0;
  kdvTutar      := (netFiyat * miktar * kdvOrani) / 100.0;
  toplamTutar   := (netFiyat * miktar ) + kdvTutar;
end;

class function TSpecialFunctions.SayiyiYaziyaCevir(Num: Double): string;
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
    I := 1;
    J := Length(S) mod 3;
    if J = 0 then
    begin
      J := 3;
      N := Length(S) div 3 - 1;
    end
    else
      N := Length(S) div 3;

    while i < Length(S) do
    begin
      Nm := StrToInt(Copy(S, I, J));

      if (Nm = 1) and (N = 1) then
      begin
        Nm := 0;
        Sn := Sn + SmallNum(Nm) + Diger[N];
      end;

      if Nm <> 0 then
        Sn := Sn + SmallNum(Nm) + Diger[N];

      I := I + J;
      J := 3;
      N := N - 1;
    end;
  end;
  Result := Sn;
end;

class function TSpecialFunctions.SayiyiYaziyaCevir2(tutar: double; tur: integer; tam_birim: string = 'TL'; ondalikli_birim: string = 'KRÞ'): string;
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

class function TSpecialFunctions.VirguldenSonraHaneSayisi(deger: double; hanesayisi: integer): string;
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

class function TSpecialFunctions.GetAdapterInfo(Lana: AnsiChar):String;
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
  Result :=
    IntToHex(Byte(Adapter.adapter_address[0]), 2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[1]), 2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[2]), 2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[3]), 2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[4]), 2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[5]), 2);
end;

class function TSpecialFunctions.GetMACAddress: TStringList;
var
  AdapterList: TLanaEnum;
  NCB: TNCB;
  nIndex:integer;
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

class function TSpecialFunctions.CountNumOfCharacter(s: string; delimeter:string):integer;
var
  i,nFind : integer;
  letter : string;
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

class function TSpecialFunctions.GetSimdikiTarih(date_now: TDate): TStringList;
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
class function TSpecialFunctions.CLEN(S: string; N: INTEGER): string;
var
  X: integer;
begin
  X := LENGTH(S);
  if X < N then
    CLEN := S + FILLSTR(' ', N - X)
  else
    CLEN := COPY(S, 1, N);
end;

class function TSpecialFunctions.RSET(S: string; N: integer): string;
var
  X: INTEGER;
begin
  X := LENGTH(S);
  if X < N then
    RSET := FILLSTR(' ', N - X) + S
  else
    RSET := COPY(S, 1, N);
end;

class function TSpecialFunctions.FILLSTR(C : Char; N :Integer):string;
var
  s:string;
begin
  if N < 0 then
    N := 0;
  Setlength(s, n);
  FillChar(S[1],N,C);
  FillStr:= s;
end;

class function TSpecialFunctions.LSet(st:string):string;
var
//  ch:char;
  bCon:boolean;
  i:integer;
begin
  I:=0;
  bCon:=FALSE;
  repeat
    I:=I+1;
    if (I>Length(st)) or (Copy(st,I,1)<>' ') then
      bCon:=TRUE;
  until bCon;
  Delete(st,1,I-1);
  LSet:=st;
end;

class function TSpecialFunctions.FloatKeyControl2(Sender:TObject; Key:Char):Char;
begin
  if not CharInSet(Key, [#8, '0'..'9', FormatSettings.DecimalSeparator]) then
  begin
    Key := #0; //sadece sayý ve virgülle backspace kabul et
  end
  else
  if (Key = FormatSettings.DecimalSeparator)
  and (Pos(Key, TStringGrid(Sender).Cells[TStringGrid(Sender).Col, TStringGrid(Sender).Row]) > 0) then
  begin
    Key := #0; //ikinci virgülü alma
  end
  else
  if (Key = FormatSettings.DecimalSeparator)
  and (Length(TStringGrid(Sender).Cells[TStringGrid(Sender).Col, TStringGrid(Sender).Row]) = 0) then
  begin
    Key := #0; //, ile baþlatma
  end;
  Result := Key;
end;

class function TSpecialFunctions.LastPos(const SubStr: String; const strData: String): Integer;
begin
  Result := Pos(ReverseString(SubStr), ReverseString(strData)) ;

  if (Result <> 0) then
    Result := ((Length(strData) - Length(SubStr)) + 1) - Result + 1;
end;

class function TSpecialFunctions.isAltDown : Boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[VK_MENU] and 128)<>0);
end;

class function TSpecialFunctions.isCtrlDown : Boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[VK_CONTROL] and 128)<>0);
end;

class function TSpecialFunctions.isShiftDown : Boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[VK_SHIFT] and 128)<>0);
end;

class function TSpecialFunctions.GetMikroRaporTarihFormat(tarih : TDateTime):string;
begin
  if tarih <> 0 then
    Result := StringReplace(DateToStr(tarih), '.', '', [rfReplaceAll])
  else
    Result := '';
end;

class function TSpecialFunctions.FileToByteArray(const FileName: WideString): TArray<Byte>;
const BLOCK_SIZE = 1024;
var   BytesRead, BytesToWrite, Count : integer;
      F : File of Byte;
      pTemp : Pointer;
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
      Count := Count-BytesRead;
    end;
  finally
    CloseFile(F);
  end;
end;

class function TSpecialFunctions.AddLineBreak(pCount: Integer): string;
var
  nIndex: Integer;
begin
  for nIndex := 0 to pCount do
    Result := Result + sLineBreak;
end;

class procedure TSpecialFunctions.ByteArrayToFile(const ByteArray: TBytes; const FileName: string);
var Count : Integer;
    F : File of Byte;
    pTemp : Pointer;
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

class function TSpecialFunctions.UpperCaseTr(S:String):String;
begin
  Result := AnsiUpperCase(StringReplace(StringReplace(S,'ý','I',[rfReplaceAll]),'i','Ý',[rfReplaceAll]));
end;

class function TSpecialFunctions.myBoolToStr(pBool: Boolean): string;
begin
  Result := IfThen(pBool, 'TRUE', 'FALSE');
end;

class function TSpecialFunctions.CustomMsgDlg(const pMsg: string;
  pDlgType: TMsgDlgType; pButtons: TMsgDlgButtons; pCaptions: array of string;
  pDefaultButton:TMsgDlgBtn;
  pCustomTitle: string = ''): Integer;
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
      if vCaptionIndex > High(pCaptions) then Break;
      { Give a new caption from our Captions array}
      { Schreibe Beschriftung entsprechend Captions array}
      vDlgButton.Caption := pCaptions[vCaptionIndex];
      Inc(vCaptionIndex);
    end;
  end;
  Result := vMsgDlg.ShowModal;
end;

end.

