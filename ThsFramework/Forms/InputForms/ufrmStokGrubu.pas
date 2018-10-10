unit ufrmStokGrubu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.AyarVergiOrani,
  Ths.Erp.Database.Table.StokGrubuTuru, Vcl.Samples.Spin;

type
  TfrmStokGrubu = class(TfrmBaseInputDB)
    lblGrup: TLabel;
    lblAlisHesabi: TLabel;
    lblSatisHesabi: TLabel;
    lblHammaddeHesabi: TLabel;
    lblMamulHesabi: TLabel;
    lblKDVOrani: TLabel;
    lblTur: TLabel;
    lblIsIskontoAktif: TLabel;
    lblIskontoSatis: TLabel;
    lblIskontoMudur: TLabel;
    lblIsSatisFiyatiniKullan: TLabel;
    lblYariMamulHesabi: TLabel;
    lblIsMaliyetAnalizFarkliDB: TLabel;
    edtGrup: TEdit;
    edtAlisHesabi: TEdit;
    edtSatisHesabi: TEdit;
    edtHammaddeHesabi: TEdit;
    edtMamulHesabi: TEdit;
    cbbKDVOrani: TCombobox;
    cbbTur: TCombobox;
    chkIsIskontoAktif: TCheckBox;
    edtIskontoSatis: TEdit;
    edtIskontoMudur: TEdit;
    chkIsSatisFiyatiniKullan: TCheckBox;
    edtYariMamulHesabi: TEdit;
    chkIsMaliyetAnalizFarkliDB: TCheckBox;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
    vStokGrubuTur: TStokGrubuTuru;
    vVergiOrani: TAyarVergiOrani;
  public
  protected
  published
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.StokGrubu;

{$R *.dfm}

procedure TfrmStokGrubu.FormCreate(Sender: TObject);
var
  n1: Integer;
begin
  TStokGrubu(Table).Grup.SetControlProperty(Table.TableName, edtGrup);
  TStokGrubu(Table).AlisHesabi.SetControlProperty(Table.TableName, edtAlisHesabi);
  TStokGrubu(Table).SatisHesabi.SetControlProperty(Table.TableName, edtSatisHesabi);
  TStokGrubu(Table).HammaddeHesabi.SetControlProperty(Table.TableName, edtHammaddeHesabi);
  TStokGrubu(Table).MamulHesabi.SetControlProperty(Table.TableName, edtMamulHesabi);
  TStokGrubu(Table).KDVOrani.SetControlProperty(Table.TableName, cbbKDVOrani);
  TStokGrubu(Table).Tur.SetControlProperty(Table.TableName, cbbTur);
  TStokGrubu(Table).IskontoSatis.SetControlProperty(Table.TableName, edtIskontoSatis);
  TStokGrubu(Table).IskontoMudur.SetControlProperty(Table.TableName, edtIskontoMudur);
  TStokGrubu(Table).YariMamulHesabi.SetControlProperty(Table.TableName, edtYariMamulHesabi);

  inherited;

  cbbKDVOrani.Style := csDropDownList;

  vStokGrubuTur := TStokGrubuTuru.Create(Table.Database);
  vVergiOrani := TAyarVergiOrani.Create(Table.Database);

  vStokGrubuTur.SelectToList('', False, False);
  cbbTur.Clear;
  for n1 := 0 to vStokGrubuTur.List.Count-1 do
    cbbTur.AddItem(
      FormatedVariantVal(TStokGrubuTuru(vStokGrubuTur.List[n1]).Tur.FieldType, TStokGrubuTuru(vStokGrubuTur.List[n1]).Tur.Value),
      TStokGrubuTuru(vStokGrubuTur.List[n1])
    );

  vVergiOrani.SelectToList(' ORDER BY ' + vVergiOrani.VergiOrani.FieldName + ' ASC', False, False);
  cbbKDVOrani.Clear;
  for n1 := 0 to vVergiOrani.List.Count-1 do
    cbbKDVOrani.AddItem(
      FormatedVariantVal(TAyarVergiOrani(vVergiOrani.List[n1]).VergiOrani.FieldType, TAyarVergiOrani(vVergiOrani.List[n1]).VergiOrani.Value),
      TAyarVergiOrani(vVergiOrani.List[n1])
    );
end;

procedure TfrmStokGrubu.FormDestroy(Sender: TObject);
begin
  vStokGrubuTur.Free;
  vVergiOrani.Free;

  inherited;
end;

procedure TfrmStokGrubu.RefreshData();
var
  n1: Integer;
begin
  //control içeriðini table class ile doldur
  edtGrup.Text := FormatedVariantVal(TStokGrubu(Table).Grup.FieldType, TStokGrubu(Table).Grup.Value);
  edtAlisHesabi.Text := FormatedVariantVal(TStokGrubu(Table).AlisHesabi.FieldType, TStokGrubu(Table).AlisHesabi.Value);
  edtSatisHesabi.Text := FormatedVariantVal(TStokGrubu(Table).SatisHesabi.FieldType, TStokGrubu(Table).SatisHesabi.Value);
  edtHammaddeHesabi.Text := FormatedVariantVal(TStokGrubu(Table).HammaddeHesabi.FieldType, TStokGrubu(Table).HammaddeHesabi.Value);
  edtMamulHesabi.Text := FormatedVariantVal(TStokGrubu(Table).MamulHesabi.FieldType, TStokGrubu(Table).MamulHesabi.Value);

  for n1 := 0 to cbbKDVOrani.Items.Count-1 do
  begin
    if TAyarVergiOrani(cbbKDVOrani.Items.Objects[n1]).Id.Value = TStokGrubu(Table).KDVOraniID.Value then
    begin
      cbbKDVOrani.ItemIndex := n1;
      break;
    end;
  end;

  for n1 := 0 to cbbTur.Items.Count-1 do
  begin
    if TStokGrubuTuru(cbbTur.Items.Objects[n1]).Id.Value = TStokGrubu(Table).TurID.Value then
    begin
      cbbTur.ItemIndex := n1;
      break;
    end;
  end;

  chkIsIskontoAktif.Checked := FormatedVariantVal(TStokGrubu(Table).IsIskontoAktif.FieldType, TStokGrubu(Table).IsIskontoAktif.Value);
  edtIskontoSatis.Text := FormatedVariantVal(TStokGrubu(Table).IskontoSatis.FieldType, TStokGrubu(Table).IskontoSatis.Value);
  edtIskontoMudur.Text := FormatedVariantVal(TStokGrubu(Table).IskontoMudur.FieldType, TStokGrubu(Table).IskontoMudur.Value);
  chkIsSatisFiyatiniKullan.Checked := FormatedVariantVal(TStokGrubu(Table).IsSatisFiyatiniKullan.FieldType, TStokGrubu(Table).IsSatisFiyatiniKullan.Value);
  edtYariMamulHesabi.Text := FormatedVariantVal(TStokGrubu(Table).YariMamulHesabi.FieldType, TStokGrubu(Table).YariMamulHesabi.Value);
  chkIsMaliyetAnalizFarkliDB.Checked := FormatedVariantVal(TStokGrubu(Table).IsMaliyetAnalizFarkliDB.FieldType, TStokGrubu(Table).IsMaliyetAnalizFarkliDB.Value);
end;

procedure TfrmStokGrubu.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TStokGrubu(Table).Grup.Value := edtGrup.Text;
      TStokGrubu(Table).AlisHesabi.Value := edtAlisHesabi.Text;
      TStokGrubu(Table).SatisHesabi.Value := edtSatisHesabi.Text;
      TStokGrubu(Table).HammaddeHesabi.Value := edtHammaddeHesabi.Text;
      TStokGrubu(Table).MamulHesabi.Value := edtMamulHesabi.Text;

      if cbbKDVOrani.ItemIndex > -1 then
        TStokGrubu(Table).KDVOraniID.Value := FormatedVariantVal(TAyarVergiOrani(cbbKDVOrani.Items.Objects[cbbKDVOrani.ItemIndex]).Id.FieldType, TAyarVergiOrani(cbbKDVOrani.Items.Objects[cbbKDVOrani.ItemIndex]).Id.Value);
      TStokGrubu(Table).KDVOrani.Value := cbbKDVOrani.Text;

      if cbbTur.ItemIndex > -1 then
        TStokGrubu(Table).TurID.Value := FormatedVariantVal(TStokGrubuTuru(cbbTur.Items.Objects[cbbTur.ItemIndex]).Id.FieldType, TStokGrubuTuru(cbbTur.Items.Objects[cbbTur.ItemIndex]).Id.Value);
      TStokGrubu(Table).Tur.Value := cbbTur.Text;

      TStokGrubu(Table).IsIskontoAktif.Value := chkIsIskontoAktif.Checked;
      TStokGrubu(Table).IskontoSatis.Value := edtIskontoSatis.Text;
      TStokGrubu(Table).IskontoMudur.Value := edtIskontoMudur.Text;
      TStokGrubu(Table).IsSatisFiyatiniKullan.Value := chkIsSatisFiyatiniKullan.Checked;
      TStokGrubu(Table).YariMamulHesabi.Value := edtYariMamulHesabi.Text;
      TStokGrubu(Table).IsMaliyetAnalizFarkliDB.Value := chkIsMaliyetAnalizFarkliDB.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
