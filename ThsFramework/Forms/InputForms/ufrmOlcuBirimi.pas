unit ufrmOlcuBirimi;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmOlcuBirimi = class(TfrmBaseInputDB)
    lblbirim: TLabel;
    edtbirim: TEdit;
    lblefatura_birim: TLabel;
    edtefatura_birim: TEdit;
    lblbirim_aciklama: TLabel;
    edtbirim_aciklama: TEdit;
    lblis_float_tip: TLabel;
    chkis_float_tip: TCheckBox;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.OlcuBirimi;

{$R *.dfm}

procedure TfrmOlcuBirimi.btnAcceptClick(Sender: TObject);
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

end.
