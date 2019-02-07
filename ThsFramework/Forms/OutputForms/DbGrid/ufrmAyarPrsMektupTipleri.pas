unit ufrmAyarPrsMektupTipleri;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids,

  ufrmBase, ufrmBaseDBGrid;

type
  TfrmAyarPrsMektupTipleri = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarPrsMektupTipi,
  Ths.Erp.Database.Table.AyarPrsMektupTipi;

{$R *.dfm}

function TfrmAyarPrsMektupTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPrsMektupTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPrsMektupTipi.Create(Application, Self, TAyarPrsMektupTipi.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPrsMektupTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
