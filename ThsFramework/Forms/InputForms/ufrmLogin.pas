unit ufrmLogin;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Samples.Spin,
  Vcl.StdCtrls, FireDAC.Comp.Client, Vcl.Dialogs, Winapi.Windows, Vcl.Graphics,
  Vcl.AppEvnts, Vcl.ExtCtrls, Vcl.ComCtrls,
  xmldom, XMLDoc, XMLIntf,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInput, Vcl.Menus
  ;

type
  TfrmLogin = class(TfrmBase)
    btnShowConfigure: TButton;
    lbllanguage: TLabel;
    lblUserName: TLabel;
    lblPassword: TLabel;
    lblServer: TLabel;
    lblServerExample: TLabel;
    lblDatabase: TLabel;
    lblPortNo: TLabel;
    lblSaveSettings: TLabel;
    cbbLanguage: TComboBox;
    edtUserName: TEdit;
    edtPassword: TEdit;
    edtServer: TEdit;
    edtDatabase: TEdit;
    edtPortNo: TEdit;
    chkSaveSettings: TCheckBox;
    procedure FormCreate(Sender: TObject); override;
    procedure FormShow(Sender: TObject); override;
    procedure btnAcceptClick(Sender: TObject); override;

    procedure RefreshLangValue();
    procedure cbbLanguageChange(Sender: TObject);
    procedure btnShowConfigureClick(Sender: TObject);
  private
  protected
  public
    class function Execute(): Boolean;
  end;

implementation

uses

  Ths.Erp.Functions
  , Ths.Erp.Constants
  , Ths.Erp.Database
  , Ths.Erp.Database.Singleton
  , Ths.Erp.Database.Connection.Settings
  , Ths.Erp.Database.Table.SysLang
  , Ths.Erp.Database.Table.SysLangGuiContent
  ;

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
      TSingletonDB.GetInstance.User.SelectToList(' AND ' + TSingletonDB.GetInstance.User.UserName.FieldName + '=' + QuotedStr(edtUserName.Text), False, False);
      TSingletonDB.GetInstance.HaneMiktari.SelectToList('', False, False);
      TSingletonDB.GetInstance.ApplicationSettings.SelectToList('', False, False);
      //þimdilik kapatýldý form düzenlenince ileride açýlacak
//      TSingletonDB.GetInstance.ApplicationSettingsOther.SelectToList('', False, False);
      TSingletonDB.GetInstance.SysLang.SelectToList(' AND ' + TSingletonDB.GetInstance.SysLang.Language.FieldName + '=' + QuotedStr(cbbLanguage.Text), False, False);
      if TSingletonDB.GetInstance.User.List.Count = 0 then
        raise Exception.Create(TranslateText('Username/Password not defined or correct!', FrameworkLang.ErrorLogin, LngMsgError, LngSystem));

      ModalResult := mrYes;

      if chkSaveSettings.Checked then
        TSingletonDB.GetInstance.DataBase.ConnSetting.SaveToFile;
    end;
  end;
end;

procedure TfrmLogin.btnShowConfigureClick(Sender: TObject);
begin
  if edtServer.Visible then
  begin
    lblServer.Visible := False;
    edtServer.Visible := False;
    lblServerExample.Visible := False;
    lblDatabase.Visible := False;
    edtDatabase.Visible := False;
    lblPortNo.Visible := False;
    edtPortNo.Visible := False;
    chkSaveSettings.Visible := False;
    ClientHeight := 120;
  end
  else
  begin
    lblServer.Visible := True;
    edtServer.Visible := True;
    lblServerExample.Visible := True;
    lblDatabase.Visible := True;
    edtDatabase.Visible := True;
    lblPortNo.Visible := True;
    edtPortNo.Visible := True;
    chkSaveSettings.Visible := True;
    ClientHeight := 230;
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

    btnAccept.Images := TSingletonDB.GetInstance.ImageList32;
    btnAccept.ImageIndex := 0;
    btnShowConfigureClick(btnShowConfigure);
  except
    on E: Exception do
    begin
      raise Exception.Create(TranslateText('Failed to connect to database!', FrameworkLang.ErrorDatabaseConnection, LngMsgError, LngSystem) + sLineBreak + sLineBreak + E.Message);
    end;
  end;
end;

procedure TfrmLogin.RefreshLangValue;
begin
//  if TSingletonDB.GetInstance.DataBase.Connection.Connected then
  begin
    Self.Caption := getFormCaptionByLang(Self.Name, Self.Caption);

    btnAccept.Caption := TranslateText( btnAccept.Caption, FrameworkLang.ButtonAccept, LngButton, LngSystem);
    btnClose.Caption := TranslateText( btnClose.Caption, FrameworkLang.ButtonClose, LngButton, LngSystem);
    btnAccept.Width := Canvas.TextWidth(btnAccept.Caption) + 56;
    btnClose.Width := Canvas.TextWidth(btnClose.Caption) + 56;

    lblLanguage.Caption := TranslateText(lblLanguage.Caption, lblLanguage.Name, LngLabelCaption);
    lblUserName.Caption := TranslateText( lblUserName.Caption, 'User Name', LngLogin, LngSystem );
    lblPassword.Caption := TranslateText( lblPassword.Caption, 'Password', LngLogin, LngSystem );
    lblServer.Caption := TranslateText( lblServer.Caption, 'Server', LngLogin, LngSystem );
    lblServerExample.Caption := TranslateText( lblServerExample.Caption, 'Server Example', LngLogin, LngSystem );
    lblDatabase.Caption := TranslateText( lblDatabase.Caption, 'Database', LngLogin, LngSystem );
    lblPortNo.Caption := TranslateText( lblPortNo.Caption, 'Port No', LngLogin, LngSystem );
    chkSaveSettings.Caption := TranslateText( chkSaveSettings.Caption, 'Save Settings', LngLogin, LngSystem );
  end;
end;

end.

