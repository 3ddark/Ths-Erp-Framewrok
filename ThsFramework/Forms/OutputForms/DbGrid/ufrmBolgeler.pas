unit ufrmBolgeler;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmBolgeler = class(TfrmBaseDBGrid)
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
  ufrmBolge,
  Ths.Erp.Database.Table.Bolge;

{$R *.dfm}

{ TfrmBolgeler }

function TfrmBolgeler.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmBolge.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmBolge.Create(Application, Self, TBolge.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmBolge.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmBolgeler.SetSelectedItem;
begin
  inherited;

  TBolge(Table).BolgeTuruID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TBolge(Table).BolgeTuruID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TBolge(Table).BolgeTuruID.FieldName).Value);
  TBolge(Table).BolgeTuru.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TBolge(Table).BolgeTuru.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TBolge(Table).BolgeTuru.FieldName).Value);
  TBolge(Table).BolgeAdi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TBolge(Table).BolgeAdi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TBolge(Table).BolgeAdi.FieldName).Value);
end;

end.
