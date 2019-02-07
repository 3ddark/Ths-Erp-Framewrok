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
    lbllang: TLabel;
    lblval: TLabel;
    cbblang: TComboBox;
    edtval: TEdit;
    lbltable_name: TLabel;
    lblcolumn_name: TLabel;
    lblrow_id: TLabel;
    cbbtable_name: TComboBox;
    cbbcolumn_name: TComboBox;
    edtrow_id: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure cbbtable_nameChange(Sender: TObject);
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

procedure TfrmSysLangDataContent.cbbtable_nameChange(Sender: TObject);
begin
  fillComboBoxData(cbbcolumn_name, vSysViewColumns, vSysViewColumns.ColumnName.FieldName, ' AND ' + vSysViewColumns.TableName1.FieldName + '=' + QuotedStr(cbbtable_name.Text) + ' ORDER BY ' + vSysViewColumns.OrdinalPosition.FieldName + ' ASC ');
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
  inherited;

  if FormViewMode = ivmSort then
  begin
    lbltable_name.Visible := False;
    cbbtable_name.Visible := False;
    lblcolumn_name.Visible := False;
    cbbcolumn_name.Visible := False;
    lblrow_id.Visible := False;
    edtrow_id.Visible := False;
  end
  else if FormViewMode = ivmNormal then
  begin
    lbltable_name.Visible := True;
    cbbtable_name.Visible := True;
    lblcolumn_name.Visible := True;
    cbbcolumn_name.Visible := True;
    lblrow_id.Visible := True;
    edtrow_id.Visible := True;
  end;

  cbblang.CharCase := ecNormal;
  cbbtable_name.CharCase := ecNormal;
  cbbcolumn_name.CharCase := ecNormal;

  vSysViewTables := TSysViewTables.Create(Table.Database);
  vSysViewColumns := TSysViewColumns.Create(Table.Database);
  vLangs := TSysLang.Create(Table.DataBase);

  fillComboBoxData(cbbtable_name, vSysViewTables, vSysViewTables.TableName1.FieldName, '');
  fillComboBoxData(cbbLang, vLangs, vLangs.Language.FieldName, '');
end;

procedure TfrmSysLangDataContent.btnAcceptClick(Sender: TObject);
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
