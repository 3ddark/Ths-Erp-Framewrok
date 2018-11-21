unit ufrmPersonelTasimaServisi;

interface

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
    lblServisNo: TLabel;
    edtServisNo: TEdit;
    lblServisAdi: TLabel;
    edtServisAdi: TEdit;
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
  TPersonelTasimaServisi(Table).ServisNo.SetControlProperty(Table.TableName, edtServisNo);
  TPersonelTasimaServisi(Table).ServisAdi.SetControlProperty(Table.TableName, edtServisAdi);

  inherited;
end;

procedure TfrmPersonelTasimaServisi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtServisNo.Text := FormatedVariantVal(TPersonelTasimaServisi(Table).ServisNo.FieldType, TPersonelTasimaServisi(Table).ServisNo.Value);
  edtServisAdi.Text := FormatedVariantVal(TPersonelTasimaServisi(Table).ServisAdi.FieldType, TPersonelTasimaServisi(Table).ServisAdi.Value);
end;

procedure TfrmPersonelTasimaServisi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TPersonelTasimaServisi(Table).ServisNo.Value := edtServisNo.Text;
      TPersonelTasimaServisi(Table).ServisAdi.Value := edtServisAdi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
