unit ufrmSysGridColColors;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysGridColColors = class(TfrmBaseDBGrid)
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
  ufrmSysGridColColor,
  Ths.Erp.Database.Table.SysGridColColor;

{$R *.dfm}

{ TfrmSysGridColColors }

function TfrmSysGridColColors.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysGridColColor.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysGridColColor.Create(Self, Self, TSysGridColColor.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysGridColColor.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysGridColColors.FormCreate(Sender: TObject);
begin
  QueryDefaultFilter := '';
  QueryDefaultOrder := TSysGridColColor(Table).TableName1.FieldName + ' ASC, ' +
                       TSysGridColColor(Table).ColumnName.FieldName + ' ASC';
  inherited;
end;

procedure TfrmSysGridColColors.SetSelectedItem;
begin
  inherited;

  TSysGridColColor(Table).TableName1.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColColor(Table).TableName1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColColor(Table).TableName1.FieldName).Value);
  TSysGridColColor(Table).ColumnName.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColColor(Table).ColumnName.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColColor(Table).ColumnName.FieldName).Value);
  TSysGridColColor(Table).MinValue.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColColor(Table).MinValue.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColColor(Table).MinValue.FieldName).Value);
  TSysGridColColor(Table).MinColor.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColColor(Table).MinColor.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColColor(Table).MinColor.FieldName).Value);
  TSysGridColColor(Table).MaxValue.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColColor(Table).MaxValue.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColColor(Table).MaxValue.FieldName).Value);
  TSysGridColColor(Table).MaxColor.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysGridColColor(Table).MaxColor.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysGridColColor(Table).MaxColor.FieldName).Value);
end;

end.
