unit ufrmSysGridColWidths;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysGridColWidths = class(TfrmBaseDBGrid)
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
  ufrmSysGridColWidth,
  Ths.Erp.Database.Table.SysGridColWidth;

{$R *.dfm}

{ TfrmSysGridColWidths }

function TfrmSysGridColWidths.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysGridColWidth.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysGridColWidth.Create(Self, Self, TSysGridColWidth.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysGridColWidth.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysGridColWidths.SetSelectedItem;
begin
  inherited;

  TSysGridColWidth(Table).TableName1.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColWidth(Table).TableName1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColWidth(Table).TableName1.FieldName).Value);
  TSysGridColWidth(Table).ColumnName.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColWidth(Table).ColumnName.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColWidth(Table).ColumnName.FieldName).Value);
  TSysGridColWidth(Table).ColumnWidth.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColWidth(Table).ColumnWidth.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColWidth(Table).ColumnWidth.FieldName).Value);
  TSysGridColWidth(Table).SequenceNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColWidth(Table).SequenceNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColWidth(Table).SequenceNo.FieldName).Value);
end;

end.
