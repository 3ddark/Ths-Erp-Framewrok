unit ufrmSysGridColColor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB

  ,Ths.Erp.Database.Table.View.SysViewTables
  ;

type
  TfrmSysGridColColor = class(TfrmBaseInputDB)
    lblTableName: TLabel;
    lblColumnName: TLabel;
    cbbTableName: TComboBox;
    cbbColumnName: TComboBox;
    edtMinValue: TEdit;
    edtMinColor: TEdit;
    lblMinValue: TLabel;
    lblMinColor: TLabel;
    edtMaxValue: TEdit;
    edtMaxColor: TEdit;
    lblMaxValue: TLabel;
    lblMaxColor: TLabel;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure cbbTableNameChange(Sender: TObject);
    procedure edtMinColorDblClick(Sender: TObject);
    procedure edtMaxColorDblClick(Sender: TObject);
  private
    vSysViewTables: TSysViewTables;
    procedure SetColor(color: TColor; editColor: TEdit);
  public
    destructor Destroy; override;
  protected
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Table.SysGridColColor
  , Ths.Erp.Database.Singleton
  , Ths.Erp.Functions
  , Ths.Erp.Constants
  ;

{$R *.dfm}

procedure TfrmSysGridColColor.cbbTableNameChange(Sender: TObject);
var
  lst: TStringList;
  n1: Integer;
begin
  lst := TSingletonDB.GetInstance.GetDistinctColumnName(cbbTableName.Text);
  try
    cbbColumnName.Clear;
    for n1 := 0 to lst.Count-1 do
      cbbColumnName.Items.Add(lst.Strings[n1]);
  finally
    lst.Free;
  end;
end;

destructor TfrmSysGridColColor.Destroy;
begin
  if Assigned(vSysViewTables) then
    vSysViewTables.Free;
  inherited;
end;

procedure TfrmSysGridColColor.edtMaxColorDblClick(Sender: TObject);
begin
  SetColor(TFunctions.GetDialogColor(StrToIntDef(edtMaxColor.Text, 0)), edtMaxColor);
end;

procedure TfrmSysGridColColor.edtMinColorDblClick(Sender: TObject);
begin
  SetColor(TFunctions.GetDialogColor(StrToIntDef(edtMinColor.Text, 0)), edtMinColor);
end;

procedure TfrmSysGridColColor.FormCreate(Sender: TObject);
begin
  TSysGridColColor(Table).TableName1.SetControlProperty(Table.TableName, cbbTableName);
  TSysGridColColor(Table).ColumnName.SetControlProperty(Table.TableName, cbbColumnName);
  TSysGridColColor(Table).MinValue.SetControlProperty(Table.TableName, edtMinValue);
  TSysGridColColor(Table).MinColor.SetControlProperty(Table.TableName, edtMinColor);
  TSysGridColColor(Table).MaxValue.SetControlProperty(Table.TableName, edtMaxValue);
  TSysGridColColor(Table).MaxColor.SetControlProperty(Table.TableName, edtMaxColor);

  inherited;

  cbbTableName.CharCase := ecNormal;
  cbbColumnName.CharCase := ecNormal;

  vSysViewTables := TSysViewTables.Create(Table.Database);

  fillComboBoxData(cbbTableName, vSysViewTables, vSysViewTables.TableName1.FieldName, '');
  cbbTableNameChange(cbbTableName);
end;

procedure TfrmSysGridColColor.FormShow(Sender: TObject);
begin
  inherited;
  edtMinColor.ReadOnly := True;
  edtMaxColor.ReadOnly := True;
end;

procedure TfrmSysGridColColor.RefreshData();
begin
  cbbTableName.ItemIndex := cbbTableName.Items.IndexOf( VarToStr(TSysGridColColor(Table).TableName1.Value) );
  cbbTableNameChange(cbbTableName);
  cbbColumnName.ItemIndex := cbbColumnName.Items.IndexOf( VarToStr(TSysGridColColor(Table).ColumnName.Value) );
  edtMinValue.Text := TSysGridColColor(Table).MinValue.Value;
  edtMinColor.Text := TSysGridColColor(Table).MinColor.Value;
  SetColor(StrToIntDef(edtMinColor.Text, 0), edtMinColor);
  edtMaxValue.Text := TSysGridColColor(Table).MaxValue.Value;
  edtMaxColor.Text := TSysGridColColor(Table).MaxColor.Value;
  SetColor(StrToIntDef(edtMaxColor.Text, 0), edtMaxColor);
end;

procedure TfrmSysGridColColor.SetColor(color: TColor; editColor: TEdit);
begin
  editColor.Text := IntToStr(color);
  editColor.Color := color;
  editColor.thsColorActive := color;
  editColor.thsColorRequiredData := color;
  editColor.Repaint;
end;

procedure TfrmSysGridColColor.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      if cbbTableName.Items.IndexOf(cbbTableName.Text) = -1 then
        raise Exception.Create( TranslateText('Listede olmayan bir Tablo Adý giremezsiniz!', '#1', LngError, LngSystem) );

      if cbbColumnName.Items.IndexOf(cbbColumnName.Text) = -1 then
        raise Exception.Create(TranslateText('Listede olmayan bir Kolon Adý giremezsiniz!', '#1', LngError, LngSystem) );

      TSysGridColColor(Table).TableName1.Value := cbbTableName.Text;
      TSysGridColColor(Table).ColumnName.Value := cbbColumnName.Text;
      TSysGridColColor(Table).MinValue.Value := edtMinValue.Text;
      TSysGridColColor(Table).MinColor.Value := edtMinColor.Text;
      TSysGridColColor(Table).MaxValue.Value := edtMaxValue.Text;
      TSysGridColColor(Table).MaxColor.Value := edtMaxColor.Text;
      inherited;
    end;
  end
  else
  begin
    inherited;
    edtMinColor.ReadOnly := True;
    edtMaxColor.ReadOnly := True;
  end;
end;

end.
