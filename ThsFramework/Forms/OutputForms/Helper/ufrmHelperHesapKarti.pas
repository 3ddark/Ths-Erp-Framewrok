unit ufrmHelperHesapKarti;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.DBGrids, Vcl.Samples.Spin, Vcl.Grids,

  ufrmBaseHelper;

type
  TfrmHelperHesapKarti = class(TfrmBaseHelper)
  private
  protected
  public
  published
    function getFilterEditData: string; override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.HesapKarti;

{$R *.dfm}

function TfrmHelperHesapKarti.getFilterEditData;
begin
  Result := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).HesapKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapKarti(Table).HesapKodu.FieldName).Value);
end;

end.
