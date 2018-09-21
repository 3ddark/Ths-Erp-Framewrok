unit ufrmAyarPersonelTipleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarPersonelTipleri = class(TfrmBaseDBGrid)
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
  ufrmAyarPersonelTipi,
  Ths.Erp.Database.Table.AyarPersonelTipi;

{$R *.dfm}

{ TfrmAyarPersonelTipleri }

function TfrmAyarPersonelTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPersonelTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPersonelTipi.Create(Application, Self, TAyarPersonelTipi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPersonelTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarPersonelTipleri.SetSelectedItem;
begin
  inherited;

  TAyarPersonelTipi(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelTipi(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelTipi(Table).Deger.FieldName).Value);
  TAyarPersonelTipi(Table).IsActive.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelTipi(Table).IsActive.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelTipi(Table).IsActive.FieldName).Value);
end;

end.
