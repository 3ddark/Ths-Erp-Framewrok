unit ufrmBaseOutput;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, Vcl.Samples.Spin,
  Vcl.Buttons, Vcl.Menus, Vcl.AppEvnts, Vcl.StdCtrls,
  ufrmBase;

type
  TfrmBaseOutput = class(TfrmBase)
    pnlLeft: TPanel;
    splLeft: TSplitter;
    splHeader: TSplitter;
    pnlHeader: TPanel;
    pnlContent: TPanel;
    pmDB: TPopupMenu;
    procedure FormCreate(Sender: TObject);override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmBaseOutput.FormCreate(Sender: TObject);
begin
  inherited;

  btnKapat.Visible := True;

  //sol panel ve üst paneli base açýlýþta kapat. kullanan form kendisi açsýn
  pnlLeft.Visible := False;
  splLeft.Visible := False;
  pnlHeader.Visible := False;
  splHeader.Visible := False;

  btnSpin.Visible := False;
end;

end.
