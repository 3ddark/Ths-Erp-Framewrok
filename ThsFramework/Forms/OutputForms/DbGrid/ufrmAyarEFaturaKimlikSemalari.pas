unit ufrmAyarEFaturaKimlikSemalari;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids,
  ufrmBase, ufrmBaseDBGrid;

type
  TfrmAyarEFaturaKimlikSemalari = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarEFaturaKimlikSemasi,
  Ths.Erp.Database.Table.AyarEFaturaKimlikSemasi;

{$R *.dfm}

{ TfrmAyarEFaturaKimlikSemalari }

function TfrmAyarEFaturaKimlikSemalari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarEFaturaKimlikSemasi.Create(Self, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarEFaturaKimlikSemasi.Create(Self, Self, TAyarEFaturaKimlikSemasi.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarEFaturaKimlikSemasi.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

end.
