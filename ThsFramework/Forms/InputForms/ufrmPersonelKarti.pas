unit ufrmPersonelKarti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Samples.Spin, Vcl.Mask,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB
  , Ths.Erp.Database.Table.AyarPersonelTipi
  , Ths.Erp.Database.Table.AyarPersonelBolum
  , Ths.Erp.Database.Table.AyarPersonelBirim
  , Ths.Erp.Database.Table.AyarPersonelGorev
  , Ths.Erp.Database.Table.AyarPersonelCinsiyet
  , Ths.Erp.Database.Table.AyarPersonelAskerlikDurumu
  , Ths.Erp.Database.Table.AyarPersonelMedeniDurum
  , Ths.Erp.Database.Table.PersonelPDKSKart
  , Ths.Erp.Database.Table.AyarPersonelAyrilmaNedeniTipi
  , Ths.Erp.Database.Table.PersonelTasimaServisi
  ;

type
  TfrmPersonelKarti = class(TfrmBaseInputDB)
    pgcPersonel: TPageControl;
    tsGenel: TTabSheet;
    tsAyrinti: TTabSheet;
    tsOzel: TTabSheet;
    lblGenelNot: TLabel;
    lblPersonelAd: TLabel;
    lblPersonelSoyad: TLabel;
    lblPersonelTipi: TLabel;
    lblBolum: TLabel;
    lblBirim: TLabel;
    lblGorev: TLabel;
    lblIsActive: TLabel;
    chkIsActive: TCheckBox;
    edtPersonelAd: TEdit;
    edtPersonelSoyad: TEdit;
    cbbPersonelTipi: TComboBox;
    cbbBolum: TComboBox;
    cbbBirim: TComboBox;
    cbbGorev: TComboBox;
    mmoGenelNot: TMemo;
    imgPersonelResim: TImage;
    edtTelefon1: TEdit;
    edtTelefon2: TEdit;
    edtMailAdresi: TEdit;
    edtYakinAdSoyad: TEdit;
    edtYakinTelefon: TEdit;
    edtEvAdresi: TEdit;
    edtTcKimlikNo: TEdit;
    edtDogumTarihi: TEdit;
    cbbKanGrubu: TComboBox;
    cbbCinsiyet: TComboBox;
    cbbMedeniDurumu: TComboBox;
    edtCocukSayisi: TEdit;
    edtAyakkabiNo: TEdit;
    edtElbiseBedeni: TEdit;
    cbbAskerlikDurumu: TComboBox;
    cbbServisAdi: TComboBox;
    edtBrutMaas: TEdit;
    edtIkramiyeSayisi: TEdit;
    edtIkramiyeMiktar: TEdit;
    mmoOzelNot: TMemo;
    lblBrutMaas: TLabel;
    lblOzelNot: TLabel;
    lblIkramiyeSayisi: TLabel;
    lblIkramiyeMiktar: TLabel;
    lblTelefon1: TLabel;
    lblTelefon2: TLabel;
    lblYakinTelefon: TLabel;
    lblYakinAdSoyad: TLabel;
    lblEvAdresi: TLabel;
    lblMailAdresi: TLabel;
    lblAyakkabiNo: TLabel;
    lblElbiseBedeni: TLabel;
    lblTCKimlikNo: TLabel;
    lblServisAdi: TLabel;
    lblDogumTarihi: TLabel;
    lblKanGrubu: TLabel;
    lblCinsiyet: TLabel;
    lblMedeniDurumu: TLabel;
    lblAskerlikDurumu: TLabel;
    lblCocukSayisi: TLabel;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure FormDestroy(Sender: TObject);override;
    procedure cbbBolumChange(Sender: TObject);
  private
    vAyarPersonelTipi: TAyarPersonelTipi;
    vAyarPersonelBolum: TAyarPersonelBolum;
    vAyarPersonelBirim: TAyarPersonelBirim;
    vAyarPersonelGorev: TAyarPersonelGorev;
    vAyarPersonelCinsiyet: TAyarPersonelCinsiyet;
    vAyarPersonelAskerlikDurumu: TAyarPersonelAskerlikDurumu;
    vAyarPersonelMedeniDurum: TAyarPersonelMedeniDurum;
    vAyarPersonelTasimaServisi: TPersonelTasimaServis;
  public
  protected
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

procedure TfrmPersonelKarti.cbbBolumChange(Sender: TObject);
begin
  fillComboBoxData(cbbBirim, vAyarPersonelBirim, vAyarPersonelBirim.Birim.FieldName, ' AND ' + vAyarPersonelBirim.BolumID.FieldName + '=' + IntToStr(TFunctions.VarToInt(TAyarPersonelBolum(cbbBolum.Items.Objects[cbbBolum.ItemIndex]).ID.Value)), True);
end;

procedure TfrmPersonelKarti.FormCreate(Sender: TObject);
begin
  TPersonelKarti(Table).PersonelAd.SetControlProperty(Table.TableName, edtPersonelAd);
  TPersonelKarti(Table).PersonelSoyad.SetControlProperty(Table.TableName, edtPersonelSoyad);
  TPersonelKarti(Table).PersonelTipi.SetControlProperty(Table.TableName, cbbPersonelTipi);
  TPersonelKarti(Table).Bolum.SetControlProperty(Table.TableName, cbbBolum);
  TPersonelKarti(Table).Birim.SetControlProperty(Table.TableName, cbbBirim);
  TPersonelKarti(Table).Gorev.SetControlProperty(Table.TableName, cbbGorev);
  TPersonelKarti(Table).GenelNot.SetControlProperty(Table.TableName, mmoGenelNot);

  TPersonelKarti(Table).Telefon1.SetControlProperty(Table.TableName, edtTelefon1);
  TPersonelKarti(Table).Telefon2.SetControlProperty(Table.TableName, edtTelefon2);
  TPersonelKarti(Table).MailAdresi.SetControlProperty(Table.TableName, edtMailAdresi);
  TPersonelKarti(Table).YakinAdSoyad.SetControlProperty(Table.TableName, edtYakinAdSoyad);
  TPersonelKarti(Table).YakinTelefon.SetControlProperty(Table.TableName, edtYakinTelefon);
  TPersonelKarti(Table).EvAdresi.SetControlProperty(Table.TableName, edtEvAdresi);
  TPersonelKarti(Table).TCKimlikNo.SetControlProperty(Table.TableName, edtTcKimlikNo);
  TPersonelKarti(Table).DogumTarihi.SetControlProperty(Table.TableName, edtDogumTarihi);
  TPersonelKarti(Table).KanGrubu.SetControlProperty(Table.TableName, cbbKanGrubu);
  TPersonelKarti(Table).Cinsiyet.SetControlProperty(Table.TableName, cbbCinsiyet);
  TPersonelKarti(Table).MedeniDurum.SetControlProperty(Table.TableName, cbbMedeniDurumu);
  TPersonelKarti(Table).CocukSayisi.SetControlProperty(Table.TableName, edtCocukSayisi);
  TPersonelKarti(Table).AyakkabiNo.SetControlProperty(Table.TableName, edtAyakkabiNo);
  TPersonelKarti(Table).ElbiseBedeni.SetControlProperty(Table.TableName, edtElbiseBedeni);
  TPersonelKarti(Table).AskerlikDurum.SetControlProperty(Table.TableName, cbbAskerlikDurumu);
  TPersonelKarti(Table).Servis.SetControlProperty(Table.TableName, cbbServisAdi);

  TPersonelKarti(Table).BrutMaas.SetControlProperty(Table.TableName, edtBrutMaas);
  TPersonelKarti(Table).IkramiyeSayisi.SetControlProperty(Table.TableName, edtIkramiyeSayisi);
  TPersonelKarti(Table).IkramiyeMiktar.SetControlProperty(Table.TableName, edtIkramiyeMiktar);
  TPersonelKarti(Table).OzelNot.SetControlProperty(Table.TableName, mmoOzelNot);

  inherited;

  vAyarPersonelTipi := TAyarPersonelTipi.Create(Table.Database);
  vAyarPersonelBolum := TAyarPersonelBolum.Create(Table.Database);
  vAyarPersonelBirim := TAyarPersonelBirim.Create(Table.Database);
  vAyarPersonelGorev := TAyarPersonelGorev.Create(Table.Database);
  vAyarPersonelCinsiyet := TAyarPersonelCinsiyet.Create(Table.Database);
  vAyarPersonelAskerlikDurumu := TAyarPersonelAskerlikDurumu.Create(Table.Database);
  vAyarPersonelMedeniDurum := TAyarPersonelMedeniDurum.Create(Table.Database);
  vAyarPersonelTasimaServisi := TPersonelTasimaServis.Create(Table.Database);

  edtMailAdresi.CharCase := ecNormal;
  edtEvAdresi.CharCase := ecNormal;

  fillComboBoxData(cbbPersonelTipi, vAyarPersonelTipi, vAyarPersonelTipi.Deger.FieldName, ' AND ' + vAyarPersonelTipi.IsActive.FieldName + '=True', True);
  fillComboBoxData(cbbBolum, vAyarPersonelBolum, vAyarPersonelBolum.Bolum.FieldName, '', True);
  cbbBolumChange(cbbBolum);
  fillComboBoxData(cbbGorev, vAyarPersonelGorev, vAyarPersonelGorev.Gorev.FieldName, '', True);
  fillComboBoxData(cbbCinsiyet, vAyarPersonelCinsiyet, vAyarPersonelCinsiyet.Deger.FieldName, '', True);
  fillComboBoxData(cbbMedeniDurumu, vAyarPersonelMedeniDurum, vAyarPersonelMedeniDurum.Deger.FieldName, '', True);
  fillComboBoxData(cbbAskerlikDurumu, vAyarPersonelAskerlikDurumu, vAyarPersonelAskerlikDurumu.Deger.FieldName, '', True);
  fillComboBoxData(cbbServisAdi, vAyarPersonelTasimaServisi, vAyarPersonelTasimaServisi.ServisAdi.FieldName, '', True, True);

  pgcPersonel.ActivePage := tsGenel;
end;

procedure TfrmPersonelKarti.FormDestroy(Sender: TObject);
begin
  if Assigned(vAyarPersonelTipi) then
    vAyarPersonelTipi.Free;
  if Assigned(vAyarPersonelBolum) then
    vAyarPersonelBolum.Free;
  if Assigned(vAyarPersonelBirim) then
    vAyarPersonelBirim.Free;
  if Assigned(vAyarPersonelGorev) then
    vAyarPersonelGorev.Free;
  if Assigned(vAyarPersonelCinsiyet) then
    vAyarPersonelCinsiyet.Free;
  if Assigned(vAyarPersonelAskerlikDurumu) then
    vAyarPersonelAskerlikDurumu.Free;
  if Assigned(vAyarPersonelMedeniDurum) then
    vAyarPersonelMedeniDurum.Free;
  if Assigned(vAyarPersonelTasimaServisi) then
    vAyarPersonelTasimaServisi.Free;
  inherited;
end;

procedure TfrmPersonelKarti.FormShow(Sender: TObject);
begin
  inherited;
  if (FormMode = ifmNewRecord)
  or (FormMode = ifmCopyNewRecord)
  then
  begin
//    lblAyrilmaNedeni.Visible := False;
//    cbbAyrilmaNedeni.Visible := False;
//
//    edtIseGirisTarihi.Text := DateToStr(Table.Database.GetNow);
  end;
end;

procedure TfrmPersonelKarti.RefreshData();
begin
  //control içeriðini table class ile doldur
  chkIsActive.Checked := FormatedVariantVal(TPersonelKarti(Table).IsActive.FieldType, TPersonelKarti(Table).IsActive.Value);
  edtPersonelAd.Text := FormatedVariantVal(TPersonelKarti(Table).PersonelAd.FieldType, TPersonelKarti(Table).PersonelAd.Value);
  edtPersonelSoyad.Text := FormatedVariantVal(TPersonelKarti(Table).PersonelSoyad.FieldType, TPersonelKarti(Table).PersonelSoyad.Value);

  cbbPersonelTipi.Text := FormatedVariantVal(TPersonelKarti(Table).PersonelTipi.FieldType, TPersonelKarti(Table).PersonelTipi.Value);
  vAyarPersonelTipi.SelectToList(' AND ' + vAyarPersonelTipi.TableName + '.' + vAyarPersonelTipi.Id.FieldName + '=' + IntToStr(TPersonelKarti(Table).PersonelTipiID.Value), False, False);

  cbbBolum.Text := FormatedVariantVal(TPersonelKarti(Table).Bolum.FieldType, TPersonelKarti(Table).Bolum.Value);
  vAyarPersonelBolum.SelectToList(' AND ' + vAyarPersonelBolum.TableName + '.' + vAyarPersonelBolum.Id.FieldName + '=' + IntToStr(TPersonelKarti(Table).BolumID.Value), False, False);

  cbbBirim.Text := FormatedVariantVal(TPersonelKarti(Table).Birim.FieldType, TPersonelKarti(Table).Birim.Value);
  vAyarPersonelBirim.SelectToList(' AND ' + vAyarPersonelBirim.TableName + '.' + vAyarPersonelBirim.Id.FieldName + '=' + IntToStr(TPersonelKarti(Table).BirimID.Value), False, False);

  cbbGorev.Text := FormatedVariantVal(TPersonelKarti(Table).Gorev.FieldType, TPersonelKarti(Table).Gorev.Value);
  vAyarPersonelGorev.SelectToList(' AND ' + vAyarPersonelGorev.TableName + '.' + vAyarPersonelGorev.Id.FieldName + '=' + IntToStr(TPersonelKarti(Table).GorevID.Value), False, False);

  mmoGenelNot.Text := FormatedVariantVal(TPersonelKarti(Table).Gorev.FieldType, TPersonelKarti(Table).Gorev.Value);

  edtTelefon1.Text := FormatedVariantVal(TPersonelKarti(Table).Telefon1.FieldType, TPersonelKarti(Table).Telefon1.Value);
  edtTelefon2.Text := FormatedVariantVal(TPersonelKarti(Table).Telefon2.FieldType, TPersonelKarti(Table).Telefon2.Value);
  edtMailAdresi.Text := FormatedVariantVal(TPersonelKarti(Table).MailAdresi.FieldType, TPersonelKarti(Table).MailAdresi.Value);
  edtYakinAdSoyad.Text := FormatedVariantVal(TPersonelKarti(Table).YakinAdSoyad.FieldType, TPersonelKarti(Table).YakinAdSoyad.Value);
  edtYakinTelefon.Text := FormatedVariantVal(TPersonelKarti(Table).YakinTelefon.FieldType, TPersonelKarti(Table).YakinTelefon.Value);
  edtEvAdresi.Text := FormatedVariantVal(TPersonelKarti(Table).EvAdresi.FieldType, TPersonelKarti(Table).EvAdresi.Value);
  edtTcKimlikNo.Text := FormatedVariantVal(TPersonelKarti(Table).TCKimlikNo.FieldType, TPersonelKarti(Table).TCKimlikNo.Value);
  edtDogumTarihi.Text := FormatedVariantVal(TPersonelKarti(Table).DogumTarihi.FieldType, TPersonelKarti(Table).DogumTarihi.Value);
  cbbKanGrubu.Text := FormatedVariantVal(TPersonelKarti(Table).KanGrubu.FieldType, TPersonelKarti(Table).KanGrubu.Value);

  cbbCinsiyet.Text := FormatedVariantVal(TPersonelKarti(Table).Cinsiyet.FieldType, TPersonelKarti(Table).Cinsiyet.Value);
  vAyarPersonelCinsiyet.SelectToList(' AND ' + vAyarPersonelCinsiyet.TableName + '.' + vAyarPersonelCinsiyet.Id.FieldName + '=' + IntToStr(TPersonelKarti(Table).CinsiyetID.Value), False, False);

  cbbMedeniDurumu.Text := FormatedVariantVal(TPersonelKarti(Table).MedeniDurum.FieldType, TPersonelKarti(Table).MedeniDurum.Value);
  vAyarPersonelMedeniDurum.SelectToList(' AND ' + vAyarPersonelMedeniDurum.TableName + '.' + vAyarPersonelMedeniDurum.Id.FieldName + '=' + IntToStr(TPersonelKarti(Table).MedeniDurumID.Value), False, False);

  edtCocukSayisi.Text := FormatedVariantVal(TPersonelKarti(Table).CocukSayisi.FieldType, TPersonelKarti(Table).CocukSayisi.Value);
  edtAyakkabiNo.Text := FormatedVariantVal(TPersonelKarti(Table).AyakkabiNo.FieldType, TPersonelKarti(Table).AyakkabiNo.Value);
  edtElbiseBedeni.Text := FormatedVariantVal(TPersonelKarti(Table).ElbiseBedeni.FieldType, TPersonelKarti(Table).ElbiseBedeni.Value);

  cbbAskerlikDurumu.Text := FormatedVariantVal(TPersonelKarti(Table).AskerlikDurum.FieldType, TPersonelKarti(Table).AskerlikDurum.Value);
  vAyarPersonelAskerlikDurumu.SelectToList(' AND ' + vAyarPersonelAskerlikDurumu.TableName + '.' + vAyarPersonelAskerlikDurumu.Id.FieldName + '=' + IntToStr(TPersonelKarti(Table).AskerlikDurumID.Value), False, False);

  cbbServisAdi.Text := FormatedVariantVal(TPersonelKarti(Table).Servis.FieldType, TPersonelKarti(Table).Servis.Value);
  vAyarPersonelTasimaServisi.SelectToList(' AND ' + vAyarPersonelTasimaServisi.TableName + '.' + vAyarPersonelTasimaServisi.Id.FieldName + '=' + IntToStr(TPersonelKarti(Table).ServisID.Value), False, False);

  edtBrutMaas.Text := FormatedVariantVal(TPersonelKarti(Table).BrutMaas.FieldType, TPersonelKarti(Table).BrutMaas.Value);
  edtIkramiyeSayisi.Text := FormatedVariantVal(TPersonelKarti(Table).IkramiyeSayisi.FieldType, TPersonelKarti(Table).IkramiyeSayisi.Value);
  edtIkramiyeMiktar.Text := FormatedVariantVal(TPersonelKarti(Table).IkramiyeMiktar.FieldType, TPersonelKarti(Table).IkramiyeMiktar.Value);
  mmoOzelNot.Text := FormatedVariantVal(TPersonelKarti(Table).OzelNot.FieldType, TPersonelKarti(Table).OzelNot.Value);
end;

procedure TfrmPersonelKarti.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TPersonelKarti(Table).IsActive.Value := chkIsActive.Checked;
      TPersonelKarti(Table).PersonelAd.Value := edtPersonelAd.Text;
      TPersonelKarti(Table).PersonelSoyad.Value := edtPersonelSoyad.Text;

      TPersonelKarti(Table).PersonelTipi.Value := cbbPersonelTipi.Text;
      if Assigned(cbbPersonelTipi.Items.Objects[cbbPersonelTipi.ItemIndex]) then
        TPersonelKarti(Table).PersonelTipiID.Value := TAyarPersonelTipi(cbbPersonelTipi.Items.Objects[cbbPersonelTipi.ItemIndex]).Id.Value;

      TPersonelKarti(Table).Bolum.Value := cbbBolum.Text;
      if Assigned(cbbBolum.Items.Objects[cbbBolum.ItemIndex]) then
        TPersonelKarti(Table).BolumID.Value := TAyarPersonelBolum(cbbBolum.Items.Objects[cbbBolum.ItemIndex]).Id.Value;

      TPersonelKarti(Table).Birim.Value := cbbBirim.Text;
      if Assigned(cbbBirim.Items.Objects[cbbBirim.ItemIndex]) then
        TPersonelKarti(Table).BirimID.Value := TAyarPersonelBirim(cbbBirim.Items.Objects[cbbBirim.ItemIndex]).Id.Value;

      TPersonelKarti(Table).Gorev.Value := cbbGorev.Text;
      if Assigned(cbbGorev.Items.Objects[cbbGorev.ItemIndex]) then
        TPersonelKarti(Table).GorevID.Value := TAyarPersonelGorev(cbbGorev.Items.Objects[cbbGorev.ItemIndex]).Id.Value;

      TPersonelKarti(Table).GenelNot.Value := mmoGenelNot.Lines.Text;


      TPersonelKarti(Table).Telefon1.Value := edtTelefon1.Text;
      TPersonelKarti(Table).Telefon2.Value := edtTelefon2.Text;
      TPersonelKarti(Table).MailAdresi.Value := edtMailAdresi.Text;
      TPersonelKarti(Table).YakinAdSoyad.Value := edtYakinAdSoyad.Text;
      TPersonelKarti(Table).YakinTelefon.Value := edtYakinTelefon.Text;
      TPersonelKarti(Table).EvAdresi.Value := edtEvAdresi.Text;
      TPersonelKarti(Table).TCKimlikNo.Value := edtTcKimlikNo.Text;
      TPersonelKarti(Table).DogumTarihi.Value := edtDogumTarihi.Text;
      TPersonelKarti(Table).KanGrubu.Value := cbbKanGrubu.Text;

      TPersonelKarti(Table).Cinsiyet.Value := cbbCinsiyet.Text;
      if Assigned(cbbCinsiyet.Items.Objects[cbbCinsiyet.ItemIndex]) then
        TPersonelKarti(Table).CinsiyetID.Value := TAyarPersonelCinsiyet(cbbCinsiyet.Items.Objects[cbbCinsiyet.ItemIndex]).Id.Value;

      TPersonelKarti(Table).MedeniDurum.Value := cbbMedeniDurumu.Text;
      if Assigned(cbbMedeniDurumu.Items.Objects[cbbMedeniDurumu.ItemIndex]) then
        TPersonelKarti(Table).MedeniDurumID.Value := TAyarPersonelMedeniDurum(cbbMedeniDurumu.Items.Objects[cbbMedeniDurumu.ItemIndex]).Id.Value;

      TPersonelKarti(Table).CocukSayisi.Value := edtCocukSayisi.Text;
      TPersonelKarti(Table).AyakkabiNo.Value := edtAyakkabiNo.Text;
      TPersonelKarti(Table).ElbiseBedeni.Value := edtElbiseBedeni.Text;

      TPersonelKarti(Table).AskerlikDurum.Value := cbbAskerlikDurumu.Text;
      if Assigned(cbbAskerlikDurumu.Items.Objects[cbbAskerlikDurumu.ItemIndex]) then
        TPersonelKarti(Table).AskerlikDurumID.Value := TAyarPersonelAskerlikDurumu(cbbAskerlikDurumu.Items.Objects[cbbAskerlikDurumu.ItemIndex]).Id.Value;

      TPersonelKarti(Table).Servis.Value := cbbServisAdi.Text;
      if Assigned(cbbServisAdi.Items.Objects[cbbServisAdi.ItemIndex]) then
        TPersonelKarti(Table).ServisID.Value := TPersonelTasimaServis(cbbServisAdi.Items.Objects[cbbServisAdi.ItemIndex]).Id.Value;

      TPersonelKarti(Table).BrutMaas.Value := edtBrutMaas.Text;
      TPersonelKarti(Table).IkramiyeSayisi.Value := edtIkramiyeSayisi.Text;
      TPersonelKarti(Table).IkramiyeMiktar.Value := edtIkramiyeMiktar.Text;
      TPersonelKarti(Table).OzelNot.Value := mmoOzelNot.Lines.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.

