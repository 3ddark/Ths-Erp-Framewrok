unit ufrmSysLangDataContent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB,
  Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmSysLangDataContent = class(TfrmBaseInputDB)
    lblLang: TLabel;
    lblTableName1: TLabel;
    lblColumnName: TLabel;
    lblRowID: TLabel;
    lblValue: TLabel;
    cbbLang: TthsCombobox;
    cbbTableName1: TthsCombobox;
    cbbColumnName: TthsCombobox;
    edtRowID: TthsEdit;
    edtValue: TthsEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure cbbTableName1Change(Sender: TObject);
  private
  public
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.SysLangDataContent, Ths.Erp.Database.Table.SysLang;

{$R *.dfm}

procedure TfrmSysLangDataContent.cbbTableName1Change(Sender: TObject);
begin
  TSingletonDB.GetInstance.FillColName(TComboBox(cbbColumnName), cbbTableName1.Text);
end;

procedure TfrmSysLangDataContent.FormCreate(Sender: TObject);
var
  n1: Integer;
  vLangs: TSysLang;
begin
  TSysLangDataContent(Table).Lang.SetControlProperty(Table.TableName, cbbLang);
  TSysLangDataContent(Table).TableName1.SetControlProperty(Table.TableName, cbbTableName1);
  TSysLangDataContent(Table).ColumnName.SetControlProperty(Table.TableName, cbbColumnName);
  TSysLangDataContent(Table).RowID.SetControlProperty(Table.TableName, edtRowID);
  TSysLangDataContent(Table).Value.SetControlProperty(Table.TableName, edtValue);

  inherited;
  cbbLang.CharCase := ecNormal;
  cbbTableName1.CharCase := ecNormal;
  cbbColumnName.CharCase := ecNormal;

  vLangs := TSysLang.Create(TSingletonDB.GetInstance.DataBase);
  try
    vLangs.SelectToList('', False, False);
    cbbLang.Clear;
    for n1 := 0 to vLangs.List.Count-1 do
      cbbLang.Items.Add( TSysLang(vLangs.List[n1]).Language.Value );
    cbbLang.ItemIndex := -1;
  finally
    vLangs.Free;
  end;

  TSingletonDB.GetInstance.FillTableName(TComboBox(cbbTableName1));
end;

procedure TfrmSysLangDataContent.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbLang.Text := TSysLangDataContent(Table).Lang.Value;
  cbbTableName1.Text := TSysLangDataContent(Table).TableName1.Value;
  cbbColumnName.Text := TSysLangDataContent(Table).ColumnName.Value;
  edtRowID.Text := TSysLangDataContent(Table).RowID.Value;
  edtValue.Text := TSysLangDataContent(Table).Value.Value;
end;

procedure TfrmSysLangDataContent.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysLangDataContent(Table).Lang.Value := cbbLang.Text;
      TSysLangDataContent(Table).TableName1.Value := cbbTableName1.Text;
      TSysLangDataContent(Table).ColumnName.Value := cbbColumnName.Text;
      TSysLangDataContent(Table).RowID.Value := edtRowID.Text;
      TSysLangDataContent(Table).Value.Value := edtValue.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
