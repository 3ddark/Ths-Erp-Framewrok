unit ufrmSatisTeklifDetaylar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBaseDetaylar, Vcl.Menus,
  Vcl.AppEvnts, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  AdvUtil, AdvObj, AdvGrid,
  thsEdit, thsComboBox,

  ufrmBase,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.SatisTeklif,
  Ths.Erp.Database.Table.SatisTeklifDetay,
  Ths.Erp.Database.Table.AyarEFaturaFaturaTipi,
  Ths.Erp.Database.Table.PersonelKarti,
  Ths.Erp.Database.Table.AyarTeklifDurum, Vcl.Samples.Spin;

const
  COLUMN_T_IS_STOKKODLU        = 1;
  COLUMN_T_IS_TRANSFERKODLU    = 2;
  COLUMN_T_MAL_KODU            = 3;
  COLUMN_T_MAL_ADI             = 4;
  COLUMN_T_MIKTAR              = 5;
  COLUMN_T_MIKTAR_GIDEN        = 6;
  COLUMN_T_MIKTAR_BEKLEYEN     = 7;
  COLUMN_T_BIRIM               = 8;
  COLUMN_T_KDV_ORANI           = 9;
  COLUMN_T_FIYAT               = 10;
  COLUMN_T_ISKONTO_ORANI       = 11;
  COLUMN_T_NET_FIYAT           = 12;
  COLUMN_T_TUTAR               = 13;
  COLUMN_T_NET_TUTAR           = 14;
  COLUMN_T_ISKONTO_TUTAR       = 15;
  COLUMN_T_KDV_TUTAR           = 16;
  COLUMN_T_ACIKLAMA_KULLANICI  = 17;
  COLUMN_T_REFERANS            = 18;
  COLUMN_T_M2                  = 19;

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
    cbbIslemTipi: TthsCombobox;
    edtMusteriKodu: TthsEdit;
    edtMusteriAdi: TthsEdit;
    edtTeklifNo: TthsEdit;
    edtTeklifTarihi: TthsEdit;
    cbbTeklifDurum: TthsCombobox;
    edtTeslimTarihi: TthsEdit;
    edtAdresMusteri: TthsEdit;
    edtSehirMusteri: TthsEdit;
    edtPostaKodu: TthsEdit;
    edtVergiDairesi: TthsEdit;
    edtVergiNo: TthsEdit;
    cbbMusteriTemsilci: TthsCombobox;
    cbbTeklifTipi: TthsCombobox;
    edtAdresSevkiyat: TthsEdit;
    edtSehirSevkiyat: TthsEdit;
    edtMuhattapAd: TthsEdit;
    edtReferans: TthsEdit;
    edtOrtakKdv: TthsEdit;
    edtOrtakIskonto: TthsEdit;
    edtVadeGunSayisi: TthsEdit;
    cbbParaBirimi: TthsCombobox;
    edtDolarKuru: TthsEdit;
    edtEuroKuru: TthsEdit;
    edtOdemeVadesi: TthsEdit;
    edtTeslimatSuresi: TthsEdit;
    edtSevkTarihi: TthsEdit;
    edtFaturaSevkTarihi: TthsEdit;
    cbbOdemeBaslangicDonemi: TthsCombobox;
    cbbTeslimSarti: TthsCombobox;
    cbbGonderimSekli: TthsCombobox;
    edtGonderimSekliDetaylari: TthsEdit;
    cbbOdemeSekli: TthsCombobox;
    edtAciklama: TthsEdit;
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
    edtMuhattapSoyad: TthsEdit;
    lblGecerlilikTarihi: TLabel;
    edtGecerlilikTarihi: TthsEdit;
    procedure btnAddDetailClick(Sender: TObject);
    procedure btnAcceptClick(Sender: TObject);override;
  private
    vFaturaTipi: TAyarEFaturaFaturaTipi;
    vMusteriTemsilcisi: TPersonelKarti;
    vTeklifDurum: TAyarTeklifDurum;
  protected
    procedure GridReset; override;
    procedure GridFill; override;
    { Private declarations }
  public
    procedure GridAddRow(pGrid: TStringGrid; pTable: TTable = nil); override;
    procedure RefreshData; override;
  published
    procedure FormCreate(Sender: TObject); override;
    procedure FormShow(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject); override;
    procedure HelperProcess(Sender: TObject);
  end;

implementation

uses
  ufrmSatisTeklifDetay;

{$R *.dfm}

{ TfrmTeklifDetaylar }

procedure TfrmSatisTeklifDetaylar.GridAddRow(pGrid: TStringGrid; pTable: TTable);
begin
  inherited;
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
      TSatisTeklif(Table).TeklifNo.Value := edtTeklifNo.Text;
      TSatisTeklif(Table).MusteriKodu.Value := edtMusteriKodu.Text;
      TSatisTeklif(Table).MusteriAdi.Value := edtMusteriAdi.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

procedure TfrmSatisTeklifDetaylar.btnAddDetailClick(Sender: TObject);
begin
  inherited;
  TfrmSatisTeklifDetay.Create(Self, Self, TSatisTeklifDetay.Create(Table.Database), True, ifmNewRecord, FormOndalikMod).Show;
end;

procedure TfrmSatisTeklifDetaylar.GridFill;
var
  n1: Integer;
begin
  GridReset;
  for n1 := 0 to 10 do
  begin
    GridAddRow(strngrd1, Table);
    GridAddCell(strngrd1, COLUMN_T_MAL_KODU, strngrd1.Row, '42CA07LS');
    GridAddCell(strngrd1, COLUMN_T_MAL_ADI, strngrd1.Row, 'ÇÝFT HIZLI 7KW LG KUMANDA TABLOSU');
    GridAddCell(strngrd1, COLUMN_T_MIKTAR, strngrd1.Row, (n1*n1).ToString);
    GridAddCell(strngrd1, COLUMN_T_BIRIM, strngrd1.Row, 'ADET');

    GridIncRow(strngrd1);
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

  inherited;

  vFaturaTipi := TAyarEFaturaFaturaTipi.Create(Table.Database);
  vMusteriTemsilcisi := TPersonelKarti.Create(Table.Database);
  vTeklifDurum := TAyarTeklifDurum.Create(Table.Database);


  vFaturaTipi.SelectToList('', False, False);
  cbbIslemTipi.Clear;
  for n1 := 0 to vFaturaTipi.List.Count-1 do
    cbbIslemTipi.AddItem(FormatedVariantVal(TAyarEFaturaFaturaTipi(vFaturaTipi.List[n1]).Tip.FieldType, TAyarEFaturaFaturaTipi(vFaturaTipi.List[n1]).Tip.Value), TAyarEFaturaFaturaTipi(vFaturaTipi.List[n1]));
  cbbIslemTipi.ItemIndex := -1;

  vTeklifDurum.SelectToList('', False, False);
  cbbTeklifDurum.Clear;
  for n1 := 0 to vTeklifDurum.List.Count-1 do
    cbbTeklifDurum.AddItem(FormatedVariantVal(TAyarTeklifDurum(vTeklifDurum.List[n1]).Deger.FieldType, TAyarTeklifDurum(vFaturaTipi.List[n1]).Deger.Value), TAyarTeklifDurum(vTeklifDurum.List[n1]));
  cbbTeklifDurum.ItemIndex := -1;


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

  inherited;
end;

procedure TfrmSatisTeklifDetaylar.FormShow(Sender: TObject);
begin
  inherited;
end;

procedure TfrmSatisTeklifDetaylar.GridReset;
begin
  inherited;
  strngrd1.RowCount := 2;
  strngrd1.ColCount := 20;

  GridColWidth(strngrd1, 80, COLUMN_T_MAL_KODU);
  GridColWidth(strngrd1, 150, COLUMN_T_MAL_ADI);
  GridColWidth(strngrd1, 60, COLUMN_T_MIKTAR);
  GridColWidth(strngrd1, 60, COLUMN_T_BIRIM);

  strngrd1.Row := 1;
  GridAddColTitle(strngrd1, 'STOK KODU', COLUMN_T_MAL_KODU);
  GridAddColTitle(strngrd1, 'AÇIKLAMA', COLUMN_T_MAL_ADI);
  GridAddColTitle(strngrd1, 'MÝKTAR', COLUMN_T_MIKTAR);

//  IncRow(strngrd1);
end;

procedure TfrmSatisTeklifDetaylar.RefreshData;
begin
  cbbIslemTipi.Text := FormatedVariantVal(TSatisTeklif(Table).IslemTipi.FieldType, TSatisTeklif(Table).IslemTipi.Value);
  edtMusteriKodu.Text := FormatedVariantVal(TSatisTeklif(Table).MusteriKodu.FieldType, TSatisTeklif(Table).MusteriKodu.Value);
  edtMusteriAdi.Text := FormatedVariantVal(TSatisTeklif(Table).MusteriAdi.FieldType, TSatisTeklif(Table).MusteriAdi.Value);
  edtTeklifNo.Text := FormatedVariantVal(TSatisTeklif(Table).TeklifNo.FieldType, TSatisTeklif(Table).TeklifNo.Value);
  edtTeklifTarihi.Text := FormatedVariantVal(TSatisTeklif(Table).TeklifTarihi.FieldType, TSatisTeklif(Table).TeklifTarihi.Value);

  cbbTeklifDurum.Text := FormatedVariantVal(TSatisTeklif(Table).TeklifDurum.FieldType, TSatisTeklif(Table).TeklifDurum.Value);
  vTeklifDurum.SelectToList(' AND ' + vTeklifDurum.TableName + '.' + vTeklifDurum.Id.FieldName + '=' + IntToStr(TSatisTeklif(Table).TeklifDurumID.Value), False, False);

  edtTeslimTarihi.Text := FormatedVariantVal(TSatisTeklif(Table).TeslimTarihi.FieldType, TSatisTeklif(Table).TeslimTarihi.Value);
  edtAdresMusteri.Text := FormatedVariantVal(TSatisTeklif(Table).AdresMusteri.FieldType, TSatisTeklif(Table).AdresMusteri.Value);
  edtSehirMusteri.Text := FormatedVariantVal(TSatisTeklif(Table).SehirMusteri.FieldType, TSatisTeklif(Table).SehirMusteri.Value);
  edtPostaKodu.Text := FormatedVariantVal(TSatisTeklif(Table).PostaKodu.FieldType, TSatisTeklif(Table).PostaKodu.Value);
  edtVergiDairesi.Text := FormatedVariantVal(TSatisTeklif(Table).VergiDairesi.FieldType, TSatisTeklif(Table).VergiDairesi.Value);
  edtVergiNo.Text := FormatedVariantVal(TSatisTeklif(Table).VergiNo.FieldType, TSatisTeklif(Table).VergiNo.Value);

  cbbMusteriTemsilci.Text := FormatedVariantVal(TSatisTeklif(Table).MusteriTemsilcisi.FieldType, TSatisTeklif(Table).MusteriTemsilcisi.Value);
  vMusteriTemsilcisi.SelectToList(' AND ' + vMusteriTemsilcisi.TableName + '.' + vMusteriTemsilcisi.Id.FieldName + '=' + IntToStr(TSatisTeklif(Table).MusteriTemsilcisiID.Value), False, False);

  cbbTeklifTipi.Text := FormatedVariantVal(TSatisTeklif(Table).TeklifTipi.FieldType, TSatisTeklif(Table).TeklifTipi.Value);
  edtAdresSevkiyat.Text := FormatedVariantVal(TSatisTeklif(Table).AdresSevkiyat.FieldType, TSatisTeklif(Table).AdresSevkiyat.Value);
  edtSehirSevkiyat.Text := FormatedVariantVal(TSatisTeklif(Table).SehirSevkiyat.FieldType, TSatisTeklif(Table).SehirSevkiyat.Value);
  edtReferans.Text := FormatedVariantVal(TSatisTeklif(Table).Referans.FieldType, TSatisTeklif(Table).Referans.Value);
  edtMuhattapAd.Text := FormatedVariantVal(TSatisTeklif(Table).MuhattapAd.FieldType, TSatisTeklif(Table).MuhattapAd.Value);
  edtMuhattapSoyad.Text := FormatedVariantVal(TSatisTeklif(Table).MuhattapSoyad.FieldType, TSatisTeklif(Table).MuhattapSoyad.Value);
//  edtOrtakKdv.Text := FormatedVariantVal(TSatisTeklif(Table).OrtakKDV.FieldType, TSatisTeklif(Table).OrtakKDV.Value);
  cbbParaBirimi.Text := FormatedVariantVal(TSatisTeklif(Table).ParaBirimi.FieldType, TSatisTeklif(Table).ParaBirimi.Value);
//  edtOdemeVadesi.Text := FormatedVariantVal(TSatisTeklif(Table).OdemeVadesi.FieldType, TSatisTeklif(Table).OdemeVadesi.Value);
  edtOrtakIskonto.Text := FormatedVariantVal(TSatisTeklif(Table).OrtakIskonto.FieldType, TSatisTeklif(Table).OrtakIskonto.Value);
  edtDolarKuru.Text := FormatedVariantVal(TSatisTeklif(Table).DolarKur.FieldType, TSatisTeklif(Table).DolarKur.Value);
  edtTeslimatSuresi.Text := FormatedVariantVal(TSatisTeklif(Table).TeslimatSuresi.FieldType, TSatisTeklif(Table).TeslimatSuresi.Value);
  edtVadeGunSayisi.Text := FormatedVariantVal(TSatisTeklif(Table).VadeGunSayisi.FieldType, TSatisTeklif(Table).VadeGunSayisi.Value);
  edtEuroKuru.Text := FormatedVariantVal(TSatisTeklif(Table).EuroKur.FieldType, TSatisTeklif(Table).EuroKur.Value);
//  edtSevkTarihi.Text := FormatedVariantVal(TSatisTeklif(Table).SevkTarihi.FieldType, TSatisTeklif(Table).SevkTarihi.Value);
//  edtFaturaSevkTarihi.Text := FormatedVariantVal(TSatisTeklif(Table).FaturaSevkTarihi.FieldType, TSatisTeklif(Table).FaturaSevkTarihi.Value);
//  cbbOdemeBaslangicDonemi.Text := FormatedVariantVal(TSatisTeklif(Table).OdemeBaslangicDonemi.FieldType, TSatisTeklif(Table).OdemeBaslangicDonemi.Value);
//  cbbTeslimSarti.Text := FormatedVariantVal(TSatisTeklif(Table).TeslimSarti.FieldType, TSatisTeklif(Table).TeslimSarti.Value);
//  cbbGonderimSekli.Text := FormatedVariantVal(TSatisTeklif(Table).GonderimSekli.FieldType, TSatisTeklif(Table).GonderimSekli.Value);
//  edtGonderimSekliDetaylari.Text := FormatedVariantVal(TSatisTeklif(Table).GonderimSekliDetaylari.FieldType, TSatisTeklif(Table).GonderimSekliDetaylari.Value);
//  cbbOdemeSekli.Text := FormatedVariantVal(TSatisTeklif(Table).OdemeSekli.FieldType, TSatisTeklif(Table).OdemeSekli.Value);
  edtAciklama.Text := FormatedVariantVal(TSatisTeklif(Table).Aciklama.FieldType, TSatisTeklif(Table).Aciklama.Value);

  GridFill;
end;

procedure TfrmSatisTeklifDetaylar.HelperProcess(Sender: TObject);
//var
//  vHelperStokGrubu: TfrmHelperStokGrubu;
begin
  if Sender.ClassType = TthsCombobox then
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
  if Sender.ClassType = TthsEdit then
  begin

  end;
end;

end.
