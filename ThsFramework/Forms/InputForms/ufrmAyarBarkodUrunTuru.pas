unit ufrmAyarBarkodUrunTuru;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB, Vcl.Samples.Spin;

type
  TfrmAyarBarkodUrunTuru = class(TfrmBaseInputDB)
    edtTur: TEdit;
    lblTur: TLabel;
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
  Ths.Erp.Database.Table.AyarBarkodUrunTuru;

{$R *.dfm}

procedure TfrmAyarBarkodUrunTuru.FormCreate(Sender: TObject);
begin
  TAyarBarkodUrunTuru(Table).Tur.SetControlProperty(Table.TableName, edtTur);

  inherited;
end;

procedure TfrmAyarBarkodUrunTuru.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtTur.Text := FormatedVariantVal(TAyarBarkodUrunTuru(Table).Tur.FieldType, TAyarBarkodUrunTuru(Table).Tur.Value);
end;

procedure TfrmAyarBarkodUrunTuru.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarBarkodUrunTuru(Table).Tur.Value := edtTur.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
