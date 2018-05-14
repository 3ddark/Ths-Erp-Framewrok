unit ufrmLogin;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Samples.Spin, System.StrUtils,
  Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Comp.Client,
  xmldom, XMLDoc, XMLIntf,
  ufrmBase, fyComboBox, fyEdit,
  Vcl.AppEvnts, Vcl.ExtCtrls,
  Ths.Erp.Database,
  Ths.Erp.Database.Connection;

type
  TfrmLogin = class(TfrmBase)
    lblDil: TLabel;
    cbbDil: TfyComboBox;
    lblKullanici: TLabel;
    edtKullanici: TfyEdit;
    lblSifre: TLabel;
    edtSifre: TfyEdit;
    lblSunucu: TLabel;
    edtSunucu: TfyEdit;
    lblValSunucuOrnek: TLabel;
    lblDatabase: TLabel;
    edtDatabase: TfyEdit;
    lblPortNo: TLabel;
    edtPortNo: TfyEdit;
    chkAyarlariSakla: TCheckBox;
    procedure FormCreate(Sender: TObject);override;
    procedure FormShow(Sender: TObject);override;
    procedure cbbDilChange(Sender: TObject);
    procedure btnTamamClick(Sender: TObject);override;
    procedure FormPaint(Sender: TObject);override;
  private

  protected
    procedure RefreshData;
  public
    class function Execute(): Boolean;
  end;

implementation

uses
  Ths.Erp.Database.Connection.Settings, ufrmMain;

{$R *.dfm}

class function TfrmLogin.Execute(): boolean;
begin
  with TfrmLogin.Create(nil) do
  try
    if (ShowModal = mrYes )then
      Result := True
    else
      Result := False;
  finally
    Free;
  end;
end;

procedure TfrmLogin.btnTamamClick(Sender: TObject);
begin
  if ValidateInput then
  begin
    ModalResult := mrCancel;

    frmMain.SingletonDB.DataBase.Connection.GetConn.Open();
    if frmMain.SingletonDB.DataBase.Connection.GetConn.Connected then
    begin
      frmMain.SingletonDB.User.SelectToList(' and kullanici_adi=' + QuotedStr(edtKullanici.Text), False, False);
      if chkAyarlariSakla.Checked then
      begin
        Ths.Erp.Database.Connection.Settings.TConnSettings.SaveToFile(
            ExtractFilePath(Application.ExeName) + 'Settings' + '\' + 'GlobalSettings.ini',
            cbbDil.Text, edtSunucu.Text, edtDatabase.Text, edtKullanici.Text, edtSifre.Text, edtPortNo.Text
        );
      end;
      ModalResult := mrYes;
    end;
  end;
end;

procedure TfrmLogin.cbbDilChange(Sender: TObject);
var
  strDmp: string;
begin
  inherited;

  strDmp := RightStr(TComboBox(Sender).Text, Length(TComboBox(Sender).Text) - Pos(' ', TComboBox(Sender).Text));
  Repaint;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  inherited;

  btnTamam.Visible := True;
  btnKapat.Visible := True;
  btnSil.Visible := False;
  btnSpin.Visible := False;

  cbbDil.Clear;
  cbbDil.Items.Add(frmMain.SingletonDB.DataBase.Connection.ConnSetting.Language);

  edtKullanici.Text := frmMain.SingletonDB.Database.Connection.ConnSetting.Language;
  edtSifre.Text := frmMain.SingletonDB.Database.Connection.ConnSetting.DBUserPassword;
  edtSunucu.Text := frmMain.SingletonDB.Database.Connection.ConnSetting.SQLServer;
  edtDatabase.Text := frmMain.SingletonDB.Database.Connection.ConnSetting.DatabaseName;
  edtPortNo.Text := frmMain.SingletonDB.Database.Connection.ConnSetting.DBPortNo.ToString;

  cbbDil.ItemIndex := cbbDil.Items.IndexOf(frmMain.SingletonDB.Database.Connection.ConnSetting.Language);
  cbbDilChange(cbbDil);
end;

procedure TfrmLogin.FormPaint(Sender: TObject);
begin
  inherited;

//  if GlobalVars.XMLGlobalSettings <> nil then
//  begin
//    Self.Caption := applang.FrmLogin.FrmCaption;
//    Self.lblKullanici.Caption := applang.FrmLogin.LblKullanici;
//    Self.lblSifre.Caption := applang.FrmLogin.LblSifre;
//    Self.lblDil.Caption := applang.FrmLogin.LblDil;
//    Self.lblSunucu.Caption := applang.FrmLogin.LblSunucu;
//    Self.lblValSunucuOrnek.Caption := applang.FrmLogin.LblSunucuOrnek;
//    Self.btnKapat.Caption := applang.FrmLogin.BtnKapat;
//    Self.btnTamam.Caption := applang.FrmLogin.BtnTamam;
//  end;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmLogin.RefreshData;
begin
  //
end;

end.
