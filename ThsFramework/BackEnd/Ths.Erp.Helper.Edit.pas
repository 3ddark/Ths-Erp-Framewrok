unit Ths.Erp.Helper.Edit;

interface

//{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.Forms,
  Vcl.Graphics, Winapi.Messages, Winapi.Windows, System.StrUtils,
  Vcl.Themes, Vcl.Mask, Vcl.ExtCtrls, System.UITypes,
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
    procedure Invalidate; override;
    function Focused: Boolean; override;
    property OnHelperProcess: TNotifyEvent read FOnHelperProcess write SetHelperProcess;
    property OnCalculatorProcess: TNotifyEvent read FOnCalculatorProcess write FOnCalculatorProcess;

    constructor Create(AOwner: TComponent); override;
    procedure Repaint();override;
    destructor Destroy; override;

    procedure WndProc(var Message: TMessage); override;

    procedure DoubleToMoney();
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
        Brush.Color := TEdit(Control).FColorRequiredData;

      Brush.Color := TEdit(Control).FColorDefault;
      if TEdit(Control).thsRequiredData then
        Brush.Color := TEdit(Control).FColorRequiredData;
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
        Brush.Color := TEdit(Control).FColorRequiredData;
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

  with pParams do
  begin
    Style := Style or Alignments[FAlignment];
  end;

  DecodeDate(Now, vYear, vMonth, vDay);
  if FActiveYear = 0 then
    FActiveYear := vYear;
end;

constructor TEdit.Create(AOwner: TComponent);
var
  vDay, vMonth, vYear: Word;
  vDate: TDateTime;
begin
  inherited;
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
  FInfo                 := 'Ferhat Edit Component v0.2';
  FMesaj                := '';
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
    itInteger:
    begin

    end;
    itMoney:
    begin
      DoubleToMoney;
    end;

    itDate: ValidateDate;
  end;

  if FDoTrim then
  begin
    Self.Text := Trim(Self.Text);
  end;

  inherited;
end;

procedure TEdit.DoubleToMoney;
begin
  if (Trim(Self.Text) <> '') then//and (not Self.ReadOnly) then
    Self.Text := FormatFloat('0' +FormatSettings.ThousandSeparator +
                             FormatSettings.DecimalSeparator +
                             StringOfChar('0', Self.FDecimalDigit),
                             toMoneyToDouble);
end;

procedure TEdit.KeyPress(var Key: Char);
begin
  if not Self.ReadOnly then
  begin
    if FInputDataType = itString then
    begin
      if Self.CharCase = ecUpperCase then
      begin
        if FSupportTRChars then
          Key := Ths.Erp.Helper.BaseTypes.UpCaseTr(Key);
      end
      else if Self.CharCase = ecLowerCase then
      begin
        if FSupportTRChars then
          Key := LowCaseTr(Key);
      end;
    end;

    case FInputDataType of
      itInteger:
      begin
        Key := IntegerKeyControl(Key);
      end;
      itFloat:
      begin
        Key := FloatKeyControl(Key, FDecimalDigit);
      end;
      itMoney:
      begin
        Key := MoneyKeyControl(Key, FDecimalDigit);
      end;
      itDate:
      begin
        Key := DateKeyControl(Key);
      end;
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

procedure TEdit.Invalidate;
begin
  inherited;
end;

function TEdit.DateKeyControl(pKey: Char): Char;
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

destructor TEdit.Destroy;
begin
  inherited;
end;

procedure TEdit.Repaint;
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

  if thsInputDataType = itMoney then
    DoubleToMoney;

  DrawHelperSing(Self);
end;

procedure TEdit.SetAlignment(const pValue: TAlignment);
begin
  FAlignment := pValue;
end;

procedure TEdit.SetHelperProcess(const Value: TNotifyEvent);
begin
  FOnHelperProcess := Value;
  Self.thsInputDataType := itString;
  Self.ReadOnly := True;
end;

function TEdit.toMoneyToDouble: Double;
begin
  Result := 0;
  if thsInputDataType = itMoney then
    Result := StrToFloat(StringReplace(Text, FormatSettings.ThousandSeparator, '', [rfReplaceAll]));
end;

function TEdit.FloatKeyControl(pKey: Char; pDecimalDigits: Integer): Char;
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

function TEdit.Focused: Boolean;
begin
  Result := inherited Focused;
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
      FMesaj := 'Hatalý tarih giriþi!';
    raise Exception.Create(FMesaj);
  end;
end;

procedure TEdit.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
  with Message do
    case Msg of
//      CM_MOUSEENTER, CM_MOUSELEAVE, CM_MOUSEWHEEL, CM_MOUSEACTIVATE,
//      WM_LBUTTONUP, WM_LBUTTONDOWN, WM_KEYDOWN, WM_KEYUP,
//      WM_SETFOCUS, WM_KILLFOCUS, CM_FONTCHANGED, CM_TEXTCHANGED,
      WM_ENABLE, WM_PAINT:
        begin
          //Invalidate;
          DrawHelperSing(Self);
        end;
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
  TStyleManager.Engine.RegisterStyleHook(TEdit, TEditStyleHookColor);

end.
