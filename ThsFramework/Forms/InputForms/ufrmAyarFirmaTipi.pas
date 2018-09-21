unit ufrmAyarFirmaTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmAyarFirmaTipi = class(TfrmBaseInputDB)
    lblTip: TLabel;
    edtTip: TthsEdit;
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
  Ths.Erp.Database.Table.AyarFirmaTipi;

{$R *.dfm}

procedure TfrmAyarFirmaTipi.FormCreate(Sender: TObject);
begin
  TAyarFirmaTipi(Table).Tip.SetControlProperty(Table.TableName, edtTip);

  inherited;
end;

procedure TfrmAyarFirmaTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtTip.Text := TAyarFirmaTipi(Table).Tip.Value;
end;

procedure TfrmAyarFirmaTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarFirmaTipi(Table).Tip.Value := edtTip.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
