unit ufrmSatisTeklifDetaylar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Menus, Vcl.Samples.Spin, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Grids,
//  AdvUtil, AdvObj, AdvGrid,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,

  ufrmBase,
  ufrmBaseDetaylar,

  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.SatisTeklif,
  Ths.Erp.Database.Table.SatisTeklifDetay,
  Ths.Erp.Database.Table.AyarEFaturaFaturaTipi,
  Ths.Erp.Database.Table.PersonelKarti,
  Ths.Erp.Database.Table.AyarTeklifDurum,
  Ths.Erp.Database.Table.AyarTeklifTipi,
  Ths.Erp.Database.Table.AyarOdemeBaslangicDonemi,
  Ths.Erp.Database.Table.ParaBirimi;

const
  COLUMN_T_MAL_KODU            = 1;
  COLUMN_T_MAL_ADI             = 2;
  COLUMN_T_MIKTAR              = 3;
  COLUMN_T_BIRIM               = 4;
  COLUMN_T_KDV_ORANI           = 5;
  COLUMN_T_FIYAT               = 6;
  COLUMN_T_ISKONTO_ORANI       = 7;
  COLUMN_T_NET_FIYAT           = 8;
  COLUMN_T_TUTAR               = 9;
  COLUMN_T_NET_TUTAR           = 10;
  COLUMN_T_REFERANS            = 11;

type
  TfrmSatisTeklifDetaylar = class(TfrmBaseDetaylar)
    lblIslemTipi: TLabel;
    lblOdemeBaslangicDonemi: TLabel;
    lblTeklifNo: TLabel;
    lblTeklifTarihi: TLabel;
    lblMusteriKodu: TLabel;
    lblVadeGunSayisi: TLabel;
    lblMusteriAdi: TLabel;
    lblPostaKodu: TLabel;
    lblSehirMusteri: TLabel;
    lblVergiDairesi: TLabel;
    lblVergiNo: TLabel;
    lblParaBirimi: TLabel;
    lblOrtakKdv: TLabel;
    lblDolarKuru: TLabel;
    lblEuroKuru: TLabel;
    lblTeslimTarihi: TLabel;
    lblOrtakIskonto: TLabel;
    lblOdemeVadesi: TLabel;
    lblMusteriTemsilci: TLabel;
    lblGonderimSekli: TLabel;
    lblTeslimSarti: TLabel;
    lblGonderimSekliDetaylari: TLabel;
    lblOdemeSekli: TLabel;
    lblAciklama: TLabel;
    lblReferans: TLabel;
    lblTeklifTipi: TLabel;
    lblDurum: TLabel;
    lblTeslimatSuresi: TLabel;
    lblMuhattapAd: TLabel;
    lblSevkTarihi: TLabel;
    lblFaturaSevkTarihi: TLabel;
    LabelProformaNo: TLabel;
    LabelSonrakiAksiyonTarihi: TLabel;
    LabelSonrakiAksiyon: TLabel;
    LabelArayanKisi: TLabel;
    LabelAramaTarihi: TLabel;
    LabelSonGecerlilikTarihi: TLabel;
    LabelGenelIskontoYuzdesiTutari: TLabel;
    LabelGenelIskontoAyrac: TLabel;
    LabelIhracKayitKodu: TLabel;
    LabelTevkifatKodu: TLabel;
    LabelTevkifatOrani: TLabel;
    LabelTevkifatBolme: TLabel;
    lblAdresMusteri: TLabel;
    lblAdresSevkiyat: TLabel;
    lblSehirSevkiyat: TLabel;
    cbbIslemTipi: TCombobox;
    edtMusteriKodu: TEdit;
    edtMusteriAdi: TEdit;
    edtTeklifNo: TEdit;
    edtTeklifTarihi: TEdit;
    cbbTeklifDurum: TCombobox;
    edtTeslimTarihi: TEdit;
    edtAdresMusteri: TEdit;
    edtSehirMusteri: TEdit;
    edtPostaKodu: TEdit;
    edtVergiDairesi: TEdit;
    edtVergiNo: TEdit;
    cbbMusteriTemsilci: TCombobox;
    cbbTeklifTipi: TCombobox;
    edtAdresSevkiyat: TEdit;
    edtSehirSevkiyat: TEdit;
    edtMuhattapAd: TEdit;
    edtReferans: TEdit;
    edtOrtakKdv: TEdit;
    edtOrtakIskonto: TEdit;
    edtVadeGunSayisi: TEdit;
    cbbParaBirimi: TCombobox;
    edtDolarKuru: TEdit;
    edtEuroKuru: TEdit;
    edtOdemeVadesi: TEdit;
    edtTeslimatSuresi: TEdit;
    edtSevkTarihi: TEdit;
    edtFaturaSevkTarihi: TEdit;
    cbbOdemeBaslangicDonemi: TCombobox;
    cbbTeslimSarti: TCombobox;
    cbbGonderimSekli: TCombobox;
    edtGonderimSekliDetaylari: TEdit;
    cbbOdemeSekli: TCombobox;
    edtAciklama: TEdit;
    EditProformaNo: TEdit;
    EditSonrakiAksiyonTarihi: TEdit;
    MemoSonrakiAksiyon: TMemo;
    EditGenelIskontoYuzdesi: TEdit;
    EditGenelIskontoTutar: TEdit;
    ComboBoxArayanKisi: TComboBox;
    EditAramaTarihi: TEdit;
    EditSonGecerlilikTarihi: TEdit;
    ComboBoxIhracKayitKodu: TComboBox;
    ComboBoxTevkifatKodu: TComboBox;
    ComboBoxTevkifatPay: TComboBox;
    ComboBoxTevkifatPayda: TComboBox;
    lblMuhattapSoyad: TLabel;
    edtMuhattapSoyad: TEdit;
    lblGecerlilikTarihi: TLabel;
    edtGecerlilikTarihi: TEdit;
    procedure btnAddDetailClick(Sender: TObject);
    procedure btnAcceptClick(Sender: TObject);override;
  private
    vFaturaTipi: TAyarEFaturaFaturaTipi;
    vMusteriTemsilcisi: TPersonelKarti;
    vTeklifDurum: TAyarTeklifDurum;
    vTeklifTipi: TAyarTeklifTipi;
    vOdemeBaslangicDonemi: TAyarOdemeBaslangicDonemi;
    vPara: TParaBirimi;
  protected
    { Private declarations }
  public
    procedure GridAddRow(pGrid: TStringGrid; pTable: TTable = nil); override;
    procedure RefreshData; override;
    function CreateDetailInputForm(pFormMode: TInputFormMod): TForm; override;
    procedure GridReset(pGrid: TStringGrid); override;
    procedure GridFill(pGrid: TStringGrid); override;
  published
    procedure FormCreate(Sender: TObject); override;
    procedure FormShow(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject); override;
    procedure HelperProcess(Sender: TObject); override;
  end;

implementation

uses
  ufrmSatisTeklifDetay;

{$R *.dfm}

{ TfrmTeklifDetaylar }

procedure TfrmSatisTeklifDetaylar.GridAddRow(pGrid: TStringGrid; pTable: TTable);
begin
  inherited;
  pGrid.Objects[COLUMN_GRID_OBJECT, pGrid.Row] := pTable;
//  if pGrid.RowCount > 2 then
//    IncRow(strngrd1);
//  strngrd1.Cells[COLUMN_T_MAL_KODU, strngrd1.Row] := TSatisTeklif(pTable).MusteriKodu.Value;
//  strngrd1.Cells[COLUMN_T_MAL_ADI, strngrd1.Row] := TSatisTeklif(pTable). MusteriAdi.Value;
//  strngrd1.Cells[COLUMN_T_MIKTAR, strngrd1.Row] := TSatisTeklif(pTable).TeklifNo.Value;
end;

procedure TfrmSatisTeklifDetaylar.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      if cbbIslemTipi.ItemIndex > -1 then
        if Assigned(TAyarEFaturaFaturaTipi(cbbIslemTipi.Items.Objects[cbbIslemTipi.ItemIndex])) then
          TSatisTeklif(Table).IslemTipiID.Value := TAyarEFaturaFaturaTipi(cbbIslemTipi.Items.Objects[cbbIslemTipi.ItemIndex]).Id.Value;
      TSatisTeklif(Table).IslemTipi.Value := cbbIslemTipi.Text;

      TSatisTeklif(Table).MusteriKodu.Value := edtMusteriKodu.Text;
      TSatisTeklif(Table).MusteriAdi.Value := edtMusteriAdi.Text;
      TSatisTeklif(Table).AdresMusteri.Value := edtAdresMusteri.Text;
      TSatisTeklif(Table).SehirMusteri.Value := edtSehirMusteri.Text;
      TSatisTeklif(Table).PostaKodu.Value := edtPostaKodu.Text;
      TSatisTeklif(Table).AdresSevkiyat.Value := edtAdresSevkiyat.Text;
      TSatisTeklif(Table).SehirSevkiyat.Value := edtSehirSevkiyat.Text;
      TSatisTeklif(Table).OdemeVadesi.Value := edtOdemeVadesi.Text;
      TSatisTeklif(Table).TeslimatSuresi.Value := edtTeslimatSuresi.Text;
      TSatisTeklif(Table).SevkTarihi.Value := StrToDateDef(edtSevkTarihi.Text, 0);
      TSatisTeklif(Table).FaturaSevkTarihi.Value := edtFaturaSevkTarihi.Text;

      TSatisTeklif(Table).TeklifNo.Value := edtTeklifNo.Text;
      TSatisTeklif(Table).TeklifTarihi.Value := StrToDateDef(edtTeklifTarihi.Text, 0);
      TSatisTeklif(Table).VergiDairesi.Value := edtVergiDairesi.Text;
      TSatisTeklif(Table).VergiNo.Value := edtVergiNo.Text;
      TSatisTeklif(Table).MuhattapAd.Value := edtMuhattapAd.Text;
      TSatisTeklif(Table).Referans.Value := edtReferans.Text;

      if cbbTeklifDurum.ItemIndex > -1 then
        if Assigned(TAyarTeklifDurum(cbbTeklifDurum.Items.Objects[cbbTeklifDurum.ItemIndex])) then
          TSatisTeklif(Table).TeklifDurumID.Value := TAyarTeklifDurum(cbbTeklifDurum.Items.Objects[cbbTeklifDurum.ItemIndex]).Id.Value;
      TSatisTeklif(Table).TeklifDurum.Value := cbbTeklifDurum.Text;

      TSatisTeklif(Table).VadeGunSayisi.Value := edtVadeGunSayisi.Text;
      TSatisTeklif(Table).OrtakKDV.Value := StrToFloatDef(edtOrtakKdv.Text, 0);
      TSatisTeklif(Table).OrtakIskonto.Value := StrToFloatDef(edtOrtakIskonto.Text, 0);
      TSatisTeklif(Table).GonderimSekliDetay.Value := edtGonderimSekliDetaylari.Text;
      TSatisTeklif(Table).Aciklama.Value := edtAciklama.Text;

      TSatisTeklif(Table).TeslimTarihi.Value := StrToDateDef(edtTeslimTarihi.Text, 0);
      TSatisTeklif(Table).GecerlilikTarihi.Value := StrToDateDef(edtGecerlilikTarihi.Text, 0);

      if cbbMusteriTemsilci.ItemIndex > -1 then
        if Assigned(TPersonelKarti(cbbMusteriTemsilci.Items.Objects[cbbMusteriTemsilci.ItemIndex])) then
          TSatisTeklif(Table).MusteriTemsilcisiID.Value := TPersonelKarti(cbbMusteriTemsilci.Items.Objects[cbbMusteriTemsilci.ItemIndex]).Id.Value;
      TSatisTeklif(Table).MusteriTemsilcisi.Value := cbbMusteriTemsilci.Text;

      if cbbTeklifTipi.ItemIndex > -1 then
        if Assigned(TAyarTeklifTipi(cbbTeklifTipi.Items.Objects[cbbTeklifTipi.ItemIndex])) then
          TSatisTeklif(Table).TeklifTipiID.Value := TAyarTeklifTipi(cbbTeklifTipi.Items.Objects[cbbTeklifTipi.ItemIndex]).Id.Value;
      TSatisTeklif(Table).TeklifTipi.Value := cbbTeklifTipi.Text;

      TSatisTeklif(Table).MuhattapSoyad.Value := edtMuhattapSoyad.Text;
      TSatisTeklif(Table).ParaBirimi.Value := cbbParaBirimi.Text;
      TSatisTeklif(Table).DolarKur.Value := StrToFloatDef(edtDolarKuru.Text, 1);
      TSatisTeklif(Table).EuroKur.Value := StrToFloatDef(edtEuroKuru.Text, 1);

      if cbbOdemeBaslangicDonemi.ItemIndex > -1 then
        if Assigned(TAyarOdemeBaslangicDonemi(cbbOdemeBaslangicDonemi.Items.Objects[cbbOdemeBaslangicDonemi.ItemIndex])) then
          TSatisTeklif(Table).OdemeBaslangicDonemiID.Value := TAyarOdemeBaslangicDonemi(cbbTeklifTipi.Items.Objects[cbbTeklifTipi.ItemIndex]).Id.Value;
      TSatisTeklif(Table).TeklifTipi.Value := cbbTeklifTipi.Text;

      inherited;
    end;
  end
  else
    inherited;
end;

procedure TfrmSatisTeklifDetaylar.btnAddDetailClick(Sender: TObject);
begin
  inherited;
  CreateDetailInputForm(ifmNewRecord).Show
end;

function TfrmSatisTeklifDetaylar.CreateDetailInputForm(
  pFormMode: TInputFormMod): TForm;
begin
  Result := inherited;
  if (pFormMode = ifmNewRecord) or (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSatisTeklifDetay.Create(Application, Self, TSatisTeklifDetay.Create(Table.Database), False, pFormMode)
  else if (pFormMode = ifmRewiev) or (pFormMode = ifmUpdate) then
  begin
    if Assigned(strngrd1.Objects[COLUMN_GRID_OBJECT, strngrd1.Row]) then
      Result := TfrmSatisTeklifDetay.Create(Application, Self, TSatisTeklifDetay(strngrd1.Objects[COLUMN_GRID_OBJECT, strngrd1.Row]), False, pFormMode);
  end;
end;

procedure TfrmSatisTeklifDetaylar.GridFill(pGrid: TStringGrid);
var
  n1: Integer;
begin
  GridReset(pGrid);
  pGrid.Row := 1;

  for n1 := 0 to TSatisTeklif(Table).ListDetay.Count-1 do
  begin
    if n1 > 0 then
      GridIncRow(pGrid);

    pGrid.Rows[n1].BeginUpdate;

    GridAddRow(pGrid, TSatisTeklifDetay(TSatisTeklif(Table).ListDetay[n1]));

    GridAddCell(pGrid, COLUMN_GRID_OBJECT, pGrid.Row, (n1+1).ToString);
    GridAddCell(pGrid, COLUMN_T_MAL_KODU, pGrid.Row, TSatisTeklifDetay(TSatisTeklif(Table).ListDetay[n1]).StokKodu.Value);
    GridAddCell(pGrid, COLUMN_T_MAL_ADI, pGrid.Row, TSatisTeklifDetay(TSatisTeklif(Table).ListDetay[n1]).StokAciklama.Value);
    GridAddCell(pGrid, COLUMN_T_MIKTAR, pGrid.Row, TSatisTeklifDetay(TSatisTeklif(Table).ListDetay[n1]).Miktar.Value);
    GridAddCell(pGrid, COLUMN_T_BIRIM, pGrid.Row, TSatisTeklifDetay(TSatisTeklif(Table).ListDetay[n1]).OlcuBirimi.Value);
    GridAddCell(pGrid, COLUMN_T_KDV_ORANI, pGrid.Row, TSatisTeklifDetay(TSatisTeklif(Table).ListDetay[n1]).KdvOrani.Value);
    GridAddCell(pGrid, COLUMN_T_FIYAT, pGrid.Row, TSatisTeklifDetay(TSatisTeklif(Table).ListDetay[n1]).Fiyat.Value);
    GridAddCell(pGrid, COLUMN_T_ISKONTO_ORANI, pGrid.Row, TSatisTeklifDetay(TSatisTeklif(Table).ListDetay[n1]).IskontoOrani.Value);
    GridAddCell(pGrid, COLUMN_T_NET_FIYAT, pGrid.Row, TSatisTeklifDetay(TSatisTeklif(Table).ListDetay[n1]).NetFiyat.Value);
    GridAddCell(pGrid, COLUMN_T_TUTAR, pGrid.Row, TSatisTeklifDetay(TSatisTeklif(Table).ListDetay[n1]).Tutar.Value);
    GridAddCell(pGrid, COLUMN_T_NET_TUTAR, pGrid.Row, TSatisTeklifDetay(TSatisTeklif(Table).ListDetay[n1]).NetTutar.Value);
    GridAddCell(pGrid, COLUMN_T_REFERANS, pGrid.Row, TSatisTeklifDetay(TSatisTeklif(Table).ListDetay[n1]).Referans.Value);

    pGrid.Rows[n1].EndUpdate;
  end;

  inherited;
end;

procedure TfrmSatisTeklifDetaylar.FormCreate(Sender: TObject);
var
  n1: Integer;
begin
  TSatisTeklif(Table).TeklifNo.SetControlProperty(Table.TableName, edtTeklifNo);
  TSatisTeklif(Table).MusteriKodu.SetControlProperty(Table.TableName, edtMusteriKodu);
  TSatisTeklif(Table).MusteriAdi.SetControlProperty(Table.TableName, edtMusteriAdi);
  TSatisTeklif(Table).DolarKur.SetControlProperty(Table.TableName, edtDolarKuru);
  TSatisTeklif(Table).EuroKur.SetControlProperty(Table.TableName, edtEuroKuru);

  inherited;

  edtDolarKuru.thsDecimalDigit := 5;
  edtEuroKuru.thsDecimalDigit := 6;

  vFaturaTipi := TAyarEFaturaFaturaTipi.Create(Table.Database);
  vMusteriTemsilcisi := TPersonelKarti.Create(Table.Database);
  vTeklifDurum := TAyarTeklifDurum.Create(Table.Database);
  vTeklifTipi := TAyarTeklifTipi.Create(Table.Database);
  vOdemeBaslangicDonemi := TAyarOdemeBaslangicDonemi.Create(Table.Database);
  vPara := TParaBirimi.Create(Table.Database);

  vFaturaTipi.SelectToList('', False, False);
  cbbIslemTipi.Clear;
  for n1 := 0 to vFaturaTipi.List.Count-1 do
    cbbIslemTipi.AddItem(FormatedVariantVal(TAyarEFaturaFaturaTipi(vFaturaTipi.List[n1]).Tip.FieldType, TAyarEFaturaFaturaTipi(vFaturaTipi.List[n1]).Tip.Value), TAyarEFaturaFaturaTipi(vFaturaTipi.List[n1]));
  cbbIslemTipi.ItemIndex := -1;

  vTeklifDurum.SelectToList(' AND ' + vTeklifDurum.IsActive.FieldName + '=TRUE', False, False);
  cbbTeklifDurum.Clear;
  for n1 := 0 to vTeklifDurum.List.Count-1 do
    cbbTeklifDurum.AddItem(FormatedVariantVal(TAyarTeklifDurum(vTeklifDurum.List[n1]).Deger.FieldType, TAyarTeklifDurum(vTeklifDurum.List[n1]).Deger.Value), TAyarTeklifDurum(vTeklifDurum.List[n1]));
  cbbTeklifDurum.ItemIndex := -1;

  vTeklifTipi.SelectToList(' AND ' + vTeklifTipi.IsActive.FieldName + '=TRUE', False, False);
  cbbTeklifTipi.Clear;
  for n1 := 0 to vTeklifTipi.List.Count-1 do
    cbbTeklifTipi.AddItem(FormatedVariantVal(TAyarTeklifTipi(vTeklifTipi.List[n1]).Deger.FieldType, TAyarTeklifTipi(vTeklifTipi.List[n1]).Deger.Value), TAyarTeklifTipi(vTeklifTipi.List[n1]));
  cbbTeklifTipi.ItemIndex := -1;

  vOdemeBaslangicDonemi.SelectToList(' AND ' + vOdemeBaslangicDonemi.IsActive.FieldName + '=TRUE', False, False);
  cbbOdemeBaslangicDonemi.Clear;
  for n1 := 0 to vOdemeBaslangicDonemi.List.Count-1 do
    cbbOdemeBaslangicDonemi.AddItem(FormatedVariantVal(TAyarOdemeBaslangicDonemi(vOdemeBaslangicDonemi.List[n1]).Deger.FieldType, TAyarOdemeBaslangicDonemi(vOdemeBaslangicDonemi.List[n1]).Deger.Value), TAyarOdemeBaslangicDonemi(vOdemeBaslangicDonemi.List[n1]));
  cbbOdemeBaslangicDonemi.ItemIndex := -1;

  vPara.SelectToList('', False, False);
  cbbParaBirimi.Clear;
  for n1 := 0 to vPara.List.Count-1 do
    cbbParaBirimi.AddItem(FormatedVariantVal(TParaBirimi(vPara.List[n1]).Kod.FieldType, TParaBirimi(vPara.List[n1]).Kod.Value), TParaBirimi(vPara.List[n1]));
  cbbParaBirimi.ItemIndex := -1;

  ts1.Caption := 'Teklif Detaylarý';
  tsHeaderDiger.TabVisible := True;
end;

procedure TfrmSatisTeklifDetaylar.FormDestroy(Sender: TObject);
begin
  if Assigned(vFaturaTipi) then
    vFaturaTipi.Free;

  if Assigned(vMusteriTemsilcisi) then
    vMusteriTemsilcisi.Free;

  if Assigned(vTeklifDurum) then
    vTeklifDurum.Free;

  if Assigned(vTeklifTipi) then
    vTeklifTipi.Free;

  if Assigned(vOdemeBaslangicDonemi) then
    vOdemeBaslangicDonemi.Free;

  if Assigned(vPara) then
    vPara.Free;

  inherited;
end;

procedure TfrmSatisTeklifDetaylar.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmSatisTeklifDetaylar.GridReset(pGrid: TStringGrid);
begin
  inherited;
  pGrid.RowCount := 2;
  pGrid.ColCount := 12;
  pGrid.Rows[0].Text := '';
  pGrid.Rows[1].Text := '';

  GridColWidth(pGrid, 80, COLUMN_T_MAL_KODU);
  GridColWidth(pGrid, 150, COLUMN_T_MAL_ADI);
  GridColWidth(pGrid, 60, COLUMN_T_MIKTAR);
  GridColWidth(pGrid, 60, COLUMN_T_BIRIM);

  GridAddColTitle(pGrid, 'STOK KODU', COLUMN_T_MAL_KODU);
  GridAddColTitle(pGrid, 'AÇIKLAMA', COLUMN_T_MAL_ADI);
  GridAddColTitle(pGrid, 'MÝKTAR', COLUMN_T_MIKTAR);
  GridAddColTitle(pGrid, 'BÝRÝM', COLUMN_T_BIRIM);
  GridAddColTitle(pGrid, 'KDV', COLUMN_T_KDV_ORANI);
  GridAddColTitle(pGrid, 'FÝYAT', COLUMN_T_FIYAT);
  GridAddColTitle(pGrid, 'ÝSKONTO', COLUMN_T_ISKONTO_ORANI);
  GridAddColTitle(pGrid, 'NET FÝYAT', COLUMN_T_NET_FIYAT);
  GridAddColTitle(pGrid, 'TUTAR', COLUMN_T_TUTAR);
  GridAddColTitle(pGrid, 'NET TUTAR', COLUMN_T_NET_TUTAR);
  GridAddColTitle(pGrid, 'REFERANS', COLUMN_T_REFERANS);
end;

procedure TfrmSatisTeklifDetaylar.RefreshData;
begin
  inherited;

  cbbIslemTipi.ItemIndex := cbbIslemTipi.Items.IndexOf( FormatedVariantVal(TSatisTeklif(Table).IslemTipi.FieldType, TSatisTeklif(Table).IslemTipi.Value) );
  //vFaturaTipi.SelectToList(' AND ' + vFaturaTipi.TableName + '.' + vFaturaTipi.Id.FieldName + '=' + IntToStr(TSatisTeklif(Table).IslemTipiID.Value), False, False);

  edtMusteriKodu.Text := FormatedVariantVal(TSatisTeklif(Table).MusteriKodu.FieldType, TSatisTeklif(Table).MusteriKodu.Value);
  edtMusteriAdi.Text := FormatedVariantVal(TSatisTeklif(Table).MusteriAdi.FieldType, TSatisTeklif(Table).MusteriAdi.Value);
  edtTeklifNo.Text := FormatedVariantVal(TSatisTeklif(Table).TeklifNo.FieldType, TSatisTeklif(Table).TeklifNo.Value);

  if TSatisTeklif(Table).TeklifTarihi.Value > 0 then
    edtTeklifTarihi.Text := FormatedVariantVal(TSatisTeklif(Table).TeklifTarihi.FieldType, TSatisTeklif(Table).TeklifTarihi.Value)
  else
    edtTeklifTarihi.Clear;

  if TSatisTeklif(Table).TeslimTarihi.Value > 0 then
    edtTeslimTarihi.Text := FormatedVariantVal(TSatisTeklif(Table).TeslimTarihi.FieldType, TSatisTeklif(Table).TeslimTarihi.Value)
  else
    edtTeslimTarihi.Clear;
  if TSatisTeklif(Table).GecerlilikTarihi.Value > 0 then
    edtGecerlilikTarihi.Text := FormatedVariantVal(TSatisTeklif(Table).GecerlilikTarihi.FieldType, TSatisTeklif(Table).GecerlilikTarihi.Value)
  else
    edtGecerlilikTarihi.Clear;
  edtAdresMusteri.Text := FormatedVariantVal(TSatisTeklif(Table).AdresMusteri.FieldType, TSatisTeklif(Table).AdresMusteri.Value);
  edtSehirMusteri.Text := FormatedVariantVal(TSatisTeklif(Table).SehirMusteri.FieldType, TSatisTeklif(Table).SehirMusteri.Value);
  edtVergiDairesi.Text := FormatedVariantVal(TSatisTeklif(Table).VergiDairesi.FieldType, TSatisTeklif(Table).VergiDairesi.Value);
  edtVergiNo.Text := FormatedVariantVal(TSatisTeklif(Table).VergiNo.FieldType, TSatisTeklif(Table).VergiNo.Value);

  cbbMusteriTemsilci.ItemIndex := cbbMusteriTemsilci.Items.IndexOf( FormatedVariantVal(TSatisTeklif(Table).MusteriTemsilcisi.FieldType, TSatisTeklif(Table).MusteriTemsilcisi.Value) );
  //vMusteriTemsilcisi.SelectToList(' AND ' + vMusteriTemsilcisi.TableName + '.' + vMusteriTemsilcisi.Id.FieldName + '=' + IntToStr(TSatisTeklif(Table).MusteriTemsilcisiID.Value), False, False);

  cbbTeklifTipi.ItemIndex := cbbTeklifTipi.Items.IndexOf( FormatedVariantVal(TSatisTeklif(Table).TeklifTipi.FieldType, TSatisTeklif(Table).TeklifTipi.Value) );
  //vTeklifTipi.SelectToList(' AND ' + vTeklifTipi.TableName + '.' + vTeklifTipi.Id.FieldName + '=' + IntToStr(TSatisTeklif(Table).TeklifTipiID.Value), False, False);

  edtAdresSevkiyat.Text := FormatedVariantVal(TSatisTeklif(Table).AdresSevkiyat.FieldType, TSatisTeklif(Table).AdresSevkiyat.Value);
  edtSehirSevkiyat.Text := FormatedVariantVal(TSatisTeklif(Table).SehirSevkiyat.FieldType, TSatisTeklif(Table).SehirSevkiyat.Value);
  edtOdemeVadesi.Text := FormatedVariantVal(TSatisTeklif(Table).OdemeVadesi.FieldType, TSatisTeklif(Table).OdemeVadesi.Value);
  edtTeslimatSuresi.Text := FormatedVariantVal(TSatisTeklif(Table).TeslimatSuresi.FieldType, TSatisTeklif(Table).TeslimatSuresi.Value);
  if TSatisTeklif(Table).SevkTarihi.Value > 0 then
    edtSevkTarihi.Text := FormatedVariantVal(TSatisTeklif(Table).SevkTarihi.FieldType, TSatisTeklif(Table).SevkTarihi.Value)
  else
    edtSevkTarihi.Clear;
  edtFaturaSevkTarihi.Text := FormatedVariantVal(TSatisTeklif(Table).FaturaSevkTarihi.FieldType, TSatisTeklif(Table).FaturaSevkTarihi.Value);
  edtMuhattapAd.Text := FormatedVariantVal(TSatisTeklif(Table).MuhattapAd.FieldType, TSatisTeklif(Table).MuhattapAd.Value);
  edtMuhattapSoyad.Text := FormatedVariantVal(TSatisTeklif(Table).MuhattapSoyad.FieldType, TSatisTeklif(Table).MuhattapSoyad.Value);
  edtReferans.Text := FormatedVariantVal(TSatisTeklif(Table).Referans.FieldType, TSatisTeklif(Table).Referans.Value);

  cbbTeklifDurum.ItemIndex := cbbTeklifDurum.Items.IndexOf( FormatedVariantVal(TSatisTeklif(Table).TeklifDurum.FieldType, TSatisTeklif(Table).TeklifDurum.Value) );
  //vTeklifDurum.SelectToList(' AND ' + vTeklifDurum.TableName + '.' + vTeklifDurum.Id.FieldName + '=' + IntToStr(TSatisTeklif(Table).TeklifDurumID.Value), False, False);

  cbbParaBirimi.ItemIndex := cbbParaBirimi.Items.IndexOf( FormatedVariantVal(TSatisTeklif(Table).ParaBirimi.FieldType, TSatisTeklif(Table).ParaBirimi.Value) );
  edtDolarKuru.Text := FormatedVariantVal(TSatisTeklif(Table).DolarKur.FieldType, TSatisTeklif(Table).DolarKur.Value);
  edtEuroKuru.Text := FormatedVariantVal(TSatisTeklif(Table).EuroKur.FieldType, TSatisTeklif(Table).EuroKur.Value);

  edtVadeGunSayisi.Text := FormatedVariantVal(TSatisTeklif(Table).VadeGunSayisi.FieldType, TSatisTeklif(Table).VadeGunSayisi.Value);
  edtOrtakKdv.Text := FormatedVariantVal(TSatisTeklif(Table).OrtakKDV.FieldType, TSatisTeklif(Table).OrtakKDV.Value);
  edtOrtakIskonto.Text := FormatedVariantVal(TSatisTeklif(Table).OrtakIskonto.FieldType, TSatisTeklif(Table).OrtakIskonto.Value);





  edtPostaKodu.Text := FormatedVariantVal(TSatisTeklif(Table).PostaKodu.FieldType, TSatisTeklif(Table).PostaKodu.Value);
  cbbOdemeBaslangicDonemi.ItemIndex := cbbOdemeBaslangicDonemi.Items.IndexOf( FormatedVariantVal(TSatisTeklif(Table).OdemeBaslangicDonemi.FieldType, TSatisTeklif(Table).OdemeBaslangicDonemi.Value) );
  //vOdemeBaslangicDonemi.SelectToList(' AND ' + vOdemeBaslangicDonemi.TableName + '.' + vOdemeBaslangicDonemi.Id.FieldName + '=' + IntToStr(TSatisTeklif(Table).OdemeBaslangicDonemiID.Value), False, False);

//  cbbTeslimSarti.Text := FormatedVariantVal(TSatisTeklif(Table).TeslimSarti.FieldType, TSatisTeklif(Table).TeslimSarti.Value);
//  cbbGonderimSekli.Text := FormatedVariantVal(TSatisTeklif(Table).GonderimSekli.FieldType, TSatisTeklif(Table).GonderimSekli.Value);
//  edtGonderimSekliDetaylari.Text := FormatedVariantVal(TSatisTeklif(Table).GonderimSekliDetaylari.FieldType, TSatisTeklif(Table).GonderimSekliDetaylari.Value);
//  cbbOdemeSekli.Text := FormatedVariantVal(TSatisTeklif(Table).OdemeSekli.FieldType, TSatisTeklif(Table).OdemeSekli.Value);
  edtAciklama.Text := FormatedVariantVal(TSatisTeklif(Table).Aciklama.FieldType, TSatisTeklif(Table).Aciklama.Value);

  GridFill(strngrd1);
end;

procedure TfrmSatisTeklifDetaylar.HelperProcess(Sender: TObject);
//var
//  vHelperStokGrubu: TfrmHelperStokGrubu;
begin
  if Sender.ClassType = TCombobox then
  begin
//    if TthsCombobox(Sender).Name = cbbIslemTipi.Name then
//    begin
//      vHelperStokGrubu := TfrmHelperStokGrubu.Create(cbbIslemTipi, Self, TAyarEFaturaFaturaTipi.Create(Table.Database), True, ifmNone, fomNormal);
//      try
//        vHelperStokGrubu.ShowModal;
//
//        if Assigned(vFaturaTipi) then
//          vFaturaTipi.Free;
//
//        vFaturaTipi := TAyarEFaturaFaturaTipi(TAyarEFaturaFaturaTipi(vHelperStokGrubu.Table).Clone);
//        lblValGroupName.Caption := vStokGrubu.Grup.Value;
//      finally
//        vHelperStokGrubu.Free;
//      end;
//    end
  end
  else
  if Sender.ClassType = TEdit then
  begin

  end;
end;

end.
