unit ufrmHelperHesapGrubu;

interface

{$I ThsERP.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.DBGrids, Vcl.Samples.Spin, Vcl.Grids,

  ufrmBase,
  ufrmBaseHelper,

  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.HesapGrubu;

type
  TfrmHelperHesapGrubu = class(TfrmBaseHelper)
  private
  protected
  public
  published
    function getFilterEditData: string; override;
  end;

implementation

{$R *.dfm}

function TfrmHelperHesapGrubu.getFilterEditData: string;
begin
  Result := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapGrubu(Table).Grup.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapGrubu(Table).Grup.FieldName).Value);
end;

end.
