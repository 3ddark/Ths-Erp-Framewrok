unit ufrmAyarMukellefTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarMukellefTipi = class(TfrmBaseInputDB)
    chkIsDefault: TCheckBox;
    edtDeger: TEdit;
    lblDeger: TLabel;
    lblIsDefault: TLabel;
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
  Ths.Erp.Database.Table.AyarMukellefTipi;

{$R *.dfm}

procedure TfrmAyarMukellefTipi.FormCreate(Sender: TObject);
begin
  TAyarMukellefTipi(Table).Deger.SetControlProperty(Table.TableName, edtDeger);
  TAyarMukellefTipi(Table).IsDefault.SetControlProperty(Table.TableName, chkIsDefault);

  inherited;
end;

procedure TfrmAyarMukellefTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtDeger.Text := FormatedVariantVal(TAyarMukellefTipi(Table).Deger.FieldType, TAyarMukellefTipi(Table).Deger.Value);
  chkIsDefault.Checked := FormatedVariantVal(TAyarMukellefTipi(Table).IsDefault.FieldType, TAyarMukellefTipi(Table).IsDefault.Value);
end;

procedure TfrmAyarMukellefTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarMukellefTipi(Table).Deger.Value := edtDeger.Text;
      TAyarMukellefTipi(Table).IsDefault.Value := chkIsDefault.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
