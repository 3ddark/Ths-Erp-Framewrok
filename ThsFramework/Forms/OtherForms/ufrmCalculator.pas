unit ufrmCalculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, StrUtils;

type
  TCalcOperation = (coAdd, coSub, coMultiple, coDivide, coSquare, coNon);

  TfrmCalculator = class(TForm)
    edtLCD: TEdit;
    pnlButtons: TPanel;
    grdpnlCalculator: TGridPanel;
    btn0: TButton;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    btn7: TButton;
    btn8: TButton;
    btn9: TButton;
    btnAddition: TButton;
    btnSubtract: TButton;
    btnMultiply: TButton;
    btnDivide: TButton;
    btnErase: TButton;
    btnSquare: TButton;
    btnC: TButton;
    btnCalculate: TButton;
    btnSeperate: TButton;
    btnArtiEksi: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnEraseClick(Sender: TObject);
    procedure btnCalculateClick(Sender: TObject);
    procedure btnArtiEksiClick(Sender: TObject);
    procedure btnCClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    Operation: TCalcOperation;
    IsKeyPressed, IsDataChange: Boolean;
    FNumber1, FTempNumber: Real;
  public
    procedure SayiButonlariClick(Sender: TObject);
  end;

implementation

{$R *.dfm}

{ TfrmCalculator }

procedure TfrmCalculator.btnArtiEksiClick(Sender: TObject);
var
  OriginalNumber: real;
  TextNumber: string;
begin
  OriginalNumber := -(StrToFloat(edtLCD.Text));
  TextNumber := FormatFloat('0.##########', OriginalNumber);
  edtLCD.Text := TextNumber;
  TCustomForm(Self).DefocusControl(Sender as TButton, True);
end;

procedure TfrmCalculator.btnCClick(Sender: TObject);
begin
  Operation := coNon;
  edtLCD.Text := '0';
  FNumber1 := 0;
  FTempNumber := 0;
  IsKeyPressed := False;
  IsDataChange := False;
  TCustomForm(Self).DefocusControl(Sender as TButton, True);
end;

procedure TfrmCalculator.btnEraseClick(Sender: TObject);
begin
  if Length(edtLCD.Text) = 1 then
    edtLCD.Text := '0'
  else
    edtLCD.Text := LeftStr(edtLCD.Text, Length(edtLCD.Text)-1);
  TCustomForm(Self).DefocusControl(Sender as TButton, True);
end;

procedure TfrmCalculator.btnCalculateClick(Sender: TObject);
var
  Answer: real;

  procedure SetOperation;
  begin
    if Sender is TButton then
    begin
      if TButton(Sender).Name = btnAddition.Name then
        Operation := coAdd
      else if TButton(Sender).Name = btnSubtract.Name then
        Operation := coSub
      else if TButton(Sender).Name = btnMultiply.Name then
        Operation := coMultiple
      else if TButton(Sender).Name = btnDivide.Name then
        Operation := coDivide
      else if TButton(Sender).Name = btnSquare.Name then
        Answer := FTempNumber * FTempNumber
      else if TButton(Sender).Name = btnCalculate.Name then
        Operation := coNon;

      IsDataChange := False;
    end;
  end;

begin
  if IsKeyPressed then
  begin
    if (Trim(edtLCD.Text) <> '') then
    begin
      Answer := 0;
      if Operation = coNon then
      begin
        FTempNumber := StrToFloatDef(edtLCD.Text, 0);
        Answer := FTempNumber;
      end
      else
      begin
        if IsDataChange then
        begin
          if Operation = coAdd then
            Answer := FTempNumber + StrToFloatDef(edtLCD.Text, 0)
          else if Operation = coSub then
            Answer := FTempNumber - StrToFloatDef(edtLCD.Text, 0)
          else if Operation = coMultiple then
            Answer := FTempNumber * StrToFloatDef(edtLCD.Text, 0)
          else if Operation = coDivide then
          begin
            Answer := FTempNumber / StrToFloatDef(edtLCD.Text, 0)
          end;
          FTempNumber := Answer;
        end;
      end;

      if Operation <> coNon then
        IsKeyPressed := False;

      SetOperation();

      edtLCD.Text := FormatFloat('0.##########', Answer);
    end;
  end
  else
    SetOperation();
  TCustomForm(Self).DefocusControl(Sender as TButton, True);
end;

procedure TfrmCalculator.FormCreate(Sender: TObject);
begin
  btn0.OnClick := SayiButonlariClick;
  btn1.OnClick := SayiButonlariClick;
  btn2.OnClick := SayiButonlariClick;
  btn3.OnClick := SayiButonlariClick;
  btn4.OnClick := SayiButonlariClick;
  btn5.OnClick := SayiButonlariClick;
  btn6.OnClick := SayiButonlariClick;
  btn7.OnClick := SayiButonlariClick;
  btn7.OnClick := SayiButonlariClick;
  btn8.OnClick := SayiButonlariClick;
  btn9.OnClick := SayiButonlariClick;
  btnSeperate.OnClick := SayiButonlariClick;

  btnSquare.OnClick := btnCalculateClick;
  btnAddition.OnClick := btnCalculateClick;
  btnSubtract.OnClick := btnCalculateClick;
  btnMultiply.OnClick := btnCalculateClick;
  btnDivide.OnClick := btnCalculateClick;

  edtLCD.OnKeyPress := nil;
  edtLCD.OnKeyUp := nil;
  edtLCD.OnExit := nil;
  edtLCD.MaxLength := 11;

  btnCClick(btnC);
end;

procedure TfrmCalculator.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    btnCClick(btnC)
  else if Key = VK_RETURN then
    btnCalculateClick(btnCalculate)
  else if Key = VK_BACK then
    btnEraseClick(btnErase)
  else if ((Key = Ord('0')) or (Key = VK_NUMPAD0)) then
    SayiButonlariClick(btn0)
  else if ((Key = Ord('1')) or (Key = VK_NUMPAD1)) then
    SayiButonlariClick(btn1)
  else if ((Key = Ord('2')) or (Key = VK_NUMPAD2)) then
    SayiButonlariClick(btn2)
  else if ((Key = Ord('3')) or (Key = VK_NUMPAD3)) then
    SayiButonlariClick(btn3)
  else if ((Key = Ord('4')) or (Key = VK_NUMPAD4)) then
    SayiButonlariClick(btn4)
  else if ((Key = Ord('5')) or (Key = VK_NUMPAD5)) then
    SayiButonlariClick(btn5)
  else if ((Key = Ord('6')) or (Key = VK_NUMPAD6)) then
    SayiButonlariClick(btn6)
  else if ((Key = Ord('7')) or (Key = VK_NUMPAD7)) then
    SayiButonlariClick(btn7)
  else if ((Key = Ord('8')) or (Key = VK_NUMPAD8)) then
    SayiButonlariClick(btn8)
  else if ((Key = Ord('9')) or (Key = VK_NUMPAD9)) then
    SayiButonlariClick(btn9)
  else if ((Key = Ord(',')) or (Key = VK_DECIMAL)) then
    SayiButonlariClick(btnSeperate)
  else if ((Key = Ord('+')) or (Key = VK_ADD)) then
    btnCalculateClick(btnAddition)
  else if ((Key = Ord('-')) or (Key = VK_SUBTRACT)) then
    btnCalculateClick(btnSubtract)
  else if ((Key = Ord('/')) or (Key = VK_DIVIDE)) then
    btnCalculateClick(btnDivide)
  else if ((Key = Ord('*')) or (Key = VK_MULTIPLY)) then
    btnCalculateClick(btnMultiply)
  else if ((Key = Ord('*')) or (Key = VK_MULTIPLY)) then
    btnCalculateClick(btnSquare)
  else if Key = VK_ESCAPE then
  begin
    Close;
  end;
end;

procedure TfrmCalculator.SayiButonlariClick(Sender: TObject);
var
  vKey: Char;
begin
  if Sender is TButton then
  begin
    if edtLCD.MaxLength > Length(edtLCD.Text) then
    begin
      if ((TButton(Sender).Caption = btnSeperate.Caption) AND (Pos(btnSeperate.Caption, edtLCD.Text) = 0))
      or (TButton(Sender).Caption <> btnSeperate.Caption)
      then
      begin
        TCustomForm(Self).DefocusControl(Sender as TButton, True);
        vKey := TButton(Sender).Caption[1];

        if not IsDataChange then
        begin
          if (CharInSet(vKey, ['0'..'9'])) then
            edtLCD.Text := TButton(Sender).Caption
        end
        else
        begin
          if (edtLCD.Text = '0') and (CharInSet(vKey, ['0'..'9'])) then
            edtLCD.Text := TButton(Sender).Caption
          else
            edtLCD.Text := edtLCD.Text + TButton(Sender).Caption;
        end;

        IsKeyPressed := True;
        IsDataChange := True;
      end;
    end;
  end;
end;

end.
