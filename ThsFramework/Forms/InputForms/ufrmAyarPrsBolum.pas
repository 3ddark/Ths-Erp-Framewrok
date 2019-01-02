unit ufrmAyarPrsBolum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsBolum = class(TfrmBaseInputDB)
    lblBolum: TLabel;
    edtBolum: TEdit;
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
  Ths.Erp.Database.Table.AyarPrsBolum;

{$R *.dfm}

procedure TfrmAyarPrsBolum.FormCreate(Sender: TObject);
begin
  TAyarPrsBolum(Table).Bolum.SetControlProperty(Table.TableName, edtBolum);

  inherited;
end;

procedure TfrmAyarPrsBolum.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtBolum.Text := FormatedVariantVal(TAyarPrsBolum(Table).Bolum.FieldType, TAyarPrsBolum(Table).Bolum.Value);
end;

procedure TfrmAyarPrsBolum.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsBolum(Table).Bolum.Value := edtBolum.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
