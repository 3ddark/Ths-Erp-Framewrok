unit ufrmSysApplicationSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin, Vcl.Menus,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.Ulke,
  Ths.Erp.Database.Table.Sehir;

type
  TfrmSysApplicationSetting = class(TfrmBaseInputDB)
    lblUnvan: TLabel;
    lblTel1: TLabel;
    lblTel2: TLabel;
    lblTel3: TLabel;
    lblTel4: TLabel;
    lblTel5: TLabel;
    lblFax1: TLabel;
    lblFax2: TLabel;
    lblMersisNo: TLabel;
    lblWebSitesi: TLabel;
    lblEPostaAdresi: TLabel;
    lblVergiDairesi: TLabel;
    lblVergiNo: TLabel;
    lblFormRengi: TLabel;
    lblDonem: TLabel;
    lblMukellefTipi: TLabel;
    imgLogo: TImage;
    lblKapiNo: TLabel;
    lblBina: TLabel;
    lblPostaKodu: TLabel;
    lblSokak: TLabel;
    lblCadde: TLabel;
    lblMahalle: TLabel;
    lblIlce: TLabel;
    lblSehir: TLabel;
    lblUlke: TLabel;
    edtUnvan: TthsEdit;
    edtTel1: TthsEdit;
    edtTel2: TthsEdit;
    edtTel3: TthsEdit;
    edtTel4: TthsEdit;
    edtTel5: TthsEdit;
    edtFax1: TthsEdit;
    edtFax2: TthsEdit;
    edtMersisNo: TthsEdit;
    edtVergiDairesi: TthsEdit;
    edtVergiNo: TthsEdit;
    cbbMukellefTipi: TthsCombobox;
    edtFormRengi: TthsEdit;
    edtDonem: TthsEdit;
    edtWebSitesi: TthsEdit;
    edtEPostaAdresi: TthsEdit;
    cbbUlke: TthsCombobox;
    cbbSehir: TthsCombobox;
    edtIlce: TthsEdit;
    edtMahalle: TthsEdit;
    edtCadde: TthsEdit;
    edtSokak: TthsEdit;
    lblSystemLanguage: TLabel;
    cbbSystemLanguage: TthsCombobox;
    lblMailSunucuAdres: TLabel;
    lblMailSunucuKullanici: TLabel;
    lblMailSunucuSifre: TLabel;
    lblMailSunucuPort: TLabel;
    edtBina: TthsEdit;
    edtKapiNo: TthsEdit;
    edtPostaKodu: TthsEdit;
    edtMailSunucuAdres: TthsEdit;
    edtMailSunucuKullanici: TthsEdit;
    edtMailSunucuSifre: TthsEdit;
    edtMailSunucuPort: TthsEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure imgLogoDblClick(Sender: TObject);
    procedure edtFormRengiDblClick(Sender: TObject);
    procedure cbbUlkeChange(Sender: TObject);
  private
    vpUlke: TUlke;
    vpSehir: TSehir;
    procedure SetColor(color: TColor; editColor: TthsEdit);
    procedure DrawEmptyImage();
    procedure LoadImage(pFileName: string);
  public
  protected
  published
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.SpecialFunctions,
  Ths.Erp.Database.Table.SysLang,
  Ths.Erp.Database.Table.SysApplicationSettings;

{$R *.dfm}

procedure TfrmSysApplicationSetting.cbbUlkeChange(Sender: TObject);
var
  n1: Integer;
begin
  cbbSehir.Clear;
  if Assigned(cbbUlke.Items.Objects[cbbUlke.ItemIndex]) then
  begin
    vpSehir.SelectToList(' and ' + vpSehir.UlkeAdi.FieldName + '=' +
      QuotedStr(GetVarToFormatedValue(TUlke(cbbUlke.Items.Objects[cbbUlke.ItemIndex]).UlkeAdi.FieldType,
                                      TUlke(cbbUlke.Items.Objects[cbbUlke.ItemIndex]).UlkeAdi.Value)), False, False);

    for n1 := 0 to vpSehir.List.Count-1 do
      cbbSehir.Items.AddObject(TSehir(vpSehir.List[n1]).SehirAdi.Value, TSehir(vpSehir.List[n1]));
  end;
end;

procedure TfrmSysApplicationSetting.DrawEmptyImage;
var
  vRightOrigin, x1, x2, y1, y2: Integer;
begin
  with imgLogo do
  begin
    vRightOrigin := Left + Width;
    Width := 320;
    Height := 240;
    Left := vRightOrigin-Width;
        
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Width := 1;

    Canvas.Pen.Color := clOlive;
    Canvas.Brush.Color := clOlive;
    x1 := 0;  x2 := Width;  y1 := 0;  y2 := Height;
    Canvas.Rectangle( x1, y1, x2, y2 );
  end;
end;

procedure TfrmSysApplicationSetting.edtFormRengiDblClick(Sender: TObject);
begin
  if (FormMode = ifmUpdate) or (FormMode = ifmNewRecord) then
  begin
    SetColor(TSpecialFunctions.GetDialogColor, edtFormRengi);
  end;
end;

procedure TfrmSysApplicationSetting.FormCreate(Sender: TObject);
var
  n1: Integer;
  vLang: TSysLang;
begin
  TSysApplicationSettings(Table).Unvan.SetControlProperty(Table.TableName, edtUnvan);
  TSysApplicationSettings(Table).Tel1.SetControlProperty(Table.TableName, edtTel1);
  TSysApplicationSettings(Table).Tel2.SetControlProperty(Table.TableName, edtTel2);
  TSysApplicationSettings(Table).Tel3.SetControlProperty(Table.TableName, edtTel3);
  TSysApplicationSettings(Table).Tel4.SetControlProperty(Table.TableName, edtTel4);
  TSysApplicationSettings(Table).Tel5.SetControlProperty(Table.TableName, edtTel5);
  TSysApplicationSettings(Table).Fax1.SetControlProperty(Table.TableName, edtFax1);
  TSysApplicationSettings(Table).Fax2.SetControlProperty(Table.TableName, edtFax2);
  TSysApplicationSettings(Table).MersisNo.SetControlProperty(Table.TableName, edtMersisNo);
  TSysApplicationSettings(Table).WebSitesi.SetControlProperty(Table.TableName, edtWebSitesi);
  TSysApplicationSettings(Table).EPostaAdresi.SetControlProperty(Table.TableName, edtEPostaAdresi);
  TSysApplicationSettings(Table).VergiDairesi.SetControlProperty(Table.TableName, edtVergiDairesi);
  TSysApplicationSettings(Table).VergiNo.SetControlProperty(Table.TableName, edtVergiNo);
  TSysApplicationSettings(Table).FormRengi.SetControlProperty(Table.TableName, edtFormRengi);
  TSysApplicationSettings(Table).Donem.SetControlProperty(Table.TableName, edtDonem);
  TSysApplicationSettings(Table).MukellefTipi.SetControlProperty(Table.TableName, cbbMukellefTipi);
  TSysApplicationSettings(Table).UlkeID.SetControlProperty(Table.TableName, cbbUlke);
  TSysApplicationSettings(Table).SehirID.SetControlProperty(Table.TableName, cbbSehir);
  TSysApplicationSettings(Table).Ilce.SetControlProperty(Table.TableName, edtIlce);
  TSysApplicationSettings(Table).Mahalle.SetControlProperty(Table.TableName, edtMahalle);
  TSysApplicationSettings(Table).Cadde.SetControlProperty(Table.TableName, edtCadde);
  TSysApplicationSettings(Table).Sokak.SetControlProperty(Table.TableName, edtSokak);
  TSysApplicationSettings(Table).PostaKodu.SetControlProperty(Table.TableName, edtPostaKodu);
  TSysApplicationSettings(Table).Bina.SetControlProperty(Table.TableName, edtBina);
  TSysApplicationSettings(Table).KapiNo.SetControlProperty(Table.TableName, edtKapiNo);
  TSysApplicationSettings(Table).MailSunucuAdres.SetControlProperty(Table.TableName, edtMailSunucuAdres);
  TSysApplicationSettings(Table).MailSunucuKullanici.SetControlProperty(Table.TableName, edtMailSunucuKullanici);
  TSysApplicationSettings(Table).MailSunucuSifre.SetControlProperty(Table.TableName, edtMailSunucuSifre);
  TSysApplicationSettings(Table).MailSunucuPort.SetControlProperty(Table.TableName, edtMailSunucuPort);

  inherited;

  edtUnvan.CharCase := ecNormal;
  edtWebSitesi.CharCase := ecNormal;
  edtEPostaAdresi.CharCase := ecNormal;
  cbbMukellefTipi.CharCase := ecNormal;
  cbbUlke.CharCase := ecNormal;
  cbbSehir.CharCase := ecNormal;
  cbbSystemLanguage.CharCase := ecNormal;
  edtMailSunucuAdres.CharCase := ecNormal;
  edtMailSunucuKullanici.CharCase := ecNormal;
  edtMailSunucuSifre.CharCase := ecNormal;
  edtMailSunucuPort.CharCase := ecNormal;

  vpUlke := TUlke.Create(Table.Database);
  vpSehir := TSehir.Create(Table.Database);

  vpUlke.SelectToList('', False, False);
  cbbUlke.Clear;
  for n1 := 0 to vpUlke.List.Count-1 do
    cbbUlke.Items.AddObject(TUlke(vpUlke.List[n1]).UlkeKodu.Value + ' ' + TUlke(vpUlke.List[n1]).UlkeAdi.Value, TUlke(vpUlke.List[n1]));

  vLang := TSysLang.Create(Table.Database);
  try
    vLang.SelectToList('', False, False);
    cbbSystemLanguage.Clear;
    for n1 := 0 to vLang.List.Count-1 do
      cbbSystemLanguage.Items.Add( TSysLang(vLang.List[n1]).Language.Value );
  finally
    vLang.Free;
  end;
end;

procedure TfrmSysApplicationSetting.FormDestroy(Sender: TObject);
begin
  vpUlke.Free;
  vpSehir.Free;
  inherited;
end;

procedure TfrmSysApplicationSetting.imgLogoDblClick(Sender: TObject);
var
  vFileName: string;
begin
  if (FormMode = ifmUpdate) or (FormMode = ifmNewRecord) then
  begin
    vFileName := TSpecialFunctions.GetDiaglogOpen('Bitmap File|*.bmp');
    if (vFileName <> '') and FileExists(vFileName) then
    begin
      LoadImage(vFileName);
    end;
  end;
end;

procedure TfrmSysApplicationSetting.LoadImage(pFileName: string);
var
  vRightOrigin: Integer;
begin
  vRightOrigin := imgLogo.Left + imgLogo.Width;
  imgLogo.Picture.LoadFromFile(pFileName);

  if imgLogo.Picture.Bitmap.Width > 640 then
  begin
    imgLogo.Picture.Assign(nil);
    DrawEmptyImage;
    raise Exception.Create('Logo genişliği en fazla 640px olabilir');          
  end;
  if imgLogo.Picture.Bitmap.Height > 480 then
  begin
    imgLogo.Picture.Assign(nil);
    DrawEmptyImage;
    raise Exception.Create('Logo yüksekliği en fazla 480px olabilir');
  end;        

  imgLogo.Width := imgLogo.Picture.Bitmap.Width;
  imgLogo.Height := imgLogo.Picture.Bitmap.Height;
  imgLogo.Left := vRightOrigin-imgLogo.Width;
end;

procedure TfrmSysApplicationSetting.RefreshData();
var
  n1: Integer;
begin
  if TSysApplicationSettings(Table).Logo.Value <> null then
  begin
    TSpecialFunctions.ByteArrayToFile(TSysApplicationSettings(Table).Logo.Value, 'logo_dmp.bmp');
    try
      LoadImage('logo_dmp.bmp');
    finally
      DeleteFile('logo_dmp.bmp');
    end;
  end
  else
  begin
    DrawEmptyImage();
  end;

  edtUnvan.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).Unvan.FieldType, TSysApplicationSettings(Table).Unvan.Value);
  edtTel1.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).Tel1.FieldType, TSysApplicationSettings(Table).Tel1.Value);
  edtTel2.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).Tel2.FieldType, TSysApplicationSettings(Table).Tel2.Value);
  edtTel3.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).Tel3.FieldType, TSysApplicationSettings(Table).Tel3.Value);
  edtTel4.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).Tel4.FieldType, TSysApplicationSettings(Table).Tel4.Value);
  edtTel5.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).Tel5.FieldType, TSysApplicationSettings(Table).Tel5.Value);
  edtFax1.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).Fax1.FieldType, TSysApplicationSettings(Table).Fax1.Value);
  edtFax2.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).Fax2.FieldType, TSysApplicationSettings(Table).Fax2.Value);
  edtMersisNo.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).MersisNo.FieldType, TSysApplicationSettings(Table).MersisNo.Value);
  edtVergiDairesi.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).VergiDairesi.FieldType, TSysApplicationSettings(Table).VergiDairesi.Value);
  edtVergiNo.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).VergiNo.FieldType, TSysApplicationSettings(Table).VergiNo.Value);
  cbbMukellefTipi.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).MukellefTipi.FieldType, TSysApplicationSettings(Table).MukellefTipi.Value);

  edtFormRengi.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).FormRengi.FieldType, TSysApplicationSettings(Table).FormRengi.Value);
  SetColor(StrToIntDef(edtFormRengi.Text, 0), edtFormRengi);

  edtDonem.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).Donem.FieldType, TSysApplicationSettings(Table).Donem.Value);
  cbbSystemLanguage.ItemIndex := cbbSystemLanguage.Items.IndexOf( GetVarToFormatedValue(TSysApplicationSettings(Table).SistemDili.FieldType, TSysApplicationSettings(Table).SistemDili.Value) );
  edtWebSitesi.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).WebSitesi.FieldType, TSysApplicationSettings(Table).WebSitesi.Value);
  edtEPostaAdresi.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).EPostaAdresi.FieldType, TSysApplicationSettings(Table).EPostaAdresi.Value);

  for n1 := 0 to cbbUlke.Items.Count-1 do
  begin
    if Assigned(cbbUlke.Items.Objects[n1]) then
    begin
      if TUlke(cbbUlke.Items.Objects[n1]).Id.Value = GetVarToFormatedValue(TSysApplicationSettings(Table).UlkeID.FieldType, TSysApplicationSettings(Table).UlkeID.Value) then
      begin
        cbbUlke.ItemIndex := n1;
        cbbUlkeChange(cbbUlke);
        Break;
      end;
    end;
  end;

  for n1 := 0 to cbbSehir.Items.Count-1 do
  begin
    if Assigned(cbbSehir.Items.Objects[n1]) then
    begin
      if TSehir(cbbSehir.Items.Objects[n1]).Id.Value = GetVarToFormatedValue(TSysApplicationSettings(Table).SehirID.FieldType, TSysApplicationSettings(Table).SehirID.Value) then
      begin
        cbbSehir.ItemIndex := n1;
        Break;
      end;
    end;
  end;

  edtIlce.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).Ilce.FieldType, TSysApplicationSettings(Table).Ilce.Value);
  edtMahalle.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).Mahalle.FieldType, TSysApplicationSettings(Table).Mahalle.Value);
  edtCadde.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).Cadde.FieldType, TSysApplicationSettings(Table).Cadde.Value);
  edtSokak.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).Sokak.FieldType, TSysApplicationSettings(Table).Sokak.Value);
  edtPostaKodu.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).PostaKodu.FieldType, TSysApplicationSettings(Table).PostaKodu.Value);
  edtBina.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).Bina.FieldType, TSysApplicationSettings(Table).Bina.Value);
  edtKapiNo.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).KapiNo.FieldType, TSysApplicationSettings(Table).KapiNo.Value);
  edtMailSunucuAdres.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).MailSunucuAdres.FieldType, TSysApplicationSettings(Table).MailSunucuAdres.Value);
  edtMailSunucuKullanici.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).MailSunucuKullanici.FieldType, TSysApplicationSettings(Table).MailSunucuKullanici.Value);
  edtMailSunucuSifre.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).MailSunucuSifre.FieldType, TSysApplicationSettings(Table).MailSunucuSifre.Value);
  edtMailSunucuPort.Text := GetVarToFormatedValue(TSysApplicationSettings(Table).MailSunucuPort.FieldType, TSysApplicationSettings(Table).MailSunucuPort.Value);
end;

procedure TfrmSysApplicationSetting.SetColor(color: TColor;
  editColor: TthsEdit);
begin
  editColor.Text := IntToStr(color);
  editColor.Color := color;
  editColor.thsColorActive := color;
  editColor.thsColorRequiredData := color;
  editColor.Repaint;
end;

procedure TfrmSysApplicationSetting.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysApplicationSettings(Table).FLogoVal := imgLogo.Picture.Bitmap;

      TSysApplicationSettings(Table).Unvan.Value := edtUnvan.Text;
      TSysApplicationSettings(Table).Tel1.Value := edtTel1.Text;
      TSysApplicationSettings(Table).Tel2.Value := edtTel2.Text;
      TSysApplicationSettings(Table).Tel3.Value := edtTel3.Text;
      TSysApplicationSettings(Table).Tel4.Value := edtTel4.Text;
      TSysApplicationSettings(Table).Tel5.Value := edtTel5.Text;
      TSysApplicationSettings(Table).Fax1.Value := edtFax1.Text;
      TSysApplicationSettings(Table).Fax2.Value := edtFax2.Text;
      TSysApplicationSettings(Table).MersisNo.Value := edtMersisNo.Text;
      TSysApplicationSettings(Table).WebSitesi.Value := edtWebSitesi.Text;
      TSysApplicationSettings(Table).EPostaAdresi.Value := edtEPostaAdresi.Text;
      TSysApplicationSettings(Table).VergiDairesi.Value := edtVergiDairesi.Text;
      TSysApplicationSettings(Table).VergiNo.Value := edtVergiNo.Text;
      TSysApplicationSettings(Table).FormRengi.Value := edtFormRengi.Text;
      TSysApplicationSettings(Table).Donem.Value := edtDonem.Text;
      TSysApplicationSettings(Table).MukellefTipi.Value := cbbMukellefTipi.Text;

      if Assigned(cbbUlke.Items.Objects[cbbUlke.ItemIndex]) then
        TSysApplicationSettings(Table).UlkeID.Value := TUlke(cbbUlke.Items.Objects[cbbUlke.ItemIndex]).Id.Value;

      if Assigned(cbbSehir.Items.Objects[cbbSehir.ItemIndex]) then
        TSysApplicationSettings(Table).SehirID.Value := TSehir(cbbSehir.Items.Objects[cbbSehir.ItemIndex]).Id.Value;

      TSysApplicationSettings(Table).Ilce.Value := edtIlce.Text;
      TSysApplicationSettings(Table).Mahalle.Value := edtMahalle.Text;
      TSysApplicationSettings(Table).Cadde.Value := edtCadde.Text;
      TSysApplicationSettings(Table).Sokak.Value := edtSokak.Text;
      TSysApplicationSettings(Table).PostaKodu.Value := edtPostaKodu.Text;
      TSysApplicationSettings(Table).Bina.Value := edtBina.Text;
      TSysApplicationSettings(Table).KapiNo.Value := edtKapiNo.Text;
      TSysApplicationSettings(Table).MailSunucuAdres.Value := edtMailSunucuAdres.Text;
      TSysApplicationSettings(Table).MailSunucuKullanici.Value := edtMailSunucuKullanici.Text;
      TSysApplicationSettings(Table).MailSunucuSifre.Value := edtMailSunucuSifre.Text;
      TSysApplicationSettings(Table).MailSunucuPort.Value := edtMailSunucuPort.Text;

      inherited;
    end;
  end
  else
  begin
    inherited;
    btnDelete.Visible := False;
  end;
end;

end.
