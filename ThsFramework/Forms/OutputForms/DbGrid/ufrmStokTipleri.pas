unit ufrmStokTipleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmStokTipleri = class(TfrmBaseDBGrid)
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
  ufrmStokTipi,
  Ths.Erp.Database.Table.StokTipi;

{$R *.dfm}

{ TfrmStokTipleri }

function TfrmStokTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmStokTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmStokTipi.Create(Application, Self, TStokTipi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmStokTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmStokTipleri.SetSelectedItem;
begin
  inherited;

  TStokTipi(Table).Tip.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokTipi(Table).Tip.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokTipi(Table).Tip.FieldName).Value);
  TStokTipi(Table).IsDefault.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokTipi(Table).IsDefault.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokTipi(Table).IsDefault.FieldName).Value);
  TStokTipi(Table).IsStokHareketiYap.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokTipi(Table).IsStokHareketiYap.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokTipi(Table).IsStokHareketiYap.FieldName).Value);
end;

end.
