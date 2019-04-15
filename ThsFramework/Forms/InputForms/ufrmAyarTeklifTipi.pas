unit ufrmAyarTeklifTipi;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB, Vcl.Samples.Spin;

type
  TfrmAyarTeklifTipi = class(TfrmBaseInputDB)
    chkIsActive: TCheckBox;
    edtAciklama: TEdit;
    edtDeger: TEdit;
    lblAciklama: TLabel;
    lblDeger: TLabel;
    lblIsActive: TLabel;
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
  Ths.Erp.Database.Table.AyarTeklifTipi;

{$R *.dfm}

procedure TfrmAyarTeklifTipi.FormCreate(Sender: TObject);
begin
  TAyarTeklifTipi(Table).Deger.SetControlProperty(Table.TableName, edtDeger);
  TAyarTeklifTipi(Table).Aciklama.SetControlProperty(Table.TableName, edtAciklama);
  TAyarTeklifTipi(Table).IsActive.SetControlProperty(Table.TableName, chkIsActive);

  inherited;
end;

procedure TfrmAyarTeklifTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtDeger.Text := FormatedVariantVal(TAyarTeklifTipi(Table).Deger.FieldType, TAyarTeklifTipi(Table).Deger.Value);
  edtAciklama.Text := FormatedVariantVal(TAyarTeklifTipi(Table).Aciklama.FieldType, TAyarTeklifTipi(Table).Aciklama.Value);
  chkIsActive.Checked := FormatedVariantVal(TAyarTeklifTipi(Table).IsActive.FieldType, TAyarTeklifTipi(Table).IsActive.Value);
end;

procedure TfrmAyarTeklifTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarTeklifTipi(Table).Deger.Value := edtDeger.Text;
      TAyarTeklifTipi(Table).Aciklama.Value := edtAciklama.Text;
      TAyarTeklifTipi(Table).IsActive.Value := chkIsActive.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
