unit ufrmSysLangGuiContent;

interface

{$I ThsERP.inc}

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
  ;

type
  TfrmSysLangGuiContent = class(TfrmBaseInputDB)
    lbllang: TLabel;
    lblcode: TLabel;
    lblval: TLabel;
    lblcontent_type: TLabel;
    lbltable_name: TLabel;
    lblform_name: TLabel;
    lblis_factory_setting: TLabel;
    edtlang: TEdit;
    edtcode: TEdit;
    edtval: TEdit;
    edtcontent_type: TEdit;
    cbbtable_name: TComboBox;
    edtform_name: TEdit;
    chkis_factory_setting: TCheckBox;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
    procedure HelperProcess(Sender: TObject); override;
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
    Ths.Erp.Database.Singleton
  , Ths.Erp.Database.Table.SysLangGuiContent
  , Ths.Erp.Database.Table.SysLang
  , ufrmHelperSysLang
  ;

{$R *.dfm}

procedure TfrmSysLangGuiContent.FormShow(Sender: TObject);
begin
  inherited;

  edtlang.CharCase := ecNormal;
  edtcode.CharCase := ecNormal;
  edtval.CharCase := ecNormal;
  edtcontent_type.CharCase := ecNormal;
  cbbtable_name.CharCase := ecNormal;
  edtform_name.CharCase := ecNormal;

  edtlang.OnHelperProcess := HelperProcess;
end;

procedure TfrmSysLangGuiContent.HelperProcess(Sender: TObject);
var
  vHelperSysLang: TfrmHelperSysLang;
begin
  if Sender.ClassType = TEdit then
  begin
    if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
    begin
      if TEdit(Sender).Name = edtlang.Name then
      begin
        vHelperSysLang := TfrmHelperSysLang.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperSysLang.ShowModal;

          if Assigned(TSysLangGuiContent(Table).Lang.FK.FKTable) then
            TSysLangGuiContent(Table).Lang.FK.FKTable.Free;
          TSysLangGuiContent(Table).Lang.FK.FKTable := vHelperSysLang.Table.Clone;
        finally
          vHelperSysLang.Free;
        end;
      end
    end;
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
    Height := 200;
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
    Height := 290;
  end;

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
      TSysLangGuiContent(Table).Lang.Value := edtlang.Text;
      TSysLangGuiContent(Table).Code.Value := edtcode.Text;
      TSysLangGuiContent(Table).ContentType.Value := edtcontent_type.Text;
      TSysLangGuiContent(Table).TableName1.Value := cbbtable_name.Text;
      TSysLangGuiContent(Table).Val.Value := edtval.Text;
      TSysLangGuiContent(Table).IsFactorySetting.Value := chkis_factory_setting.Checked;

      inherited;
    end;
  end
  else
    inherited;
end;

end.
