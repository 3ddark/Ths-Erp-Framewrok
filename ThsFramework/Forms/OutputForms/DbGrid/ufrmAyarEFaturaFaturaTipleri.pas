unit ufrmAyarEFaturaFaturaTipleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarEFaturaFaturaTipleri = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarEFaturaFaturaTipi,
  Ths.Erp.Database.Table.AyarEFaturaFaturaTipi;

{$R *.dfm}

{ TfrmAyarEFaturaFaturaTipleri }

function TfrmAyarEFaturaFaturaTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarEFaturaFaturaTipi.Create(Self, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarEFaturaFaturaTipi.Create(Self, Self, TAyarEFaturaFaturaTipi.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarEFaturaFaturaTipi.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

end.
