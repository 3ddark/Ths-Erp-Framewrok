unit ufrmBolge;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase,
  ufrmBaseInputDB,

  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Bolge
  ;

type
  TfrmBolge = class(TfrmBaseInputDB)
    edtBolge: TEdit;
    edtBolgeTuru: TEdit;
    lblBolge: TLabel;
    lblBolgeTuru: TLabel;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
  end;

implementation

{$R *.dfm}

procedure TfrmBolge.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TBolge(Table).BolgeTuruID.Value := TBolge(Table).BolgeTuruID.FK.FKTable.Id.Value;
      TBolge(Table).BolgeTuruID.FK.FKCol.Value := edtBolgeTuru.Text;
      TBolge(Table).BolgeAdi.Value := edtBolge.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
