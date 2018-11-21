unit ufrmMusteriTemsilciGruplari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmMusteriTemsilciGruplari = class(TfrmBaseDBGrid)
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
  ufrmMusteriTemsilciGrubu,
  Ths.Erp.Database.Table.MusteriTemsilciGrubu;

{$R *.dfm}

{ TfrmMusteriTemsilciGruplari }

function TfrmMusteriTemsilciGruplari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmMusteriTemsilciGrubu.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmMusteriTemsilciGrubu.Create(Application, Self, TMusteriTemsilciGrubu.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmMusteriTemsilciGrubu.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmMusteriTemsilciGruplari.SetSelectedItem;
begin
  inherited;

  TMusteriTemsilciGrubu(Table).TemsilciGrupAdi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).TemsilciGrupAdi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).TemsilciGrupAdi.FieldName).Value);
  TMusteriTemsilciGrubu(Table).GecmisOcak.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisOcak.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisOcak.FieldName).Value);
  TMusteriTemsilciGrubu(Table).GecmisSubat.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisSubat.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisSubat.FieldName).Value);
  TMusteriTemsilciGrubu(Table).GecmisMart.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisMart.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisMart.FieldName).Value);
  TMusteriTemsilciGrubu(Table).GecmisNisan.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisNisan.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisNisan.FieldName).Value);
  TMusteriTemsilciGrubu(Table).GecmisMayis.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisMayis.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisMayis.FieldName).Value);
  TMusteriTemsilciGrubu(Table).GecmisHaziran.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisHaziran.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisHaziran.FieldName).Value);
  TMusteriTemsilciGrubu(Table).GecmisTemmuz.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisTemmuz.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisTemmuz.FieldName).Value);
  TMusteriTemsilciGrubu(Table).GecmisAgustos.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisAgustos.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisAgustos.FieldName).Value);
  TMusteriTemsilciGrubu(Table).GecmisEylul.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisEylul.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisEylul.FieldName).Value);
  TMusteriTemsilciGrubu(Table).GecmisEkim.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisEkim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisEkim.FieldName).Value);
  TMusteriTemsilciGrubu(Table).GecmisKasim.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisKasim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisKasim.FieldName).Value);
  TMusteriTemsilciGrubu(Table).GecmisAralik.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisAralik.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).GecmisAralik.FieldName).Value);
  TMusteriTemsilciGrubu(Table).HedefOcak.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefOcak.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefOcak.FieldName).Value);
  TMusteriTemsilciGrubu(Table).HedefSubat.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefSubat.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefSubat.FieldName).Value);
  TMusteriTemsilciGrubu(Table).HedefMart.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefMart.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefMart.FieldName).Value);
  TMusteriTemsilciGrubu(Table).HedefNisan.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefNisan.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefNisan.FieldName).Value);
  TMusteriTemsilciGrubu(Table).HedefMayis.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefMayis.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefMayis.FieldName).Value);
  TMusteriTemsilciGrubu(Table).HedefHaziran.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefHaziran.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefHaziran.FieldName).Value);
  TMusteriTemsilciGrubu(Table).HedefTemmuz.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefTemmuz.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefTemmuz.FieldName).Value);
  TMusteriTemsilciGrubu(Table).HedefAgustos.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefAgustos.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefAgustos.FieldName).Value);
  TMusteriTemsilciGrubu(Table).HedefEylul.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefEylul.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefEylul.FieldName).Value);
  TMusteriTemsilciGrubu(Table).HedefEkim.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefEkim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefEkim.FieldName).Value);
  TMusteriTemsilciGrubu(Table).HedefKasim.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefKasim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefKasim.FieldName).Value);
  TMusteriTemsilciGrubu(Table).HedefAralik.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefAralik.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TMusteriTemsilciGrubu(Table).HedefAralik.FieldName).Value);
end;

end.
