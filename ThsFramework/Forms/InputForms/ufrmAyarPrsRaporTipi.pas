unit ufrmAyarPrsRaporTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsRaporTipi = class(TfrmBaseInputDB)
    lblRaporTipi: TLabel;
    edtRaporTipi: TEdit;
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
  Ths.Erp.Database.Table.AyarPrsRaporTipi;

{$R *.dfm}

procedure TfrmAyarPrsRaporTipi.FormCreate(Sender: TObject);
begin
  TAyarPrsRaporTipi(Table).RaporTipi.SetControlProperty(Table.TableName, edtRaporTipi);

  inherited;
end;

procedure TfrmAyarPrsRaporTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtRaporTipi.Text := FormatedVariantVal(TAyarPrsRaporTipi(Table).RaporTipi.FieldType, TAyarPrsRaporTipi(Table).RaporTipi.Value);
end;

procedure TfrmAyarPrsRaporTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsRaporTipi(Table).RaporTipi.Value := edtRaporTipi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
