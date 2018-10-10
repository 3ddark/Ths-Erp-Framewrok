unit ufrmSysApplicationSettingsOther;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmSysApplicationSettingsOther = class(TfrmBaseInputDB)
    lblIsEdefterAktif: TLabel;
    chkIsEdefterAktif: TCheckBox;
    lblVarsayilanSatisCariKod: TLabel;
    edtVarsayilanSatisCariKod: TEdit;
    lblVarsayilanAlisCariKod: TLabel;
    edtVarsayilanAlisCariKod: TEdit;
    lblIsBolumAmbardaUretimYap: TLabel;
    chkIsBolumAmbardaUretimYap: TCheckBox;
    lblIsUretimMuhasebeKaydiOlustursun: TLabel;
    chkIsUretimMuhasebeKaydiOlustursun: TCheckBox;
    lblIsStokSatimdaNegatifeDusebilir: TLabel;
    chkIsStokSatimdaNegatifeDusebilir: TCheckBox;
    lblIsMalSatisSayilariniGoster: TLabel;
    chkIsMalSatisSayilariniGoster: TCheckBox;
    lblIsPcbUretim: TLabel;
    chkIsPcbUretim: TCheckBox;
    lblIsProformaNoGoster: TLabel;
    chkIsProformaNoGoster: TCheckBox;
    lblIsSatisTakip: TLabel;
    chkIsSatisTakip: TCheckBox;
    lblIsHammaddeGiriseGoreSirala: TLabel;
    chkIsHammaddeGiriseGoreSirala: TCheckBox;
    lblIsUretimEntegrasyonHammaddeKullanimHesabiIscilikle: TLabel;
    chkIsUretimEntegrasyonHammaddeKullanimHesabiIscilikle: TCheckBox;
    lblIsTahsilatListesiVirmanli: TLabel;
    chkIsTahsilatListesiVirmanli: TCheckBox;
    lblIsOrtalamaVadeSifirsaSevkiyataIzinVerme: TLabel;
    chkIsOrtalamaVadeSifirsaSevkiyataIzinVerme: TCheckBox;
    lblIsSiparisteTeslimTarihiYazdir: TLabel;
    chkIsSiparisteTeslimTarihiYazdir: TCheckBox;
    lblIsTeklifAyrintilariniGoster: TLabel;
    chkIsTeklifAyrintilariniGoster: TCheckBox;
    lblIsFaturaIrsaliyeNoSifirlaBaslasin: TLabel;
    chkIsFaturaIrsaliyeNoSifirlaBaslasin: TCheckBox;
    lblIsExcelEkliIrsaliyeYazdirma: TLabel;
    chkIsExcelEkliIrsaliyeYazdirma: TCheckBox;
    lblIsAmbarTransferNumarasiOtomatikGelsin: TLabel;
    chkIsAmbarTransferNumarasiOtomatikGelsin: TCheckBox;
    lblIsAmbarTransferOnayliCalissin: TLabel;
    chkIsAmbarTransferOnayliCalissin: TCheckBox;
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
  Ths.Erp.Database.Table.SysApplicationSettingsOther;

{$R *.dfm}

procedure TfrmSysApplicationSettingsOther.FormCreate(Sender: TObject);
begin
  TSysApplicationSettingsOther(Table).VarsayilanSatisCariKod.SetControlProperty(Table.TableName, edtVarsayilanSatisCariKod);
  TSysApplicationSettingsOther(Table).VarsayilanAlisCariKod.SetControlProperty(Table.TableName, edtVarsayilanAlisCariKod);

  inherited;
end;

procedure TfrmSysApplicationSettingsOther.RefreshData();
begin
  //control içeriðini table class ile doldur
  chkIsEdefterAktif.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsEdefterAktif.FieldType, TSysApplicationSettingsOther(Table).IsEdefterAktif.Value);
  edtVarsayilanSatisCariKod.Text := FormatedVariantVal(TSysApplicationSettingsOther(Table).VarsayilanSatisCariKod.FieldType, TSysApplicationSettingsOther(Table).VarsayilanSatisCariKod.Value);
  edtVarsayilanAlisCariKod.Text := FormatedVariantVal(TSysApplicationSettingsOther(Table).VarsayilanAlisCariKod.FieldType, TSysApplicationSettingsOther(Table).VarsayilanAlisCariKod.Value);
  chkIsBolumAmbardaUretimYap.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsBolumAmbardaUretimYap.FieldType, TSysApplicationSettingsOther(Table).IsBolumAmbardaUretimYap.Value);
  chkIsUretimMuhasebeKaydiOlustursun.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsUretimMuhasebeKaydiOlustursun.FieldType, TSysApplicationSettingsOther(Table).IsUretimMuhasebeKaydiOlustursun.Value);
  chkIsStokSatimdaNegatifeDusebilir.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsStokSatimdaNegatifeDusebilir.FieldType, TSysApplicationSettingsOther(Table).IsStokSatimdaNegatifeDusebilir.Value);
  chkIsMalSatisSayilariniGoster.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsMalSatisSayilariniGoster.FieldType, TSysApplicationSettingsOther(Table).IsMalSatisSayilariniGoster.Value);
  chkIsPcbUretim.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsPcbUretim.FieldType, TSysApplicationSettingsOther(Table).IsPcbUretim.Value);
  chkIsProformaNoGoster.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsProformaNoGoster.FieldType, TSysApplicationSettingsOther(Table).IsProformaNoGoster.Value);
  chkIsSatisTakip.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsSatisTakip.FieldType, TSysApplicationSettingsOther(Table).IsSatisTakip.Value);
  chkIsHammaddeGiriseGoreSirala.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsHammaddeGiriseGoreSirala.FieldType, TSysApplicationSettingsOther(Table).IsHammaddeGiriseGoreSirala.Value);
  chkIsUretimEntegrasyonHammaddeKullanimHesabiIscilikle.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsUretimEntegrasyonHammaddeKullanimHesabiIscilikle.FieldType, TSysApplicationSettingsOther(Table).IsUretimEntegrasyonHammaddeKullanimHesabiIscilikle.Value);
  chkIsTahsilatListesiVirmanli.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsTahsilatListesiVirmanli.FieldType, TSysApplicationSettingsOther(Table).IsTahsilatListesiVirmanli.Value);
  chkIsOrtalamaVadeSifirsaSevkiyataIzinVerme.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsOrtalamaVadeSifirsaSevkiyataIzinVerme.FieldType, TSysApplicationSettingsOther(Table).IsOrtalamaVadeSifirsaSevkiyataIzinVerme.Value);
  chkIsSiparisteTeslimTarihiYazdir.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsSiparisteTeslimTarihiYazdir.FieldType, TSysApplicationSettingsOther(Table).IsSiparisteTeslimTarihiYazdir.Value);
  chkIsTeklifAyrintilariniGoster.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsTeklifAyrintilariniGoster.FieldType, TSysApplicationSettingsOther(Table).IsTeklifAyrintilariniGoster.Value);
  chkIsFaturaIrsaliyeNoSifirlaBaslasin.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsFaturaIrsaliyeNoSifirlaBaslasin.FieldType, TSysApplicationSettingsOther(Table).IsFaturaIrsaliyeNoSifirlaBaslasin.Value);
  chkIsExcelEkliIrsaliyeYazdirma.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsExcelEkliIrsaliyeYazdirma.FieldType, TSysApplicationSettingsOther(Table).IsExcelEkliIrsaliyeYazdirma.Value);
  chkIsAmbarTransferNumarasiOtomatikGelsin.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsAmbarTransferNumarasiOtomatikGelsin.FieldType, TSysApplicationSettingsOther(Table).IsAmbarTransferNumarasiOtomatikGelsin.Value);
  chkIsAmbarTransferOnayliCalissin.Checked := FormatedVariantVal(TSysApplicationSettingsOther(Table).IsAmbarTransferOnayliCalissin.FieldType, TSysApplicationSettingsOther(Table).IsAmbarTransferOnayliCalissin.Value);
end;

procedure TfrmSysApplicationSettingsOther.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysApplicationSettingsOther(Table).IsEdefterAktif.Value := chkIsEdefterAktif.Checked;
      TSysApplicationSettingsOther(Table).VarsayilanSatisCariKod.Value := edtVarsayilanSatisCariKod.Text;
      TSysApplicationSettingsOther(Table).VarsayilanAlisCariKod.Value := edtVarsayilanAlisCariKod.Text;
      TSysApplicationSettingsOther(Table).IsBolumAmbardaUretimYap.Value := chkIsBolumAmbardaUretimYap.Checked;
      TSysApplicationSettingsOther(Table).IsUretimMuhasebeKaydiOlustursun.Value := chkIsUretimMuhasebeKaydiOlustursun.Checked;
      TSysApplicationSettingsOther(Table).IsStokSatimdaNegatifeDusebilir.Value := chkIsStokSatimdaNegatifeDusebilir.Checked;
      TSysApplicationSettingsOther(Table).IsMalSatisSayilariniGoster.Value := chkIsMalSatisSayilariniGoster.Checked;
      TSysApplicationSettingsOther(Table).IsPcbUretim.Value := chkIsPcbUretim.Checked;
      TSysApplicationSettingsOther(Table).IsProformaNoGoster.Value := chkIsProformaNoGoster.Checked;
      TSysApplicationSettingsOther(Table).IsSatisTakip.Value := chkIsSatisTakip.Checked;
      TSysApplicationSettingsOther(Table).IsHammaddeGiriseGoreSirala.Value := chkIsHammaddeGiriseGoreSirala.Checked;
      TSysApplicationSettingsOther(Table).IsUretimEntegrasyonHammaddeKullanimHesabiIscilikle.Value := chkIsUretimEntegrasyonHammaddeKullanimHesabiIscilikle.Checked;
      TSysApplicationSettingsOther(Table).IsTahsilatListesiVirmanli.Value := chkIsTahsilatListesiVirmanli.Checked;
      TSysApplicationSettingsOther(Table).IsOrtalamaVadeSifirsaSevkiyataIzinVerme.Value := chkIsOrtalamaVadeSifirsaSevkiyataIzinVerme.Checked;
      TSysApplicationSettingsOther(Table).IsSiparisteTeslimTarihiYazdir.Value := chkIsSiparisteTeslimTarihiYazdir.Checked;
      TSysApplicationSettingsOther(Table).IsTeklifAyrintilariniGoster.Value := chkIsTeklifAyrintilariniGoster.Checked;
      TSysApplicationSettingsOther(Table).IsFaturaIrsaliyeNoSifirlaBaslasin.Value := chkIsFaturaIrsaliyeNoSifirlaBaslasin.Checked;
      TSysApplicationSettingsOther(Table).IsExcelEkliIrsaliyeYazdirma.Value := chkIsExcelEkliIrsaliyeYazdirma.Checked;
      TSysApplicationSettingsOther(Table).IsAmbarTransferNumarasiOtomatikGelsin.Value := chkIsAmbarTransferNumarasiOtomatikGelsin.Checked;
      TSysApplicationSettingsOther(Table).IsAmbarTransferOnayliCalissin.Value := chkIsAmbarTransferOnayliCalissin.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
