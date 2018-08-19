unit ufrmAyarCekSenetCashEdiciTipleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarCekSenetCashEdiciTipleri = class(TfrmBaseDBGrid)
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
  ufrmAyarCekSenetCashEdiciTipi,
  Ths.Erp.Database.Table.AyarCekSenetCashEdiciTipi;

{$R *.dfm}

{ TfrmAyarCekSenetCashEdiciTipleri }

function TfrmAyarCekSenetCashEdiciTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarCekSenetCashEdiciTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarCekSenetCashEdiciTipi.Create(Application, Self, TAyarCekSenetCashEdiciTipi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarCekSenetCashEdiciTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarCekSenetCashEdiciTipleri.SetSelectedItem;
begin
  inherited;

  TAyarCekSenetCashEdiciTipi(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarCekSenetCashEdiciTipi(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarCekSenetCashEdiciTipi(Table).Deger.FieldName).Value);
end;

end.
