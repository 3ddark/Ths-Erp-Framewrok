unit ufrmBaseStrGrid;

interface

uses
  System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls,
  Vcl.Buttons, AdvObj,
  AdvGrid,
  ufrmBase, ufrmBaseOutput, AdvUtil, Vcl.Grids, BaseGrid, Vcl.Menus,
  Vcl.AppEvnts, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TfrmBaseStrGrid = class(TfrmBaseOutput)
    strGrdBase: TAdvStringGrid;
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

  strGrdBase.SearchFooter.Visible := False;
end;

end.
