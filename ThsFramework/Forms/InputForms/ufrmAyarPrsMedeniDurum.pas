unit ufrmAyarPrsMedeniDurum;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, Vcl.Samples.Spin,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase,
  ufrmBaseInputDB;

type
  TfrmAyarPrsMedeniDurum = class(TfrmBaseInputDB)
    lblmedeni_durum: TLabel;
    edtmedeni_durum: TEdit;
    lblis_married: TLabel;
    chkis_married: TCheckBox;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
  end;

implementation

{$R *.dfm}

procedure TfrmAyarPrsMedeniDurum.btnAcceptClick(Sender: TObject);
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
