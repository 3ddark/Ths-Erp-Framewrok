unit ufrmAyarPersonelBirim;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus,
  Ths.Erp.Database.Table.AyarPersonelBolum;

type
  TfrmAyarPersonelBirim = class(TfrmBaseInputDB)
    lblBolum: TLabel;
    cbbBolum: TthsComboBox;
    lblBirim: TLabel;
    edtBirim: TthsEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
    vBolum: TAyarPersonelBolum;
  public
  protected
  published
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.AyarPersonelBirim;

{$R *.dfm}

procedure TfrmAyarPersonelBirim.FormCreate(Sender: TObject);
var
  n1: Integer;
begin
  TAyarPersonelBirim(Table).Bolum.SetControlProperty(Table.TableName, cbbBolum);
  TAyarPersonelBirim(Table).Birim.SetControlProperty(Table.TableName, edtBirim);

  inherited;

  vBolum := TAyarPersonelBolum.Create(Table.Database);

  vBolum.SelectToList('', False, False);
  for n1 := 0 to vBolum.List.Count-1 do
    cbbBolum.Items.AddObject(FormatedVariantVal(TAyarPersonelBolum(vBolum.List[n1]).Bolum.FieldType, TAyarPersonelBolum(vBolum.List[n1]).Bolum.Value), TAyarPersonelBolum(vBolum.List[n1]));
//    TSingletonDB.GetInstance.FillComboFromLangData(cbbBolum, vBolum.TableName, vBolum.Bolum.FieldName,
//      GetVarToFormatedValue(TAyarPersonelBolum(vBolum.List[n1]).Id.FieldType, TAyarPersonelBolum(vBolum.List[n1]).Id.Value));
end;

procedure TfrmAyarPersonelBirim.FormDestroy(Sender: TObject);
begin
  vBolum.Free;
  inherited;
end;

procedure TfrmAyarPersonelBirim.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbBolum.ItemIndex := cbbBolum.Items.IndexOf(FormatedVariantVal(TAyarPersonelBirim(Table).Bolum.FieldType, TAyarPersonelBirim(Table).Bolum.Value));
  edtBirim.Text := FormatedVariantVal(TAyarPersonelBirim(Table).Birim.FieldType, TAyarPersonelBirim(Table).Birim.Value);
end;

procedure TfrmAyarPersonelBirim.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPersonelBirim(Table).BolumID.Value := FormatedVariantVal(TAyarPersonelBolum(cbbBolum.Items.Objects[cbbBolum.ItemIndex]).Id.FieldType, TAyarPersonelBolum(cbbBolum.Items.Objects[cbbBolum.ItemIndex]).Id.Value);
      TAyarPersonelBirim(Table).Bolum.Value := cbbBolum.Text;
      TAyarPersonelBirim(Table).Birim.Value := edtBirim.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
