unit ufrmMain;

interface

uses
  Winapi.Windows, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.ComCtrls, Vcl.Menus, Math, StrUtils, Vcl.ActnList, System.Actions,
  Vcl.AppEvnts, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls, System.Classes,
  System.ImageList, Vcl.ImgList, Dialogs, System.SysUtils,
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
  FireDAC.Phys.Intf, ufrmPersonelBilgileri;

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
    tsStaff: TTabSheet;
    tsFrameworkSettings: TTabSheet;
    tsSettings: TTabSheet;
    btnStokHareketi: TButton;
    pmButtons: TPopupMenu;
    mniAddLanguageContent: TMenuItem;
    btnPersonelBilgisi: TButton;
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
    procedure btnPersonelBilgisiClick(Sender: TObject);
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
  Vcl.Styles.Utils.SystemMenu,
  Ths.Erp.Constants,
  ufrmSysLangGuiContent,
  Ths.Erp.Database.Table.PersonelBilgisi,
  Ths.Erp.Database.Table.View.SysViewColumns,
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
  Ths.Erp.Database.Table.AyarBarkodTezgah, ufrmAyarBarkodTezgahlar;

procedure TfrmMain.AppEvntsBaseIdle(Sender: TObject; var Done: Boolean);
begin
  inherited;
  //
end;

procedure TfrmMain.btnSehirlerClick(Sender: TObject);
begin
  TfrmSehirler.Create(Self, Self, TSehir.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAyarStokHareketTipiClick(Sender: TObject);
begin
  TfrmAyarStokHareketTipleri.Create(Self, Self,
      TAyarStokHareketTipi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
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

procedure TfrmMain.btnOlcuBirimleriClick(Sender: TObject);
begin
  TfrmOlcuBirimleri.Create(Self, Self, TOlcuBirimi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnAmbarlarClick(Sender: TObject);
begin
  TfrmAmbarlar.Create(Self, Self, TAmbar.Create(TSingletonDB.GetInstance.DataBase), True).Show;
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

procedure TfrmMain.btnSysUserClick(Sender: TObject);
begin
  //
end;

procedure TfrmMain.btnSysUserMacAddressExceptionsClick(Sender: TObject);
begin
  TfrmSysUserMacAddressExceptions.Create(Self, Self, TSysUserMacAddressException.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnUlkelerClick(Sender: TObject);
begin
  TfrmUlkeler.Create(Self, Self, TUlke.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnUrunKabulRedNedenleriClick(Sender: TObject);
begin
  TfrmUrunKabulRedNedenleri.Create(Self, Self, TUrunKabulRedNedeni.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnParaBirimleriClick(Sender: TObject);
begin
  TfrmParaBirimleri.Create(Self, Self, TParaBirimi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnPersonelBilgisiClick(Sender: TObject);
begin
  TfrmPersonelBilgileri.Create(Self, Self, TPersonelBilgisi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
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
          btnPersonelBilgisi.Enabled := True;
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
end;

Initialization

end.
