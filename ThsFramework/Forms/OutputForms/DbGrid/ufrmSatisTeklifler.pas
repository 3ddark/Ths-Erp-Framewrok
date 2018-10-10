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

  TSatisTeklif(Table).SiparisID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SiparisID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SiparisID.FieldName).Value);
  TSatisTeklif(Table).IrsaliyeID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IrsaliyeID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IrsaliyeID.FieldName).Value);
  TSatisTeklif(Table).FaturaID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).FaturaID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).FaturaID.FieldName).Value);
  TSatisTeklif(Table).IsSiparislesti.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IsSiparislesti.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IsSiparislesti.FieldName).Value);
  TSatisTeklif(Table).IsTaslak.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IsTaslak.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IsTaslak.FieldName).Value);
  TSatisTeklif(Table).IsEFatura.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IsEFatura.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IsEFatura.FieldName).Value);
  TSatisTeklif(Table).Tutar.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).Tutar.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).Tutar.FieldName).Value);
  TSatisTeklif(Table).IskontoTutar.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IskontoTutar.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IskontoTutar.FieldName).Value);
  TSatisTeklif(Table).AraToplam.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AraToplam.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AraToplam.FieldName).Value);
  TSatisTeklif(Table).GenelIskontoTutar.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GenelIskontoTutar.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GenelIskontoTutar.FieldName).Value);
  TSatisTeklif(Table).KDVTutar.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).KDVTutar.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).KDVTutar.FieldName).Value);
  TSatisTeklif(Table).GenelToplam.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GenelToplam.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GenelToplam.FieldName).Value);
  TSatisTeklif(Table).IslemTipiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IslemTipiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IslemTipiID.FieldName).Value);
  TSatisTeklif(Table).IslemTipi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IslemTipi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IslemTipi.FieldName).Value);
  TSatisTeklif(Table).TeklifNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifNo.FieldName).Value);
  TSatisTeklif(Table).TeklifTarihi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifTarihi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifTarihi.FieldName).Value);
  TSatisTeklif(Table).TeslimTarihi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeslimTarihi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeslimTarihi.FieldName).Value);
  TSatisTeklif(Table).GecerlilikTarihi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GecerlilikTarihi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GecerlilikTarihi.FieldName).Value);
  TSatisTeklif(Table).MusteriKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MusteriKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MusteriKodu.FieldName).Value);
  TSatisTeklif(Table).MusteriAdi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MusteriAdi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MusteriAdi.FieldName).Value);
  TSatisTeklif(Table).AdresMusteri.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AdresMusteri.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AdresMusteri.FieldName).Value);
  TSatisTeklif(Table).SehirMusteri.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SehirMusteri.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SehirMusteri.FieldName).Value);
  TSatisTeklif(Table).PostaKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).PostaKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).PostaKodu.FieldName).Value);
  TSatisTeklif(Table).VergiDairesi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).VergiDairesi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).VergiDairesi.FieldName).Value);
  TSatisTeklif(Table).VergiNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).VergiNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).VergiNo.FieldName).Value);
  TSatisTeklif(Table).MusteriTemsilcisiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MusteriTemsilcisiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MusteriTemsilcisiID.FieldName).Value);
  TSatisTeklif(Table).MusteriTemsilcisi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MusteriTemsilcisi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MusteriTemsilcisi.FieldName).Value);
  TSatisTeklif(Table).TeklifTipiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifTipiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifTipiID.FieldName).Value);
  TSatisTeklif(Table).TeklifTipi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifTipi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifTipi.FieldName).Value);
  TSatisTeklif(Table).AdresSevkiyat.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AdresSevkiyat.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AdresSevkiyat.FieldName).Value);
  TSatisTeklif(Table).SehirSevkiyat.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SehirSevkiyat.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SehirSevkiyat.FieldName).Value);
  TSatisTeklif(Table).MuhattapAd.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MuhattapAd.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MuhattapAd.FieldName).Value);
  TSatisTeklif(Table).MuhattapSoyad.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MuhattapSoyad.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).MuhattapSoyad.FieldName).Value);
  TSatisTeklif(Table).OdemeVadesi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).OdemeVadesi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).OdemeVadesi.FieldName).Value);
  TSatisTeklif(Table).Referans.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).Referans.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).Referans.FieldName).Value);
  TSatisTeklif(Table).TeslimatSuresi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeslimatSuresi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeslimatSuresi.FieldName).Value);
  TSatisTeklif(Table).TeklifDurumID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifDurumID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifDurumID.FieldName).Value);
  TSatisTeklif(Table).TeklifDurum.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifDurum.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeklifDurum.FieldName).Value);
  TSatisTeklif(Table).SevkTarihi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SevkTarihi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SevkTarihi.FieldName).Value);
  TSatisTeklif(Table).VadeGunSayisi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).VadeGunSayisi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).VadeGunSayisi.FieldName).Value);
  TSatisTeklif(Table).FaturaSevkTarihi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).FaturaSevkTarihi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).FaturaSevkTarihi.FieldName).Value);
  TSatisTeklif(Table).ParaBirimi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).ParaBirimi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).ParaBirimi.FieldName).Value);
  TSatisTeklif(Table).DolarKur.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).DolarKur.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).DolarKur.FieldName).Value);
  TSatisTeklif(Table).EuroKur.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EuroKur.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).EuroKur.FieldName).Value);
  TSatisTeklif(Table).OdemeBaslangicDonemiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).OdemeBaslangicDonemiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).OdemeBaslangicDonemiID.FieldName).Value);
  TSatisTeklif(Table).OdemeBaslangicDonemi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).OdemeBaslangicDonemi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).OdemeBaslangicDonemi.FieldName).Value);
  TSatisTeklif(Table).TeslimSartiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeslimSartiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeslimSartiID.FieldName).Value);
//  TSatisTeklif(Table).TeslimSarti.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeslimSarti.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TeslimSarti.FieldName).Value);
  TSatisTeklif(Table).GonderimSekliID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GonderimSekliID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GonderimSekliID.FieldName).Value);
//  TSatisTeklif(Table).GonderimSekli.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GonderimSekli.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GonderimSekli.FieldName).Value);
  TSatisTeklif(Table).GonderimSekliDetay.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GonderimSekliDetay.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).GonderimSekliDetay.FieldName).Value);
  TSatisTeklif(Table).OdemeSekliID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).OdemeSekliID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).OdemeSekliID.FieldName).Value);
//  TSatisTeklif(Table).OdemeSekli.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).OdemeSekli.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).OdemeSekli.FieldName).Value);
  TSatisTeklif(Table).Aciklama.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).Aciklama.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).Aciklama.FieldName).Value);
  TSatisTeklif(Table).ProformaNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).ProformaNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).ProformaNo.FieldName).Value);
  TSatisTeklif(Table).ArayanKisiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).ArayanKisiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).ArayanKisiID.FieldName).Value);
  TSatisTeklif(Table).ArayanKisi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).ArayanKisi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).ArayanKisi.FieldName).Value);
  TSatisTeklif(Table).AramaTarihi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AramaTarihi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AramaTarihi.FieldName).Value);
  TSatisTeklif(Table).SonrakiAksiyonTarihi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SonrakiAksiyonTarihi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).SonrakiAksiyonTarihi.FieldName).Value);
  TSatisTeklif(Table).AksiyonNotu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AksiyonNotu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).AksiyonNotu.FieldName).Value);
  TSatisTeklif(Table).TevkifatKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TevkifatKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TevkifatKodu.FieldName).Value);
  TSatisTeklif(Table).TevkifatPay.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TevkifatPay.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TevkifatPay.FieldName).Value);
  TSatisTeklif(Table).TevkifatPayda.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TevkifatPayda.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).TevkifatPayda.FieldName).Value);
  TSatisTeklif(Table).IhracKayitKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IhracKayitKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSatisTeklif(Table).IhracKayitKodu.FieldName).Value);
end;

end.
