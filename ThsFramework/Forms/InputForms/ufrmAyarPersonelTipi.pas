unit ufrmAyarPersonelTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPersonelTipi = class(TfrmBaseInputDB)
    lblDeger: TLabel;
    edtDeger: TthsEdit;
    lblIsActive: TLabel;
    chkIsActive: TCheckBox;
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
  Ths.Erp.Database.Table.AyarPersonelTipi;

{$R *.dfm}

procedure TfrmAyarPersonelTipi.FormCreate(Sender: TObject);
begin
  TAyarPersonelTipi(Table).Deger.SetControlProperty(Table.TableName, edtDeger);

  inherited;
end;

procedure TfrmAyarPersonelTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtDeger.Text := FormatedVariantVal(TAyarPersonelTipi(Table).Deger.FieldType, TAyarPersonelTipi(Table).Deger.Value);
  chkIsActive.Checked := FormatedVariantVal(TAyarPersonelTipi(Table).IsActive.FieldType, TAyarPersonelTipi(Table).IsActive.Value);
end;

procedure TfrmAyarPersonelTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPersonelTipi(Table).Deger.Value := edtDeger.Text;
      TAyarPersonelTipi(Table).IsActive.Value := chkIsActive.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
