unit ufrmAyarPrsCinsiyet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsCinsiyet = class(TfrmBaseInputDB)
    lblCinsiyet: TLabel;
    edtCinsiyet: TEdit;
    chkIsMan: TCheckBox;
    lblIsMan: TLabel;
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
  Ths.Erp.Database.Table.AyarPrsCinsiyet;

{$R *.dfm}

procedure TfrmAyarPrsCinsiyet.FormCreate(Sender: TObject);
begin
  TAyarPrsCinsiyet(Table).Cinsiyet.SetControlProperty(Table.TableName, edtCinsiyet);

  inherited;
end;

procedure TfrmAyarPrsCinsiyet.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtCinsiyet.Text := FormatedVariantVal(TAyarPrsCinsiyet(Table).Cinsiyet.FieldType, TAyarPrsCinsiyet(Table).Cinsiyet.Value);
  chkIsMan.Checked := FormatedVariantVal(TAyarPrsCinsiyet(Table).IsMan.FieldType, TAyarPrsCinsiyet(Table).IsMan.Value);
end;

procedure TfrmAyarPrsCinsiyet.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsCinsiyet(Table).Cinsiyet.Value := edtCinsiyet.Text;
      TAyarPrsCinsiyet(Table).IsMan.Value := chkIsMan.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
