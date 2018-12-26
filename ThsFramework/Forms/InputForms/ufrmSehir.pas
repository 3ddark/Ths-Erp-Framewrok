unit ufrmSehir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Samples.Spin,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB,

  Ths.Erp.Database.Table.Ulke;

type
  TfrmSehir = class(TfrmBaseInputDB)
    lblSehirAdi: TLabel;
    lblUlkeAdi: TLabel;
    edtSehirAdi: TEdit;
    cbbUlkeAdi: TComboBox;
    lblPlakaKodu: TLabel;
    edtPlakaKodu: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.Sehir;

{$R *.dfm}

procedure TfrmSehir.FormCreate(Sender: TObject);
begin
  TSehir(Table).SehirAdi.SetControlProperty(Table.TableName, edtSehirAdi);
  TSehir(Table).UlkeID.FK.FKCol.SetControlProperty(Table.TableName, cbbUlkeAdi);
  TSehir(Table).PlakaKodu.SetControlProperty(Table.TableName, edtPlakaKodu);

  inherited;
end;

procedure TfrmSehir.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TfrmSehir.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtSehirAdi.Text := TSehir(Table).SehirAdi.Value;
  cbbUlkeAdi.ItemIndex := cbbUlkeAdi.Items.IndexOf( VarToStr(TSehir(Table).UlkeID.FK.FKCol.Value) );
  edtPlakaKodu.Text := TSehir(Table).PlakaKodu.Value;
end;

procedure TfrmSehir.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSehir(Table).SehirAdi.Value := edtSehirAdi.Text;
      TSehir(Table).UlkeID.Value := FormatedVariantVal(TUlke(cbbUlkeAdi.Items.Objects[cbbUlkeAdi.ItemIndex]).Id.FieldType, TUlke(cbbUlkeAdi.Items.Objects[cbbUlkeAdi.ItemIndex]).Id.Value);
      TSehir(Table).PlakaKodu.Value := edtPlakaKodu.Text;

      inherited;
    end;
  end
  else
    inherited;
end;

end.
