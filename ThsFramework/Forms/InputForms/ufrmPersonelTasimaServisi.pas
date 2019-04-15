unit ufrmPersonelTasimaServisi;

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

  ufrmBase, ufrmBaseInputDB;

type
  TfrmPersonelTasimaServisi = class(TfrmBaseInputDB)
    edtServisAdi: TEdit;
    edtServisNo: TEdit;
    lblServisAdi: TLabel;
    lblServisNo: TLabel;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.PersonelTasimaServisi;

{$R *.dfm}

procedure TfrmPersonelTasimaServisi.FormCreate(Sender: TObject);
begin
  TPersonelTasimaServis(Table).ServisNo.SetControlProperty(Table.TableName, edtServisNo);
  TPersonelTasimaServis(Table).ServisAdi.SetControlProperty(Table.TableName, edtServisAdi);

  inherited;
end;

procedure TfrmPersonelTasimaServisi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtServisNo.Text := FormatedVariantVal(TPersonelTasimaServis(Table).ServisNo.FieldType, TPersonelTasimaServis(Table).ServisNo.Value);
  edtServisAdi.Text := FormatedVariantVal(TPersonelTasimaServis(Table).ServisAdi.FieldType, TPersonelTasimaServis(Table).ServisAdi.Value);
end;

procedure TfrmPersonelTasimaServisi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TPersonelTasimaServis(Table).ServisNo.Value := edtServisNo.Text;
      TPersonelTasimaServis(Table).ServisAdi.Value := edtServisAdi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
