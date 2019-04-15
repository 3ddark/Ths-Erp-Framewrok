unit ufrmSysCountry;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Samples.Spin,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,
  ufrmBase, ufrmBaseInputDB;

type
  TfrmSysCountry = class(TfrmBaseInputDB)
    lblcountry_code: TLabel;
    lblcountry_name: TLabel;
    lbliso_year: TLabel;
    lbliso_cctld_code: TLabel;
    lblis_eu_member: TLabel;
    edtcountry_code: TEdit;
    edtcountry_name: TEdit;
    edtiso_year: TEdit;
    edtiso_cctld_code: TEdit;
    chkis_eu_member: TCheckBox;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Table.SysCountry;

{$R *.dfm}

procedure TfrmSysCountry.btnAcceptClick(Sender: TObject);
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

procedure TfrmSysCountry.FormShow(Sender: TObject);
begin
  inherited;
  edtiso_cctld_code.CharCase := ecLowerCase;
end;

end.
