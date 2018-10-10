unit ufrmSysMultiLangDataTableList;

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
  TfrmSysMultiLangDataTableList = class(TfrmBaseInputDB)
    lblTableName: TLabel;
    edtTableName: TEdit;
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
  Ths.Erp.Database.Table.SysMultiLangDataTableList;

{$R *.dfm}

procedure TfrmSysMultiLangDataTableList.FormCreate(Sender: TObject);
begin
  TSysMultiLangDataTableList(Table).TableName1.SetControlProperty(Table.TableName, edtTableName);

  inherited;
  edtTableName.CharCase := ecNormal;
end;

procedure TfrmSysMultiLangDataTableList.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtTableName.Text := FormatedVariantVal(TSysMultiLangDataTableList(Table).TableName1.FieldType, TSysMultiLangDataTableList(Table).TableName1.Value);
end;

procedure TfrmSysMultiLangDataTableList.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysMultiLangDataTableList(Table).TableName1.Value := edtTableName.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
