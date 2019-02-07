unit ufrmSysGridDefaultOrderFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Vcl.StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.Samples.Spin, Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB
  , Ths.Erp.Database.Table.View.SysViewTables
  ;

type
  TfrmSysGridDefaultOrderFilter = class(TfrmBaseInputDB)
    lblKey: TLabel;
    cbbKey: TComboBox;
    lblValue: TLabel;
    edtValue: TEdit;
    lblIsOrder: TLabel;
    chkIsOrder: TCheckBox;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
    vSysViewTables: TSysViewTables;
  public
    destructor Destroy; override;
  protected
  published
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton
  , Ths.Erp.Functions
  , Ths.Erp.Constants
  , Ths.Erp.Database.Table.SysGridDefaultOrderFilter
  ;

{$R *.dfm}

destructor TfrmSysGridDefaultOrderFilter.Destroy;
begin
  if Assigned(vSysViewTables) then
    vSysViewTables.Free;
  inherited;
end;

procedure TfrmSysGridDefaultOrderFilter.FormCreate(Sender: TObject);
begin
  TSysGridDefaultOrderFilter(Table).Key.SetControlProperty(Table.TableName, cbbKey);
  TSysGridDefaultOrderFilter(Table).Value.SetControlProperty(Table.TableName, edtValue);

  inherited;

  cbbKey.CharCase := ecNormal;
  edtValue.CharCase := ecNormal;

  vSysViewTables := TSysViewTables.Create(Table.Database);
  fillComboBoxData(cbbKey, vSysViewTables, vSysViewTables.TableName1.FieldName, '');
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
      if cbbKey.Items.IndexOf(cbbKey.Text) = -1 then
        raise Exception.Create( TranslateText('Listede olmayan bir Tablo Adý giremezsiniz!', '#1', LngMsgError, LngSystem) );

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
