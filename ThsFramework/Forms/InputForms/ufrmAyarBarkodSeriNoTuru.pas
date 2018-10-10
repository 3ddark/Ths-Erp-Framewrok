unit ufrmAyarBarkodSeriNoTuru;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB, Vcl.Samples.Spin;

type
  TfrmAyarBarkodSeriNoTuru = class(TfrmBaseInputDB)
    lblTur: TLabel;
    edtTur: TEdit;
    lblAciklama: TLabel;
    edtAciklama: TEdit;
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
  Ths.Erp.Database.Table.AyarBarkodSeriNoTuru;

{$R *.dfm}

procedure TfrmAyarBarkodSeriNoTuru.FormCreate(Sender: TObject);
begin
  TAyarBarkodSeriNoTuru(Table).Tur.SetControlProperty(Table.TableName, edtTur);
  TAyarBarkodSeriNoTuru(Table).Aciklama.SetControlProperty(Table.TableName, edtAciklama);

  inherited;
end;

procedure TfrmAyarBarkodSeriNoTuru.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtTur.Text := FormatedVariantVal(TAyarBarkodSeriNoTuru(Table).Tur.FieldType, TAyarBarkodSeriNoTuru(Table).Tur.Value);
  edtAciklama.Text := FormatedVariantVal(TAyarBarkodSeriNoTuru(Table).Aciklama.FieldType, TAyarBarkodSeriNoTuru(Table).Aciklama.Value);
end;

procedure TfrmAyarBarkodSeriNoTuru.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarBarkodSeriNoTuru(Table).Tur.Value := edtTur.Text;
      TAyarBarkodSeriNoTuru(Table).Aciklama.Value := edtAciklama.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
