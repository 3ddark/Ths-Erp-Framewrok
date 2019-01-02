unit ufrmAyarPrsSrcTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsSrcTipi = class(TfrmBaseInputDB)
    lblSrcTipi: TLabel;
    edtSrcTipi: TEdit;
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
  Ths.Erp.Database.Table.AyarPrsSrcTipi;

{$R *.dfm}

procedure TfrmAyarPrsSrcTipi.FormCreate(Sender: TObject);
begin
  TAyarPrsSrcTipi(Table).SrcTipi.SetControlProperty(Table.TableName, edtSrcTipi);

  inherited;
end;

procedure TfrmAyarPrsSrcTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtSrcTipi.Text := FormatedVariantVal(TAyarPrsSrcTipi(Table).SrcTipi.FieldType, TAyarPrsSrcTipi(Table).SrcTipi.Value);
end;

procedure TfrmAyarPrsSrcTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsSrcTipi(Table).SrcTipi.Value := edtSrcTipi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
