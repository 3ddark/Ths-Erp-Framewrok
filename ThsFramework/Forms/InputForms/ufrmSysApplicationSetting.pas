unit ufrmSysApplicationSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Samples.Spin,
  Vcl.AppEvnts, Vcl.Menus,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.Ulke,
  Ths.Erp.Database.Table.Sehir;

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
    cbbapp_main_lang: TComboBox;
    lblmail_host_name: TLabel;
    edtmail_host_name: TEdit;
    lblmail_host_user: TLabel;
    edtmail_host_user: TEdit;
    lblmail_host_pass: TLabel;
    edtmail_host_pass: TEdit;
    lblmail_host_smtp_port: TLabel;
    edtmail_host_smtp_port: TEdit;
    tsAdres: TTabSheet;
    lbltaxpayer_type: TLabel;
    cbbtaxpayer_type: TComboBox;
    lbltax_administration: TLabel;
    edttax_administration: TEdit;
    lbltax_no: TLabel;
    edttax_no: TEdit;
    lblmersis_no: TLabel;
    edtmersis_no: TEdit;
    chkis_use_quality_form_number: TCheckBox;
    lblis_use_quality_form_number: TLabel;
    lblweb_site: TLabel;
    edtweb_site: TEdit;
    lblemail: TLabel;
    edtemail: TEdit;
    lblcountry_id: TLabel;
    lblcity_id: TLabel;
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
    edtcity_id: TEdit;
    procedure FormCreate(Sender: TObject);override;
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
  published
    procedure FormDestroy(Sender: TObject); override;
    procedure FormPaint(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Functions,
  Ths.Erp.Database.Table.SysLang,
  Ths.Erp.Database.Table.SysApplicationSettings;

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
    Canvas.Rectangle( x1, y1, x2, y2 );
  end;
end;

procedure TfrmSysApplicationSetting.edtform_colorDblClick(Sender: TObject);
begin
  if (FormMode = ifmUpdate) or (FormMode = ifmNewRecord) then
  begin
    SetColor(TFunctions.GetDialogColor(StrToIntDef(edtform_color.Text, 0)), edtform_color);
  end;
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
  begin
    SetColor(TFunctions.GetDialogColor(StrToIntDef(edtgrid_color_1.Text, 0)), edtgrid_color_1);
  end;
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
  begin
    SetColor(TFunctions.GetDialogColor(StrToIntDef(edtgrid_color_2.Text, 0)), edtgrid_color_2);
  end;
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
  begin
    SetColor(TFunctions.GetDialogColor(StrToIntDef(edtgrid_color_active.Text, 0)), edtgrid_color_active);
  end;
end;

procedure TfrmSysApplicationSetting.edtgrid_color_activeExit(Sender: TObject);
begin
  inherited;
  SetColor(StrToIntDef(edtgrid_color_active.Text, 0), edtgrid_color_active);
  edtgrid_color_active.Repaint;
end;

procedure TfrmSysApplicationSetting.FormCreate(Sender: TObject);
var
  n1: Integer;
  vLang: TSysLang;
begin
  inherited;

  edtcompany_name.CharCase := ecNormal;
  edtweb_site.CharCase := ecNormal;
  edtemail.CharCase := ecNormal;
  cbbtaxpayer_type.CharCase := ecNormal;
  cbbapp_main_lang.CharCase := ecNormal;
  edtmail_host_name.CharCase := ecNormal;
  edtmail_host_user.CharCase := ecNormal;
  edtmail_host_pass.CharCase := ecNormal;

  vLang := TSysLang.Create(Table.Database);
  try
    vLang.SelectToList('', False, False);
    cbbapp_main_lang.Clear;
    for n1 := 0 to vLang.List.Count-1 do
      cbbapp_main_lang.Items.Add( TSysLang(vLang.List[n1]).Language.Value );
  finally
    vLang.Free;
  end;
end;

procedure TfrmSysApplicationSetting.FormDestroy(Sender: TObject);
begin
  //
  inherited;
end;

procedure TfrmSysApplicationSetting.FormPaint(Sender: TObject);
begin
  inherited;
  SetColor(clRed, edtform_color);
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
  inherited;

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
  begin
    DrawEmptyImage();
  end;

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
  editColor.thsColorRequiredData := color;
  editColor.Repaint;
end;

procedure TfrmSysApplicationSetting.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      btnAcceptAuto;

      TSysApplicationSettings(Table).FLogoVal := imgLogo.Picture.Bitmap;

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
