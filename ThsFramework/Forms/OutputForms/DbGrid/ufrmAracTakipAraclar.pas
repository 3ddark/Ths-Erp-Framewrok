unit ufrmAracTakipAraclar;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAracTakipAraclar = class(TfrmBaseDBGrid)
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
  ufrmAracTakipArac,
  Ths.Erp.Database.Table.AracTakip.Arac;

{$R *.dfm}

{ TfrmAracTakipAraclar }

function TfrmAracTakipAraclar.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAracTakipArac.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAracTakipArac.Create(Application, Self, TArac.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAracTakipArac.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAracTakipAraclar.SetSelectedItem;
begin
  inherited;

  TArac(Table).Marka.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TArac(Table).Marka.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TArac(Table).Marka.FieldName).Value);
  TArac(Table).Model.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TArac(Table).Model.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TArac(Table).Model.FieldName).Value);
  TArac(Table).Plaka.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TArac(Table).Plaka.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TArac(Table).Plaka.FieldName).Value);
  TArac(Table).Renk.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TArac(Table).Renk.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TArac(Table).Renk.FieldName).Value);
  TArac(Table).GelisTarihi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TArac(Table).GelisTarihi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TArac(Table).GelisTarihi.FieldName).Value);
  TArac(Table).GelisKM.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TArac(Table).GelisKM.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TArac(Table).GelisKM.FieldName).Value);
  TArac(Table).GelisYeri.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TArac(Table).GelisYeri.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TArac(Table).GelisYeri.FieldName).Value);
  TArac(Table).Aciklama.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TArac(Table).Aciklama.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TArac(Table).Aciklama.FieldName).Value);
  TArac(Table).IsActive.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TArac(Table).IsActive.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TArac(Table).IsActive.FieldName).Value);
  TArac(Table).AktifKM.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TArac(Table).AktifKM.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TArac(Table).AktifKM.FieldName).Value);
  TArac(Table).AktifKonum.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TArac(Table).AktifKonum.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TArac(Table).AktifKonum.FieldName).Value);
end;

end.
