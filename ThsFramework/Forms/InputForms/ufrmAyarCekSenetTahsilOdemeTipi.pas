unit ufrmAyarCekSenetTahsilOdemeTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Samples.Spin;

type
  TfrmAyarCekSenetTahsilOdemeTipi = class(TfrmBaseInputDB)
    lblDeger: TLabel;
    edtDeger: TthsEdit;
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
  Ths.Erp.Database.Table.AyarCekSenetTahsilOdemeTipi;

{$R *.dfm}

procedure TfrmAyarCekSenetTahsilOdemeTipi.FormCreate(Sender: TObject);
begin
  TAyarCekSenetTahsilOdemeTipi(Table).Deger.SetControlProperty(Table.TableName, edtDeger);

  inherited;
end;

procedure TfrmAyarCekSenetTahsilOdemeTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtDeger.Text := FormatedVariantVal(TAyarCekSenetTahsilOdemeTipi(Table).Deger.FieldType, TAyarCekSenetTahsilOdemeTipi(Table).Deger.Value);
end;

procedure TfrmAyarCekSenetTahsilOdemeTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarCekSenetTahsilOdemeTipi(Table).Deger.Value := edtDeger.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
