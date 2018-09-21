unit ufrmStokHareketleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmStokHareketleri = class(TfrmBaseDBGrid)
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
  ufrmStokHareketi,
  Ths.Erp.Database.Table.StokHareketi;

{$R *.dfm}

{ TfrmStokHareketleri }

function TfrmStokHareketleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmStokHareketi.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmStokHareketi.Create(Self, Self, TStokHareketi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmStokHareketi.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmStokHareketleri.SetSelectedItem;
begin
  inherited;

  TStokHareketi(Table).StokKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokHareketi(Table).StokKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokHareketi(Table).StokKodu.FieldName).Value);
  TStokHareketi(Table).Miktar.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokHareketi(Table).Miktar.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokHareketi(Table).Miktar.FieldName).Value);
  TStokHareketi(Table).Tutar.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokHareketi(Table).Tutar.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokHareketi(Table).Tutar.FieldName).Value);
  TStokHareketi(Table).GirisCikisTipID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokHareketi(Table).GirisCikisTipID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokHareketi(Table).GirisCikisTipID.FieldName).Value);
  TStokHareketi(Table).Tarih.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokHareketi(Table).Tarih.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokHareketi(Table).Tarih.FieldName).Value);
end;

end.
