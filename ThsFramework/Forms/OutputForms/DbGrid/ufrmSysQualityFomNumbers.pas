unit ufrmSysQualityFomNumbers;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysQualityFomNumbers = class(TfrmBaseDBGrid)
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
  ufrmSysQualityFomNumber,
  Ths.Erp.Database.Table.SysQualityFomNumber;

{$R *.dfm}

{ TfrmSysQualityFomNumbers }

function TfrmSysQualityFomNumbers.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysQualityFomNumber.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysQualityFomNumber.Create(Application, Self, TSysQualityFomNumber.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysQualityFomNumber.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysQualityFomNumbers.SetSelectedItem;
begin
  inherited;

  TSysQualityFomNumber(Table).TableName1.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysQualityFomNumber(Table).TableName1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysQualityFomNumber(Table).TableName1.FieldName).Value);
  TSysQualityFomNumber(Table).FormNo.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysQualityFomNumber(Table).FormNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysQualityFomNumber(Table).FormNo.FieldName).Value);
end;

end.
