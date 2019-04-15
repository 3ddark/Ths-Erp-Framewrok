unit Ths.Erp.Helper.Memo;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.Forms,
  Vcl.Graphics, Winapi.Messages, Winapi.Windows, System.StrUtils,
  Vcl.Themes, Vcl.Mask, Vcl.ExtCtrls, System.UITypes,
  Ths.Erp.Constants, Ths.Erp.Helper.BaseTypes;

{$M+}
type
  TMemoStyleHookColor = class(TMemoStyleHook)
  private
    procedure UpdateColors;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AControl: TWinControl); override;
  end;

type
  TMemo = class(Vcl.StdCtrls.TMemo)
  private
    FOldBackColor         : TColor;
    FColorDefault         : TColor;
    FColorActive          : TColor;
    FColorRequiredData    : TColor;
    FAlignment            : TAlignment;
    FEnterAsTabKey        : Boolean;
    FInputDataType        : TInputType;
    FSupportTRChars       : Boolean;
    FDecimalDigit         : Integer;
    FRequiredData         : Boolean;
    FDoTrim               : Boolean;
    FActiveYear           : Integer;
    FDBFieldName          : string;
    FInfo                 : string;
    FMesaj                : string;

    procedure SetAlignment(const pValue: TAlignment);

    function UpCaseTr(pKey: Char): Char;
    function LowCaseTr(pKey: Char): Char;
    function IntegerKeyControl(pKey: Char): Char;
    function FloatKeyControl(pKey: Char; pDecimalDigits: Integer): Char;
    function MoneyKeyControl(pKey: Char; pDecimalDigits: Integer): Char;
    function DateKeyControl(pKey: Char): Char;

    function ValidateDate():boolean;
  protected
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure KeyPress(var Key: Char); override;

    procedure CreateParams(var pParams: TCreateParams); override;
  public
    function LowCase(pKey: Char): Char;
    constructor Create(AOwner: TComponent); override;
    procedure Repaint();override;
    destructor Destroy; override;
  published
    property thsAlignment            : TAlignment      read FAlignment             write SetAlignment;
    property thsColorActive          : TColor          read FColorActive           write FColorActive;
    property thsColorRequiredData    : TColor          read FColorRequiredData     write FColorRequiredData;
    property thsTabEnterKeyJump      : Boolean         read FEnterAsTabKey         write FEnterAsTabKey;
    property thsInputDataType        : TInputType      read FInputDataType         write FInputDataType;
    property thsCaseUpLowSupportTr   : Boolean         read FSupportTRChars        write FSupportTRChars;
    property thsDecimalDigit         : Integer         read FDecimalDigit          write FDecimalDigit;
    property thsRequiredData         : Boolean         read FRequiredData          write FRequiredData;
    property thsDoTrim               : Boolean         read FDoTrim                write FDoTrim;
    property thsActiveYear           : Integer         read FActiveYear            write FActiveYear;
    property thsDBFieldName          : string          read FDBFieldName           write FDBFieldName;
    property thsInfo                 : string          read FInfo;
    property thsMesaj                : string          read FMesaj                 write FMesaj;
  end;

implementation

uses
  Vcl.Styles;

type
  TWinControlH = class(TWinControl);

constructor TMemoStyleHookColor.Create(AControl: TWinControl);
begin
  inherited;
  UpdateColors;
end;

procedure TMemoStyleHookColor.UpdateColors;
var
  vStyle: TCustomStyleServices;
begin
  if Control.ClassType = TMemo then
  begin
    if Control.Enabled then
    begin
      Brush.Color := TWinControlH(Control).Color;
      FontColor := TWinControlH(Control).Font.Color;

      Brush.Color := TMemo(Control).FColorDefault;
      if TMemo(Control).thsRequiredData then
        Brush.Color := TMemo(Control).FColorRequiredData;
      if TMemo(Control).Focused then
        Brush.Color := TMemo(Control).FColorActive;
    end
    else
    begin
      vStyle := StyleServices;
      Brush.Color := vStyle.GetStyleColor(scEditDisabled);
      FontColor := vStyle.GetStyleFontColor(sfEditBoxTextDisabled);

      Brush.Color := TMemo(Control).FColorDefault;
      if TMemo(Control).thsRequiredData then
        Brush.Color := TMemo(Control).FColorRequiredData;
      if TMemo(Control).Focused then
        Brush.Color := TMemo(Control).FColorActive;
    end;
  end
  else
    inherited;
end;

procedure TMemoStyleHookColor.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    CN_CTLCOLORMSGBOX..CN_CTLCOLORSTATIC:
      begin
        UpdateColors;
        SetTextColor(Message.WParam, ColorToRGB(FontColor));
        SetBkColor(Message.WParam, ColorToRGB(Brush.Color));
        Message.Result := LRESULT(Brush.Handle);
        Handled := True;
      end;
    CM_ENABLEDCHANGED:
      begin
        UpdateColors;
        Handled := False;
      end
  else
    inherited WndProc(Message);
  end;
end;

procedure TMemo.CreateParams(var pParams: TCreateParams);
const
  Alignments: array[TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
var
  vYear, vMonth, vDay: Word;
begin
  inherited CreateParams(pParams);

  with pParams do
  begin
    Style := Style or Alignments[FAlignment];
  end;

  DecodeDate(Now, vYear, vMonth, vDay);
  if FActiveYear = 0 then
    FActiveYear := vYear;
end;

constructor TMemo.Create(AOwner: TComponent);
var
  vDay, vMonth, vYear: Word;
  vDate: TDateTime;
begin
  inherited;
  Font.Name := DefaultFontName;
  vDate := Now;
  DecodeDate(vDate, vYear, vMonth, vDay);

  FColorDefault         := Color;
  FColorActive          := clSkyBlue;
  FColorRequiredData    := $00706CEC;
  FAlignment            := taLeftJustify;
  FInputDataType        := itString;
  FEnterAsTabKey        := True;
  FSupportTRChars       := True;
  FDecimalDigit         := 4;
  FRequiredData         := False;
  FDoTrim               := True;
  FActiveYear           := vYear;
  FDBFieldName          := '';
  FInfo                 := 'Ferhat Memo Component v0.1';
  FMesaj                := '';
end;

procedure TMemo.DoEnter;
begin
  FOldBackColor := Color;
  Color := thsColorActive;

  if thsInputDataType = itMoney then
  begin
    if Trim(Self.Text) <> '' then
    begin
      Self.Text := StringReplace(Self.Text, FormatSettings.ThousandSeparator, '', [rfReplaceAll]);
      Self.SelStart := Length(Self.Text);
    end;
  end;

  inherited;
end;

procedure TMemo.DoExit;
begin
  if (FRequiredData) and (Trim(Self.Text) = '') then
  begin
    Color := FColorRequiredData;
  end
  else
  begin
    if FOldBackColor = FColorRequiredData then
      Color := FColorDefault
    else
    begin
      if FOldBackColor = 0 then
        FOldBackColor := Color;
      Color := FOldBackColor;
    end;
  end;

  case thsInputDataType of
    itMoney: begin
      if (Trim(Self.Text) <> '') then
        Self.Text := FormatFloat(FormatSettings.ThousandSeparator +
                                 FormatSettings.DecimalSeparator +
                                 StringOfChar('0', Self.FDecimalDigit),
                                 StrToFloatDef(Self.Text,0));
    end;

    itDate: ValidateDate;
  end;

  if FDoTrim then
  begin
    Self.Text := Trim(Self.Text);
  end;

  inherited;
end;

procedure TMemo.KeyPress(var Key: Char);
begin
  if FInputDataType = itString then
  begin
    if CharCase = ecUpperCase then
    begin
      if FSupportTRChars then
        Key := UpCaseTr(Key);
    end
    else if CharCase = ecLowerCase then
    begin
      if FSupportTRChars then
        Key := LowCaseTr(Key);
    end;
  end;

  case FInputDataType of
    itInteger   : Key := IntegerKeyControl(Key);
    itFloat     : Key := FloatKeyControl(Key, FDecimalDigit);
    itMoney     : Key := MoneyKeyControl(Key, FDecimalDigit);
    itDate      : Key := DateKeyControl(Key);
  end;

  inherited KeyPress(Key);

  if FEnterAsTabKey AND (Owner is TWinControl) then
  begin
    if Key = Char(VK_RETURN) then
    begin
      Key := #0;
      if HiWord(GetKeyState(VK_SHIFT)) <> 0 then
        PostMessage((Owner as TWinControl).Handle, WM_NEXTDLGCTL, 1, 0)
      else
        PostMessage((Owner as TWinControl).Handle, WM_NEXTDLGCTL, 0, 0);
    end;
  end;
end;

function TMemo.UpCaseTr(pKey: Char): Char;
begin
  case pKey of
    'ý': pKey := 'I';
    'i': pKey := 'Ý';
    'ð': pKey := 'Ð';
    'ü': pKey := 'Ü';
    'þ': pKey := 'Þ';
    'ö': pKey := 'Ö';
    'ç': pKey := 'Ç';
  else
    pKey := UpCase(pKey);
  end;
  Result := pKey;
end;

function TMemo.LowCase(pKey: Char): Char;
begin
  Result := Char(Word(pKey) or $0020);
end;

function TMemo.LowCaseTr(pKey: Char): Char;
begin
  case pKey of
    'I': pKey := 'ý';
    'Ý': pKey := 'i';
    'Ð': pKey := 'ð';
    'Ü': pKey := 'ü';
    'Þ': pKey := 'þ';
    'Ö': pKey := 'ö';
    'Ç': pKey := 'ç';
  else
    pKey := LowCase(pKey);
  end;
  Result := pKey;
end;

function TMemo.IntegerKeyControl(pKey: Char): Char;
begin
  if not CharInSet(pKey, [#13{Enter}, #8{Backspace}, '0'..'9']) then
    pKey := #0;
  Result := pKey;
end;

function TMemo.DateKeyControl(pKey: Char): Char;
begin
  if (CharInSet(pKey, ['-', '/', '.', ',', FormatSettings.DateSeparator])) then
    pKey := FormatSettings.DateSeparator;

  if  (Length(Self.Text) = Self.SelLength) and (Self.ReadOnly = False)
  and (CharInSet(pKey, ['0'..'9', #8{Backspace}, FormatSettings.DateSeparator]))
  then
    Self.Clear;

  if not CharInSet(pKey, [#13{Return}, #8{Backspace}, '0'..'9', FormatSettings.DateSeparator])
  or ((Length(Self.Text) = 0) and ((pKey = FormatSettings.DateSeparator)))
  then
    pKey := #0;

  Result := pKey;
end;

destructor TMemo.Destroy;
begin
  inherited;
end;

procedure TMemo.Repaint;
begin
  if (FRequiredData) and (Trim(Self.Text) = '') then
  begin
    Color := FColorRequiredData;
  end
  else
  begin
    if FOldBackColor = FColorRequiredData then
      Color := FColorDefault
    else
    begin
      if FOldBackColor = 0 then
        FOldBackColor := Color;
      Color := FOldBackColor;
    end;
  end;

  inherited;
end;

procedure TMemo.SetAlignment(const pValue: TAlignment);
begin
  FAlignment := pValue;
end;

function TMemo.FloatKeyControl(pKey: Char; pDecimalDigits: Integer): Char;
var
  divided_string: TStringList;
  strPrevious, strIntegerPart, strDecimalPart: String;
begin
  Result := #0;

  if (CharInSet(pKey, ['.', ',', FormatSettings.DecimalSeparator])) then
  begin
    pKey := FormatSettings.DecimalSeparator;
  end;

  if CharInSet(pKey, [#8, '0'..'9', FormatSettings.DecimalSeparator]) then
  begin
    Self.Modified := true;
  end;

  //Tümünü seçip yazarsa eski bilgiyi temizle
  if (Length(Self.Text) = Self.SelLength) and (CharInSet(pKey, [#8, '0'..'9', FormatSettings.DecimalSeparator])) then
    Self.Clear;

  //Aradan bilgi girilemez
  if (Length(Self.Text) > Self.SelStart) and (pKey <> #13) then
    pKey := #0;

  //tanýmlý tuþlar harici tuþlar girilmez veya seperator sadece bir kere girilebilir
  if not CharInSet(pKey, [#13, #8, '0'..'9', FormatSettings.DecimalSeparator]) then
  begin
    pKey := #0;
  end
  else
  if (pKey = FormatSettings.DecimalSeparator) and (Pos(pKey, Self.Text) > 0) then
  begin
    pKey := #0;
  end;


  if pKey <> #0 then
  begin
    strPrevious := Self.Text;

    if (Length(strPrevious) = 0) then
    begin
      if pKey = #13 then
      begin
        Result := pKey;
      end
      else
      if pKey = '0' then
      begin
        Result := FormatSettings.DecimalSeparator;
        Self.Text := '0';
      end
      else
      if pKey = FormatSettings.DecimalSeparator then
      begin
        Result := pKey;
        Self.Text := '0';
      end
      else
      if CharInSet(pKey, ['1'..'9']) then
      begin
        Result := pKey;
      end;
    end
    else if (Length(strPrevious) > 0) then
    begin
      if (Pos(FormatSettings.DecimalSeparator, Self.Text) > 0) then
      begin
        divided_string := TStringList.Create;
        try
          Assert(Assigned(divided_string)) ;
          divided_string.Clear;
          divided_string.Delimiter := FormatSettings.DecimalSeparator;
          divided_string.DelimitedText := strPrevious;

          strIntegerPart := divided_string[0];
          strDecimalPart := divided_string[1];

          if (Length(strDecimalPart) < pDecimalDigits) then
          begin

            if (pKey = #13) then
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

            Result := pKey;
          end
          else
          begin
            if (pKey = #13) or (pKey = #8) then
              Result := pKey;
          end;

        finally
          divided_string.Destroy;
        end;

      end
      else
      begin
        if (pKey = #13) then
        begin
          Self.Text := Self.Text + FormatSettings.DecimalSeparator + '00';
        end;
        Result := pKey;
      end;

    end;
    Self.SelStart := Length(Self.Text);
  end;
end;

function TMemo.ValidateDate(): Boolean;
var
  vDay, vMonth, vYear, vDate: string;
begin
  Result := True;
  try
    vDate := Self.Text;
    if Length(vDate) < 4 then
    begin
      if Length(vDate) = 1 then
      begin
        vDay := LeftStr(vDate, 1);
      end;

      if Length(vDate) = 2 then
      begin
        vDay := LeftStr(vDate, 2);
      end;

      if Length(vDate) = 3 then
      begin
        vMonth  := vDate[3];
      end;
    end
    else
    if Length(vDate) = 4 then
    begin
      if Pos(FormatSettings.DateSeparator, vDate) = 0 then
      begin
        vDay := LeftStr(vDate, 2);
        vMonth  := RightStr(vDate, 2);
        vYear := IntToStr(FActiveYear);
      end;
    end
    else if Length(vDate) = 5 then
    begin
      if Pos(FormatSettings.DateSeparator, vDate) > 0 then
      begin
        vDay := LeftStr(vDate, 2);
        vMonth  := RightStr(vDate, 2);
        vYear := IntToStr(FActiveYear);
      end;
    end
    else if Length(vDate) = 6 then
    begin
      if Pos(FormatSettings.DateSeparator, vDate) = 0 then
      begin
        vDay := LeftStr(vDate, 2);
        vMonth  := vDate[3] + vDate[4];
        vYear := LeftStr(IntToStr(FActiveYear), 2) + RightStr(vDate, 2);
      end;
    end
    else if Length(vDate) = 8 then
    begin
      if Pos(FormatSettings.DateSeparator, vDate) = 0 then
      begin
        vDay := LeftStr(vDate, 2);
        vMonth  := vDate[3] + vDate[4];
        vYear := RightStr(vDate, 4);
      end
      else
      if Pos(FormatSettings.DateSeparator, vDate) > 0 then
      begin
        vDay := LeftStr(vDate, 2);
        vMonth  := vDate[4] + vDate[5];
        vYear := LeftStr(IntToStr(FActiveYear), 2) + RightStr(vDate, 2);
      end
    end
    else
    if Length(vDate) = 10 then
    begin
      if Pos(FormatSettings.DateSeparator, vDate) > 0 then
      begin
        vDay := LeftStr(vDate, 2);
        vMonth  := vDate[4] + vDate[5];
        vYear := RightStr(vDate, 4);
      end
    end;


    if (Length(vDay)>0) or (Length(vMonth)>0) then
    begin
      vDate := vDay + FormatSettings.DateSeparator + vMonth + FormatSettings.DateSeparator + vYear;
      EncodeDate(StrToInt(vYear), strtoint(vMonth), strtoint(vDay));
      Self.Text := vDate;
    end;

  except
    Self.SelStart := Length(Self.Text);
    Self.SetFocus;

    if FMesaj = '' then
      FMesaj := 'Hatalý tarih giriþi';
    Raise Exception.Create(FMesaj);
  end;
end;

function TMemo.MoneyKeyControl(pKey: Char; pDecimalDigits: Integer): Char;
var
  vDividedString: TStringList;
  vPrevious, vIntegerPart, vDecimalPart: string;
  vPosCursor, vPosDecimalSeparator: Integer;
begin
  Result := #0;

  if (CharInSet(pKey, ['.', ',', FormatSettings.DecimalSeparator])) then
    pKey := FormatSettings.DecimalSeparator;

  if CharInSet(pKey, [#8, '0'..'9', FormatSettings.DecimalSeparator]) then
    Self.Modified := true;

  //Already SelectAll clear
  if (Length(Self.Text) = Self.SelLength) and (pKey <> #13) then
    Self.Clear;

  //tanýmlý tuþlar harici tuþlar girilmez veya seperator sadece bir kere girilebilir
  if (pKey = FormatSettings.DecimalSeparator) and (Pos(pKey, Self.Text) > 0) then
    pKey := #0
  else if not CharInSet(pKey, [#13, #8, '0'..'9', FormatSettings.DecimalSeparator]) then
    pKey := #0;


  if pKey <> #0 then
  begin
    vPrevious := Self.Text;

    if (Length(vPrevious) = 0) then
    begin
      if pKey = #13 then
      begin
        Result := pKey;
      end
      else
      if pKey = '0' then
      begin
        Result := FormatSettings.DecimalSeparator;
        Self.Text := '0';
      end
      else
      if pKey = FormatSettings.DecimalSeparator then
      begin
        Result := pKey;
        Self.Text := '0';
      end
      else
      if CharInSet(pKey, ['1'..'9']) then
      begin
        Result := pKey;
      end;
    end
    else if (Length(vPrevious) > 0) then
    begin
      if (Pos(FormatSettings.DecimalSeparator, Self.Text) > 0) then
      begin
        vPosDecimalSeparator := Pos(FormatSettings.DecimalSeparator, Self.Text);
        vPosCursor := Self.SelStart;

        vDividedString := TStringList.Create;
        try
          Assert(Assigned(vDividedString));
          vDividedString.Clear;
          vDividedString.Delimiter := FormatSettings.DecimalSeparator;
          vDividedString.DelimitedText := vPrevious;

          vIntegerPart := vDividedString[0];
          vDecimalPart := vDividedString[1];

          if (Length(VDecimalPart) < pDecimalDigits) then
          begin
            if (pKey = #13) then
              Self.Text := Self.Text + StringOfChar('0', FDecimalDigit-Length(vDecimalPart));

            Result := pKey;
          end
          else
          begin
            if (vPosCursor <= vPosDecimalSeparator) then
              Result := pKey
            else
            begin
              if (pKey = #13) or (pKey = #8) then
                Result := pKey;
            end;
          end;

        finally
          vDividedString.Free;
        end;

      end
      else
      begin
        if (pKey = #13) then
        begin
          Self.Text := Self.Text + FormatSettings.DecimalSeparator + '00';
        end;
        Result := pKey;
      end;

    end;
    //Self.SelStart := Length(Self.Text);
  end;
end;

initialization
  TStyleManager.Engine.RegisterStyleHook(TMemo, TMemoStyleHookColor);
end.
