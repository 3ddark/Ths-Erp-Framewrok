unit ufrmSysUserAccessRights;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysUserAccessRights = class(TfrmBaseDBGrid)
    procedure FormCreate(Sender: TObject);override;
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSysUserAccessRight,
  Ths.Erp.Database.Table.SysUserAccessRight;

{$R *.dfm}

{ TfrmSysUserAccessRights }

function TfrmSysUserAccessRights.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysUserAccessRight.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysUserAccessRight.Create(Application, Self, TSysUserAccessRight.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysUserAccessRight.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysUserAccessRights.FormCreate(Sender: TObject);
begin
  QueryDefaultFilter := '';
  QueryDefaultOrder := '';
  inherited;
end;

procedure TfrmSysUserAccessRights.FormShow(Sender: TObject);
begin
  inherited;
  mniCopyRecord.Visible := True;
end;

procedure TfrmSysUserAccessRights.SetSelectedItem;
begin
  inherited;

  TSysUserAccessRight(Table).UserName.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).UserName.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).UserName.FieldName).Value);
  TSysUserAccessRight(Table).PermissionCode.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).PermissionCode.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).PermissionCode.FieldName).Value);
  TSysUserAccessRight(Table).IsRead.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsRead.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsRead.FieldName).Value);
  TSysUserAccessRight(Table).IsAddRecord.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsAddRecord.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsAddRecord.FieldName).Value);
  TSysUserAccessRight(Table).IsUpdate.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsUpdate.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsUpdate.FieldName).Value);
  TSysUserAccessRight(Table).IsDelete.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsDelete.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsDelete.FieldName).Value);
  TSysUserAccessRight(Table).IsSpecial.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsSpecial.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsSpecial.FieldName).Value);
end;

end.
