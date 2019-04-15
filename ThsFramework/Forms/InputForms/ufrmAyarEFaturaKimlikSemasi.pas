unit ufrmAyarEFaturaKimlikSemasi;

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
  TfrmAyarEFaturaKimlikSemasi = class(TfrmBaseInputDB)
    edtdeger: TEdit;
    lbldeger: TLabel;
    lblaciklama: TLabel;
    edtaciklama: TEdit;
    lblis_active: TLabel;
    chkis_active: TCheckBox;
  private
  public
  protected
  published
    procedure btnAcceptClick(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Table.AyarEFaturaKimlikSemasi;

{$R *.dfm}

procedure TfrmAyarEFaturaKimlikSemasi.btnAcceptClick(Sender: TObject);
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
