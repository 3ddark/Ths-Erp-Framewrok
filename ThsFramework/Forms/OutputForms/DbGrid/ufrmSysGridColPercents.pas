unit ufrmSysGridColPercents;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysGridColPercents = class(TfrmBaseDBGrid)
    procedure FormCreate(Sender: TObject);override;
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
  ufrmSysGridColPercent,
  Ths.Erp.Database.Table.SysGridColPercent;

{$R *.dfm}

{ TfrmSysGridColPercents }

function TfrmSysGridColPercents.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysGridColPercent.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysGridColPercent.Create(Self, Self, TSysGridColPercent.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysGridColPercent.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysGridColPercents.FormCreate(Sender: TObject);
begin
  QueryDefaultFilter := '';
  QueryDefaultOrder := TSysGridColPercent(Table).TableName1.FieldName + ' ASC, ' +
                       TSysGridColPercent(Table).ColumnName.FieldName + ' ASC';
  inherited;
end;

procedure TfrmSysGridColPercents.SetSelectedItem;
begin
  inherited;

  TSysGridColPercent(Table).TableName1.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColPercent(Table).TableName1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColPercent(Table).TableName1.FieldName).Value);
  TSysGridColPercent(Table).ColumnName.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColPercent(Table).ColumnName.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColPercent(Table).ColumnName.FieldName).Value);
  TSysGridColPercent(Table).MaxValue.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColPercent(Table).MaxValue.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColPercent(Table).MaxValue.FieldName).Value);
  TSysGridColPercent(Table).ColorBar.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColPercent(Table).ColorBar.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColPercent(Table).ColorBar.FieldName).Value);
  TSysGridColPercent(Table).ColorBarBack.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColPercent(Table).ColorBarBack.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColPercent(Table).ColorBarBack.FieldName).Value);
  TSysGridColPercent(Table).ColorBarText.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColPercent(Table).ColorBarText.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColPercent(Table).ColorBarText.FieldName).Value);
  TSysGridColPercent(Table).ColorBarTextActive.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColPercent(Table).ColorBarTextActive.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColPercent(Table).ColorBarTextActive.FieldName).Value);
end;

end.
