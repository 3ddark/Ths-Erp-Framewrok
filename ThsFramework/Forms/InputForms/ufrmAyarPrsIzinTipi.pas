unit ufrmAyarPrsIzinTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsIzinTipi = class(TfrmBaseInputDB)
    lblIzinTipi: TLabel;
    edtIzinTipi: TEdit;
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
  Ths.Erp.Database.Table.AyarPrsIzinTipi;

{$R *.dfm}

procedure TfrmAyarPrsIzinTipi.FormCreate(Sender: TObject);
begin
  TAyarPrsIzinTipi(Table).IzinTipi.SetControlProperty(Table.TableName, edtIzinTipi);

  inherited;
end;

procedure TfrmAyarPrsIzinTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtIzinTipi.Text := FormatedVariantVal(TAyarPrsIzinTipi(Table).IzinTipi.FieldType, TAyarPrsIzinTipi(Table).IzinTipi.Value);
end;

procedure TfrmAyarPrsIzinTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsIzinTipi(Table).IzinTipi.Value := edtIzinTipi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
