unit ufrmSysPermissionSources;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysPermissionSources = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
    procedure FormCreate(Sender: TObject);override;
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
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysPermissionSource.Create(Self, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmSysPermissionSource.Create(Self, Self, TSysPermissionSource.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysPermissionSource.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysPermissionSources.FormCreate(Sender: TObject);
begin
  QueryDefaultFilter := '';
  QueryDefaultOrder := '';
  inherited;
end;

end.
