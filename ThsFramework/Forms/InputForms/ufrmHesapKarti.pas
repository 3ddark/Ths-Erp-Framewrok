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

  ufrmBase, ufrmBaseInputDB

  , Ths.Erp.Database.Table.HesapGrubu
  , Ths.Erp.Database.Table.AyarHesapTipi
  , Ths.Erp.Database.Table.PersonelKarti
  , Ths.Erp.Database.Table.Bolge
  , Ths.Erp.Database.Table.HesapPlani
  , Ths.Erp.Database.Table.AyarMukellefTipi
  , Ths.Erp.Database.Table.Ulke
  , Ths.Erp.Database.Table.Sehir
  , Ths.Erp.Database.Table.MusteriTemsilciGrubu
  , Ths.Erp.Database.Table.ParaBirimi
  ;

type
  TfrmHesapKarti = class(TfrmBaseInputDB)
    pgcHesapKarti: TPageControl;
    tsGenel: TTabSheet;
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
    lblParaBirimi: TLabel;
    lblBolge: TLabel;
    lblTemsilciGrubu: TLabel;
    lblMusteriTemsilcisi: TLabel;
    lblIbanNo: TLabel;
    lblIsEFaturaHesabi: TLabel;
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
    cbbParaBirimi: TComboBox;
    cbbTemsilciGrubu: TComboBox;
    edtMusteriTemsilcisi: TEdit;
    edtIbanNo: TEdit;
    cbbIbanParaBirimi: TComboBox;
    chkIsEFaturaHesabi: TCheckBox;
    edtBolge: TEdit;
    tsAdres: TTabSheet;
    lblPostaKutusu: TLabel;
    lblBina: TLabel;
    lblSokak: TLabel;
    lblCadde: TLabel;
    lblMahalle: TLabel;
    lblIlce: TLabel;
    lblSehir: TLabel;
    lblUlke: TLabel;
    lblPostaKodu: TLabel;
    lblKapiNo: TLabel;
    edtUlke: TEdit;
    edtSehir: TEdit;
    edtIlce: TEdit;
    edtMahalle: TEdit;
    edtCadde: TEdit;
    edtSokak: TEdit;
    edtBina: TEdit;
    edtKapiNo: TEdit;
    edtPostaKutusu: TEdit;
    edtPostaKodu: TEdit;
    tsIletisim: TTabSheet;
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
    lblYetkiliKisi2Telefon: TLabel;
    lblYetkiliKisi1Telefon: TLabel;
    lblOzelBilgi: TLabel;
    Label3: TLabel;
    edtYetkiliKisi1: TEdit;
    edtYetkiliKisi1Telefon: TEdit;
    edtYetkiliKisi2: TEdit;
    edtYetkiliKisi2Telefon: TEdit;
    edtTelefon1: TEdit;
    edtTelefon2: TEdit;
    edtTelefon3: TEdit;
    edtFaks: TEdit;
    edtWebSitesi: TEdit;
    edtePostaAdresi: TEdit;
    edtMuhasebeTelefon: TEdit;
    edtMuhasebeEPosta: TEdit;
    mmoOzelBilgi: TMemo;
    Edit3: TEdit;
    tsDiger: TTabSheet;
    lblOdemeVadeGunSayisi: TLabel;
    lblIsAcikHesap: TLabel;
    lblKrediLimiti: TLabel;
    lblHesapIskonto: TLabel;
    edtOdemeVadeGunSayisi: TEdit;
    chkIsAcikHesap: TCheckBox;
    edtKrediLimiti: TEdit;
    edtHesapIskonto: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure cbbMukellefTipiChange(Sender: TObject);
    procedure FormShow(Sender: TObject);override;
  private
    vAyarHesapTipi: TAyarHesapTipi;
    vHesapGrubu: THesapGrubu;
    vBolge: TBolge;
    vMusteriTemsilciGrubu: TMusteriTemsilciGrubu;
    vMukellefTipi: TAyarMukellefTipi;
    vMusteriTemsilcisi: TPersonelKarti;
    vUlke: TUlke;
    vSehir: TSehir;
    vHesapPlani: THesapPlani;
    vParaBirimi: TParaBirimi;
  public
    destructor Destroy; override;
  protected
    procedure HelperProcess(Sender: TObject); override;
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton
  , Ths.Erp.Database.Table.HesapKarti
  , ufrmHelperHesapGrubu
  , ufrmHelperUlke
  , ufrmHelperSehir
  , ufrmHelperBolge
  , ufrmHelperPersonelKarti
  ;

{$R *.dfm}

procedure TfrmHesapKarti.cbbMukellefTipiChange(Sender: TObject);
begin
  inherited;
  if cbbMukellefTipi.Text = 'TCKN' then
  begin
    lblMukellefAdi.Visible := True;
    edtMukellefAdi.Visible := True;
    lblMukellefIkinciAdi.Visible := True;
    edtMukellefIkinciAdi.Visible := True;
    lblMukellefSoyadi.Visible := True;
    edtMukellefSoyadi.Visible := True;
  end
  else
  begin
    lblMukellefAdi.Visible := False;
    edtMukellefAdi.Visible := False;
    lblMukellefIkinciAdi.Visible := False;
    edtMukellefIkinciAdi.Visible := False;
    lblMukellefSoyadi.Visible := False;
    edtMukellefSoyadi.Visible := False;

    edtMukellefAdi.Clear;
    edtMukellefIkinciAdi.Clear;
    edtMukellefSoyadi.Clear;
  end;
end;

destructor TfrmHesapKarti.Destroy;
begin
  if Assigned(vAyarHesapTipi) then
    vAyarHesapTipi.Free;
  if Assigned(vHesapGrubu) then
    vHesapGrubu.Free;
  if Assigned(vBolge) then
    vBolge.Free;
  if Assigned(vMusteriTemsilciGrubu) then
    vMusteriTemsilciGrubu.Free;
  if Assigned(vMukellefTipi) then
    vMukellefTipi.Free;
  if Assigned(vMusteriTemsilcisi) then
    vMusteriTemsilcisi.Free;
  if Assigned(vUlke) then
    vUlke.Free;
  if Assigned(vSehir) then
    vSehir.Free;
  if Assigned(vHesapPlani) then
    vHesapPlani.Free;
  if Assigned(vParaBirimi) then
    vParaBirimi.Free;

  inherited;
end;

procedure TfrmHesapKarti.FormCreate(Sender: TObject);
var
  n1: Integer;
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
  THesapKarti(Table).Yetkili1.SetControlProperty(Table.TableName, edtYetkiliKisi1);
  THesapKarti(Table).Yetkili1Tel.SetControlProperty(Table.TableName, edtYetkiliKisi1Telefon);
  THesapKarti(Table).Yetkili2.SetControlProperty(Table.TableName, edtYetkiliKisi2);
  THesapKarti(Table).Yetkili2Tel.SetControlProperty(Table.TableName, edtYetkiliKisi2Telefon);
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
  THesapKarti(Table).TemsilciGrubu.SetControlProperty(Table.TableName, cbbTemsilciGrubu);
  THesapKarti(Table).MusteriTemsilcisi.SetControlProperty(Table.TableName, edtMusteriTemsilcisi);
  THesapKarti(Table).Iban.SetControlProperty(Table.TableName, edtIbanNo);
  THesapKarti(Table).IbanPara.SetControlProperty(Table.TableName, cbbIbanParaBirimi);

  inherited;

  vAyarHesapTipi := TAyarHesapTipi.Create(Table.Database);
  vHesapGrubu := THesapGrubu.Create(Table.Database);
  vBolge := TBolge.Create(Table.Database);
  vMusteriTemsilciGrubu := TMusteriTemsilciGrubu.Create(Table.Database);
  vMukellefTipi := TAyarMukellefTipi.Create(Table.Database);
  vMusteriTemsilcisi := TPersonelKarti.Create(Table.Database);
  vUlke := TUlke.Create(Table.Database);
  vSehir := TSehir.Create(Table.Database);
  vHesapPlani := THesapPlani.Create(Table.Database);
  vParaBirimi := TParaBirimi.Create(Table.Database);


  fillComboBoxData(cbbTemsilciGrubu, vMusteriTemsilciGrubu, vMusteriTemsilciGrubu.TemsilciGrupAdi.FieldName, '', True);
  fillComboBoxData(cbbMukellefTipi, vMukellefTipi, vMukellefTipi.Deger.FieldName, '', True);
  for n1 := 0 to cbbMukellefTipi.Items.Count-1 do
  begin
    if TAyarMukellefTipi(cbbMukellefTipi.Items.Objects[n1]).IsDefault.Value then
    begin
      cbbMukellefTipi.ItemIndex := n1;
      Break;
    end;
  end;
  cbbMukellefTipiChange(cbbMukellefTipi);

  fillComboBoxData(cbbParaBirimi, vParaBirimi, vParaBirimi.Kod.FieldName, '', True);
  for n1 := 0 to cbbParaBirimi.Items.Count-1 do
  begin
    if TParaBirimi(cbbParaBirimi.Items.Objects[n1]).IsVarsayilan.Value then
    begin
      cbbParaBirimi.ItemIndex := n1;
      Break;
    end;
  end;

  fillComboBoxData(cbbIbanParaBirimi, vParaBirimi, vParaBirimi.Kod.FieldName, '', True);
  for n1 := 0 to cbbIbanParaBirimi.Items.Count-1 do
  begin
    if TParaBirimi(cbbIbanParaBirimi.Items.Objects[n1]).IsVarsayilan.Value then
    begin
      cbbIbanParaBirimi.ItemIndex := n1;
      Break;
    end;
  end;

  vMusteriTemsilcisi.SelectToList('', False, False);
//  edtMusteriTemsilcisi.Text := vMusteriTemsilcisi.PersonelAd.Value + ' ' + vMusteriTemsilcisi.PersonelSoyad.Value;
end;

procedure TfrmHesapKarti.FormShow(Sender: TObject);
begin
  inherited;

  edtUlke.ReadOnly := True;

  edtHesapGrubu.OnHelperProcess := HelperProcess;
  edtHesapGrubu.thsInputDataType := itString;
  edtHesapGrubu.ReadOnly := True;

  edtSehir.OnHelperProcess := HelperProcess;
  edtSehir.thsInputDataType := itString;
  edtSehir.ReadOnly := True;

  edtBolge.OnHelperProcess := HelperProcess;
  edtBolge.thsInputDataType := itString;
  edtBolge.ReadOnly := True;

  edtMusteriTemsilcisi.OnHelperProcess := HelperProcess;
  edtMusteriTemsilcisi.thsInputDataType := itString;
  edtMusteriTemsilcisi.ReadOnly := True;
end;

procedure TfrmHesapKarti.HelperProcess(Sender: TObject);
var
  vHelperHesapGrubu: TfrmHelperHesapGrubu;
  vHelperBolge: TfrmHelperBolge;
  vHelperSehir: TfrmHelperSehir;
  vHelperMusteriTemsilcisi: TfrmHelperPersonelKarti;
begin
  if Sender.ClassType = TEdit then
  begin
    if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
    begin
      if TEdit(Sender).Name = edtHesapGrubu.Name then
      begin
        vHelperHesapGrubu := TfrmHelperHesapGrubu.Create(edtHesapGrubu, Self, THesapGrubu.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperHesapGrubu.ShowModal;
          if Assigned(vHesapGrubu) then vHesapGrubu.Free;
          vHesapGrubu := vHelperHesapGrubu.Table.Clone as THesapGrubu;
        finally
          vHelperHesapGrubu.Free;
        end;
      end
      else if TEdit(Sender).Name = edtBolge.Name then
      begin
        vHelperBolge := TfrmHelperBolge.Create(edtBolge, Self, TBolge.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperBolge.ShowModal;
          if Assigned(vBolge) then  vBolge.Free;
          vBolge := vHelperBolge.Table.Clone as TBolge;
        finally
          vHelperBolge.Free;
        end;
      end
      else if TEdit(Sender).Name = edtSehir.Name then
      begin
        vHelperSehir := TfrmHelperSehir.Create(edtSehir, Self, TSehir.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperSehir.ShowModal;

          if Assigned(vSehir) then  vSehir.Free;
          vSehir := vHelperSehir.Table.Clone as TSehir;
          edtUlke.Text := vSehir.UlkeAdi.Value;
        finally
          vHelperSehir.Free;
        end;
      end
      else if TEdit(Sender).Name = edtMusteriTemsilcisi.Name then
      begin
        vHelperMusteriTemsilcisi := TfrmHelperPersonelKarti.Create(edtMusteriTemsilcisi, Self, TPersonelKarti.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperMusteriTemsilcisi.ShowModal;

          if Assigned(vMusteriTemsilcisi) then  vMusteriTemsilcisi.Free;
          vMusteriTemsilcisi := vHelperMusteriTemsilcisi.Table.Clone as TPersonelKarti;
          edtMusteriTemsilcisi.Text := vMusteriTemsilcisi.PersonelAdSoyad.Value;
        finally
          vHelperMusteriTemsilcisi.Free;
        end;
      end;

    end;
  end
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
  vSehir.SelectToList(' AND ' + vSehir.TableName + '.' + vSehir.Id.FieldName + '=' + IntToStr(THesapKarti(Table).SehirID.Value), False, False);

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
  edtYetkiliKisi1.Text := FormatedVariantVal(THesapKarti(Table).Yetkili1.FieldType, THesapKarti(Table).Yetkili1.Value);
  edtYetkiliKisi1Telefon.Text := FormatedVariantVal(THesapKarti(Table).Yetkili1.FieldType, THesapKarti(Table).Yetkili1Tel.Value);
  edtYetkiliKisi2.Text := FormatedVariantVal(THesapKarti(Table).Yetkili2.FieldType, THesapKarti(Table).Yetkili2.Value);
  edtYetkiliKisi2Telefon.Text := FormatedVariantVal(THesapKarti(Table).Yetkili2Tel.FieldType, THesapKarti(Table).Yetkili2Tel.Value);
  edtWebSitesi.Text := FormatedVariantVal(THesapKarti(Table).WebSitesi.FieldType, THesapKarti(Table).WebSitesi.Value);
  edtePostaAdresi.Text := FormatedVariantVal(THesapKarti(Table).ePostaAdresi.FieldType, THesapKarti(Table).ePostaAdresi.Value);
  edtMuhasebeTelefon.Text := FormatedVariantVal(THesapKarti(Table).MuhasebeTelefon.FieldType, THesapKarti(Table).MuhasebeTelefon.Value);
  edtMuhasebeEPosta.Text := FormatedVariantVal(THesapKarti(Table).MuhasebeEPosta.FieldType, THesapKarti(Table).MuhasebeEPosta.Value);
  edtNaceKodu.Text := FormatedVariantVal(THesapKarti(Table).NaceKodu.FieldType, THesapKarti(Table).NaceKodu.Value);
  cbbParaBirimi.Text := FormatedVariantVal(THesapKarti(Table).ParaBirimi.FieldType, THesapKarti(Table).ParaBirimi.Value);
  mmoOzelBilgi.Text := FormatedVariantVal(THesapKarti(Table).OzelBilgi.FieldType, THesapKarti(Table).OzelBilgi.Value);
  edtOdemeVadeGunSayisi.Text := FormatedVariantVal(THesapKarti(Table).OdemeVadeGunSayisi.FieldType, THesapKarti(Table).OdemeVadeGunSayisi.Value);

  edtBolge.Text := FormatedVariantVal(THesapKarti(Table).Bolge.FieldType, THesapKarti(Table).Bolge.Value);
  vBolge.SelectToList(' AND ' + vBolge.TableName + '.' + vBolge.Id.FieldName + '=' + IntToStr(THesapKarti(Table).BolgeID.Value), False, False);

  chkIsEFaturaHesabi.Checked := FormatedVariantVal(THesapKarti(Table).IsEFaturaHesabi.FieldType, THesapKarti(Table).IsEFaturaHesabi.Value);
  chkIsAcikHesap.Checked := FormatedVariantVal(THesapKarti(Table).IsAcikHesap.FieldType, THesapKarti(Table).IsAcikHesap.Value);
  edtKrediLimiti.Text := FormatedVariantVal(THesapKarti(Table).KrediLimiti.FieldType, THesapKarti(Table).KrediLimiti.Value);
  cbbTemsilciGrubu.Text := FormatedVariantVal(THesapKarti(Table).TemsilciGrubu.FieldType, THesapKarti(Table).TemsilciGrubu.Value);
  edtMusteriTemsilcisi.Text := FormatedVariantVal(THesapKarti(Table).MusteriTemsilcisi.FieldType, THesapKarti(Table).MusteriTemsilcisi.Value);
  edtIbanNo.Text := FormatedVariantVal(THesapKarti(Table).Iban.FieldType, THesapKarti(Table).Iban.Value);
  cbbIbanParaBirimi.Text := FormatedVariantVal(THesapKarti(Table).IbanPara.FieldType, THesapKarti(Table).IbanPara.Value);
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
      THesapKarti(Table).UlkeID.Value := vSehir.UlkeID.Value;
      THesapKarti(Table).SehirID.Value := vSehir.Id.Value;

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
      THesapKarti(Table).Yetkili1.Value := edtYetkiliKisi1.Text;
      THesapKarti(Table).Yetkili1Tel.Value := edtYetkiliKisi1Telefon.Text;
      THesapKarti(Table).Yetkili2.Value := edtYetkiliKisi2.Text;
      THesapKarti(Table).Yetkili2Tel.Value := edtYetkiliKisi2Telefon.Text;
      THesapKarti(Table).WebSitesi.Value := edtWebSitesi.Text;
      THesapKarti(Table).ePostaAdresi.Value := edtePostaAdresi.Text;
      THesapKarti(Table).MuhasebeTelefon.Value := edtMuhasebeTelefon.Text;
      THesapKarti(Table).MuhasebeEPosta.Value := edtMuhasebeEPosta.Text;
      THesapKarti(Table).NaceKodu.Value := edtNaceKodu.Text;
      THesapKarti(Table).ParaBirimi.Value := cbbParaBirimi.Text;
      THesapKarti(Table).OzelBilgi.Value := mmoOzelBilgi.Text;
      THesapKarti(Table).OdemeVadeGunSayisi.Value := edtOdemeVadeGunSayisi.Text;

      THesapKarti(Table).Bolge.Value := edtBolge.Text;
      THesapKarti(Table).BolgeID.Value := vBolge.Id.Value;

      THesapKarti(Table).IsEFaturaHesabi.Value := chkIsEFaturaHesabi.Checked;
      THesapKarti(Table).IsAcikHesap.Value := chkIsAcikHesap.Checked;
      THesapKarti(Table).KrediLimiti.Value := edtKrediLimiti.Text;
      THesapKarti(Table).TemsilciGrubu.Value := cbbTemsilciGrubu.Text;
      THesapKarti(Table).MusteriTemsilcisi.Value := edtMusteriTemsilcisi.Text;
      THesapKarti(Table).Iban.Value := edtIbanNo.Text;
      THesapKarti(Table).IbanPara.Value := cbbIbanParaBirimi.Text;

      inherited;
    end;
  end
  else
    inherited;
end;

end.
