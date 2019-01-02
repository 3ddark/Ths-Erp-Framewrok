unit ufrmAyarPrsAyrilmaNedeni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsAyrilmaNedeni = class(TfrmBaseInputDB)
    lblAyrilmaNedeni: TLabel;
    edtAyrilmaNedeni: TEdit;
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
  Ths.Erp.Database.Table.AyarPrsAyrilmaNedeni;

{$R *.dfm}

procedure TfrmAyarPrsAyrilmaNedeni.FormCreate(Sender: TObject);
begin
  TAyarPrsAyrilmaNedeni(Table).AyrilmaNedeni.SetControlProperty(Table.TableName, edtAyrilmaNedeni);

  inherited;
end;

procedure TfrmAyarPrsAyrilmaNedeni.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtAyrilmaNedeni.Text := FormatedVariantVal(TAyarPrsAyrilmaNedeni(Table).AyrilmaNedeni.FieldType, TAyarPrsAyrilmaNedeni(Table).AyrilmaNedeni.Value);
end;

procedure TfrmAyarPrsAyrilmaNedeni.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsAyrilmaNedeni(Table).AyrilmaNedeni.Value := edtAyrilmaNedeni.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
