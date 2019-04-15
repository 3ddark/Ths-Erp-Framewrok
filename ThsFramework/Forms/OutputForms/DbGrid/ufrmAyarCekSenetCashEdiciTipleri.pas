unit ufrmAyarCekSenetCashEdiciTipleri;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarCekSenetCashEdiciTipleri = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarCekSenetCashEdiciTipi,
  Ths.Erp.Database.Table.AyarCekSenetCashEdiciTipi;

{$R *.dfm}

{ TfrmAyarCekSenetCashEdiciTipleri }

function TfrmAyarCekSenetCashEdiciTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarCekSenetCashEdiciTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarCekSenetCashEdiciTipi.Create(Application, Self, TAyarCekSenetCashEdiciTipi.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarCekSenetCashEdiciTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
