unit ufrmAyarTeklifDurum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB, Vcl.Samples.Spin;

type
  TfrmAyarTeklifDurum = class(TfrmBaseInputDB)
    lblDeger: TLabel;
    edtDeger: TEdit;
    lblAciklama: TLabel;
    edtAciklama: TEdit;
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
  Ths.Erp.Database.Table.AyarTeklifDurum;

{$R *.dfm}

procedure TfrmAyarTeklifDurum.FormCreate(Sender: TObject);
begin
  TAyarTeklifDurum(Table).Deger.SetControlProperty(Table.TableName, edtDeger);
  TAyarTeklifDurum(Table).Aciklama.SetControlProperty(Table.TableName, edtAciklama);

  inherited;
end;

procedure TfrmAyarTeklifDurum.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtDeger.Text := FormatedVariantVal(TAyarTeklifDurum(Table).Deger.FieldType, TAyarTeklifDurum(Table).Deger.Value);
  edtAciklama.Text := FormatedVariantVal(TAyarTeklifDurum(Table).Aciklama.FieldType, TAyarTeklifDurum(Table).Aciklama.Value);
  chkIsActive.Checked := FormatedVariantVal(TAyarTeklifDurum(Table).IsActive.FieldType, TAyarTeklifDurum(Table).IsActive.Value);
end;

procedure TfrmAyarTeklifDurum.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarTeklifDurum(Table).Deger.Value := edtDeger.Text;
      TAyarTeklifDurum(Table).Aciklama.Value := edtAciklama.Text;
      TAyarTeklifDurum(Table).IsActive.Value := chkIsActive.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
