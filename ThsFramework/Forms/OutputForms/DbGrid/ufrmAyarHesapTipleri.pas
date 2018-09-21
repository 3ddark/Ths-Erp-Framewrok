unit ufrmAyarHesapTipleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarHesapTipleri = class(TfrmBaseDBGrid)
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarHesapTipi,
  Ths.Erp.Database.Table.AyarHesapTipi;

{$R *.dfm}

{ TfrmAyarHesapTipleri }

function TfrmAyarHesapTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarHesapTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarHesapTipi.Create(Application, Self, TAyarHesapTipi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarHesapTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarHesapTipleri.SetSelectedItem;
begin
  inherited;

  TAyarHesapTipi(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarHesapTipi(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarHesapTipi(Table).Deger.FieldName).Value);
end;

end.
