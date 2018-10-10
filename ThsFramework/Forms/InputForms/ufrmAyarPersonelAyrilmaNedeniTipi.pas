unit ufrmAyarPersonelAyrilmaNedeniTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPersonelAyrilmaNedeniTipi = class(TfrmBaseInputDB)
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
  Ths.Erp.Database.Table.AyarPersonelAyrilmaNedeniTipi;

{$R *.dfm}

procedure TfrmAyarPersonelAyrilmaNedeniTipi.FormCreate(Sender: TObject);
begin
  TAyarPersonelAyrilmaNedeniTipi(Table).Deger.SetControlProperty(Table.TableName, edtDeger);

  inherited;
end;

procedure TfrmAyarPersonelAyrilmaNedeniTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtDeger.Text := FormatedVariantVal(TAyarPersonelAyrilmaNedeniTipi(Table).Deger.FieldType, TAyarPersonelAyrilmaNedeniTipi(Table).Deger.Value);
end;

procedure TfrmAyarPersonelAyrilmaNedeniTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPersonelAyrilmaNedeniTipi(Table).Deger.Value := edtDeger.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
