unit ufrmSysLangGuiContent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Samples.Spin,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase,
  ufrmBaseInputDB

  , Ths.Erp.Database.Table.View.SysViewTables
  , Ths.Erp.Database.Table.SysLang
  ;

type
  TfrmSysLangGuiContent = class(TfrmBaseInputDB)
    lbllang: TLabel;
    cbblang: TComboBox;
    lblcode: TLabel;
    edtcode: TEdit;
    lblval: TLabel;
    edtval: TEdit;
    lblcontent_type: TLabel;
    edtcontent_type: TEdit;
    lbltable_name: TLabel;
    cbbtable_name: TComboBox;
    lblform_name: TLabel;
    edtform_name: TEdit;
    lblis_factory_setting: TLabel;
    chkis_factory_setting: TCheckBox;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
    procedure FormCreate(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.SysLangGuiContent;

{$R *.dfm}

procedure TfrmSysLangGuiContent.FormCreate(Sender: TObject);
var
  vLang: TSysLang;
begin
  inherited;

  vLang := TSysLang.Create(Table.Database);
  try
    fillComboBoxData(cbblang, vLang, vLang.Language.FieldName, '');
  finally
    vLang.Free;
  end;
end;

procedure TfrmSysLangGuiContent.RefreshData();
begin
  if FormViewMode = ivmSort then
  begin
    lblcontent_type.Visible := False;
    edtcontent_type.Visible := False;
    lbltable_name.Visible := False;
    cbbtable_name.Visible := False;
    lblis_factory_setting.Visible := False;
    chkis_factory_setting.Visible := False;
    lblform_name.Visible := False;
    edtform_name.Visible := False;
    Height := 170;
  end
  else
  if FormViewMode = ivmNormal then
  begin
    lblcontent_type.Visible := True;
    edtcontent_type.Visible := True;
    lbltable_name.Visible := True;
    cbbtable_name.Visible := True;
    lblis_factory_setting.Visible := True;
    chkis_factory_setting.Visible := True;
    lblform_name.Visible := True;
    edtform_name.Visible := True;
    Height := 260;
  end;

  cbblang.CharCase := ecNormal;
  edtcode.CharCase := ecNormal;
  edtcontent_type.CharCase := ecNormal;
  cbbtable_name.CharCase := ecNormal;
  edtval.CharCase := ecNormal;
  edtform_name.CharCase := ecNormal;

  if cbbtable_name.Items.IndexOf( TSysLangGuiContent(Table).TableName1.Value ) = -1 then
    cbbtable_name.Items.Add( TSysLangGuiContent(Table).TableName1.Value );

  inherited;
end;

procedure TfrmSysLangGuiContent.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      btnAcceptAuto;

      inherited;
    end;
  end
  else
    inherited;
end;

end.
