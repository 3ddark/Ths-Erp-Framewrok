unit ufrmAyarPrsAyrilmaNedeni;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmAyarPrsAyrilmaNedeni = class(TfrmBaseInputDB)
    edtayrilma_nedeni: TEdit;
    lblayrilma_nedeni: TLabel;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.AyarPrsAyrilmaNedeni;

{$R *.dfm}

procedure TfrmAyarPrsAyrilmaNedeni.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsAyrilmaNedeni(Table).AyrilmaNedeni.Value := edtayrilma_nedeni.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
