unit ufrmAyarCekSenetTahsilOdemeTipleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarCekSenetTahsilOdemeTipleri = class(TfrmBaseDBGrid)
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
  ufrmAyarCekSenetTahsilOdemeTipi,
  Ths.Erp.Database.Table.AyarCekSenetTahsilOdemeTipi;

{$R *.dfm}

{ TfrmAyarCekSenetTahsilOdemeTipleri }

function TfrmAyarCekSenetTahsilOdemeTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarCekSenetTahsilOdemeTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarCekSenetTahsilOdemeTipi.Create(Application, Self, TAyarCekSenetTahsilOdemeTipi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarCekSenetTahsilOdemeTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarCekSenetTahsilOdemeTipleri.SetSelectedItem;
begin
  inherited;

  TAyarCekSenetTahsilOdemeTipi(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarCekSenetTahsilOdemeTipi(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarCekSenetTahsilOdemeTipi(Table).Deger.FieldName).Value);
end;

end.
