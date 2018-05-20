unit ufrmMain;

interface

uses
  Winapi.Windows, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.Menus, Math, StrUtils, Vcl.ActnList, System.Actions,
  Vcl.AppEvnts, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls, System.Classes,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin, Dialogs, System.SysUtils,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  ufrmBase, ufrmBaseDBGrid, ufrmBaseStrGrid,
  Ths.Erp.Database,
  Ths.Erp.Database.Singleton;

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
    btnCountries: TBitBtn;
    btnPersonelBolumler: TBitBtn;
    btnPersonelBirimler: TBitBtn;
    btnPersonelGorevler: TBitBtn;
    btnPersonelBilgileri: TBitBtn;
    btnCities: TBitBtn;
    btnCurrencies: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);override;
    procedure FormCreate(Sender: TObject);override;
    procedure FormShow(Sender: TObject);override;
    procedure btnCountriesClick(Sender: TObject);
    procedure AppEvntsBaseIdle(Sender: TObject; var Done: Boolean);
    procedure btnCitiesClick(Sender: TObject);
    procedure btnCurrenciesClick(Sender: TObject);

    procedure SetSession();
    procedure ResetSession(pPanelGroupboxPagecontrolTabsheet: TWinControl);
    procedure mniAboutClick(Sender: TObject);
  private
    FDatabase: Ths.Erp.Database.Singleton.TSingletonDB;
  public
    destructor Destroy; override;
    property SingletonDB: TSingletonDB read FDatabase;

    procedure RefreshStatusBar();
  published
    procedure btnCloseClick(Sender: TObject); override;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Ths.Erp.Constants,
  Ths.Erp.SpecialFunctions,
  Vcl.Styles.Utils.SystemMenu,
  //uParaBirimi, ufrmParaBirimleri,
  Ths.Erp.Database.Table.Country,
  ufrmCountries,
  Ths.Erp.Database.Table.Country.City,
  ufrmCurrencies,
  Ths.Erp.Database.Table.Currency,
  ufrmCities
  , Ths.Erp.Database.Table.SysUserAccessRight, ufrmAbout;
{$R *.dfm}

procedure TfrmMain.AppEvntsBaseIdle(Sender: TObject; var Done: Boolean);
begin
  inherited;
  RefreshStatusBar;
end;

procedure TfrmMain.btnCitiesClick(Sender: TObject);
begin
  TfrmCities.Create(Application, Self, TCity.Create(SingletonDB.DataBase), True).Show;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  if TSpecialFunctions.CustomMsgDlg(
    'Application terminated. Are you sure you want close application?',
    mtConfirmation, mbYesNo, ['Yes', 'No'], mbNo, 'Confirmation') = mrYes
  then
    inherited;
end;

procedure TfrmMain.btnCountriesClick(Sender: TObject);
begin
  TfrmCountries.Create(Application, Self, TCountry.Create(SingletonDB.DataBase), True).Show;
end;

procedure TfrmMain.btnCurrenciesClick(Sender: TObject);
begin
  TfrmCurrencies.Create(Application, Self, TCurrency.Create(SingletonDB.DataBase), True).Show;
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
  FDatabase := TSingletonDB.Create;

  inherited;
  TVclStylesSystemMenu.Create(Self);
  btnClose.Visible := True;
  pnlBottom.Visible := False;
  stbBase.Visible := True;
  pnlBottom.Visible := True;

  //todo
  1 permision code listesini duzenle butun erisim izinleri kodlar üzerinden yürüyecek þekilde deðiþklik yap
  2 standart erisim kodlarý için döküman ayarla sabit bilgi olarak girilsin
  3 sys visible colum sýnýfý için ön yüz hazýrla
  4 sistem ayarlarý için sýnýf tanýmla. ondalýklý hane formatý, para formatý, tarih formatý, butun sistem bu formatlar üzerinde ilerleyecek
  5 Output formda arama penceresini ayarla
  6 input formlar icin helper penceresi tasarla
  7 excel rapor
  8 yazýcý ekraný
  9 detaylý form
  10 stringgrid base form
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  inherited;

  SetSession();
end;

procedure TfrmMain.mniAboutClick(Sender: TObject);
begin
  TfrmAbout.Create(Application).ShowModal;
end;

procedure TfrmMain.RefreshStatusBar;
begin
//  if GetKeyState(VK_CAPITAL) > 0 then
//  begin
//    stbBase.Panels.Items[4].Text := 'CAP ON';
//  end
//  else
//    stbBase.Panels.Items[4].Text := 'CAP OFF';
//
//  stbBase.Panels.Items[4].Width := Canvas.TextWidth(stbBase.Panels.Items[0].Text) + 32;
//
//  if GetKeyState(VK_NUMLOCK) > 0 then
//    stbBase.Panels.Items[5].Text := 'NUM ON'
//  else
//    stbBase.Panels.Items[5].Text := 'NUM OFF';
//
//  stbBase.Panels.Items[5].Width := Canvas.TextWidth(stbBase.Panels.Items[1].Text) + 32;
end;

procedure TfrmMain.ResetSession(pPanelGroupboxPagecontrolTabsheet: TWinControl);
var
  nIndex, nIndex2: Integer;
  PanelContainer: TWinControl;

  procedure DisableButtons(Sender: TWinControl);
  var
    nIndex: Integer;
  begin
    if (Sender.ClassType = TBitBtn) then
    begin
      TButton(Sender).Enabled := False;
    end
    else
    begin
      for nIndex := 0 to Sender.ControlCount -1 do
      begin
        if Sender.Controls[nIndex].ClassType = TBitBtn then
          TBitBtn(Sender.Controls[nIndex]).Enabled := False
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

      if PanelContainer.Controls[nIndex].ClassType = TBitBtn then
        DisableButtons( TBitBtn(PanelContainer.Controls[nIndex]) );
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
    vAccessRight.SelectToList(' and user_name=' + QuotedStr(SingletonDB.User.UserName), False, False);
    for n1 := 0 to vAccessRight.List.Count-1 do
    begin
      if (TSysUserAccessRight(vAccessRight.List[n1]).IsRead)
      or (TSysUserAccessRight(vAccessRight.List[n1]).IsAddRecord)
      or (TSysUserAccessRight(vAccessRight.List[n1]).IsUpdate)
      or (TSysUserAccessRight(vAccessRight.List[n1]).IsDelete)
      or (TSysUserAccessRight(vAccessRight.List[n1]).IsSpecial)
      then
      begin
        if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode = '1001' then
        begin
          btnCurrencies.Enabled := True;
        end
        else
        if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode = '1002' then
        begin
          btnCountries.Enabled := True;
        end
        else
        if TSysUserAccessRight(vAccessRight.List[n1]).PermissionCode = '1003' then
        begin
          btnCities.Enabled := True;
        end;
      end;
    end;
  finally
    vAccessRight.Free;
  end;
end;

Initialization

end.
