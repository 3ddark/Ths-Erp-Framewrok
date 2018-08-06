unit ufrmSysGridDefaultOrderFilters;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysGridDefaultOrderFilters = class(TfrmBaseDBGrid)
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
  ufrmSysGridDefaultOrderFilter,
  Ths.Erp.Database.Table.SysGridDefaultOrderFilter;

{$R *.dfm}

{ TfrmSysGridDefaultOrderFilters }

function TfrmSysGridDefaultOrderFilters.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysGridDefaultOrderFilter.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysGridDefaultOrderFilter.Create(Self, Self, TSysGridDefaultOrderFilter.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysGridDefaultOrderFilter.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysGridDefaultOrderFilters.SetSelectedItem;
begin
  inherited;

  TSysGridDefaultOrderFilter(Table).Key.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridDefaultOrderFilter(Table).Key.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridDefaultOrderFilter(Table).Key.FieldName).Value);
  TSysGridDefaultOrderFilter(Table).Value.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridDefaultOrderFilter(Table).Value.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridDefaultOrderFilter(Table).Value.FieldName).Value);
  TSysGridDefaultOrderFilter(Table).IsOrder.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridDefaultOrderFilter(Table).IsOrder.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridDefaultOrderFilter(Table).IsOrder.FieldName).Value);
end;

end.
