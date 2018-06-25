unit ufrmBaseOutput;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, Vcl.Samples.Spin,
  Vcl.Menus, Vcl.AppEvnts, Vcl.StdCtrls,
  ufrmBase, System.ImageList, Vcl.ImgList, Vcl.ComCtrls;

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

  btnClose.Visible := True;

  //sol panel ve üst paneli base açýlýþta kapat. kullanan form kendisi açsýn
  pnlLeft.Visible := False;
  splLeft.Visible := False;
  pnlHeader.Visible := False;
  splHeader.Visible := False;

  btnSpin.Visible := False;
end;

end.
