unit ufrmAyarPrsIzinTipleri;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids,

  ufrmBase, ufrmBaseDBGrid;

type
  TfrmAyarPrsIzinTipleri = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarPrsIzinTipi,
  Ths.Erp.Database.Table.AyarPrsIzinTipi;

{$R *.dfm}

function TfrmAyarPrsIzinTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPrsIzinTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPrsIzinTipi.Create(Application, Self, TAyarPrsIzinTipi.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPrsIzinTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
