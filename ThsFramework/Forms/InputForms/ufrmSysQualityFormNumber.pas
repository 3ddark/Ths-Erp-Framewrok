unit ufrmSysQualityFormNumber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmSysQualityFormNumber = class(TfrmBaseInputDB)
    lblTableName1: TLabel;
    cbbTableName1: TComboBox;
    lblFormNo: TLabel;
    edtFormNo: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.SysQualityFormNumber;

{$R *.dfm}

procedure TfrmSysQualityFormNumber.FormCreate(Sender: TObject);
begin
  TSysQualityFormNumber(Table).TableName1.SetControlProperty(Table.TableName, cbbTableName1);
  TSysQualityFormNumber(Table).FormNo.SetControlProperty(Table.TableName, edtFormNo);

  inherited;

  cbbTableName1.CharCase := ecNormal;
  edtFormNo.CharCase := ecNormal;

  TSingletonDB.GetInstance.FillTableName(TComboBox(cbbTableName1));
end;

procedure TfrmSysQualityFormNumber.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbTableName1.Text := TSysQualityFormNumber(Table).TableName1.Value;
  edtFormNo.Text := TSysQualityFormNumber(Table).FormNo.Value;
end;

procedure TfrmSysQualityFormNumber.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysQualityFormNumber(Table).TableName1.Value := cbbTableName1.Text;
      TSysQualityFormNumber(Table).FormNo.Value := edtFormNo.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
