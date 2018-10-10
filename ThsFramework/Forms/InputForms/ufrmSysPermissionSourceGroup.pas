unit ufrmSysPermissionSourceGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Samples.Spin,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmSysPermissionSourceGroup = class(TfrmBaseInputDB)
    lblSourceGroup: TLabel;
    edtSourceGroup: TEdit;
    destructor Destroy; override;
    procedure FormCreate(Sender: TObject);override;
    procedure Repaint(); override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public

  protected
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Table.SysPermissionSourceGroup;

{$R *.dfm}

Destructor TfrmSysPermissionSourceGroup.Destroy;
begin
  //
  inherited;
end;

procedure TfrmSysPermissionSourceGroup.FormCreate(Sender: TObject);
begin
  TSysPermissionSourceGroup(Table).SourceGroup.SetControlProperty(Table.TableName, edtSourceGroup);

  inherited;
end;

procedure TfrmSysPermissionSourceGroup.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmSysPermissionSourceGroup.Repaint();
begin
  inherited;
  //
end;

procedure TfrmSysPermissionSourceGroup.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtSourceGroup.Text := TSysPermissionSourceGroup(Table).SourceGroup.Value;
end;

procedure TfrmSysPermissionSourceGroup.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysPermissionSourceGroup(Table).SourceGroup.Value := edtSourceGroup.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
