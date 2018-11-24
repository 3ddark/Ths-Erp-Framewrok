unit ufrmSysLangDataContent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Samples.Spin,

  Ths.Erp.Helper. Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB

  , Ths.Erp.Database.Table.View.SysViewTables
  , Ths.Erp.Database.Table.View.SysViewColumns
  , Ths.Erp.Database.Table.SysLang
  ;

type
  TfrmSysLangDataContent = class(TfrmBaseInputDB)
    lblLang: TLabel;
    lblTableName1: TLabel;
    lblColumnName: TLabel;
    lblRowID: TLabel;
    lblValue: TLabel;
    cbbLang: TComboBox;
    cbbTableName1: TComboBox;
    cbbColumnName: TComboBox;
    edtRowID: TEdit;
    edtValue: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure cbbTableName1Change(Sender: TObject);
  private
    vSysViewTables: TSysViewTables;
    vSysViewColumns: TSysViewColumns;
    vLangs: TSysLang;
  public
    destructor Destroy; override;
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton
  , Ths.Erp.Database.Table.SysLangDataContent
  ;

{$R *.dfm}

procedure TfrmSysLangDataContent.cbbTableName1Change(Sender: TObject);
begin
  fillComboBoxData(cbbColumnName, vSysViewColumns, vSysViewColumns.ColumnName.FieldName, ' AND ' + vSysViewColumns.TableName1.FieldName + '=' + QuotedStr(cbbTableName1.Text) + ' ORDER BY ' + vSysViewColumns.OrdinalPosition.FieldName + ' ASC ');
end;

destructor TfrmSysLangDataContent.Destroy;
begin
  if Assigned(vSysViewTables) then
    vSysViewTables.Free;
  if Assigned(vSysViewColumns) then
    vSysViewColumns.Free;
  if Assigned(vLangs) then
    vLangs.Free;
  inherited;
end;

procedure TfrmSysLangDataContent.FormCreate(Sender: TObject);
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

  vSysViewTables := TSysViewTables.Create(Table.Database);
  vSysViewColumns := TSysViewColumns.Create(Table.Database);
  vLangs := TSysLang.Create(Table.DataBase);

  fillComboBoxData(cbbTableName1, vSysViewTables, vSysViewTables.TableName1.FieldName, '');
  fillComboBoxData(cbbLang, vLangs, vLangs.Language.FieldName, '');
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
