unit ufrmSysPermissionSources;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysPermissionSources = class(TfrmBaseDBGrid)
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
  ufrmSysPermissionSource,
  Ths.Erp.Database.Table.SysPermissionSource;

{$R *.dfm}

{ TfrmPermissionSource }

function TfrmSysPermissionSources.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysPermissionSource.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysPermissionSource.Create(Self, Self, TSysPermissionSource.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysPermissionSource.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysPermissionSources.FormCreate(Sender: TObject);
begin
  QueryDefaultFilter := '';
  QueryDefaultOrder := '';
  inherited;
end;

procedure TfrmSysPermissionSources.SetSelectedItem;
begin
  inherited;

  TSysPermissionSource(Table).SourceCode.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysPermissionSource(Table).SourceCode.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysPermissionSource(Table).SourceCode.FieldName).Value);
  TSysPermissionSource(Table).SourceName.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysPermissionSource(Table).SourceName.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysPermissionSource(Table).SourceName.FieldName).Value);
  TSysPermissionSource(Table).SourceGroupID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysPermissionSource(Table).SourceGroupID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysPermissionSource(Table).SourceGroupID.FieldName).Value);
  TSysPermissionSource(Table).SourceGroup.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysPermissionSource(Table).SourceGroup.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysPermissionSource(Table).SourceGroup.FieldName).Value);
end;

end.
