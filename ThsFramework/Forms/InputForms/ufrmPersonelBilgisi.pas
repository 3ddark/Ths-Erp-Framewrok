unit ufrmPersonelBilgisi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus;

type
  TfrmPersonelBilgisi = class(TfrmBaseInputDB)
    lblIsActive: TLabel;
    chkIsActive: TCheckBox;
    lblPersonelAd: TLabel;
    edtPersonelAd: TthsEdit;
    lblPersonelSoyad: TLabel;
    edtPersonelSoyad: TthsEdit;
    lblTelefon1: TLabel;
    edtTelefon1: TthsEdit;
    lblTelefon2: TLabel;
    edtTelefon2: TthsEdit;
    lblPersonelTipi: TLabel;
    cbbPersonelTipi: TthsComboBox;
    lblBolum: TLabel;
    cbbBolum: TthsComboBox;
    lblBirim: TLabel;
    cbbBirim: TthsComboBox;
    lblGorev: TLabel;
    cbbGorev: TthsComboBox;
    lblMailAdresi: TLabel;
    edtMailAdresi: TthsEdit;
    lblDogumTarihi: TLabel;
    edtDogumTarihi: TthsEdit;
    lblKanGrubu: TLabel;
    cbbKanGrubu: TthsComboBox;
    lblCinsiyet: TLabel;
    cbbCinsiyet: TthsComboBox;
    lblAskerlikDurumu: TLabel;
    cbbAskerlikDurumu: TthsComboBox;
    lblMedeniDurumu: TLabel;
    cbbMedeniDurumu: TthsComboBox;
    lblCocukSayisi: TLabel;
    edtCocukSayisi: TthsEdit;
    lblYakinAdSoyad: TLabel;
    edtYakinAdSoyad: TthsEdit;
    lblYakinTelefon: TLabel;
    edtYakinTelefon: TthsEdit;
    lblEvAdresi: TLabel;
    edtEvAdresi: TthsEdit;
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
  Ths.Erp.Database.Table.PersonelBilgisi;

{$R *.dfm}

procedure TfrmPersonelBilgisi.FormCreate(Sender: TObject);
begin
  TPersonelBilgisi(Table).PersonelAd.SetControlProperty(Table.TableName, edtPersonelAd);
  TPersonelBilgisi(Table).PersonelSoyad.SetControlProperty(Table.TableName, edtPersonelSoyad);
  TPersonelBilgisi(Table).Telefon1.SetControlProperty(Table.TableName, edtTelefon1);
  TPersonelBilgisi(Table).Telefon2.SetControlProperty(Table.TableName, edtTelefon2);
  TPersonelBilgisi(Table).PersonelTipi.SetControlProperty(Table.TableName, cbbPersonelTipi);
  TPersonelBilgisi(Table).Bolum.SetControlProperty(Table.TableName, cbbBolum);
  TPersonelBilgisi(Table).Birim.SetControlProperty(Table.TableName, cbbBirim);
  TPersonelBilgisi(Table).Gorev.SetControlProperty(Table.TableName, cbbGorev);
  TPersonelBilgisi(Table).MailAdresi.SetControlProperty(Table.TableName, edtMailAdresi);
  TPersonelBilgisi(Table).DogumTarihi.SetControlProperty(Table.TableName, edtDogumTarihi);
  TPersonelBilgisi(Table).KanGrubu.SetControlProperty(Table.TableName, cbbKanGrubu);
  TPersonelBilgisi(Table).Cinsiyet.SetControlProperty(Table.TableName, cbbCinsiyet);
  TPersonelBilgisi(Table).AskerlikDurumu.SetControlProperty(Table.TableName, cbbAskerlikDurumu);
  TPersonelBilgisi(Table).MedeniDurumu.SetControlProperty(Table.TableName, cbbMedeniDurumu);
  TPersonelBilgisi(Table).CocukSayisi.SetControlProperty(Table.TableName, edtCocukSayisi);
  TPersonelBilgisi(Table).YakinAdSoyad.SetControlProperty(Table.TableName, edtYakinAdSoyad);
  TPersonelBilgisi(Table).YakinTelefon.SetControlProperty(Table.TableName, edtYakinTelefon);
  TPersonelBilgisi(Table).EvAdresi.SetControlProperty(Table.TableName, edtEvAdresi);

  inherited;
end;

procedure TfrmPersonelBilgisi.RefreshData();
begin
  //control içeriðini table class ile doldur
  chkIsActive.Checked := GetVarToFormatedValue(TPersonelBilgisi(Table).IsActive.FieldType, TPersonelBilgisi(Table).IsActive.Value);
  edtPersonelAd.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).PersonelAd.FieldType, TPersonelBilgisi(Table).PersonelAd.Value);
  edtPersonelSoyad.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).PersonelSoyad.FieldType, TPersonelBilgisi(Table).PersonelSoyad.Value);
  edtTelefon1.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).Telefon1.FieldType, TPersonelBilgisi(Table).Telefon1.Value);
  edtTelefon2.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).Telefon2.FieldType, TPersonelBilgisi(Table).Telefon2.Value);
  cbbPersonelTipi.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).PersonelTipi.FieldType, TPersonelBilgisi(Table).PersonelTipi.Value);
  cbbBolum.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).Bolum.FieldType, TPersonelBilgisi(Table).Bolum.Value);
  cbbBirim.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).Birim.FieldType, TPersonelBilgisi(Table).Birim.Value);
  cbbGorev.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).Gorev.FieldType, TPersonelBilgisi(Table).Gorev.Value);
  edtMailAdresi.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).MailAdresi.FieldType, TPersonelBilgisi(Table).MailAdresi.Value);
  edtDogumTarihi.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).DogumTarihi.FieldType, TPersonelBilgisi(Table).DogumTarihi.Value);
  cbbKanGrubu.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).KanGrubu.FieldType, TPersonelBilgisi(Table).KanGrubu.Value);
  cbbCinsiyet.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).Cinsiyet.FieldType, TPersonelBilgisi(Table).Cinsiyet.Value);
  cbbAskerlikDurumu.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).AskerlikDurumu.FieldType, TPersonelBilgisi(Table).AskerlikDurumu.Value);
  cbbMedeniDurumu.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).MedeniDurumu.FieldType, TPersonelBilgisi(Table).MedeniDurumu.Value);
  edtCocukSayisi.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).CocukSayisi.FieldType, TPersonelBilgisi(Table).CocukSayisi.Value);
  edtYakinAdSoyad.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).YakinAdSoyad.FieldType, TPersonelBilgisi(Table).YakinAdSoyad.Value);
  edtYakinTelefon.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).YakinTelefon.FieldType, TPersonelBilgisi(Table).YakinTelefon.Value);
  edtEvAdresi.Text := GetVarToFormatedValue(TPersonelBilgisi(Table).EvAdresi.FieldType, TPersonelBilgisi(Table).EvAdresi.Value);
end;

procedure TfrmPersonelBilgisi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TPersonelBilgisi(Table).IsActive.Value := chkIsActive.Checked;
      TPersonelBilgisi(Table).PersonelAd.Value := edtPersonelAd.Text;
      TPersonelBilgisi(Table).PersonelSoyad.Value := edtPersonelSoyad.Text;
      TPersonelBilgisi(Table).Telefon1.Value := edtTelefon1.Text;
      TPersonelBilgisi(Table).Telefon2.Value := edtTelefon2.Text;
      TPersonelBilgisi(Table).PersonelTipi.Value := cbbPersonelTipi.Text;
      TPersonelBilgisi(Table).Bolum.Value := cbbBolum.Text;
      TPersonelBilgisi(Table).Birim.Value := cbbBirim.Text;
      TPersonelBilgisi(Table).Gorev.Value := cbbGorev.Text;
      TPersonelBilgisi(Table).MailAdresi.Value := edtMailAdresi.Text;
      TPersonelBilgisi(Table).DogumTarihi.Value := edtDogumTarihi.Text;
      TPersonelBilgisi(Table).KanGrubu.Value := cbbKanGrubu.Text;
      TPersonelBilgisi(Table).Cinsiyet.Value := cbbCinsiyet.Text;
      TPersonelBilgisi(Table).AskerlikDurumu.Value := cbbAskerlikDurumu.Text;
      TPersonelBilgisi(Table).MedeniDurumu.Value := cbbMedeniDurumu.Text;
      TPersonelBilgisi(Table).CocukSayisi.Value := edtCocukSayisi.Text;
      TPersonelBilgisi(Table).YakinAdSoyad.Value := edtYakinAdSoyad.Text;
      TPersonelBilgisi(Table).YakinTelefon.Value := edtYakinTelefon.Text;
      TPersonelBilgisi(Table).EvAdresi.Value := edtEvAdresi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
