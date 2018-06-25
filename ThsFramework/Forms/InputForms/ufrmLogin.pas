unit ufrmLogin;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Samples.Spin,
  System.StrUtils, Vcl.StdCtrls, FireDAC.Comp.Client,
  Winapi.Windows, Vcl.Graphics,
  Vcl.AppEvnts, Vcl.ExtCtrls, Vcl.ComCtrls,
  xmldom, XMLDoc, XMLIntf,
  thsEdit, thsComboBox,
  ufrmBase,
  Ths.Erp.Database, System.ImageList, Vcl.ImgList;

type
  TfrmLogin = class(TfrmBase)
    lblLanguage: TLabel;
    lblUserName: TLabel;
    lblPassword: TLabel;
    lblServer: TLabel;
    lblValServerExam: TLabel;
    lblDatabase: TLabel;
    lblPortNo: TLabel;
    cbbLanguage: TthsCombobox;
    edtUserName: TthsEdit;
    edtPassword: TthsEdit;
    edtServer: TthsEdit;
    edtDatabase: TthsEdit;
    edtPortNo: TthsEdit;
    chkSaveSettings: TCheckBox;
    procedure FormCreate(Sender: TObject); override;
    procedure FormShow(Sender: TObject); override;
    procedure cbbDilChange(Sender: TObject);
    procedure btnAcceptClick(Sender: TObject); override;
    procedure FormPaint(Sender: TObject); override;
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
    if (ShowModal = mrYes) then
      Result := True
    else
      Result := False;
  finally
    Free;
  end;
end;

procedure TfrmLogin.btnAcceptClick(Sender: TObject);
begin
  if ValidateInput then
  begin
    ModalResult := mrCancel;

    frmMain.SingletonDB.DataBase.ConnSetting.Language := cbbLanguage.Text;
    frmMain.SingletonDB.DataBase.ConnSetting.SQLServer := edtServer.Text;
    frmMain.SingletonDB.DataBase.ConnSetting.DatabaseName := edtDatabase.Text;
    frmMain.SingletonDB.DataBase.ConnSetting.DBUserName := edtUserName.Text;
    frmMain.SingletonDB.DataBase.ConnSetting.DBUserPassword := edtPassword.Text;
    frmMain.SingletonDB.DataBase.ConnSetting.DBPortNo := StrToIntDef(edtPortNo.Text, 0);

    frmMain.SingletonDB.DataBase.ConfigureConnection;
    try
      frmMain.SingletonDB.DataBase.Connection.Open();
      if frmMain.SingletonDB.DataBase.Connection.Connected then
      begin
        frmMain.SingletonDB.User.SelectToList(' and user_name=' + QuotedStr(edtUserName.Text), False, False);
        if frmMain.SingletonDB.User.List.Count = 0 then
          raise Exception.Create('Kullanýcý Adý / Þifre tanýmlý deðil veya girilen bilgiler doðru deðil!');

        ModalResult := mrYes;

        if chkSaveSettings.Checked then
          frmMain.SingletonDB.DataBase.ConnSetting.SaveToFile;
      end;
    except
      on E: Exception do
      begin
        raise Exception.Create('Veri tabaný ile baðlantý kurulamadý!' + sLineBreak + sLineBreak + E.Message);
      end;
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

  lblValServerExam.Caption := 'Server/Sunucu Örn/Exam: 192.168.1.100';
  edtUserName.thsRequiredData := True;
  edtPassword.thsRequiredData := True;
  edtServer.thsRequiredData := True;
  edtDatabase.thsRequiredData := True;
  edtPortNo.thsRequiredData := True;

  btnAccept.Visible := True;
  btnClose.Visible := True;
  btnDelete.Visible := False;
  btnSpin.Visible := False;

  cbbLanguage.Clear;
  cbbLanguage.Items.Add(frmMain.SingletonDB.DataBase.ConnSetting.Language);

  edtUserName.Text := frmMain.SingletonDB.Database.ConnSetting.DBUserName;
  edtPassword.Text := frmMain.SingletonDB.Database.ConnSetting.DBUserPassword;
  edtServer.Text := frmMain.SingletonDB.Database.ConnSetting.SQLServer;
  edtDatabase.Text := frmMain.SingletonDB.Database.ConnSetting.DatabaseName;
  edtPortNo.Text := frmMain.SingletonDB.Database.ConnSetting.DBPortNo.ToString;

  cbbLanguage.ItemIndex := cbbLanguage.Items.IndexOf(frmMain.SingletonDB.Database.ConnSetting.Language);
  cbbDilChange(cbbLanguage);
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

