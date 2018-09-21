unit ufrmAyarPersonelEhliyetTipleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarPersonelEhliyetTipleri = class(TfrmBaseDBGrid)
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
  ufrmAyarPersonelEhliyetTipi,
  Ths.Erp.Database.Table.AyarPersonelEhliyetTipi;

{$R *.dfm}

{ TfrmAyarPersonelEhliyetTipleri }

function TfrmAyarPersonelEhliyetTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPersonelEhliyetTipi.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPersonelEhliyetTipi.Create(Self, Self, TAyarPersonelEhliyetTipi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPersonelEhliyetTipi.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarPersonelEhliyetTipleri.SetSelectedItem;
begin
  inherited;

  TAyarPersonelEhliyetTipi(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelEhliyetTipi(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelEhliyetTipi(Table).Deger.FieldName).Value);
end;

end.
