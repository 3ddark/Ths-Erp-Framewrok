unit ufrmParaBirimi;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmParaBirimi = class(TfrmBaseInputDB)
    lblKod: TLabel;
    edtKod: TEdit;
    lblSembol: TLabel;
    edtSembol: TEdit;
    lblIsVarsayilan: TLabel;
    chkIsVarsayilan: TCheckBox;
    lblAciklama: TLabel;
    edtAciklama: TEdit;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Table.ParaBirimi;

{$R *.dfm}

procedure TfrmParaBirimi.btnAcceptClick(Sender: TObject);
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
