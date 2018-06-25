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
    btnCountry: TButton;
    btnCity: TButton;
    btnCurrency: TButton;
    btnPermissionSource: TButton;
    btnPermissionSourceGroup: TButton;
    btnUserAccessRight: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);override;
    procedure FormCreate(Sender: TObject);override;
    procedure FormShow(Sender: TObject);override;
    procedure btnCountryClick(Sender: TObject);
    procedure AppEvntsBaseIdle(Sender: TObject; var Done: Boolean);
    procedure btnCityClick(Sender: TObject);
    procedure btnCurrencyClick(Sender: TObject);

    procedure SetSession();
    procedure ResetSession(pPanelGroupboxPagecontrolTabsheet: TWinControl);
    procedure mniAboutClick(Sender: TObject);
    procedure btnPermissionSourceGroupClick(Sender: TObject);
    procedure btnPermissionSourceClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);override;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);override;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);override;
    procedure btnUserAccessRightClick(Sender: TObject);

  private
    FDatabase: Ths.Erp.Database.Singleton.TSingletonDB;

    procedure ButonBasliklariniDilDosyasindanGetir(Sender: TControl = nil);
  protected
  published
    procedure btnCloseClick(Sender: TObject); override;
  public
    destructor Destroy; override;
    property SingletonDB: TSingletonDB read FDatabase;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  ufrmAbout,

  Ths.Erp.SpecialFunctions,
  Vcl.Styles.Utils.SystemMenu,

  Ths.Erp.Database.Table.Country,
  ufrmCountries,
  Ths.Erp.Database.Table.Country.City,
  ufrmCities,
  Ths.Erp.Database.Table.Currency,
  ufrmCurrencies,
  ufrmSysUserAccessRights,
  Ths.Erp.Database.Table.SysUserAccessRight,
  ufrmSysPermissionSourceGroups,
  Ths.Erp.Database.Table.SysPermissionSourceGroup,
  ufrmSysPermissionSources,
  Ths.Erp.Database.Table.SysPermissionSource, Ths.Erp.Database.Table.View.SysViewColumns;

procedure TfrmMain.AppEvntsBaseIdle(Sender: TObject; var Done: Boolean);
begin
  inherited;
  //
end;

procedure TfrmMain.btnCityClick(Sender: TObject);
begin
  TfrmCities.Create(Application, Self, TCity.Create(SingletonDB.DataBase), True).Show;
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

procedure TfrmMain.btnCountryClick(Sender: TObject);
begin
  TfrmCountries.Create(Application, Self, TCountry.Create(SingletonDB.DataBase), True).Show;
end;

procedure TfrmMain.btnCurrencyClick(Sender: TObject);
begin
  TfrmCurrencies.Create(Application, Self, TCurrency.Create(SingletonDB.DataBase), True).Show;
end;

procedure TfrmMain.btnPermissionSourceClick(Sender: TObject);
begin
  TfrmSysPermissionSources.Create(Application, Self,
      TSysPermissionSource.Create(SingletonDB.DataBase), True).Show;
end;

procedure TfrmMain.btnPermissionSourceGroupClick(Sender: TObject);
begin
  TfrmSysPermissionSourceGroups.Create(Application, Self,
      TSysPermissionSourceGroup.Create(SingletonDB.DataBase), True).Show;
end;

procedure TfrmMain.btnUserAccessRightClick(Sender: TObject);
begin
  TfrmSysUserAccessRights.Create(Application, Self,
      TSysUserAccessRight.Create(SingletonDB.DataBase), True).Show;
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
              'ButonCaption.Main.' + LowerCase( StringReplace(TButton(TWinControl(Sender).Controls[n1]).Name, 'btn', '', [rfReplaceAll]) ));
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

  SingletonDB.Free;

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
  FDatabase := TSingletonDB.GetInstance;

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

  vAccessRight := TSysUserAccessRight.Create(SingletonDB.DataBase);
  try
    vAccessRight.SelectToList(' and user_name=' + QuotedStr(SingletonDB.User.UserName.Value), False, False);
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
          btnPermissionSourceGroup.Enabled := True;
          btnPermissionSource.Enabled := True;
          btnUserAccessRight.Enabled := True;
        end
        else
        if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1001' then
        begin
          btnCurrency.Enabled := True;
        end
        else
        if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1002' then
        begin
          btnCountry.Enabled := True;
        end
        else
        if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode.Value = '1003' then
        begin
          btnCity.Enabled := True;
        end;
      end;
    end;
  finally
    vAccessRight.Free;
  end;
end;

Initialization

end.
