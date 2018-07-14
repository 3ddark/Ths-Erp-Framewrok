unit ufrmSysApplicationSettingsOthers;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysApplicationSettingsOthers = class(TfrmBaseDBGrid)
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSysApplicationSettingsOthers,
  Ths.Erp.Database.Table.SysApplicationSettingsOther;

{$R *.dfm}

{ TfrmSysApplicationSettingsOthers }

function TfrmSysApplicationSettingsOthers.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysApplicationSettingsOthers.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysApplicationSettingsOthers.Create(Application, Self, TSysApplicationSettingsOther.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysApplicationSettingsOthers.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysApplicationSettingsOthers.SetSelectedItem;
begin
  inherited;

  TSysApplicationSettingsOther(Table).IsEdefterAktif.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsEdefterAktif.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsEdefterAktif.FieldName).Value);
  TSysApplicationSettingsOther(Table).VarsayilanSatisCariKod.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).VarsayilanSatisCariKod.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).VarsayilanSatisCariKod.FieldName).Value);
  TSysApplicationSettingsOther(Table).VarsayilanAlisCariKod.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).VarsayilanAlisCariKod.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).VarsayilanAlisCariKod.FieldName).Value);
  TSysApplicationSettingsOther(Table).MailSenderAddress.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).MailSenderAddress.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).MailSenderAddress.FieldName).Value);
  TSysApplicationSettingsOther(Table).MailSenderUsername.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).MailSenderUsername.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).MailSenderUsername.FieldName).Value);
  TSysApplicationSettingsOther(Table).MailSenderPassword.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).MailSenderPassword.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).MailSenderPassword.FieldName).Value);
  TSysApplicationSettingsOther(Table).MailSenderPort.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).MailSenderPort.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).MailSenderPort.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsBolumAmbardaUretimYap.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsBolumAmbardaUretimYap.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsBolumAmbardaUretimYap.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsUretimMuhasebeKaydiOlustursun.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsUretimMuhasebeKaydiOlustursun.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsUretimMuhasebeKaydiOlustursun.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsStokSatimdaNegatifeDusebilir.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsStokSatimdaNegatifeDusebilir.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsStokSatimdaNegatifeDusebilir.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsMalSatisSayilariniGoster.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsMalSatisSayilariniGoster.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsMalSatisSayilariniGoster.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsPcbUretim.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsPcbUretim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsPcbUretim.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsProformaNoGoster.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsProformaNoGoster.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsProformaNoGoster.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsSatisTakip.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsSatisTakip.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsSatisTakip.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsHammaddeGiriseGoreSirala.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsHammaddeGiriseGoreSirala.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsHammaddeGiriseGoreSirala.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsUretimEntegrasyonHammaddeKullanimHesabiIscilikle.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsUretimEntegrasyonHammaddeKullanimHesabiIscilikle.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsUretimEntegrasyonHammaddeKullanimHesabiIscilikle.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsTahsilatListesiVirmanli.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsTahsilatListesiVirmanli.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsTahsilatListesiVirmanli.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsOrtalamaVadeSifirsaSevkiyataIzinVerme.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsOrtalamaVadeSifirsaSevkiyataIzinVerme.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsOrtalamaVadeSifirsaSevkiyataIzinVerme.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsSiparisteTeslimTarihiYazdir.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsSiparisteTeslimTarihiYazdir.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsSiparisteTeslimTarihiYazdir.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsTeklifAyrintilariniGoster.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsTeklifAyrintilariniGoster.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsTeklifAyrintilariniGoster.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsFaturaIrsaliyeNoSifirlaBaslasin.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsFaturaIrsaliyeNoSifirlaBaslasin.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsFaturaIrsaliyeNoSifirlaBaslasin.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsExcelEkliIrsaliyeYazdirma.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsExcelEkliIrsaliyeYazdirma.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsExcelEkliIrsaliyeYazdirma.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsAmbarTransferNumarasiOtomatikGelsin.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsAmbarTransferNumarasiOtomatikGelsin.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsAmbarTransferNumarasiOtomatikGelsin.FieldName).Value);
  TSysApplicationSettingsOther(Table).IsAmbarTransferOnayliCalissin.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsAmbarTransferOnayliCalissin.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettingsOther(Table).IsAmbarTransferOnayliCalissin.FieldName).Value);
end;

end.
