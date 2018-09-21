unit ufrmSatisTeklifDetay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Samples.Spin;

type
  TfrmSatisTeklifDetay = class(TfrmBaseInputDB)
    lblStokKodu: TLabel;
    edtStokKodu: TthsEdit;
    lblStokAciklama: TLabel;
    edtStokAciklama: TthsEdit;
    lblVadeGun: TLabel;
    edtVadeGun: TthsEdit;
    lblAciklama: TLabel;
    edtAciklama: TthsEdit;
    lblReferans: TLabel;
    edtReferans: TthsEdit;
    lblFiyat: TLabel;
    edtFiyat: TthsEdit;
    lblIskonto: TLabel;
    edtIskonto: TthsEdit;
    lblKdv: TLabel;
    cbbKdv: TthsCombobox;
    lblVergiKodu: TLabel;
    cbbVergiKodu: TthsCombobox;
    lblMiktar: TLabel;
    edtMiktar: TthsEdit;
    lblOlcuBirimi: TLabel;
    cbbOlcuBirimi: TthsCombobox;
    lblGtipNo: TLabel;
    edtGtipNo: TthsEdit;
    lblVergiMuafiyetKodu: TLabel;
    cbbVergiMuafiyetKodu: TthsCombobox;
    lblDigerVergiKodu: TLabel;
    cbbDigerVergiKodu: TthsCombobox;
    PanelBilgilendirme: TPanel;
    lblTutar: TLabel;
    lblValTutar: TLabel;
    lblTutarPara: TLabel;
    lblIskontoTutar: TLabel;
    lblValIskontoTutar: TLabel;
    lblIskontoTutarPara: TLabel;
    lblKDVTutar: TLabel;
    lblValKDVTutar: TLabel;
    lblKdvTutarPara: TLabel;
    lblToplamTutar: TLabel;
    lblValToplamTutar: TLabel;
    lblToplamTutarPara: TLabel;
    imgStokResim: TImage;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
    procedure ClearTotalLabels;
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSatisTeklifDetaylar,
  Ths.Erp.Database.Table.SatisTeklif,
  Ths.Erp.Database.Table.SatisTeklifDetay;

{$R *.dfm}

procedure TfrmSatisTeklifDetay.ClearTotalLabels;
begin
  lblValTutar.Caption := '0.00';
  lblValIskontoTutar.Caption := '0.00';
  lblValKDVTutar.Caption := '0.00';
  lblValToplamTutar.Caption := '0.00';

  lblTutarPara.Caption := (TfrmSatisTeklifDetaylar(ParentForm).Table as TSatisTeklif).ParaBirimi.Value;
  lblIskontoTutarPara.Caption := (TfrmSatisTeklifDetaylar(ParentForm).Table as TSatisTeklif).ParaBirimi.Value;
  lblKdvTutarPara.Caption := (TfrmSatisTeklifDetaylar(ParentForm).Table as TSatisTeklif).ParaBirimi.Value;
  lblToplamTutarPara.Caption := (TfrmSatisTeklifDetaylar(ParentForm).Table as TSatisTeklif).ParaBirimi.Value;
end;

procedure TfrmSatisTeklifDetay.FormCreate(Sender: TObject);
begin
  TSatisTeklifDetay(Table).StokKodu.SetControlProperty(Table.TableName, edtStokKodu);
  TSatisTeklifDetay(Table).StokAciklama.SetControlProperty(Table.TableName, edtStokAciklama);
  TSatisTeklifDetay(Table).Aciklama.SetControlProperty(Table.TableName, edtAciklama);
  TSatisTeklifDetay(Table).Referans.SetControlProperty(Table.TableName, edtReferans);
  TSatisTeklifDetay(Table).Miktar.SetControlProperty(Table.TableName, edtMiktar);
  TSatisTeklifDetay(Table).OlcuBirimi.SetControlProperty(Table.TableName, cbbOlcuBirimi);
  TSatisTeklifDetay(Table).Fiyat.SetControlProperty(Table.TableName, edtFiyat);
  TSatisTeklifDetay(Table).Iskonto.SetControlProperty(Table.TableName, edtIskonto);
  TSatisTeklifDetay(Table).Kdv.SetControlProperty(Table.TableName, cbbKdv);
  TSatisTeklifDetay(Table).VadeGun.SetControlProperty(Table.TableName, edtVadeGun);
  TSatisTeklifDetay(Table).VergiKodu.SetControlProperty(Table.TableName, cbbVergiKodu);
  TSatisTeklifDetay(Table).VergiMuafiyetKodu.SetControlProperty(Table.TableName, cbbVergiMuafiyetKodu);
  TSatisTeklifDetay(Table).DigerVergiKodu.SetControlProperty(Table.TableName, cbbDigerVergiKodu);
  TSatisTeklifDetay(Table).GtipNo.SetControlProperty(Table.TableName, edtGtipNo);

  inherited;

  ClearTotalLabels;
end;

procedure TfrmSatisTeklifDetay.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtStokKodu.Text := FormatedVariantVal(TSatisTeklifDetay(Table).StokKodu.FieldType, TSatisTeklifDetay(Table).StokKodu.Value);
  edtStokAciklama.Text := FormatedVariantVal(TSatisTeklifDetay(Table).StokAciklama.FieldType, TSatisTeklifDetay(Table).StokAciklama.Value);
  edtAciklama.Text := FormatedVariantVal(TSatisTeklifDetay(Table).Aciklama.FieldType, TSatisTeklifDetay(Table).Aciklama.Value);
  edtReferans.Text := FormatedVariantVal(TSatisTeklifDetay(Table).Referans.FieldType, TSatisTeklifDetay(Table).Referans.Value);
  edtMiktar.Text := FormatedVariantVal(TSatisTeklifDetay(Table).Miktar.FieldType, TSatisTeklifDetay(Table).Miktar.Value);
  cbbOlcuBirimi.Text := FormatedVariantVal(TSatisTeklifDetay(Table).OlcuBirimi.FieldType, TSatisTeklifDetay(Table).OlcuBirimi.Value);
  edtFiyat.Text := FormatedVariantVal(TSatisTeklifDetay(Table).Fiyat.FieldType, TSatisTeklifDetay(Table).Fiyat.Value);
  edtIskonto.Text := FormatedVariantVal(TSatisTeklifDetay(Table).Iskonto.FieldType, TSatisTeklifDetay(Table).Iskonto.Value);
  cbbKdv.Text := FormatedVariantVal(TSatisTeklifDetay(Table).Kdv.FieldType, TSatisTeklifDetay(Table).Kdv.Value);
  edtVadeGun.Text := FormatedVariantVal(TSatisTeklifDetay(Table).VadeGun.FieldType, TSatisTeklifDetay(Table).VadeGun.Value);
  cbbVergiKodu.Text := FormatedVariantVal(TSatisTeklifDetay(Table).VergiKodu.FieldType, TSatisTeklifDetay(Table).VergiKodu.Value);
  cbbVergiMuafiyetKodu.Text := FormatedVariantVal(TSatisTeklifDetay(Table).VergiMuafiyetKodu.FieldType, TSatisTeklifDetay(Table).VergiMuafiyetKodu.Value);
  cbbDigerVergiKodu.Text := FormatedVariantVal(TSatisTeklifDetay(Table).DigerVergiKodu.FieldType, TSatisTeklifDetay(Table).DigerVergiKodu.Value);
  edtGtipNo.Text := FormatedVariantVal(TSatisTeklifDetay(Table).GtipNo.FieldType, TSatisTeklifDetay(Table).GtipNo.Value);
end;

procedure TfrmSatisTeklifDetay.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSatisTeklifDetay(Table).StokKodu.Value := edtStokKodu.Text;
      TSatisTeklifDetay(Table).StokAciklama.Value := edtStokAciklama.Text;
      TSatisTeklifDetay(Table).Aciklama.Value := edtAciklama.Text;
      TSatisTeklifDetay(Table).Referans.Value := edtReferans.Text;
      TSatisTeklifDetay(Table).Miktar.Value := edtMiktar.Text;
      TSatisTeklifDetay(Table).OlcuBirimi.Value := cbbOlcuBirimi.Text;
      TSatisTeklifDetay(Table).Fiyat.Value := edtFiyat.Text;
      TSatisTeklifDetay(Table).Iskonto.Value := edtIskonto.Text;
      TSatisTeklifDetay(Table).Kdv.Value := cbbKdv.Text;
      TSatisTeklifDetay(Table).VadeGun.Value := edtVadeGun.Text;
      TSatisTeklifDetay(Table).VergiKodu.Value := cbbVergiKodu.Text;
      TSatisTeklifDetay(Table).VergiMuafiyetKodu.Value := cbbVergiMuafiyetKodu.Text;
      TSatisTeklifDetay(Table).DigerVergiKodu.Value := cbbDigerVergiKodu.Text;
      TSatisTeklifDetay(Table).GtipNo.Value := edtGtipNo.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
