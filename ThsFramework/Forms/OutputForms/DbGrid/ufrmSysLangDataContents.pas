unit ufrmSysLangDataContents;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysLangDataContents = class(TfrmBaseDBGrid)
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
  ufrmSysLangDataContent,
  Ths.Erp.Database.Table.SysLangDataContent;

{$R *.dfm}

{ TfrmSysLangDataContents }

function TfrmSysLangDataContents.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysLangDataContent.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysLangDataContent.Create(Self, Self, TSysLangDataContent.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysLangDataContent.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysLangDataContents.SetSelectedItem;
begin
  inherited;

  TSysLangDataContent(Table).Lang.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysLangDataContent(Table).Lang.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangDataContent(Table).Lang.FieldName).Value);
  TSysLangDataContent(Table).TableName1.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysLangDataContent(Table).TableName1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangDataContent(Table).TableName1.FieldName).Value);
  TSysLangDataContent(Table).ColumnName.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysLangDataContent(Table).ColumnName.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangDataContent(Table).ColumnName.FieldName).Value);
  TSysLangDataContent(Table).RowID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysLangDataContent(Table).RowID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangDataContent(Table).RowID.FieldName).Value);
  TSysLangDataContent(Table).Value.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysLangDataContent(Table).Value.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysLangDataContent(Table).Value.FieldName).Value);
end;

end.
