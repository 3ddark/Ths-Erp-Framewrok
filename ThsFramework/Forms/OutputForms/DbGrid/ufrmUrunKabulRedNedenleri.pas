unit ufrmUrunKabulRedNedenleri;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmUrunKabulRedNedenleri = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmUrunKabulRedNedeni,
  Ths.Erp.Database.Table.UrunKabulRedNedeni;

{$R *.dfm}

{ TfrmUrunKabulRedNedenleri }

function TfrmUrunKabulRedNedenleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmUrunKabulRedNedeni.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmUrunKabulRedNedeni.Create(Application, Self, TUrunKabulRedNedeni.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmUrunKabulRedNedeni.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
