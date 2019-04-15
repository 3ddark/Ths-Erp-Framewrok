unit ufrmPersonelPDKSKart;

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
  TfrmPersonelPDKSKart = class(TfrmBaseInputDB)
    cbbKartNo: TComboBox;
    chkIsActive: TCheckBox;
    edtKartID: TEdit;
    edtPersonelNo: TEdit;
    lblIsActive: TLabel;
    lblKartID: TLabel;
    lblKartNo: TLabel;
    lblPersonelNo: TLabel;
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
  Ths.Erp.Database.Table.PersonelPDKSKart;

{$R *.dfm}

procedure TfrmPersonelPDKSKart.FormCreate(Sender: TObject);
begin
  TPersonelPDKSKart(Table).KartID.SetControlProperty(Table.TableName, edtKartID);
  TPersonelPDKSKart(Table).PersonelNo.SetControlProperty(Table.TableName, edtPersonelNo);
  TPersonelPDKSKart(Table).KartNo.SetControlProperty(Table.TableName, cbbKartNo);

  inherited;
end;

procedure TfrmPersonelPDKSKart.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtKartID.Text := FormatedVariantVal(TPersonelPDKSKart(Table).KartID.FieldType, TPersonelPDKSKart(Table).KartID.Value);
  edtPersonelNo.Text := FormatedVariantVal(TPersonelPDKSKart(Table).PersonelNo.FieldType, TPersonelPDKSKart(Table).PersonelNo.Value);
  cbbKartNo.Text := FormatedVariantVal(TPersonelPDKSKart(Table).KartNo.FieldType, TPersonelPDKSKart(Table).KartNo.Value);
  chkIsActive.Checked := FormatedVariantVal(TPersonelPDKSKart(Table).IsActive.FieldType, TPersonelPDKSKart(Table).IsActive.Value);
end;

procedure TfrmPersonelPDKSKart.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TPersonelPDKSKart(Table).KartID.Value := edtKartID.Text;
      TPersonelPDKSKart(Table).PersonelNo.Value := edtPersonelNo.Text;
      TPersonelPDKSKart(Table).KartNo.Value := cbbKartNo.Text;
      TPersonelPDKSKart(Table).IsActive.Value := chkIsActive.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
