unit ufrmPersonelKarti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Samples.Spin, Vcl.Mask,

  Ths.Erp.Helper.BaseTypes,
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
    lblBrutMaas: TLabel;
    lblOzelNot: TLabel;
    lblIkramiyeSayisi: TLabel;
    lblIkramiyeMiktar: TLabel;
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
    lblTelefon1: TLabel;
    lblTelefon2: TLabel;
    lblYakinTelefon: TLabel;
    lblYakinAdSoyad: TLabel;
    lblMailAdresi: TLabel;
    lblAyakkabiNo: TLabel;
    lblElbiseBedeni: TLabel;
    lblTCKimlikNo: TLabel;
    lblDogumTarihi: TLabel;
    lblKanGrubu: TLabel;
    lblCinsiyet: TLabel;
    lblMedeniDurumu: TLabel;
    lblAskerlikDurumu: TLabel;
    lblCocukSayisi: TLabel;
    chkIsActive: TCheckBox;
    edtPersonelAd: TEdit;
    edtPersonelSoyad: TEdit;
    edtPersonelTipi: TEdit;
    edtBolum: TEdit;
    edtBirim: TEdit;
    edtGorev: TEdit;
    mmoGenelNot: TMemo;
    imgPersonelResim: TImage;
    lblServisAdi: TLabel;
    edtServisAdi: TEdit;
    edtTelefon1: TEdit;
    edtTelefon2: TEdit;
    edtMailAdresi: TEdit;
    edtYakinAdSoyad: TEdit;
    edtYakinTelefon: TEdit;
    edtAyakkabiNo: TEdit;
    edtElbiseBedeni: TEdit;
    edtTcKimlikNo: TEdit;
    edtDogumTarihi: TEdit;
    cbbKanGrubu: TComboBox;
    edtCinsiyet: TEdit;
    edtMedeniDurumu: TEdit;
    edtCocukSayisi: TEdit;
    edtAskerlikDurumu: TEdit;
    edtBrutMaas: TEdit;
    edtIkramiyeSayisi: TEdit;
    edtIkramiyeMiktar: TEdit;
    mmoOzelNot: TMemo;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure pgcPersonelChange(Sender: TObject);
    procedure edtCinsiyetChange(Sender: TObject);
    procedure edtMedeniDurumuChange(Sender: TObject);
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

procedure TfrmPersonelKarti.edtCinsiyetChange(Sender: TObject);
begin
  if TAyarPrsCinsiyet(TPersonelKarti(Table).CinsiyetID.FK.FKTable).IsMan.Value then
  begin
    lblAskerlikDurumu.Visible := True;
    edtAskerlikDurumu.Visible := True;
    edtAskerlikDurumu.thsRequiredData := True;
  end
  else
  begin
    lblAskerlikDurumu.Visible := False;
    edtAskerlikDurumu.Visible := False;
    edtAskerlikDurumu.thsRequiredData := False;
    edtAskerlikDurumu.Clear;
    TPersonelKarti(Table).AskerlikDurumID.Value := Null;
  end;
end;

procedure TfrmPersonelKarti.edtMedeniDurumuChange(Sender: TObject);
begin
  if TAyarPrsMedeniDurum(TPersonelKarti(Table).MedeniDurumID.FK.FKTable).IsMarried.Value then
  begin
    lblCocukSayisi.Visible := True;
    edtCocukSayisi.Visible := True;
    edtCocukSayisi.thsRequiredData := True;
  end
  else
  begin
    lblCocukSayisi.Visible := False;
    edtCocukSayisi.Visible := False;
    edtCocukSayisi.thsRequiredData := False;
    edtCocukSayisi.Clear;
    TPersonelKarti(Table).CocukSayisi.Value := Null;
  end;
end;

procedure TfrmPersonelKarti.FormCreate(Sender: TObject);
begin
  TPersonelKarti(Table).PersonelAd.SetControlProperty(Table.TableName, edtPersonelAd);
  TPersonelKarti(Table).PersonelSoyad.SetControlProperty(Table.TableName, edtPersonelSoyad);
  TPersonelKarti(Table).PersonelTipiID.FK.FKCol.SetControlProperty(Table.TableName, edtPersonelTipi);
  TPersonelKarti(Table).BolumID.FK.FKCol.SetControlProperty(Table.TableName, edtBolum);
  TPersonelKarti(Table).BirimID.FK.FKCol.SetControlProperty(Table.TableName, edtBirim);
  TPersonelKarti(Table).GorevID.FK.FKCol.SetControlProperty(Table.TableName, edtGorev);
  TPersonelKarti(Table).GenelNot.SetControlProperty(Table.TableName, mmoGenelNot);

  TPersonelKarti(Table).Adres.UlkeID.SetControlProperty(Table.TableName, edtUlke);
  TPersonelKarti(Table).Adres.SehirID.SetControlProperty(Table.TableName, edtSehir);
  TPersonelKarti(Table).Adres.Ilce.SetControlProperty(Table.TableName, edtIlce);
  TPersonelKarti(Table).Adres.Mahalle.SetControlProperty(Table.TableName, edtMahalle);
  TPersonelKarti(Table).Adres.Cadde.SetControlProperty(Table.TableName, edtCadde);
  TPersonelKarti(Table).Adres.Sokak.SetControlProperty(Table.TableName, edtSokak);
  TPersonelKarti(Table).Adres.Bina.SetControlProperty(Table.TableName, edtBina);
  TPersonelKarti(Table).Adres.KapiNo.SetControlProperty(Table.TableName, edtKapiNo);
  TPersonelKarti(Table).Adres.PostaKutusu.SetControlProperty(Table.TableName, edtPostaKutusu);
  TPersonelKarti(Table).Adres.PostaKodu.SetControlProperty(Table.TableName, edtPostaKodu);
  TPersonelKarti(Table).Adres.ePostaAdresi.SetControlProperty(Table.TableName, edtMailAdresi);

  TPersonelKarti(Table).Telefon1.SetControlProperty(Table.TableName, edtTelefon1);
  TPersonelKarti(Table).Telefon2.SetControlProperty(Table.TableName, edtTelefon2);
  TPersonelKarti(Table).MailAdresi.SetControlProperty(Table.TableName, edtMailAdresi);
  TPersonelKarti(Table).YakinAdSoyad.SetControlProperty(Table.TableName, edtYakinAdSoyad);
  TPersonelKarti(Table).YakinTelefon.SetControlProperty(Table.TableName, edtYakinTelefon);
  TPersonelKarti(Table).TCKimlikNo.SetControlProperty(Table.TableName, edtTcKimlikNo);
  TPersonelKarti(Table).DogumTarihi.SetControlProperty(Table.TableName, edtDogumTarihi);
  TPersonelKarti(Table).KanGrubu.SetControlProperty(Table.TableName, cbbKanGrubu);
  TPersonelKarti(Table).CinsiyetID.FK.FKCol.SetControlProperty(Table.TableName, edtCinsiyet);
  TPersonelKarti(Table).MedeniDurumID.FK.FKCol.SetControlProperty(Table.TableName, edtMedeniDurumu);
  TPersonelKarti(Table).CocukSayisi.SetControlProperty(Table.TableName, edtCocukSayisi);
  TPersonelKarti(Table).AyakkabiNo.SetControlProperty(Table.TableName, edtAyakkabiNo);
  TPersonelKarti(Table).ElbiseBedeni.SetControlProperty(Table.TableName, edtElbiseBedeni);
  TPersonelKarti(Table).AskerlikDurumID.FK.FKCol.SetControlProperty(Table.TableName, edtAskerlikDurumu);
  TPersonelKarti(Table).ServisID.FK.FKCol.SetControlProperty(Table.TableName, edtServisAdi);

  TPersonelKarti(Table).BrutMaas.SetControlProperty(Table.TableName, edtBrutMaas);
  TPersonelKarti(Table).IkramiyeSayisi.SetControlProperty(Table.TableName, edtIkramiyeSayisi);
  TPersonelKarti(Table).IkramiyeMiktar.SetControlProperty(Table.TableName, edtIkramiyeMiktar);
  TPersonelKarti(Table).OzelNot.SetControlProperty(Table.TableName, mmoOzelNot);

  inherited;

  mmoGenelNot.CharCase := ecNormal;
  mmoOzelNot.CharCase := ecNormal;
  edtMailAdresi.CharCase := ecNormal;

  chkIsActive.Visible := False;
  lblIsActive.Visible := False;

  pgcPersonel.ActivePage := tsGenel;
end;

procedure TfrmPersonelKarti.FormShow(Sender: TObject);
begin
  cbbKanGrubu.Clear;
  cbbKanGrubu.Items.Add('A RH+');
  cbbKanGrubu.Items.Add('B RH+');
  cbbKanGrubu.Items.Add('AB RH+');
  cbbKanGrubu.Items.Add('0 RH+');
  cbbKanGrubu.Items.Add('A RH-');
  cbbKanGrubu.Items.Add('B RH-');
  cbbKanGrubu.Items.Add('AB RH-');
  cbbKanGrubu.Items.Add('0 RH-');

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

  edtBolum.ReadOnly := True;
  edtUlke.ReadOnly := True;

  edtPersonelTipi.OnHelperProcess := HelperProcess;
  edtBirim.OnHelperProcess := HelperProcess;
  edtGorev.OnHelperProcess := HelperProcess;
  edtCinsiyet.OnHelperProcess := HelperProcess;
  edtMedeniDurumu.OnHelperProcess := HelperProcess;
  edtAskerlikDurumu.OnHelperProcess := HelperProcess;
  edtServisAdi.OnHelperProcess := HelperProcess;
  edtSehir.OnHelperProcess := HelperProcess;


  {$ifdef DEBUG}
    if FormMode = ifmNewRecord then
    begin
      edtPersonelAd.Text := 'AYNUR';
      edtPersonelSoyad.Text := 'YILDIRIM';
      edtDogumTarihi.Text := '01.01.1988';
      edtBrutMaas.Text := '3000';
      edtIlce.Text := 'PENDÝK';
      edtMahalle.Text := 'ESENLER';
      edtCadde.Text := 'RIFAT ILGAZ';
      edtSokak.Text := 'Sýrdaþ';
      edtBina.Text := 'XXX';
      edtKapiNo.Text := '6/1';
      edtPostaKodu.Text := '34890';
    end;
  {$EndIf}

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
      if TEdit(Sender).Name = edtPersonelTipi.Name then
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
      if TEdit(Sender).Name = edtBirim.Name then
      begin
        vHelperBirim := TfrmHelperAyarPrsBirim.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperBirim.ShowModal;

          if Assigned(TPersonelKarti(Table).BirimID.FK.FKTable) then
            TPersonelKarti(Table).BirimID.FK.FKTable.Free;
          TPersonelKarti(Table).BirimID.Value := vHelperBirim.Table.Id.Value;
          TPersonelKarti(Table).BirimID.FK.FKTable := vHelperBirim.Table.Clone;
          edtBolum.Text := TAyarPrsBirim(TPersonelKarti(Table).BirimID.FK.FKTable).BolumID.FK.FKCol.Value;
          TPersonelKarti(Table).BolumID.Value := TAyarPrsBirim(TPersonelKarti(Table).BirimID.FK.FKTable).BolumID.Value;
        finally
          vHelperBirim.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtGorev.Name then
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
      if TEdit(Sender).Name = edtCinsiyet.Name then
      begin
        vHelperCinsiyet := TfrmHelperAyarPrsCinsiyet.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperCinsiyet.ShowModal;

          if Assigned(TPersonelKarti(Table).CinsiyetID.FK.FKTable) then
            TPersonelKarti(Table).CinsiyetID.FK.FKTable.Free;
          TPersonelKarti(Table).CinsiyetID.Value := vHelperCinsiyet.Table.Id.Value;
          TPersonelKarti(Table).CinsiyetID.FK.FKTable := vHelperCinsiyet.Table.Clone;
          edtCinsiyetChange(edtCinsiyet);
        finally
          vHelperCinsiyet.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtMedeniDurumu.Name then
      begin
        vHelperMedeniDurum := TfrmHelperAyarPrsMedeniDurum.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperMedeniDurum.ShowModal;

          if Assigned(TPersonelKarti(Table).MedeniDurumID.FK.FKTable) then
            TPersonelKarti(Table).MedeniDurumID.FK.FKTable.Free;
          TPersonelKarti(Table).MedeniDurumID.Value := vHelperMedeniDurum.Table.Id.Value;
          TPersonelKarti(Table).MedeniDurumID.FK.FKTable := vHelperMedeniDurum.Table.Clone;
          edtMedeniDurumuChange(edtMedeniDurumu);
        finally
          vHelperMedeniDurum.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtAskerlikDurumu.Name then
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
      if TEdit(Sender).Name = edtServisAdi.Name then
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
      if TEdit(Sender).Name = edtSehir.Name then
      begin
        vHelperSehir := TfrmHelperSehir.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperSehir.ShowModal;

          if Assigned(TPersonelKarti(Table).Adres.SehirID.FK.FKTable) then
            TPersonelKarti(Table).Adres.SehirID.FK.FKTable.Free;
          TPersonelKarti(Table).Adres.SehirID.Value := vHelperSehir.Table.Id.Value;
          TPersonelKarti(Table).ServisID.FK.FKTable := vHelperSehir.Table.Clone;
          edtUlke.Text := TSehir(TPersonelKarti(Table).ServisID.FK.FKTable).UlkeID.FK.FKCol.Value;
          TPersonelKarti(Table).Adres.UlkeID.Value := TSehir(TPersonelKarti(Table).ServisID.FK.FKTable).UlkeID.Value;
        finally
          vHelperSehir.Free;
        end;
      end
    end;
  end;
end;

procedure TfrmPersonelKarti.pgcPersonelChange(Sender: TObject);
begin
  inherited;
  lblPersonelAd.Parent := pgcPersonel.ActivePage;
  edtPersonelAd.Parent := pgcPersonel.ActivePage;
  lblPersonelSoyad.Parent := pgcPersonel.ActivePage;
  edtPersonelSoyad.Parent := pgcPersonel.ActivePage;

  if pgcPersonel.ActivePage.Name = tsGenel.Name then
  begin
    edtPersonelAd.ReadOnly := False;
    edtPersonelAd.TabStop := True;
    edtPersonelSoyad.ReadOnly := False;
    edtPersonelSoyad.TabStop := True;

    edtPersonelAd.TabOrder := 0;
    edtPersonelSoyad.TabOrder := 1;
    edtPersonelAd.SetFocus;
  end
  else
  begin
    edtPersonelAd.ReadOnly := True;
    edtPersonelAd.TabStop := False;
    edtPersonelAd.ReadOnly := True;
    edtPersonelSoyad.TabStop := False;
  end;
end;

procedure TfrmPersonelKarti.RefreshData();
begin
  //control içeriðini table class ile doldur
  chkIsActive.Checked := FormatedVariantVal(TPersonelKarti(Table).IsActive.FieldType, TPersonelKarti(Table).IsActive.Value);
  edtPersonelAd.Text := FormatedVariantVal(TPersonelKarti(Table).PersonelAd.FieldType, TPersonelKarti(Table).PersonelAd.Value);
  edtPersonelSoyad.Text := FormatedVariantVal(TPersonelKarti(Table).PersonelSoyad.FieldType, TPersonelKarti(Table).PersonelSoyad.Value);
  edtPersonelTipi.Text := FormatedVariantVal(TPersonelKarti(Table).PersonelTipiID.FK.FKCol.FieldType, TPersonelKarti(Table).PersonelTipiID.FK.FKCol.Value);
  edtBolum.Text := FormatedVariantVal(TPersonelKarti(Table).BolumID.FK.FKCol.FieldType, TPersonelKarti(Table).BolumID.FK.FKCol.Value);
  edtBirim.Text := FormatedVariantVal(TPersonelKarti(Table).BirimID.FK.FKCol.FieldType, TPersonelKarti(Table).BirimID.FK.FKCol.Value);
  edtGorev.Text := FormatedVariantVal(TPersonelKarti(Table).GorevID.FK.FKCol.FieldType, TPersonelKarti(Table).GorevID.FK.FKCol.Value);
  mmoGenelNot.Text := FormatedVariantVal(TPersonelKarti(Table).GenelNot.FieldType, TPersonelKarti(Table).GenelNot.Value);

  edtUlke.Text := TPersonelKarti(Table).Adres.UlkeID.FK.FKCol.Value;
  edtSehir.Text := TPersonelKarti(Table).Adres.SehirID.FK.FKCol.Value;
  edtIlce.Text := TPersonelKarti(Table).Adres.Ilce.Value;
  edtMahalle.Text := TPersonelKarti(Table).Adres.Mahalle.Value;
  edtCadde.Text := TPersonelKarti(Table).Adres.Cadde.Value;
  edtSokak.Text := TPersonelKarti(Table).Adres.Sokak.Value;
  edtBina.Text := TPersonelKarti(Table).Adres.Bina.Value;
  edtKapiNo.Text := TPersonelKarti(Table).Adres.KapiNo.Value;
  edtPostaKutusu.Text := TPersonelKarti(Table).Adres.PostaKutusu.Value;
  edtPostaKodu.Text := TPersonelKarti(Table).Adres.PostaKodu.Value;

  edtTelefon1.Text := FormatedVariantVal(TPersonelKarti(Table).Telefon1.FieldType, TPersonelKarti(Table).Telefon1.Value);
  edtTelefon2.Text := FormatedVariantVal(TPersonelKarti(Table).Telefon2.FieldType, TPersonelKarti(Table).Telefon2.Value);
  edtMailAdresi.Text := FormatedVariantVal(TPersonelKarti(Table).MailAdresi.FieldType, TPersonelKarti(Table).MailAdresi.Value);
  edtYakinAdSoyad.Text := FormatedVariantVal(TPersonelKarti(Table).YakinAdSoyad.FieldType, TPersonelKarti(Table).YakinAdSoyad.Value);
  edtYakinTelefon.Text := FormatedVariantVal(TPersonelKarti(Table).YakinTelefon.FieldType, TPersonelKarti(Table).YakinTelefon.Value);

  if FormMode = ifmUpdate then
    edtTcKimlikNo.Text := TFunctions.DecryptStr(FormatedVariantVal(TPersonelKarti(Table).TCKimlikNo.FieldType, TPersonelKarti(Table).TCKimlikNo.Value), TSingletonDB.GetInstance.ApplicationSetting.CryptKey.Value)
  else
    edtTcKimlikNo.Text := FormatedVariantVal(TPersonelKarti(Table).TCKimlikNo.FieldType, TPersonelKarti(Table).TCKimlikNo.Value);
  edtDogumTarihi.Text := FormatedVariantVal(TPersonelKarti(Table).DogumTarihi.FieldType, TPersonelKarti(Table).DogumTarihi.Value);
  cbbKanGrubu.ItemIndex := cbbKanGrubu.Items.IndexOf(TPersonelKarti(Table).KanGrubu.Value);
  edtCinsiyet.Text := FormatedVariantVal(TPersonelKarti(Table).CinsiyetID.FK.FKCol.FieldType, TPersonelKarti(Table).CinsiyetID.FK.FKCol.Value);
  edtCinsiyetChange(edtCinsiyet);
  edtMedeniDurumu.Text := FormatedVariantVal(TPersonelKarti(Table).MedeniDurumID.FK.FKCol.FieldType, TPersonelKarti(Table).MedeniDurumID.FK.FKCol.Value);
  edtMedeniDurumuChange(edtMedeniDurumu);
  edtCocukSayisi.Text := FormatedVariantVal(TPersonelKarti(Table).CocukSayisi.FieldType, TPersonelKarti(Table).CocukSayisi.Value);
  edtAyakkabiNo.Text := FormatedVariantVal(TPersonelKarti(Table).AyakkabiNo.FieldType, TPersonelKarti(Table).AyakkabiNo.Value);
  edtElbiseBedeni.Text := FormatedVariantVal(TPersonelKarti(Table).ElbiseBedeni.FieldType, TPersonelKarti(Table).ElbiseBedeni.Value);
  edtAskerlikDurumu.Text := FormatedVariantVal(TPersonelKarti(Table).AskerlikDurumID.FK.FKCol.FieldType, TPersonelKarti(Table).AskerlikDurumID.FK.FKCol.Value);
  edtServisAdi.Text := FormatedVariantVal(TPersonelKarti(Table).ServisID.FK.FKCol.FieldType, TPersonelKarti(Table).ServisID.FK.FKCol.Value);

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
      if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) then
        TPersonelKarti(Table).IsActive.Value := True
      else
        TPersonelKarti(Table).IsActive.Value := chkIsActive.Checked;

      TPersonelKarti(Table).PersonelAd.Value := edtPersonelAd.Text;
      TPersonelKarti(Table).PersonelSoyad.Value := edtPersonelSoyad.Text;
      TPersonelKarti(Table).PersonelAdSoyad.Value := edtPersonelAd.Text + ' ' + edtPersonelSoyad.Text;
      TPersonelKarti(Table).PersonelTipiID.Value := TPersonelKarti(Table).PersonelTipiID.Value;
      TPersonelKarti(Table).BolumID.Value := TPersonelKarti(Table).BolumID.Value;
      TPersonelKarti(Table).BirimID.Value := TPersonelKarti(Table).BirimID.Value;
      TPersonelKarti(Table).GorevID.Value := TPersonelKarti(Table).GorevID.Value;
      TPersonelKarti(Table).GenelNot.Value := mmoGenelNot.Lines.Text;

      TPersonelKarti(Table).Adres.UlkeID.Value := TPersonelKarti(Table).Adres.UlkeID.Value;
      TPersonelKarti(Table).Adres.SehirID.Value := TPersonelKarti(Table).Adres.SehirID.Value;
      TPersonelKarti(Table).Adres.Ilce.Value := edtIlce.Text;
      TPersonelKarti(Table).Adres.Mahalle.Value := edtMahalle.Text;
      TPersonelKarti(Table).Adres.Cadde.Value := edtCadde.Text;
      TPersonelKarti(Table).Adres.Sokak.Value := edtSokak.Text;
      TPersonelKarti(Table).Adres.Bina.Value := edtBina.Text;
      TPersonelKarti(Table).Adres.KapiNo.Value := edtKapiNo.Text;
      TPersonelKarti(Table).Adres.PostaKutusu.Value := edtPostaKutusu.Text;
      TPersonelKarti(Table).Adres.PostaKodu.Value := edtPostaKodu.Text;
      TPersonelKarti(Table).Adres.ePostaAdresi.Value := '';
      TPersonelKarti(Table).Adres.WebSitesi.Value := '';

      TPersonelKarti(Table).Telefon1.Value := edtTelefon1.Text;
      TPersonelKarti(Table).Telefon2.Value := edtTelefon2.Text;
      TPersonelKarti(Table).MailAdresi.Value := edtMailAdresi.Text;
      TPersonelKarti(Table).YakinAdSoyad.Value := edtYakinAdSoyad.Text;
      TPersonelKarti(Table).YakinTelefon.Value := edtYakinTelefon.Text;
      TPersonelKarti(Table).TCKimlikNo.Value := TFunctions.EncryptStr(edtTcKimlikNo.Text, TSingletonDB.GetInstance.ApplicationSetting.CryptKey.Value);
      TPersonelKarti(Table).DogumTarihi.Value := edtDogumTarihi.Text;
      TPersonelKarti(Table).KanGrubu.Value := cbbKanGrubu.Text;
      TPersonelKarti(Table).CinsiyetID.Value := TPersonelKarti(Table).CinsiyetID.Value;
      TPersonelKarti(Table).MedeniDurumID.Value := TPersonelKarti(Table).MedeniDurumID.Value;
      TPersonelKarti(Table).CocukSayisi.Value := StrToIntDef(edtCocukSayisi.Text, 0);
      TPersonelKarti(Table).AyakkabiNo.Value := edtAyakkabiNo.Text;
      TPersonelKarti(Table).ElbiseBedeni.Value := edtElbiseBedeni.Text;
      TPersonelKarti(Table).AskerlikDurumID.Value := TPersonelKarti(Table).AskerlikDurumID.Value;
      TPersonelKarti(Table).ServisID.Value := TPersonelKarti(Table).ServisID.Value;
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

