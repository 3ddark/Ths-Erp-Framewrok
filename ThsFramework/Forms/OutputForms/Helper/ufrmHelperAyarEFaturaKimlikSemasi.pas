unit ufrmHelperAyarEFaturaKimlikSemasi;

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
  Ths.Erp.Database.Table.AyarPrsAskerlikDurumu;

type
  TfrmHelperAyarEFaturaKimlikSemasi = class(TfrmBaseHelper)
  private
  published
    function getFilterEditData: string; override;
  public
  end;

implementation

{$R *.dfm}

function TfrmHelperAyarEFaturaKimlikSemasi.getFilterEditData: string;
begin
  Result := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaKimlikSemasi(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaKimlikSemasi(Table).Deger.FieldName).Value);
end;

end.
