unit ufrmSysPermissionSourceGroups;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysPermissionSourceGroups = class(TfrmBaseDBGrid)
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
  ufrmSysPermissionSourceGroup,
  Ths.Erp.Database.Table.SysPermissionSourceGroup;

{$R *.dfm}

{ TfrmPermissionSourceGroup }

function TfrmSysPermissionSourceGroups.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysPermissionSourceGroup.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysPermissionSourceGroup.Create(Self, Self, TSysPermissionSourceGroup.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysPermissionSourceGroup.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysPermissionSourceGroups.FormCreate(Sender: TObject);
begin
  QueryDefaultFilter := '';
  QueryDefaultOrder := '';
  inherited;
end;

procedure TfrmSysPermissionSourceGroups.SetSelectedItem;
begin
  inherited;

  TSysPermissionSourceGroup(Table).SourceGroup.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TSysPermissionSourceGroup(Table).SourceGroup.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysPermissionSourceGroup(Table).SourceGroup.FieldName).Value);
end;

end.
