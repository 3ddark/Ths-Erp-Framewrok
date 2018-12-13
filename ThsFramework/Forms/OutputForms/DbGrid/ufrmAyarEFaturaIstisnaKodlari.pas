unit ufrmAyarEFaturaIstisnaKodlari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarEFaturaIstisnaKodlari = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarEFaturaIstisnaKodu,
  Ths.Erp.Database.Table.AyarEFaturaIstisnaKodu;

{$R *.dfm}

{ TfrmAyarEFaturaIstisnaKodlari }

function TfrmAyarEFaturaIstisnaKodlari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarEFaturaIstisnaKodu.Create(Self, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarEFaturaIstisnaKodu.Create(Self, Self, TAyarEFaturaIstisnaKodu.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarEFaturaIstisnaKodu.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

end.
