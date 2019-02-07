unit ufrmPersonelKarti;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Samples.Spin, Vcl.Mask,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase,
  ufrmBaseInputDB,
  ufrmHelperAyarPrsPersonelTipi,
  ufrmHelperAyarPrsBirim,
  ufrmHelperAyarPrsGorev,
  ufrmHelperAyarPrsCinsiyet,
  ufrmHelperAyarPrsMedeniDurum,
  ufrmHelperAyarPrsAskerlikDurumu,
  ufrmHelperPersonelTasimaServisi,
  ufrmHelperSehir

  , Ths.Erp.Database.Table.AyarPrsPersonelTipi
  , Ths.Erp.Database.Table.AyarPrsBolum
  , Ths.Erp.Database.Table.AyarPrsBirim
  , Ths.Erp.Database.Table.AyarPrsGorev
  , Ths.Erp.Database.Table.AyarPrsCinsiyet
  , Ths.Erp.Database.Table.AyarPrsAskerlikDurumu
  , Ths.Erp.Database.Table.AyarPrsMedeniDurum
  , Ths.Erp.Database.Table.PersonelPDKSKart
  , Ths.Erp.Database.Table.AyarPrsAyrilmaNedeni
  , Ths.Erp.Database.Table.PersonelTasimaServisi
  , Ths.Erp.Database.Table.Ulke
  , Ths.Erp.Database.Table.Sehir
  ;

type
  TfrmPersonelKarti = class(TfrmBaseInputDB)
    pgcMain: TPageControl;
    tsGenel: TTabSheet;
    tsAyrinti: TTabSheet;
    tsOzel: TTabSheet;
    lblgenel_not: TLabel;
    lblpersonel_ad: TLabel;
    lblpersonel_soyad: TLabel;
    lblpersonel_tipi_id: TLabel;
    lblbolum_id: TLabel;
    lblbirim_id: TLabel;
    lblgorev_id: TLabel;
    lblis_active: TLabel;
    lblbrut_maas: TLabel;
    lblozel_not: TLabel;
    lblikramiye_sayisi: TLabel;
    lblikramiye_miktar: TLabel;
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
    lbltelefon1: TLabel;
    lbltelefon2: TLabel;
    lblyakin_telefon: TLabel;
    lblyakin_ad_soyad: TLabel;
    lblmail_adresi: TLabel;
    lblayakkabi_no: TLabel;
    lblelbise_bedeni: TLabel;
    lbltc_kimlik_no: TLabel;
    lbldogum_tarihi: TLabel;
    lblkan_grubu: TLabel;
    lblcinsiyet_id: TLabel;
    lblmedeni_durum_id: TLabel;
    lblaskerlik_durum_id: TLabel;
    lblcocuk_sayisi: TLabel;
    chkis_active: TCheckBox;
    edtpersonel_ad: TEdit;
    edtpersonel_soyad: TEdit;
    edtpersonel_tipi_id: TEdit;
    edtbolum_id: TEdit;
    edtbirim_id: TEdit;
    edtgorev_id: TEdit;
    mmogenel_not: TMemo;
    imgPersonelResim: TImage;
    lblservis_id: TLabel;
    edtservis_id: TEdit;
    edttelefon1: TEdit;
    edttelefon2: TEdit;
    edtmail_adresi: TEdit;
    edtyakin_ad_soyad: TEdit;
    edtyakin_telefon: TEdit;
    edtayakkabi_no: TEdit;
    edtelbise_bedeni: TEdit;
    edttc_kimlik_no: TEdit;
    edtdogum_tarihi: TEdit;
    cbbkan_grubu: TComboBox;
    edtcinsiyet_id: TEdit;
    edtmedeni_durum_id: TEdit;
    edtcocuk_sayisi: TEdit;
    edtaskerlik_durum_id: TEdit;
    edtbrut_maas: TEdit;
    edtikramiye_sayisi: TEdit;
    edtikramiye_miktar: TEdit;
    mmoozel_not: TMemo;
    procedure FormCreate(Sender: TObject);override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure pgcMainChange(Sender: TObject);
    procedure edtcinsiyet_idChange(Sender: TObject);
    procedure edtmedeni_durum_idChange(Sender: TObject);
  private
  public
  protected
    procedure HelperProcess(Sender: TObject); override;
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton
  , Ths.Erp.Database.Table.PersonelKarti
  , Ths.Erp.Functions
  ;

{$R *.dfm}

procedure TfrmPersonelKarti.edtcinsiyet_idChange(Sender: TObject);
begin
  if TAyarPrsCinsiyet(TPersonelKarti(Table).CinsiyetID.FK.FKTable).IsMan.Value then
  begin
    lblaskerlik_durum_id.Visible := True;
    edtaskerlik_durum_id.Visible := True;
    edtaskerlik_durum_id.thsRequiredData := True;
  end
  else
  begin
    lblaskerlik_durum_id.Visible := False;
    edtaskerlik_durum_id.Visible := False;
    edtaskerlik_durum_id.thsRequiredData := False;
    edtaskerlik_durum_id.Clear;
    TPersonelKarti(Table).AskerlikDurumID.Value := Null;
  end;
end;

procedure TfrmPersonelKarti.edtmedeni_durum_idChange(Sender: TObject);
begin
  if TAyarPrsMedeniDurum(TPersonelKarti(Table).MedeniDurumID.FK.FKTable).IsMarried.Value then
  begin
    lblcocuk_sayisi.Visible := True;
    edtcocuk_sayisi.Visible := True;
    edtcocuk_sayisi.thsRequiredData := True;
  end
  else
  begin
    lblcocuk_sayisi.Visible := False;
    edtcocuk_sayisi.Visible := False;
    edtcocuk_sayisi.thsRequiredData := False;
    edtcocuk_sayisi.Clear;
    TPersonelKarti(Table).CocukSayisi.Value := Null;
  end;
end;

procedure TfrmPersonelKarti.FormCreate(Sender: TObject);
begin
  inherited;

  mmogenel_not.CharCase := ecNormal;
  mmoozel_not.CharCase := ecNormal;
  edtmail_adresi.CharCase := ecNormal;

  chkis_active.Visible := False;
  lblis_active.Visible := False;

  pgcMain.ActivePage := tsGenel;
end;

procedure TfrmPersonelKarti.FormShow(Sender: TObject);
begin
  cbbkan_grubu.Clear;
  cbbkan_grubu.Items.Add('A RH+');
  cbbkan_grubu.Items.Add('B RH+');
  cbbkan_grubu.Items.Add('AB RH+');
  cbbkan_grubu.Items.Add('0 RH+');
  cbbkan_grubu.Items.Add('A RH-');
  cbbkan_grubu.Items.Add('B RH-');
  cbbkan_grubu.Items.Add('AB RH-');
  cbbkan_grubu.Items.Add('0 RH-');

  inherited;

  edtbolum_id.ReadOnly := True;
  edtulke_id.ReadOnly := True;

  {$IFDEF DUMMY_VALUE}
    if FormMode = ifmNewRecord then
    begin
      edtpersonel_ad.Text := 'JOHN';
      edtpersonel_soyad.Text := 'DOE';
      edtdogum_tarihi.Text := '01.01.1980';
      edtbrut_maas.Text := '1000';
      edtIlce.Text := 'PENDÝK';
      edtMahalle.Text := 'KAYNARCA';
      edtCadde.Text := 'UZUN';
      edtSokak.Text := 'KISA';
      edtBina.Text := 'GENÝÞ';
      edtkapi_no.Text := '14/2';
      edtposta_kodu.Text := '12345';
    end;
  {$ENDIF}
end;

procedure TfrmPersonelKarti.HelperProcess(Sender: TObject);
var
  vHelperPersonelTipi: TfrmHelperAyarPrsPersonelTipi;
  vHelperBirim: TfrmHelperAyarPrsBirim;
  vHelperGorev: TfrmHelperAyarPrsGorev;
  vHelperCinsiyet: TfrmHelperAyarPrsCinsiyet;
  vHelperMedeniDurum: TfrmHelperAyarPrsMedeniDurum;
  vHelperAskerlikDurumu: TfrmHelperAyarPrsAskerlikDurumu;
  vHelperServis: TfrmHelperPersonelTasimaServisi;
  vHelperSehir: TfrmHelperSehir;
begin
  if Sender.ClassType = TEdit then
  begin
    if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
    begin
      if TEdit(Sender).Name = edtpersonel_tipi_id.Name then
      begin
        vHelperPersonelTipi := TfrmHelperAyarPrsPersonelTipi.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperPersonelTipi.ShowModal;

          if Assigned(TPersonelKarti(Table).PersonelTipiID.FK.FKTable) then
            TPersonelKarti(Table).PersonelTipiID.FK.FKTable.Free;
          TPersonelKarti(Table).PersonelTipiID.Value := vHelperPersonelTipi.Table.Id.Value;
          TPersonelKarti(Table).PersonelTipiID.FK.FKTable := vHelperPersonelTipi.Table.Clone;
        finally
          vHelperPersonelTipi.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtbirim_id.Name then
      begin
        vHelperBirim := TfrmHelperAyarPrsBirim.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperBirim.ShowModal;

          if Assigned(TPersonelKarti(Table).BirimID.FK.FKTable) then
            TPersonelKarti(Table).BirimID.FK.FKTable.Free;
          TPersonelKarti(Table).BirimID.Value := vHelperBirim.Table.Id.Value;
          TPersonelKarti(Table).BirimID.FK.FKTable := vHelperBirim.Table.Clone;
          edtbolum_id.Text := TAyarPrsBirim(TPersonelKarti(Table).BirimID.FK.FKTable).BolumID.FK.FKCol.Value;
          TPersonelKarti(Table).BolumID.Value := TAyarPrsBirim(TPersonelKarti(Table).BirimID.FK.FKTable).BolumID.Value;
        finally
          vHelperBirim.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtgorev_id.Name then
      begin
        vHelperGorev := TfrmHelperAyarPrsGorev.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperGorev.ShowModal;

          if Assigned(TPersonelKarti(Table).GorevID.FK.FKTable) then
            TPersonelKarti(Table).GorevID.FK.FKTable.Free;
          TPersonelKarti(Table).GorevID.Value := vHelperGorev.Table.Id.Value;
          TPersonelKarti(Table).GorevID.FK.FKTable := vHelperGorev.Table.Clone;
        finally
          vHelperGorev.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtcinsiyet_id.Name then
      begin
        vHelperCinsiyet := TfrmHelperAyarPrsCinsiyet.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperCinsiyet.ShowModal;

          if Assigned(TPersonelKarti(Table).CinsiyetID.FK.FKTable) then
            TPersonelKarti(Table).CinsiyetID.FK.FKTable.Free;
          TPersonelKarti(Table).CinsiyetID.Value := vHelperCinsiyet.Table.Id.Value;
          TPersonelKarti(Table).CinsiyetID.FK.FKTable := vHelperCinsiyet.Table.Clone;
          edtcinsiyet_idChange(edtcinsiyet_id);
        finally
          vHelperCinsiyet.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtmedeni_durum_id.Name then
      begin
        vHelperMedeniDurum := TfrmHelperAyarPrsMedeniDurum.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperMedeniDurum.ShowModal;

          if Assigned(TPersonelKarti(Table).MedeniDurumID.FK.FKTable) then
            TPersonelKarti(Table).MedeniDurumID.FK.FKTable.Free;
          TPersonelKarti(Table).MedeniDurumID.Value := vHelperMedeniDurum.Table.Id.Value;
          TPersonelKarti(Table).MedeniDurumID.FK.FKTable := vHelperMedeniDurum.Table.Clone;
          edtmedeni_durum_idChange(edtmedeni_durum_id);
        finally
          vHelperMedeniDurum.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtaskerlik_durum_id.Name then
      begin
        vHelperAskerlikDurumu := TfrmHelperAyarPrsAskerlikDurumu.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperAskerlikDurumu.ShowModal;

          if Assigned(TPersonelKarti(Table).AskerlikDurumID.FK.FKTable) then
            TPersonelKarti(Table).AskerlikDurumID.FK.FKTable.Free;
          TPersonelKarti(Table).AskerlikDurumID.Value := vHelperAskerlikDurumu.Table.Id.Value;
          TPersonelKarti(Table).AskerlikDurumID.FK.FKTable := vHelperAskerlikDurumu.Table.Clone;
        finally
          vHelperAskerlikDurumu.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtservis_id.Name then
      begin
        vHelperServis := TfrmHelperPersonelTasimaServisi.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperServis.ShowModal;

          if Assigned(TPersonelKarti(Table).ServisID.FK.FKTable) then
            TPersonelKarti(Table).ServisID.FK.FKTable.Free;
          TPersonelKarti(Table).ServisID.Value := vHelperServis.Table.Id.Value;
          TPersonelKarti(Table).ServisID.FK.FKTable := vHelperServis.Table.Clone;
        finally
          vHelperServis.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtsehir_id.Name then
      begin
        vHelperSehir := TfrmHelperSehir.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperSehir.ShowModal;

          if Assigned(TPersonelKarti(Table).Adres.SehirID.FK.FKTable) then
            TPersonelKarti(Table).Adres.SehirID.FK.FKTable.Free;
          TPersonelKarti(Table).Adres.SehirID.Value := vHelperSehir.Table.Id.Value;
          TPersonelKarti(Table).ServisID.FK.FKTable := vHelperSehir.Table.Clone;
          edtulke_id.Text := TSehir(TPersonelKarti(Table).ServisID.FK.FKTable).UlkeID.FK.FKCol.Value;
          TPersonelKarti(Table).Adres.UlkeID.Value := TSehir(TPersonelKarti(Table).ServisID.FK.FKTable).UlkeID.Value;
        finally
          vHelperSehir.Free;
        end;
      end
    end;
  end;
end;

procedure TfrmPersonelKarti.pgcMainChange(Sender: TObject);
begin
  inherited;
  lblpersonel_ad.Parent := pgcMain.ActivePage;
  edtpersonel_ad.Parent := pgcMain.ActivePage;
  lblpersonel_soyad.Parent := pgcMain.ActivePage;
  edtpersonel_soyad.Parent := pgcMain.ActivePage;

  if pgcMain.ActivePage.Name = tsGenel.Name then
  begin
    edtpersonel_ad.ReadOnly := False;
    edtpersonel_ad.TabStop := True;
    edtpersonel_soyad.ReadOnly := False;
    edtpersonel_soyad.TabStop := True;

    edtpersonel_ad.TabOrder := 0;
    edtpersonel_soyad.TabOrder := 1;
    edtpersonel_ad.SetFocus;
  end
  else
  begin
    edtpersonel_ad.ReadOnly := True;
    edtpersonel_ad.TabStop := False;
    edtpersonel_ad.ReadOnly := True;
    edtpersonel_soyad.TabStop := False;
  end;
end;

procedure TfrmPersonelKarti.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      btnAcceptAuto;

      if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) then
        TPersonelKarti(Table).IsActive.Value := True
      else
        TPersonelKarti(Table).IsActive.Value := chkis_active.Checked;

      inherited;
    end;
  end
  else
    inherited;
end;

end.

