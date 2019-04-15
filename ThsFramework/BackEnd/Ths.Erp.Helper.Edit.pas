unit Ths.Erp.Helper.Edit;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.Forms,
  Vcl.Graphics, Winapi.Messages, Winapi.Windows, System.StrUtils,
  Vcl.Themes, Vcl.Mask, Vcl.ExtCtrls, System.UITypes,
  Ths.Erp.Constants,
  Ths.Erp.Helper.BaseTypes;

{$M+}

type
  TEditStyleHookColor = class(TEditStyleHook)
  private
    procedure UpdateColors;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AControl: TWinControl); override;
  published
    property OverridePaint;
  end;

type
  TEdit = class(Vcl.StdCtrls.TEdit)
  private
    FOnHelperProcess      : TNotifyEvent;
    FOnCalculatorProcess  : TNotifyEvent;
    FOldBackColor         : TColor;
    FColorDefault         : TColor;
    FColorActive          : TColor;
    FColorRequiredInput   : TColor;
    {$IFDEF VER150}
    FAlignment            : TAlignment;
    {$ENDIF}
    FEnterAsTabKey        : Boolean;
    FInputDataType        : TInputType;
    FDecimalDigitCount    : Integer;
    FRequiredData         : Boolean;
    FDoTrim               : Boolean;
    FActiveYear4Digit     : Integer;
    FDBFieldName          : string;
    FInfo                 : string;
    FWrongDateMessage     : string;

    {$IFDEF VER150}
    procedure SetAlignment(const pValue: TAlignment);
    {$ENDIF}

    function IntegerKeyControl(pKey: Char): Char;
    function FloatKeyControl(pKey: Char; pDecimalDigits: Integer): Char;
    function MoneyKeyControl(pKey: Char; pDecimalDigits: Integer): Char;
    function DateKeyControl(pKey: Char): Char;

    function ValidateDate():boolean;
    procedure SetHelperProcess(const Value: TNotifyEvent);
  protected
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure KeyPress(var Key: Char); override;
    procedure MyOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HelperProcess();virtual;
    procedure CalculatorProcess();virtual;

    procedure CreateParams(var pParams: TCreateParams); override;
  public
    property OnHelperProcess: TNotifyEvent read FOnHelperProcess write SetHelperProcess;
    property OnCalculatorProcess: TNotifyEvent read FOnCalculatorProcess write FOnCalculatorProcess;

    constructor Create(AOwner: TComponent); override;
    procedure Repaint();override;

    procedure WndProc(var Message: TMessage); override;

    procedure DoubleToMoney();
  published
    {$IFDEF VER150}
    property thsAlignment            : TAlignment      read FAlignment             write SetAlignment;
    {$ENDIF}
    property thsColorActive          : TColor          read FColorActive           write FColorActive;
    property thsColorRequiredInput   : TColor          read FColorRequiredInput    write FColorRequiredInput;
    property thsTabEnterKeyJump      : Boolean         read FEnterAsTabKey         write FEnterAsTabKey;
    property thsInputDataType        : TInputType      read FInputDataType         write FInputDataType;
    property thsDecimalDigitCount    : Integer         read FDecimalDigitCount     write FDecimalDigitCount;
    property thsRequiredData         : Boolean         read FRequiredData          write FRequiredData;
    property thsDoTrim               : Boolean         read FDoTrim                write FDoTrim;
    property thsActiveYear4Digit     : Integer         read FActiveYear4Digit      write FActiveYear4Digit;
    property thsDBFieldName          : string          read FDBFieldName           write FDBFieldName;
    property thsInfo                 : string          read FInfo;
    property thsWrongDateMessage     : string          read FWrongDateMessage      write FWrongDateMessage;

    function toMoneyToDouble(): Double;
  end;

  procedure DrawHelperSing(Sender: TEdit);

implementation

uses
    Vcl.Styles
  {$IFDEF THSERP}, ufrmBaseInputDB{$ENDIF}
  ;

type
  TWinControlH = class(TWinControl);

procedure DrawHelperSing(Sender: TEdit);
var
  vControlCanvas: TControlCanvas;
begin
  if Assigned(Sender.FOnHelperProcess) then
  begin
    vControlCanvas := TControlCanvas.Create;
    try
      vControlCanvas.Control := Sender;
      vControlCanvas.Brush.Color := clBlue;
      vControlCanvas.Pen.Style := psSolid;
      vControlCanvas.Rectangle(Sender.Width-8, 1, Sender.Width-2, 6);
      vControlCanvas.Pen.Style := psClear;
    finally
      FreeAndNil(vControlCanvas);
    end;
  end;
end;

constructor TEditStyleHookColor.Create(AControl: TWinControl);
begin
  inherited;
  UpdateColors;
end;

procedure TEditStyleHookColor.UpdateColors;
var
  vStyle: TCustomStyleServices;
begin
  if Control.ClassType = TEdit then
  begin
    if Control.Enabled then
    begin
      Brush.Color := TWinControlH(Control).Color;
      FontColor := TWinControlH(Control).Font.Color;

      if TEdit(Control).thsRequiredData then
        Brush.Color := TEdit(Control).FColorRequiredInput;

      Brush.Color := TEdit(Control).FColorDefault;
      if TEdit(Control).thsRequiredData then
        Brush.Color := TEdit(Control).FColorRequiredInput;
      if TEdit(Control).Focused then
        Brush.Color := TEdit(Control).FColorActive;
    end
    else
    begin
      vStyle := StyleServices;
      Brush.Color := vStyle.GetStyleColor(scEditDisabled);
      FontColor := vStyle.GetStyleFontColor(sfEditBoxTextDisabled);

      Brush.Color := TEdit(Control).FColorDefault;
      if TEdit(Control).thsRequiredData then
        Brush.Color := TEdit(Control).FColorRequiredInput;
      if TEdit(Control).Focused then
        Brush.Color := TEdit(Control).FColorActive;
    end;
  end
  else
    inherited;
end;

procedure TEditStyleHookColor.WndProc(var Message: TMessage);
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

procedure TEdit.CreateParams(var pParams: TCreateParams);
const
  Alignments: array[TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
var
  vYear, vMonth, vDay: Word;
begin
  inherited CreateParams(pParams);

{$IFDEF VER150}
  with pParams do
    Style := Style or Alignments[FAlignment];
{$ENDIF}

  DecodeDate(Now, vYear, vMonth, vDay);
  if FActiveYear4Digit = 0 then
    FActiveYear4Digit := vYear;
end;

constructor TEdit.Create(AOwner: TComponent);
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
  FColorRequiredInput   := $00706CEC;
  {$IFDEF VER150}
  FAlignment            := taLeftJustify;
  {$ELSE}
  Alignment             := taLeftJustify;
  {$ENDIF}
  FInputDataType        := itString;
  FEnterAsTabKey        := True;
  FDecimalDigitCount    := 4;
  FRequiredData         := False;
  FDoTrim               := True;
  FActiveYear4Digit     := vYear;
  FDBFieldName          := '';
  FInfo                 := 'Thundersoft Edit Component(3ddark) v0.2';
  FWrongDateMessage     := 'Hatalý tarih giriþi!';
  OnKeyDown             := MyOnKeyDown;

  Self.DoubleBuffered := True;
end;

procedure TEdit.DoEnter;
begin
  FOldBackColor := Color;
  Color := thsColorActive;

  if thsInputDataType = itMoney then
  begin
    if (Trim(Self.Text) <> '') and (not Self.ReadOnly) then
    begin
      Self.Text := StringReplace(Self.Text, FormatSettings.ThousandSeparator, '', [rfReplaceAll]);
      Self.SelStart := Length(Self.Text);
      Self.SelectAll;
    end;
  end;

  inherited;
end;

procedure TEdit.DoExit;
begin
  if (FRequiredData) and (Trim(Self.Text) = '') then
    Color := FColorRequiredInput
  else
  begin
    if FOldBackColor = FColorRequiredInput then
      Color := FColorDefault
    else
    begin
      if FOldBackColor = 0 then
        FOldBackColor := Color;
      Color := FOldBackColor;
    end;
  end;

  case thsInputDataType of
    itInteger : ;
    itMoney   : DoubleToMoney;
    itDate    : ValidateDate;
  end;

  if FDoTrim then
    Self.Text := Trim(Self.Text);

  inherited;
end;

procedure TEdit.DoubleToMoney;
begin
  if (Trim(Self.Text) <> '') then
    Self.Text := FormatFloat('0' + FormatSettings.ThousandSeparator +
                             FormatSettings.DecimalSeparator +
                             StringOfChar('0', Self.FDecimalDigitCount),
                             toMoneyToDouble);
end;

procedure TEdit.KeyPress(var Key: Char);
begin
  if not Self.ReadOnly then
  begin
    if FInputDataType = itString then
    begin
      if Self.CharCase = ecUpperCase then
        Key := Ths.Erp.Helper.BaseTypes.UpCaseTr(Key)
      else if Self.CharCase = ecLowerCase then
        Key := Ths.Erp.Helper.BaseTypes.LowCaseTr(Key);
    end;

    case FInputDataType of
      itInteger : Key := IntegerKeyControl(Key);
      itFloat   : Key := FloatKeyControl(Key, FDecimalDigitCount);
      itMoney   : Key := MoneyKeyControl(Key, FDecimalDigitCount);
      itDate    : Key := DateKeyControl(Key);
    else
      inherited KeyPress(Key);
    end;

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
end;

procedure TEdit.MyOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_F1) then
  begin
    if Assigned(FOnHelperProcess) then
      FOnHelperProcess(Self);
  end
  else
  if (Key = VK_F12) then
  begin
    if Assigned(FOnCalculatorProcess) then
      FOnCalculatorProcess(Self);
  end;
end;

function TEdit.IntegerKeyControl(pKey: Char): Char;
begin
  if not CharInSet(pKey, [#13{Enter}, #8{Backspace}, '0'..'9']) then
    pKey := #0;
  Result := pKey;
end;

function TEdit.DateKeyControl(pKey: Char): Char;
begin
  if (CharInSet(pKey, ['-', '/', '.', ',', FormatSettings.DateSeparator])) then
    pKey := FormatSettings.DateSeparator;

  if  (Length(Self.Text) = Self.SelLength) and (not Self.ReadOnly)
  and (CharInSet(pKey, ['0'..'9', #8{Backspace}, FormatSettings.DateSeparator]))
  then
    Self.Clear;

  if not CharInSet(pKey, [#13{Return}, #8{Backspace}, '0'..'9', FormatSettings.DateSeparator])
  or ((Length(Self.Text) = 0) and ((pKey = FormatSettings.DateSeparator)))
  then
    pKey := #0;

  Result := pKey;
end;

procedure TEdit.Repaint;
begin
  if (FRequiredData) and (Trim(Self.Text) = '') then
    Color := FColorRequiredInput
  else
  begin
    if FOldBackColor = FColorRequiredInput then
      Color := FColorDefault
    else
    begin
      if FOldBackColor = 0 then
        FOldBackColor := Color;
      Color := FOldBackColor;
    end;
  end;

  inherited;

  if thsInputDataType = itMoney then
    DoubleToMoney;

  DrawHelperSing(Self);
end;

{$IFDEF VER150}
procedure TEdit.SetAlignment(const pValue: TAlignment);
begin
  FAlignment := pValue;
end;
{$ENDIF}

procedure TEdit.SetHelperProcess(const Value: TNotifyEvent);
begin
  FOnHelperProcess := Value;
  Self.thsInputDataType := itString;
  Self.ReadOnly := True;
end;

function TEdit.toMoneyToDouble: Double;
begin
  Result := Ths.Erp.Helper.BaseTypes.toMoneyToDouble(Text, thsInputDataType);
end;

function TEdit.FloatKeyControl(pKey: Char; pDecimalDigits: Integer): Char;
var
  divided_string: TStringList;
  strPrevious, strIntegerPart, strDecimalPart: String;
begin
  Result := #0;

  if (CharInSet(pKey, ['.', ',', FormatSettings.DecimalSeparator])) then
    pKey := FormatSettings.DecimalSeparator;

  if CharInSet(pKey, [#8, '0'..'9', FormatSettings.DecimalSeparator]) then
    Self.Modified := true;

  //Tümünü seçip yazarsa eski bilgiyi temizle
  if (Length(Self.Text) = Self.SelLength) and (CharInSet(pKey, [#8, '0'..'9', FormatSettings.DecimalSeparator])) then
    Self.Clear;

  //Aradan bilgi girilemez
  if (Length(Self.Text) > Self.SelStart) and (pKey <> #13) then
    pKey := #0;

  //tanýmlý tuþlar harici tuþlar girilmez veya seperator sadece bir kere girilebilir
  if not CharInSet(pKey, [#13, #8, '0'..'9', FormatSettings.DecimalSeparator]) then
    pKey := #0
  else if (pKey = FormatSettings.DecimalSeparator) and (Pos(pKey, Self.Text) > 0) then
    pKey := #0;

  if pKey <> #0 then
  begin
    strPrevious := Self.Text;

    if (Length(strPrevious) = 0) then
    begin
      if pKey = #13 then
        Result := pKey
      else if pKey = '0' then
      begin
        Result := FormatSettings.DecimalSeparator;
        Self.Text := '0';
      end
      else if pKey = FormatSettings.DecimalSeparator then
      begin
        Result := pKey;
        Self.Text := '0';
      end
      else if CharInSet(pKey, ['1'..'9']) then
        Result := pKey;
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
              Self.Text := Self.Text + StringOfChar('0', pDecimalDigits-Length(strDecimalPart));
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
          Self.Text := Self.Text + FormatSettings.DecimalSeparator + StringOfChar('0', pDecimalDigits-Length(strDecimalPart));
        Result := pKey;
      end;

    end;
    Self.SelStart := Length(Self.Text);
  end;
end;

procedure TEdit.HelperProcess;
begin
  if Assigned(FOnHelperProcess) then
    FOnHelperProcess(Self);
end;

procedure TEdit.CalculatorProcess;
begin
  if Assigned(FOnCalculatorProcess) then
    FOnCalculatorProcess(Self);
end;

function TEdit.ValidateDate(): Boolean;
var
  vDay, vMonth, vYear, vDate: string;
begin
  Result := True;
  try
    vDate := Self.Text;
    if Length(vDate) < 4 then
    begin
      if Length(vDate) = 1 then
        vDay := LeftStr(vDate, 1);

      if Length(vDate) = 2 then
        vDay := LeftStr(vDate, 2);

      if Length(vDate) = 3 then
        vMonth  := vDate[3];
    end
    else if Length(vDate) = 4 then
    begin
      if Pos(FormatSettings.DateSeparator, vDate) = 0 then
      begin
        vDay := LeftStr(vDate, 2);
        vMonth  := RightStr(vDate, 2);
        vYear := IntToStr(FActiveYear4Digit);
      end;
    end
    else if Length(vDate) = 5 then
    begin
      if Pos(FormatSettings.DateSeparator, vDate) > 0 then
      begin
        vDay := LeftStr(vDate, 2);
        vMonth  := RightStr(vDate, 2);
        vYear := IntToStr(FActiveYear4Digit);
      end;
    end
    else if Length(vDate) = 6 then
    begin
      if Pos(FormatSettings.DateSeparator, vDate) = 0 then
      begin
        vDay := LeftStr(vDate, 2);
        vMonth  := vDate[3] + vDate[4];
        vYear := LeftStr(IntToStr(FActiveYear4Digit), 2) + RightStr(vDate, 2);
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
      else if Pos(FormatSettings.DateSeparator, vDate) > 0 then
      begin
        vDay := LeftStr(vDate, 2);
        vMonth  := vDate[4] + vDate[5];
        vYear := LeftStr(IntToStr(FActiveYear4Digit), 2) + RightStr(vDate, 2);
      end
    end
    else if Length(vDate) = 10 then
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

    if FWrongDateMessage = '' then
      FWrongDateMessage := 'Hatalý tarih giriþi!';
    raise Exception.Create(FWrongDateMessage);
  end;
end;

procedure TEdit.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
  with Message do
    case Msg of
      WM_ENABLE, WM_PAINT: DrawHelperSing(Self);
    end;
end;

function TEdit.MoneyKeyControl(pKey: Char; pDecimalDigits: Integer): Char;
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
        Result := pKey
      else if pKey = '0' then
      begin
        Result := FormatSettings.DecimalSeparator;
        Self.Text := '0';
      end
      else if pKey = FormatSettings.DecimalSeparator then
      begin
        Result := pKey;
        Self.Text := '0';
      end
      else if CharInSet(pKey, ['1'..'9']) then
        Result := pKey;
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
              Self.Text := Self.Text + StringOfChar('0', FDecimalDigitCount-Length(vDecimalPart));

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
          Self.Text := Self.Text + FormatSettings.DecimalSeparator + '00';
        Result := pKey;
      end;

    end;
  end;
end;

initialization
  TStyleManager.Engine.RegisterStyleHook(TEdit, TEditStyleHookColor);

end.
