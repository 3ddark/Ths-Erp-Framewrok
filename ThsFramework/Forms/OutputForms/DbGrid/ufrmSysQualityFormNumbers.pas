unit ufrmSysQualityFormNumbers;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysQualityFormNumbers = class(TfrmBaseDBGrid)
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
  ufrmSysQualityFormNumber,
  Ths.Erp.Database.Table.SysQualityFormNumber;

{$R *.dfm}

{ TfrmSysQualityFomNumbers }

function TfrmSysQualityFormNumbers.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysQualityFormNumber.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysQualityFormNumber.Create(Self, Self, TSysQualityFormNumber.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysQualityFormNumber.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysQualityFormNumbers.SetSelectedItem;
begin
  inherited;

  TSysQualityFormNumber(Table).TableName1.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysQualityFormNumber(Table).TableName1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysQualityFormNumber(Table).TableName1.FieldName).Value);
  TSysQualityFormNumber(Table).FormNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysQualityFormNumber(Table).FormNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysQualityFormNumber(Table).FormNo.FieldName).Value);
end;

end.
