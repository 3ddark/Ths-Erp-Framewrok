unit ufrmSysGridColColor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, System.ImageList,
  Vcl.ImgList, Vcl.Samples.Spin, Vcl.AppEvnts,
  thsEdit, thsComboBox,
  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.View.SysViewColumns;

type
  TfrmSysGridColColor = class(TfrmBaseInputDB)
    lbltable_name: TLabel;
    lblcolumn_name: TLabel;
    cbbtable_name: TthsCombobox;
    cbbcolumn_name: TthsCombobox;
    edtmin_value: TthsEdit;
    edtmin_color: TthsEdit;
    lblmin_value: TLabel;
    lblmin_color: TLabel;
    edtmax_value: TthsEdit;
    edtmax_color: TthsEdit;
    lblmax_value: TLabel;
    lblmax_color: TLabel;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure cbbtable_nameChange(Sender: TObject);
    procedure edtmin_colorDblClick(Sender: TObject);
    procedure edtmax_colorDblClick(Sender: TObject);
  private
    vpTableColumn: TSysViewColumns;

    procedure SetColor(color: TColor; editColor: TthsEdit);
  public
  protected
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Table.SysGridColColor,
  Ths.Erp.Database.Singleton,
  Ths.Erp.SpecialFunctions;

{$R *.dfm}

procedure TfrmSysGridColColor.cbbtable_nameChange(Sender: TObject);
var
  n1: Integer;
  vSL: TStringList;
begin
  cbbcolumn_name.Clear;
  vpTableColumn := TSysViewColumns.Create(TSingletonDB.GetInstance.DataBase);
  vSL := vpTableColumn.GetDistinctColumnName(cbbtable_name.Text);
  try
    for n1 := 0 to vSL.Count-1 do
      cbbcolumn_name.Items.Add( vSL.Strings[n1] );

    if (FormMode <> ifmNewRecord) then
      cbbcolumn_name.Items.Add( VarToStr(TSysGridColColor(Table).ColumnName.Value) );
  finally
    vpTableColumn.Free;
    vSL.Free;
  end;
end;

procedure TfrmSysGridColColor.edtmax_colorDblClick(Sender: TObject);
begin
  SetColor(TSpecialFunctions.GetColorFromColorDiaglog, edtmax_color);
end;

procedure TfrmSysGridColColor.edtmin_colorDblClick(Sender: TObject);
begin
  SetColor(TSpecialFunctions.GetColorFromColorDiaglog, edtmin_color);
end;

procedure TfrmSysGridColColor.FormCreate(Sender: TObject);
var
  n1: Integer;
  vSL: TStringList;
begin
  TSysGridColColor(Table).TableName1.SetControlProperty(Table.TableName, cbbtable_name);
  TSysGridColColor(Table).ColumnName.SetControlProperty(Table.TableName, cbbcolumn_name);
  TSysGridColColor(Table).MinValue.SetControlProperty(Table.TableName, edtmin_value);
  TSysGridColColor(Table).MinColor.SetControlProperty(Table.TableName, edtmin_color);
  TSysGridColColor(Table).MaxValue.SetControlProperty(Table.TableName, edtmax_value);
  TSysGridColColor(Table).MaxColor.SetControlProperty(Table.TableName, edtmax_color);

  inherited;

  cbbtable_name.CharCase := ecLowerCase;
  cbbcolumn_name.CharCase := ecLowerCase;

  cbbtable_name.Clear;
  vpTableColumn := TSysViewColumns.Create(TSingletonDB.GetInstance.DataBase);
  vSL := vpTableColumn.GetDistinctTableName;
  try
    for n1 := 0 to vSL.Count-1 do
      cbbtable_name.Items.Add( vSL.Strings[n1] );
  finally
    vpTableColumn.Free;
    vSL.Free;
  end;
end;

procedure TfrmSysGridColColor.FormShow(Sender: TObject);
begin
  inherited;
  edtmin_color.ReadOnly := True;
  edtmax_color.ReadOnly := True;
end;

procedure TfrmSysGridColColor.RefreshData();
begin
  cbbtable_name.ItemIndex := cbbtable_name.Items.IndexOf( VarToStr(TSysGridColColor(Table).TableName1.Value) );
  cbbtable_nameChange(cbbtable_name);
  cbbcolumn_name.ItemIndex := cbbcolumn_name.Items.IndexOf( VarToStr(TSysGridColColor(Table).ColumnName.Value) );
  edtmin_value.Text := TSysGridColColor(Table).MinValue.Value;
  edtmin_color.Text := TSysGridColColor(Table).MinColor.Value;
  SetColor(StrToIntDef(edtmin_color.Text, 0), edtmin_color);
  edtmax_value.Text := TSysGridColColor(Table).MaxValue.Value;
  edtmax_color.Text := TSysGridColColor(Table).MaxColor.Value;
  SetColor(StrToIntDef(edtmax_color.Text, 0), edtmax_color);
end;

procedure TfrmSysGridColColor.SetColor(color: TColor; editColor: TthsEdit);
begin
  editColor.Text := IntToStr(color);
  editColor.Color := color;
  editColor.thsColorActive := color;
  editColor.thsColorRequiredData := color;
  editColor.Repaint;
end;

procedure TfrmSysGridColColor.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysGridColColor(Table).TableName1.Value := cbbtable_name.Text;
      TSysGridColColor(Table).ColumnName.Value := cbbcolumn_name.Text;
      TSysGridColColor(Table).MinValue.Value := edtmin_value.Text;
      TSysGridColColor(Table).MinColor.Value := edtmin_color.Text;
      TSysGridColColor(Table).MaxValue.Value := edtmax_value.Text;
      TSysGridColColor(Table).MaxColor.Value := edtmax_color.Text;
      inherited;
    end;
  end
  else
  begin
    inherited;
    edtmin_color.ReadOnly := True;
    edtmax_color.ReadOnly := True;
  end;
end;

end.
