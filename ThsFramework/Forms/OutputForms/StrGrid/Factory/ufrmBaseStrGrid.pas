unit ufrmBaseStrGrid;

interface

uses
  System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls,


  ufrmBase, ufrmBaseOutput, Vcl.Grids, Vcl.Menus,
  Vcl.AppEvnts, Vcl.StdCtrls,
  Vcl.ComCtrls, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin;

type
  TfrmBaseStrGrid = class(TfrmBaseOutput)
    strngrdBase: TStringGrid;
    procedure FormCreate(Sender: TObject);override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmBaseStrGrid.FormCreate(Sender: TObject);
begin
  inherited;
  btnAccept.Visible := True;
  btnClose.Visible := True;

  pnlHeader.Visible := False;
  splHeader.Visible := False;
  pnlLeft.Visible := False;
  splLeft.Visible := False;
end;

end.
