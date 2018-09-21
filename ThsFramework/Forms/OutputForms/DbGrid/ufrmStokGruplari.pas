unit ufrmStokGruplari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmStokGruplari = class(TfrmBaseDBGrid)
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
  ufrmStokGrubu,
  Ths.Erp.Database.Table.StokGrubu;

{$R *.dfm}

{ TfrmStokGruplari }

function TfrmStokGruplari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmStokGrubu.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmStokGrubu.Create(Application, Self, TStokGrubu.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmStokGrubu.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmStokGruplari.SetSelectedItem;
begin
  inherited;

  TStokGrubu(Table).Grup.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).Grup.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).Grup.FieldName).Value);
  TStokGrubu(Table).AlisHesabi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).AlisHesabi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).AlisHesabi.FieldName).Value);
  TStokGrubu(Table).SatisHesabi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).SatisHesabi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).SatisHesabi.FieldName).Value);
  TStokGrubu(Table).HammaddeHesabi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).HammaddeHesabi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).HammaddeHesabi.FieldName).Value);
  TStokGrubu(Table).MamulHesabi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).MamulHesabi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).MamulHesabi.FieldName).Value);
  TStokGrubu(Table).KDVOraniID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).KDVOraniID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).KDVOraniID.FieldName).Value);
  TStokGrubu(Table).KDVOrani.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).KDVOrani.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).KDVOrani.FieldName).Value);
  TStokGrubu(Table).TurID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).TurID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).TurID.FieldName).Value);
  TStokGrubu(Table).Tur.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).Tur.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).Tur.FieldName).Value);
  TStokGrubu(Table).IsIskontoAktif.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IsIskontoAktif.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IsIskontoAktif.FieldName).Value);
  TStokGrubu(Table).IskontoSatis.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IskontoSatis.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IskontoSatis.FieldName).Value);
  TStokGrubu(Table).IskontoMudur.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IskontoMudur.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IskontoMudur.FieldName).Value);
  TStokGrubu(Table).IsSatisFiyatiniKullan.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IsSatisFiyatiniKullan.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IsSatisFiyatiniKullan.FieldName).Value);
  TStokGrubu(Table).YariMamulHesabi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).YariMamulHesabi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).YariMamulHesabi.FieldName).Value);
  TStokGrubu(Table).IsMaliyetAnalizFarkliDB.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IsMaliyetAnalizFarkliDB.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IsMaliyetAnalizFarkliDB.FieldName).Value);
end;

end.
