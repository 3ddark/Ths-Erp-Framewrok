unit ufrmAyarPrsEgitimDurumu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsEgitimDurumu = class(TfrmBaseInputDB)
    lblEgitimDurumu: TLabel;
    edtEgitimDurumu: TEdit;
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
  Ths.Erp.Database.Table.AyarPrsEgitimDurumu;

{$R *.dfm}

procedure TfrmAyarPrsEgitimDurumu.FormCreate(Sender: TObject);
begin
  TAyarPrsEgitimDurumu(Table).EgitimDurumu.SetControlProperty(Table.TableName, edtEgitimDurumu);

  inherited;
end;

procedure TfrmAyarPrsEgitimDurumu.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtEgitimDurumu.Text := FormatedVariantVal(TAyarPrsEgitimDurumu(Table).EgitimDurumu.FieldType, TAyarPrsEgitimDurumu(Table).EgitimDurumu.Value);
end;

procedure TfrmAyarPrsEgitimDurumu.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsEgitimDurumu(Table).EgitimDurumu.Value := edtEgitimDurumu.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
