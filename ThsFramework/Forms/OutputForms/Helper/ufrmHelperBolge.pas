unit ufrmHelperBolge;

interface

{$I ThsERP.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.DBGrids, Vcl.Samples.Spin, Vcl.Grids,

  ufrmBaseHelper;

type
  TfrmHelperBolge = class(TfrmBaseHelper)
  private
  protected
  public
  published
    function getFilterEditData: string; override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.Bolge;

{$R *.dfm}

function TfrmHelperBolge.getFilterEditData: string;
begin
  Result := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TBolge(Table).BolgeAdi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TBolge(Table).BolgeAdi.FieldName).Value);
end;

end.