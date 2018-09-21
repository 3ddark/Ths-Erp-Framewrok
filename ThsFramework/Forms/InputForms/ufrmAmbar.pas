unit ufrmAmbar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmAmbar = class(TfrmBaseInputDB)
    lblAmbarAdi: TLabel;
    lblIsVarsayilanHammaddeAmbari: TLabel;
    lblIsVarsayilanUretimAmbari: TLabel;
    lblIsVarsayilanSatisAmbari: TLabel;
    edtAmbarAdi: TthsEdit;
    chkIsVarsayilanHammaddeAmbari: TCheckBox;
    chkIsVarsayilanUretimAmbari: TCheckBox;
    chkIsVarsayilanSatisAmbari: TCheckBox;
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
  Ths.Erp.Database.Table.Ambar;

{$R *.dfm}

procedure TfrmAmbar.FormCreate(Sender: TObject);
begin
  TAmbar(Table).AmbarAdi.SetControlProperty(Table.TableName, edtAmbarAdi);

  inherited;
end;

procedure TfrmAmbar.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtAmbarAdi.Text := FormatedVariantVal(TAmbar(Table).AmbarAdi.FieldType, TAmbar(Table).AmbarAdi.Value);
  chkIsVarsayilanHammaddeAmbari.Checked := FormatedVariantVal(TAmbar(Table).IsVarsayýlanHammaddeAmbari.FieldType, TAmbar(Table).IsVarsayýlanHammaddeAmbari.Value);
  chkIsVarsayilanUretimAmbari.Checked := FormatedVariantVal(TAmbar(Table).IsVarsayilanUretimAmbari.FieldType, TAmbar(Table).IsVarsayilanUretimAmbari.Value);
  chkIsVarsayilanSatisAmbari.Checked := FormatedVariantVal(TAmbar(Table).IsVarsayilanSatisAmbari.FieldType, TAmbar(Table).IsVarsayilanSatisAmbari.Value);
end;

procedure TfrmAmbar.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAmbar(Table).AmbarAdi.Value := edtAmbarAdi.Text;
      TAmbar(Table).IsVarsayýlanHammaddeAmbari.Value := chkIsVarsayilanHammaddeAmbari.Checked;
      TAmbar(Table).IsVarsayilanUretimAmbari.Value := chkIsVarsayilanUretimAmbari.Checked;
      TAmbar(Table).IsVarsayilanSatisAmbari.Value := chkIsVarsayilanSatisAmbari.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
