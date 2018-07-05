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
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait;

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
    tsSettings: TTabSheet;
    btnSysPermissionSource: TButton;
    btnSysPermissionSourceGroup: TButton;
    btnSysUserAccessRight: TButton;
    btnSysLang: TButton;
    btnSysGridColWidth: TButton;
    btnSysGridColColor: TButton;
    btnSysGridColPercent: TButton;
    btnSysLangContent: TButton;
    btnSysQualityFormNumber: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);override;
    procedure FormCreate(Sender: TObject);override;
    procedure FormShow(Sender: TObject);override;
    procedure btnUlkelerClick(Sender: TObject);
    procedure AppEvntsBaseIdle(Sender: TObject; var Done: Boolean);
    procedure btnSehirlerClick(Sender: TObject);
    procedure btnParaBirimleriClick(Sender: TObject);

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

  private
    procedure ButonBasliklariniDilDosyasindanGetir(Sender: TControl = nil);
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
  Ths.Erp.Database.Table.View.SysViewColumns,
  Ths.Erp.Database.Table.ParaBirimi,
  ufrmParaBirimleri,
  Ths.Erp.Database.Table.Ulke,
  ufrmUlkeler,
  Ths.Erp.Database.Table.Sehir,
  ufrmSehirler,
  Ths.Erp.Database.Table.SysUserAccessRight,
  ufrmSysUserAccessRights,
  Ths.Erp.Database.Table.SysPermissionSourceGroup,
  ufrmSysPermissionSourceGroups,
  Ths.Erp.Database.Table.SysPermissionSource,
  ufrmSysPermissionSources,
  Ths.Erp.Database.Table.SysLang,
  ufrmSysLangs,
  Ths.Erp.Database.Table.SysLangContents,
  ufrmSysLangContents,
  Ths.Erp.Database.Table.SysGridColWidth,
  ufrmSysGridColWidths,
  Ths.Erp.Database.Table.SysGridColColor,
  ufrmSysGridColColors,
  Ths.Erp.Database.Table.SysGridColPercent,
  ufrmSysGridColPercents;

procedure TfrmMain.AppEvntsBaseIdle(Sender: TObject; var Done: Boolean);
begin
  inherited;
  //
end;

procedure TfrmMain.btnSehirlerClick(Sender: TObject);
begin
  TfrmSehirler.Create(Application, Self, TSehir.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  if TSpecialFunctions.CustomMsgDlg(
    TSingletonDB.GetInstance.GetTextFromLang('Application terminated. Are you sure you want close application?', TSingletonDB.GetInstance.LangFramework.MesajUygulamaKapatma),
    mtConfirmation, mbYesNo, [TSingletonDB.GetInstance.GetTextFromLang('Yes', TSingletonDB.GetInstance.LangFramework.MantikEvetKucuk),
                              TSingletonDB.GetInstance.GetTextFromLang('No', TSingletonDB.GetInstance.LangFramework.MantikHayirKucuk)], mbNo,
                              TSingletonDB.GetInstance.GetTextFromLang('Confirmation', TSingletonDB.GetInstance.LangFramework.IslemOnayiKucuk)) = mrYes
  then
    inherited;
end;

procedure TfrmMain.btnUlkelerClick(Sender: TObject);
begin
  TfrmUlkeler.Create(Application, Self, TUlke.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnParaBirimleriClick(Sender: TObject);
begin
  TfrmParaBirimleri.Create(Application, Self, TParaBirimi.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysGridColColorClick(Sender: TObject);
begin
  TfrmSysGridColColors.Create(Application, Self,
      TSysGridColColor.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysGridColPercentClick(Sender: TObject);
begin
  TfrmSysGridColPercents.Create(Application, Self,
      TSysGridColPercent.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysGridColWidthClick(Sender: TObject);
begin
  TfrmSysGridColWidths.Create(Application, Self,
      TSysGridColWidth.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysPermissionSourceClick(Sender: TObject);
begin
  TfrmSysPermissionSources.Create(Application, Self,
      TSysPermissionSource.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysPermissionSourceGroupClick(Sender: TObject);
begin
  TfrmSysPermissionSourceGroups.Create(Application, Self,
      TSysPermissionSourceGroup.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysQualityFormNumberClick(Sender: TObject);
begin
  //
end;

procedure TfrmMain.btnSysLangClick(Sender: TObject);
begin
  TfrmSysLangs.Create(Application, Self,
      TSysLang.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysLangContentClick(Sender: TObject);
begin
  TfrmSysLangContents.Create(Application, Self,
      TSysLangContents.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.btnSysUserAccessRightClick(Sender: TObject);
begin
  TfrmSysUserAccessRights.Create(Application, Self,
      TSysUserAccessRight.Create(TSingletonDB.GetInstance.DataBase), True).Show;
end;

procedure TfrmMain.ButonBasliklariniDilDosyasindanGetir(Sender: TControl);
var
  n1: Integer;
begin
  //Ana formdaki butonlarýn isimleri þu formata uygun olacak. btn + herhangi bir isim btnCity veya btncity
  //dil dosyasýna bakarken de "ButonCaption.Main.city" þeklinde olacak
  if Sender = nil then
  begin
    Sender := pnlMain;
    ButonBasliklariniDilDosyasindanGetir(Sender);
  end;


  for n1 := 0 to TWinControl(Sender).ControlCount-1 do
  begin
    if TWinControl(Sender).Controls[n1].ClassType = TPageControl then
      ButonBasliklariniDilDosyasindanGetir(TWinControl(Sender).Controls[n1])
    else if TWinControl(Sender).Controls[n1].ClassType = TTabSheet then
      ButonBasliklariniDilDosyasindanGetir(TWinControl(Sender).Controls[n1])
    else if TWinControl(Sender).Controls[n1].ClassType = TButton then
    begin
      TButton(TWinControl(Sender).Controls[n1]).Caption :=
          TSingletonDB.GetInstance.GetTextFromLang(
              TButton(TWinControl(Sender).Controls[n1]).Caption,
              'ButonCaption.Main.' + StringReplace(TButton(TWinControl(Sender).Controls[n1]).Name, 'btn', '', [rfReplaceAll])
          );
    end;
  end;

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

  //todo
//  1 permision code listesini duzenle butun erisim izinleri kodlar üzerinden yürüyecek þekilde deðiþklik yap
//  2 standart erisim kodlarý için döküman ayarla sabit bilgi olarak girilsin
//  3 sys visible colum sýnýfý için ön yüz hazýrla
//  4 sistem ayarlarý için sýnýf tanýmla. ondalýklý hane formatý, para formatý, tarih formatý, butun sistem bu formatlar üzerinde ilerleyecek
//  5 Output formda arama penceresini ayarla kýsmen yapýldý. kontrol edilecek
//  6 input formlar icin helper penceresi tasarla
//  7 excel rapor
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

  ButonBasliklariniDilDosyasindanGetir();
end;

procedure TfrmMain.mniAboutClick(Sender: TObject);
begin
  TfrmAbout.Create(Application).ShowModal;
  SetSession;
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
        if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1000' then
        begin
          btnSysPermissionSourceGroup.Enabled := True;
          btnSysPermissionSource.Enabled := True;
          btnSysUserAccessRight.Enabled := True;
          btnSysLang.Enabled := True;
          btnSysGridColWidth.Enabled := True;
          btnSysGridColColor.Enabled := True;
          btnSysGridColPercent.Enabled := True;
          btnSysLangContent.Enabled := True;
          btnSysQualityFormNumber.Enabled := True;
        end
        else
        if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1001' then
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
