unit ufrmSysPermissionSource;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,

  thsEdit, thsComboBox,
  ufrmBase, ufrmBaseInputDB, Vcl.AppEvnts, System.ImageList, Vcl.ImgList,
  Vcl.Samples.Spin,
  Ths.Erp.Database.Table.SysPermissionSourceGroup;

type
  TfrmSysPermissionSource = class(TfrmBaseInputDB)
    lblSourceCode: TLabel;
    edtSourceCode: TthsEdit;
    lblSourceName: TLabel;
    edtSourceName: TthsEdit;
    lblSourceGroup: TLabel;
    cbbSourceGroup: TthsCombobox;
    destructor Destroy; override;
    procedure FormCreate(Sender: TObject);override;
    procedure Repaint(); override;
    procedure RefreshData();override;
  private
    vpSourceGroup: TSysPermissionSourceGroup;
  public

  protected
  published
    procedure FormShow(Sender: TObject); override;
    procedure btnAcceptClick(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Table.SysPermissionSource;

{$R *.dfm}

procedure TfrmSysPermissionSource.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysPermissionSource(Table).SourceCode.Value := edtSourceCode.Text;
      TSysPermissionSource(Table).SourceName.Value := edtSourceName.Text;
      TSysPermissionSource(Table).SourceGroup.Value := TSysPermissionSourceGroup(cbbSourceGroup.Items.Objects[cbbSourceGroup.ItemIndex]).SourceGroup.Value;
      TSysPermissionSource(Table).SourceGroupID.Value := TSysPermissionSourceGroup(cbbSourceGroup.Items.Objects[cbbSourceGroup.ItemIndex]).Id.Value;
      inherited;
    end;
  end
  else
    inherited;
end;

Destructor TfrmSysPermissionSource.Destroy;
begin
  vpSourceGroup.Free;

  inherited;
end;

procedure TfrmSysPermissionSource.FormCreate(Sender: TObject);
var
  n1: Integer;
begin
  TSysPermissionSource(Table).SourceCode.SetControlProperty(Table.TableName, edtSourceCode);
  TSysPermissionSource(Table).SourceName.SetControlProperty(Table.TableName, edtSourceName);
  TSysPermissionSource(Table).SourceGroup.SetControlProperty(Table.TableName, cbbSourceGroup);

  inherited;

  vpSourceGroup := TSysPermissionSourceGroup.Create(Table.Database);
  vpSourceGroup.SelectToList('', False, False);

  cbbSourceGroup.Items.Clear;
  for n1 := 0 to vpSourceGroup.List.Count-1 do
    cbbSourceGroup.Items.AddObject(TSysPermissionSourceGroup(vpSourceGroup.List[n1]).SourceGroup.Value, TSysPermissionSourceGroup(vpSourceGroup.List[n1]));
end;

procedure TfrmSysPermissionSource.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmSysPermissionSource.Repaint();
begin
  inherited;
  //
end;

procedure TfrmSysPermissionSource.RefreshData();
var
  n1: Integer;
begin
  //control içeriðini table class ile doldur
  edtSourceCode.Text := TSysPermissionSource(Table).SourceCode.Value;
  edtSourceName.Text := TSysPermissionSource(Table).SourceName.Value;
  for n1 := 0 to cbbSourceGroup.Items.Count-1 do
    if TSysPermissionSourceGroup(cbbSourceGroup.Items.Objects[n1]).Id.Value = TSysPermissionSource(Table).SourceGroupID.Value then
    begin
      cbbSourceGroup.ItemIndex := n1;
      Break;
    end;
end;

end.
