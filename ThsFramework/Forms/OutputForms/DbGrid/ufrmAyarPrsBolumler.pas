unit ufrmAyarPrsBolumler;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids,

  ufrmBase, ufrmBaseDBGrid;

type
  TfrmAyarPrsBolumler = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarPrsBolum,
  Ths.Erp.Database.Table.AyarPrsBolum;

{$R *.dfm}

function TfrmAyarPrsBolumler.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPrsBolum.Create(Self, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPrsBolum.Create(Self, Self, TAyarPrsBolum.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPrsBolum.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

end.
