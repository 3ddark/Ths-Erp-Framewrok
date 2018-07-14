unit ufrmAyarPersonelBolum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus;

type
  TfrmAyarPersonelBolum = class(TfrmBaseInputDB)
    lblBolum: TLabel;
    edtBolum: TthsEdit;
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
  Ths.Erp.Database.Table.AyarPersonelBolum;

{$R *.dfm}

procedure TfrmAyarPersonelBolum.FormCreate(Sender: TObject);
begin
  TAyarPersonelBolum(Table).Bolum.SetControlProperty(Table.TableName, edtBolum);

  inherited;
end;

procedure TfrmAyarPersonelBolum.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtBolum.Text := GetVarToFormatedValue(TAyarPersonelBolum(Table).Bolum.FieldType, TAyarPersonelBolum(Table).Bolum.Value);
end;

procedure TfrmAyarPersonelBolum.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPersonelBolum(Table).Bolum.Value := edtBolum.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
