unit ufrmHesapPlani;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmHesapPlani = class(TfrmBaseInputDB)
    lblPlanKoduVarsayilan: TLabel;
    edtPlanKoduVarsayilan: TEdit;
    lblAciklama: TLabel;
    edtAciklama: TEdit;
    lblPlanKodu: TLabel;
    edtPlanKodu: TEdit;
    lblSeviyeSayisi: TLabel;
    edtSeviyeSayisi: TEdit;
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
  Ths.Erp.Database.Table.HesapPlani;

{$R *.dfm}

procedure TfrmHesapPlani.FormCreate(Sender: TObject);
begin
  THesapPlani(Table).PlanKoduVarsayilan.SetControlProperty(Table.TableName, edtPlanKoduVarsayilan);
  THesapPlani(Table).Aciklama.SetControlProperty(Table.TableName, edtAciklama);
  THesapPlani(Table).PlanKodu.SetControlProperty(Table.TableName, edtPlanKodu);
  THesapPlani(Table).SeviyeSayisi.SetControlProperty(Table.TableName, edtSeviyeSayisi);

  inherited;
end;

procedure TfrmHesapPlani.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtPlanKoduVarsayilan.Text := FormatedVariantVal(THesapPlani(Table).PlanKoduVarsayilan.FieldType, THesapPlani(Table).PlanKoduVarsayilan.Value);
  edtAciklama.Text := FormatedVariantVal(THesapPlani(Table).Aciklama.FieldType, THesapPlani(Table).Aciklama.Value);
  edtPlanKodu.Text := FormatedVariantVal(THesapPlani(Table).PlanKodu.FieldType, THesapPlani(Table).PlanKodu.Value);
  edtSeviyeSayisi.Text := FormatedVariantVal(THesapPlani(Table).SeviyeSayisi.FieldType, THesapPlani(Table).SeviyeSayisi.Value);
end;

procedure TfrmHesapPlani.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      THesapPlani(Table).PlanKoduVarsayilan.Value := edtPlanKoduVarsayilan.Text;
      THesapPlani(Table).Aciklama.Value := edtAciklama.Text;
      THesapPlani(Table).PlanKodu.Value := edtPlanKodu.Text;
      THesapPlani(Table).SeviyeSayisi.Value := edtSeviyeSayisi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
