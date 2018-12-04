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
  TPersonelKarti(Table).PersonelTipiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).PersonelTipiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).PersonelTipiID.FieldName).Value);
  TPersonelKarti(Table).PersonelTipi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).PersonelTipi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).PersonelTipi.FieldName).Value);
  TPersonelKarti(Table).BolumID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).BolumID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).BolumID.FieldName).Value);
  TPersonelKarti(Table).Bolum.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Bolum.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Bolum.FieldName).Value);
  TPersonelKarti(Table).BirimID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).BirimID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).BirimID.FieldName).Value);
  TPersonelKarti(Table).Birim.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Birim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Birim.FieldName).Value);
  TPersonelKarti(Table).GorevID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).GorevID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).GorevID.FieldName).Value);
  TPersonelKarti(Table).Gorev.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Gorev.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Gorev.FieldName).Value);
  TPersonelKarti(Table).GenelNot.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).GenelNot.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).GenelNot.FieldName).Value);

  TPersonelKarti(Table).Telefon1.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Telefon1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Telefon1.FieldName).Value);
  TPersonelKarti(Table).Telefon2.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Telefon2.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Telefon2.FieldName).Value);
  TPersonelKarti(Table).MailAdresi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).MailAdresi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).MailAdresi.FieldName).Value);
  TPersonelKarti(Table).YakinAdSoyad.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).YakinAdSoyad.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).YakinAdSoyad.FieldName).Value);
  TPersonelKarti(Table).YakinTelefon.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).YakinTelefon.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).YakinTelefon.FieldName).Value);
  TPersonelKarti(Table).EvAdresi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).EvAdresi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).EvAdresi.FieldName).Value);
  TPersonelKarti(Table).TCKimlikNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).TCKimlikNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).TCKimlikNo.FieldName).Value);
  TPersonelKarti(Table).DogumTarihi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).DogumTarihi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).DogumTarihi.FieldName).Value);
  TPersonelKarti(Table).KanGrubu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).KanGrubu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).KanGrubu.FieldName).Value);
  TPersonelKarti(Table).CinsiyetID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).CinsiyetID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).CinsiyetID.FieldName).Value);
  TPersonelKarti(Table).Cinsiyet.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Cinsiyet.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Cinsiyet.FieldName).Value);
  TPersonelKarti(Table).MedeniDurumID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).MedeniDurumID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).MedeniDurumID.FieldName).Value);
  TPersonelKarti(Table).MedeniDurum.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).MedeniDurum.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).MedeniDurum.FieldName).Value);
  TPersonelKarti(Table).CocukSayisi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).CocukSayisi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).CocukSayisi.FieldName).Value);
  TPersonelKarti(Table).AyakkabiNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).AyakkabiNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).AyakkabiNo.FieldName).Value);
  TPersonelKarti(Table).ElbiseBedeni.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).ElbiseBedeni.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).ElbiseBedeni.FieldName).Value);
  TPersonelKarti(Table).AskerlikDurumID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).AskerlikDurumID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).AskerlikDurumID.FieldName).Value);
  TPersonelKarti(Table).AskerlikDurum.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).AskerlikDurum.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).AskerlikDurum.FieldName).Value);
  TPersonelKarti(Table).ServisID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).ServisID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).ServisID.FieldName).Value);
  TPersonelKarti(Table).Servis.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Servis.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).Servis.FieldName).Value);

  TPersonelKarti(Table).BrutMaas.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).BrutMaas.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).BrutMaas.FieldName).Value);
  TPersonelKarti(Table).IkramiyeSayisi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).IkramiyeSayisi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).IkramiyeSayisi.FieldName).Value);
  TPersonelKarti(Table).IkramiyeMiktar.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).IkramiyeMiktar.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).IkramiyeMiktar.FieldName).Value);
  TPersonelKarti(Table).OzelNot.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).OzelNot.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).OzelNot.FieldName).Value);
end;

end.

