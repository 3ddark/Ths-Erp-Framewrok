unit thsEdit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  Vcl.Controls, Vcl.Forms, Vcl.Graphics, Vcl.Dialogs, Vcl.StdCtrls,
  Winapi.Messages, System.StrUtils, Winapi.Windows;


const
  INDEX_TYPE_STRING        = 0;
  INDEX_TYPE_INTEGER       = 1;
  INDEX_TYPE_DOUBLE        = 2;
  INDEX_TYPE_MONEY         = 3;
  INDEX_TYPE_DATE          = 4;
  INDEX_TYPE_NUMERIC       = 5;

type
  TDataInputType = (dtString, dtNumeric, dtDate, dtInteger, dtFloat, dtMoney);

type
  TthsEdit = class(TEdit)
  private
    FOldBackColor         : TColor;
    FColorDefault         : TColor;
    FColorActive          : TColor;
    FColorRequiredData    : TColor;
    FAlignment            : TAlignment;
    FTabEnterKeyJump      : Boolean;
    FDataInputType        : TDataInputType;
    FCaseUpperTr          : Boolean;
    FSeparatorDecimal     : Char;
    FSeparatorDate        : Char;
    FSeparatorMoney       : Char;
    FSeparatorNumeric     : Char;
    FDecimalDigit         : Integer;
    FRequiredData         : Boolean;
    FDoTrim               : Boolean;
    FActiveYear           : Integer;
    FInfo                 : string;
    procedure SetSeparatorNumeric(const Value: Char);

    property OldBackColor : TColor read FOldBackColor write FOldBackColor;
    property ColorDefault : TColor read FColorDefault write FColorDefault;

    procedure SetAlignment(const Value: TAlignment);
    procedure SetDataInputType(const Value: TDataInputType);
    procedure SetCaseUpperTr(const Value: Boolean);
    procedure SetSeparatorDecimal(const Value: Char);
    procedure SetSeparatorDate(const Value: Char);
    procedure SetSeparatorMoney(const Value: Char);
    procedure SetDecimalDigit(const Value: Integer);
    procedure SetActiveYear(const Value: Integer);
    function GetActiveYear():Integer;

    function UpCaseTr(Key:Char):Char;
    function IntegerKeyControl(Key:Char):Char;
    function FloatKeyControl(Key:Char; nOndalikliHaneSayisi:Integer):Char;
    function MoneyKeyControl(Key:Char; nOndalikliHaneSayisi:Integer):Char;
    function DateKeyControl(Key:Char):Char;
    function NumerikKeyControl(Key:Char):Char;

    function ValidateDate():boolean;

    function DoubleToMoney(Money:Double; nDecimalDigit:Integer):string;
    function MoneyToDouble(Money:String):Double;

  protected
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure KeyPress(var Key: Char); override;

    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner:TComponent); override;
  published
    property thsAlignment            : TAlignment      read FAlignment             write SetAlignment;
    property thsColorActive          : TColor          read FColorActive           write FColorActive;
    property thsColorRequiredData    : TColor          read FColorRequiredData     write FColorRequiredData;
    property thsTabEnterKeyJump      : boolean         read FTabEnterKeyJump       write FTabEnterKeyJump;
    property thsDataInputType        : TDataInputType  read FDataInputType         write SetDataInputType;
    property thsCaseUpperTr          : boolean         read FCaseUpperTr           write SetCaseUpperTr;
    property thsSeparatorDecimal     : Char            read FSeparatorDecimal      write SetSeparatorDecimal;
    property thsSeparatorDate        : Char            read FSeparatorDate         write SetSeparatorDate;
    property thsSeparatorMoney       : Char            read FSeparatorMoney        write SetSeparatorMoney;
    property thsSeparatorNumeric     : Char            read FSeparatorNumeric      write SetSeparatorNumeric;
    property thsDecimalDigit         : Integer         read FDecimalDigit          write SetDecimalDigit;
    property thsRequiredData         : boolean         read FRequiredData          write FRequiredData;
    property thsDoTrim               : boolean         read FDoTrim                write FDoTrim;
    property thsActiveYear           : Integer         read GetActiveYear          write SetActiveYear;
    property thsInfo                 : string          read FInfo;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('thsComponentsSet', [TthsEdit]);
end;

procedure TthsEdit.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    if (FDataInputType=dtDate)
    or (FDataInputType=dtInteger)
    or (FDataInputType=dtFloat)
    or (FDataInputType=dtMoney)
    then
    begin
      FAlignment := taRightJustify;
    end;

    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TthsEdit.SetDataInputType(const Value: TDataInputType);
begin
  if FDataInputType <> Value then
  begin
    FDataInputType := Value;
  end;
end;

procedure TthsEdit.SetCaseUpperTr(const Value: Boolean);
begin
  if FCaseUpperTr <> Value then
  begin
    FCaseUpperTr := Value;
  end;
end;

procedure TthsEdit.SetSeparatorDecimal(const Value: Char);
var
  val : Char;
begin
  val := Value;
  if (val=' ') or (val='') then
    val := ',';

  if FSeparatorDecimal <> val then
    FSeparatorDecimal := val;
end;

procedure TthsEdit.SetSeparatorDate(const Value: Char);
var
  val : Char;
begin
  val := Value;
  if (val=' ') or (val='') then
    val := '.';

  if FSeparatorDate <> val then
    FSeparatorDate := val;
end;

procedure TthsEdit.SetSeparatorMoney(const Value: Char);
var
  val : Char;
begin
  val := Value;
  if (val=' ') or (val='') then
    val := '.';

  if FSeparatorDate <> val then
    FSeparatorDate := val;
end;


procedure TthsEdit.SetSeparatorNumeric(const Value: Char);
begin
  if FSeparatorNumeric <> Value then
    FSeparatorNumeric := Value;
end;

procedure TthsEdit.SetDecimalDigit(const Value: Integer);
begin
  if FDecimalDigit <> Value then
    FDecimalDigit := Value;
end;

procedure TthsEdit.SetActiveYear(const Value: Integer);
begin
  if FActiveYear <> Value then
    FActiveYear := Value;
end;

function TthsEdit.GetActiveYear():Integer;
begin
  Result := FActiveYear;
end;

procedure TthsEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);

var
  wYear, wMonth, wDay : Word;
begin
  inherited CreateParams(Params);

  with Params do
  begin
    Style := Style or Alignments[FAlignment];
  end;

  DecodeDate(Now, wYear, wMonth, wDay);
  if FActiveYear = 0 then
    SetActiveYear(wYear);
end;

constructor TthsEdit.Create(AOwner: TComponent);
begin
  inherited;

  FColorDefault := Color;

  FColorActive := clSkyBlue;

  FColorRequiredData := $00706CEC;

  FAlignment := taLeftJustify;

  FDataInputType := dtString;

  FTabEnterKeyJump := True;

  FCaseUpperTr := True;

  FSeparatorDecimal := ',';

  FSeparatorDate := '.';

  FSeparatorMoney := '.';

  FSeparatorNumeric := '-';

  FDecimalDigit := 2;

  SetActiveYear(thsActiveYear);

  FInfo := 'thunderSoft Edit Component';
end;

procedure TthsEdit.DoEnter;
begin
  OldBackColor  := Color;
  Color         := thsColorActive;

  if thsDataInputType = dtMoney then
  begin
    if Trim(Self.Text) <> '' then
    begin
      Self.Text := FloatToStr(MoneyToDouble(Self.Text));
      Self.SelStart := Length(Self.Text);
      Self.SelectAll;
    end;
  end;

  inherited;
end;

procedure TthsEdit.DoExit;
begin
  if (FRequiredData) and (Trim(Self.Text) = '') then
  begin
    Color := FColorRequiredData;
  end
  else
  begin
    if OldBackColor = FColorRequiredData then
      Color := ColorDefault
    else
      Color := OldBackColor;
  end;


  case FDataInputType of
    dtString:
    begin

    end;

    dtInteger:
    begin
    end;

    dtFloat:
    begin
      if Trim(Self.Text) <> '' then
      begin
        FloatKeyControl(#13, FDecimalDigit);
      end;
    end;

    dtMoney:
    begin
      if Trim(Self.Text) <> '' then
      begin
        Self.Text := DoubleToMoney(StrToFloat(Self.Text), thsDecimalDigit);
      end;

    end;

    dtDate:
    begin
      ValidateDate;
    end;

    dtNumeric:
    begin
      if (RightStr(Self.Text, 1)=thsSeparatorNumeric)
      or (RightStr(Self.Text, 1)=' ')
      then
        Self.Text := LeftStr(Self.Text, Length(Self.Text)-1);
    end;

  end;

  if FDoTrim then
  begin
    Self.Text := Trim(Self.Text);
  end;

  inherited;
end;

procedure TthsEdit.KeyPress(var Key: Char);
begin
  if FCaseUpperTr then
  begin
    Key := UpCaseTr(Key);
  end;

  case FDataInputType of
    dtString: ;

    dtInteger   : Key := IntegerKeyControl(Key);

    dtFloat     : Key := FloatKeyControl(Key, FDecimalDigit);

    dtMoney     : Key := MoneyKeyControl(Key, FDecimalDigit);

    dtDate      : Key := DateKeyControl(Key);

    dtNumeric   : Key := NumerikKeyControl(Key);
  end;


  inherited KeyPress(Key);


  if FTabEnterKeyJump AND (Owner is TWinControl) then
  begin
    if Key = Char(vkReturn) then
    begin
      Key := #0;
     if HiWord(GetKeyState(vkShift)) <> 0 then
        PostMessage((Owner as TWinControl).Handle, WM_NEXTDLGCTL, 1, 0)
     else
        PostMessage((Owner as TWinControl).Handle, WM_NEXTDLGCTL, 0, 0);
    end;
  end;
end;

function TthsEdit.UpCaseTr(Key:Char):Char;
begin
  if Key = 'ý' then
    Key := 'I'
  else if Key = 'ð' then
    Key := 'Ð'
  else if Key = 'ü' then
    Key := 'Ü'
  else if Key = 'þ' then
    Key := 'Þ'
  else if Key = 'i' then
    Key := 'Ý'
  else if Key = 'ö' then
    Key := 'Ö'
  else if Key = 'ç' then
    Key := 'Ç'
  else
    Key := UpCase(Key);

  Result := Key;
end;

function TthsEdit.IntegerKeyControl(Key:Char):Char;
begin
  if not CharInSet(Key, [#13, #8, '0'..'9']) then
  begin
    Key := #0;
  end;

  Result := Key;
end;

function TthsEdit.DateKeyControl(Key:Char):Char;
begin
  if CharInSet(Key, ['/', '.', ',', FSeparatorDate]) then
    Key := FSeparatorDate;

  if  (Length(Self.Text) = Self.SelLength)
  and CharInSet(Key, ['0'..'9', #8, FSeparatorDate])
  then
  begin
    Self.Clear;
  end;

  if (not CharInSet(Key, [#13, #8, '0'..'9', FSeparatorDate]))
  or ((Length(Self.Text) = 0) and ((Key = FSeparatorDate)))
  then
  begin
    Key := #0;
  end;

  Result := Key;
end;

function TthsEdit.NumerikKeyControl(Key:Char):Char;
var
  strData: string;
begin
  if (not CharInSet(Key, [#13, #8, '0'..'9', FSeparatorNumeric])) then
  begin
    Key := #0; //sadece sayi, bosluk, backspace ve enter kabul et
  end;

  if (Length(Self.Text)=0) and (Key=FSeparatorNumeric) then
    Key := #0;

  strData := Self.Text;

  //son karakter separator ise ve gelen karakterde separator ise tusu sil
  if  (RightStr(strData, 1)=FSeparatorNumeric)
  and (Key = FSeparatorNumeric)
  then
    Key := #0;

  if (RightStr(strData, 1) = Key) and (Key = '-') then
    Key := #0;

  Result := Key;
end;

function TthsEdit.FloatKeyControl(Key:Char; nOndalikliHaneSayisi:Integer):Char;
var
  strList: TStringList;
  strPrevious, strIntegerPart, strDecimalPart: string;
begin
  Result := #0;

  if (CharInSet(Key, ['.', ',', FSeparatorDecimal])) then
    Key := FSeparatorDecimal;

  if CharInSet(Key, [#8, '0'..'9', FSeparatorDecimal]) then
    Self.Modified := true;

  //Tamamini secip yazarsa eski bilgiyi temizle
  if  (Length(Self.Text) = Self.SelLength)
  and (CharInSet(Key, [#8, '0'..'9', FSeparatorDecimal]))
  then
    Self.Clear;

  //Aradan bilgi girilemez
  if (Length(Self.Text) > Self.SelStart)
  and (Key <> #13)
  then
    Key := #0;

  //tanimli tuslar harici tuslar girilmez veya seperator sadece bir kere girilebilir
  if (not CharInSet(Key, [#13, #8, '0'..'9', FSeparatorDecimal])) then
    Key := #0
  else if (Key=FSeparatorDecimal) and (Pos(Key, Self.Text) > 0) then
    Key := #0;


//  if Key <> #0 then
  begin
    strPrevious := Self.Text;


    if (Length(strPrevious) = 0) then //daha once hic veri girilmediyse
    begin
      //0 veya seperator ise once 0 karakterini ekle
      if CharInSet(Key, ['0', FSeparatorDecimal]) then
        Self.Text := '0';


      if (CharInSet(Key, [#13, FSeparatorDecimal, '1'..'9']))
      then
        Result := Key
      else if Key = '0' then    //o karakterine basildiysa seperatoru ekle
        Result := FSeparatorDecimal;
    end
    else if (Length(strPrevious) > 0) then  //daha once bir veri girildiyse
    begin
      if (Pos(FSeparatorDecimal, Self.Text) > 0) then //seperator daha once girildiyse
      begin
        strList := TStringList.Create;
        try
          Assert(Assigned(strList)) ;
          strList.Clear;
          strList.Delimiter := FSeparatorDecimal;
          strList.DelimitedText := strPrevious;

          strIntegerPart := strList[0];
          strDecimalPart := strList[1];

          if (Length(strDecimalPart) < nOndalikliHaneSayisi) then
          begin

            if (Key = #13) then
            begin
              if (Length(strDecimalPart)=0) then
              begin
                Self.Text := Self.Text + '00';
              end
              else
              if (Length(strDecimalPart)=1) then
              begin
                Self.Text := Self.Text + '0';
              end;
            end;

            Result := Key;
          end
          else
          begin
            if (Key = #13) or (Key = #8) then
              Result := Key;
          end;

        finally
          strList.Destroy;
        end;

      end
      else  //seperator girilmemisse
      begin
        if (Key = #13) then
        begin
          Self.Text := Self.Text + FSeparatorDecimal + '00';
        end;
        Result := Key;
      end;

    end;
    Self.SelStart := Length(Self.Text);
  end;
end;

function TthsEdit.ValidateDate():boolean;
var
  strGun,strAy,strYil, strTarih : string;
begin
  Result := True;
  try
    strTarih := Self.Text;
    if Length(strTarih) < 4 then
    begin
      if Length(strTarih) = 1 then
      begin
        strGun := LeftStr(strTarih, 1);
      end;

      if Length(strTarih) = 2 then
      begin
        strGun := LeftStr(strTarih, 2);
      end;

      if Length(strTarih) = 3 then
      begin
        strAy  := strTarih[3];
      end;
    end
    else
    if Length(strTarih) = 4 then
    begin
      if Pos(FSeparatorDate, strTarih) = 0 then
      begin
        strGun := LeftStr(strTarih, 2);
        strAy  := RightStr(strTarih, 2);
        strYil := IntToStr(GetActiveYear);
      end;
    end
    else if Length(strTarih) = 5 then
    begin
      if Pos(FSeparatorDate, strTarih) > 0 then
      begin
        strGun := LeftStr(strTarih, 2);
        strAy  := RightStr(strTarih, 2);
        strYil := IntToStr(GetActiveYear);
      end;
    end
    else if Length(strTarih) = 6 then
    begin
      if Pos(FSeparatorDate, strTarih) = 0 then
      begin
        strGun := LeftStr(strTarih, 2);
        strAy  := strTarih[3] + strTarih[4];
        strYil := LeftStr(IntToStr(GetActiveYear), 2) + RightStr(strTarih, 2);
      end;
    end
    else if Length(strTarih) = 8 then
    begin
      if Pos(FSeparatorDate, strTarih) = 0 then
      begin
        strGun := LeftStr(strTarih, 2);
        strAy  := strTarih[3] + strTarih[4];
        strYil := RightStr(strTarih, 4);
      end
      else
      if Pos(FSeparatorDate, strTarih) > 0 then
      begin
        strGun := LeftStr(strTarih, 2);
        strAy  := strTarih[4] + strTarih[5];
        strYil := LeftStr(IntToStr(GetActiveYear), 2) + RightStr(strTarih, 2);
      end
    end
    else
    if Length(strTarih) = 10 then
    begin
      if Pos(FSeparatorDate, strTarih) > 0 then
      begin
        strGun := LeftStr(strTarih, 2);
        strAy  := strTarih[4] + strTarih[5];
        strYil := RightStr(strTarih, 4);
      end
    end;


    if (Length(strGun)>0) or (Length(strAy)>0) then
    begin
      strTarih := strGun + FSeparatorDate + strAy + FSeparatorDate + strYil;
      EncodeDate(StrToInt(strYil), strtoint(strAy), strtoint(strGun));
      Self.Text := strTarih;
    end;


  except
    Self.SelStart := Length(Self.Text);
    Self.SetFocus;
    Raise Exception.Create('Hatalu tarih giriþi');
  end;

end;

function TthsEdit.MoneyKeyControl(Key:Char; nOndalikliHaneSayisi:Integer):Char;
var divided_string                                : TStringList;
    strPrevious, strIntegerPart, strDecimalPart   : String;
begin
  Result := #0;

  if (CharInSet(Key, ['.', ',', FSeparatorDecimal])) then
  begin
    Key := FSeparatorDecimal;
  end;

  if CharInSet(Key, [#8, '0'..'9', FSeparatorDecimal]) then
  begin
    Self.Modified := true;
  end;

  //TÃ¼mÃ¼nÃ¼ seÃ§ip yazarsa eski bilgiyi temizle
  if (Length(Self.Text) = Self.SelLength) and (CharInSet(Key, [#8, '0'..'9', FSeparatorDecimal])) then
    Self.Clear;

  //Aradan bilgi girilemez
  if (Length(Self.Text) > Self.SelStart) and (Key <> #13) then
    Key := #0;

  //tanimli tuslar harici tuslar girilmez veya seperator sadece bir kere girilebilir
  if not CharInSet(Key, [#13, #8, '0'..'9', FSeparatorDecimal]) then
  begin
    Key := #0;
  end
  else
  if (Key = FSeparatorDecimal) and (Pos(Key, Self.Text) > 0) then
  begin
    Key := #0;
  end;


  if Key <> #0 then
  begin
    strPrevious := Self.Text;

    if (Length(strPrevious) = 0) then
    begin
      if Key = #13 then
      begin
        Result := Key;
      end
      else
      if Key = '0' then
      begin
        Result := FSeparatorDecimal;
        Self.Text := '0';
      end
      else
      if Key = FSeparatorDecimal then
      begin
        Result := Key;
        Self.Text := '0';
      end
      else
      if CharInSet(Key, ['1'..'9']) then
      begin
        Result := Key;
      end;
    end
    else if (Length(strPrevious) > 0) then
    begin
      if (Pos(FSeparatorDecimal, Self.Text) > 0) then
      begin
        divided_string := TStringList.Create;
        try
          Assert(Assigned(divided_string)) ;
          divided_string.Clear;
          divided_string.Delimiter := FSeparatorDecimal;
          divided_string.DelimitedText := strPrevious;

          strIntegerPart := divided_string[0];
          strDecimalPart := divided_string[1];

          if (Length(strDecimalPart) < nOndalikliHaneSayisi) then
          begin

            if (Key = #13) then
            begin
              if (Length(strDecimalPart)=0) then
              begin
                Self.Text := Self.Text + '00';
              end
              else
              if (Length(strDecimalPart)=1) then
              begin
                Self.Text := Self.Text + '0';
              end;
            end;

            Result := Key;
          end
          else
          begin
            if (Key = #13) or (Key = #8) then
              Result := Key;
          end;

        finally
          divided_string.Destroy;
        end;

      end
      else
      begin
        if (Key = #13) then
        begin
          Self.Text := Self.Text + FSeparatorDecimal + '00';
        end;
        Result := Key;
      end;

    end;
    Self.SelStart := Length(Self.Text);
  end;
end;

function TthsEdit.DoubleToMoney(Money:Double; nDecimalDigit:Integer):string;
var
  strResult, strDecimalPart, strIntegerPart : String;
  divided_string  : TStringList;
begin
  divided_string := TStringList.Create();
  divided_string.Clear;

  strResult := Format('%.' + IntToStr(nDecimalDigit) + 'f', [Money]);


  Assert(Assigned(divided_string)) ;
  divided_string.Clear;
  divided_string.Delimiter := ',';
  divided_string.DelimitedText := strResult;


  if (divided_string.Count > 0) and (divided_string[0] <> '')then
    strIntegerPart := divided_string[0];
  if (divided_string.Count > 1) and (divided_string[1] <> '') then
    strDecimalPart := divided_string[1];
  if (strIntegerPart <> '') and (strIntegerPart <> '0') then
    strIntegerPart := FormatFloat('#.###,#', StrToFloat(strIntegerPart));

  if (divided_string.Count = 2) and (strIntegerPart <> '') then
    strResult := strIntegerPart + ',' + strDecimalPart
  else if (divided_string.Count = 1) and (strIntegerPart <> '') then
    strResult := strIntegerPart
  else
    strResult := DoubleToMoney(0, nDecimalDigit);
  Result := strResult;
end;

function TthsEdit.MoneyToDouble(Money:String):Double;
begin
  Result := StrToFloat(StringReplace(Money, '.', '', [rfReplaceAll]));
end;

end.
