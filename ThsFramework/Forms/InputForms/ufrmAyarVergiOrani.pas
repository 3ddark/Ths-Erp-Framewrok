unit ufrmAyarVergiOrani;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus;

type
  TfrmAyarVergiOrani = class(TfrmBaseInputDB)
    lblVergiOrani: TLabel;
    edtVergiOrani: TthsEdit;
    lblVergiHesapKodu: TLabel;
    edtVergiHesapKodu: TthsEdit;
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
  Ths.Erp.Database.Table.AyarVergiOrani;

{$R *.dfm}

procedure TfrmAyarVergiOrani.FormCreate(Sender: TObject);
begin
  TAyarVergiOrani(Table).VergiOrani.SetControlProperty(Table.TableName, edtVergiOrani);
  TAyarVergiOrani(Table).VergiHesapKodu.SetControlProperty(Table.TableName, edtVergiHesapKodu);

  inherited;
end;

procedure TfrmAyarVergiOrani.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtVergiOrani.Text := FormatedVariantVal(TAyarVergiOrani(Table).VergiOrani.FieldType, TAyarVergiOrani(Table).VergiOrani.Value);
  edtVergiHesapKodu.Text := FormatedVariantVal(TAyarVergiOrani(Table).VergiHesapKodu.FieldType, TAyarVergiOrani(Table).VergiHesapKodu.Value);
end;

procedure TfrmAyarVergiOrani.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarVergiOrani(Table).VergiOrani.Value := edtVergiOrani.Text;
      TAyarVergiOrani(Table).VergiHesapKodu.Value := edtVergiHesapKodu.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
