unit ufrmSysGridDefaultOrderFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Vcl.StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmSysGridDefaultOrderFilter = class(TfrmBaseInputDB)
    lblKey: TLabel;
    cbbKey: TthsCombobox;
    lblValue: TLabel;
    edtValue: TthsEdit;
    lblIsOrder: TLabel;
    chkIsOrder: TCheckBox;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.SysGridDefaultOrderFilter;

{$R *.dfm}

procedure TfrmSysGridDefaultOrderFilter.FormCreate(Sender: TObject);
begin
  TSysGridDefaultOrderFilter(Table).Key.SetControlProperty(Table.TableName, cbbKey);
  TSysGridDefaultOrderFilter(Table).Value.SetControlProperty(Table.TableName, edtValue);

  inherited;

  cbbKey.CharCase := ecNormal;
  edtValue.CharCase := ecNormal;

  TSingletonDB.GetInstance.FillTableName(TComboBox(cbbKey));
end;

procedure TfrmSysGridDefaultOrderFilter.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TfrmSysGridDefaultOrderFilter.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbKey.ItemIndex := cbbKey.Items.IndexOf(TSysGridDefaultOrderFilter(Table).Key.Value);
  edtValue.Text := TSysGridDefaultOrderFilter(Table).Value.Value;
  chkIsOrder.Checked := TSysGridDefaultOrderFilter(Table).IsOrder.Value;
end;

procedure TfrmSysGridDefaultOrderFilter.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysGridDefaultOrderFilter(Table).Key.Value := cbbKey.Text;
      TSysGridDefaultOrderFilter(Table).Value.Value := edtValue.Text;
      TSysGridDefaultOrderFilter(Table).IsOrder.Value := chkIsOrder.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
