unit ufrmPersonelDilBilgileri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmPersonelDilBilgileri = class(TfrmBaseDBGrid)
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
  ufrmPersonelDilBilgisi,
  Ths.Erp.Database.Table.PersonelDilBilgisi;

{$R *.dfm}

{ TfrmPersonelDilBilgileri }

function TfrmPersonelDilBilgileri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmPersonelDilBilgisi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmPersonelDilBilgisi.Create(Application, Self, TPersonelDilBilgisi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmPersonelDilBilgisi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmPersonelDilBilgileri.SetSelectedItem;
begin
  inherited;

  TPersonelDilBilgisi(Table).DilID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).DilID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).DilID.FieldName).Value);
  TPersonelDilBilgisi(Table).Dil.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).Dil.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).Dil.FieldName).Value);
  TPersonelDilBilgisi(Table).OkumaSeviyesiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).OkumaSeviyesiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).OkumaSeviyesiID.FieldName).Value);
  TPersonelDilBilgisi(Table).OkumaSeviyesi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).OkumaSeviyesi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).OkumaSeviyesi.FieldName).Value);
  TPersonelDilBilgisi(Table).YazmaSeviyesiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).YazmaSeviyesiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).YazmaSeviyesiID.FieldName).Value);
  TPersonelDilBilgisi(Table).YazmaSeviyesi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).YazmaSeviyesi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).YazmaSeviyesi.FieldName).Value);
  TPersonelDilBilgisi(Table).KonusmaSeviyesiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).KonusmaSeviyesiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).KonusmaSeviyesiID.FieldName).Value);
  TPersonelDilBilgisi(Table).KonusmaSeviyesi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).KonusmaSeviyesi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).KonusmaSeviyesi.FieldName).Value);
  TPersonelDilBilgisi(Table).PersonelID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).PersonelID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).PersonelID.FieldName).Value);
  TPersonelDilBilgisi(Table).PersonelAd.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).PersonelAd.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).PersonelSoyad.FieldName).Value);
  TPersonelDilBilgisi(Table).PersonelSoyad.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).PersonelSoyad.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelDilBilgisi(Table).PersonelSoyad.FieldName).Value);
end;

end.
