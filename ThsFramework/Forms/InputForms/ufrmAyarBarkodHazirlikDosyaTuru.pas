unit ufrmAyarBarkodHazirlikDosyaTuru;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB, Vcl.Samples.Spin;

type
  TfrmAyarBarkodHazirlikDosyaTuru = class(TfrmBaseInputDB)
    lblTur: TLabel;
    edtTur: TEdit;
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
  Ths.Erp.Database.Table.AyarBarkodHazirlikDosyaTuru;

{$R *.dfm}

procedure TfrmAyarBarkodHazirlikDosyaTuru.FormCreate(Sender: TObject);
begin
  TAyarBarkodHazirlikDosyaTuru(Table).Tur.SetControlProperty(Table.TableName, edtTur);

  inherited;
end;

procedure TfrmAyarBarkodHazirlikDosyaTuru.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtTur.Text := FormatedVariantVal(TAyarBarkodHazirlikDosyaTuru(Table).Tur.FieldType, TAyarBarkodHazirlikDosyaTuru(Table).Tur.Value);
end;

procedure TfrmAyarBarkodHazirlikDosyaTuru.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarBarkodHazirlikDosyaTuru(Table).Tur.Value := edtTur.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
