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
  Ths.Erp.Database, System.ImageList, Vcl.ImgList, Ths.Erp.SpecialFunctions, System.Hash;

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
  Ths.Erp.Database.Connection.Settings, ufrmMain, Ths.Erp.Database.Singleton, Ths.Erp.Constants, Ths.Erp.Database.Table.SysLang;

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

    if frmMain.SingletonDB.DataBase.Connection.Connected then
    begin
      frmMain.SingletonDB.User.SelectToList(' and user_name=' + QuotedStr(edtUserName.Text), False, False);
      if frmMain.SingletonDB.User.List.Count = 0 then
        raise Exception.Create(TSingletonDB.GetInstance.GetTextFromLang('Username/Password not defined or correct!', TSingletonDB.GetInstance.LangFramework.HataKullaniciAdi));

      ModalResult := mrYes;

      if chkSaveSettings.Checked then
        frmMain.SingletonDB.DataBase.ConnSetting.SaveToFile;
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
  cbbLanguage.Items.Add(frmMain.SingletonDB.DataBase.ConnSetting.Language);

  edtUserName.Text := frmMain.SingletonDB.Database.ConnSetting.DBUserName;
  edtPassword.Text := frmMain.SingletonDB.Database.ConnSetting.DBUserPassword;
  edtServer.Text := frmMain.SingletonDB.Database.ConnSetting.SQLServer;
  edtDatabase.Text := frmMain.SingletonDB.Database.ConnSetting.DatabaseName;
  edtPortNo.Text := frmMain.SingletonDB.Database.ConnSetting.DBPortNo.ToString;

  cbbLanguage.ItemIndex := cbbLanguage.Items.IndexOf(frmMain.SingletonDB.Database.ConnSetting.Language);
  cbbLanguageChange(cbbLanguage);
end;

procedure TfrmLogin.FormShow(Sender: TObject);
var
  vLang: TSysLang;
  n1: Integer;
begin
  inherited;

  frmMain.SingletonDB.DataBase.ConfigureConnection;
  try
    frmMain.SingletonDB.DataBase.Connection.Open();
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
      raise Exception.Create(TSingletonDB.GetInstance.GetTextFromLang('Failed to connect to database!', TSingletonDB.GetInstance.LangFramework.HataVeritabaniBaglantisi) + sLineBreak + sLineBreak + E.Message);
    end;
  end;
end;

procedure TfrmLogin.RefreshLangValue;
begin
  if frmMain.SingletonDB.DataBase.Connection.Connected then
  begin
    Caption := TSingletonDB.GetInstance.GetTextFromLang( Caption, 'FormCaption.Input.login' );

    btnAccept.Caption := TSingletonDB.GetInstance.GetTextFromLang( btnAccept.Caption, TSingletonDB.GetInstance.LangFramework.ButonOnay);
    btnClose.Caption := TSingletonDB.GetInstance.GetTextFromLang( btnClose.Caption, TSingletonDB.GetInstance.LangFramework.ButonKapat);

    lblLanguage.Caption := TSingletonDB.GetInstance.GetTextFromLang( lblLanguage.Caption, 'LabelCaption.Input.login.' + LowerCase( StringReplace(lblLanguage.Name, LABEL_PREFIX, '', [rfReplaceAll]) ) );
    lblUserName.Caption := TSingletonDB.GetInstance.GetTextFromLang( lblUserName.Caption, 'LabelCaption.Input.login.' + LowerCase( StringReplace(lblUserName.Name, LABEL_PREFIX, '', [rfReplaceAll]) ) );
    lblPassword.Caption := TSingletonDB.GetInstance.GetTextFromLang( lblPassword.Caption, 'LabelCaption.Input.login.' + LowerCase( StringReplace(lblPassword.Name, LABEL_PREFIX, '', [rfReplaceAll]) ) );
    lblServer.Caption := TSingletonDB.GetInstance.GetTextFromLang( lblServer.Caption, 'LabelCaption.Input.login.' + LowerCase( StringReplace(lblServer.Name, LABEL_PREFIX, '', [rfReplaceAll]) ) );
    lblServerExample.Caption := TSingletonDB.GetInstance.GetTextFromLang( lblServerExample.Caption, 'LabelCaption.Input.login.' + LowerCase( StringReplace(lblServerExample.Name, LABEL_PREFIX, '', [rfReplaceAll]) ) );
    lblDatabase.Caption := TSingletonDB.GetInstance.GetTextFromLang( lblDatabase.Caption, 'LabelCaption.Input.login.' + LowerCase( StringReplace(lblDatabase.Name, LABEL_PREFIX, '', [rfReplaceAll]) ) );
    lblPortNo.Caption := TSingletonDB.GetInstance.GetTextFromLang( lblPortNo.Caption, 'LabelCaption.Input.login.' + LowerCase( StringReplace(lblPortNo.Name, LABEL_PREFIX, '', [rfReplaceAll]) ) );
    chkSaveSettings.Caption := TSingletonDB.GetInstance.GetTextFromLang( chkSaveSettings.Caption, 'LabelCaption.Input.login.' + LowerCase( StringReplace(chkSaveSettings.Name, CHECKBOX_PREFIX, '', [rfReplaceAll]) ) );
  end;
end;

end.

