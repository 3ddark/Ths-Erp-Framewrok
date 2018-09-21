unit ufrmAyarOdemeBaslangicDonemi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Samples.Spin;

type
  TfrmAyarOdemeBaslangicDonemi = class(TfrmBaseInputDB)
    lblDeger: TLabel;
    edtDeger: TthsEdit;
    lblAciklama: TLabel;
    edtAciklama: TthsEdit;
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
  Ths.Erp.Database.Table.AyarOdemeBaslangicDonemi;

{$R *.dfm}

procedure TfrmAyarOdemeBaslangicDonemi.FormCreate(Sender: TObject);
begin
  TAyarOdemeBaslangicDonemi(Table).Deger.SetControlProperty(Table.TableName, edtDeger);
  TAyarOdemeBaslangicDonemi(Table).Aciklama.SetControlProperty(Table.TableName, edtAciklama);

  inherited;
end;

procedure TfrmAyarOdemeBaslangicDonemi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtDeger.Text := FormatedVariantVal(TAyarOdemeBaslangicDonemi(Table).Deger.FieldType, TAyarOdemeBaslangicDonemi(Table).Deger.Value);
  edtAciklama.Text := FormatedVariantVal(TAyarOdemeBaslangicDonemi(Table).Aciklama.FieldType, TAyarOdemeBaslangicDonemi(Table).Aciklama.Value);
  chkIsActive.Checked := FormatedVariantVal(TAyarOdemeBaslangicDonemi(Table).IsActive.FieldType, TAyarOdemeBaslangicDonemi(Table).IsActive.Value);
end;

procedure TfrmAyarOdemeBaslangicDonemi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarOdemeBaslangicDonemi(Table).Deger.Value := edtDeger.Text;
      TAyarOdemeBaslangicDonemi(Table).Aciklama.Value := edtAciklama.Text;
      TAyarOdemeBaslangicDonemi(Table).IsActive.Value := chkIsActive.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
