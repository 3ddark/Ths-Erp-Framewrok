unit ufrmAyarPrsPersonelTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsPersonelTipi = class(TfrmBaseInputDB)
    lblPersonelTipi: TLabel;
    edtPersonelTipi: TEdit;
    lblIsActive: TLabel;
    chkIsActive: TCheckBox;
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
  Ths.Erp.Database.Table.AyarPrsPersonelTipi;

{$R *.dfm}

procedure TfrmAyarPrsPersonelTipi.FormCreate(Sender: TObject);
begin
  TAyarPrsPersonelTipi(Table).PersonelTipi.SetControlProperty(Table.TableName, edtPersonelTipi);

  inherited;
end;

procedure TfrmAyarPrsPersonelTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtPersonelTipi.Text := FormatedVariantVal(TAyarPrsPersonelTipi(Table).PersonelTipi.FieldType, TAyarPrsPersonelTipi(Table).PersonelTipi.Value);
  chkIsActive.Checked := FormatedVariantVal(TAyarPrsPersonelTipi(Table).IsActive.FieldType, TAyarPrsPersonelTipi(Table).IsActive.Value);
end;

procedure TfrmAyarPrsPersonelTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsPersonelTipi(Table).PersonelTipi.Value := edtPersonelTipi.Text;
      TAyarPrsPersonelTipi(Table).IsActive.Value := chkIsActive.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
