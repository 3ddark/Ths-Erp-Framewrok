unit ufrmSysPermissionSources;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

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
  ufrmSysPermissionSource,
  Ths.Erp.Database.Table.SysPermissionSource;

{$R *.dfm}

{ TfrmPermissionSource }

function TfrmSysPermissionSources.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysPermissionSource.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysPermissionSource.Create(Application, Self,
        TSysPermissionSource.Create(Table.Database), True, pFormMode);
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

  TSysPermissionSource(Table).SourceCode.Value := dbgrdBase.DataSource.DataSet.FindField(TSysPermissionSource(Table).SourceCode.FieldName).AsString;
  TSysPermissionSource(Table).SourceName.Value := dbgrdBase.DataSource.DataSet.FindField(TSysPermissionSource(Table).SourceName.FieldName).AsString;
  TSysPermissionSource(Table).SourceGroupID.Value := dbgrdBase.DataSource.DataSet.FindField(TSysPermissionSource(Table).SourceGroupID.FieldName).AsInteger;
  TSysPermissionSource(Table).SourceGroup.Value := dbgrdBase.DataSource.DataSet.FindField(TSysPermissionSource(Table).SourceGroup.FieldName).AsString;
end;

end.
