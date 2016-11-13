unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, thsEdit;

type
  TFormMain = class(TForm)
    thsEditString: TthsEdit;
    thsEditInteger: TthsEdit;
    thsEditDate: TthsEdit;
    thsEditNumeric: TthsEdit;
    thsEditMoney: TthsEdit;
    thsEditFloat: TthsEdit;
    thsEdit1: TthsEdit;
    thsEdit2: TthsEdit;
    thsEdit3: TthsEdit;
    thsEdit4: TthsEdit;
    thsEdit5: TthsEdit;
    thsEdit6: TthsEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

end.
