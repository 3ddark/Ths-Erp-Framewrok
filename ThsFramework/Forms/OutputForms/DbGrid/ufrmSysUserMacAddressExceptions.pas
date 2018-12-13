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
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
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
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysUserMacAddressException.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmSysUserMacAddressException.Create(Application, Self, TSysUserMacAddressException.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysUserMacAddressException.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
