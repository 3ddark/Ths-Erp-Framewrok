unit ufrmUrunKabulRedNedenleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmUrunKabulRedNedenleri = class(TfrmBaseDBGrid)
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
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
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmUrunKabulRedNedeni.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmUrunKabulRedNedeni.Create(Application, Self, TUrunKabulRedNedeni.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmUrunKabulRedNedeni.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmUrunKabulRedNedenleri.SetSelectedItem;
begin
  inherited;

  TUrunKabulRedNedeni(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TUrunKabulRedNedeni(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TUrunKabulRedNedeni(Table).Deger.FieldName).Value);
end;

end.
