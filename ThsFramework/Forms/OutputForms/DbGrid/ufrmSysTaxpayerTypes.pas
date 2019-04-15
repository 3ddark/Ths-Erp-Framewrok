unit ufrmSysTaxpayerTypes;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.Grids,
  Vcl.Controls, Vcl.Forms, Data.DB, Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts,
  Vcl.ComCtrls,Vcl.ExtCtrls, Vcl.ImgList, Vcl.Samples.Spin, Vcl.StdCtrls,
  ufrmBase, ufrmBaseDBGrid;

type
  TfrmSysTaxPayerTypes = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSysTaxPayerType,
  Ths.Erp.Database.Table.SysTaxpayerType;

{$R *.dfm}

function TfrmSysTaxPayerTypes.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysTaxpayerType.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmSysTaxpayerType.Create(Application, Self, TSysTaxpayerType.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysTaxpayerType.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
