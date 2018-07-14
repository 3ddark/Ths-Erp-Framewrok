unit ufrmAyarPersonelBirim;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus;

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
  public
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.AyarPersonelBirim;

{$R *.dfm}

procedure TfrmAyarPersonelBirim.FormCreate(Sender: TObject);
begin
  TAyarPersonelBirim(Table).Bolum.SetControlProperty(Table.TableName, cbbBolum);
  TAyarPersonelBirim(Table).Birim.SetControlProperty(Table.TableName, edtBirim);

  inherited;
end;

procedure TfrmAyarPersonelBirim.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbBolum.Text := GetVarToFormatedValue(TAyarPersonelBirim(Table).Bolum.FieldType, TAyarPersonelBirim(Table).Bolum.Value);
  edtBirim.Text := GetVarToFormatedValue(TAyarPersonelBirim(Table).Birim.FieldType, TAyarPersonelBirim(Table).Birim.Value);
end;

procedure TfrmAyarPersonelBirim.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPersonelBirim(Table).Bolum.Value := cbbBolum.Text;
      TAyarPersonelBirim(Table).Birim.Value := edtBirim.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
