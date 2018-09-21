unit ufrmMain;

interface

uses
  Winapi.Windows, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.ComCtrls, Vcl.Menus, Math, StrUtils, Vcl.ActnList, System.Actions,
  Vcl.AppEvnts, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls, System.Classes,
  Dialogs, System.SysUtils,
  System.Rtti, thsEdit,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.Client,

  ufrmBase,

  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Field, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.DataSet;

type
  TfrmMain = class(TfrmBase)
    mmMain: TMainMenu;
    mniApplication: TMenuItem;
    mniAbout: TMenuItem;
    mniSettings: TMenuItem;
    mniChangePassword: TMenuItem;
    mniAdministration: TMenuItem;
    mniClose: TMenuItem;
    PageControl1: TPageControl;
    tsGeneral: TTabSheet;
    tsBuying: TTabSheet;
    tsSales: TTabSheet;
    tsStock: TTabSheet;
    tsAccounting: TTabSheet;
    tsProduction: TTabSheet;
    tsEquipment: TTabSheet;
    tsEmployee: TTabSheet;
    tsFrameworkSettings: TTabSheet;
    tsSettings: TTabSheet;
    btnStokHareketi: TButton;
    pmButtons: TPopupMenu;
    mniAddLanguageContent: TMenuItem;
    btnPersonelKartlari: TButton;
    pgcSettings: TPageControl;
    tsSettingGeneral: TTabSheet;
    tsSettingStock: TTabSheet;
    btnAyarStokHareketTipi: TButton;
    tsSettingAccount: TTabSheet;
    btnHesapGrubu: TButton;
    tsSettingEmployee: TTabSheet;
    btnAyarPersonelBolum: TButton;
    btnAyarPersonelBirim: TButton;
    btnAyarPersonelGorev: TButton;
    btnBolgeTuru: TButton;
    btnUlkeler: TButton;
    btnSehirler: TButton;
    btnParaBirimleri: TButton;
    btnAyarVergiOrani: TButton;
    tsSettingEInvoice: TTabSheet;
    btnAyarEFaturaFaturaTipi: TButton;
    btnAyarEfaturaIletisimKanali: TButton;
    btnAyarEfaturaIstisnaKodu: TButton;
    btnAyarFirmaTipi: TButton;
    btnSysPermissionSourceGroup: TButton;
    btnSysPermissionSource: TButton;
    btnSysUserAccessRight: TButton;
    btnSysUser: TButton;
    btnSysGridColWidth: TButton;
    btnSysGridColPercent: TButton;
    btnSysGridColColor: TButton;
    btnSysDefaultOrderFilter: TButton;
    btnSysLang: TButton;
    btnSysLangContent: TButton;
    btnSysTableLangContent: TButton;
    btnSysQualityFormNumber: TButton;
    btnSysApplicationSettings: TButton;
    btnAmbarlar: TButton;
    btnOlcuBirimleri: TButton;
    btnQualityFormMailRecievers: TButton;
    btnSysUserMacAddressExceptions: TButton;
    btnDovizKurlari: TButton;
    btnBankalar: TButton;
    btnBankaSubeleri: TButton;
    btnUrunKabulRedNedenleri: TButton;
    btnSysMultiLangDataTableLists: TButton;
    btnStokTipi: TButton;
    btnCinsAileleri: TButton;
    btnCinsOzellikleri: TButton;
    btnAyarHesapTipleri: TButton;
    btnStokKartlari: TButton;
    btnStokGrubuTurleri: TButton;
    btnStokGruplari: TButton;
    btnAyarBarkodUrunTuru: TButton;
    btnAyarBarkodSeriNoTuru: TButton;
    btnAyarBarkodHazirlikDosyaTurleri: TButton;
    btnAyarBarkodTezgahlar: TButton;
    btnServis: TButton;
    pb1: TProgressBar;
    btnTeklifler: TButton;
    btnAyarTeklifDurumlar: TButton;
    btnOdemeBaslangicDonemi: TButton;
    btnTeklifTipleri: TButton;
    btnAyarPersonelTipi: TButton;
    btnAyarPersonelCinsiyet: TButton;
    btnAyarPersonelKanGrubu: TButton;
    btnAyarPersonelAskerlikDurumu: TButton;
    btnAyarPersonelRaporTipi: TButton;
    btnAyarPersonelIzinTipi: TButton;
    btnAyarPersonelMedeniDurum: TButton;
    btnAyarPersonelDil: TButton;
    btnAyarPersonelDilSeviyesi: TButton;
    btnPersonelDilBilgileri: TButton;
    btnAyarPersonelEhliyetTipi: TButton;
    btnAyarPersonelMykTipi: TButton;
    btnAyarPersonelSrcTipi: TButton;
    btnAyarPersonelAyarilmaNedeniTipi: TButton;
    btnAyarPersonelMektupTipi: TButton;
    btnAyarPersonelTatilTipi: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);override;
    procedure FormCreate(Sender: TObject);override;
    procedure FormShow(Sender: TObject);override;
    procedure btnUlkelerClick(Sender: TObject);
    procedure AppEvntsBaseIdle(Sender: TObject; var Done: Boolean);
    procedure btnSehirlerClick(Sender: TObject);
    procedure btnParaBirimleriClick(Sender: TObject);

/// <summary>
///   Kullanýcýnýn eriþim yetkisine göre yapýlacak iþlemler burada olacak
/// </summary>
/// <remarks>
///   Login olan kullanýcýya ait haklara göre yapýlacak iþlemler burada yapýlýyor.
///   Ana formda kullanýcýnýn sahip olduðu yetkilere göre butonlar açýlýyor.
/// </remarks>
/// <example>
///   Yeni Kayýt Ekle Buton baþlýðý için ButtonAdd
/// </example>
    procedure SetSession();
    procedure ResetSession(pPanelGroupboxPagecontrolTabsheet: TWinControl);
    procedure mniAboutClick(Sender: TObject);
    procedure btnSysPermissionSourceGroupClick(Sender: TObject);
    procedure btnSysPermissionSourceClick(Sender: TObject);
    procedure btnSysUserAccessRightClick(Sender: TObject);
    procedure btnSysLangClick(Sender: TObject);
    procedure btnSysGridColWidthClick(Sender: TObject);
    procedure btnSysGridColColorClick(Sender: TObject);
    procedure btnSysGridColPercentClick(Sender: TObject);
    procedure btnSysLangContentClick(Sender: TObject);
    procedure btnSysQualityFormNumberClick(Sender: TObject);
    procedure btnSysTableLangContentClick(Sender: TObject);
    procedure btnAyarStokHareketTipiClick(Sender: TObject);
    procedure btnStokHareketiClick(Sender: TObject);
    procedure btnSysDefaultOrderFilterClick(Sender: TObject);
    procedure mniAddLanguageContentClick(Sender: TObject);
    procedure btnSysUserClick(Sender: TObject);
    procedure btnAyarEFaturaFaturaTipiClick(Sender: TObject);
    procedure btnAyarFirmaTipiClick(Sender: TObject);
    procedure btnAyarEfaturaIletisimKanaliClick(Sender: TObject);
    procedure btnAyarEfaturaIstisnaKoduClick(Sender: TObject);
    procedure btnSysApplicationSettingsClick(Sender: TObject);
    procedure btnPersonelKartlariClick(Sender: TObject);
    procedure btnAyarPersonelBolumClick(Sender: TObject);
    procedure btnAyarPersonelBirimClick(Sender: TObject);
    procedure btnAyarPersonelGorevClick(Sender: TObject);
    procedure btnAyarVergiOraniClick(Sender: TObject);
    procedure btnHesapGrubuClick(Sender: TObject);
    procedure btnBolgeTuruClick(Sender: TObject);
    procedure btnAmbarlarClick(Sender: TObject);
    procedure btnOlcuBirimleriClick(Sender: TObject);
    procedure btnQualityFormMailRecieversClick(Sender: TObject);
    procedure mniCloseClick(Sender: TObject);
    procedure btnSysUserMacAddressExceptionsClick(Sender: TObject);
    procedure btnDovizKurlariClick(Sender: TObject);
    procedure btnBankalarClick(Sender: TObject);
    procedure btnBankaSubeleriClick(Sender: TObject);
    procedure btnUrunKabulRedNedenleriClick(Sender: TObject);
    procedure btnSysMultiLangDataTableListsClick(Sender: TObject);
    procedure btnStokTipiClick(Sender: TObject);
    procedure btnCinsAileleriClick(Sender: TObject);
    procedure btnCinsOzellikleriClick(Sender: TObject);
    procedure btnAyarHesapTipleriClick(Sender: TObject);
    procedure btnStokKartlariClick(Sender: TObject);
    procedure btnStokGrubuTurleriClick(Sender: TObject);
    procedure btnStokGruplariClick(Sender: TObject);
    procedure btnAyarBarkodUrunTuruClick(Sender: TObject);
    procedure btnAyarBarkodSeriNoTuruClick(Sender: TObject);
    procedure btnAyarBarkodHazirlikDosyaTurleriClick(Sender: TObject);
    procedure btnAyarBarkodTezgahlarClick(Sender: TObject);
    procedure btnServisClick(Sender: TObject);
    procedure btnTekliflerClick(Sender: TObject);
    procedure btnAyarTeklifDurumlarClick(Sender: TObject);
    procedure btnOdemeBaslangicDonemiClick(Sender: TObject);
    procedure btnTeklifTipleriClick(Sender: TObject);
    procedure btnAyarPersonelTipiClick(Sender: TObject);
    procedure btnAyarPersonelCinsiyetClick(Sender: TObject);
    procedure btnAyarPersonelKanGrubuClick(Sender: TObject);
    procedure btnAyarPersonelAskerlikDurumuClick(Sender: TObject);
    procedure btnAyarPersonelRaporTipiClick(Sender: TObject);
    procedure btnAyarPersonelIzinTipiClick(Sender: TObject);
    procedure btnAyarPersonelMedeniDurumClick(Sender: TObject);
    procedure btnAyarPersonelDilClick(Sender: TObject);
    procedure btnAyarPersonelDilSeviyesiClick(Sender: TObject);
    procedure btnPersonelDilBilgileriClick(Sender: TObject);
    procedure btnAyarPersonelEhliyetTipiClick(Sender: TObject);
    procedure btnAyarPersonelMykTipiClick(Sender: TObject);
    procedure btnAyarPersonelSrcTipiClick(Sender: TObject);
    procedure btnAyarPersonelAyarilmaNedeniTipiClick(Sender: TObject);
    procedure btnAyarPersonelMektupTipiClick(Sender: TObject);
    procedure btnAyarPersonelTatilTipiClick(Sender: TObject);
    procedure ButtonedEdit1RightButtonClick(Sender: TObject);
    procedure ButtonedEdit1LeftButtonClick(Sender: TObject);

  private
    procedure SetTitleFromLangContent(Sender: TControl = nil);
    procedure SetButtonPopup(Sender: TControl = nil);
  protected
  published
    procedure btnCloseClick(Sender: TObject); override;
    procedure FormKeyPress(Sender: TObject; var Key: Char);override;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);override;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;
  public
    destructor Destroy; override;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  ufrmAbout,

  Ths.Erp.SpecialFunctions,

  Ths.Erp.Constants,
  ufrmSysLangGuiContent,

  Ths.Erp.Database.Table.PersonelKarti, ufrmPersonelKartlari,
  Ths.Erp.Database.Table.ParaBirimi, ufrmParaBirimleri,
  Ths.Erp.Database.Table.Ulke, ufrmUlkeler,
  Ths.Erp.Database.Table.Sehir, ufrmSehirler,
  Ths.Erp.Database.Table.SysUserAccessRight, ufrmSysUserAccessRights,
  Ths.Erp.Database.Table.SysPermissionSourceGroup, ufrmSysPermissionSourceGroups,
  Ths.Erp.Database.Table.SysPermissionSource, ufrmSysPermissionSources,
  Ths.Erp.Database.Table.SysLang, ufrmSysLangs,
  Ths.Erp.Database.Table.SysLangGuiContent, ufrmSysLangGuiContents,
  Ths.Erp.Database.Table.SysGridColWidth, ufrmSysGridColWidths,
  Ths.Erp.Database.Table.SysGridColColor, ufrmSysGridColColors,
  Ths.Erp.Database.Table.SysGridColPercent, ufrmSysGridColPercents,
  Ths.Erp.Database.Table.SysLangDataContent, ufrmSysLangDataContents,
  Ths.Erp.Database.Table.SysQualityFormNumber, ufrmSysQualityFormNumbers,
  Ths.Erp.Database.Table.AyarStokHareketTipi, ufrmAyarStokHareketTipleri,
  Ths.Erp.Database.Table.StokHareketi, ufrmStokHareketleri,
  Ths.Erp.Database.Table.SysGridDefaultOrderFilter, ufrmSysGridDefaultOrderFilters,
  Ths.Erp.Database.Table.AyarEFaturaFaturaTipi, ufrmAyarEFaturaFaturaTipleri,
  Ths.Erp.Database.Table.AyarFirmaTipi, ufrmAyarFirmaTipleri,
  Ths.Erp.Database.Table.AyarEFaturaIletisimKanali, ufrmAyarEFaturaIletisimKanallari,
  Ths.Erp.Database.Table.AyarEFaturaIstisnaKodu, ufrmAyarEFaturaIstisnaKodlari,
  Ths.Erp.Database.Table.SysApplicationSettings, ufrmSysApplicationSetting,
  Ths.Erp.Database.Table.AyarPersonelBolum, ufrmAyarPersonelBolumler,
  Ths.Erp.Database.Table.AyarPersonelBirim, ufrmAyarPersonelBirimler,
  Ths.Erp.Database.Table.AyarPersonelGorev, ufrmAyarPersonelGorevler,
  Ths.Erp.Database.Table.AyarVergiOrani, ufrmAyarVergiOranlari,
  Ths.Erp.Database.Table.BolgeTuru, ufrmBolgeTurleri,
  Ths.Erp.Database.Table.HesapGrubu, ufrmHesapGruplari,
  Ths.Erp.Database.Table.Ambar, ufrmAmbarlar,
  Ths.Erp.Database.Table.OlcuBirimi, ufrmOlcuBirimleri,
  Ths.Erp.Database.Table.UrunKabulRedNedeni, ufrmUrunKabulRedNedenleri,
  Ths.Erp.Database.Table.QualityFormMailReciever, ufrmQualityFormMailRecievers,
  Ths.Erp.Database.Table.SysUserMacAddressException, ufrmSysUserMacAddressExceptions,
  Ths.Erp.Database.Table.DovizKuru, ufrmDovizKurlari,
  Ths.Erp.Database.Table.Banka, ufrmBankalar,
  Ths.Erp.Database.Table.BankaSubesi, ufrmBankaSubeleri,
  Ths.Erp.Database.Table.SysMultiLangDataTableList, ufrmSysMultiLangDataTableLists,
  Ths.Erp.Database.Table.StokTipi, ufrmStokTipleri,
  Ths.Erp.Database.Table.CinsAilesi, ufrmCinsAileleri,
  Ths.Erp.Database.Table.CinsOzelligi, ufrmCinsOzellikleri,
  Ths.Erp.Database.Table.AyarHesapTipi, ufrmAyarHesapTipleri,
  Ths.Erp.Database.Table.StokKarti, ufrmStokKartlari,
  Ths.Erp.Database.Table.StokGrubuTuru, ufrmStokGrubuTurleri,
  Ths.Erp.Database.Table.StokGrubu, ufrmStokGruplari,
  Ths.Erp.Database.Table.AyarBarkodUrunTuru, ufrmAyarBarkodUrunTurleri,
  Ths.Erp.Database.Table.AyarBarkodHazirlikDosyaTuru, ufrmAyarBarkodHazirlikDosyaTurleri,
  Ths.Erp.Database.Table.AyarBarkodSeriNoTuru, ufrmAyarBarkodSeriNoTurleri,
  Ths.Erp.Database.Table.AyarBarkodTezgah, ufrmAyarBarkodTezgahlar,
  Ths.Erp.Database.Table.SatisTeklif, ufrmSatisTeklifDetaylar,
  Ths.Erp.Database.Table.AyarTeklifDurum, ufrmAyarTeklifDurumlar,
  Ths.Erp.Database.Table.AyarTeklifTipi, ufrmAyarTeklifTipleri,
  Ths.Erp.Database.Table.AyarOdemeBaslangicDonemi, ufrmAyarOdemeBaslangicDonemleri,
  Ths.Erp.Database.Table.AyarPersonelTipi, ufrmAyarPersonelTipleri,
  Ths.Erp.Database.Table.AyarPersonelCinsiyet, ufrmAyarPersonelCinsiyetler,
  Ths.Erp.Database.Table.AyarPersonelKanGrubu, ufrmAyarPersonelKanGruplari,
  Ths.Erp.Database.Table.AyarPersonelAskerlikDurumu, ufrmAyarPersonelAskerlikDurumlari,
  Ths.Erp.Database.Table.AyarPersonelRaporTipi, ufrmAyarPersonelRaporTipleri,
  Ths.Erp.Database.Table.AyarPersonelIzinTipi, ufrmAyarPersonelIzinTipleri,
  Ths.Erp.Database.Table.AyarPersonelMedeniDurum, ufrmAyarPersonelMedeniDurumlar,
  Ths.Erp.Database.Table.AyarPersonelDil, ufrmAyarPersonelDilleri,
  Ths.Erp.Database.Table.AyarPersonelDilSeviyesi, ufrmAyarPersonelDilSeviyeleri,
  Ths.Erp.Database.Table.PersonelDilBilgisi, ufrmPersonelDilBilgileri,
  Ths.Erp.Database.Table.AyarPersonelEhliyetTipi, ufrmAyarPersonelEhliyetTipleri,
  Ths.Erp.Database.Table.AyarPersonelMykTipi, ufrmAyarPersonelMykTipleri,
  Ths.Erp.Database.Table.AyarPersonelSrcTipi, ufrmAyarPersonelSrcTipleri,
  Ths.Erp.Database.Table.AyarPersonelAyrilmaNedeniTipi, ufrmAyarPersonelAyrilmaNedeniTipleri,
  Ths.Erp.Database.Table.AyarPersonelMektupTipi, ufrmAyarPersonelMektupTipleri,
  Ths.Erp.Database.Table.AyarPersonelTatilTipi, ufrmAyarPersonelTatilTipleri;

procedure TfrmMain.AppEvntsBaseIdle(Sender: TObject; var Done: Boolean);
begin
  inherited;
  //
end;

procedure TfrmMain.btnSehirlerClick(Sender: TObject);
begin
  TfrmSehirler.Create(Self, Self, TSehir.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnServisClick(Sender: TObject);
var
//  vID: Integer;
  vOld: TFDQuery;
  vCon: TFDConnection;
  vStokGrubuTuru: TStokGrubuTuru;
  vStokGrubu: TStokGrubu;
  vKDV: TAyarVergiOrani;
  vStokKarti, vStokKarti2: TStokKarti;
  vOlcuBirimi: TOlcuBirimi;
  vStokTipi: TStokTipi;
  vUlke: TUlke;
  vCins: TCinsOzelligi;
begin
  vCon := TSingletonDB.GetInstance.DataBase.NewConnection;
  if vCon.Connected then
    vCon.Close;
  vCon.Name := 'ConnectionMigrate';
  vCon.Params.Clear;
  vCon.Params.Add('DriverID=PG');
  vCon.Params.Add('CharacterSet=UTF8');
  vCon.Params.Add('Server=' + 'localhost');
  vCon.Params.Add('Database=' + 'aybey_daily');
  vCon.Params.Add('User_Name=' + 'guest');
  vCon.Params.Add('Password=' + '123');
  vCon.Params.Add('Port=' + '5432');
  vCon.Params.Add('ApplicationName=' + 'THS ERP Framework Migrate');
  vCon.LoginPrompt := False;
  vCon.Open;

  vOld := TSingletonDB.GetInstance.DataBase.NewQuery(vCon);

  vStokGrubuTuru := TStokGrubuTuru.Create(TSingletonDB.GetInstance.DataBase);
  vStokGrubu := TStokGrubu.Create(TSingletonDB.GetInstance.DataBase);
  vKDV := TAyarVergiOrani.Create(TSingletonDB.GetInstance.DataBase);
  vStokKarti := TStokKarti.Create(TSingletonDB.GetInstance.DataBase);
  vStokKarti2 := TStokKarti.Create(TSingletonDB.GetInstance.DataBase);
  vOlcuBirimi := TOlcuBirimi.Create(TSingletonDB.GetInstance.DataBase);
  vStokTipi := TStokTipi.Create(TSingletonDB.GetInstance.DataBase);
  vUlke := TUlke.Create(TSingletonDB.GetInstance.DataBase);
  vCins := TCinsOzelligi.Create(TSingletonDB.GetInstance.DataBase);
  try
    vStokGrubuTuru.Database.Connection.StartTransaction;
    //burasý stok grubu turlerini getirir
//    vOld.Close;
//    vOld.SQL.Clear;
//    vOld.SQL.Text := 'SELECT tur FROM mal_grubu_turleri ORDER BY tur ASC';
//    vOld.Open;
//    vOld.First;
//
//    pb1.Max := vOld.RecordCount;
//    pb1.Step := 1;
//    pb1.Position := 1;
//    pb1.Enabled := True;
//
//    while not vOld.Eof do
//    begin
//      if not vOld.Fields.Fields[0].IsNull then
//      begin
//        vStokGrubuTuru.Clear;
//        vStokGrubuTuru.Tur.Value := vOld.Fields.Fields[0].AsString;
//        vStokGrubuTuru.Insert(vID, False);
//      end;
//
//      vOld.Next;
//      pb1.Position := pb1.Position + 1;
//    end;

    //burasý stok gruplarýný getirir
//    vOld.Close;
//    vOld.SQL.Clear;
//    vOld.SQL.Text :=
//      'SELECT grup, alim_hesabi, satim_hesabi, hammadde_hesabi, mamul_hesabi, kdv, tur, ' +
//        'iskonto_aktif, satis_iskontosu, mudur_iskontosu, satis_fiyatini_kullan, yarimamul_hesabi, ' +
//        'is_maliyet_analizde_diger_db_kullan ' +
//      'FROM mal_gruplari ORDER BY grup ASC';
//    vOld.Open;
//    vOld.First;
//
//    pb1.Max := vOld.RecordCount;
//    pb1.Step := 1;
//    pb1.Position := 1;
//    pb1.Enabled := True;
//
//    while not vOld.Eof do
//    begin
//      if not vOld.Fields.Fields[0].IsNull then
//      begin
//        vKDV.SelectToList(' and ' + vKDV.VergiOrani.FieldName + '=' + QuotedStr(vOld.Fields.Fields[5].AsString), False, False);
//        vStokGrubuTuru.SelectToList(' and ' + vStokGrubuTuru.Tur.FieldName + '=' + QuotedStr(vOld.Fields.Fields[6].AsString), False, False);
//
//        vStokGrubu.Clear;
//        vStokGrubu.Grup.Value := vOld.Fields.Fields[0].AsString;
//        vStokGrubu.AlisHesabi.Value := vOld.Fields.Fields[1].AsString;
//        vStokGrubu.SatisHesabi.Value := vOld.Fields.Fields[2].AsString;
//        vStokGrubu.HammaddeHesabi.Value := vOld.Fields.Fields[3].AsString;
//        vStokGrubu.MamulHesabi.Value := vOld.Fields.Fields[4].AsString;
//        vStokGrubu.KDVOraniID.Value := vKDV.Id.Value;
//        vStokGrubu.TurID.Value := vStokGrubuTuru.Id.Value;
//        vStokGrubu.IsIskontoAktif.Value := vOld.Fields.Fields[7].AsBoolean;
//        vStokGrubu.IskontoSatis.Value := vOld.Fields.Fields[8].AsFloat;
//        vStokGrubu.IskontoMudur.Value := vOld.Fields.Fields[9].AsFloat;
//        vStokGrubu.IsSatisFiyatiniKullan.Value := vOld.Fields.Fields[10].AsBoolean;
//        vStokGrubu.YariMamulHesabi.Value := vOld.Fields.Fields[11].AsString;
//        vStokGrubu.IsMaliyetAnalizFarkliDB.Value := vOld.Fields.Fields[12].AsBoolean;
//        vStokGrubu.Insert(vID, False);
//      end;
//
//      vOld.Next;
//      pb1.Position := pb1.Position + 1;
//    end;

    //burasý stok kartýlarýný getirir
//    vOld.Close;
//    vOld.SQL.Clear;
//    vOld.SQL.Text :=
//      'SELECT ' +
//        'mal_kodu, mal_adi, grup, olcu_birimi, alis_iskonto, stok_tipi, ' +
//        'ham_alis_fiyati, ham_alis_para_birimi, alis, alis_para_birimi, ' +
//        'satis, satis_para_birimi, ihrac_fiyati, ihrac_para_birimi, ortalama_maliyet, ' +
//        'default_recete_id, en, boy, yukseklik, mensei, gtip_no, ' +
//        'diib_urun_tanimi, esik_deger, tanim, ozel, marka, ' +
//        'agirlik, kapasite, cins, string_degisken1, string_degisken2, ' +
//        'string_degisken3, string_degisken4, string_degisken5, string_degisken6, ' +
//        'integer_degisken1, integer_degisken2, integer_degisken3, double_degisken1, ' +
//        'double_degisken2, double_degisken3, is_teklif_siparis_alinabilir, is_ana_urun, ' +
//        'is_yari_mamul, is_otomatik_uretim_urunu, is_aybey_ozet_urun, lot_parti_miktari, ' +
//        'paket_miktari, serino_turu, is_harici_serino_icerir, harici_serino_mal_kodu, ' +
//        'tasiyici_paket_id, onceki_donem_cikan, temin_suresi, ' +
//        'stock_name, en_string_degisken1, en_string_degisken2, en_string_degisken3, ' +
//        'en_string_degisken4, en_string_degisken5, en_string_degisken6 ' +
//      'FROM mallar ORDER BY mal_kodu ASC';
//    vOld.Open;
//    vOld.First;
//
//    pb1.Max := vOld.RecordCount;
//    pb1.Step := 1;
//    pb1.Position := 1;
//    pb1.Enabled := True;
//
//    while not vOld.Eof do
//    begin
//      if not vOld.Fields.Fields[0].IsNull then
//      begin
//        vStokGrubu.SelectToList(' and ' + vStokGrubu.Grup.FieldName + '=' + QuotedStr(vOld.Fields.Fields[2].AsString), False, False);
//        vOlcuBirimi.SelectToList(' and ' + vOlcuBirimi.Birim.FieldName + '=' + QuotedStr(vOld.Fields.Fields[3].AsString), False, False);
//        vStokTipi.SelectToList(' and ' + vStokTipi.Tip.FieldName + '=' + QuotedStr(vOld.Fields.Fields[5].AsString), False, False);
//        vUlke.SelectToList(' and ' + vUlke.UlkeAdi.FieldName + '=' + QuotedStr(vOld.Fields.Fields[19].AsString), False, False);
//        vCins.SelectToList(' and ' + vCins.Cins.FieldName + '=' + QuotedStr(vOld.Fields.Fields[28].AsString), False, False);
//
//        vStokKarti.StokKodu.Value := vOld.Fields.Fields[0].AsString;
//        vStokKarti.StokAdi.Value := vOld.Fields.Fields[1].AsString;
//        if vStokGrubu.Id.Value > 0 then
//          vStokKarti.StokGrubuID.Value := vStokGrubu.Id.Value
//        else
//          vStokKarti.StokGrubuID.Value := 0;
//
//        if vOlcuBirimi.Id.Value > 0 then
//          vStokKarti.OlcuBirimiID.Value := vOlcuBirimi.Id.Value
//        else
//          vStokKarti.OlcuBirimiID.Value := 0;
//
//        vStokKarti.AlisIskonto.Value := vOld.Fields.Fields[4].AsFloat;
//        vStokKarti.SatisIskonto.Value := 0.0;
//        vStokKarti.YetkiliIskonto.Value := 0.0;
//
//        if vStokTipi.Id.Value > 0 then
//          vStokKarti.StokTipiID.Value := vStokTipi.Id.Value
//        else
//          vStokKarti.StokTipiID.Value := 0;
//        vStokKarti.HamAlisFiyat.Value := vOld.Fields.Fields[6].AsFloat;
//        vStokKarti.HamAlisParaBirimi.Value := vOld.Fields.Fields[7].AsString;
//        vStokKarti.AlisFiyat.Value := vOld.Fields.Fields[8].AsFloat;
//        vStokKarti.AlisParaBirimi.Value := vOld.Fields.Fields[9].AsString;
//        vStokKarti.SatisFiyat.Value := vOld.Fields.Fields[10].AsFloat;
//        vStokKarti.SatisParaBirimi.Value := vOld.Fields.Fields[11].AsString;
//        vStokKarti.IhracFiyat.Value := vOld.Fields.Fields[12].AsFloat;
//        vStokKarti.IhracParaBirimi.Value := vOld.Fields.Fields[13].AsString;
//        vStokKarti.OrtalamaMaliyet.Value := vOld.Fields.Fields[14].AsFloat;
//        vStokKarti.VarsayilaReceteID.Value := vOld.Fields.Fields[15].AsInteger;
//        vStokKarti.En.Value := vOld.Fields.Fields[16].AsFloat;
//        vStokKarti.Boy.Value := vOld.Fields.Fields[17].AsFloat;
//        vStokKarti.Yukseklik.Value := vOld.Fields.Fields[18].AsFloat;
//        if vUlke.Id.Value > 0 then
//          vStokKarti.MenseiID.Value := vUlke.Id.Value
//        else
//          vStokKarti.MenseiID.Value := 0;
//        vStokKarti.GtipNo.Value := vOld.Fields.Fields[20].AsString;
//        vStokKarti.DiibUrunTanimi.Value := vOld.Fields.Fields[21].AsString;
//        vStokKarti.EnAzStokSeviyesi.Value := vOld.Fields.Fields[22].AsFloat;
//        vStokKarti.Tanim.Value := vOld.Fields.Fields[23].AsString;
//        vStokKarti.OzelKod.Value := vOld.Fields.Fields[24].AsString;
//        vStokKarti.Marka.Value := vOld.Fields.Fields[25].AsString;
//        vStokKarti.Agirlik.Value := vOld.Fields.Fields[26].AsFloat;
//        vStokKarti.Kapasite.Value := vOld.Fields.Fields[27].AsFloat;
//        if vCins.Id.Value > 0 then
//          vStokKarti.CinsID.Value := vCins.Id.Value
//        else
//          vStokKarti.CinsID.Value := 0;
//        vStokKarti.StringDegisken1.Value := vOld.Fields.Fields[29].AsString;
//        vStokKarti.StringDegisken2.Value := vOld.Fields.Fields[30].AsString;
//        vStokKarti.StringDegisken3.Value := vOld.Fields.Fields[31].AsString;
//        vStokKarti.StringDegisken4.Value := vOld.Fields.Fields[32].AsString;
//        vStokKarti.StringDegisken5.Value := vOld.Fields.Fields[33].AsString;
//        vStokKarti.StringDegisken6.Value := vOld.Fields.Fields[34].AsString;
//        vStokKarti.IntegerDegisken1.Value := vOld.Fields.Fields[35].AsInteger;
//        vStokKarti.IntegerDegisken2.Value := vOld.Fields.Fields[36].AsInteger;
//        vStokKarti.IntegerDegisken3.Value := vOld.Fields.Fields[37].AsInteger;
//        vStokKarti.DoubleDegisken1.Value := vOld.Fields.Fields[38].AsFloat;
//        vStokKarti.DoubleDegisken2.Value := vOld.Fields.Fields[39].AsFloat;
//        vStokKarti.DoubleDegisken3.Value := vOld.Fields.Fields[40].AsFloat;
//
//        vStokKarti.IsSatilabilir.Value := vOld.Fields.Fields[41].AsBoolean;
//        vStokKarti.IsAnaUrun.Value := vOld.Fields.Fields[42].AsBoolean;
//        vStokKarti.IsYariMamul.Value := vOld.Fields.Fields[43].AsBoolean;
//        vStokKarti.IsOtomatikUretimUrunu.Value := vOld.Fields.Fields[44].AsBoolean;
//        vStokKarti.IsOzetUrun.Value := vOld.Fields.Fields[45].AsBoolean;
//        vStokKarti.LotPartiMiktari.Value := vOld.Fields.Fields[46].AsFloat;
//        vStokKarti.PaketMiktari.Value := vOld.Fields.Fields[47].AsFloat;
//        vStokKarti.SeriNoTuru.Value := vOld.Fields.Fields[48].AsString;
//
//        vStokKarti.IsHariciSeriNoIcerir.Value := vOld.Fields.Fields[49].AsBoolean;
//        vStokKarti.HariciSeriNoStokKoduID.Value := 0;
//        vStokKarti.TasiyiciPaketID.Value := 0;
//        vStokKarti.OncekiDonemCikanMiktar.Value := vOld.Fields.Fields[52].AsFloat;
//        vStokKarti.TeminSuresi.Value := vOld.Fields.Fields[53].AsInteger;
//
//        vStokKarti.StockName.Value := vOld.Fields.Fields[54].AsString;
//        vStokKarti.EnStringDegisken1.Value := vOld.Fields.Fields[55].AsString;
//        vStokKarti.EnStringDegisken2.Value := vOld.Fields.Fields[56].AsString;
//        vStokKarti.EnStringDegisken3.Value := vOld.Fields.Fields[57].AsString;
//        vStokKarti.EnStringDegisken4.Value := vOld.Fields.Fields[58].AsString;
//        vStokKarti.EnStringDegisken5.Value := vOld.Fields.Fields[59].AsString;
//        vStokKarti.EnStringDegisken6.Value := vOld.Fields.Fields[60].AsString;
//
//        vStokKarti.Insert(vID);
//
//        vOld.Next;
//        pb1.Position := pb1.Position + 1;
//      end;
//    end;

    //burasý stok kartýlarýný getirir
    vOld.Close;
    vOld.SQL.Clear;
    vOld.SQL.Text :=
      'SELECT ' +
        'mal_kodu, harici_serino_mal_kodu ' +
      'FROM mallar WHERE harici_serino_mal_kodu is not null ORDER BY mal_kodu ASC';
    vOld.Open;
    vOld.First;

    pb1.Max := vOld.RecordCount;
    pb1.Step := 1;
    pb1.Position := 1;
    pb1.Enabled := True;

    while not vOld.Eof do
    begin
      if not vOld.Fields.Fields[0].IsNull then
      begin
        //harici serino mal kodu için id bilgisi bulunacak
        vStokKarti2.SelectToList(' and ' + vStokKarti2.StokKodu.FieldName + '=' + QuotedStr(vOld.Fields.Fields[1].AsString), False, False);
        //normal stok kartý çekilecek ve hariciserino id bilgisi güncellenecek
        vStokKarti.SelectToList(' and ' + vStokKarti.StokKodu.FieldName + '=' + QuotedStr(vOld.Fields.Fields[0].AsString), False, False);
        vStokKarti.HariciSeriNoStokKoduID.Value := vStokKarti2.Id.Value;
        vStokKarti.Update(False);
      end;
      vOld.Next;
      pb1.Position := pb1.Position + 1;
    end;
    vStokGrubuTuru.Database.Connection.Commit;
  finally
    vOld.Free;
    vCon.Close;
    vCon.Free;
    vStokGrubuTuru.Free;
    vStokGrubu.Free;
    vKDV.Free;
    vStokKarti.Free;
    vStokKarti2.Free;
    vOlcuBirimi.Free;
    vStokTipi.Free;
    vUlke.Free;
    vCins.Free;
  end;
end;

procedure TfrmMain.btnAyarStokHareketTipiClick(Sender: TObject);
begin
  TfrmAyarStokHareketTipleri.Create(Self, Self,
      TAyarStokHareketTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarTeklifDurumlarClick(Sender: TObject);
begin
  TfrmAyarTeklifDurumlar.Create(Self, Self, TAyarTeklifDurum.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarVergiOraniClick(Sender: TObject);
begin
  TfrmAyarVergiOranlari.Create(Self, Self, TAyarVergiOrani.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnBankalarClick(Sender: TObject);
begin
  TfrmBankalar.Create(Self, Self, TBanka.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnBankaSubeleriClick(Sender: TObject);
begin
  TfrmBankaSubeleri.Create(Self, Self, TBankaSubesi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnBolgeTuruClick(Sender: TObject);
begin
  TfrmBolgeTurleri.Create(Self, Self, TBolgeTuru.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnCinsAileleriClick(Sender: TObject);
begin
  TfrmCinsAileleri.Create(Self, Self, TCinsAilesi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnCinsOzellikleriClick(Sender: TObject);
begin
  TfrmCinsOzellikleri.Create(Self, Self, TCinsOzelligi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  if CustomMsgDlg(
    TranslateText('Application terminated. Are you sure you want close application?', FrameworkLang.MessageApplicationTerminate, LngMessage, LngSystem),
    mtConfirmation, mbYesNo, [TranslateText('Yes', FrameworkLang.GeneralYesLower, LngGeneral, LngSystem),
                              TranslateText('No', FrameworkLang.GeneralNoLower, LngGeneral, LngSystem)], mbNo,
                              TranslateText('Confirmation', FrameworkLang.GeneralConfirmationLower, LngGeneral, LngSystem)) = mrYes
  then
    inherited;
end;

procedure TfrmMain.btnDovizKurlariClick(Sender: TObject);
begin
  TfrmDovizKurlari.Create(Self, Self, TDovizKuru.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnHesapGrubuClick(Sender: TObject);
begin
  TfrmHesapGruplari.Create(Self, Self, THesapGrubu.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnOdemeBaslangicDonemiClick(Sender: TObject);
begin
  TfrmAyarOdemeBaslangicDonemleri.Create(Self, Self, TAyarOdemeBaslangicDonemi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnOlcuBirimleriClick(Sender: TObject);
begin
  TfrmOlcuBirimleri.Create(Self, Self, TOlcuBirimi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAmbarlarClick(Sender: TObject);
begin
  TfrmAmbarlar.Create(Self, Self, TAmbar.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelAskerlikDurumuClick(Sender: TObject);
begin
  TfrmAyarPersonelAskerlikDurumlari.Create(Self, Self, TAyarPersonelAskerlikDurumu.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelAyarilmaNedeniTipiClick(Sender: TObject);
begin
  TfrmAyarPersonelAyrilmaNedeniTipleri.Create(Self, Self, TAyarPersonelAyrilmaNedeniTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarBarkodHazirlikDosyaTurleriClick(Sender: TObject);
begin
  TfrmAyarBarkodHazirlikDosyaTurleri.Create(Self, Self, TAyarBarkodHazirlikDosyaTuru.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarBarkodSeriNoTuruClick(Sender: TObject);
begin
  TfrmAyarBarkodSeriNoTurleri.Create(Self, Self, TAyarBarkodSeriNoTuru.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarBarkodTezgahlarClick(Sender: TObject);
begin
  TfrmAyarBarkodTezgahlar.Create(Self, Self, TAyarBarkodTezgah.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarBarkodUrunTuruClick(Sender: TObject);
begin
  TfrmAyarBarkodUrunTurleri.Create(Self, Self, TAyarBarkodUrunTuru.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelCinsiyetClick(Sender: TObject);
begin
  TfrmAyarPersonelCinsiyetler.Create(Self, Self, TAyarPersonelCinsiyet.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelDilClick(Sender: TObject);
begin
  TfrmAyarPersonelDilleri.Create(Self, Self, TAyarPersonelDil.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelDilSeviyesiClick(Sender: TObject);
begin
  TfrmAyarPersonelDilSeviyeleri.Create(Self, Self, TAyarPersonelDilSeviyesi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelEhliyetTipiClick(Sender: TObject);
begin
  TfrmAyarPersonelEhliyetTipleri.Create(Self, Self, TAyarPersonelEhliyetTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarEFaturaFaturaTipiClick(Sender: TObject);
begin
  TfrmAyarEFaturaFaturaTipleri.Create(Self, Self, TAyarEFaturaFaturaTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarEfaturaIletisimKanaliClick(Sender: TObject);
begin
  TfrmAyarEFaturaIletisimKanallari.Create(Self, Self, TAyarEFaturaIletisimKanali.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarEfaturaIstisnaKoduClick(Sender: TObject);
begin
  TfrmAyarEFaturaIstisnaKodlari.Create(Self, Self, TAyarEFaturaIstisnaKodu.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarFirmaTipiClick(Sender: TObject);
begin
  TfrmAyarFirmaTipleri.Create(Self, Self, TAyarFirmaTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarHesapTipleriClick(Sender: TObject);
begin
  TfrmAyarHesapTipleri.Create(Self, Self, TAyarHesapTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelKanGrubuClick(Sender: TObject);
begin
  TfrmAyarPersonelKanGruplari.Create(Self, Self, TAyarPersonelKanGrubu.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelMedeniDurumClick(Sender: TObject);
begin
  TfrmAyarPersonelMedeniDurumlar.Create(Self, Self, TAyarPersonelMedeniDurum.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelMektupTipiClick(Sender: TObject);
begin
  TfrmAyarPersonelMektupTipleri.Create(Self, Self, TAyarPersonelMektupTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelMykTipiClick(Sender: TObject);
begin
  TfrmAyarPersonelMykTipleri.Create(Self, Self, TAyarPersonelMykTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelRaporTipiClick(Sender: TObject);
begin
  TfrmAyarPersonelRaporTipleri.Create(Self, Self, TAyarPersonelRaporTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelSrcTipiClick(Sender: TObject);
begin
  TfrmAyarPersonelSrcTipleri.Create(Self, Self, TAyarPersonelSrcTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelBirimClick(Sender: TObject);
begin
  TfrmAyarPersonelBirimler.Create(Self, Self, TAyarPersonelBirim.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelBolumClick(Sender: TObject);
begin
  TfrmAyarPersonelBolumler.Create(Self, Self, TAyarPersonelBolum.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelGorevClick(Sender: TObject);
begin
  TfrmAyarPersonelGorevler.Create(Self, Self, TAyarPersonelGorev.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelIzinTipiClick(Sender: TObject);
begin
  TfrmAyarPersonelIzinTipleri.Create(Self, Self, TAyarPersonelIzinTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelTatilTipiClick(Sender: TObject);
begin
  TfrmAyarPersonelTatilTipleri.Create(Self, Self, TAyarPersonelTatilTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarPersonelTipiClick(Sender: TObject);
begin
  TfrmAyarPersonelTipleri.Create(Self, Self, TAyarPersonelTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysUserClick(Sender: TObject);
begin
  //
end;

procedure TfrmMain.btnSysUserMacAddressExceptionsClick(Sender: TObject);
begin
  TfrmSysUserMacAddressExceptions.Create(Self, Self, TSysUserMacAddressException.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnTekliflerClick(Sender: TObject);
var
  teklif: TSatisTeklif;
begin
  teklif := TSatisTeklif.Create(TSingletonDB.GetInstance.DataBase);
  teklif.TeklifNo.Value := '142537';
  teklif.MusteriKodu.Value := '120-1-501';
  teklif.MusteriAdi.Value := 'AHMET ASANSÖR';
  teklif.ParaBirimi.Value := TSingletonDB.GetInstance.DataBase.getVarsayilanParaBirimi;
  TfrmSatisTeklifDetaylar.Create(Application, Self, teklif, False, ifmNewRecord, fomSatis).Show;
end;

procedure TfrmMain.btnTeklifTipleriClick(Sender: TObject);
begin
  TfrmAyarTeklifTipleri.Create(Self, Self, TAyarTeklifTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnUlkelerClick(Sender: TObject);
begin
  TfrmUlkeler.Create(Self, Self, TUlke.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnUrunKabulRedNedenleriClick(Sender: TObject);
begin
  TfrmUrunKabulRedNedenleri.Create(Self, Self, TUrunKabulRedNedeni.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.ButtonedEdit1LeftButtonClick(Sender: TObject);
begin
  ShowMessage('sað button týklandý');
end;

procedure TfrmMain.ButtonedEdit1RightButtonClick(Sender: TObject);
begin
  ShowMessage('sað button týklandý');
end;

procedure TfrmMain.btnParaBirimleriClick(Sender: TObject);
begin
  TfrmParaBirimleri.Create(Self, Self, TParaBirimi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnPersonelDilBilgileriClick(Sender: TObject);
begin
  TfrmPersonelDilBilgileri.Create(Self, Self, TPersonelDilBilgisi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnPersonelKartlariClick(Sender: TObject);
begin
  TfrmPersonelKartlari.Create(Self, Self, TPersonelKarti.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnQualityFormMailRecieversClick(Sender: TObject);
begin
  TfrmQualityFormMailRecievers.Create(Self, Self, TQualityFormMailReciever.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysApplicationSettingsClick(Sender: TObject);
var
  vApplicationSetting: TSysApplicationSettings;
begin
  vApplicationSetting := TSysApplicationSettings.Create(TSingletonDB.GetInstance.DataBase);
  vApplicationSetting.SelectToList('', False);
  if vApplicationSetting.List.Count = 0 then
  begin
    vApplicationSetting.Clear;
    TfrmSysApplicationSetting.Create(Self, nil, vApplicationSetting, True, ifmNewRecord).ShowModal
  end
  else if vApplicationSetting.List.Count = 1 then
  begin
    TfrmSysApplicationSetting.Create(Self, nil, vApplicationSetting, True, ifmRewiev).ShowModal;
  end;
end;

procedure TfrmMain.btnSysDefaultOrderFilterClick(Sender: TObject);
begin
  TfrmSysGridDefaultOrderFilters.Create(Self, Self, TSysGridDefaultOrderFilter.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysGridColColorClick(Sender: TObject);
begin
  TfrmSysGridColColors.Create(Self, Self, TSysGridColColor.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysGridColPercentClick(Sender: TObject);
begin
  TfrmSysGridColPercents.Create(Self, Self, TSysGridColPercent.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysGridColWidthClick(Sender: TObject);
begin
  TfrmSysGridColWidths.Create(Self, Self, TSysGridColWidth.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysPermissionSourceClick(Sender: TObject);
begin
  TfrmSysPermissionSources.Create(Self, Self, TSysPermissionSource.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysPermissionSourceGroupClick(Sender: TObject);
begin
  TfrmSysPermissionSourceGroups.Create(Self, Self, TSysPermissionSourceGroup.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysQualityFormNumberClick(Sender: TObject);
begin
  TfrmSysQualityFormNumbers.Create(Self, Self, TSysQualityFormNumber.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysTableLangContentClick(Sender: TObject);
begin
  TfrmSysLangDataContents.Create(Self, Self, TSysLangDataContent.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysLangClick(Sender: TObject);
begin
  TfrmSysLangs.Create(Self, Self, TSysLang.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysLangContentClick(Sender: TObject);
begin
  TfrmSysLangGuiContents.Create(Self, Self, TSysLangGuiContent.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysMultiLangDataTableListsClick(Sender: TObject);
begin
  TfrmSysMultiLangDataTableLists.Create(Self, Self, TSysMultiLangDataTableList.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysUserAccessRightClick(Sender: TObject);
begin
  TfrmSysUserAccessRights.Create(Self, Self, TSysUserAccessRight.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.SetTitleFromLangContent(Sender: TControl);
var
  n1: Integer;
begin
  //Ana formdaki butonlarýn isimleri þu formata uygun olacak. btn + herhangi bir isim btnCity veya btncity
  //dil dosyasýna bakarken de "ButonCaption.Main.city" þeklinde olacak
  if Sender = nil then
  begin
    Sender := pnlMain;
    SetTitleFromLangContent(Sender);
  end;


  for n1 := 0 to TWinControl(Sender).ControlCount-1 do
  begin
    if TWinControl(Sender).Controls[n1].ClassType = TPageControl then
      SetTitleFromLangContent(TWinControl(Sender).Controls[n1])
    else if TWinControl(Sender).Controls[n1].ClassType = TTabSheet then
    begin
      TTabSheet(TWinControl(Sender).Controls[n1]).Caption :=
        TranslateText(
          TTabSheet(TWinControl(Sender).Controls[n1]).Caption,
          StringReplace(TTabSheet(TWinControl(Sender).Controls[n1]).Name, PREFIX_TABSHEET, '', [rfReplaceAll]),
          LngTab, LngMainTable
        );
      SetTitleFromLangContent(TWinControl(Sender).Controls[n1])
    end
    else if TWinControl(Sender).Controls[n1].ClassType = TButton then
    begin
      TButton(TWinControl(Sender).Controls[n1]).Caption :=
          TranslateText(
              TButton(TWinControl(Sender).Controls[n1]).Caption,
              StringReplace(TButton(TWinControl(Sender).Controls[n1]).Name, PREFIX_BUTTON, '', [rfReplaceAll]),
              LngButton, LngMainTable
          );
    end;
  end;

end;

procedure TfrmMain.SetButtonPopup(Sender: TControl = nil);
var
  n1: Integer;
begin
  if Sender = nil then
  begin
    Sender := pnlMain;
    SetButtonPopup(Sender);
  end;


  for n1 := 0 to TWinControl(Sender).ControlCount-1 do
  begin
    if TWinControl(Sender).Controls[n1].ClassType = TPageControl then
      SetButtonPopup(TWinControl(Sender).Controls[n1])
    else if TWinControl(Sender).Controls[n1].ClassType = TTabSheet then
    begin
      TTabSheet(TWinControl(Sender).Controls[n1]).PopupMenu := pmButtons;
      SetButtonPopup(TWinControl(Sender).Controls[n1])
    end
    else if TWinControl(Sender).Controls[n1].ClassType = TButton then
    begin
      TButton(TWinControl(Sender).Controls[n1]).PopupMenu := pmButtons;
    end;
  end;

end;

procedure TfrmMain.btnStokGrubuTurleriClick(Sender: TObject);
begin
  TfrmStokGrubuTurleri.Create(Self, Self, TStokGrubuTuru.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnStokGruplariClick(Sender: TObject);
begin
  TfrmStokGruplari.Create(Self, Self, TStokGrubu.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnStokHareketiClick(Sender: TObject);
begin
  TfrmStokHareketleri.Create(Self, Self, TStokHareketi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnStokKartlariClick(Sender: TObject);
begin
  TfrmStokKartlari.Create(Self, Self, TStokKarti.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnStokTipiClick(Sender: TObject);
begin
  TfrmStokTipleri.Create(Self, Self, TStokTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

destructor TfrmMain.Destroy;
begin
  if stbBase.Panels.Count > 0 then
  begin
    repeat
      stbBase.Panels.Items[stbBase.Panels.Count-1].Free;
    until (stbBase.Panels.Count = 0);
  end;
  stbBase.Free;

  TSingletonDB.GetInstance.Free;

  inherited;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  inherited;
  Application.Terminate;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  inherited;

//  TVclStylesSystemMenu.Create(Self);
  btnClose.Visible := True;
  pnlBottom.Visible := False;
  stbBase.Visible := True;
  pnlBottom.Visible := True;

  pmButtons.Images := TSingletonDB.GetInstance.ImageList16;
  mniAddLanguageContent.ImageIndex := IMG_ADD_DATA;


  btnClose.Images := TSingletonDB.GetInstance.ImageList32;
  btnClose.HotImageIndex := IMG_CLOSE;
  btnClose.ImageIndex := IMG_CLOSE;

//  todo
//  1 yapýldý permision code listesini duzenle butun erisim izinleri kodlar üzerinden yürüyecek þekilde deðiþklik yap
//  2 standart erisim kodlarý için döküman ayarla sabit bilgi olarak girilsin
//  3 yapýldý sys visible colum sýnýfý için ön yüz hazýrla
//  4 kýsmen sistem ayarlarý için sýnýf tanýmla. ondalýklý hane formatý, para formatý, tarih formatý, butun sistem bu formatlar üzerinde ilerleyecek
//  5 yapýldý Output formda arama penceresini ayarla kýsmen yapýldý. kontrol edilecek
//  6 input formlar icin helper penceresi tasarla
//  7 yapýldý excel rapor
//  8 yazýcý ekraný
//  9 detaylý form
//  10 stringgrid base form
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Key := 0;
end;

procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Char(VK_ESCAPE) then
    inherited;
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F6 then
    inherited;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  inherited;

  SetSession();

  SetTitleFromLangContent();

  Self.Caption := TranslateText(Self.Caption, LngMainTable, LngInputFormCaption);

  if TSingletonDB.GetInstance.User.IsSuperUser.Value then
  begin
    SetButtonPopup();
    tsFrameworkSettings.TabVisible := True;
  end
  else
    tsFrameworkSettings.TabVisible := False;

  mniAddLanguageContent.Caption := TranslateText(mniAddLanguageContent.Caption, FrameworkLang.PopupAddLangGuiContent, LngPopup, LngSystem);
end;

procedure TfrmMain.mniAboutClick(Sender: TObject);
begin
  TfrmAbout.Create(Application).ShowModal;
  SetSession;
end;

procedure TfrmMain.mniAddLanguageContentClick(Sender: TObject);
var
  vSysLangGuiContent: TSysLangGuiContent;
  vCode, vValue, vContentType, vTableName: string;
begin
  if pmButtons.PopupComponent.ClassType = TButton then
  begin
    vCode := StringReplace(pmButtons.PopupComponent.Name, PREFIX_BUTTON, '', [rfReplaceAll]);
    vContentType := LngButton;
    vTableName := LngMainTable;
    vValue := TButton(pmButtons.PopupComponent).Caption;
  end
  else
  if pmButtons.PopupComponent.ClassType = TTabSheet then
  begin
    vCode := StringReplace(pmButtons.PopupComponent.Name, PREFIX_TABSHEET, '', [rfReplaceAll]);
    vContentType := LngTab;
    vTableName := LngMainTable;
    vValue := TTabSheet(pmButtons.PopupComponent).Caption;
  end;


  vSysLangGuiContent := TSysLangGuiContent.Create(TSingletonDB.GetInstance.DataBase);

  vSysLangGuiContent.Lang.Value := TSingletonDB.GetInstance.DataBase.ConnSetting.Language;
  vSysLangGuiContent.Code.Value := vCode;
  vSysLangGuiContent.ContentType.Value := vContentType;
  vSysLangGuiContent.TableName1.Value := vTableName;
  vSysLangGuiContent.Value.Value := vValue;

  TfrmSysLangGuiContent.Create(Self, nil, vSysLangGuiContent, True, ifmCopyNewRecord).ShowModal;


  SetTitleFromLangContent();
end;

procedure TfrmMain.mniCloseClick(Sender: TObject);
begin
  btnCloseClick(btnClose);
end;

procedure TfrmMain.ResetSession(pPanelGroupboxPagecontrolTabsheet: TWinControl);
var
  nIndex, nIndex2: Integer;
  PanelContainer: TWinControl;

  procedure DisableButtons(Sender: TWinControl);
  var
    nIndex: Integer;
  begin
    if (Sender.ClassType = TButton) then
    begin
      TButton(Sender).Enabled := False;
    end
    else
    begin
      for nIndex := 0 to Sender.ControlCount -1 do
      begin
        if Sender.Controls[nIndex].ClassType = TButton then
          TButton(Sender.Controls[nIndex]).Enabled := False
      end;
    end;
  end;

begin
  PanelContainer := nil;

  if pPanelGroupboxPagecontrolTabsheet = nil then
    PanelContainer := pnlMain
  else
  begin
    if pPanelGroupboxPagecontrolTabsheet.ClassType = TPanel then
      PanelContainer := pPanelGroupboxPagecontrolTabsheet as TPanel
    else if pPanelGroupboxPagecontrolTabsheet.ClassType = TGroupBox then
      PanelContainer := pPanelGroupboxPagecontrolTabsheet as TGroupBox
    else if pPanelGroupboxPagecontrolTabsheet.ClassType = TPageControl then
      PanelContainer := pPanelGroupboxPagecontrolTabsheet as TPageControl
    else if pPanelGroupboxPagecontrolTabsheet.ClassType = TTabSheet then
      PanelContainer := pPanelGroupboxPagecontrolTabsheet as TTabSheet;
  end;

  if (FormMode=ifmNone) then
  begin
    for nIndex := 0 to PanelContainer.ControlCount -1 do
    begin
      if PanelContainer.Controls[nIndex].ClassType = TPanel then
        DisableButtons(PanelContainer.Controls[nIndex] as TPanel);

      if PanelContainer.Controls[nIndex].ClassType = TGroupBox then
        DisableButtons(PanelContainer.Controls[nIndex] as TGroupBox);

      if PanelContainer.Controls[nIndex].ClassType = TPageControl then
        for nIndex2 := 0 to (PanelContainer.Controls[nIndex] as TPageControl).PageCount-1 do
          DisableButtons((PanelContainer.Controls[nIndex] as TPageControl).Pages[nIndex2]);

      if PanelContainer.Controls[nIndex].ClassType = TTabSheet then
        DisableButtons(PanelContainer.Controls[nIndex] as TTabSheet);

      if PanelContainer.Controls[nIndex].ClassType = TButton then
        DisableButtons( TButton(PanelContainer.Controls[nIndex]) );
    end;
  end;
end;

procedure TfrmMain.SetSession;
var
  vAccessRight: TSysUserAccessRight;
  n1: Integer;
begin
  ResetSession(pnlMain);

  vAccessRight := TSysUserAccessRight.Create(TSingletonDB.GetInstance.DataBase);
  try
    vAccessRight.SelectToList(' and user_name=' + QuotedStr(TSingletonDB.GetInstance.User.UserName.Value), False, False);
    for n1 := 0 to vAccessRight.List.Count-1 do
    begin
      if (TSysUserAccessRight(vAccessRight.List[n1]).IsRead.Value)
      or (TSysUserAccessRight(vAccessRight.List[n1]).IsAddRecord.Value)
      or (TSysUserAccessRight(vAccessRight.List[n1]).IsUpdate.Value)
      or (TSysUserAccessRight(vAccessRight.List[n1]).IsDelete.Value)
      or (TSysUserAccessRight(vAccessRight.List[n1]).IsSpecial.Value)
      then
      begin
        if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1' then
        begin
          btnSysPermissionSourceGroup.Enabled := True;
          btnSysPermissionSource.Enabled := True;
          btnSysUserAccessRight.Enabled := True;
          btnSysLang.Enabled := True;
          btnSysGridColWidth.Enabled := True;
          btnSysGridColColor.Enabled := True;
          btnSysGridColPercent.Enabled := True;
          btnSysLangContent.Enabled := True;
          btnSysTableLangContent.Enabled := True;
          btnStokHareketi.Enabled := True;
          btnSysDefaultOrderFilter.Enabled := True;
          btnSysApplicationSettings.Enabled := True;
          btnSysUser.Enabled := True;
          btnSysUserMacAddressExceptions.Enabled := True;
          btnSysMultiLangDataTableLists.Enabled := True;
        end
        else if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1000' then
        begin
          btnParaBirimleri.Enabled := True;
          btnAyarEFaturaFaturaTipi.Enabled := True;
          btnAyarFirmaTipi.Enabled := True;
          btnAyarEfaturaIletisimKanali.Enabled := True;
          btnAyarEfaturaIstisnaKodu.Enabled := True;
          btnAyarVergiOrani.Enabled := True;
          btnBolgeTuru.Enabled := True;
          btnHesapGrubu.Enabled := True;
          btnAyarStokHareketTipi.Enabled := True;
          btnSysQualityFormNumber.Enabled := True;
          btnUlkeler.Enabled := True;
          btnSehirler.Enabled := True;
          btnAmbarlar.Enabled := True;
          btnQualityFormMailRecievers.Enabled := True;
          btnUrunKabulRedNedenleri.Enabled := True;
          btnStokTipi.Enabled := True;
          btnCinsAileleri.Enabled := True;
          btnStokGrubuTurleri.Enabled := True;
          btnStokGruplari.Enabled := True;
          btnAyarBarkodUrunTuru.Enabled := True;
          btnAyarBarkodSeriNoTuru.Enabled := True;
          btnAyarBarkodHazirlikDosyaTurleri.Enabled := True;
          btnAyarBarkodTezgahlar.Enabled := True;
        end
        else if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1009' then
        begin
          btnDovizKurlari.Enabled := True;
        end
        else if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1020' then
        begin
          btnAyarPersonelBolum.Enabled := True;
          btnAyarPersonelBirim.Enabled := True;
          btnAyarPersonelGorev.Enabled := True;
        end
        else if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1021' then
        begin
          btnPersonelKartlari.Enabled := True;
          btnPersonelDilBilgileri.Enabled := True;
        end
        else if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1011' then
        else if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1013' then
        else if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1030' then
        begin
          btnStokKartlari.Enabled := True;
        end
        else if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1001' then
        begin
        end;
      end;
    end;
  finally
    vAccessRight.Free;
  end;

  btnTeklifler.Enabled := True;
end;

Initialization

end.

