unit ufrmAyarEFaturaFaturaTipi;

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
  TfrmAyarEFaturaFaturaTipi = class(TfrmBaseInputDB)
    lblTip: TLabel;
    edtTip: TEdit;
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
  Ths.Erp.Database.Table.AyarEFaturaFaturaTipi;

{$R *.dfm}

procedure TfrmAyarEFaturaFaturaTipi.FormCreate(Sender: TObject);
begin
  TAyarEFaturaFaturaTipi(Table).Tip.SetControlProperty(Table.TableName, edtTip);

  inherited;
end;

procedure TfrmAyarEFaturaFaturaTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtTip.Text := TAyarEFaturaFaturaTipi(Table).Tip.Value;
end;

procedure TfrmAyarEFaturaFaturaTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarEFaturaFaturaTipi(Table).Tip.Value := edtTip.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
