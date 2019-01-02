unit ufrmAyarPrsTatilTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsTatilTipi = class(TfrmBaseInputDB)
    lblTatilTipi: TLabel;
    edtTatilTipi: TEdit;
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
  Ths.Erp.Database.Table.AyarPrsTatilTipi;

{$R *.dfm}

procedure TfrmAyarPrsTatilTipi.FormCreate(Sender: TObject);
begin
  TAyarPrsTatilTipi(Table).TatilTipi.SetControlProperty(Table.TableName, edtTatilTipi);

  inherited;
end;

procedure TfrmAyarPrsTatilTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtTatilTipi.Text := FormatedVariantVal(TAyarPrsTatilTipi(Table).TatilTipi.FieldType, TAyarPrsTatilTipi(Table).TatilTipi.Value);
  chkIsResmiTatil.Checked := FormatedVariantVal(TAyarPrsTatilTipi(Table).IsResmiTatil.FieldType, TAyarPrsTatilTipi(Table).IsResmiTatil.Value);
end;

procedure TfrmAyarPrsTatilTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsTatilTipi(Table).TatilTipi.Value := edtTatilTipi.Text;
      TAyarPrsTatilTipi(Table).IsResmiTatil.Value := chkIsResmiTatil.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
