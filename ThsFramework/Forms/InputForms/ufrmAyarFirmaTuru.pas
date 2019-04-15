unit ufrmAyarFirmaTuru;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB
  ;

type
  TfrmAyarFirmaTuru = class(TfrmBaseInputDB)
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
  Ths.Erp.Database.Table.AyarFirmaTuru;

{$R *.dfm}

procedure TfrmAyarFirmaTuru.FormCreate(Sender: TObject);
begin
  TAyarFirmaTuru(Table).Tur.SetControlProperty(Table.TableName, edtTur);

  inherited;
end;

procedure TfrmAyarFirmaTuru.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtTur.Text := TAyarFirmaTuru(Table).Tur.Value;
end;

procedure TfrmAyarFirmaTuru.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarFirmaTuru(Table).Tur.Value := edtTur.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
