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
  end;

implementation

uses
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
    Result := TfrmSysUserAccessRight.Create(Application, Self,
        TSysUserAccessRight.Create(Table.Database), True, pFormMode);
end;

procedure TfrmSysUserAccessRights.FormCreate(Sender: TObject);
begin
  QueryDefaultFilter := '';
  QueryDefaultOrder := '';
  inherited;
end;

procedure TfrmSysUserAccessRights.SetSelectedItem;
begin
  inherited;

  TSysUserAccessRight(Table).UserName.Value := dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).UserName.FieldName).AsString;
  TSysUserAccessRight(Table).PermissionCode.Value := dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).PermissionCode.FieldName).AsString;
  TSysUserAccessRight(Table).IsRead.Value := dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsRead.FieldName).AsBoolean;
  TSysUserAccessRight(Table).IsAddRecord.Value := dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsAddRecord.FieldName).AsBoolean;
  TSysUserAccessRight(Table).IsUpdate.Value := dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsUpdate.FieldName).AsBoolean;
  TSysUserAccessRight(Table).IsDelete.Value := dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsDelete.FieldName).AsBoolean;
  TSysUserAccessRight(Table).IsSpecial.Value := dbgrdBase.DataSource.DataSet.FindField(TSysUserAccessRight(Table).IsSpecial.FieldName).AsBoolean;
end;

end.
