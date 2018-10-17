unit ufrmHesapKartlari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmHesapKartlari = class(TfrmBaseDBGrid)
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
  ufrmHesapKarti,
  Ths.Erp.Database.Table.HesapKarti;

{$R *.dfm}

{ TfrmHesapKartlari }

function TfrmHesapKartlari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmHesapKarti.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmHesapKarti.Create(Application, Self, THesapKarti.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmHesapKarti.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmHesapKartlari.SetSelectedItem;
begin
  inherited;

  THesapKarti(Table).HesapKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).HesapKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).HesapKodu.FieldName).Value);
  THesapKarti(Table).HesapIsmi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).HesapIsmi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).HesapIsmi.FieldName).Value);
  THesapKarti(Table).HesapGrubuID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).HesapGrubuID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).HesapGrubuID.FieldName).Value);
  THesapKarti(Table).HesapGrubu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).HesapGrubu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).HesapGrubu.FieldName).Value);
  THesapKarti(Table).MukellefTipiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MukellefTipiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MukellefTipiID.FieldName).Value);
  THesapKarti(Table).MukellefTipi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MukellefTipi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MukellefTipi.FieldName).Value);
  THesapKarti(Table).MukellefAdi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MukellefAdi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MukellefAdi.FieldName).Value);
  THesapKarti(Table).MukellefIkinciAdi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MukellefIkinciAdi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MukellefIkinciAdi.FieldName).Value);
  THesapKarti(Table).MukellefSoyadi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MukellefSoyadi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MukellefSoyadi.FieldName).Value);
  THesapKarti(Table).UlkeID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).UlkeID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).UlkeID.FieldName).Value);
  THesapKarti(Table).Ulke.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Ulke.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Ulke.FieldName).Value);
  THesapKarti(Table).SehirID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).SehirID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).SehirID.FieldName).Value);
  THesapKarti(Table).Sehir.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Sehir.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Sehir.FieldName).Value);
  THesapKarti(Table).VergiDairesi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).VergiDairesi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).VergiDairesi.FieldName).Value);
  THesapKarti(Table).VergiNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).VergiNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).VergiNo.FieldName).Value);
  THesapKarti(Table).Ilce.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Ilce.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Ilce.FieldName).Value);
  THesapKarti(Table).Mahalle.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Mahalle.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Mahalle.FieldName).Value);
  THesapKarti(Table).Cadde.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Cadde.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Cadde.FieldName).Value);
  THesapKarti(Table).Sokak.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Sokak.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Sokak.FieldName).Value);
  THesapKarti(Table).Bina.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Bina.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Bina.FieldName).Value);
  THesapKarti(Table).KapiNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).KapiNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).KapiNo.FieldName).Value);
  THesapKarti(Table).PostaKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).PostaKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).PostaKodu.FieldName).Value);
  THesapKarti(Table).PostaKutusu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).PostaKutusu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).PostaKutusu.FieldName).Value);
  THesapKarti(Table).Telefon1.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Telefon1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Telefon1.FieldName).Value);
  THesapKarti(Table).Telefon2.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Telefon2.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Telefon2.FieldName).Value);
  THesapKarti(Table).Telefon3.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Telefon3.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Telefon3.FieldName).Value);
  THesapKarti(Table).Faks.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Faks.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Faks.FieldName).Value);
  THesapKarti(Table).YetkiliKisi1.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).YetkiliKisi1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).YetkiliKisi1.FieldName).Value);
  THesapKarti(Table).YetkiliKisi2.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).YetkiliKisi2.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).YetkiliKisi2.FieldName).Value);
  THesapKarti(Table).WebSitesi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).WebSitesi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).WebSitesi.FieldName).Value);
  THesapKarti(Table).ePostaAdresi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).ePostaAdresi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).ePostaAdresi.FieldName).Value);
  THesapKarti(Table).MuhasebeTelefon.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MuhasebeTelefon.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MuhasebeTelefon.FieldName).Value);
  THesapKarti(Table).MuhasebeEPosta.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MuhasebeEPosta.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MuhasebeEPosta.FieldName).Value);
  THesapKarti(Table).NaceKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).NaceKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).NaceKodu.FieldName).Value);
  THesapKarti(Table).ParaBirimi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).ParaBirimi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).ParaBirimi.FieldName).Value);
  THesapKarti(Table).OzelBilgi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).OzelBilgi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).OzelBilgi.FieldName).Value);
  THesapKarti(Table).OdemeVadeGunSayisi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).OdemeVadeGunSayisi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).OdemeVadeGunSayisi.FieldName).Value);
  THesapKarti(Table).BolgeID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).BolgeID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).BolgeID.FieldName).Value);
  THesapKarti(Table).Bolge.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Bolge.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Bolge.FieldName).Value);
  THesapKarti(Table).IsEFaturaHesabi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).IsEFaturaHesabi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).IsEFaturaHesabi.FieldName).Value);
  THesapKarti(Table).IsAcikHesap.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).IsAcikHesap.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).IsAcikHesap.FieldName).Value);
  THesapKarti(Table).KrediLimiti.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).KrediLimiti.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).KrediLimiti.FieldName).Value);
  THesapKarti(Table).KategoriID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).KategoriID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).KategoriID.FieldName).Value);
  THesapKarti(Table).Kategori.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Kategori.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).Kategori.FieldName).Value);
  THesapKarti(Table).TemsilciGrubuId.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).TemsilciGrubuId.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).TemsilciGrubuId.FieldName).Value);
  THesapKarti(Table).TemsilciGrubu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).TemsilciGrubu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).TemsilciGrubu.FieldName).Value);
  THesapKarti(Table).MusteriTemsilcisiID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MusteriTemsilcisiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MusteriTemsilcisiID.FieldName).Value);
  THesapKarti(Table).MusteriTemsilcisi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MusteriTemsilcisi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MusteriTemsilcisi.FieldName).Value);
  THesapKarti(Table).IbanNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).IbanNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).IbanNo.FieldName).Value);
  THesapKarti(Table).IbanParaBirimi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).IbanParaBirimi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).IbanParaBirimi.FieldName).Value);
  THesapKarti(Table).MuhasebePlanKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MuhasebePlanKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).MuhasebePlanKodu.FieldName).Value);
end;

end.
