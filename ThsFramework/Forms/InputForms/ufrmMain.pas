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
    btnUlkeler: TButton;
    btnSehirler: TButton;
    btnParaBirimleri: TButton;
    tsFrameworkSettings: TTabSheet;
    btnSysPermissionSource: TButton;
    btnSysPermissionSourceGroup: TButton;
    btnSysUserAccessRight: TButton;
    btnSysLang: TButton;
    btnSysGridColWidth: TButton;
    btnSysGridColColor: TButton;
    btnSysGridColPercent: TButton;
    btnSysLangContent: TButton;
    btnSysQualityFormNumber: TButton;
    btnSysDefaultOrderFilter: TButton;
    btnSysTableLangContent: TButton;
    tsSettings: TTabSheet;
    btnStokHareketi: TButton;
    pmButtons: TPopupMenu;
    mniAddLanguageContent: TMenuItem;
    btnAyarStokHareketTipi: TButton;
    btnSysUser: TButton;
    btnAyarEFaturaFaturaTipi: TButton;
    btnAyarFirmaTipi: TButton;
    btnAyarEfaturaIletisimKanali: TButton;
    btnAyarEfaturaIstisnaKodu: TButton;
    btnSysApplicationSettings: TButton;
    btnPersonelBilgisi: TButton;
    btnAyarPersonelBolum: TButton;
    btnAyarPersonelBirim: TButton;
    btnAyarPersonelGorev: TButton;
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
    procedure FormKeyPress(Sender: TObject; var Key: Char);override;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);override;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);override;
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

  private
    procedure SetTitleFromLangContent(Sender: TControl = nil);
    procedure SetButtonPopup(Sender: TControl = nil);
  protected
  published
    procedure btnCloseClick(Sender: TObject); override;
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
  ufrmSysLangContent,
  Ths.Erp.Database.Table.View.SysViewColumns,
  Ths.Erp.Database.Table.ParaBirimi, ufrmParaBirimleri,
  Ths.Erp.Database.Table.Ulke, ufrmUlkeler,
  Ths.Erp.Database.Table.Sehir, ufrmSehirler,
  Ths.Erp.Database.Table.SysUserAccessRight, ufrmSysUserAccessRights,
  Ths.Erp.Database.Table.SysPermissionSourceGroup, ufrmSysPermissionSourceGroups,
  Ths.Erp.Database.Table.SysPermissionSource, ufrmSysPermissionSources,
  Ths.Erp.Database.Table.SysLang, ufrmSysLangs,
  Ths.Erp.Database.Table.SysLangContents, ufrmSysLangContents,
  Ths.Erp.Database.Table.SysGridColWidth, ufrmSysGridColWidths,
  Ths.Erp.Database.Table.SysGridColColor, ufrmSysGridColColors,
  Ths.Erp.Database.Table.SysGridColPercent, ufrmSysGridColPercents,
  Ths.Erp.Database.Table.SysTableLangContent, ufrmSysTableLangContents,
  Ths.Erp.Database.Table.SysQualityFormNumber, ufrmSysQualityFormNumbers,
  Ths.Erp.Database.Table.AyarStokHareketTipi, ufrmAyarStokHareketTipleri,
  Ths.Erp.Database.Table.StokHareketi, ufrmStokHareketleri,
  Ths.Erp.Database.Table.SysGridDefaultOrderFilter, ufrmSysGridDefaultOrderFilters,
  Ths.Erp.Database.Table.AyarEFaturaFaturaTipi, ufrmAyarEFaturaFaturaTipleri,
  Ths.Erp.Database.Table.AyarFirmaTipi, ufrmAyarFirmaTipleri,
  Ths.Erp.Database.Table.AyarEFaturaIletisimKanali, ufrmAyarEFaturaIletisimKanallari,
  Ths.Erp.Database.Table.AyarEFaturaIstisnaKodu, ufrmAyarEFaturaIstisnaKodlari,
  Ths.Erp.Database.Table.SysApplicationSettings, ufrmSysApplicationSetting,
  Ths.Erp.Database.Table.PersonelBilgisi, ufrmAyarPersonelBolumler, ufrmAyarPersonelBirimler, ufrmAyarPersonelGorevler, Ths.Erp.Database.Table.AyarPersonelBolum, Ths.Erp.Database.Table.AyarPersonelBirim, Ths.Erp.Database.Table.AyarPersonelGorev;

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

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  if CustomMsgDlg(
    GetTextFromLang('Application terminated. Are you sure you want close application?', FrameworkLang.MessageApplicationTerminate, LngMessage, LngSystem),
    mtConfirmation, mbYesNo, [GetTextFromLang('Yes', FrameworkLang.GeneralYesLower, LngGeneral, LngSystem),
                              GetTextFromLang('No', FrameworkLang.GeneralNoLower, LngGeneral, LngSystem)], mbNo,
                              GetTextFromLang('Confirmation', FrameworkLang.GeneralConfirmationLower, LngGeneral, LngSystem)) = mrYes
  then
    inherited;
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
  with TSingletonDB.GetInstance.DataBase.NewQuery do
  try
    SQL.Text := 'SELECT * FROM ali;';
    ExecSQL;
  finally
    Free;
  end;
end;

procedure TfrmMain.btnUlkelerClick(Sender: TObject);
begin
  TfrmUlkeler.Create(Self, Self, TUlke.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnParaBirimleriClick(Sender: TObject);
begin
  TfrmParaBirimleri.Create(Self, Self, TParaBirimi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnPersonelBilgisiClick(Sender: TObject);
begin
  TfrmPersonelBilgileri.Create(Self, Self, TPersonelBilgisi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
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
    TfrmSysApplicationSetting.Create(Self, Self, vApplicationSetting, True, ifmNewRecord).ShowModal
  end
  else if vApplicationSetting.List.Count = 1 then
  begin
    TfrmSysApplicationSetting.Create(Self, Self, vApplicationSetting, True, ifmRewiev).ShowModal;
  end;
end;

procedure TfrmMain.btnSysDefaultOrderFilterClick(Sender: TObject);
begin
  TfrmSysGridDefaultOrderFilters.Create(Self, Self,
      TSysGridDefaultOrderFilter.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysGridColColorClick(Sender: TObject);
begin
  TfrmSysGridColColors.Create(Self, Self,
      TSysGridColColor.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysGridColPercentClick(Sender: TObject);
begin
  TfrmSysGridColPercents.Create(Self, Self,
      TSysGridColPercent.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysGridColWidthClick(Sender: TObject);
begin
  TfrmSysGridColWidths.Create(Self, Self,
      TSysGridColWidth.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysPermissionSourceClick(Sender: TObject);
begin
  TfrmSysPermissionSources.Create(Self, Self,
      TSysPermissionSource.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysPermissionSourceGroupClick(Sender: TObject);
begin
  TfrmSysPermissionSourceGroups.Create(Self, Self,
      TSysPermissionSourceGroup.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysQualityFormNumberClick(Sender: TObject);
begin
  TfrmSysQualityFormNumbers.Create(Self, Self,
      TSysQualityFormNumber.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysTableLangContentClick(Sender: TObject);
begin
  TfrmSysTableLangContents.Create(Self, Self,
      TSysTableLangContent.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysLangClick(Sender: TObject);
begin
  TfrmSysLangs.Create(Self, Self,
      TSysLang.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysLangContentClick(Sender: TObject);
begin
  TfrmSysLangContents.Create(Self, Self,
      TSysLangContents.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysUserAccessRightClick(Sender: TObject);
begin
  TfrmSysUserAccessRights.Create(Self, Self,
      TSysUserAccessRight.Create(TSingletonDB.GetInstance.DataBase), True).Show;
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
        GetTextFromLang(
          TTabSheet(TWinControl(Sender).Controls[n1]).Caption,
          StringReplace(TTabSheet(TWinControl(Sender).Controls[n1]).Name, PREFIX_TABSHEET, '', [rfReplaceAll]),
          LngTab, LngMainTable
        );
      SetTitleFromLangContent(TWinControl(Sender).Controls[n1])
    end
    else if TWinControl(Sender).Controls[n1].ClassType = TButton then
    begin
      TButton(TWinControl(Sender).Controls[n1]).Caption :=
          GetTextFromLang(
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

procedure TfrmMain.btnStokHareketiClick(Sender: TObject);
begin
  TfrmStokHareketleri.Create(Self, Self,
      TStokHareketi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
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
  TVclStylesSystemMenu.Create(Self);
  btnClose.Visible := True;
  pnlBottom.Visible := False;
  stbBase.Visible := True;
  pnlBottom.Visible := True;

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
  if Key = VK_RETURN then
    Key := 0;
  inherited;
  //
end;

procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  //
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Key := 0;
  inherited;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  inherited;

  SetSession();

  SetTitleFromLangContent();

  Self.Caption := GetTextFromLang(Self.Caption, LngMainTable, LngInputFormCaption);

  if TSingletonDB.GetInstance.User.IsSuperUser.Value then
  begin
    SetButtonPopup();
    tsFrameworkSettings.TabVisible := True;
  end
  else
    tsFrameworkSettings.TabVisible := False;

  mniAddLanguageContent.Caption := GetTextFromLang(mniAddLanguageContent.Caption, FrameworkLang.PopupAddLanguageContent, LngPopup, LngSystem);
end;

procedure TfrmMain.mniAboutClick(Sender: TObject);
begin
  TfrmAbout.Create(Application).ShowModal;
  SetSession;
end;

procedure TfrmMain.mniAddLanguageContentClick(Sender: TObject);
var
  vSysLangContent: TSysLangContents;
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



  vSysLangContent := TSysLangContents.Create(TSingletonDB.GetInstance.DataBase);

  vSysLangContent.Lang.Value := TSingletonDB.GetInstance.DataBase.ConnSetting.Language;
  vSysLangContent.Code.Value := vCode;
  vSysLangContent.ContentType.Value := vContentType;
  vSysLangContent.TableName1.Value := vTableName;
  vSysLangContent.Value.Value := vValue;

  TfrmSysLangContent.Create(Self, Self, vSysLangContent, True, ifmCopyNewRecord).ShowModal;


  SetTitleFromLangContent();
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
        end
        else if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1000' then
        begin
          btnSysUser.Enabled := True;
          btnAyarEFaturaFaturaTipi.Enabled := True;
          btnAyarFirmaTipi.Enabled := True;
          btnAyarEfaturaIletisimKanali.Enabled := True;
          btnAyarEfaturaIstisnaKodu.Enabled := True;
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
          btnSysQualityFormNumber.Enabled := True
        else if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1013' then
          btnAyarStokHareketTipi.Enabled := True
        else if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1001' then
        begin
          btnParaBirimleri.Enabled := True;
        end
        else
        if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1002' then
        begin
          btnUlkeler.Enabled := True;
        end
        else
        if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1003' then
        begin
          btnSehirler.Enabled := True;
        end;
      end;
    end;
  finally
    vAccessRight.Free;
  end;
end;

Initialization

end.
