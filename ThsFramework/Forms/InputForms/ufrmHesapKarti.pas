unit ufrmHesapKarti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmHesapKarti = class(TfrmBaseInputDB)
    pgcHesapKarti: TPageControl;
    tsGenel: TTabSheet;
    tsAdres: TTabSheet;
    lblHesapKodu: TLabel;
    lblHesapIsmi: TLabel;
    lblHesapGrubu: TLabel;
    lblMukellefTipi: TLabel;
    lblMukellefAdi: TLabel;
    lblMukellefIkinciAdi: TLabel;
    lblMukellefSoyadi: TLabel;
    lblVergiDairesi: TLabel;
    lblVergiNo: TLabel;
    lblNaceKodu: TLabel;
    edtHesapKodu: TEdit;
    edtHesapIsmi: TEdit;
    edtHesapGrubu: TEdit;
    cbbMukellefTipi: TComboBox;
    edtMukellefAdi: TEdit;
    edtMukellefIkinciAdi: TEdit;
    edtMukellefSoyadi: TEdit;
    edtVergiDairesi: TEdit;
    edtVergiNo: TEdit;
    edtNaceKodu: TEdit;
    lblOdemeVadeGunSayisi: TLabel;
    lblIsAcikHesap: TLabel;
    lblKrediLimiti: TLabel;
    edtOdemeVadeGunSayisi: TEdit;
    chkIsAcikHesap: TCheckBox;
    edtKrediLimiti: TEdit;
    edtPostaKutusu: TEdit;
    edtPostaKodu: TEdit;
    edtBina: TEdit;
    edtSokak: TEdit;
    edtCadde: TEdit;
    edtMahalle: TEdit;
    edtIlce: TEdit;
    edtSehir: TEdit;
    edtUlke: TEdit;
    lblPostaKutusu: TLabel;
    lblPostaKodu: TLabel;
    lblBina: TLabel;
    lblSokak: TLabel;
    lblCadde: TLabel;
    lblMahalle: TLabel;
    lblIlce: TLabel;
    lblSehir: TLabel;
    lblUlke: TLabel;
    lblParaBirimi: TLabel;
    lblBolge: TLabel;
    lblKategori: TLabel;
    lblTemsilciGrubu: TLabel;
    lblMusteriTemsilcisi: TLabel;
    lblIbanNo: TLabel;
    cbbParaBirimi: TComboBox;
    edtBolge: TEdit;
    cbbKategori: TComboBox;
    cbbTemsilciGrubu: TComboBox;
    edtMusteriTemsilcisi: TEdit;
    edtIbanNo: TEdit;
    cbbIbanParaBirimi: TComboBox;
    tsIletisim: TTabSheet;
    tsDiger: TTabSheet;
    lblOzelBilgi: TLabel;
    mmoOzelBilgi: TMemo;
    chkIsEFaturaHesabi: TCheckBox;
    lblIsEFaturaHesabi: TLabel;
    lblYetkiliKisi2: TLabel;
    lblYetkiliKisi1: TLabel;
    lblTelefon1: TLabel;
    lblTelefon2: TLabel;
    lblTelefon3: TLabel;
    lblFaks: TLabel;
    lblWebSitesi: TLabel;
    lblePostaAdresi: TLabel;
    lblMuhasebeTelefon: TLabel;
    lblMuhasebeEPosta: TLabel;
    edtYetkiliKisi2: TEdit;
    edtYetkiliKisi1: TEdit;
    edtTelefon1: TEdit;
    edtTelefon2: TEdit;
    edtTelefon3: TEdit;
    edtFaks: TEdit;
    edtWebSitesi: TEdit;
    edtePostaAdresi: TEdit;
    edtMuhasebeTelefon: TEdit;
    edtMuhasebeEPosta: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.HesapKarti;

{$R *.dfm}

procedure TfrmHesapKarti.FormCreate(Sender: TObject);
begin
  THesapKarti(Table).HesapKodu.SetControlProperty(Table.TableName, edtHesapKodu);
  THesapKarti(Table).HesapIsmi.SetControlProperty(Table.TableName, edtHesapIsmi);
  THesapKarti(Table).HesapGrubu.SetControlProperty(Table.TableName, edtHesapGrubu);
  THesapKarti(Table).MukellefTipi.SetControlProperty(Table.TableName, cbbMukellefTipi);
  THesapKarti(Table).MukellefAdi.SetControlProperty(Table.TableName, edtMukellefAdi);
  THesapKarti(Table).MukellefIkinciAdi.SetControlProperty(Table.TableName, edtMukellefIkinciAdi);
  THesapKarti(Table).MukellefSoyadi.SetControlProperty(Table.TableName, edtMukellefSoyadi);
  THesapKarti(Table).Ulke.SetControlProperty(Table.TableName, edtUlke);
  THesapKarti(Table).Sehir.SetControlProperty(Table.TableName, edtSehir);
  THesapKarti(Table).VergiDairesi.SetControlProperty(Table.TableName, edtVergiDairesi);
  THesapKarti(Table).VergiNo.SetControlProperty(Table.TableName, edtVergiNo);
  THesapKarti(Table).Ilce.SetControlProperty(Table.TableName, edtIlce);
  THesapKarti(Table).Mahalle.SetControlProperty(Table.TableName, edtMahalle);
  THesapKarti(Table).Cadde.SetControlProperty(Table.TableName, edtCadde);
  THesapKarti(Table).Sokak.SetControlProperty(Table.TableName, edtSokak);
  THesapKarti(Table).Bina.SetControlProperty(Table.TableName, edtBina);
  THesapKarti(Table).PostaKodu.SetControlProperty(Table.TableName, edtPostaKodu);
  THesapKarti(Table).PostaKutusu.SetControlProperty(Table.TableName, edtPostaKutusu);
  THesapKarti(Table).Telefon1.SetControlProperty(Table.TableName, edtTelefon1);
  THesapKarti(Table).Telefon2.SetControlProperty(Table.TableName, edtTelefon2);
  THesapKarti(Table).Telefon3.SetControlProperty(Table.TableName, edtTelefon3);
  THesapKarti(Table).Faks.SetControlProperty(Table.TableName, edtFaks);
  THesapKarti(Table).YetkiliKisi1.SetControlProperty(Table.TableName, edtYetkiliKisi1);
  THesapKarti(Table).YetkiliKisi2.SetControlProperty(Table.TableName, edtYetkiliKisi2);
  THesapKarti(Table).WebSitesi.SetControlProperty(Table.TableName, edtWebSitesi);
  THesapKarti(Table).ePostaAdresi.SetControlProperty(Table.TableName, edtePostaAdresi);
  THesapKarti(Table).MuhasebeTelefon.SetControlProperty(Table.TableName, edtMuhasebeTelefon);
  THesapKarti(Table).MuhasebeEPosta.SetControlProperty(Table.TableName, edtMuhasebeEPosta);
  THesapKarti(Table).NaceKodu.SetControlProperty(Table.TableName, edtNaceKodu);
  THesapKarti(Table).ParaBirimi.SetControlProperty(Table.TableName, cbbParaBirimi);
  THesapKarti(Table).OzelBilgi.SetControlProperty(Table.TableName, mmoOzelBilgi);
  THesapKarti(Table).OdemeVadeGunSayisi.SetControlProperty(Table.TableName, edtOdemeVadeGunSayisi);
  THesapKarti(Table).Bolge.SetControlProperty(Table.TableName, edtBolge);
  THesapKarti(Table).KrediLimiti.SetControlProperty(Table.TableName, edtKrediLimiti);
  THesapKarti(Table).Kategori.SetControlProperty(Table.TableName, cbbKategori);
  THesapKarti(Table).TemsilciGrubu.SetControlProperty(Table.TableName, cbbTemsilciGrubu);
  THesapKarti(Table).MusteriTemsilcisi.SetControlProperty(Table.TableName, edtMusteriTemsilcisi);
  THesapKarti(Table).IbanNo.SetControlProperty(Table.TableName, edtIbanNo);
  THesapKarti(Table).IbanParaBirimi.SetControlProperty(Table.TableName, cbbIbanParaBirimi);

  inherited;
end;

procedure TfrmHesapKarti.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtHesapKodu.Text := FormatedVariantVal(THesapKarti(Table).HesapKodu.FieldType, THesapKarti(Table).HesapKodu.Value);
  edtHesapIsmi.Text := FormatedVariantVal(THesapKarti(Table).HesapIsmi.FieldType, THesapKarti(Table).HesapIsmi.Value);
  edtHesapGrubu.Text := FormatedVariantVal(THesapKarti(Table).HesapGrubu.FieldType, THesapKarti(Table).HesapGrubu.Value);
  cbbMukellefTipi.Text := FormatedVariantVal(THesapKarti(Table).MukellefTipi.FieldType, THesapKarti(Table).MukellefTipi.Value);
  edtMukellefAdi.Text := FormatedVariantVal(THesapKarti(Table).MukellefAdi.FieldType, THesapKarti(Table).MukellefAdi.Value);
  edtMukellefIkinciAdi.Text := FormatedVariantVal(THesapKarti(Table).MukellefIkinciAdi.FieldType, THesapKarti(Table).MukellefIkinciAdi.Value);
  edtMukellefSoyadi.Text := FormatedVariantVal(THesapKarti(Table).MukellefSoyadi.FieldType, THesapKarti(Table).MukellefSoyadi.Value);
  edtUlke.Text := FormatedVariantVal(THesapKarti(Table).Ulke.FieldType, THesapKarti(Table).Ulke.Value);
  edtSehir.Text := FormatedVariantVal(THesapKarti(Table).Sehir.FieldType, THesapKarti(Table).Sehir.Value);
  edtVergiDairesi.Text := FormatedVariantVal(THesapKarti(Table).VergiDairesi.FieldType, THesapKarti(Table).VergiDairesi.Value);
  edtVergiNo.Text := FormatedVariantVal(THesapKarti(Table).VergiNo.FieldType, THesapKarti(Table).VergiNo.Value);
  edtIlce.Text := FormatedVariantVal(THesapKarti(Table).Ilce.FieldType, THesapKarti(Table).Ilce.Value);
  edtMahalle.Text := FormatedVariantVal(THesapKarti(Table).Mahalle.FieldType, THesapKarti(Table).Mahalle.Value);
  edtCadde.Text := FormatedVariantVal(THesapKarti(Table).Cadde.FieldType, THesapKarti(Table).Cadde.Value);
  edtSokak.Text := FormatedVariantVal(THesapKarti(Table).Sokak.FieldType, THesapKarti(Table).Sokak.Value);
  edtBina.Text := FormatedVariantVal(THesapKarti(Table).Bina.FieldType, THesapKarti(Table).Bina.Value);
  edtPostaKodu.Text := FormatedVariantVal(THesapKarti(Table).PostaKodu.FieldType, THesapKarti(Table).PostaKodu.Value);
  edtPostaKutusu.Text := FormatedVariantVal(THesapKarti(Table).PostaKutusu.FieldType, THesapKarti(Table).PostaKutusu.Value);
  edtTelefon1.Text := FormatedVariantVal(THesapKarti(Table).Telefon1.FieldType, THesapKarti(Table).Telefon1.Value);
  edtTelefon2.Text := FormatedVariantVal(THesapKarti(Table).Telefon2.FieldType, THesapKarti(Table).Telefon2.Value);
  edtTelefon3.Text := FormatedVariantVal(THesapKarti(Table).Telefon3.FieldType, THesapKarti(Table).Telefon3.Value);
  edtFaks.Text := FormatedVariantVal(THesapKarti(Table).Faks.FieldType, THesapKarti(Table).Faks.Value);
  edtYetkiliKisi1.Text := FormatedVariantVal(THesapKarti(Table).YetkiliKisi1.FieldType, THesapKarti(Table).YetkiliKisi1.Value);
  edtYetkiliKisi2.Text := FormatedVariantVal(THesapKarti(Table).YetkiliKisi2.FieldType, THesapKarti(Table).YetkiliKisi2.Value);
  edtWebSitesi.Text := FormatedVariantVal(THesapKarti(Table).WebSitesi.FieldType, THesapKarti(Table).WebSitesi.Value);
  edtePostaAdresi.Text := FormatedVariantVal(THesapKarti(Table).ePostaAdresi.FieldType, THesapKarti(Table).ePostaAdresi.Value);
  edtMuhasebeTelefon.Text := FormatedVariantVal(THesapKarti(Table).MuhasebeTelefon.FieldType, THesapKarti(Table).MuhasebeTelefon.Value);
  edtMuhasebeEPosta.Text := FormatedVariantVal(THesapKarti(Table).MuhasebeEPosta.FieldType, THesapKarti(Table).MuhasebeEPosta.Value);
  edtNaceKodu.Text := FormatedVariantVal(THesapKarti(Table).NaceKodu.FieldType, THesapKarti(Table).NaceKodu.Value);
  cbbParaBirimi.Text := FormatedVariantVal(THesapKarti(Table).ParaBirimi.FieldType, THesapKarti(Table).ParaBirimi.Value);
  mmoOzelBilgi.Text := FormatedVariantVal(THesapKarti(Table).OzelBilgi.FieldType, THesapKarti(Table).OzelBilgi.Value);
  edtOdemeVadeGunSayisi.Text := FormatedVariantVal(THesapKarti(Table).OdemeVadeGunSayisi.FieldType, THesapKarti(Table).OdemeVadeGunSayisi.Value);
  edtBolge.Text := FormatedVariantVal(THesapKarti(Table).Bolge.FieldType, THesapKarti(Table).Bolge.Value);
  chkIsEFaturaHesabi.Checked := FormatedVariantVal(THesapKarti(Table).IsEFaturaHesabi.FieldType, THesapKarti(Table).IsEFaturaHesabi.Value);
  chkIsAcikHesap.Checked := FormatedVariantVal(THesapKarti(Table).IsAcikHesap.FieldType, THesapKarti(Table).IsAcikHesap.Value);
  edtKrediLimiti.Text := FormatedVariantVal(THesapKarti(Table).KrediLimiti.FieldType, THesapKarti(Table).KrediLimiti.Value);
  cbbKategori.Text := FormatedVariantVal(THesapKarti(Table).Kategori.FieldType, THesapKarti(Table).Kategori.Value);
  cbbTemsilciGrubu.Text := FormatedVariantVal(THesapKarti(Table).TemsilciGrubu.FieldType, THesapKarti(Table).TemsilciGrubu.Value);
  edtMusteriTemsilcisi.Text := FormatedVariantVal(THesapKarti(Table).MusteriTemsilcisi.FieldType, THesapKarti(Table).MusteriTemsilcisi.Value);
  edtIbanNo.Text := FormatedVariantVal(THesapKarti(Table).IbanNo.FieldType, THesapKarti(Table).IbanNo.Value);
  cbbIbanParaBirimi.Text := FormatedVariantVal(THesapKarti(Table).IbanParaBirimi.FieldType, THesapKarti(Table).IbanParaBirimi.Value);
end;

procedure TfrmHesapKarti.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      THesapKarti(Table).HesapKodu.Value := edtHesapKodu.Text;
      THesapKarti(Table).HesapIsmi.Value := edtHesapIsmi.Text;
      THesapKarti(Table).HesapGrubu.Value := edtHesapGrubu.Text;
      THesapKarti(Table).MukellefTipi.Value := cbbMukellefTipi.Text;
      THesapKarti(Table).MukellefAdi.Value := edtMukellefAdi.Text;
      THesapKarti(Table).MukellefIkinciAdi.Value := edtMukellefIkinciAdi.Text;
      THesapKarti(Table).MukellefSoyadi.Value := edtMukellefSoyadi.Text;
      THesapKarti(Table).Ulke.Value := edtUlke.Text;
      THesapKarti(Table).Sehir.Value := edtSehir.Text;
      THesapKarti(Table).VergiDairesi.Value := edtVergiDairesi.Text;
      THesapKarti(Table).VergiNo.Value := edtVergiNo.Text;
      THesapKarti(Table).Ilce.Value := edtIlce.Text;
      THesapKarti(Table).Mahalle.Value := edtMahalle.Text;
      THesapKarti(Table).Cadde.Value := edtCadde.Text;
      THesapKarti(Table).Sokak.Value := edtSokak.Text;
      THesapKarti(Table).Bina.Value := edtBina.Text;
      THesapKarti(Table).PostaKodu.Value := edtPostaKodu.Text;
      THesapKarti(Table).PostaKutusu.Value := edtPostaKutusu.Text;
      THesapKarti(Table).Telefon1.Value := edtTelefon1.Text;
      THesapKarti(Table).Telefon2.Value := edtTelefon2.Text;
      THesapKarti(Table).Telefon3.Value := edtTelefon3.Text;
      THesapKarti(Table).Faks.Value := edtFaks.Text;
      THesapKarti(Table).YetkiliKisi1.Value := edtYetkiliKisi1.Text;
      THesapKarti(Table).YetkiliKisi2.Value := edtYetkiliKisi2.Text;
      THesapKarti(Table).WebSitesi.Value := edtWebSitesi.Text;
      THesapKarti(Table).ePostaAdresi.Value := edtePostaAdresi.Text;
      THesapKarti(Table).MuhasebeTelefon.Value := edtMuhasebeTelefon.Text;
      THesapKarti(Table).MuhasebeEPosta.Value := edtMuhasebeEPosta.Text;
      THesapKarti(Table).NaceKodu.Value := edtNaceKodu.Text;
      THesapKarti(Table).ParaBirimi.Value := cbbParaBirimi.Text;
      THesapKarti(Table).OzelBilgi.Value := mmoOzelBilgi.Text;
      THesapKarti(Table).OdemeVadeGunSayisi.Value := edtOdemeVadeGunSayisi.Text;
      THesapKarti(Table).Bolge.Value := edtBolge.Text;
      THesapKarti(Table).IsEFaturaHesabi.Value := chkIsEFaturaHesabi.Checked;
      THesapKarti(Table).IsAcikHesap.Value := chkIsAcikHesap.Checked;
      THesapKarti(Table).KrediLimiti.Value := edtKrediLimiti.Text;
      THesapKarti(Table).Kategori.Value := cbbKategori.Text;
      THesapKarti(Table).TemsilciGrubu.Value := cbbTemsilciGrubu.Text;
      THesapKarti(Table).MusteriTemsilcisi.Value := edtMusteriTemsilcisi.Text;
      THesapKarti(Table).IbanNo.Value := edtIbanNo.Text;
      THesapKarti(Table).IbanParaBirimi.Value := cbbIbanParaBirimi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
