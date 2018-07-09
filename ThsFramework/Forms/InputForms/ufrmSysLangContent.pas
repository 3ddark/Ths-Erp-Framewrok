unit ufrmSysLangContent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  thsEdit, thsComboBox,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus;

type
  TfrmSysLangContent = class(TfrmBaseInputDB)
    lblCode: TLabel;
    lblLang: TLabel;
    lblValue: TLabel;
    lblIsFactorySetting: TLabel;
    lblContentType: TLabel;
    Label2: TLabel;
    cbbLang: TthsCombobox;
    edtCode: TthsEdit;
    edtContentType: TthsEdit;
    cbbTableName: TthsCombobox;
    edtValue: TthsEdit;
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
  Ths.Erp.Database.Table.SysLangContents;

{$R *.dfm}

procedure TfrmSysLangContent.FormCreate(Sender: TObject);
var
  vLang: TSysLang;
  n1: Integer;
begin
  TSysLangContents(Table).Lang.SetControlProperty(Table.TableName, cbbLang);
  TSysLangContents(Table).Code.SetControlProperty(Table.TableName, edtCode);
  TSysLangContents(Table).Lang.SetControlProperty(Table.TableName, edtContentType);
  TSysLangContents(Table).Lang.SetControlProperty(Table.TableName, cbbTableName);
  TSysLangContents(Table).Value.SetControlProperty(Table.TableName, edtValue);
  TSysLangContents(Table).IsFactorySetting.SetControlProperty(Table.TableName, chkIsFactorySetting);

  inherited;

  cbbLang.CharCase := ecNormal;
  edtCode.CharCase := ecNormal;
  edtContentType.CharCase := ecNormal;
  cbbTableName.CharCase := ecNormal;
  edtValue.CharCase := ecNormal;

  TSingletonDB.GetInstance.FillTableName(TComboBox(cbbTableName));

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

procedure TfrmSysLangContent.RefreshData();
begin
  //control i�eri�ini table class ile doldur
  cbbLang.ItemIndex := cbbLang.Items.IndexOf(TSysLangContents(Table).Lang.Value);
  edtCode.Text := TSysLangContents(Table).Code.Value;
  edtContentType.Text := TSysLangContents(Table).ContentType.Value;

  if cbbTableName.Items.IndexOf( TSysLangContents(Table).TableName1.Value ) = -1 then
    cbbTableName.Items.Add( TSysLangContents(Table).TableName1.Value );
  cbbTableName.ItemIndex := cbbTableName.Items.IndexOf(TSysLangContents(Table).TableName1.Value);

  edtValue.Text := TSysLangContents(Table).Value.Value;
  chkIsFactorySetting.Checked := TSysLangContents(Table).IsFactorySetting.Value;
end;

procedure TfrmSysLangContent.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysLangContents(Table).Lang.Value := cbbLang.Text;
      TSysLangContents(Table).Code.Value := edtCode.Text;
      TSysLangContents(Table).ContentType.Value := edtContentType.Text;
      TSysLangContents(Table).TableName1.Value := cbbTableName.Text;
      TSysLangContents(Table).Value.Value := edtValue.Text;
      TSysLangContents(Table).IsFactorySetting.Value := chkIsFactorySetting.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
