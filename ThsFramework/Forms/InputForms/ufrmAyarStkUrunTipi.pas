unit ufrmAyarStkUrunTipi;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,

  Ths.Erp.Helper.Edit,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus, Vcl.AppEvnts, Vcl.Samples.Spin;

type
  TfrmAyarStkUrunTipi = class(TfrmBaseInputDB)
    lbltip: TLabel;
    edttip: TEdit;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
  end;

implementation

{$R *.dfm}

procedure TfrmAyarStkUrunTipi.btnAcceptClick(Sender: TObject);
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
