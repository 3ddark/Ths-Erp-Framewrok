unit ufrmSysLang;

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
  TfrmSysLang = class(TfrmBaseInputDB)
    lblLanguage: TLabel;
    edtLanguage: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure Repaint(); override;
    procedure RefreshData();override;
  private
  public

  protected
  published
    procedure FormShow(Sender: TObject); override;
    procedure btnAcceptClick(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Table.SysLang;

{$R *.dfm}

procedure TfrmSysLang.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysLang(Table).Language.Value := edtLanguage.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

procedure TfrmSysLang.FormCreate(Sender: TObject);
begin
  TSysLang(Table).Language.SetControlProperty(Table.TableName, edtLanguage);

  inherited;

  edtLanguage.CharCase := ecNormal;
end;

procedure TfrmSysLang.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmSysLang.Repaint();
begin
  inherited;
  //
end;

procedure TfrmSysLang.RefreshData();
begin
  edtLanguage.Text := TSysLang(Table).Language.Value;
end;

end.
