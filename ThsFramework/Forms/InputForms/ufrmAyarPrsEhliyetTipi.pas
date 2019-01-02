unit ufrmAyarPrsEhliyetTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsEhliyetTipi = class(TfrmBaseInputDB)
    lblEhliyetTipi: TLabel;
    edtEhliyetTipi: TEdit;
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
  Ths.Erp.Database.Table.AyarPrsEhliyetTipi;

{$R *.dfm}

procedure TfrmAyarPrsEhliyetTipi.FormCreate(Sender: TObject);
begin
  TAyarPrsEhliyetTipi(Table).EhliyetTipi.SetControlProperty(Table.TableName, edtEhliyetTipi);

  inherited;
end;

procedure TfrmAyarPrsEhliyetTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtEhliyetTipi.Text := FormatedVariantVal(TAyarPrsEhliyetTipi(Table).EhliyetTipi.FieldType, TAyarPrsEhliyetTipi(Table).EhliyetTipi.Value);
end;

procedure TfrmAyarPrsEhliyetTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsEhliyetTipi(Table).EhliyetTipi.Value := edtEhliyetTipi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
