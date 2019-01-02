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
  , Ths.Erp.Database.Table.Adres

  , ufrmHelperSehir
  , ufrmHelperUlke
  , ufrmHelperHesapGrubu
  , ufrmHelperBolge
  , ufrmHelperPersonelKarti
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
    lblFaks: TLabel;
    lblWebSitesi: TLabel;
    lblePostaAdresi: TLabel;
    lblMuhasebeTelefon: TLabel;
    lblMuhasebeEPosta: TLabel;
    lblYetkiliKisi2Telefon: TLabel;
    lblYetkiliKisi1Telefon: TLabel;
    lblOzelBilgi: TLabel;
    Label3: TLabel;
    tsDiger: TTabSheet;
    lblOdemeVadeGunSayisi: TLabel;
    lblIsAcikHesap: TLabel;
    lblKrediLimiti: TLabel;
    lblHesapIskonto: TLabel;
    edtOdemeVadeGunSayisi: TEdit;
    chkIsAcikHesap: TCheckBox;
    edtKrediLimiti: TEdit;
    edtHesapIskonto: TEdit;
    lblYetkiliKisi3: TLabel;
    lblYetkiliKisi3Telefon: TLabel;
    lblMuhasebeKodu: TLabel;
    edtHesapKodu: TEdit;
    edtMuhasebeKodu: TEdit;
    edtHesapIsmi: TEdit;
    edtHesapGrubu: TEdit;
    edtBolge: TEdit;
    edtTemsilciGrubu: TEdit;
    edtMukellefTipi: TEdit;
    edtVergiDairesi: TEdit;
    edtVergiNo: TEdit;
    edtMukellefAdi: TEdit;
    edtMukellefIkinciAdi: TEdit;
    edtMukellefSoyadi: TEdit;
    edtParaBirimi: TEdit;
    edtIbanNo: TEdit;
    edtIbanParaBirimi: TEdit;
    edtMusteriTemsilcisi: TEdit;
    edtNaceKodu: TEdit;
    chkIsEFaturaHesabi: TCheckBox;
    lblEFaturaPKName: TLabel;
    edtEFaturaPKName: TEdit;
    edtYetkiliKisi1: TEdit;
    edtYetkiliKisi1Telefon: TEdit;
    edtYetkiliKisi2: TEdit;
    edtYetkiliKisi2Telefon: TEdit;
    edtYetkiliKisi3: TEdit;
    edtYetkiliKisi3Telefon: TEdit;
    edtFaks: TEdit;
    edtWebSitesi: TEdit;
    edtMuhasebeTelefon: TEdit;
    edtePostaAdresi: TEdit;
    edtMuhasebeEPosta: TEdit;
    Edit3: TEdit;
    mmoOzelBilgi: TMemo;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure FormShow(Sender: TObject);override;
    procedure edtMukellefTipiChange(Sender: TObject);
  private
    vHelperSehir: TfrmHelperSehir;
    vHelperHesapGrubu: TfrmHelperHesapGrubu;
    vHelperBolge: TfrmHelperBolge;
    vHelperMusteriTemsilcisi: TfrmHelperPersonelKarti;
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
  ;

{$R *.dfm}

destructor TfrmHesapKarti.Destroy;
begin
  inherited;
end;

procedure TfrmHesapKarti.edtMukellefTipiChange(Sender: TObject);
begin
  inherited;
  if edtMukellefTipi.Text = 'TCKN' then
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

procedure TfrmHesapKarti.FormCreate(Sender: TObject);
//var
//  n1: Integer;
begin
  THesapKarti(Table).HesapKodu.SetControlProperty(Table.TableName, edtHesapKodu);
  THesapKarti(Table).HesapIsmi.SetControlProperty(Table.TableName, edtHesapIsmi);
  THesapKarti(Table).MuhasebeKodu.SetControlProperty(Table.TableName, edtMuhasebeKodu);
//  THesapKarti(Table).HesapGrubuID.FK.FKCol.SetControlProperty(Table.TableName, edtHesapGrubu);
//  THesapKarti(Table).BolgeID.FK.FKCol.SetControlProperty(Table.TableName, edtBolge);
//  THesapKarti(Table).TemsilciGrubuID.FK.FKCol.SetControlProperty(Table.TableName, edtTemsilciGrubu);
//  THesapKarti(Table).MukellefTipiID.FK.FKCol.SetControlProperty(Table.TableName, edtMukellefTipi);
//  THesapKarti(Table).VergiDairesi.SetControlProperty(Table.TableName, edtVergiDairesi);
//  THesapKarti(Table).VergiNo.SetControlProperty(Table.TableName, edtVergiNo);
//  THesapKarti(Table).MukellefAdi.SetControlProperty(Table.TableName, edtMukellefAdi);
//  THesapKarti(Table).MukellefIkinciAdi.SetControlProperty(Table.TableName, edtMukellefIkinciAdi);
//  THesapKarti(Table).MukellefSoyadi.SetControlProperty(Table.TableName, edtMukellefSoyadi);
//  THesapKarti(Table).ParaBirimi.SetControlProperty(Table.TableName, edtParaBirimi);
//  THesapKarti(Table).IbanPara.SetControlProperty(Table.TableName, edtIbanParaBirimi);
//  THesapKarti(Table).Iban.SetControlProperty(Table.TableName, edtIbanNo);
//  THesapKarti(Table).MusteriTemsilcisiID.SetControlProperty(Table.TableName, edtMusteriTemsilcisi);
//  THesapKarti(Table).NaceKodu.SetControlProperty(Table.TableName, edtNaceKodu);
//
//  TAdres(THesapKarti(Table).AdresID.FK.FKTable).UlkeID.SetControlProperty(Table.TableName, edtUlke);
//  TAdres(THesapKarti(Table).AdresID.FK.FKTable).SehirID.SetControlProperty(Table.TableName, edtSehir);
//  THesapKarti(Table).Adres.Ilce.SetControlProperty(Table.TableName, edtIlce);
//  THesapKarti(Table).Adres.Mahalle.SetControlProperty(Table.TableName, edtMahalle);
//  THesapKarti(Table).Adres.Cadde.SetControlProperty(Table.TableName, edtCadde);
//  THesapKarti(Table).Adres.Sokak.SetControlProperty(Table.TableName, edtSokak);
//  THesapKarti(Table).Adres.Bina.SetControlProperty(Table.TableName, edtBina);
//  THesapKarti(Table).Adres.PostaKodu.SetControlProperty(Table.TableName, edtPostaKodu);
//  THesapKarti(Table).Adres.PostaKutusu.SetControlProperty(Table.TableName, edtPostaKutusu);
//  THesapKarti(Table).Adres.WebSitesi.SetControlProperty(Table.TableName, edtWebSitesi);
//  THesapKarti(Table).Adres.ePostaAdresi.SetControlProperty(Table.TableName, edtePostaAdresi);
//
//  THesapKarti(Table).Faks.SetControlProperty(Table.TableName, edtFaks);
//  THesapKarti(Table).Yetkili1.SetControlProperty(Table.TableName, edtYetkiliKisi1);
//  THesapKarti(Table).Yetkili1Tel.SetControlProperty(Table.TableName, edtYetkiliKisi1Telefon);
//  THesapKarti(Table).Yetkili2.SetControlProperty(Table.TableName, edtYetkiliKisi2);
//  THesapKarti(Table).Yetkili2Tel.SetControlProperty(Table.TableName, edtYetkiliKisi2Telefon);
//  THesapKarti(Table).Yetkili3.SetControlProperty(Table.TableName, edtYetkiliKisi2);
//  THesapKarti(Table).Yetkili3Tel.SetControlProperty(Table.TableName, edtYetkiliKisi2Telefon);
//  THesapKarti(Table).MuhasebeTelefon.SetControlProperty(Table.TableName, edtMuhasebeTelefon);
//  THesapKarti(Table).MuhasebeEPosta.SetControlProperty(Table.TableName, edtMuhasebeEPosta);
//  THesapKarti(Table).OzelBilgi.SetControlProperty(Table.TableName, mmoOzelBilgi);
//  THesapKarti(Table).OdemeVadeGunSayisi.SetControlProperty(Table.TableName, edtOdemeVadeGunSayisi);
//  THesapKarti(Table).BolgeID.SetControlProperty(Table.TableName, edtBolge);
//  THesapKarti(Table).KrediLimiti.SetControlProperty(Table.TableName, edtKrediLimiti);

  inherited;
end;

procedure TfrmHesapKarti.FormShow(Sender: TObject);
begin
  inherited;

  edtUlke.ReadOnly := True;

  edtSehir.OnHelperProcess := HelperProcess;
  edtHesapGrubu.OnHelperProcess := HelperProcess;
  edtBolge.OnHelperProcess := HelperProcess;
  edtMusteriTemsilcisi.OnHelperProcess := HelperProcess;
end;

procedure TfrmHesapKarti.HelperProcess(Sender: TObject);
begin
  if Sender.ClassType = TEdit then
  begin
    if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
    begin
      if TEdit(Sender).Name = edtSehir.Name then
      begin
        vHelperSehir := TfrmHelperSehir.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperSehir.ShowModal;

          if Assigned(THesapKarti(Table).Adres.SehirID.FK.FKTable) then
            THesapKarti(Table).Adres.SehirID.FK.FKTable.Free;
          THesapKarti(Table).Adres.SehirID.FK.FKTable := vHelperSehir.Table.Clone;
          edtUlke.Text := TSehir(THesapKarti(Table).Adres.SehirID.FK.FKTable).UlkeID.FK.FKCol.Value;
        finally
          vHelperSehir.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtHesapGrubu.Name then
      begin
        vHelperHesapGrubu := TfrmHelperHesapGrubu.Create(TEdit(Sender), Self, THesapGrubu.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperHesapGrubu.ShowModal;
          if Assigned(THesapKarti(Table).HesapGrubuID.FK.FKTable) then
            THesapKarti(Table).HesapGrubuID.FK.FKTable.Free;
          THesapKarti(Table).HesapGrubuID.FK.FKTable := vHelperHesapGrubu.Table.Clone;
        finally
          vHelperHesapGrubu.Free;
        end;
      end
      else if TEdit(Sender).Name = edtBolge.Name then
      begin
        vHelperBolge := TfrmHelperBolge.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperBolge.ShowModal;

          if Assigned(THesapKarti(Table).BolgeID.FK.FKTable) then
            THesapKarti(Table).BolgeID.FK.FKTable.Free;
          THesapKarti(Table).BolgeID.FK.FKTable := vHelperBolge.Table.Clone;
        finally
          vHelperBolge.Free;
        end;
      end
      else if TEdit(Sender).Name = edtMusteriTemsilcisi.Name then
      begin
        vHelperMusteriTemsilcisi := TfrmHelperPersonelKarti.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperMusteriTemsilcisi.ShowModal;

          if Assigned(THesapKarti(Table).MusteriTemsilcisiID.FK.FKTable) then
            THesapKarti(Table).MusteriTemsilcisiID.FK.FKTable.Free;
          THesapKarti(Table).MusteriTemsilcisiID.FK.FKTable := vHelperMusteriTemsilcisi.Table.Clone;
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
  edtHesapGrubu.Text := FormatedVariantVal(THesapKarti(Table).HesapGrubuID.FK.FKCol.FieldType, THesapKarti(Table).HesapGrubuID.FK.FKCol.Value);
//  edtMukellefTipi.Text := FormatedVariantVal(THesapKarti(Table).MukellefTipiID.FK.FKColName, THesapKarti(Table).MukellefTipiID.FK.FKValue);
//  edtMukellefAdi.Text := FormatedVariantVal(THesapKarti(Table).MukellefAdi.FieldType, THesapKarti(Table).MukellefAdi.Value);
//  edtMukellefIkinciAdi.Text := FormatedVariantVal(THesapKarti(Table).MukellefIkinciAdi.FieldType, THesapKarti(Table).MukellefIkinciAdi.Value);
//  edtMukellefSoyadi.Text := FormatedVariantVal(THesapKarti(Table).MukellefSoyadi.FieldType, THesapKarti(Table).MukellefSoyadi.Value);
//  edtUlke.Text :=
//    FormatedVariantVal(
//        TUlke(THesapKarti(Table).UlkeID.FK.FKTable).UlkeAdi.FieldType,
//        TUlke(THesapKarti(Table).UlkeID.FK.FKTable).UlkeAdi.Value
//    );
//  edtSehir.Text :=
//    FormatedVariantVal(
//        TSehir(THesapKarti(Table).SehirID.FK.FKTable).SehirAdi.FieldType,
//        TSehir(THesapKarti(Table).SehirID.FK.FKTable).SehirAdi.Value
//    );
//  edtIlce.Text := THesapKarti(Table).Ilce.Value;
//  edtMahalle.Text := THesapKarti(Table).Mahalle.Value;
//  edtCadde.Text := THesapKarti(Table).Cadde.Value;
//  edtSokak.Text := THesapKarti(Table).Sokak.Value;
//  edtBina.Text := THesapKarti(Table).Bina.Value;
//  edtKapiNo.Text := THesapKarti(Table).KapiNo.Value;
//  edtPostaKodu.Text := THesapKarti(Table).PostaKodu.Value;
//  edtPostaKutusu.Text := THesapKarti(Table).PostaKutusu.Value;
//  vSehir.SelectToList(' AND ' + vSehir.TableName + '.' + vSehir.Id.FieldName + '=' + IntToStr(THesapKarti(Table).SehirID.Value), False, False);
//  edtVergiDairesi.Text := FormatedVariantVal(THesapKarti(Table).VergiDairesi.FieldType, THesapKarti(Table).VergiDairesi.Value);
//  edtVergiNo.Text := FormatedVariantVal(THesapKarti(Table).VergiNo.FieldType, THesapKarti(Table).VergiNo.Value);
//  edtIlce.Text := FormatedVariantVal(THesapKarti(Table).Ilce.FieldType, THesapKarti(Table).Ilce.Value);
//  edtMahalle.Text := FormatedVariantVal(THesapKarti(Table).Mahalle.FieldType, THesapKarti(Table).Mahalle.Value);
//  edtCadde.Text := FormatedVariantVal(THesapKarti(Table).Cadde.FieldType, THesapKarti(Table).Cadde.Value);
//  edtSokak.Text := FormatedVariantVal(THesapKarti(Table).Sokak.FieldType, THesapKarti(Table).Sokak.Value);
//  edtBina.Text := FormatedVariantVal(THesapKarti(Table).Bina.FieldType, THesapKarti(Table).Bina.Value);
//  edtPostaKodu.Text := FormatedVariantVal(THesapKarti(Table).PostaKodu.FieldType, THesapKarti(Table).PostaKodu.Value);
//  edtPostaKutusu.Text := FormatedVariantVal(THesapKarti(Table).PostaKutusu.FieldType, THesapKarti(Table).PostaKutusu.Value);
//  edtTelefon1.Text := FormatedVariantVal(THesapKarti(Table).Telefon1.FieldType, THesapKarti(Table).Telefon1.Value);
//  edtTelefon2.Text := FormatedVariantVal(THesapKarti(Table).Telefon2.FieldType, THesapKarti(Table).Telefon2.Value);
//  edtTelefon3.Text := FormatedVariantVal(THesapKarti(Table).Telefon3.FieldType, THesapKarti(Table).Telefon3.Value);
//  edtFaks.Text := FormatedVariantVal(THesapKarti(Table).Faks.FieldType, THesapKarti(Table).Faks.Value);
//  edtYetkiliKisi1.Text := FormatedVariantVal(THesapKarti(Table).Yetkili1.FieldType, THesapKarti(Table).Yetkili1.Value);
//  edtYetkiliKisi1Telefon.Text := FormatedVariantVal(THesapKarti(Table).Yetkili1.FieldType, THesapKarti(Table).Yetkili1Tel.Value);
//  edtYetkiliKisi2.Text := FormatedVariantVal(THesapKarti(Table).Yetkili2.FieldType, THesapKarti(Table).Yetkili2.Value);
//  edtYetkiliKisi2Telefon.Text := FormatedVariantVal(THesapKarti(Table).Yetkili2Tel.FieldType, THesapKarti(Table).Yetkili2Tel.Value);
//  edtWebSitesi.Text := FormatedVariantVal(THesapKarti(Table).WebSitesi.FieldType, THesapKarti(Table).WebSitesi.Value);
//  edtePostaAdresi.Text := FormatedVariantVal(THesapKarti(Table).ePostaAdresi.FieldType, THesapKarti(Table).ePostaAdresi.Value);
//  edtMuhasebeTelefon.Text := FormatedVariantVal(THesapKarti(Table).MuhasebeTelefon.FieldType, THesapKarti(Table).MuhasebeTelefon.Value);
//  edtMuhasebeEPosta.Text := FormatedVariantVal(THesapKarti(Table).MuhasebeEPosta.FieldType, THesapKarti(Table).MuhasebeEPosta.Value);
//  edtNaceKodu.Text := FormatedVariantVal(THesapKarti(Table).NaceKodu.FieldType, THesapKarti(Table).NaceKodu.Value);
//  cbbParaBirimi.Text := FormatedVariantVal(THesapKarti(Table).ParaBirimi.FieldType, THesapKarti(Table).ParaBirimi.Value);
//  mmoOzelBilgi.Text := FormatedVariantVal(THesapKarti(Table).OzelBilgi.FieldType, THesapKarti(Table).OzelBilgi.Value);
//  edtOdemeVadeGunSayisi.Text := FormatedVariantVal(THesapKarti(Table).OdemeVadeGunSayisi.FieldType, THesapKarti(Table).OdemeVadeGunSayisi.Value);
//  edtBolge.Text := FormatedVariantVal(THesapKarti(Table).Bolge.FieldType, THesapKarti(Table).Bolge.Value);
//  vBolge.SelectToList(' AND ' + vBolge.TableName + '.' + vBolge.Id.FieldName + '=' + IntToStr(THesapKarti(Table).BolgeID.Value), False, False);
//  chkIsEFaturaHesabi.Checked := FormatedVariantVal(THesapKarti(Table).IsEFaturaHesabi.FieldType, THesapKarti(Table).IsEFaturaHesabi.Value);
//  chkIsAcikHesap.Checked := FormatedVariantVal(THesapKarti(Table).IsAcikHesap.FieldType, THesapKarti(Table).IsAcikHesap.Value);
//  edtKrediLimiti.Text := FormatedVariantVal(THesapKarti(Table).KrediLimiti.FieldType, THesapKarti(Table).KrediLimiti.Value);
//  cbbTemsilciGrubu.Text := FormatedVariantVal(THesapKarti(Table).TemsilciGrubu.FieldType, THesapKarti(Table).TemsilciGrubu.Value);
//  edtMusteriTemsilcisi.Text := FormatedVariantVal(THesapKarti(Table).MusteriTemsilcisi.FieldType, THesapKarti(Table).MusteriTemsilcisi.Value);
//  edtIbanNo.Text := FormatedVariantVal(THesapKarti(Table).Iban.FieldType, THesapKarti(Table).Iban.Value);
//  cbbIbanParaBirimi.Text := FormatedVariantVal(THesapKarti(Table).IbanPara.FieldType, THesapKarti(Table).IbanPara.Value);
end;

procedure TfrmHesapKarti.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      THesapKarti(Table).HesapKodu.Value := edtHesapKodu.Text;
      THesapKarti(Table).HesapIsmi.Value := edtHesapIsmi.Text;
      THesapKarti(Table).HesapGrubuID.Value := THesapKarti(Table).HesapGrubuID.FK.FKTable.Id.Value;
//      THesapKarti(Table).MukellefTipi.Value := cbbMukellefTipi.Text;
//      THesapKarti(Table).MukellefAdi.Value := edtMukellefAdi.Text;
//      THesapKarti(Table).MukellefIkinciAdi.Value := edtMukellefIkinciAdi.Text;
//      THesapKarti(Table).MukellefSoyadi.Value := edtMukellefSoyadi.Text;

//      THesapKarti(Table).UlkeID.Value :=
//        TSehir(THesapKarti(Table).SehirID.FK.FKTable).UlkeID.Value;
//      THesapKarti(Table).SehirID.Value :=
//        TSehir(THesapKarti(Table).SehirID.FK.FKTable).Id.Value;
//      THesapKarti(Table).Ilce.Value := edtIlce.Text;
//      THesapKarti(Table).Mahalle.Value := edtMahalle.Text;
//      THesapKarti(Table).Cadde.Value := edtCadde.Text;
//      THesapKarti(Table).Sokak.Value := edtSokak.Text;
//      THesapKarti(Table).Bina.Value := edtBina.Text;
//      THesapKarti(Table).PostaKodu.Value := edtPostaKodu.Text;
//      THesapKarti(Table).PostaKutusu.Value := edtPostaKutusu.Text;

//      THesapKarti(Table).VergiDairesi.Value := edtVergiDairesi.Text;
//      THesapKarti(Table).VergiNo.Value := edtVergiNo.Text;
//      THesapKarti(Table).Telefon1.Value := edtTelefon1.Text;
//      THesapKarti(Table).Telefon2.Value := edtTelefon2.Text;
//      THesapKarti(Table).Telefon3.Value := edtTelefon3.Text;
//      THesapKarti(Table).Faks.Value := edtFaks.Text;
//      THesapKarti(Table).Yetkili1.Value := edtYetkiliKisi1.Text;
//      THesapKarti(Table).Yetkili1Tel.Value := edtYetkiliKisi1Telefon.Text;
//      THesapKarti(Table).Yetkili2.Value := edtYetkiliKisi2.Text;
//      THesapKarti(Table).Yetkili2Tel.Value := edtYetkiliKisi2Telefon.Text;
//      THesapKarti(Table).WebSitesi.Value := edtWebSitesi.Text;
//      THesapKarti(Table).ePostaAdresi.Value := edtePostaAdresi.Text;
//      THesapKarti(Table).MuhasebeTelefon.Value := edtMuhasebeTelefon.Text;
//      THesapKarti(Table).MuhasebeEPosta.Value := edtMuhasebeEPosta.Text;
//      THesapKarti(Table).NaceKodu.Value := edtNaceKodu.Text;
//      THesapKarti(Table).ParaBirimi.Value := cbbParaBirimi.Text;
//      THesapKarti(Table).OzelBilgi.Value := mmoOzelBilgi.Text;
//      THesapKarti(Table).OdemeVadeGunSayisi.Value := edtOdemeVadeGunSayisi.Text;
//      THesapKarti(Table).BolgeID.Value := vBolge.Id.Value;
//      THesapKarti(Table).IsEFaturaHesabi.Value := chkIsEFaturaHesabi.Checked;
//      THesapKarti(Table).IsAcikHesap.Value := chkIsAcikHesap.Checked;
//      THesapKarti(Table).KrediLimiti.Value := edtKrediLimiti.Text;
//      THesapKarti(Table).TemsilciGrubuID.Value := edtTemsilciGrubu.Text;
//      THesapKarti(Table).MusteriTemsilcisiID.Value := edtMusteriTemsilcisi.Text;
//      THesapKarti(Table).Iban.Value := edtIbanNo.Text;
//      THesapKarti(Table).IbanPara.Value := cbbIbanParaBirimi.Text;

      inherited;
    end;
  end
  else
    inherited;
end;

end.
