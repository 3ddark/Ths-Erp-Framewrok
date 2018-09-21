unit ufrmDovizKurlari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmDovizKurlari = class(TfrmBaseDBGrid)
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
  ufrmDovizKuru,
  Ths.Erp.Database.Table.DovizKuru;

{$R *.dfm}

{ TfrmDovizKurlari }

function TfrmDovizKurlari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmDovizKuru.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmDovizKuru.Create(Application, Self, TDovizKuru.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmDovizKuru.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmDovizKurlari.SetSelectedItem;
begin
  inherited;

  TDovizKuru(Table).Tarih.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TDovizKuru(Table).Tarih.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TDovizKuru(Table).Tarih.FieldName).Value);
  TDovizKuru(Table).ParaBirimi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TDovizKuru(Table).ParaBirimi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TDovizKuru(Table).ParaBirimi.FieldName).Value);
  TDovizKuru(Table).Kur.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TDovizKuru(Table).Kur.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TDovizKuru(Table).Kur.FieldName).Value);
end;

end.
