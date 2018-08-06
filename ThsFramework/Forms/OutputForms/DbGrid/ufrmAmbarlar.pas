unit ufrmAmbarlar;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAmbarlar = class(TfrmBaseDBGrid)
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
  ufrmAmbar,
  Ths.Erp.Database.Table.Ambar;

{$R *.dfm}

{ TfrmAmbarlar }

function TfrmAmbarlar.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAmbar.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAmbar.Create(Application, Self, TAmbar.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAmbar.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAmbarlar.SetSelectedItem;
begin
  inherited;

  TAmbar(Table).AmbarAdi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAmbar(Table).AmbarAdi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAmbar(Table).AmbarAdi.FieldName).Value);
  TAmbar(Table).IsVarsayýlanHammaddeAmbari.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAmbar(Table).IsVarsayýlanHammaddeAmbari.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAmbar(Table).IsVarsayýlanHammaddeAmbari.FieldName).Value);
  TAmbar(Table).IsVarsayilanUretimAmbari.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAmbar(Table).IsVarsayilanUretimAmbari.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAmbar(Table).IsVarsayilanUretimAmbari.FieldName).Value);
  TAmbar(Table).IsVarsayilanSatisAmbari.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAmbar(Table).IsVarsayilanSatisAmbari.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAmbar(Table).IsVarsayilanSatisAmbari.FieldName).Value);
end;

end.
