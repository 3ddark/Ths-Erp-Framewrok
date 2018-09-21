unit ufrmSatisTeklifler;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSatisTeklifler = class(TfrmBaseDBGrid)
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  end;

implementation

uses
  ufrmSatisTeklifDetaylar,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.SatisTeklif;

{$R *.dfm}

{ TfrmSatisTeklifler }

function TfrmSatisTeklifler.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSatisTeklifDetaylar.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmSatisTeklifDetaylar.Create(Application, Self, TSatisTeklif.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSatisTeklifDetaylar.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSatisTeklifler.SetSelectedItem;
begin
  inherited;

  TSatisTeklif(Table).TeklifNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifNo.FieldName).Value);
  TSatisTeklif(Table).TeklifTarihi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifTarihi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifTarihi.FieldName).Value);
  TSatisTeklif(Table).SiparisID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SiparisID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SiparisID.FieldName).Value);
  TSatisTeklif(Table).IrsaliyeID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IrsaliyeID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IrsaliyeID.FieldName).Value);
  TSatisTeklif(Table).FaturaID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).FaturaID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).FaturaID.FieldName).Value);
  TSatisTeklif(Table).MusteriKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MusteriKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MusteriKodu.FieldName).Value);
  TSatisTeklif(Table).MusteriAdi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MusteriAdi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MusteriAdi.FieldName).Value);
  TSatisTeklif(Table).MuhattapAd.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MuhattapAd.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MuhattapAd.FieldName).Value);
  TSatisTeklif(Table).MuhattapSoyad.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MuhattapSoyad.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MuhattapSoyad.FieldName).Value);
  TSatisTeklif(Table).VergiDairesi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).VergiDairesi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).VergiDairesi.FieldName).Value);
  TSatisTeklif(Table).VergiNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).VergiNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).VergiNo.FieldName).Value);
  TSatisTeklif(Table).AdresMusteri.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AdresMusteri.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AdresMusteri.FieldName).Value);
  TSatisTeklif(Table).AdresSevkiyat.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AdresSevkiyat.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AdresSevkiyat.FieldName).Value);
  TSatisTeklif(Table).SehirMusteri.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SehirMusteri.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SehirMusteri.FieldName).Value);
  TSatisTeklif(Table).SehirSevkiyat.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SehirSevkiyat.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SehirSevkiyat.FieldName).Value);
  TSatisTeklif(Table).PostaKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).PostaKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).PostaKodu.FieldName).Value);
  TSatisTeklif(Table).IsSiparislesti.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IsSiparislesti.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IsSiparislesti.FieldName).Value);
  TSatisTeklif(Table).ParaBirimi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).ParaBirimi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).ParaBirimi.FieldName).Value);
  TSatisTeklif(Table).Tutar.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).Tutar.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).Tutar.FieldName).Value);
  TSatisTeklif(Table).IskontoTutar.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IskontoTutar.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IskontoTutar.FieldName).Value);
  TSatisTeklif(Table).AraToplam.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AraToplam.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AraToplam.FieldName).Value);
  TSatisTeklif(Table).KDVTutar.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).KDVTutar.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).KDVTutar.FieldName).Value);
  TSatisTeklif(Table).GenelIskontoTutar.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GenelIskontoTutar.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GenelIskontoTutar.FieldName).Value);
  TSatisTeklif(Table).GenelToplam.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GenelToplam.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GenelToplam.FieldName).Value);
  TSatisTeklif(Table).IsEFatura.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IsEFatura.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IsEFatura.FieldName).Value);
//  TSatisTeklif(Table).EFaturaTevkifatKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaTevkifatKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaTevkifatKodu.FieldName).Value);
//  TSatisTeklif(Table).EFaturaTevkifatPay.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaTevkifatPay.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaTevkifatPay.FieldName).Value);
//  TSatisTeklif(Table).EFaturaTevkifatPayda.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaTevkifatPayda.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaTevkifatPayda.FieldName).Value);
//  TSatisTeklif(Table).EFaturaIslemTipi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaIslemTipi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaIslemTipi.FieldName).Value);
//  TSatisTeklif(Table).EFaturaIhracKayitKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaIhracKayitKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaIhracKayitKodu.FieldName).Value);
//  TSatisTeklif(Table).EFaturaGonderimSekliID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaGonderimSekliID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaGonderimSekliID.FieldName).Value);
//  TSatisTeklif(Table).EFaturaTeslimSartiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaTeslimSartiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaTeslimSartiID.FieldName).Value);
//  TSatisTeklif(Table).EFaturaGonderimSekliDetay.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaGonderimSekliDetay.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaGonderimSekliDetay.FieldName).Value);
//  TSatisTeklif(Table).EFaturaOdemeSekliID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaOdemeSekliID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EFaturaOdemeSekliID.FieldName).Value);
  TSatisTeklif(Table).Aciklama.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).Aciklama.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).Aciklama.FieldName).Value);
  TSatisTeklif(Table).Referans.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).Referans.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).Referans.FieldName).Value);
  TSatisTeklif(Table).TeslimTarihi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeslimTarihi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeslimTarihi.FieldName).Value);
//  TSatisTeklif(Table).SonGecerlilikTarihi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SonGecerlilikTarihi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SonGecerlilikTarihi.FieldName).Value);
  TSatisTeklif(Table).OrtakIskonto.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).OrtakIskonto.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).OrtakIskonto.FieldName).Value);
  TSatisTeklif(Table).VadeGunSayisi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).VadeGunSayisi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).VadeGunSayisi.FieldName).Value);
  TSatisTeklif(Table).IsTaslak.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IsTaslak.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IsTaslak.FieldName).Value);
  TSatisTeklif(Table).MusteriTemsilcisiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MusteriTemsilcisiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MusteriTemsilcisiID.FieldName).Value);
  TSatisTeklif(Table).ProformaNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).ProformaNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).ProformaNo.FieldName).Value);
  TSatisTeklif(Table).TeslimatSuresi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeslimatSuresi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeslimatSuresi.FieldName).Value);
end;

end.
