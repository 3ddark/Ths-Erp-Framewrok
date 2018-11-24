unit ufrmCalculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, StrUtils;

type
  TfrmCalculator = class(TForm)
    edtLCD: TEdit;
    pnlButtons: TPanel;
    grdpnlCalculator: TGridPanel;
    btnCE: TButton;
    btnErase: TButton;
    btnBol: TButton;
    btn7: TButton;
    btn8: TButton;
    btn9: TButton;
    btnCarp: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    btnCikart: TButton;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btnTopla: TButton;
    btnArtiEksi: TButton;
    btnVirgul: TButton;
    lblState: TLabel;
    btnSonuc: TButton;
    btnC: TButton;
    btn0: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnEraseClick(Sender: TObject);
    procedure btnCEClick(Sender: TObject);
    procedure btnSonucClick(Sender: TObject);
    procedure btnToplaClick(Sender: TObject);
    procedure btnCikartClick(Sender: TObject);
    procedure btnBolClick(Sender: TObject);
    procedure btnCarpClick(Sender: TObject);
    procedure btnArtiEksiClick(Sender: TObject);
    procedure btnVirgulClick(Sender: TObject);
    procedure btnCClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FNumber, SNumber : Real;
    Math : string;
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
  edtLCD.Text := TextNumber
end;

procedure TfrmCalculator.btnBolClick(Sender: TObject);
begin
  Math := 'Divide';
  FNumber := StrToFloat(edtLCD.Text);
  edtLCD.Clear;
//  Math := 'Divide';
//  FNumber := StrToFloat(edtLCD.Text);
//  edtLCD.Clear;
end;

procedure TfrmCalculator.btnCarpClick(Sender: TObject);
begin
  Math := 'Multiply';
  FNumber := StrToFloat(edtLCD.Text);
  edtLCD.Clear;

//  if FIslemTipi = '' then
//  begin
//    FIslemTipi := 'X';
//    FFirstVal := StrToFloatDef(edtLCD.Text, 0);
//    lblState.Caption := lblState.Caption + FIslemTipi + FloatToStr(FFirstVal);
//    edtLCD.Clear;
//  end
//  else
//  begin
//    edtLCD.Text := FormatFloat('0.##########', Hesapla);
//  end;
end;

procedure TfrmCalculator.btnCClick(Sender: TObject);
begin
  lblState.Caption := '';
  edtLCD.Clear;
  FNumber := 0;
  SNumber := 0;
  Math := 'Default';
end;

procedure TfrmCalculator.btnCEClick(Sender: TObject);
begin
  edtLCD.Clear;
//  lblState.Caption := '';
//  edtLCD.Text := '0';
//
//  FFirstVal := 0;
//  FLastVal := 0;
//  FIslemTipi := '';
//
//  FNumber := 0;
//  SNumber := 0;
//  Math := 'Default';
end;

procedure TfrmCalculator.btnCikartClick(Sender: TObject);
begin
  Math := 'Subtract';
  FNumber := StrToFloat(edtLCD.Text);
  edtLCD.Clear;
//  Math := 'Subtract';
//  FNumber := StrToFloat(edtLCD.Text);
//  edtLCD.Clear;
end;

procedure TfrmCalculator.btnEraseClick(Sender: TObject);
begin
  if Length(edtLCD.Text) = 1 then
    edtLCD.Text := '0'
  else
    edtLCD.Text := LeftStr(edtLCD.Text, Length(edtLCD.Text)-1);
end;

procedure TfrmCalculator.btnSonucClick(Sender: TObject);
var
  Answer, SNumber: real;
  Text: string;
begin
  if (Trim(edtLCD.Text) <> '') then
  begin
    SNumber := StrToFloat(edtLCD.Text);

    Answer := 0;
    if Math = 'Add' then
      Answer := FNumber + SNumber
    else if Math = 'Subtract' then
      Answer := FNumber - SNumber
    else if Math = 'Multiply' then
      Answer := FNumber * SNumber
    else if Math = 'Divide' then
      Answer := FNumber / SNumber;

    Text := FormatFloat('0.#####', Answer);
    edtLCD.Text := Text;
  end;
  //sonucu burada hesaplayacaksýn
end;

procedure TfrmCalculator.btnToplaClick(Sender: TObject);
begin
  Math := 'Add';
  FNumber := StrToFloat(edtLCD.Text);
  edtLCD.Clear

//  Math := 'Add';
//  FNumber := StrToFloat(edtLCD.Text);
//  edtLCD.Clear;
end;

procedure TfrmCalculator.btnVirgulClick(Sender: TObject);
begin
  edtLCD.Text := edtLCD.Text + TButton(Sender).Caption;
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

  btnCEClick(btnC);

  edtLCD.OnKeyPress := nil;
  edtLCD.OnKeyUp := nil;
  edtLCD.OnExit := nil;
end;

procedure TfrmCalculator.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    btnCEClick(btnC)
  else if Key = VK_RETURN then
    btnSonucClick(btnSonuc)
  else if Key = VK_BACK then
    btnEraseClick(btnErase)
  else if Key = VK_SEPARATOR then
    btnVirgulClick(btnVirgul)
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
  else if ((Key = Ord('+')) or (Key = VK_ADD)) then
    btnToplaClick(btnTopla)
  else if ((Key = Ord('-')) or (Key = VK_SUBTRACT)) then
    btnCikartClick(btnCikart)
  else if ((Key = Ord('/')) or (Key = VK_DIVIDE)) then
    btnBolClick(btnBol)
  else if ((Key = Ord('*')) or (Key = VK_MULTIPLY)) then
    btnCarpClick(btnCarp)
  else if Key = Ord('(') then
  else if Key = Ord(')') then
end;

procedure TfrmCalculator.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Self.Caption := '';
end;

procedure TfrmCalculator.SayiButonlariClick(Sender: TObject);
begin
  if Sender is TButton then
  begin
    edtLCD.Text := edtLCD.Text + TButton(Sender).Caption;
  end;
end;

end.
