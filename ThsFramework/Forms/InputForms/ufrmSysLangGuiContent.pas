unit ufrmSysLangGuiContent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Samples.Spin,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmSysLangGuiContent = class(TfrmBaseInputDB)
    lblCode: TLabel;
    lblLang: TLabel;
    lblValue: TLabel;
    lblIsFactorySetting: TLabel;
    lblContentType: TLabel;
    Label2: TLabel;
    cbbLang: TComboBox;
    edtCode: TEdit;
    edtContentType: TEdit;
    cbbTableName: TComboBox;
    edtValue: TEdit;
    chkIsFactorySetting: TCheckBox;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.SysLang,
  Ths.Erp.Database.Table.SysLangGuiContent;

{$R *.dfm}

procedure TfrmSysLangGuiContent.FormCreate(Sender: TObject);
var
  vLang: TSysLang;
  n1: Integer;
begin
  TSysLangGuiContent(Table).Lang.SetControlProperty(Table.TableName, cbbLang);
  TSysLangGuiContent(Table).Code.SetControlProperty(Table.TableName, edtCode);
  TSysLangGuiContent(Table).Lang.SetControlProperty(Table.TableName, edtContentType);
  TSysLangGuiContent(Table).Lang.SetControlProperty(Table.TableName, cbbTableName);
  TSysLangGuiContent(Table).Value.SetControlProperty(Table.TableName, edtValue);
  TSysLangGuiContent(Table).IsFactorySetting.SetControlProperty(Table.TableName, chkIsFactorySetting);

  inherited;

  cbbLang.CharCase := ecNormal;
  edtCode.CharCase := ecNormal;
  edtContentType.CharCase := ecNormal;
  cbbTableName.CharCase := ecNormal;
  edtValue.CharCase := ecNormal;

  TSingletonDB.GetInstance.FillTableName(cbbTableName);

  vLang := TSysLang.Create(Table.Database);
  try
    vLang.SelectToList('', False, False);
    cbbLang.Clear;
    for n1 := 0 to vLang.List.Count-1 do
      cbbLang.Items.Add(TSysLang(vLang.List[n1]).Language.Value);
  finally
    vLang.Free;
  end;
end;

procedure TfrmSysLangGuiContent.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbLang.ItemIndex := cbbLang.Items.IndexOf(TSysLangGuiContent(Table).Lang.Value);
  edtCode.Text := TSysLangGuiContent(Table).Code.Value;
  edtContentType.Text := TSysLangGuiContent(Table).ContentType.Value;

  if cbbTableName.Items.IndexOf( TSysLangGuiContent(Table).TableName1.Value ) = -1 then
    cbbTableName.Items.Add( TSysLangGuiContent(Table).TableName1.Value );
  cbbTableName.ItemIndex := cbbTableName.Items.IndexOf(TSysLangGuiContent(Table).TableName1.Value);

  edtValue.Text := TSysLangGuiContent(Table).Value.Value;
  chkIsFactorySetting.Checked := TSysLangGuiContent(Table).IsFactorySetting.Value;
end;

procedure TfrmSysLangGuiContent.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysLangGuiContent(Table).Lang.Value := cbbLang.Text;
      TSysLangGuiContent(Table).Code.Value := edtCode.Text;
      TSysLangGuiContent(Table).ContentType.Value := edtContentType.Text;
      TSysLangGuiContent(Table).TableName1.Value := cbbTableName.Text;
      TSysLangGuiContent(Table).Value.Value := edtValue.Text;
      TSysLangGuiContent(Table).IsFactorySetting.Value := chkIsFactorySetting.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
