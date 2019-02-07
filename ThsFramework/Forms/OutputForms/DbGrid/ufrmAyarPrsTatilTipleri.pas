unit ufrmAyarPrsTatilTipleri;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids,

  ufrmBase, ufrmBaseDBGrid;

type
  TfrmAyarPrsTatilTipleri = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarPrsTatilTipi,
  Ths.Erp.Database.Table.AyarPrsTatilTipi;

{$R *.dfm}

function TfrmAyarPrsTatilTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPrsTatilTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPrsTatilTipi.Create(Application, Self, TAyarPrsTatilTipi.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPrsTatilTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
