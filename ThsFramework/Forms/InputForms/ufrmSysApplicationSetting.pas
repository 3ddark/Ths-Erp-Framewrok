unit ufrmSysApplicationSetting;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Samples.Spin,
  Vcl.AppEvnts, Vcl.Menus,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmSysApplicationSetting = class(TfrmBaseInputDB)
    lblcompany_name: TLabel;
    lblphone1: TLabel;
    lblphone2: TLabel;
    lblphone3: TLabel;
    lblphone4: TLabel;
    lblphone5: TLabel;
    lblfax1: TLabel;
    lblfax2: TLabel;
    imglogo: TImage;
    edtcompany_name: TEdit;
    edtphone1: TEdit;
    edtphone2: TEdit;
    edtphone3: TEdit;
    edtphone4: TEdit;
    edtphone5: TEdit;
    edtfax1: TEdit;
    edtfax2: TEdit;
    tsDiger: TTabSheet;
    lblgrid_color_1: TLabel;
    edtgrid_color_1: TEdit;
    lblgrid_color_2: TLabel;
    edtgrid_color_2: TEdit;
    lblgrid_color_active: TLabel;
    edtgrid_color_active: TEdit;
    lblcrypt_key: TLabel;
    secrypt_key: TSpinEdit;
    lblform_color: TLabel;
    edtform_color: TEdit;
    lblperiod: TLabel;
    edtperiod: TEdit;
    lblapp_main_lang: TLabel;
    lblmail_host_name: TLabel;
    edtmail_host_name: TEdit;
    lblmail_host_user: TLabel;
    edtmail_host_user: TEdit;
    lblmail_host_pass: TLabel;
    edtmail_host_pass: TEdit;
    lblmail_host_smtp_port: TLabel;
    edtmail_host_smtp_port: TEdit;
    tsAdres: TTabSheet;
    lbltaxpayer_type_id: TLabel;
    chkis_use_quality_form_number: TCheckBox;
    lblis_use_quality_form_number: TLabel;
    edttaxpayer_type_id: TEdit;
    lbltax_administration: TLabel;
    edttax_administration: TEdit;
    lbltax_no: TLabel;
    edttax_no: TEdit;
    lblmersis_no: TLabel;
    edtmersis_no: TEdit;
    lblweb_site: TLabel;
    edtweb_site: TEdit;
    lblemail: TLabel;
    edtemail: TEdit;
    lblcountry_id: TLabel;
    lblcity_id: TLabel;
    edtcity_id: TEdit;
    lbltown: TLabel;
    edttown: TEdit;
    lbldistrict: TLabel;
    edtdistrict: TEdit;
    lblroad: TLabel;
    edtroad: TEdit;
    lblstreet: TLabel;
    edtstreet: TEdit;
    lblbuilding_name: TLabel;
    edtbuilding_name: TEdit;
    lbldoor_no: TLabel;
    edtdoor_no: TEdit;
    lblpost_code: TLabel;
    edtpost_code: TEdit;
    edtcountry_id: TEdit;
    edtapp_main_lang: TEdit;
    lbltrade_register_number: TLabel;
    edttrade_register_number: TEdit;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure imglogoDblClick(Sender: TObject);
    procedure edtform_colorDblClick(Sender: TObject);
    procedure edtgrid_color_1DblClick(Sender: TObject);
    procedure edtgrid_color_2DblClick(Sender: TObject);
    procedure edtgrid_color_activeDblClick(Sender: TObject);
    procedure edtform_colorExit(Sender: TObject);
    procedure edtgrid_color_1Exit(Sender: TObject);
    procedure edtgrid_color_2Exit(Sender: TObject);
    procedure edtgrid_color_activeExit(Sender: TObject);
  private
    procedure SetColor(color: TColor; editColor: TEdit);
    procedure DrawEmptyImage();
    procedure LoadImage(pFileName: string);
  public
  protected
    procedure HelperProcess(Sender: TObject); override;
    function ValidateInput(panel_groupbox_pagecontrol_tabsheet: TWinControl = nil): Boolean;
      override;
  published
    procedure FormPaint(Sender: TObject); override;
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
    Ths.Erp.Database.Singleton
  , Ths.Erp.Functions
  , Ths.Erp.Database.Table.SysLang
  , Ths.Erp.Database.Table.SysApplicationSettings
  , Ths.Erp.Database.Table.SysCountry
  , Ths.Erp.Database.Table.SysCity
  , Ths.Erp.Database.Table.SysTaxpayerType
  , ufrmHelperSysCity
  , ufrmHelperSysTaxpayerType
  , ufrmHelperSysLang
  ;

{$R *.dfm}

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
    Canvas.Rectangle(x1, y1, x2, y2);
  end;
end;

procedure TfrmSysApplicationSetting.edtform_colorDblClick(Sender: TObject);
begin
  if (FormMode = ifmUpdate) or (FormMode = ifmNewRecord) then
    SetColor(TFunctions.GetDialogColor(StrToIntDef(edtform_color.Text, 0)), edtform_color);
end;

procedure TfrmSysApplicationSetting.edtform_colorExit(Sender: TObject);
begin
  inherited;
  SetColor(StrToIntDef(edtform_color.Text, 0), edtform_color);
  edtform_color.Refresh;
end;

procedure TfrmSysApplicationSetting.edtgrid_color_1DblClick(Sender: TObject);
begin
  if (FormMode = ifmUpdate) or (FormMode = ifmNewRecord) then
    SetColor(TFunctions.GetDialogColor(StrToIntDef(edtgrid_color_1.Text, 0)), edtgrid_color_1);
end;

procedure TfrmSysApplicationSetting.edtgrid_color_1Exit(Sender: TObject);
begin
  inherited;
  SetColor(StrToIntDef(edtgrid_color_1.Text, 0), edtgrid_color_1);
  edtgrid_color_1.Refresh;
end;

procedure TfrmSysApplicationSetting.edtgrid_color_2DblClick(Sender: TObject);
begin
  if (FormMode = ifmUpdate) or (FormMode = ifmNewRecord) then
    SetColor(TFunctions.GetDialogColor(StrToIntDef(edtgrid_color_2.Text, 0)), edtgrid_color_2);
end;

procedure TfrmSysApplicationSetting.edtgrid_color_2Exit(Sender: TObject);
begin
  inherited;
  SetColor(StrToIntDef(edtgrid_color_2.Text, 0), edtgrid_color_2);
  edtgrid_color_2.Refresh;
end;

procedure TfrmSysApplicationSetting.edtgrid_color_activeDblClick(Sender: TObject);
begin
  if (FormMode = ifmUpdate) or (FormMode = ifmNewRecord) then
    SetColor(TFunctions.GetDialogColor(StrToIntDef(edtgrid_color_active.Text, 0)), edtgrid_color_active);
end;

procedure TfrmSysApplicationSetting.edtgrid_color_activeExit(Sender: TObject);
begin
  inherited;
  SetColor(StrToIntDef(edtgrid_color_active.Text, 0), edtgrid_color_active);
  edtgrid_color_active.Repaint;
end;

procedure TfrmSysApplicationSetting.FormPaint(Sender: TObject);
begin
  inherited;
  SetColor(clRed, edtform_color);
end;

procedure TfrmSysApplicationSetting.FormShow(Sender: TObject);
begin
  inherited;

  edtapp_main_lang.OnHelperProcess := HelperProcess;
  edttaxpayer_type_id.OnHelperProcess := HelperProcess;
  edtcity_id.OnHelperProcess := HelperProcess;

  edtcompany_name.CharCase := ecNormal;
  edtweb_site.CharCase := ecNormal;
  edtemail.CharCase := ecNormal;
  edtmail_host_name.CharCase := ecNormal;
  edtmail_host_user.CharCase := ecNormal;
  edtmail_host_pass.CharCase := ecNormal;
  edtapp_main_lang.CharCase := ecNormal;

  edtcountry_id.ReadOnly := True;

{$IFDEF DUMMY_VALUE}
  if FormMode = ifmNewRecord then
  begin
    edtcompany_name.Text := 'Thundersoft A.Þ.';
    edtphone1.Text := '0126 123 45 60';
    edtphone2.Text := '0126 123 45 61';
    edtphone3.Text := '0126 123 45 62';
    edtphone4.Text := '0126 123 45 63';
    edtphone5.Text := '0126 123 45 64';
    edtfax1.Text := '0126 123 45 65';
    edtfax2.Text := '0126 123 45 66';

    secrypt_key.Value := 12345;
    edtperiod.Text := '2019';
    edtapp_main_lang.Text := 'TÜRKÇE TR';
    chkis_use_quality_form_number.Checked := True;

    edttax_administration.Text := 'PENDÝK';
    edttax_no.Text := '0123456789';
    edtmersis_no.Text := '0987654321';
    edttrade_register_number.Text := '98235';
    edtweb_site.Text := 'www.website.com';
    edtemail.Text := 'mail@website.com';
    edttown.Text := 'PENDÝK';
    edtdistrict.Text := 'GENÝÞ';
    edtroad.Text := 'UZUN';
    edtstreet.Text := 'KISA';
    edtbuilding_name.Text := 'DAR';
    edtdoor_no.Text := '14/2';
    edtpost_code.Text := '34000';
  end;
{$ENDIF}
end;

procedure TfrmSysApplicationSetting.HelperProcess(Sender: TObject);
var
  vHelperSysCity: TfrmHelperSysCity;
  vHelperSysTaxpayerType: TfrmHelperSysTaxpayerType;
  vHelperSysLang: TfrmHelperSysLang;
begin
  if Sender.ClassType = TEdit then
  begin
    if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
    begin
      if TEdit(Sender).Name = edtcity_id.Name then
      begin
        vHelperSysCity := TfrmHelperSysCity.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperSysCity.ShowModal;

          if Assigned(TSysApplicationSettings(Table).CityID.FK.FKTable) then
            TSysApplicationSettings(Table).CityID.FK.FKTable.Free;
          TSysApplicationSettings(Table).CityID.FK.FKTable := vHelperSysCity.Table.Clone;
          TSysApplicationSettings(Table).CityID.Value := vHelperSysCity.Table.Id.Value;
          edtcountry_id.Text := TSysCity(TSysApplicationSettings(Table).CityID.FK.FKTable).CountryID.FK.FKCol.Value;
          TSysApplicationSettings(Table).CountryID.Value := TSysCity(TSysApplicationSettings(Table).CityID.FK.FKTable).CountryID.FK.FKTable.Id.Value;
        finally
          vHelperSysCity.Free;
        end;
      end
      else if TEdit(Sender).Name = edttaxpayer_type_id.Name then
      begin
        vHelperSysTaxpayerType := TfrmHelperSysTaxpayerType.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperSysTaxpayerType.ShowModal;

          if Assigned(TSysApplicationSettings(Table).TaxPayerTypeID.FK.FKTable) then
            TSysApplicationSettings(Table).TaxPayerTypeID.FK.FKTable.Free;
          TSysApplicationSettings(Table).TaxPayerTypeID.FK.FKTable := vHelperSysTaxpayerType.Table.Clone;
          TSysApplicationSettings(Table).TaxPayerTypeID.Value := vHelperSysTaxpayerType.Table.Id.Value;
        finally
          vHelperSysTaxpayerType.Free;
        end;
      end
      else if TEdit(Sender).Name = edtapp_main_lang.Name then
      begin
        vHelperSysLang := TfrmHelperSysLang.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperSysLang.ShowModal;

          if Assigned(TSysApplicationSettings(Table).AppMainLang.FK.FKTable) then
            TSysApplicationSettings(Table).AppMainLang.FK.FKTable.Free;
          TSysApplicationSettings(Table).AppMainLang.FK.FKTable := vHelperSysLang.Table.Clone;
        finally
          vHelperSysLang.Free;
        end;
      end
    end;
  end;
end;

procedure TfrmSysApplicationSetting.imglogoDblClick(Sender: TObject);
var
  vFileName: string;
begin
  if (FormMode = ifmUpdate) or (FormMode = ifmNewRecord) then
  begin
    vFileName := TFunctions.GetDiaglogOpen('Bitmap File|*.bmp');
    if (vFileName <> '') and FileExists(vFileName) then
      LoadImage(vFileName);
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
    raise Exception.Create('Logo geniþliði en fazla 640px olabilir');
  end;
  if imgLogo.Picture.Bitmap.Height > 480 then
  begin
    imgLogo.Picture.Assign(nil);
    DrawEmptyImage;
    raise Exception.Create('Logo yüksekliði en fazla 480px olabilir');
  end;

  imgLogo.Width := imgLogo.Picture.Bitmap.Width;
  imgLogo.Height := imgLogo.Picture.Bitmap.Height;
  imgLogo.Left := vRightOrigin-imgLogo.Width;
end;

procedure TfrmSysApplicationSetting.RefreshData();
begin
  edtcompany_name.Text := TSysApplicationSettings(Table).CompanyName.Value;
  edtphone1.Text := TSysApplicationSettings(Table).Phone1.Value;
  edtphone2.Text := TSysApplicationSettings(Table).Phone2.Value;
  edtphone3.Text := TSysApplicationSettings(Table).Phone3.Value;
  edtphone4.Text := TSysApplicationSettings(Table).Phone4.Value;
  edtphone5.Text := TSysApplicationSettings(Table).Phone5.Value;
  edtfax1.Text := TSysApplicationSettings(Table).Fax1.Value;
  edtfax2.Text := TSysApplicationSettings(Table).Fax2.Value;

  if TSysApplicationSettings(Table).Logo.Value <> null then
  begin
    TFunctions.ByteArrayToFile(TSysApplicationSettings(Table).Logo.Value, 'logo_dmp.bmp');
    try
      LoadImage('logo_dmp.bmp');
    finally
      DeleteFile('logo_dmp.bmp');
    end;
  end
  else
    DrawEmptyImage();

  edtgrid_color_1.Text := TSysApplicationSettings(Table).GridColor1.Value;
  edtgrid_color_2.Text := TSysApplicationSettings(Table).GridColor2.Value;
  edtgrid_color_active.Text := TSysApplicationSettings(Table).GridColorActive.Value;
  secrypt_key.Value := TSysApplicationSettings(Table).CryptKey.Value;
  edtform_color.Text := TSysApplicationSettings(Table).FormColor.Value;
  edtperiod.Text := TSysApplicationSettings(Table).Period.Value;
  edtapp_main_lang.Text := TSysApplicationSettings(Table).AppMainLang.FK.FKCol.Value;
  edtmail_host_name.Text := TSysApplicationSettings(Table).MailHostName.Value;
  edtmail_host_user.Text := TSysApplicationSettings(Table).MailHostUser.Value;
  edtmail_host_pass.Text := TSysApplicationSettings(Table).MailHostPass.Value;
  edtmail_host_smtp_port.Text := TSysApplicationSettings(Table).MailHostSmtpPort.Value;
  chkis_use_quality_form_number.Checked := TSysApplicationSettings(Table).IsUseQualityFormNumber.Value;

  edttaxpayer_type_id.Text := TSysApplicationSettings(Table).TaxPayerTypeID.FK.FKCol.Value;
  edttax_administration.Text := TSysApplicationSettings(Table).TaxAdministration.Value;
  edttax_no.Text := TSysApplicationSettings(Table).TaxNo.Value;
  edtmersis_no.Text := TSysApplicationSettings(Table).MersisNo.Value;
  edttrade_register_number.Text := TSysApplicationSettings(Table).TradeRegisterNumber.Value;
  edtweb_site.Text := TSysApplicationSettings(Table).WebSite.Value;
  edtemail.Text := TSysApplicationSettings(Table).EMail.Value;
  edtcountry_id.Text := TSysApplicationSettings(Table).CountryID.FK.FKCol.Value;
  edtcity_id.Text := TSysApplicationSettings(Table).CityID.FK.FKCol.Value;
  edttown.Text := TSysApplicationSettings(Table).Town.Value;
  edtdistrict.Text := TSysApplicationSettings(Table).District.Value;
  edtroad.Text := TSysApplicationSettings(Table).Road.Value;
  edtstreet.Text := TSysApplicationSettings(Table).Street.Value;
  edtbuilding_name.Text := TSysApplicationSettings(Table).BuildingName.Value;
  edtdoor_no.Text := TSysApplicationSettings(Table).DoorNo.Value;
  edtpost_code.Text := TSysApplicationSettings(Table).PostCode.Value;

  SetColor(StrToIntDef(edtform_color.Text, 0), edtform_color);
  SetColor(StrToIntDef(edtgrid_color_1.Text, 0), edtgrid_color_1);
  SetColor(StrToIntDef(edtgrid_color_2.Text, 0), edtgrid_color_2);
  SetColor(StrToIntDef(edtgrid_color_active.Text, 0), edtgrid_color_active);
end;

procedure TfrmSysApplicationSetting.SetColor(color: TColor; editColor: TEdit);
begin
  editColor.Text := IntToStr(color);
  editColor.Color := color;
  editColor.thsColorActive := color;
  editColor.thsColorRequiredInput := color;
  editColor.Repaint;
end;

function TfrmSysApplicationSetting.ValidateInput(
  panel_groupbox_pagecontrol_tabsheet: TWinControl): Boolean;
begin
  Result := ValidateInput();

//  if TSysApplicationSettings(Table).CryptKey.Value <> secrypt_key.Value then
//    Application.MessageBox()
end;

procedure TfrmSysApplicationSetting.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysApplicationSettings(Table).CompanyName.Value := edtcompany_name.Text;
      TSysApplicationSettings(Table).Phone1.Value := edtphone1.Text;
      TSysApplicationSettings(Table).Phone2.Value := edtphone2.Text;
      TSysApplicationSettings(Table).Phone3.Value := edtphone3.Text;
      TSysApplicationSettings(Table).Phone4.Value := edtphone4.Text;
      TSysApplicationSettings(Table).Phone5.Value := edtphone5.Text;
      TSysApplicationSettings(Table).Fax1.Value := edtfax1.Text;
      TSysApplicationSettings(Table).Fax2.Value := edtfax2.Text;
      TSysApplicationSettings(Table).FLogoVal := imgLogo.Picture.Bitmap;

      TSysApplicationSettings(Table).GridColor1.Value := edtgrid_color_1.Text;
      TSysApplicationSettings(Table).GridColor2.Value := edtgrid_color_2.Text;
      TSysApplicationSettings(Table).GridColorActive.Value := edtgrid_color_active.Text;
      TSysApplicationSettings(Table).CryptKey.Value := secrypt_key.Value;
      TSysApplicationSettings(Table).FormColor.Value := edtform_color.Text;
      TSysApplicationSettings(Table).Period.Value := edtperiod.Text;
      TSysApplicationSettings(Table).AppMainLang.Value := edtapp_main_lang.Text;
      TSysApplicationSettings(Table).MailHostName.Value := edtmail_host_name.Text;
      TSysApplicationSettings(Table).MailHostUser.Value := edtmail_host_user.Text;
      TSysApplicationSettings(Table).MailHostPass.Value := edtmail_host_pass.Text;
      TSysApplicationSettings(Table).MailHostSmtpPort.Value := edtmail_host_smtp_port.Text;
      TSysApplicationSettings(Table).IsUseQualityFormNumber.Value := chkis_use_quality_form_number.Checked;

      TSysApplicationSettings(Table).TaxPayerTypeID.Value := TSysApplicationSettings(Table).TaxPayerTypeID.Value;
      TSysApplicationSettings(Table).TaxAdministration.Value := edttax_administration.Text;
      TSysApplicationSettings(Table).TaxNo.Value := edttax_no.Text;
      TSysApplicationSettings(Table).MersisNo.Value := edtmersis_no.Text;
      TSysApplicationSettings(Table).TradeRegisterNumber.Value := edttrade_register_number.Text;

      TSysApplicationSettings(Table).WebSite.Value := edtweb_site.Text;
      TSysApplicationSettings(Table).EMail.Value := edtemail.Text;
      TSysApplicationSettings(Table).CountryID.Value := TSysApplicationSettings(Table).CountryID.Value;
      TSysApplicationSettings(Table).CityID.Value := TSysApplicationSettings(Table).CityID.Value;
      TSysApplicationSettings(Table).Town.Value := edttown.Text;
      TSysApplicationSettings(Table).District.Value := edtdistrict.Text;
      TSysApplicationSettings(Table).Road.Value := edtroad.Text;
      TSysApplicationSettings(Table).Street.Value := edtstreet.Text;
      TSysApplicationSettings(Table).BuildingName.Value := edtbuilding_name.Text;
      TSysApplicationSettings(Table).DoorNo.Value := edtdoor_no.Text;
      TSysApplicationSettings(Table).PostCode.Value := edtpost_code.Text;

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
