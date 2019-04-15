unit ufrmAyarCekSenetCashEdiciTipi;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB, Vcl.Samples.Spin;

type
  TfrmAyarCekSenetCashEdiciTipi = class(TfrmBaseInputDB)
    edtDeger: TEdit;
    lblDeger: TLabel;
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
  Ths.Erp.Database.Table.AyarCekSenetCashEdiciTipi;

{$R *.dfm}

procedure TfrmAyarCekSenetCashEdiciTipi.FormCreate(Sender: TObject);
begin
  TAyarCekSenetCashEdiciTipi(Table).Deger.SetControlProperty(Table.TableName, edtDeger);

  inherited;
end;

procedure TfrmAyarCekSenetCashEdiciTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtDeger.Text := FormatedVariantVal(TAyarCekSenetCashEdiciTipi(Table).Deger.FieldType, TAyarCekSenetCashEdiciTipi(Table).Deger.Value);
end;

procedure TfrmAyarCekSenetCashEdiciTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarCekSenetCashEdiciTipi(Table).Deger.Value := edtDeger.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
