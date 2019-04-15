unit ufrmAyarStkUrunTipleri;

interface

{$I ThsERP.inc}

uses
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB,

  ufrmBaseDBGrid, ufrmBase;

type
  TfrmAyarStkUrunTipleri = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  ufrmAyarStkUrunTipi,
  Ths.Erp.Database.Table.AyarStkUrunTipi;

{$R *.dfm}

{ TfrmAyarStkUrunTipleri }

function TfrmAyarStkUrunTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarStkUrunTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarStkUrunTipi.Create(Application, Self, TAyarStkUrunTipi.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarStkUrunTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
