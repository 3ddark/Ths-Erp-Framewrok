unit ufrmStokKarti;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Grids, Vcl.Samples.Spin,
  Vcl.Menus, Vcl.AppEvnts,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Constants,
  Ths.Erp.Database.Table.StokKarti,
  Ths.Erp.Database.Table.OlcuBirimi,
  Ths.Erp.Database.Table.AyarStkStokGrubu,
  Ths.Erp.Database.Table.ParaBirimi,
  Ths.Erp.Database.Table.AyarStkCinsOzelligi,
  Ths.Erp.Database.Table.AyarBarkodSeriNoTuru,
  Ths.Erp.Database.Table.SysCountry;

type
  TfrmStokKarti = class(TfrmBaseInputDB)
    lblOrtalamaMaliyetBirim: TLabel;
    lblstok_kodu: TLabel;
    lblstok_adi: TLabel;
    lblstok_grubu_id: TLabel;
    lblolcu_birimi_id: TLabel;
    lblen_az_stok_seviyesi: TLabel;
    lblpaket_miktari: TLabel;
    lbllot_parti_miktari: TLabel;
    lblalis_iskonto: TLabel;
    lblsatis_iskonto: TLabel;
    lblyetkili_iskonto: TLabel;
    lblsatis_fiyat: TLabel;
    lblalis_fiyat: TLabel;
    lblham_alis_fiyat: TLabel;
    lblihrac_fiyat: TLabel;
    lblortalama_maliyet: TLabel;
    lblis_satilabilir: TLabel;
    lblIsOzetUrun: TLabel;
    lblozel_kod: TLabel;
    lblvarsayilan_recete_id: TLabel;
    lbltasiyici_paket_id: TLabel;
    lbltanim: TLabel;
    btnReceteyeGit: TButton;
    btnTasiyiciPaketeGit: TButton;
    tsCinsOzelligi: TTabSheet;
    lbldouble_degisken3: TLabel;
    lbldouble_degisken2: TLabel;
    lbldouble_degisken1: TLabel;
    lblinteger_degisken3: TLabel;
    lblinteger_degisken2: TLabel;
    lblinteger_degisken1: TLabel;
    lblstring_degisken6: TLabel;
    lblstring_degisken5: TLabel;
    lblstring_degisken4: TLabel;
    lblstring_degisken3: TLabel;
    lblstring_degisken2: TLabel;
    lblstring_degisken1: TLabel;
    lblcins_id: TLabel;
    lblmarka: TLabel;
    lblagirlik: TLabel;
    lblkapasite: TLabel;
    tsDiger: TTabSheet;
    lblseri_no_turu: TLabel;
    lblis_harici_seri_no_icerir: TLabel;
    lblharici_serino_stok_kodu_id: TLabel;
    lblonceki_donem_cikan_miktar: TLabel;
    lbltemin_suresi: TLabel;
    lbldiib_urun_tanimi: TLabel;
    tsOzetler: TTabSheet;
    pnlOzetHeader: TPanel;
    pnlOzetTop: TPanel;
    lblSerbestStokBirim: TLabel;
    lblSerbestStokToplam: TLabel;
    lblBlokajBirim: TLabel;
    lblBlokajToplam: TLabel;
    lblDonemBasiBirim: TLabel;
    lblGirenToplamBirim: TLabel;
    lblCikanToplamBirim: TLabel;
    lblStokMiktariBirim: TLabel;
    LabelStokMiktari: TLabel;
    LabelCikanToplam: TLabel;
    LabelGirenToplam: TLabel;
    LabelDonemBasiMiktar: TLabel;
    EditDonemBasiMiktar: TEdit;
    EditGirenToplam: TEdit;
    EditCikanToplam: TEdit;
    EditStokMiktari: TEdit;
    edtBlokajToplam: TEdit;
    edtSerbestStokToplam: TEdit;
    pnlOzetMiddle: TPanel;
    lblStokDegeriOrtPara: TLabel;
    lblStokDegeriSonPara: TLabel;
    lblDonemBasiDegerPara: TLabel;
    LabelStokDegeri2: TLabel;
    LabelStokDegeri1: TLabel;
    LabelDonemBasiDeger: TLabel;
    lblDonemBasiFiyatPara: TLabel;
    lblToplamAlisPara: TLabel;
    lblToplamSatisPara: TLabel;
    LabelToplamSatis: TLabel;
    LabelToplamAlis: TLabel;
    LabelDonemBasiFiyat: TLabel;
    EditDonemBasiFiyat: TEdit;
    EditDonembasiDeger: TEdit;
    EditStokDegerOrt: TEdit;
    EditStokDegerSon: TEdit;
    EditToplamAlis: TEdit;
    EditToplamSatis: TEdit;
    pnlOzetBottom: TPanel;
    lblSonAlisFiyatiPara: TLabel;
    lblAlisPara: TLabel;
    lblOrtalamaMaliyetPara: TLabel;
    lblSatisPara: TLabel;
    LabelSonAlisFiyati: TLabel;
    LabelOzetOrtalamaMaliyet: TLabel;
    LabelOzetAlis: TLabel;
    LabelOzetSatis: TLabel;
    EditOzetSatis: TEdit;
    EditOzetAlis: TEdit;
    EditOzetOrtalamaMaliyet: TEdit;
    EditSonAlisFiyati: TEdit;
    tsGrupOzellikleri: TTabSheet;
    chkis_harici_seri_no_icerir: TCheckBox;
    edtharici_serino_stok_kodu_id: TEdit;
    edtdiib_urun_tanimi: TEdit;
    edtonceki_donem_cikan_miktar: TEdit;
    edttemin_suresi: TEdit;
    pnlGrupHeader: TPanel;
    pnlGrupOzellikleri: TPanel;
    lblGrupAlimHesabi: TLabel;
    lblGrupSatimHesabi: TLabel;
    lblGrupHammaddeHesabi: TLabel;
    lblGrupMamaulHesabi: TLabel;
    lblValGrupAlimHesabi: TLabel;
    lblValGrupSatimHesabi: TLabel;
    lblValGrupHammaddeHesabi: TLabel;
    lblValGrupMamaulHesabi: TLabel;
    lblValGroupName: TLabel;
    lblGrupKDVOrani: TLabel;
    lblValGrupKDVOrani: TLabel;
    pnlAmbar: TPanel;
    lblAmbarlar: TLabel;
    strngrdAmbar: TStringGrid;
    edtcins_id: TEdit;
    edtmarka: TEdit;
    edtagirlik: TEdit;
    edtkapasite: TEdit;
    edtstring_degisken1: TEdit;
    edtstring_degisken2: TEdit;
    edtstring_degisken3: TEdit;
    edtstring_degisken4: TEdit;
    edtstring_degisken5: TEdit;
    edtstring_degisken6: TEdit;
    edtinteger_degisken1: TEdit;
    edtinteger_degisken2: TEdit;
    edtinteger_degisken3: TEdit;
    edtdouble_degisken1: TEdit;
    edtdouble_degisken2: TEdit;
    edtdouble_degisken3: TEdit;
    imgStokResim: TImage;
    btnResimEkleDil: TButton;
    edtstok_kodu: TEdit;
    edtstok_adi: TEdit;
    edtolcu_birimi_id: TEdit;
    edten_az_stok_seviyesi: TEdit;
    edtpaket_miktari: TEdit;
    edtlot_parti_miktari: TEdit;
    edtalis_iskonto: TEdit;
    edtsatis_iskonto: TEdit;
    edtyetkili_iskonto: TEdit;
    edtsatis_fiyat: TEdit;
    cbbsatis_para_birim: TComboBox;
    edtalis_fiyat: TEdit;
    cbbalis_para_birim: TComboBox;
    edtham_alis_fiyat: TEdit;
    cbbham_alis_para_birim: TComboBox;
    edtihrac_fiyat: TEdit;
    cbbihrac_para_birim: TComboBox;
    edtortalama_maliyet: TEdit;
    edtozel_kod: TEdit;
    chkis_satilabilir: TCheckBox;
    chkIsOzetUrun: TCheckBox;
    cbbtasiyici_paket_id: TComboBox;
    mmotanim: TMemo;
    pnlCins: TPanel;
    edtstok_grubu_id: TEdit;
    edtvarsayilan_recete_id: TEdit;
    lblurun_tipi: TLabel;
    edturun_tipi: TEdit;
    lblmensei_id: TLabel;
    lblgtip_no: TLabel;
    edtgtip_no: TEdit;
    edtmensei_id: TEdit;
    lblen: TLabel;
    lblboy: TLabel;
    lblyukseklik: TLabel;
    lblHacim: TLabel;
    lblValueHacim: TLabel;
    LabelEnBoyYuseklikBirim: TLabel;
    edten: TEdit;
    edtboy: TEdit;
    edtyukseklik: TEdit;
    edtseri_no_turu: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure btnReceteyeGitClick(Sender: TObject);
    procedure btnTasiyiciPaketeGitClick(Sender: TObject);
    procedure edtcins_idChange(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
    procedure edtstok_grubu_idChange(Sender: TObject);
  private
//    vOlcuBirimi: TOlcuBirimi;
//    vStokGrubu: TStokGrubu;
    vParaBirimi: TParaBirimi;
//    vBarkodSeriNoTuru: TAyarBarkodSeriNoTuru;
//    vStokKarti: TStokKarti;
  public
  protected
  published
    procedure FormDestroy(Sender: TObject); override;
    procedure FormShow(Sender: TObject); override;
    procedure HelperProcess(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmHelperOlcuBirimi,
  ufrmHelperStokGrubu,
  ufrmHelperStokKarti,
  ufrmHelperCinsOzellikleri,
  ufrmHelperSysCountry;

{$R *.dfm}

procedure TfrmStokKarti.btnReceteyeGitClick(Sender: TObject);
begin
  ShowMessage('reçete detaylar ekranýný gösterecek');
end;

procedure TfrmStokKarti.btnTasiyiciPaketeGitClick(Sender: TObject);
begin
  ShowMessage('Taþýyýcý Paket detaylar ekranýný gösterecek');
end;

procedure TfrmStokKarti.edtcins_idChange(Sender: TObject);
begin
  lblstring_degisken1.Visible := False;
  lblstring_degisken2.Visible := False;
  lblstring_degisken3.Visible := False;
  lblstring_degisken4.Visible := False;
  lblstring_degisken5.Visible := False;
  lblstring_degisken6.Visible := False;
  lblinteger_degisken1.Visible := False;
  lblinteger_degisken2.Visible := False;
  lblinteger_degisken3.Visible := False;
  lbldouble_degisken1.Visible := False;
  lbldouble_degisken2.Visible := False;
  lbldouble_degisken3.Visible := False;

  edtstring_degisken1.Visible := False;
  edtstring_degisken2.Visible := False;
  edtstring_degisken3.Visible := False;
  edtstring_degisken4.Visible := False;
  edtstring_degisken5.Visible := False;
  edtstring_degisken6.Visible := False;
  edtinteger_degisken1.Visible := False;
  edtinteger_degisken2.Visible := False;
  edtinteger_degisken3.Visible := False;
  edtdouble_degisken1.Visible := False;
  edtdouble_degisken2.Visible := False;
  edtdouble_degisken3.Visible := False;

  if Assigned(TStokKarti(Table).CinsID.FK.FKTable) then
  begin
    if TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String1.Value <> '' then
    begin
      lblstring_degisken1.Visible := True;
      edtstring_degisken1.Visible := True;
    end;
    if TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String2.Value <> '' then
    begin
      lblstring_degisken2.Visible := True;
      edtstring_degisken2.Visible := True;
    end;
    if TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String3.Value <> '' then
    begin
      lblstring_degisken3.Visible := True;
      edtstring_degisken3.Visible := True;
    end;
    if TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String4.Value <> '' then
    begin
      lblstring_degisken4.Visible := True;
      edtstring_degisken4.Visible := True;
    end;
    if TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String5.Value <> '' then
    begin
      lblstring_degisken5.Visible := True;
      edtstring_degisken5.Visible := True;
    end;
    if TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String6.Value <> '' then
    begin
      lblstring_degisken6.Visible := True;
      edtstring_degisken6.Visible := True;
    end;

    if TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String7.Value <> '' then
    begin
      lblinteger_degisken1.Visible := True;
      edtinteger_degisken1.Visible := True;
    end;
    if TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String8.Value <> '' then
    begin
      lblinteger_degisken2.Visible := True;
      edtinteger_degisken2.Visible := True;
    end;
    if TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String9.Value <> '' then
    begin
      lblinteger_degisken3.Visible := True;
      edtinteger_degisken3.Visible := True;
    end;

    if TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String10.Value <> '' then
    begin
      lbldouble_degisken1.Visible := True;
      edtdouble_degisken1.Visible := True;
    end;
    if TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String11.Value <> '' then
    begin
      lbldouble_degisken2.Visible := True;
      edtdouble_degisken2.Visible := True;
    end;
    if TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String12.Value <> '' then
    begin
      lbldouble_degisken3.Visible := True;
      edtdouble_degisken3.Visible := True;
    end;

    lblstring_degisken1.Caption := TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String1.Value;
    lblstring_degisken2.Caption := TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String2.Value;
    lblstring_degisken3.Caption := TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String3.Value;
    lblstring_degisken4.Caption := TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String4.Value;
    lblstring_degisken5.Caption := TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String5.Value;
    lblstring_degisken6.Caption := TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String6.Value;
    lblinteger_degisken1.Caption := TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String7.Value;
    lblinteger_degisken2.Caption := TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String8.Value;
    lblinteger_degisken3.Caption := TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String9.Value;
    lbldouble_degisken1.Caption := TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String10.Value;
    lbldouble_degisken2.Caption := TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String11.Value;
    lbldouble_degisken3.Caption := TAyarStkCinsOzelligi(TStokKarti(Table).CinsID.FK.FKTable).String12.Value;
  end;
end;

procedure TfrmStokKarti.edtstok_grubu_idChange(Sender: TObject);
begin
  lblValGroupName.Caption := TAyarStkStokGrubu(TStokKarti(Table).StokGrubuID.FK.FKTable).Grup.Value;
  lblValGrupAlimHesabi.Caption := TAyarStkStokGrubu(TStokKarti(Table).StokGrubuID.FK.FKTable).AlisHesabi.Value;
  lblValGrupSatimHesabi.Caption := TAyarStkStokGrubu(TStokKarti(Table).StokGrubuID.FK.FKTable).SatisHesabi.Value;
  lblValGrupHammaddeHesabi.Caption := TAyarStkStokGrubu(TStokKarti(Table).StokGrubuID.FK.FKTable).HammaddeHesabi.Value;
  lblValGrupMamaulHesabi.Caption := TAyarStkStokGrubu(TStokKarti(Table).StokGrubuID.FK.FKTable).MamulHesabi.Value;
  lblValGrupKDVOrani.Caption := TAyarStkStokGrubu(TStokKarti(Table).StokGrubuID.FK.FKTable).KDVOrani.Value;
end;

procedure TfrmStokKarti.FormCreate(Sender: TObject);
var
  n1, nVarsayilan: Integer;
begin
//  TStokKarti(Table).StokKodu.SetControlProperty(Table.TableName, edtStokKodu);
//  TStokKarti(Table).StokAdi.SetControlProperty(Table.TableName, edtStokAdi);
//  TStokKarti(Table).StokGrubu.SetControlProperty(Table.TableName, edtStokGrubu);
//  TStokKarti(Table).OlcuBirimi.SetControlProperty(Table.TableName, edtOlcuBirimi);
//  TStokKarti(Table).AlisIskonto.SetControlProperty(Table.TableName, edtAlisIskonto);
//  TStokKarti(Table).SatisIskonto.SetControlProperty(Table.TableName, edtSatisIskonto);
//  TStokKarti(Table).YetkiliIskonto.SetControlProperty(Table.TableName, edtYetkiliIskonto);
//  TStokKarti(Table).HamAlisFiyat.SetControlProperty(Table.TableName, edtHamAlisFiyat);
//  TStokKarti(Table).HamAlisParaBirimi.SetControlProperty(Table.TableName, cbbHamAlisParaBirimi);
//  TStokKarti(Table).AlisFiyat.SetControlProperty(Table.TableName, edtAlisFiyat);
//  TStokKarti(Table).AlisParaBirimi.SetControlProperty(Table.TableName, cbbAlisParaBirimi);
//  TStokKarti(Table).SatisFiyat.SetControlProperty(Table.TableName, edtSatisFiyat);
//  TStokKarti(Table).SatisParaBirimi.SetControlProperty(Table.TableName, cbbSatisParaBirimi);
//  TStokKarti(Table).IhracFiyat.SetControlProperty(Table.TableName, edtIhracFiyat);
//  TStokKarti(Table).VarsayilanRecete.SetControlProperty(Table.TableName, cbbVarsayilanRecete);
//  TStokKarti(Table).En.SetControlProperty(Table.TableName, edtEn);
//  TStokKarti(Table).Boy.SetControlProperty(Table.TableName, edtBoy);
//  TStokKarti(Table).Yukseklik.SetControlProperty(Table.TableName, edtYukseklik);
//  TStokKarti(Table).Mensei.SetControlProperty(Table.TableName, cbbMensei);
//  TStokKarti(Table).GtipNo.SetControlProperty(Table.TableName, edtGtipNo);
//  TStokKarti(Table).DiibUrunTanimi.SetControlProperty(Table.TableName, edtDiibUrunTanimi);
//  TStokKarti(Table).EnAzStokSeviyesi.SetControlProperty(Table.TableName, edtEnAzStokSeviyesi);
//  TStokKarti(Table).Tanim.SetControlProperty(Table.TableName, mmoTanim);
//  TStokKarti(Table).OzelKod.SetControlProperty(Table.TableName, edtOzelKod);
//  TStokKarti(Table).Marka.SetControlProperty(Table.TableName, edtMarka);
//  TStokKarti(Table).Agirlik.SetControlProperty(Table.TableName, edtAgirlik);
//  TStokKarti(Table).Kapasite.SetControlProperty(Table.TableName, edtKapasite);
//  TStokKarti(Table).Cins.SetControlProperty(Table.TableName, edtCins);
//  TStokKarti(Table).StringDegisken1.SetControlProperty(Table.TableName, edtStringDegisken1);
//  TStokKarti(Table).StringDegisken2.SetControlProperty(Table.TableName, edtStringDegisken2);
//  TStokKarti(Table).StringDegisken3.SetControlProperty(Table.TableName, edtStringDegisken3);
//  TStokKarti(Table).StringDegisken4.SetControlProperty(Table.TableName, edtStringDegisken4);
//  TStokKarti(Table).StringDegisken5.SetControlProperty(Table.TableName, edtStringDegisken5);
//  TStokKarti(Table).StringDegisken6.SetControlProperty(Table.TableName, edtStringDegisken6);
//  TStokKarti(Table).IntegerDegisken1.SetControlProperty(Table.TableName, edtIntegerDegisken1);
//  TStokKarti(Table).IntegerDegisken2.SetControlProperty(Table.TableName, edtIntegerDegisken2);
//  TStokKarti(Table).IntegerDegisken3.SetControlProperty(Table.TableName, edtIntegerDegisken3);
//  TStokKarti(Table).DoubleDegisken1.SetControlProperty(Table.TableName, edtDoubleDegisken1);
//  TStokKarti(Table).DoubleDegisken2.SetControlProperty(Table.TableName, edtDoubleDegisken2);
//  TStokKarti(Table).DoubleDegisken3.SetControlProperty(Table.TableName, edtDoubleDegisken3);
//  TStokKarti(Table).LotPartiMiktari.SetControlProperty(Table.TableName, edtLotPartiMiktari);
//  TStokKarti(Table).PaketMiktari.SetControlProperty(Table.TableName, edtPaketMiktari);
//  TStokKarti(Table).SeriNoTuru.SetControlProperty(Table.TableName, cbbSeriNoTuru);
//  TStokKarti(Table).HariciSerinoStokKodu.SetControlProperty(Table.TableName, edtHariciSerinoStokKodu);
//  TStokKarti(Table).TasiyiciPaket.SetControlProperty(Table.TableName, cbbTasiyiciPaket);
//  TStokKarti(Table).OncekiDonemCikanMiktar.SetControlProperty(Table.TableName, edtOncekiDonemCikanMiktar);
//  TStokKarti(Table).TeminSuresi.SetControlProperty(Table.TableName, edtTeminSuresi);

//  edtHamAlisFiyat.thsInputDataType := itMoney;
//  edtAlisFiyat.thsInputDataType := itMoney;
//  edtSatisFiyat.thsInputDataType := itMoney;
//  edtIhracFiyat.thsInputDataType := itMoney;

  inherited;

  nVarsayilan := -1;

  vParaBirimi := TParaBirimi.Create(Table.Database);

  lblOrtalamaMaliyetBirim.Caption := TSingletonDB.GetInstance.DataBase.getVarsayilanParaBirimi;


  vParaBirimi.SelectToList('', False, False);
  cbbham_alis_para_birim.Clear;
  cbbalis_para_birim.Clear;
  cbbsatis_para_birim.Clear;
  cbbihrac_para_birim.Clear;
  for n1 := 0 to vParaBirimi.List.Count-1 do
  begin
    if TParaBirimi(vParaBirimi.List[n1]).IsVarsayilan.Value then
      nVarsayilan := n1;
    cbbham_alis_para_birim.AddItem(FormatedVariantVal(TParaBirimi(vParaBirimi.List[n1]).Kod.FieldType, TParaBirimi(vParaBirimi.List[n1]).Kod.Value), TParaBirimi(vParaBirimi.List[n1]));
    cbbalis_para_birim.AddItem(FormatedVariantVal(TParaBirimi(vParaBirimi.List[n1]).Kod.FieldType, TParaBirimi(vParaBirimi.List[n1]).Kod.Value), TParaBirimi(vParaBirimi.List[n1]));
    cbbsatis_para_birim.AddItem(FormatedVariantVal(TParaBirimi(vParaBirimi.List[n1]).Kod.FieldType, TParaBirimi(vParaBirimi.List[n1]).Kod.Value), TParaBirimi(vParaBirimi.List[n1]));
    cbbihrac_para_birim.AddItem(FormatedVariantVal(TParaBirimi(vParaBirimi.List[n1]).Kod.FieldType, TParaBirimi(vParaBirimi.List[n1]).Kod.Value), TParaBirimi(vParaBirimi.List[n1]));
  end;
  cbbham_alis_para_birim.ItemIndex := nVarsayilan;
  cbbalis_para_birim.ItemIndex := nVarsayilan;
  cbbsatis_para_birim.ItemIndex := nVarsayilan;
  cbbihrac_para_birim.ItemIndex := nVarsayilan;
end;

procedure TfrmStokKarti.FormDestroy(Sender: TObject);
begin
  if Assigned(vParaBirimi) then
    vParaBirimi.Free;

  inherited;
end;

procedure TfrmStokKarti.FormShow(Sender: TObject);
begin
  pgcMain.ActivePage := tsMain;
  pgcMainChange(pgcMain);

  inherited;

  edtortalama_maliyet.thsRequiredData := False;
  edtortalama_maliyet.ReadOnly := False;

  edtstok_grubu_id.OnHelperProcess := HelperProcess;
  edtolcu_birimi_id.OnHelperProcess := HelperProcess;
  edtcins_id.OnHelperProcess := HelperProcess;

  {$ifdef DUMMY_VALUE}
    if FormMode = ifmNewRecord then
    begin
      edtstok_kodu.Text := 'ELMAK';
      edtstok_adi.Text := 'ELMA KIRMIZI';
      edtsatis_fiyat.Text := '3';
      edtsatis_fiyat.Repaint;
      edtalis_fiyat.Text := '2,1';
      edtalis_fiyat.Repaint;
      edtham_alis_fiyat.Text := '2';
      edtham_alis_fiyat.Repaint;
      edtihrac_fiyat.Text := '3';
      edtihrac_fiyat.Repaint;
      cbbihrac_para_birim.ItemIndex := cbbihrac_para_birim.Items.IndexOf('EUR');
      edtortalama_maliyet.Text := '2';
    end;
  {$EndIf}
end;

procedure TfrmStokKarti.HelperProcess(Sender: TObject);
var
  vHelperStokGrubu: TfrmHelperStokGrubu;
  vHelperOlcuBirimi: TfrmHelperOlcuBirimi;
  vHelperStokKarti: TfrmHelperStokKarti;
  vHelperCinsOzelligi: TfrmHelperCinsOzellikleri;
  vHelperUlke: TfrmHelperSysCountry;
begin
  if Sender.ClassType = TEdit then
  begin
    if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
    begin
      if TEdit(Sender).Name = edtstok_grubu_id.Name then
      begin
        vHelperStokGrubu := TfrmHelperStokGrubu.Create(TEdit(Sender), Self, TAyarStkStokGrubu.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperStokGrubu.ShowModal;

          if Assigned(TStokKarti(Table).StokGrubuID.FK.FKTable) then
            TStokKarti(Table).StokGrubuID.FK.FKTable.Free;
          TStokKarti(Table).StokGrubuID.FK.FKTable := vHelperStokGrubu.Table.Clone;
          TStokKarti(Table).StokGrubuID.Value := vHelperStokGrubu.Table.Id.Value;

          edtstok_grubu_idChange(edtstok_grubu_id);
//          lblValGroupName.Caption := TStokGrubu(vHelperStokGrubu.Table).Grup.Value;
//          lblValGrupAlimHesabi.Caption := TStokGrubu(vHelperStokGrubu.Table).AlisHesabi.Value;
//          lblValGrupSatimHesabi.Caption := TStokGrubu(vHelperStokGrubu.Table).SatisHesabi.Value;
//          lblValGrupHammaddeHesabi.Caption := TStokGrubu(vHelperStokGrubu.Table).HammaddeHesabi.Value;
//          lblValGrupMamaulHesabi.Caption := TStokGrubu(vHelperStokGrubu.Table).MamulHesabi.Value;
//          lblValGrupKDVOrani.Caption := TStokGrubu(vHelperStokGrubu.Table).KDVOrani.Value;
        finally
          vHelperStokGrubu.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtolcu_birimi_id.Name then
      begin
        vHelperOlcuBirimi := TfrmHelperOlcuBirimi.Create(TEdit(Sender), Self, TOlcuBirimi.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperOlcuBirimi.ShowModal;

//          vOlcuBirimi := TOlcuBirimi(TOlcuBirimi(vHelperOlcuBirimi.Table).Clone);
        finally
          vHelperOlcuBirimi.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtcins_id.Name then
      begin
        vHelperCinsOzelligi := TfrmHelperCinsOzellikleri.Create(TEdit(Sender), Self, TAyarStkCinsOzelligi.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperCinsOzelligi.ShowModal;
          if Assigned(TStokKarti(Table).CinsID.FK.FKTable) then
            TStokKarti(Table).CinsID.FK.FKTable.Free;
          TStokKarti(Table).CinsID.FK.FKTable := vHelperCinsOzelligi.Table.Clone;
          TStokKarti(Table).CinsID.Value := vHelperCinsOzelligi.Table.Id.Value;
          edtcins_idChange(edtcins_id);
        finally
          vHelperCinsOzelligi.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtharici_serino_stok_kodu_id.Name then
      begin
        vHelperStokKarti := TfrmHelperStokKarti.Create(TEdit(Sender), Self, TStokKarti.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperStokKarti.ShowModal;

//          if Assigned(vStokKarti) then
//            vStokKarti.Free;
//          vStokKarti := TStokKarti(TStokKarti(vHelperStokKarti.Table).Clone);
        finally
          vHelperStokKarti.Free;
        end;
      end
      else
      if TEdit(Sender).Name = edtmensei_id.Name then
      begin
        vHelperUlke := TfrmHelperSysCountry.Create(TEdit(Sender), Self, TSysCountry.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperUlke.ShowModal;
          if Assigned(TStokKarti(Table).MenseiID.FK.FKTable) then
            TStokKarti(Table).MenseiID.FK.FKTable.Free;
          TStokKarti(Table).MenseiID.FK.FKTable := vHelperUlke.Table.Clone;
          TStokKarti(Table).MenseiID.Value := vHelperUlke.Table.Id.Value;
        finally
          vHelperUlke.Free;
        end;
      end;
    end;
  end
end;

procedure TfrmStokKarti.pgcMainChange(Sender: TObject);
begin
  inherited;
  if pgcMain.ActivePage.Name = tsOzetler.Name then
  begin
    lblstok_kodu.Parent := pnlOzetHeader;
    edtstok_kodu.Parent := pnlOzetHeader;
    lblstok_adi.Parent := pnlOzetHeader;
    edtstok_adi.Parent := pnlOzetHeader;
  end
  else
  if pgcMain.ActivePage.Name = tsGrupOzellikleri.Name then
  begin
    lblstok_kodu.Parent := pnlGrupHeader;
    edtstok_kodu.Parent := pnlGrupHeader;
    lblstok_adi.Parent := pnlGrupHeader;
    edtstok_adi.Parent := pnlGrupHeader;
  end
  else
  begin
    lblstok_kodu.Parent := pgcMain.ActivePage;
    edtstok_kodu.Parent := pgcMain.ActivePage;
    lblstok_adi.Parent := pgcMain.ActivePage;
    edtstok_adi.Parent := pgcMain.ActivePage;
  end;

  if pgcMain.ActivePage.Name = tsMain.Name then
  begin
    edtstok_kodu.ReadOnly := False;
    edtstok_kodu.TabStop := True;
    edtstok_adi.ReadOnly := False;
    edtstok_adi.TabStop := True;

    edtstok_kodu.TabOrder := 0;
    edtstok_adi.TabOrder := 1;
    edtstok_kodu.SetFocus;
  end
  else
  begin
    edtstok_kodu.ReadOnly := True;
    edtstok_kodu.TabStop := False;
    edtstok_adi.ReadOnly := True;
    edtstok_adi.TabStop := False;
  end;
end;

procedure TfrmStokKarti.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtstok_kodu.Text := FormatedVariantVal(TStokKarti(Table).StokKodu.FieldType, TStokKarti(Table).StokKodu.Value);
  edtstok_adi.Text := FormatedVariantVal(TStokKarti(Table).StokAdi.FieldType, TStokKarti(Table).StokAdi.Value);

  edtstok_grubu_id.Text := FormatedVariantVal(TStokKarti(Table).StokGrubuID.FK.FKCol.FieldType, TStokKarti(Table).StokGrubuID.FK.FKCol.Value);
  edtstok_grubu_idChange(edtstok_grubu_id);

  edtolcu_birimi_id.Text := FormatedVariantVal(TStokKarti(Table).OlcuBirimiID.FK.FKCol.FieldType, TStokKarti(Table).OlcuBirimiID.FK.FKCol.Value);

  edtalis_iskonto.Text := FormatedVariantVal(TStokKarti(Table).AlisIskonto.FieldType, TStokKarti(Table).AlisIskonto.Value);
  edtsatis_iskonto.Text := FormatedVariantVal(TStokKarti(Table).SatisIskonto.FieldType, TStokKarti(Table).SatisIskonto.Value);
  edtyetkili_iskonto.Text := FormatedVariantVal(TStokKarti(Table).YetkiliIskonto.FieldType, TStokKarti(Table).YetkiliIskonto.Value);

  edtham_alis_fiyat.Text := FormatedVariantVal(TStokKarti(Table).HamAlisFiyat.FieldType, TStokKarti(Table).HamAlisFiyat.Value);
//  edtHamAlisFiyat.Repaint;
  cbbham_alis_para_birim.Text := FormatedVariantVal(TStokKarti(Table).HamAlisParaBirimi.FieldType, TStokKarti(Table).HamAlisParaBirimi.Value);
  edtalis_fiyat.Text := FormatedVariantVal(TStokKarti(Table).AlisFiyat.FieldType, TStokKarti(Table).AlisFiyat.Value);
//  edtAlisFiyat.Repaint;
  cbbalis_para_birim.Text := FormatedVariantVal(TStokKarti(Table).AlisParaBirimi.FieldType, TStokKarti(Table).AlisParaBirimi.Value);
  edtsatis_fiyat.Text := FormatedVariantVal(TStokKarti(Table).SatisFiyat.FieldType, TStokKarti(Table).SatisFiyat.Value);
//  edtSatisFiyat.Repaint;
  cbbsatis_para_birim.Text := FormatedVariantVal(TStokKarti(Table).SatisParaBirimi.FieldType, TStokKarti(Table).SatisParaBirimi.Value);
  edtihrac_fiyat.Text := FormatedVariantVal(TStokKarti(Table).IhracFiyat.FieldType, TStokKarti(Table).IhracFiyat.Value);
//  edtIhracFiyat.Repaint;
  cbbihrac_para_birim.Text := FormatedVariantVal(TStokKarti(Table).IhracParaBirimi.FieldType, TStokKarti(Table).IhracParaBirimi.Value);

//  cbbVarsayilanRecete.Text := FormatedVariantVal(TStokKarti(Table).VarsayilanRecete.FieldType, TStokKarti(Table).VarsayilanRecete.Value);

  edtEn.Text := FormatedVariantVal(TStokKarti(Table).En.FieldType, TStokKarti(Table).En.Value);
  edtBoy.Text := FormatedVariantVal(TStokKarti(Table).Boy.FieldType, TStokKarti(Table).Boy.Value);
  edtYukseklik.Text := FormatedVariantVal(TStokKarti(Table).Yukseklik.FieldType, TStokKarti(Table).Yukseklik.Value);
  edtmensei_id.Text := FormatedVariantVal(TStokKarti(Table).MenseiID.FK.FKCol.FieldType, TStokKarti(Table).MenseiID.FK.FKCol.Value);
  edtgtip_no.Text := FormatedVariantVal(TStokKarti(Table).GtipNo.FieldType, TStokKarti(Table).GtipNo.Value);
  edtdiib_urun_tanimi.Text := FormatedVariantVal(TStokKarti(Table).DiibUrunTanimi.FieldType, TStokKarti(Table).DiibUrunTanimi.Value);

  edten_az_stok_seviyesi.Text := FormatedVariantVal(TStokKarti(Table).EnAzStokSeviyesi.FieldType, TStokKarti(Table).EnAzStokSeviyesi.Value);
  mmotanim.Text := FormatedVariantVal(TStokKarti(Table).Tanim.FieldType, TStokKarti(Table).Tanim.Value);
  edtozel_kod.Text := FormatedVariantVal(TStokKarti(Table).OzelKod.FieldType, TStokKarti(Table).OzelKod.Value);
  edtmarka.Text := FormatedVariantVal(TStokKarti(Table).Marka.FieldType, TStokKarti(Table).Marka.Value);
  edtagirlik.Text := FormatedVariantVal(TStokKarti(Table).Agirlik.FieldType, TStokKarti(Table).Agirlik.Value);
  edtkapasite.Text := FormatedVariantVal(TStokKarti(Table).Kapasite.FieldType, TStokKarti(Table).Kapasite.Value);

  edtcins_id.Text := FormatedVariantVal(TStokKarti(Table).CinsID.FK.FKCol.FieldType, TStokKarti(Table).CinsID.FK.FKCol.Value);
  edtcins_idChange(edtcins_id);
  edtstring_degisken1.Text := FormatedVariantVal(TStokKarti(Table).StringDegisken1.FieldType, TStokKarti(Table).StringDegisken1.Value);
  edtstring_degisken2.Text := FormatedVariantVal(TStokKarti(Table).StringDegisken2.FieldType, TStokKarti(Table).StringDegisken2.Value);
  edtstring_degisken3.Text := FormatedVariantVal(TStokKarti(Table).StringDegisken3.FieldType, TStokKarti(Table).StringDegisken3.Value);
  edtstring_degisken4.Text := FormatedVariantVal(TStokKarti(Table).StringDegisken4.FieldType, TStokKarti(Table).StringDegisken4.Value);
  edtstring_degisken5.Text := FormatedVariantVal(TStokKarti(Table).StringDegisken5.FieldType, TStokKarti(Table).StringDegisken5.Value);
  edtstring_degisken6.Text := FormatedVariantVal(TStokKarti(Table).StringDegisken6.FieldType, TStokKarti(Table).StringDegisken6.Value);
  edtinteger_degisken1.Text := FormatedVariantVal(TStokKarti(Table).IntegerDegisken1.FieldType, TStokKarti(Table).IntegerDegisken1.Value);
  edtinteger_degisken2.Text := FormatedVariantVal(TStokKarti(Table).IntegerDegisken2.FieldType, TStokKarti(Table).IntegerDegisken2.Value);
  edtinteger_degisken3.Text := FormatedVariantVal(TStokKarti(Table).IntegerDegisken3.FieldType, TStokKarti(Table).IntegerDegisken3.Value);
  edtdouble_degisken1.Text := FormatedVariantVal(TStokKarti(Table).DoubleDegisken1.FieldType, TStokKarti(Table).DoubleDegisken1.Value);
  edtdouble_degisken2.Text := FormatedVariantVal(TStokKarti(Table).DoubleDegisken2.FieldType, TStokKarti(Table).DoubleDegisken2.Value);
  edtdouble_degisken3.Text := FormatedVariantVal(TStokKarti(Table).DoubleDegisken3.FieldType, TStokKarti(Table).DoubleDegisken3.Value);

  chkis_satilabilir.Checked := FormatedVariantVal(TStokKarti(Table).IsSatilabilir.FieldType, TStokKarti(Table).IsSatilabilir.Value);
  edtlot_parti_miktari.Text := FormatedVariantVal(TStokKarti(Table).LotPartiMiktari.FieldType, TStokKarti(Table).LotPartiMiktari.Value);
  edtpaket_miktari.Text := FormatedVariantVal(TStokKarti(Table).PaketMiktari.FieldType, TStokKarti(Table).PaketMiktari.Value);
  edtseri_no_turu.Text := FormatedVariantVal(TStokKarti(Table).SeriNoTuru.FieldType, TStokKarti(Table).SeriNoTuru.Value);
  chkis_harici_seri_no_icerir.Checked := FormatedVariantVal(TStokKarti(Table).IsHariciSeriNoIcerir.FieldType, TStokKarti(Table).IsHariciSeriNoIcerir.Value);
  edtharici_serino_stok_kodu_id.Text := FormatedVariantVal(TStokKarti(Table).HariciSeriNoStokKoduID.FK.FKCol.FieldType, TStokKarti(Table).HariciSeriNoStokKoduID.FK.FKCol.Value);
  edtonceki_donem_cikan_miktar.Text := FormatedVariantVal(TStokKarti(Table).OncekiDonemCikanMiktar.FieldType, TStokKarti(Table).OncekiDonemCikanMiktar.Value);
  edttemin_suresi.Text := FormatedVariantVal(TStokKarti(Table).TeminSuresi.FieldType, TStokKarti(Table).TeminSuresi.Value);
end;

procedure TfrmStokKarti.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TStokKarti(Table).StokKodu.Value := edtstok_kodu.Text;
      TStokKarti(Table).StokAdi.Value := edtstok_adi.Text;

      TStokKarti(Table).StokGrubuID.FK.FKCol.Value := edtstok_grubu_id.Text;
      TStokKarti(Table).OlcuBirimiID.FK.FKCol.Value := edtolcu_birimi_id.Text;

      TStokKarti(Table).AlisIskonto.Value := StrToFloatDef(edtalis_iskonto.Text, 0);
      TStokKarti(Table).SatisIskonto.Value := StrToFloatDef(edtsatis_iskonto.Text, 0);
      TStokKarti(Table).YetkiliIskonto.Value := StrToFloatDef(edtyetkili_iskonto.Text, 0);

      TStokKarti(Table).HamAlisFiyat.Value := edtham_alis_fiyat.toMoneyToDouble;
      TStokKarti(Table).HamAlisParaBirimi.Value := cbbham_alis_para_birim.Text;

      TStokKarti(Table).AlisFiyat.Value := edtalis_fiyat.toMoneyToDouble;
      TStokKarti(Table).AlisParaBirimi.Value := cbbalis_para_birim.Text;

      TStokKarti(Table).SatisFiyat.Value := edtsatis_fiyat.toMoneyToDouble;
      TStokKarti(Table).SatisParaBirimi.Value := cbbsatis_para_birim.Text;

      TStokKarti(Table).IhracFiyat.Value := edtihrac_fiyat.toMoneyToDouble;
      TStokKarti(Table).IhracParaBirimi.Value := cbbihrac_para_birim.Text;

      TStokKarti(Table).VarsayilaReceteID.FK.FKCol.Value := edtvarsayilan_recete_id.Text;
      TStokKarti(Table).En.Value := StrToFloatDef(edten.Text, 0);
      TStokKarti(Table).Boy.Value := StrToFloatDef(edtboy.Text, 0);
      TStokKarti(Table).Yukseklik.Value := StrToFloatDef(edtyukseklik.Text, 0);

      TStokKarti(Table).GtipNo.Value := edtgtip_no.Text;
      TStokKarti(Table).DiibUrunTanimi.Value := edtdiib_urun_tanimi.Text;
      TStokKarti(Table).EnAzStokSeviyesi.Value := StrToFloatDef(edten_az_stok_seviyesi.Text, 0);
      TStokKarti(Table).Tanim.Value := mmotanim.Text;
      TStokKarti(Table).OzelKod.Value := edtozel_kod.Text;
      TStokKarti(Table).Marka.Value := edtmarka.Text;
      TStokKarti(Table).Agirlik.Value := StrToFloatDef(edtagirlik.Text, 0);
      TStokKarti(Table).Kapasite.Value := StrToFloatDef(edtkapasite.Text, 0);


      TStokKarti(Table).CinsID.FK.FKCol.Value := edtcins_id.Text;
      TStokKarti(Table).StringDegisken1.Value := edtstring_degisken1.Text;
      TStokKarti(Table).StringDegisken2.Value := edtstring_degisken2.Text;
      TStokKarti(Table).StringDegisken3.Value := edtstring_degisken3.Text;
      TStokKarti(Table).StringDegisken4.Value := edtstring_degisken4.Text;
      TStokKarti(Table).StringDegisken5.Value := edtstring_degisken5.Text;
      TStokKarti(Table).StringDegisken6.Value := edtstring_degisken6.Text;
      TStokKarti(Table).IntegerDegisken1.Value := edtinteger_degisken1.Text;
      TStokKarti(Table).IntegerDegisken2.Value := edtinteger_degisken2.Text;
      TStokKarti(Table).IntegerDegisken3.Value := edtinteger_degisken3.Text;
      TStokKarti(Table).DoubleDegisken1.Value := StrToFloatDef(edtdouble_degisken1.Text, 0);
      TStokKarti(Table).DoubleDegisken2.Value := StrToFloatDef(edtdouble_degisken2.Text, 0);
      TStokKarti(Table).DoubleDegisken3.Value := StrToFloatDef(edtdouble_degisken3.Text, 0);

      TStokKarti(Table).IsSatilabilir.Value := chkis_satilabilir.Checked;
      TStokKarti(Table).LotPartiMiktari.Value := StrToFloatDef(edtlot_parti_miktari.Text, 0);
      TStokKarti(Table).PaketMiktari.Value := StrToFloatDef(edtpaket_miktari.Text, 0);
      TStokKarti(Table).SeriNoTuru.Value := edtseri_no_turu.Text;
      TStokKarti(Table).IsHariciSeriNoIcerir.Value := chkis_harici_seri_no_icerir.Checked;
      TStokKarti(Table).HariciSeriNoStokKoduID.FK.FKCol.Value := edtharici_serino_stok_kodu_id.Text;
      TStokKarti(Table).TasiyiciPaketID.FK.FKCol.Value := cbbtasiyici_paket_id.Text;
      TStokKarti(Table).OncekiDonemCikanMiktar.Value := StrToFloatDef(edtonceki_donem_cikan_miktar.Text, 0);
      TStokKarti(Table).TeminSuresi.Value := StrToFloatDef(edttemin_suresi.Text, 0);
      inherited;
    end;
  end
  else
    inherited;
end;

end.
