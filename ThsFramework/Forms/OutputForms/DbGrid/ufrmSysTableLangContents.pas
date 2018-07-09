unit ufrmSysTableLangContents;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysTableLangContents = class(TfrmBaseDBGrid)
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
  ufrmSysTableLangContent,
  Ths.Erp.Database.Table.SysTableLangContent;

{$R *.dfm}

{ TfrmSysTableLangContents }

function TfrmSysTableLangContents.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysTableLangContent.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysTableLangContent.Create(Application, Self, TSysTableLangContent.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysTableLangContent.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysTableLangContents.SetSelectedItem;
begin
  inherited;

  TSysTableLangContent(Table).Lang.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysTableLangContent(Table).Lang.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysTableLangContent(Table).Lang.FieldName).Value);
  TSysTableLangContent(Table).TableName1.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysTableLangContent(Table).TableName1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysTableLangContent(Table).TableName1.FieldName).Value);
  TSysTableLangContent(Table).ColumnName.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysTableLangContent(Table).ColumnName.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysTableLangContent(Table).ColumnName.FieldName).Value);
  TSysTableLangContent(Table).RowID.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysTableLangContent(Table).RowID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysTableLangContent(Table).RowID.FieldName).Value);
  TSysTableLangContent(Table).Value.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysTableLangContent(Table).Value.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysTableLangContent(Table).Value.FieldName).Value);
end;

end.
