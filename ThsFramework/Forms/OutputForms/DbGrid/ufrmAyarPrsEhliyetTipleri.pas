unit ufrmAyarPrsEhliyetTipleri;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids,

  ufrmBase, ufrmBaseDBGrid;

type
  TfrmAyarPrsEhliyetTipleri = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarPrsEhliyetTipi,
  Ths.Erp.Database.Table.AyarPrsEhliyetTipi;

{$R *.dfm}

function TfrmAyarPrsEhliyetTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPrsEhliyetTipi.Create(Self, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPrsEhliyetTipi.Create(Self, Self, TAyarPrsEhliyetTipi.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPrsEhliyetTipi.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

end.
