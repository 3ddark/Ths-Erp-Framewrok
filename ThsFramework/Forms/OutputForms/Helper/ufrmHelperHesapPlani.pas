unit ufrmHelperHesapPlani;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids,

  ufrmBase,
  ufrmBaseHelper,
  
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.HesapPlani;

type
  TfrmHelperHesapPlani = class(TfrmBaseHelper)
  private
  published
    function getFilterEditData: string; override;
  public
  end;

implementation

{$R *.dfm}

function TfrmHelperHesapPlani.getFilterEditData: string;
var
  aField: TField;
begin
  aField := dbgrdBase.DataSource.DataSet.FindField(THesapPlani(Table).PlanKodu.FieldName);
  if aField.IsNull then
    aField := dbgrdBase.DataSource.DataSet.FindField(THesapPlani(Table).TekDuzenKodu.FieldName);
  Result := FormatedVariantVal(aField.DataType, aField.Value);
end;

end.
