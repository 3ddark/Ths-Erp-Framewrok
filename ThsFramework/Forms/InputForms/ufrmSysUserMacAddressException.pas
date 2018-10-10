unit ufrmSysUserMacAddressException;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB,

  Ths.Erp.Database.Table.SysUser, Vcl.Samples.Spin;

type
  TfrmSysUserMacAddressException = class(TfrmBaseInputDB)
    lblUserName: TLabel;
    cbbUserName: TComboBox;
    lblIpAddress: TLabel;
    edtIpAddress: TEdit;
  private
  public
    vUser: TSysUser;
  protected
  published
    procedure btnAcceptClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject); override;
    procedure RefreshData; override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.SysUserMacAddressException;

{$R *.dfm}

procedure TfrmSysUserMacAddressException.FormCreate(Sender: TObject);
var
  n1: Integer;
begin
  TSysUserMacAddressException(Table).UserName.SetControlProperty(Table.TableName, cbbUserName);
  TSysUserMacAddressException(Table).IpAddress.SetControlProperty(Table.TableName, edtIpAddress);

  inherited;

  cbbUserName.Clear;

  vUser := TSysUser.Create(TSingletonDB.GetInstance.DataBase);
  try
    vUser.SelectToList('', False, False);
    for n1 := 0 to vUser.List.Count-1 do
      cbbUserName.Items.Add(FormatedVariantVal(TSysUser(vUser.List[n1]).UserName.FieldType, TSysUser(vUser.List[n1]).UserName.Value));
  finally
    vUser.Free;
  end;
end;

procedure TfrmSysUserMacAddressException.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TfrmSysUserMacAddressException.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbUserName.Text := FormatedVariantVal(TSysUserMacAddressException(Table).UserName.FieldType, TSysUserMacAddressException(Table).UserName.Value);
  edtIpAddress.Text := FormatedVariantVal(TSysUserMacAddressException(Table).IpAddress.FieldType, TSysUserMacAddressException(Table).IpAddress.Value);
end;

procedure TfrmSysUserMacAddressException.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysUserMacAddressException(Table).UserName.Value := cbbUserName.Text;
      TSysUserMacAddressException(Table).IpAddress.Value := edtIpAddress.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
