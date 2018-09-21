unit ufrmAyarPersonelAyrilmaNedeniTipleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarPersonelAyrilmaNedeniTipleri = class(TfrmBaseDBGrid)
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
  ufrmAyarPersonelAyrilmaNedeniTipi,
  Ths.Erp.Database.Table.AyarPersonelAyrilmaNedeniTipi;

{$R *.dfm}

{ TfrmAyarPersonelAyrilmaNedeniTipleri }

function TfrmAyarPersonelAyrilmaNedeniTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPersonelAyrilmaNedeniTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPersonelAyrilmaNedeniTipi.Create(Application, Self, TAyarPersonelAyrilmaNedeniTipi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPersonelAyrilmaNedeniTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarPersonelAyrilmaNedeniTipleri.SetSelectedItem;
begin
  inherited;

  TAyarPersonelAyrilmaNedeniTipi(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelAyrilmaNedeniTipi(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelAyrilmaNedeniTipi(Table).Deger.FieldName).Value);
end;

end.
