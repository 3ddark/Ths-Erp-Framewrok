unit ufrmSysGridDefaultOrderFilters;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysGridDefaultOrderFilters = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSysGridDefaultOrderFilter,
  Ths.Erp.Database.Table.SysGridDefaultOrderFilter;

{$R *.dfm}

{ TfrmSysGridDefaultOrderFilters }

function TfrmSysGridDefaultOrderFilters.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysGridDefaultOrderFilter.Create(Self, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmSysGridDefaultOrderFilter.Create(Self, Self, TSysGridDefaultOrderFilter.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysGridDefaultOrderFilter.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

end.
