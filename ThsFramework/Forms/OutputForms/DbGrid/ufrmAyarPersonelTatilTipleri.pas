unit ufrmAyarPersonelTatilTipleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarPersonelTatilTipleri = class(TfrmBaseDBGrid)
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
  ufrmAyarPersonelTatilTipi,
  Ths.Erp.Database.Table.AyarPersonelTatilTipi;

{$R *.dfm}

{ TfrmAyarPersonelTatilTipleri }

function TfrmAyarPersonelTatilTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPersonelTatilTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPersonelTatilTipi.Create(Application, Self, TAyarPersonelTatilTipi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPersonelTatilTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarPersonelTatilTipleri.SetSelectedItem;
begin
  inherited;

  TAyarPersonelTatilTipi(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelTatilTipi(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelTatilTipi(Table).Deger.FieldName).Value);
  TAyarPersonelTatilTipi(Table).IsResmiTatil.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelTatilTipi(Table).IsResmiTatil.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelTatilTipi(Table).IsResmiTatil.FieldName).Value);
end;

end.
