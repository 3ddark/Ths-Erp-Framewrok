unit ufrmUlke;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Samples.Spin,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,
  ufrmBase, ufrmBaseInputDB;

type
  TfrmUlke = class(TfrmBaseInputDB)
    lblulke_kodu: TLabel;
    lblulke_adi: TLabel;
    lbliso_year: TLabel;
    lbliso_cctld_code: TLabel;
    lblis_ab_uyesi: TLabel;
    edtulke_kodu: TEdit;
    edtulke_adi: TEdit;
    edtiso_year: TEdit;
    edtiso_cctld_code: TEdit;
    chkis_ab_uyesi: TCheckBox;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Table.Ulke;

{$R *.dfm}

procedure TfrmUlke.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      btnAcceptAuto;

      inherited;
    end;
  end
  else
    inherited;
end;

procedure TfrmUlke.FormShow(Sender: TObject);
begin
  inherited;
  edtiso_cctld_code.CharCase := ecLowerCase;
end;

end.
