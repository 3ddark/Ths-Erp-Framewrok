unit ufrmSatisTeklifDetay;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseDetaylarDetay,

  Ths.Erp.Database.Table.OlcuBirimi,
  Ths.Erp.Database.Table.AyarVergiOrani,
  Ths.Erp.Database.Table.StokKarti;

type
  TfrmSatisTeklifDetay = class(TfrmBaseDetaylarDetay)
    lblStokKodu: TLabel;
    lblStokAciklama: TLabel;
    lblVadeGun: TLabel;
    lblAciklama: TLabel;
    lblReferans: TLabel;
    lblFiyat: TLabel;
    lblIskonto: TLabel;
    lblKdv: TLabel;
    lblVergiKodu: TLabel;
    lblMiktar: TLabel;
    lblOlcuBirimi: TLabel;
    lblGtipNo: TLabel;
    lblVergiMuafiyetKodu: TLabel;
    lblDigerVergiKodu: TLabel;
    imgStokResim: TImage;
    PanelBilgilendirme: TPanel;
    lblTutar: TLabel;
    lblValTutar: TLabel;
    lblTutarPara: TLabel;
    lblIskontoTutar: TLabel;
    lblValIskontoTutar: TLabel;
    lblIskontoTutarPara: TLabel;
    lblKDVTutar: TLabel;
    lblValKDVTutar: TLabel;
    lblKdvTutarPara: TLabel;
    lblToplamTutar: TLabel;
    lblValToplamTutar: TLabel;
    lblToplamTutarPara: TLabel;
    edtStokKodu: TEdit;
    edtStokAciklama: TEdit;
    edtFiyat: TEdit;
    edtMiktar: TEdit;
    cbbOlcuBirimi: TComboBox;
    edtIskonto: TEdit;
    cbbKdv: TComboBox;
    edtVadeGun: TEdit;
    edtGtipNo: TEdit;
    edtAciklama: TEdit;
    edtReferans: TEdit;
    cbbVergiKodu: TComboBox;
    cbbDigerVergiKodu: TComboBox;
    cbbVergiMuafiyetKodu: TComboBox;
    lblNetFiyat: TLabel;
    lblValNetFiyat: TLabel;
    lblNetFiyatPara: TLabel;
    lblNetTutar: TLabel;
    lblValNetTutar: TLabel;
    lblNetTutarPara: TLabel;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure edtFiyatKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtMiktarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtIskontoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbbKdvChange(Sender: TObject);
    procedure FormShow(Sender: TObject); override;
  private
    FNetFiyat,
    FTutar,
    FNetTutar,
    FIskontoTutar,
    FKDVTutar,
    FToplamTutar: Double;

    vHelperStokKarti: TStokKarti;
    vVergiOrani: TAyarVergiOrani;
    vOlcuBirimi: TOlcuBirimi;

    procedure CalculateTotals();
  public
    procedure ClearTotalLabels;
  protected
  published
    procedure HelperProcess(Sender: TObject);
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSatisTeklifDetaylar,
  Ths.Erp.Database.Table.SatisTeklif,
  Ths.Erp.Database.Table.SatisTeklifDetay,

  ufrmHelperStokKarti;

{$R *.dfm}

procedure TfrmSatisTeklifDetay.CalculateTotals();
var
  vFiyat, vMiktar, vIskontoOrani, vKDVOrani: Double;
begin
  vFiyat := 0;
  vMiktar := 0;
  vIskontoOrani := 0;
  vKDVOrani := 0;

  if edtFiyat.Text <> '' then
    vFiyat := StrToFloatDef(edtFiyat.Text, 0);

  if edtMiktar.Text <> '' then
    vMiktar := StrToFloatDef(edtMiktar.Text, 0);

  if edtIskonto.Text <> '' then
    vIskontoOrani  := StrToFloatDef(edtIskonto.Text, 0);

  if cbbKdv.Text <> '' then
    vKDVOrani := StrToFloatDef(cbbKdv.Text, 0);

  if ((edtFiyat.Text <> '') and (edtMiktar.Text <> '') ) then
  begin
    FTutar := vFiyat * vMiktar;
    FNetFiyat := vFiyat * ((100-vIskontoOrani)/100);
    FNetTutar := FNetFiyat * vMiktar;
    FIskontoTutar := FTutar - FNetTutar;
    FKDVTutar := FNetTutar * (vKDVOrani)/100;
    FToplamTutar := FNetTutar + FKDVTutar;

    lblValNetFiyat.Caption := FloatToStrF(FNetFiyat, TFloatFormat.ffFixed, 7, TSingletonDB.GetInstance.HaneMiktari.SatisMiktar.Value);
    lblValTutar.Caption := FloatToStrF(FTutar, TFloatFormat.ffFixed, 7, TSingletonDB.GetInstance.HaneMiktari.SatisMiktar.Value);
    lblValIskontoTutar.Caption := FloatToStrF(FIskontoTutar, TFloatFormat.ffFixed, 7, TSingletonDB.GetInstance.HaneMiktari.SatisMiktar.Value);
    lblValNetTutar.Caption := FloatToStrF(FNetTutar, TFloatFormat.ffFixed, 7, TSingletonDB.GetInstance.HaneMiktari.SatisMiktar.Value);
    lblValKDVTutar.Caption := FloatToStrF(FKDVTutar, TFloatFormat.ffFixed, 7, TSingletonDB.GetInstance.HaneMiktari.SatisMiktar.Value);
    lblValToplamTutar.Caption := FloatToStrF(FToplamTutar, TFloatFormat.ffFixed, 7, TSingletonDB.GetInstance.HaneMiktari.SatisMiktar.Value);
  end;
end;

procedure TfrmSatisTeklifDetay.cbbKdvChange(Sender: TObject);
begin
  inherited;
  CalculateTotals;
end;

procedure TfrmSatisTeklifDetay.ClearTotalLabels;
begin
  lblValNetFiyat.Caption := '0.00';
  lblValTutar.Caption := '0.00';
  lblValIskontoTutar.Caption := '0.00';
  lblValNetTutar.Caption := '0.00';
  lblValKDVTutar.Caption := '0.00';
  lblValToplamTutar.Caption := '0.00';

  lblNetFiyatPara.Caption := (TfrmSatisTeklifDetaylar(ParentForm).Table as TSatisTeklif).ParaBirimi.Value;
  lblTutarPara.Caption := (TfrmSatisTeklifDetaylar(ParentForm).Table as TSatisTeklif).ParaBirimi.Value;
  lblIskontoTutarPara.Caption := (TfrmSatisTeklifDetaylar(ParentForm).Table as TSatisTeklif).ParaBirimi.Value;
  lblNetTutarPara.Caption := (TfrmSatisTeklifDetaylar(ParentForm).Table as TSatisTeklif).ParaBirimi.Value;
  lblKdvTutarPara.Caption := (TfrmSatisTeklifDetaylar(ParentForm).Table as TSatisTeklif).ParaBirimi.Value;
  lblToplamTutarPara.Caption := (TfrmSatisTeklifDetaylar(ParentForm).Table as TSatisTeklif).ParaBirimi.Value;
end;

procedure TfrmSatisTeklifDetay.edtFiyatKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  CalculateTotals;
end;

procedure TfrmSatisTeklifDetay.edtIskontoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  CalculateTotals;
end;

procedure TfrmSatisTeklifDetay.edtMiktarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  CalculateTotals;
end;

procedure TfrmSatisTeklifDetay.FormCreate(Sender: TObject);
var
  n1: Integer;
begin
  TSatisTeklifDetay(Table).StokKodu.SetControlProperty(Table.TableName, edtStokKodu);
  TSatisTeklifDetay(Table).StokAciklama.SetControlProperty(Table.TableName, edtStokAciklama);
  TSatisTeklifDetay(Table).Aciklama.SetControlProperty(Table.TableName, edtAciklama);
  TSatisTeklifDetay(Table).Referans.SetControlProperty(Table.TableName, edtReferans);
  TSatisTeklifDetay(Table).Miktar.SetControlProperty(Table.TableName, edtMiktar);
  TSatisTeklifDetay(Table).OlcuBirimi.SetControlProperty(Table.TableName, cbbOlcuBirimi);
  TSatisTeklifDetay(Table).IskontoOrani.SetControlProperty(Table.TableName, edtIskonto);
  TSatisTeklifDetay(Table).Fiyat.SetControlProperty(Table.TableName, edtFiyat);
  TSatisTeklifDetay(Table).KdvOrani.SetControlProperty(Table.TableName, cbbKdv);
  TSatisTeklifDetay(Table).VadeGun.SetControlProperty(Table.TableName, edtVadeGun);
  TSatisTeklifDetay(Table).VergiKodu.SetControlProperty(Table.TableName, cbbVergiKodu);
  TSatisTeklifDetay(Table).VergiMuafiyetKodu.SetControlProperty(Table.TableName, cbbVergiMuafiyetKodu);
  TSatisTeklifDetay(Table).DigerVergiKodu.SetControlProperty(Table.TableName, cbbDigerVergiKodu);
  TSatisTeklifDetay(Table).GtipNo.SetControlProperty(Table.TableName, edtGtipNo);

  inherited;

  ClearTotalLabels;

  vHelperStokKarti := TStokKarti.Create(Table.Database);
  vVergiOrani := TAyarVergiOrani.Create(Table.Database);
  vOlcuBirimi := TOlcuBirimi.Create(Table.Database);


  vOlcuBirimi.SelectToList('', False, False);
  cbbOlcuBirimi.Clear;
  for n1 := 0 to vOlcuBirimi.List.Count-1 do
    cbbOlcuBirimi.AddItem(FormatedVariantVal(TOlcuBirimi(vOlcuBirimi.List[n1]).Birim.FieldType, TOlcuBirimi(vOlcuBirimi.List[n1]).Birim.Value), TOlcuBirimi(vOlcuBirimi.List[n1]));

  vVergiOrani.SelectToList('', False, False);
  cbbKdv.Clear;
  for n1 := 0 to vVergiOrani.List.Count-1 do
    cbbKdv.AddItem(FormatedVariantVal(TAyarVergiOrani(vVergiOrani.List[n1]).VergiOrani.FieldType, TAyarVergiOrani(vVergiOrani.List[n1]).VergiOrani.Value), TAyarVergiOrani(vVergiOrani.List[n1]));
  cbbKdv.ItemIndex := 0;
end;

procedure TfrmSatisTeklifDetay.FormDestroy(Sender: TObject);
begin
  if Assigned(vHelperStokKarti) then
    vHelperStokKarti.Free;
  if Assigned(vVergiOrani) then
    vVergiOrani.Free;
  if Assigned(vOlcuBirimi) then
    vOlcuBirimi.Free;

  inherited;
end;

procedure TfrmSatisTeklifDetay.FormShow(Sender: TObject);
begin
  inherited;
  edtStokKodu.OnHelperProcess := HelperProcess;
  edtStokKodu.thsInputDataType := itString;
  edtStokKodu.ReadOnly := True;

  cbbOlcuBirimi.Enabled := False;
end;

procedure TfrmSatisTeklifDetay.HelperProcess(Sender: TObject);
var
  vHelperFormStokKarti: TfrmHelperStokKarti;
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) then
  begin
    if Sender.ClassType = TEdit then
    begin
      if TEdit(Sender).Name = edtStokKodu.Name then
      begin
        vHelperFormStokKarti := TfrmHelperStokKarti.Create(edtStokKodu, Self, TStokKarti.Create(Table.Database), True);
        try
          vHelperFormStokKarti.ShowModal;

          if Assigned(vHelperStokKarti) then
            vHelperStokKarti.Free;

          if vHelperFormStokKarti.DataAktar then
          begin
            vHelperStokKarti := TStokKarti(vHelperFormStokKarti.Table.Clone);
            edtStokKodu.Text := vHelperStokKarti.StokKodu.Value;
            edtStokAciklama.Text := vHelperStokKarti.StokAdi.Value;
            edtFiyat.Text := vHelperStokKarti.SatisFiyat.Value;
            cbbOlcuBirimi.ItemIndex := cbbOlcuBirimi.Items.IndexOf( vHelperStokKarti.OlcuBirimi.Value );
            if Trim(edtIskonto.Text) = '' then
              edtIskonto.Text := '0';
          end;
        finally
          vHelperFormStokKarti.Free;
        end;
      end;
    end;
  end;
end;

procedure TfrmSatisTeklifDetay.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtStokKodu.Text := FormatedVariantVal(TSatisTeklifDetay(Table).StokKodu.FieldType, TSatisTeklifDetay(Table).StokKodu.Value);
  edtStokAciklama.Text := FormatedVariantVal(TSatisTeklifDetay(Table).StokAciklama.FieldType, TSatisTeklifDetay(Table).StokAciklama.Value);
  edtAciklama.Text := FormatedVariantVal(TSatisTeklifDetay(Table).Aciklama.FieldType, TSatisTeklifDetay(Table).Aciklama.Value);
  edtReferans.Text := FormatedVariantVal(TSatisTeklifDetay(Table).Referans.FieldType, TSatisTeklifDetay(Table).Referans.Value);
  edtMiktar.Text := FormatedVariantVal(TSatisTeklifDetay(Table).Miktar.FieldType, TSatisTeklifDetay(Table).Miktar.Value);
  cbbOlcuBirimi.ItemIndex := cbbOlcuBirimi.Items.IndexOf(FormatedVariantVal(TSatisTeklifDetay(Table).OlcuBirimi.FieldType, TSatisTeklifDetay(Table).OlcuBirimi.Value));
  edtFiyat.Text := FormatedVariantVal(TSatisTeklifDetay(Table).Fiyat.FieldType, TSatisTeklifDetay(Table).Fiyat.Value);
  edtIskonto.Text := FormatedVariantVal(TSatisTeklifDetay(Table).IskontoOrani.FieldType, TSatisTeklifDetay(Table).IskontoOrani.Value);
  cbbKdv.Text := FormatedVariantVal(TSatisTeklifDetay(Table).KdvOrani.FieldType, TSatisTeklifDetay(Table).KdvOrani.Value);
  edtVadeGun.Text := FormatedVariantVal(TSatisTeklifDetay(Table).VadeGun.FieldType, TSatisTeklifDetay(Table).VadeGun.Value);
  cbbVergiKodu.ItemIndex := cbbVergiKodu.Items.IndexOf(FormatedVariantVal(TSatisTeklifDetay(Table).VergiKodu.FieldType, TSatisTeklifDetay(Table).VergiKodu.Value));
  cbbVergiMuafiyetKodu.ItemIndex := cbbVergiMuafiyetKodu.Items.IndexOf(FormatedVariantVal(TSatisTeklifDetay(Table).VergiMuafiyetKodu.FieldType, TSatisTeklifDetay(Table).VergiMuafiyetKodu.Value));
  cbbDigerVergiKodu.ItemIndex := cbbDigerVergiKodu.Items.IndexOf(FormatedVariantVal(TSatisTeklifDetay(Table).DigerVergiKodu.FieldType, TSatisTeklifDetay(Table).DigerVergiKodu.Value));
  edtGtipNo.Text := FormatedVariantVal(TSatisTeklifDetay(Table).GtipNo.FieldType, TSatisTeklifDetay(Table).GtipNo.Value);

  CalculateTotals;
end;

procedure TfrmSatisTeklifDetay.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSatisTeklifDetay(Table).StokKodu.Value := edtStokKodu.Text;
      TSatisTeklifDetay(Table).StokAciklama.Value := edtStokAciklama.Text;
      TSatisTeklifDetay(Table).Aciklama.Value := edtAciklama.Text;
      TSatisTeklifDetay(Table).Referans.Value := edtReferans.Text;
      TSatisTeklifDetay(Table).Miktar.Value := edtMiktar.Text;
      TSatisTeklifDetay(Table).OlcuBirimi.Value := cbbOlcuBirimi.Text;

      TSatisTeklifDetay(Table).IskontoOrani.Value := edtIskonto.Text;
      TSatisTeklifDetay(Table).Fiyat.Value := edtFiyat.Text;
      TSatisTeklifDetay(Table).NetFiyat.Value := FNetFiyat;
      TSatisTeklifDetay(Table).Tutar.Value := FTutar;
      TSatisTeklifDetay(Table).IskontoTutar.Value := FIskontoTutar;
      TSatisTeklifDetay(Table).NetTutar.Value := FNetTutar;
      TSatisTeklifDetay(Table).KdvOrani.Value := cbbKdv.Text;
      TSatisTeklifDetay(Table).KdvTutar.Value := FKDVTutar;
      TSatisTeklifDetay(Table).ToplamTutar.Value := FToplamTutar;

      TSatisTeklifDetay(Table).VadeGun.Value := StrToFloatDef(edtVadeGun.Text, 0);

      TSatisTeklifDetay(Table).IsAnaUrun.Value := False;
      TSatisTeklifDetay(Table).AnaUrunID.Value := 0;
      TSatisTeklifDetay(Table).ReferansAnaUrunID.Value := 0;
      TSatisTeklifDetay(Table).TransferHesapKodu.Value := '';
      TSatisTeklifDetay(Table).KdvTransferHesapKodu.Value := '';

      TSatisTeklifDetay(Table).VergiKodu.Value := cbbVergiKodu.Text;
      TSatisTeklifDetay(Table).VergiMuafiyetKodu.Value := cbbVergiMuafiyetKodu.Text;
      TSatisTeklifDetay(Table).DigerVergiKodu.Value := cbbDigerVergiKodu.Text;
      TSatisTeklifDetay(Table).GtipNo.Value := edtGtipNo.Text;

      inherited;
    end;
  end
  else
    inherited;
end;

end.
