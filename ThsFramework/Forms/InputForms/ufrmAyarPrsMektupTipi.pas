unit ufrmAyarPrsMektupTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsMektupTipi = class(TfrmBaseInputDB)
    lblMektupTipi: TLabel;
    edtMektupTipi: TEdit;
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
  Ths.Erp.Database.Table.AyarPrsMektupTipi;

{$R *.dfm}

procedure TfrmAyarPrsMektupTipi.FormCreate(Sender: TObject);
begin
  TAyarPrsMektupTipi(Table).MektupTipi.SetControlProperty(Table.TableName, edtMektupTipi);

  inherited;
end;

procedure TfrmAyarPrsMektupTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtMektupTipi.Text := FormatedVariantVal(TAyarPrsMektupTipi(Table).MektupTipi.FieldType, TAyarPrsMektupTipi(Table).MektupTipi.Value);
end;

procedure TfrmAyarPrsMektupTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsMektupTipi(Table).MektupTipi.Value := edtMektupTipi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
