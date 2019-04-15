unit ufrmHesapKarti;

interface

{$I ThsERP.inc}

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
  , Ths.Erp.Database.Table.SysTaxpayerType
  , Ths.Erp.Database.Table.SysCountry
  , Ths.Erp.Database.Table.SysCity
  , Ths.Erp.Database.Table.MusteriTemsilciGrubu
  , Ths.Erp.Database.Table.ParaBirimi
  , Ths.Erp.Database.Table.Adres

  , ufrmHelperSysCity
  , ufrmHelperSysCountry
  , ufrmHelperHesapGrubu
  , ufrmHelperBolge
  , ufrmHelperPersonelKarti
  , ufrmHelperHesapPlani
  ;

type
  TfrmHesapKarti = class(TfrmBaseInputDB)
    lblhesap_kodu: TLabel;
    lblhesap_ismi: TLabel;
    lblhesap_grubu_id: TLabel;
    lblmukellef_tipi_id: TLabel;
    lblmukellef_adi: TLabel;
    lblmukellef_ikinci_adi: TLabel;
    lblmukellef_soyadi: TLabel;
    lblvergi_dairesi: TLabel;
    lblvergi_no: TLabel;
    lblnace_kodu: TLabel;
    lblpara_birimi: TLabel;
    lblbolge_id: TLabel;
    lblmusteri_temsilci_grubu_id: TLabel;
    lblmusteri_temsilcisi_id: TLabel;
    lbliban: TLabel;
    lblis_efatura_hesabi: TLabel;
    lblmuhasebe_kodu: TLabel;
    lblefatura_pk_name: TLabel;
    tsAdres: TTabSheet;
    lblposta_kutusu: TLabel;
    lblbina: TLabel;
    lblsokak: TLabel;
    lblcadde: TLabel;
    lblmahalle: TLabel;
    lblilce: TLabel;
    lblsehir_id: TLabel;
    lblulke_id: TLabel;
    lblposta_kodu: TLabel;
    lblkapi_no: TLabel;
    edtulke_id: TEdit;
    edtsehir_id: TEdit;
    edtilce: TEdit;
    edtmahalle: TEdit;
    edtcadde: TEdit;
    edtsokak: TEdit;
    edtbina: TEdit;
    edtkapi_no: TEdit;
    edtposta_kutusu: TEdit;
    edtposta_kodu: TEdit;
    tsIletisim: TTabSheet;
    lblyetkili2: TLabel;
    lblyetkili1: TLabel;
    lblfaks: TLabel;
    lblweb_sitesi: TLabel;
    lbleposta_adresi: TLabel;
    lblmuhasebe_telefon: TLabel;
    lblmuhasebe_eposta: TLabel;
    lblyetkili2_tel: TLabel;
    lblyetkili1_tel: TLabel;
    lblozel_bilgi: TLabel;
    lblmuhasebe_yetkili: TLabel;
    lblyetkili3: TLabel;
    lblyetkili3_tel: TLabel;
    edtyetkili1: TEdit;
    edtyetkili1_tel: TEdit;
    edtyetkili2: TEdit;
    edtyetkili2_tel: TEdit;
    edtyetkili3: TEdit;
    edtyetkili3_tel: TEdit;
    edtfaks: TEdit;
    edtweb_sitesi: TEdit;
    edtMuhasebeTelefon: TEdit;
    edteposta_adresi: TEdit;
    edtmuhasebe_eposta: TEdit;
    edtmuhasebe_yetkili: TEdit;
    mmoozel_bilgi: TMemo;
    tsDiger: TTabSheet;
    lblodeme_vade_gun_sayisi: TLabel;
    lblis_acik_hesap: TLabel;
    lblkredi_limiti: TLabel;
    lblhesap_iskonto: TLabel;
    edtodeme_vade_gun_sayisi: TEdit;
    chkis_acik_hesap: TCheckBox;
    edtkredi_limiti: TEdit;
    edthesap_iskonto: TEdit;
    lblis_ara_hesap: TLabel;
    chkis_ara_hesap: TCheckBox;
    edtmuhasebe_kodu: TEdit;
    edthesap_kodu: TEdit;
    edthesap_ismi: TEdit;
    edthesap_grubu_id: TEdit;
    edtbolge_id: TEdit;
    edtmusteri_temsilci_grubu_id: TEdit;
    edtmukellef_tipi_id: TEdit;
    edtvergi_dairesi: TEdit;
    edtmukellef_adi: TEdit;
    edtvergi_no: TEdit;
    edtmukellef_ikinci_adi: TEdit;
    edtpara_birimi: TEdit;
    edtmukellef_soyadi: TEdit;
    edtiban: TEdit;
    edtiban_para: TEdit;
    edtmusteri_temsilcisi_id: TEdit;
    edtnace_kodu: TEdit;
    chkis_efatura_hesabi: TCheckBox;
    edtefatura_pk_name: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure FormShow(Sender: TObject);override;
    procedure edtmukellef_tipi_idChange(Sender: TObject);
  private
  public
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

procedure TfrmHesapKarti.edtmukellef_tipi_idChange(Sender: TObject);
begin
  inherited;
  if edtmukellef_tipi_id.Text = 'TCKN' then
  begin
    lblmukellef_adi.Visible := True;
    edtmukellef_adi.Visible := True;
    lblmukellef_ikinci_adi.Visible := True;
    edtmukellef_ikinci_adi.Visible := True;
    lblmukellef_soyadi.Visible := True;
    edtmukellef_soyadi.Visible := True;
  end
  else
  begin
    lblmukellef_adi.Visible := False;
    edtmukellef_adi.Visible := False;
    lblmukellef_ikinci_adi.Visible := False;
    edtmukellef_ikinci_adi.Visible := False;
    lblmukellef_soyadi.Visible := False;
    edtmukellef_soyadi.Visible := False;

    edtmukellef_adi.Clear;
    edtmukellef_ikinci_adi.Clear;
    edtmukellef_soyadi.Clear;
  end;
end;

procedure TfrmHesapKarti.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmHesapKarti.FormShow(Sender: TObject);
begin
  inherited;

  edtulke_id.ReadOnly := True;
  edtulke_id.OnHelperProcess := nil;
end;

procedure TfrmHesapKarti.HelperProcess(Sender: TObject);
var
  vHelperSysCity: TfrmHelperSysCity;
  vHelperHesapGrubu: TfrmHelperHesapGrubu;
  vHelperBolge: TfrmHelperBolge;
  vHelperMusteriTemsilcisi: TfrmHelperPersonelKarti;
  vHelperHesapPlani: TfrmHelperHesapPlani;
begin
  if Sender.ClassType = TEdit then
  begin
    if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
    begin
      if TEdit(Sender).Name = edtsehir_id.Name then
      begin
        vHelperSysCity := TfrmHelperSysCity.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperSysCity.ShowModal;

          if Assigned(THesapKarti(Table).Adres.SehirID.FK.FKTable) then
            THesapKarti(Table).Adres.SehirID.FK.FKTable.Free;
          THesapKarti(Table).Adres.SehirID.FK.FKTable := vHelperSysCity.Table.Clone;
          edtulke_id.Text := TSysCity(THesapKarti(Table).Adres.SehirID.FK.FKTable).CountryID.FK.FKCol.Value;
        finally
          vHelperSysCity.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtmuhasebe_kodu.Name then
      begin
        vHelperHesapPlani := TfrmHelperHesapPlani.Create(TEdit(Sender), Self, THesapPlani.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperHesapPlani.ShowModal;

          if Assigned(THesapKarti(Table).MuhasebeKodu.FK.FKTable) then
            THesapKarti(Table).MuhasebeKodu.FK.FKTable.Free;
          THesapKarti(Table).MuhasebeKodu.FK.FKTable := vHelperHesapPlani.Table.Clone;

          if THesapPlani(THesapKarti(Table).MuhasebeKodu.FK.FKTable).SeviyeSayisi.Value = 2 then
        finally
          vHelperHesapPlani.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edthesap_grubu_id.Name then
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
      else if TEdit(Sender).Name = edtbolge_id.Name then
      begin
        vHelperBolge := TfrmHelperBolge.Create(TEdit(Sender), Self, TBolge.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperBolge.ShowModal;

          if Assigned(THesapKarti(Table).BolgeID.FK.FKTable) then
            THesapKarti(Table).BolgeID.FK.FKTable.Free;
          THesapKarti(Table).BolgeID.FK.FKTable := vHelperBolge.Table.Clone;
        finally
          vHelperBolge.Free;
        end;
      end
      else if TEdit(Sender).Name = edtmusteri_temsilcisi_id.Name then
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
  inherited;
  //
end;

procedure TfrmHesapKarti.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      btnAcceptAuto;

      inherited;
    end;
  end
  else
    inherited;
end;

end.
