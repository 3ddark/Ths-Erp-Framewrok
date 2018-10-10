unit ufrmAyarPersonelDil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPersonelDil = class(TfrmBaseInputDB)
    lblDeger: TLabel;
    edtDeger: TEdit;
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
  Ths.Erp.Database.Table.AyarPersonelDil;

{$R *.dfm}

procedure TfrmAyarPersonelDil.FormCreate(Sender: TObject);
begin
  TAyarPersonelDil(Table).Deger.SetControlProperty(Table.TableName, edtDeger);

  inherited;
end;

procedure TfrmAyarPersonelDil.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtDeger.Text := FormatedVariantVal(TAyarPersonelDil(Table).Deger.FieldType, TAyarPersonelDil(Table).Deger.Value);
end;

procedure TfrmAyarPersonelDil.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPersonelDil(Table).Deger.Value := edtDeger.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
