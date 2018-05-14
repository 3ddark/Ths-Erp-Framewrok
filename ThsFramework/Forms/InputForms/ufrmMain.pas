unit ufrmMain;

interface

uses
  Winapi.Windows, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.Menus, Math, StrUtils, Vcl.ActnList, System.Actions,
  Vcl.AppEvnts, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls, System.Classes,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin,

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
    mniMainDosya: TMenuItem;
    mniMainHakkinda: TMenuItem;
    stbBase: TStatusBar;
    mniAyarlar: TMenuItem;
    mniKisisel: TMenuItem;
    mniYonetimsel: TMenuItem;
    mniKapat: TMenuItem;
    PageControl1: TPageControl;
    tsGenel: TTabSheet;
    tsAlis: TTabSheet;
    tsSatis: TTabSheet;
    tsStok: TTabSheet;
    tsMuhasebe: TTabSheet;
    tsUretim: TTabSheet;
    btnParaBirimleri: TBitBtn;
    tsDemirbas: TTabSheet;
    tsPersonel: TTabSheet;
    btnUlkeler: TBitBtn;
    btnPersonelBolumler: TBitBtn;
    btnPersonelBirimler: TBitBtn;
    btnPersonelGorevler: TBitBtn;
    btnPersonelBilgileri: TBitBtn;
    il16x16: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);override;
    procedure FormCreate(Sender: TObject);override;
    procedure FormKeyPress(Sender: TObject; var Key: Char);override;
    procedure FormShow(Sender: TObject);override;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);override;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);override;
    procedure btnParaBirimleriClick(Sender: TObject);
    procedure btnUlkelerClick(Sender: TObject);
    procedure btnPersonelBolumlerClick(Sender: TObject);
    procedure btnPersonelBirimlerClick(Sender: TObject);
    procedure btnPersonelGorevlerClick(Sender: TObject);
    procedure btnPersonelBilgileriClick(Sender: TObject);
    procedure stbBaseDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure AppEvntsBaseIdle(Sender: TObject; var Done: Boolean);

  private
    FDatabase: Ths.Erp.Database.Singleton.TSingletonDB;
  public
    property SingletonDB: TSingletonDB read FDatabase;

    procedure RefreshStatusBar();
  published
    procedure btnCloseClick(Sender: TObject); override;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  uConstGenel,
  Vcl.Styles.Utils.SystemMenu,
  //uParaBirimi, ufrmParaBirimleri,
  Ths.Erp.Database.Table.Country
  //uPersonelBolum, ufrmPersonelBolumler,
  //uPersonelBirim, ufrmPersonelBirimler,
  //uPersonelGorev, ufrmPersonelGorevler,
  //uPersonelBilgisi, ufrmPersonelBilgileri
  ;
{$R *.dfm}

procedure TfrmMain.btnPersonelGorevlerClick(Sender: TObject);
begin
  //TfrmPersonelGorevler.Create(Application, Self, TPersonelGorev.Create(SingletonDB.DataBase), '', True).Show;
end;

procedure TfrmMain.AppEvntsBaseIdle(Sender: TObject; var Done: Boolean);
begin
  inherited;
  RefreshStatusBar;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  if Application.MessageBox('Program kapatýlacak çýkmak istediðinden emin misin?', 'Ýþlem Onayý', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = mrYes then
    inherited;
end;

procedure TfrmMain.btnParaBirimleriClick(Sender: TObject);
begin
  //TfrmParaBirimleri.Create(Application, Self, TParaBirimi.Create(SingletonDB.DataBase), '', True).Show;
end;

procedure TfrmMain.btnPersonelBilgileriClick(Sender: TObject);
begin
  //TfrmPersonelBilgileri.Create(Application, Self, TPersonelBilgisi.Create(SingletonDB.DataBase), '', True).Show;
end;

procedure TfrmMain.btnPersonelBirimlerClick(Sender: TObject);
begin
  //TfrmPersonelBirimler.Create(Application, Self, TPersonelBirim.Create(SingletonDB.DataBase), '', True).Show;
end;

procedure TfrmMain.btnPersonelBolumlerClick(Sender: TObject);
begin
  //TfrmPersonelBolumler.Create(Application, Self, TPersonelBolum.Create(SingletonDB.DataBase), '', True).Show;
end;

procedure TfrmMain.btnUlkelerClick(Sender: TObject);
begin
  //TfrmUlkeler.Create(Application, Self, TCountry.Create(SingletonDB.DataBase), '', True).Show;
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
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
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
  inherited;
//
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmMain.RefreshStatusBar;
begin
  if GetKeyState(VK_CAPITAL) > 0 then
  begin
    stbBase.Panels.Items[4].Text := 'CAP ON';
  end
  else
    stbBase.Panels.Items[4].Text := 'CAP OFF';

  stbBase.Panels.Items[4].Width := Canvas.TextWidth(stbBase.Panels.Items[0].Text) + 32;

  if GetKeyState(VK_NUMLOCK) > 0 then
    stbBase.Panels.Items[5].Text := 'NUM ON'
  else
    stbBase.Panels.Items[5].Text := 'NUM OFF';

  stbBase.Panels.Items[5].Width := Canvas.TextWidth(stbBase.Panels.Items[1].Text) + 32;
end;

procedure TfrmMain.stbBaseDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
begin
  inherited;

  StatusBar.Canvas.Font.Style := [fsBold];
  if Panel.Index = STATUS_KEY_F4 then
  begin
    Panel.Text := 'F4 KAYIT SÝL';
    StatusBar.Canvas.Font.Color := clRed;
    StatusBar.Canvas.TextRect(Rect, Rect.Left + 20, Rect.Top, Panel.Text);
    il16x16.Draw(StatusBar.Canvas, Rect.Left, ((Rect.Bottom-il16x16.Height) div 2), 0);
    Panel.Width := 120;//Canvas.TextWidth(Panel.Text)+ 32;
  end
  else
  if Panel.Index = STATUS_KEY_F5 then
  begin
    Panel.Text := 'F5 ÝÞLEM ONAY';
    StatusBar.Canvas.Font.Color := clBlue;
    StatusBar.Canvas.TextRect(Rect, Rect.Left + 20, Rect.Top, Panel.Text);
    il16x16.Draw(StatusBar.Canvas, Rect.Left, ((Rect.Bottom-il16x16.Height) div 2), 1);
    Panel.Width := 120;//Canvas.TextWidth(Panel.Text)+ 32;
  end
  else
  if Panel.Index = STATUS_KEY_F6 then
  begin
    Panel.Text := 'F6 ÝÞLEM ÝPTAL';
    StatusBar.Canvas.TextRect(Rect, Rect.Left + 20, Rect.Top, Panel.Text);
    il16x16.Draw(StatusBar.Canvas, Rect.Left, ((Rect.Bottom-il16x16.Height) div 2), 2);
    Panel.Width := 120;//Canvas.TextWidth(Panel.Text)+ 32;
  end
  else
  if Panel.Index = STATUS_KEY_F7 then
  begin
    Panel.Text := 'F7 KAYIT EKLE';
    StatusBar.Canvas.TextRect(Rect, Rect.Left + 20, Rect.Top, Panel.Text);
    il16x16.Draw(StatusBar.Canvas, Rect.Left, ((Rect.Bottom-il16x16.Height) div 2), 3);
    Panel.Width := 120;//Canvas.TextWidth(Panel.Text)+ 32;
  end;

end;

Initialization

end.
