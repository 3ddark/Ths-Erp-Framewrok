unit ufrmAyarAskerlikDurumu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarAskerlikDurumu = class(TfrmBaseInputDB)
    lblDurum: TLabel;
    edtDurum: TthsEdit;
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
  Ths.Erp.Database.Table.AyarAskerlikDurumu;

{$R *.dfm}

procedure TfrmAyarAskerlikDurumu.FormCreate(Sender: TObject);
begin
  TAyarAskerlikDurumu(Table).Durum.SetControlProperty(Table.TableName, edtDurum);

  inherited;
end;

procedure TfrmAyarAskerlikDurumu.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtDurum.Text := FormatedVariantVal(TAyarAskerlikDurumu(Table).Durum.FieldType, TAyarAskerlikDurumu(Table).Durum.Value);
end;

procedure TfrmAyarAskerlikDurumu.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarAskerlikDurumu(Table).Durum.Value := edtDurum.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
