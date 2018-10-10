unit ufrmPersonelDilBilgisi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmPersonelDilBilgisi = class(TfrmBaseInputDB)
    lblDil: TLabel;
    edtDil: TEdit;
    lblOkumaSeviyesi: TLabel;
    cbbOkumaSeviyesi: TComboBox;
    lblYazmaSeviyesi: TLabel;
    cbbYazmaSeviyesi: TComboBox;
    lblKonusmaSeviyesi: TLabel;
    cbbKonusmaSeviyesi: TComboBox;
    lblPersonelAd: TLabel;
    edtPersonelAd: TEdit;
    lblPersonelSoyad: TLabel;
    edtPersonelSoyad: TEdit;
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
  Ths.Erp.Database.Table.PersonelDilBilgisi;

{$R *.dfm}

procedure TfrmPersonelDilBilgisi.FormCreate(Sender: TObject);
begin
  TPersonelDilBilgisi(Table).Dil.SetControlProperty(Table.TableName, edtDil);
  TPersonelDilBilgisi(Table).OkumaSeviyesi.SetControlProperty(Table.TableName, cbbOkumaSeviyesi);
  TPersonelDilBilgisi(Table).YazmaSeviyesi.SetControlProperty(Table.TableName, cbbYazmaSeviyesi);
  TPersonelDilBilgisi(Table).KonusmaSeviyesi.SetControlProperty(Table.TableName, cbbKonusmaSeviyesi);
  TPersonelDilBilgisi(Table).PersonelAd.SetControlProperty(Table.TableName, edtPersonelAd);
  TPersonelDilBilgisi(Table).PersonelSoyad.SetControlProperty(Table.TableName, edtPersonelSoyad);

  inherited;
end;

procedure TfrmPersonelDilBilgisi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtDil.Text := FormatedVariantVal(TPersonelDilBilgisi(Table).Dil.FieldType, TPersonelDilBilgisi(Table).Dil.Value);
  cbbOkumaSeviyesi.Text := FormatedVariantVal(TPersonelDilBilgisi(Table).OkumaSeviyesi.FieldType, TPersonelDilBilgisi(Table).OkumaSeviyesi.Value);
  cbbYazmaSeviyesi.Text := FormatedVariantVal(TPersonelDilBilgisi(Table).YazmaSeviyesi.FieldType, TPersonelDilBilgisi(Table).YazmaSeviyesi.Value);
  cbbKonusmaSeviyesi.Text := FormatedVariantVal(TPersonelDilBilgisi(Table).KonusmaSeviyesi.FieldType, TPersonelDilBilgisi(Table).KonusmaSeviyesi.Value);
  edtPersonelAd.Text := FormatedVariantVal(TPersonelDilBilgisi(Table).PersonelAd.FieldType, TPersonelDilBilgisi(Table).PersonelAd.Value);
  edtPersonelSoyad.Text := FormatedVariantVal(TPersonelDilBilgisi(Table).PersonelSoyad.FieldType, TPersonelDilBilgisi(Table).PersonelSoyad.Value);
end;

procedure TfrmPersonelDilBilgisi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TPersonelDilBilgisi(Table).Dil.Value := edtDil.Text;
      TPersonelDilBilgisi(Table).OkumaSeviyesi.Value := cbbOkumaSeviyesi.Text;
      TPersonelDilBilgisi(Table).YazmaSeviyesi.Value := cbbYazmaSeviyesi.Text;
      TPersonelDilBilgisi(Table).KonusmaSeviyesi.Value := cbbKonusmaSeviyesi.Text;
      TPersonelDilBilgisi(Table).PersonelAd.Value := edtPersonelAd.Text;
      TPersonelDilBilgisi(Table).PersonelSoyad.Value := edtPersonelSoyad.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
