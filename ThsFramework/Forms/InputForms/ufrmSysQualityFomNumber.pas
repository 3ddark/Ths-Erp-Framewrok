unit ufrmSysQualityFomNumber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.View.SysViewColumns, Vcl.Menus;

type
  TfrmSysQualityFomNumber = class(TfrmBaseInputDB)
    lblTableName1: TLabel;
    cbbTableName1: TthsComboBox;
    lblFormNo: TLabel;
    edtFormNo: TthsEdit;
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
  Ths.Erp.Database.Table.SysQualityFomNumber;

{$R *.dfm}

procedure TfrmSysQualityFomNumber.FormCreate(Sender: TObject);
begin
  TSysQualityFomNumber(Table).TableName1.SetControlProperty(Table.TableName, cbbTableName1);
  TSysQualityFomNumber(Table).FormNo.SetControlProperty(Table.TableName, edtFormNo);

  inherited;

  cbbTableName1.CharCase := ecNormal;
  edtFormNo.CharCase := ecNormal;

  TSingletonDB.GetInstance.FillTableName(TComboBox(cbbTableName1));
end;

procedure TfrmSysQualityFomNumber.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbTableName1.Text := TSysQualityFomNumber(Table).TableName1.Value;
  edtFormNo.Text := TSysQualityFomNumber(Table).FormNo.Value;
end;

procedure TfrmSysQualityFomNumber.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysQualityFomNumber(Table).TableName1.Value := cbbTableName1.Text;
      TSysQualityFomNumber(Table).FormNo.Value := edtFormNo.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
