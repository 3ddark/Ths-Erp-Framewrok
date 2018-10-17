unit ufrmHesapPlanlari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmHesapPlanlari = class(TfrmBaseDBGrid)
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
  ufrmHesapPlani,
  Ths.Erp.Database.Table.HesapPlani;

{$R *.dfm}

{ TfrmHesapPlanlari }

function TfrmHesapPlanlari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmHesapPlani.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmHesapPlani.Create(Application, Self, THesapPlani.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmHesapPlani.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmHesapPlanlari.SetSelectedItem;
begin
  inherited;

  THesapPlani(Table).PlanKoduVarsayilan.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapPlani(Table).PlanKoduVarsayilan.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapPlani(Table).PlanKoduVarsayilan.FieldName).Value);
  THesapPlani(Table).Aciklama.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapPlani(Table).Aciklama.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapPlani(Table).Aciklama.FieldName).Value);
  THesapPlani(Table).PlanKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapPlani(Table).PlanKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapPlani(Table).PlanKodu.FieldName).Value);
  THesapPlani(Table).SeviyeSayisi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapPlani(Table).SeviyeSayisi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapPlani(Table).SeviyeSayisi.FieldName).Value);
end;

end.
