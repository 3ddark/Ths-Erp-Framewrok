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
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
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
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPersonelAyrilmaNedeniTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPersonelAyrilmaNedeniTipi.Create(Application, Self, TAyarPersonelAyrilmaNedeniTipi.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPersonelAyrilmaNedeniTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
