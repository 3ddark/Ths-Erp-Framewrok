unit ufrmSysTableLangContent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.View.SysViewColumns, Vcl.Menus;

type
  TfrmSysTableLangContent = class(TfrmBaseInputDB)
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
  Ths.Erp.Database.Table.SysTableLangContent, Ths.Erp.Database.Table.SysLang;

{$R *.dfm}

procedure TfrmSysTableLangContent.cbbTableName1Change(Sender: TObject);
begin
  TSingletonDB.GetInstance.FillColName(TComboBox(cbbColumnName), cbbTableName1.Text);
end;

procedure TfrmSysTableLangContent.FormCreate(Sender: TObject);
var
  n1: Integer;
  vLangs: TSysLang;
begin
  TSysTableLangContent(Table).Lang.SetControlProperty(Table.TableName, cbbLang);
  TSysTableLangContent(Table).TableName1.SetControlProperty(Table.TableName, cbbTableName1);
  TSysTableLangContent(Table).ColumnName.SetControlProperty(Table.TableName, cbbColumnName);
  TSysTableLangContent(Table).RowID.SetControlProperty(Table.TableName, edtRowID);
  TSysTableLangContent(Table).Value.SetControlProperty(Table.TableName, edtValue);

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

procedure TfrmSysTableLangContent.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbLang.Text := TSysTableLangContent(Table).Lang.Value;
  cbbTableName1.Text := TSysTableLangContent(Table).TableName1.Value;
  cbbColumnName.Text := TSysTableLangContent(Table).ColumnName.Value;
  edtRowID.Text := TSysTableLangContent(Table).RowID.Value;
  edtValue.Text := TSysTableLangContent(Table).Value.Value;
end;

procedure TfrmSysTableLangContent.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysTableLangContent(Table).Lang.Value := cbbLang.Text;
      TSysTableLangContent(Table).TableName1.Value := cbbTableName1.Text;
      TSysTableLangContent(Table).ColumnName.Value := cbbColumnName.Text;
      TSysTableLangContent(Table).RowID.Value := edtRowID.Text;
      TSysTableLangContent(Table).Value.Value := edtValue.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
