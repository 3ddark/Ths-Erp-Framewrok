unit ufrmAyarPrsAskerlikDurumu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsAskerlikDurumu = class(TfrmBaseInputDB)
    lblAskerlikDurumu: TLabel;
    edtAskerlikDurumu: TEdit;
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
  Ths.Erp.Database.Table.AyarPrsAskerlikDurumu;

{$R *.dfm}

procedure TfrmAyarPrsAskerlikDurumu.FormCreate(Sender: TObject);
begin
  TAyarPrsAskerlikDurumu(Table).AskerlikDurumu.SetControlProperty(Table.TableName, edtAskerlikDurumu);

  inherited;
end;

procedure TfrmAyarPrsAskerlikDurumu.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtAskerlikDurumu.Text := FormatedVariantVal(TAyarPrsAskerlikDurumu(Table).AskerlikDurumu.FieldType, TAyarPrsAskerlikDurumu(Table).AskerlikDurumu.Value);
end;

procedure TfrmAyarPrsAskerlikDurumu.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsAskerlikDurumu(Table).AskerlikDurumu.Value := edtAskerlikDurumu.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
