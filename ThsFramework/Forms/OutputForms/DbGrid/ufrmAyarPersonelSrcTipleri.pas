unit ufrmAyarPersonelSrcTipleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarPersonelSrcTipleri = class(TfrmBaseDBGrid)
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
  ufrmAyarPersonelSrcTipi,
  Ths.Erp.Database.Table.AyarPersonelSrcTipi;

{$R *.dfm}

{ TfrmAyarPersonelSrcTipleri }

function TfrmAyarPersonelSrcTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPersonelSrcTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPersonelSrcTipi.Create(Application, Self, TAyarPersonelSrcTipi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPersonelSrcTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarPersonelSrcTipleri.SetSelectedItem;
begin
  inherited;

  TAyarPersonelSrcTipi(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelSrcTipi(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelSrcTipi(Table).Deger.FieldName).Value);
end;

end.
