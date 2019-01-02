unit ufrmAyarPrsMykTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsMykTipi = class(TfrmBaseInputDB)
    lblMykTipi: TLabel;
    edtMykTipi: TEdit;
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
  Ths.Erp.Database.Table.AyarPrsMykTipi;

{$R *.dfm}

procedure TfrmAyarPrsMykTipi.FormCreate(Sender: TObject);
begin
  TAyarPrsMykTipi(Table).MykTipi.SetControlProperty(Table.TableName, edtMykTipi);

  inherited;
end;

procedure TfrmAyarPrsMykTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtMykTipi.Text := FormatedVariantVal(TAyarPrsMykTipi(Table).MykTipi.FieldType, TAyarPrsMykTipi(Table).MykTipi.Value);
end;

procedure TfrmAyarPrsMykTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsMykTipi(Table).MykTipi.Value := edtMykTipi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
