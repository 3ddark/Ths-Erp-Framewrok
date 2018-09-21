unit ufrmPersonelKartlari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmPersonelKartlari = class(TfrmBaseDBGrid)
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
  ufrmPersonelKarti,
  Ths.Erp.Database.Table.PersonelKarti;

{$R *.dfm}

{ TfrmPersonelBilgileri }

function TfrmPersonelKartlari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmPersonelKarti.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmPersonelKarti.Create(Self, Self, TPersonelKarti.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmPersonelKarti.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmPersonelKartlari.SetSelectedItem;
begin
  inherited;

  TPersonelKarti(Table).IsActive.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).IsActive.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).IsActive.FieldName).Value);
  TPersonelKarti(Table).PersonelAd.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).PersonelAd.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).PersonelAd.FieldName).Value);
  TPersonelKarti(Table).PersonelSoyad.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).PersonelSoyad.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).PersonelSoyad.FieldName).Value);
  TPersonelKarti(Table).Telefon1.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Telefon1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Telefon1.FieldName).Value);
  TPersonelKarti(Table).Telefon2.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Telefon2.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Telefon2.FieldName).Value);
  TPersonelKarti(Table).PersonelTipiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).PersonelTipiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).PersonelTipiID.FieldName).Value);
//  TPersonelBilgisi(Table).PersonelTipi.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).PersonelTipi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).PersonelTipi.FieldName).Value);
//  TPersonelBilgisi(Table).BolumID.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).BolumID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).BolumID.FieldName).Value);
//  TPersonelBilgisi(Table).Bolum.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Bolum.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Bolum.FieldName).Value);
  TPersonelKarti(Table).BirimID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).BirimID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).BirimID.FieldName).Value);
//  TPersonelBilgisi(Table).Birim.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Birim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Birim.FieldName).Value);
  TPersonelKarti(Table).GorevID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).GorevID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).GorevID.FieldName).Value);
//  TPersonelBilgisi(Table).Gorev.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Gorev.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Gorev.FieldName).Value);
  TPersonelKarti(Table).MailAdresi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).MailAdresi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).MailAdresi.FieldName).Value);
  TPersonelKarti(Table).DogumTarihi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).DogumTarihi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).DogumTarihi.FieldName).Value);
  TPersonelKarti(Table).KanGrubu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).KanGrubu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).KanGrubu.FieldName).Value);
  TPersonelKarti(Table).CinsiyetID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).CinsiyetID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).CinsiyetID.FieldName).Value);
//  TPersonelBilgisi(Table).Cinsiyet.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Cinsiyet.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Cinsiyet.FieldName).Value);
  TPersonelKarti(Table).AskerlikDurumID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).AskerlikDurumID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).AskerlikDurumID.FieldName).Value);
//  TPersonelBilgisi(Table).AskerlikDurumu.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).AskerlikDurumu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).AskerlikDurumu.FieldName).Value);
  TPersonelKarti(Table).MedeniDurumuID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).MedeniDurumuID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).MedeniDurumuID.FieldName).Value);
//  TPersonelBilgisi(Table).MedeniDurumu.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).MedeniDurumu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).MedeniDurumu.FieldName).Value);
  TPersonelKarti(Table).CocukSayisi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).CocukSayisi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).CocukSayisi.FieldName).Value);
  TPersonelKarti(Table).YakinAdSoyad.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).YakinAdSoyad.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).YakinAdSoyad.FieldName).Value);
  TPersonelKarti(Table).YakinTelefon.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).YakinTelefon.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).YakinTelefon.FieldName).Value);
  TPersonelKarti(Table).EvAdresi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).EvAdresi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).EvAdresi.FieldName).Value);
end;

end.

