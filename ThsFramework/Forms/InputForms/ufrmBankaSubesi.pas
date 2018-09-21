unit ufrmBankaSubesi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.Sehir,
  Ths.Erp.Database.Table.Banka, Vcl.Samples.Spin;

type
  TfrmBankaSubesi = class(TfrmBaseInputDB)
    lblBanka: TLabel;
    cbbBanka: TthsComboBox;
    lblSubeKodu: TLabel;
    edtSubeKodu: TthsEdit;
    lblSubeAdi: TLabel;
    edtSubeAdi: TthsEdit;
    lblSubeIl: TLabel;
    cbbSubeIl: TthsComboBox;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
    vBanka: TBanka;
    vSehir: TSehir;
  public
  protected
  published
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.BankaSubesi;

{$R *.dfm}

procedure TfrmBankaSubesi.FormCreate(Sender: TObject);
var
  n1: Integer;
begin
  TBankaSubesi(Table).Banka.SetControlProperty(Table.TableName, cbbBanka);
  TBankaSubesi(Table).SubeKodu.SetControlProperty(Table.TableName, edtSubeKodu);
  TBankaSubesi(Table).SubeAdi.SetControlProperty(Table.TableName, edtSubeAdi);
  TBankaSubesi(Table).SubeIl.SetControlProperty(Table.TableName, cbbSubeIl);

  inherited;

  vBanka := TBanka.Create(Table.Database);
  vSehir := TSehir.Create(Table.Database);

  vBanka.SelectToList(' and ' + vBanka.TableName + '.' + vBanka.IsActive.FieldName + '=True', False, False);
  cbbBanka.Clear;
  for n1 := 0 to vBanka.List.Count-1 do
    cbbBanka.Items.AddObject(FormatedVariantVal(TBanka(vBanka.List[n1]).Adi.FieldType, TBanka(vBanka.List[n1]).Adi.Value), TBanka(vBanka.List[n1]));

  vSehir.SelectToList('', False, False);
  cbbSubeIl.Clear;
  for n1 := 0 to vSehir.List.Count-1 do
    cbbSubeIl.Items.AddObject(FormatedVariantVal(TSehir(vSehir.List[n1]).SehirAdi.FieldType, TSehir(vSehir.List[n1]).SehirAdi.Value), TSehir(vSehir.List[n1]));
end;

procedure TfrmBankaSubesi.FormDestroy(Sender: TObject);
begin
  vBanka.Free;
  vSehir.Free;
  inherited;
end;

procedure TfrmBankaSubesi.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbBanka.Text := FormatedVariantVal(TBankaSubesi(Table).Banka.FieldType, TBankaSubesi(Table).Banka.Value);
  edtSubeKodu.Text := FormatedVariantVal(TBankaSubesi(Table).SubeKodu.FieldType, TBankaSubesi(Table).SubeKodu.Value);
  edtSubeAdi.Text := FormatedVariantVal(TBankaSubesi(Table).SubeAdi.FieldType, TBankaSubesi(Table).SubeAdi.Value);
  cbbSubeIl.Text := FormatedVariantVal(TBankaSubesi(Table).SubeIl.FieldType, TBankaSubesi(Table).SubeIl.Value);
end;

procedure TfrmBankaSubesi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      if Assigned(cbbBanka.Items.Objects[cbbBanka.ItemIndex]) then
        TBankaSubesi(Table).BankaID.Value := FormatedVariantVal(TBanka(cbbBanka.Items.Objects[cbbBanka.ItemIndex]).Id.FieldType, TBanka(cbbBanka.Items.Objects[cbbBanka.ItemIndex]).Id.Value);
      TBankaSubesi(Table).Banka.Value := cbbBanka.Text;
      TBankaSubesi(Table).SubeKodu.Value := edtSubeKodu.Text;
      TBankaSubesi(Table).SubeAdi.Value := edtSubeAdi.Text;
      if Assigned(cbbSubeIl.Items.Objects[cbbSubeIl.ItemIndex]) then
        TBankaSubesi(Table).SubeIlID.Value := FormatedVariantVal(TSehir(cbbSubeIl.Items.Objects[cbbSubeIl.ItemIndex]).Id.FieldType, TSehir(cbbSubeIl.Items.Objects[cbbSubeIl.ItemIndex]).Id.Value);
      TBankaSubesi(Table).SubeIl.Value := cbbSubeIl.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
