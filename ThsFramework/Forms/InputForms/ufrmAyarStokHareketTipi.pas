unit ufrmAyarStokHareketTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarStokHareketTipi = class(TfrmBaseInputDB)
    lblDeger: TLabel;
    edtDeger: TEdit;
    lblIsInput: TLabel;
    chkIsInput: TCheckBox;
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
  Ths.Erp.Database.Table.AyarStokHareketTipi;

{$R *.dfm}

procedure TfrmAyarStokHareketTipi.FormCreate(Sender: TObject);
begin
  TAyarStokHareketTipi(Table).Deger.SetControlProperty(Table.TableName, edtDeger);

  inherited;
end;

procedure TfrmAyarStokHareketTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtDeger.Text := TAyarStokHareketTipi(Table).Deger.Value;
  chkIsInput.Checked := FormatedVariantVal(TAyarStokHareketTipi(Table).IsInput.FieldType, TAyarStokHareketTipi(Table).IsInput.Value);
end;

procedure TfrmAyarStokHareketTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarStokHareketTipi(Table).Deger.Value := edtDeger.Text;
      TAyarStokHareketTipi(Table).IsInput.Value := chkIsInput.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
