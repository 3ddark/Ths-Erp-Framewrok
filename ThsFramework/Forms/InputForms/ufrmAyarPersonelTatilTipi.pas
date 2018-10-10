unit ufrmAyarPersonelTatilTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPersonelTatilTipi = class(TfrmBaseInputDB)
    lblDeger: TLabel;
    edtDeger: TEdit;
    lblIsResmiTatil: TLabel;
    chkIsResmiTatil: TCheckBox;
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
  Ths.Erp.Database.Table.AyarPersonelTatilTipi;

{$R *.dfm}

procedure TfrmAyarPersonelTatilTipi.FormCreate(Sender: TObject);
begin
  TAyarPersonelTatilTipi(Table).Deger.SetControlProperty(Table.TableName, edtDeger);

  inherited;
end;

procedure TfrmAyarPersonelTatilTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtDeger.Text := FormatedVariantVal(TAyarPersonelTatilTipi(Table).Deger.FieldType, TAyarPersonelTatilTipi(Table).Deger.Value);
  chkIsResmiTatil.Checked := FormatedVariantVal(TAyarPersonelTatilTipi(Table).IsResmiTatil.FieldType, TAyarPersonelTatilTipi(Table).IsResmiTatil.Value);
end;

procedure TfrmAyarPersonelTatilTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPersonelTatilTipi(Table).Deger.Value := edtDeger.Text;
      TAyarPersonelTatilTipi(Table).IsResmiTatil.Value := chkIsResmiTatil.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
