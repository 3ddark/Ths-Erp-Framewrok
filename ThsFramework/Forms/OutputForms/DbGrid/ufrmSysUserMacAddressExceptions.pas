unit ufrmSysUserMacAddressExceptions;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysUserMacAddressExceptions = class(TfrmBaseDBGrid)
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSysUserMacAddressException,
  Ths.Erp.Database.Table.SysUserMacAddressException;

{$R *.dfm}

{ TfrmSysMacAddressExceptionUsers }

function TfrmSysUserMacAddressExceptions.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysUserMacAddressException.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysUserMacAddressException.Create(Application, Self, TSysUserMacAddressException.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysUserMacAddressException.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysUserMacAddressExceptions.SetSelectedItem;
begin
  inherited;

  TSysUserMacAddressException(Table).UserName.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysUserMacAddressException(Table).UserName.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysUserMacAddressException(Table).UserName.FieldName).Value);
  TSysUserMacAddressException(Table).IpAddress.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysUserMacAddressException(Table).IpAddress.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysUserMacAddressException(Table).IpAddress.FieldName).Value);
end;

end.
