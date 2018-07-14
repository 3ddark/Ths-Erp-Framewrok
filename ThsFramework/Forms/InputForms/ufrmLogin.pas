unit ufrmLogin;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Samples.Spin,
  System.StrUtils, Vcl.StdCtrls, FireDAC.Comp.Client, Vcl.Dialogs,
  Winapi.Windows, Vcl.Graphics,
  Vcl.AppEvnts, Vcl.ExtCtrls, Vcl.ComCtrls,
  xmldom, XMLDoc, XMLIntf,
  thsEdit, thsComboBox,
  ufrmBase,
  System.ImageList, Vcl.ImgList, System.Hash;

type
  TfrmLogin = class(TfrmBase)
    lblLanguage: TLabel;
    lblUserName: TLabel;
    lblPassword: TLabel;
    lblServer: TLabel;
    lblServerExample: TLabel;
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
    procedure btnAcceptClick(Sender: TObject); override;

    procedure RefreshLangValue();
    procedure cbbLanguageChange(Sender: TObject);
  private
  protected
  public
    class function Execute(): Boolean;
  end;

implementation

uses
  ufrmMain,
  Ths.Erp.SpecialFunctions,
  Ths.Erp.Constants,
  Ths.Erp.Database,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Connection.Settings,
  Ths.Erp.Database.Table.SysLang;

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

    TSingletonDB.GetInstance.DataBase.ConnSetting.Language := cbbLanguage.Text;
    TSingletonDB.GetInstance.DataBase.ConnSetting.SQLServer := edtServer.Text;
    TSingletonDB.GetInstance.DataBase.ConnSetting.DatabaseName := edtDatabase.Text;
    TSingletonDB.GetInstance.DataBase.ConnSetting.DBUserName := edtUserName.Text;
    TSingletonDB.GetInstance.DataBase.ConnSetting.DBUserPassword := edtPassword.Text;
    TSingletonDB.GetInstance.DataBase.ConnSetting.DBPortNo := StrToIntDef(edtPortNo.Text, 0);

    if TSingletonDB.GetInstance.DataBase.Connection.Connected then
    begin
      TSingletonDB.GetInstance.User.SelectToList(' and user_name=' + QuotedStr(edtUserName.Text), False, False);
      TSingletonDB.GetInstance.HaneMiktari.SelectToList('', False, False);
      TSingletonDB.GetInstance.ApplicationSetting.SelectToList('', False, False);
      if TSingletonDB.GetInstance.User.List.Count = 0 then
        raise Exception.Create(GetTextFromLang('Username/Password not defined or correct!', FrameworkLang.ErrorLogin, LngError, LngSystem));

      ModalResult := mrYes;

      if chkSaveSettings.Checked then
        TSingletonDB.GetInstance.DataBase.ConnSetting.SaveToFile;
    end;
  end;
end;

procedure TfrmLogin.cbbLanguageChange(Sender: TObject);
begin
  inherited;
  TSingletonDB.GetInstance.DataBase.ConnSetting.Language := cbbLanguage.Text;
  RefreshLangValue;

  Repaint;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  inherited;

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
  cbbLanguage.Items.Add(TSingletonDB.GetInstance.DataBase.ConnSetting.Language);

  edtUserName.Text := TSingletonDB.GetInstance.Database.ConnSetting.DBUserName;
  edtPassword.Text := TSingletonDB.GetInstance.Database.ConnSetting.DBUserPassword;
  edtServer.Text := TSingletonDB.GetInstance.Database.ConnSetting.SQLServer;
  edtDatabase.Text := TSingletonDB.GetInstance.Database.ConnSetting.DatabaseName;
  edtPortNo.Text := TSingletonDB.GetInstance.Database.ConnSetting.DBPortNo.ToString;

  cbbLanguage.ItemIndex := cbbLanguage.Items.IndexOf(TSingletonDB.GetInstance.Database.ConnSetting.Language);
  cbbLanguageChange(cbbLanguage);
end;

procedure TfrmLogin.FormShow(Sender: TObject);
var
  vLang: TSysLang;
  n1: Integer;
begin
  inherited;

  TSingletonDB.GetInstance.DataBase.ConfigureConnection;
  try
    TSingletonDB.GetInstance.DataBase.Connection.Open();
    vLang := TSysLang.Create(TSingletonDB.GetInstance.DataBase);
    try
      vLang.SelectToList('', False, False);
      cbbLanguage.Clear;
      for n1 := 0 to vLang.List.Count-1 do
        cbbLanguage.Items.Add( TSysLang(vLang.List[n1]).Language.Value );
      cbbLanguage.ItemIndex := cbbLanguage.Items.IndexOf( TSingletonDB.GetInstance.DataBase.ConnSetting.Language );
    finally
      vLang.Free;
    end;
    RefreshLangValue;
  except
    on E: Exception do
    begin
      raise Exception.Create(GetTextFromLang('Failed to connect to database!', FrameworkLang.ErrorDatabaseConnection, LngError, LngSystem) + sLineBreak + sLineBreak + E.Message);
    end;
  end;
end;

procedure TfrmLogin.RefreshLangValue;
begin
  if TSingletonDB.GetInstance.DataBase.Connection.Connected then
  begin
    Caption := GetTextFromLang(Caption, 'Login', LngInputFormCaption);

    btnAccept.Caption := GetTextFromLang( btnAccept.Caption, FrameworkLang.ButtonAccept, LngButton, LngSystem);
    btnClose.Caption := GetTextFromLang( btnClose.Caption, FrameworkLang.ButtonClose, LngButton, LngSystem);

    lblLanguage.Caption := GetTextFromLang( lblLanguage.Caption, 'Language', LngLogin, LngSystem );
    lblUserName.Caption := GetTextFromLang( lblUserName.Caption, 'User Name', LngLogin, LngSystem );
    lblPassword.Caption := GetTextFromLang( lblPassword.Caption, 'Password', LngLogin, LngSystem );
    lblServer.Caption := GetTextFromLang( lblServer.Caption, 'Server', LngLogin, LngSystem );
    lblServerExample.Caption := GetTextFromLang( lblServerExample.Caption, 'Server Example', LngLogin, LngSystem );
    lblDatabase.Caption := GetTextFromLang( lblDatabase.Caption, 'Database', LngLogin, LngSystem );
    lblPortNo.Caption := GetTextFromLang( lblPortNo.Caption, 'Port No', LngLogin, LngSystem );
    chkSaveSettings.Caption := GetTextFromLang( chkSaveSettings.Caption, 'Save Settings', LngLogin, LngSystem );
  end;
end;

end.

