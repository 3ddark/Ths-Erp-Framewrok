unit ufrmAyarPrsMedeniDurum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsMedeniDurum = class(TfrmBaseInputDB)
    lblMedeniDurum: TLabel;
    edtMedeniDurum: TEdit;
    lblIsMarried: TLabel;
    chkIsMarried: TCheckBox;
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
  Ths.Erp.Database.Table.AyarPrsMedeniDurum;

{$R *.dfm}

procedure TfrmAyarPrsMedeniDurum.FormCreate(Sender: TObject);
begin
  TAyarPrsMedeniDurum(Table).MedeniDurum.SetControlProperty(Table.TableName, edtMedeniDurum);

  inherited;
end;

procedure TfrmAyarPrsMedeniDurum.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtMedeniDurum.Text := FormatedVariantVal(TAyarPrsMedeniDurum(Table).MedeniDurum.FieldType, TAyarPrsMedeniDurum(Table).MedeniDurum.Value);
  chkIsMarried.Checked := FormatedVariantVal(TAyarPrsMedeniDurum(Table).IsMarried.FieldType, TAyarPrsMedeniDurum(Table).IsMarried.Value);
end;

procedure TfrmAyarPrsMedeniDurum.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsMedeniDurum(Table).MedeniDurum.Value := edtMedeniDurum.Text;
      TAyarPrsMedeniDurum(Table).IsMarried.Value := chkIsMarried.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
