unit ufrmSysUserAccessRight;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,

  thsEdit, thsComboBox,
  ufrmBase, ufrmBaseInputDB, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmSysUserAccessRight = class(TfrmBaseInputDB)
    lblUserName: TLabel;
    lblSourceName: TLabel;
    lblIsRead: TLabel;
    lblIsAddRecord: TLabel;
    lblIsUpdate: TLabel;
    lblIsDelete: TLabel;
    lblIsSpecial: TLabel;
    cbbUserName: TthsCombobox;
    cbbSourceName: TthsCombobox;
    cbxIsRead: TCheckBox;
    cbxIsAddRecord: TCheckBox;
    cbxIsUpdate: TCheckBox;
    cbxIsDelete: TCheckBox;
    cbxIsSpecial: TCheckBox;
    procedure FormCreate(Sender: TObject);override;
    procedure Repaint(); override;
    procedure RefreshData();override;
  private
  public

  protected
  published
    procedure FormShow(Sender: TObject); override;
    procedure btnAcceptClick(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Table.SysUserAccessRight, Ths.Erp.Database.Table.SysUser, Ths.Erp.Database.Table.SysPermissionSource;

{$R *.dfm}

procedure TfrmSysUserAccessRight.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysUserAccessRight(Table).UserName.Value := cbbUserName.Text;
      //TSysUserAccessRight(Table).PermissionCode.Value := cbbSourceName.Text;
      TSysUserAccessRight(Table).PermissionCode.Value := TSysPermissionSource(cbbSourceName.Items.Objects[cbbSourceName.ItemIndex]).SourceCode.Value;
      TSysUserAccessRight(Table).IsRead.Value := cbxIsRead.Checked;
      TSysUserAccessRight(Table).IsAddRecord.Value := cbxIsAddRecord.Checked;
      TSysUserAccessRight(Table).IsUpdate.Value := cbxIsUpdate.Checked;
      TSysUserAccessRight(Table).IsDelete.Value := cbxIsDelete.Checked;
      TSysUserAccessRight(Table).IsSpecial.Value := cbxIsSpecial.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

procedure TfrmSysUserAccessRight.FormCreate(Sender: TObject);
var
  vUser: TSysUser;
  vPermissionSource: TSysPermissionSource;
  n1: Integer;
begin
  TSysUserAccessRight(Table).UserName.SetControlProperty(Table.TableName, cbbUserName);
  TSysUserAccessRight(Table).PermissionCode.SetControlProperty(Table.TableName, cbbSourceName);

  inherited;

  cbbUserName.Clear;
  vUser := TSysUser.Create(Table.Database);
  try
    vUser.SelectToList('', False, False);
    for n1 := 0 to vUser.List.Count-1 do
      cbbUserName.Items.Add(TSysUser(vUser.List[n1]).UserName.Value);
  finally
    vUser.Free;
  end;

  cbbSourceName.Clear;
  vPermissionSource := TSysPermissionSource.Create(Table.Database);
  try
    vPermissionSource.SelectToList('', False, False);
    for n1 := 0 to vPermissionSource.List.Count-1 do
      cbbSourceName.Items.AddObject(TSysPermissionSource(vPermissionSource.List[n1]).SourceName.Value, TSysPermissionSource(vPermissionSource.List[n1]).Clone);
  finally
    vPermissionSource.Free;
  end;
end;

procedure TfrmSysUserAccessRight.FormDestroy(Sender: TObject);
var
  n1: Integer;
begin
  for n1 := cbbSourceName.Items.Count-1 downto 0 do
    if Assigned(cbbSourceName.Items.Objects[n1]) then
      cbbSourceName.Items.Objects[n1].Free;
  inherited;
end;

procedure TfrmSysUserAccessRight.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmSysUserAccessRight.Repaint();
begin
  inherited;
  //
end;

procedure TfrmSysUserAccessRight.RefreshData();
var
  n1: Integer;
begin
  //control içeriðini table class ile doldur
  cbbUserName.ItemIndex := cbbUserName.Items.IndexOf( TSysUserAccessRight(Table).UserName.Value );

  for n1 := 0 to cbbSourceName.Items.Count-1 do
    if TSysPermissionSource(cbbSourceName.Items.Objects[n1]).SourceCode.Value = TSysUserAccessRight(Table).PermissionCode.Value then
      cbbSourceName.ItemIndex := n1;

  cbxIsRead.Checked := TSysUserAccessRight(Table).IsRead.Value;
  cbxIsAddRecord.Checked := TSysUserAccessRight(Table).IsAddRecord.Value;
  cbxIsUpdate.Checked := TSysUserAccessRight(Table).IsUpdate.Value;
  cbxIsDelete.Checked := TSysUserAccessRight(Table).IsDelete.Value;
  cbxIsSpecial.Checked := TSysUserAccessRight(Table).IsSpecial.Value;
end;

end.
