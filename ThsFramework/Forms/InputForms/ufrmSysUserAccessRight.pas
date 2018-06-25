unit ufrmSysUserAccessRight;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,

  thsEdit, thsComboBox,
  ufrmBase, ufrmBaseInputDB, Vcl.AppEvnts, System.ImageList, Vcl.ImgList,
  Vcl.Samples.Spin;

type
  TfrmSysUserAccessRight = class(TfrmBaseInputDB)
    lblUserName: TLabel;
    cbbUserName: TthsCombobox;
    lblSourceCode: TLabel;
    edtSourceCode: TthsEdit;
    lblIsRead: TLabel;
    cbxIsRead: TCheckBox;
    lblIsAddRecord: TLabel;
    cbxIsAddRecord: TCheckBox;
    lblIsUpdate: TLabel;
    cbxIsUpdate: TCheckBox;
    lblIsDelete: TLabel;
    cbxIsDelete: TCheckBox;
    lblIsSpecial: TLabel;
    cbxIsSpecial: TCheckBox;
    destructor Destroy; override;
    procedure FormCreate(Sender: TObject);override;
    procedure Repaint(); override;
    procedure RefreshData();override;
  private
  public

  protected
  published
    procedure FormShow(Sender: TObject); override;
    procedure btnAcceptClick(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Table.SysUserAccessRight, Ths.Erp.Database.Table.SysUser;

{$R *.dfm}

procedure TfrmSysUserAccessRight.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysUserAccessRight(Table).UserName.Value := cbbUserName.Text;
      TSysUserAccessRight(Table).PermissionCode.Value := edtSourceCode.Text;
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

Destructor TfrmSysUserAccessRight.Destroy;
begin
  //
  inherited;
end;

procedure TfrmSysUserAccessRight.FormCreate(Sender: TObject);
var
  vUser: TSysUser;
  n1: Integer;
begin
  TSysUserAccessRight(Table).UserName.SetControlProperty(Table.TableName, cbbUserName);
  TSysUserAccessRight(Table).PermissionCode.SetControlProperty(Table.TableName, edtSourceCode);

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
begin
  //control içeriðini table class ile doldur
  cbbUserName.ItemIndex := cbbUserName.Items.IndexOf( TSysUserAccessRight(Table).UserName.Value );
  edtSourceCode.Text := TSysUserAccessRight(Table).PermissionCode.Value;
  cbxIsRead.Checked := TSysUserAccessRight(Table).IsRead.Value;
  cbxIsAddRecord.Checked := TSysUserAccessRight(Table).IsAddRecord.Value;
  cbxIsUpdate.Checked := TSysUserAccessRight(Table).IsUpdate.Value;
  cbxIsDelete.Checked := TSysUserAccessRight(Table).IsDelete.Value;
  cbxIsSpecial.Checked := TSysUserAccessRight(Table).IsSpecial.Value;
end;

end.
