unit ufrmCinsOzelligi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.CinsAilesi, Vcl.Samples.Spin;

type
  TfrmCinsOzelligi = class(TfrmBaseInputDB)
    cbbCinsAilesi: TComboBox;
    chkIsSeriNoIcerir: TCheckBox;
    edtAciklama: TEdit;
    edtCins: TEdit;
    edtString1: TEdit;
    edtString10: TEdit;
    edtString11: TEdit;
    edtString12: TEdit;
    edtString2: TEdit;
    edtString3: TEdit;
    edtString4: TEdit;
    edtString5: TEdit;
    edtString6: TEdit;
    edtString7: TEdit;
    edtString8: TEdit;
    edtString9: TEdit;
    lblAciklama: TLabel;
    lblCins: TLabel;
    lblCinsAilesi: TLabel;
    lblIsSeriNoIcerir: TLabel;
    lblString1: TLabel;
    lblString10: TLabel;
    lblString11: TLabel;
    lblString12: TLabel;
    lblString2: TLabel;
    lblString3: TLabel;
    lblString4: TLabel;
    lblString5: TLabel;
    lblString6: TLabel;
    lblString7: TLabel;
    lblString8: TLabel;
    lblString9: TLabel;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
    vCinsAilesi: TCinsAilesi;
  protected
  published
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.CinsOzelligi;

{$R *.dfm}

procedure TfrmCinsOzelligi.FormCreate(Sender: TObject);
var
  n1: Integer;
begin
  TCinsOzelligi(Table).CinsAilesi.SetControlProperty(Table.TableName, cbbCinsAilesi);
  TCinsOzelligi(Table).Cins.SetControlProperty(Table.TableName, edtCins);
  TCinsOzelligi(Table).Aciklama.SetControlProperty(Table.TableName, edtAciklama);
  TCinsOzelligi(Table).String1.SetControlProperty(Table.TableName, edtString1);
  TCinsOzelligi(Table).String2.SetControlProperty(Table.TableName, edtString2);
  TCinsOzelligi(Table).String3.SetControlProperty(Table.TableName, edtString3);
  TCinsOzelligi(Table).String4.SetControlProperty(Table.TableName, edtString4);
  TCinsOzelligi(Table).String5.SetControlProperty(Table.TableName, edtString5);
  TCinsOzelligi(Table).String6.SetControlProperty(Table.TableName, edtString6);
  TCinsOzelligi(Table).String7.SetControlProperty(Table.TableName, edtString7);
  TCinsOzelligi(Table).String8.SetControlProperty(Table.TableName, edtString8);
  TCinsOzelligi(Table).String9.SetControlProperty(Table.TableName, edtString9);
  TCinsOzelligi(Table).String10.SetControlProperty(Table.TableName, edtString10);
  TCinsOzelligi(Table).String11.SetControlProperty(Table.TableName, edtString11);
  TCinsOzelligi(Table).String12.SetControlProperty(Table.TableName, edtString12);
  TCinsOzelligi(Table).IsSerinoIcerir.SetControlProperty(Table.TableName, chkIsSeriNoIcerir);

  inherited;

  vCinsAilesi := TCinsAilesi.Create(Table.Database);
  vCinsAilesi.SelectToList('', False, False);
  cbbCinsAilesi.Clear;
  for n1 := 0 to vCinsAilesi.List.Count-1 do
    cbbCinsAilesi.AddItem( FormatedVariantVal(TCinsAilesi(vCinsAilesi.List[n1]).Aile.FieldType, TCinsAilesi(vCinsAilesi.List[n1]).Aile.Value), TCinsAilesi(vCinsAilesi.List[n1]) );
end;

procedure TfrmCinsOzelligi.FormDestroy(Sender: TObject);
begin
  vCinsAilesi.Free;

  inherited;
end;

procedure TfrmCinsOzelligi.RefreshData();
var
  n1: Integer;
begin
  //control içeriðini table class ile doldur
  for n1 := 0 to cbbCinsAilesi.Items.Count-1 do
  begin
    if Assigned(cbbCinsAilesi.Items.Objects[n1]) then
    begin
      if FormatedVariantVal(TCinsAilesi(cbbCinsAilesi.Items.Objects[n1]).Id.FieldType, TCinsAilesi(cbbCinsAilesi.Items.Objects[n1]).Id.Value) = FormatedVariantVal(TCinsOzelligi(Table).CinsAileID.FieldType, TCinsOzelligi(Table).CinsAileID.Value)
      then
      begin
        cbbCinsAilesi.ItemIndex := n1;
        Break;
      end;
    end;
  end;

  cbbCinsAilesi.Text := FormatedVariantVal(TCinsOzelligi(Table).CinsAilesi.FieldType, TCinsOzelligi(Table).CinsAilesi.Value);
  edtCins.Text := FormatedVariantVal(TCinsOzelligi(Table).Cins.FieldType, TCinsOzelligi(Table).Cins.Value);
  edtAciklama.Text := FormatedVariantVal(TCinsOzelligi(Table).Aciklama.FieldType, TCinsOzelligi(Table).Aciklama.Value);
  edtString1.Text := FormatedVariantVal(TCinsOzelligi(Table).String1.FieldType, TCinsOzelligi(Table).String1.Value);
  edtString2.Text := FormatedVariantVal(TCinsOzelligi(Table).String2.FieldType, TCinsOzelligi(Table).String2.Value);
  edtString3.Text := FormatedVariantVal(TCinsOzelligi(Table).String3.FieldType, TCinsOzelligi(Table).String3.Value);
  edtString4.Text := FormatedVariantVal(TCinsOzelligi(Table).String4.FieldType, TCinsOzelligi(Table).String4.Value);
  edtString5.Text := FormatedVariantVal(TCinsOzelligi(Table).String5.FieldType, TCinsOzelligi(Table).String5.Value);
  edtString6.Text := FormatedVariantVal(TCinsOzelligi(Table).String6.FieldType, TCinsOzelligi(Table).String6.Value);
  edtString7.Text := FormatedVariantVal(TCinsOzelligi(Table).String7.FieldType, TCinsOzelligi(Table).String7.Value);
  edtString8.Text := FormatedVariantVal(TCinsOzelligi(Table).String8.FieldType, TCinsOzelligi(Table).String8.Value);
  edtString9.Text := FormatedVariantVal(TCinsOzelligi(Table).String9.FieldType, TCinsOzelligi(Table).String9.Value);
  edtString10.Text := FormatedVariantVal(TCinsOzelligi(Table).String10.FieldType, TCinsOzelligi(Table).String10.Value);
  edtString11.Text := FormatedVariantVal(TCinsOzelligi(Table).String11.FieldType, TCinsOzelligi(Table).String11.Value);
  edtString12.Text := FormatedVariantVal(TCinsOzelligi(Table).String12.FieldType, TCinsOzelligi(Table).String12.Value);
  chkIsSeriNoIcerir.Checked := FormatedVariantVal(TCinsOzelligi(Table).IsSerinoIcerir.FieldType, TCinsOzelligi(Table).IsSerinoIcerir.Value);
end;

procedure TfrmCinsOzelligi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      if Assigned(cbbCinsAilesi.Items.Objects[cbbCinsAilesi.ItemIndex]) then
        TCinsOzelligi(Table).CinsAileID.Value := FormatedVariantVal(TCinsAilesi(cbbCinsAilesi.Items.Objects[cbbCinsAilesi.ItemIndex]).Id.FieldType, TCinsAilesi(cbbCinsAilesi.Items.Objects[cbbCinsAilesi.ItemIndex]).Id.Value);

      TCinsOzelligi(Table).CinsAilesi.Value := cbbCinsAilesi.Text;
      TCinsOzelligi(Table).Cins.Value := edtCins.Text;
      TCinsOzelligi(Table).Aciklama.Value := edtAciklama.Text;
      TCinsOzelligi(Table).String1.Value := edtString1.Text;
      TCinsOzelligi(Table).String2.Value := edtString2.Text;
      TCinsOzelligi(Table).String3.Value := edtString3.Text;
      TCinsOzelligi(Table).String4.Value := edtString4.Text;
      TCinsOzelligi(Table).String5.Value := edtString5.Text;
      TCinsOzelligi(Table).String6.Value := edtString6.Text;
      TCinsOzelligi(Table).String7.Value := edtString7.Text;
      TCinsOzelligi(Table).String8.Value := edtString8.Text;
      TCinsOzelligi(Table).String9.Value := edtString9.Text;
      TCinsOzelligi(Table).String10.Value := edtString10.Text;
      TCinsOzelligi(Table).String11.Value := edtString11.Text;
      TCinsOzelligi(Table).String12.Value := edtString12.Text;
      TCinsOzelligi(Table).IsSerinoIcerir.Value := chkIsSeriNoIcerir.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
