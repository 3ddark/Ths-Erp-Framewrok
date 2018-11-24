unit ufrmSysQualityFormNumber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB
  , Ths.Erp.Database.Table.View.SysViewTables
  ;

type
  TfrmSysQualityFormNumber = class(TfrmBaseInputDB)
    lblTableName1: TLabel;
    cbbTableName1: TComboBox;
    lblFormNo: TLabel;
    edtFormNo: TEdit;
    chkIsInput: TCheckBox;
    lblIsInput: TLabel;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
    vSysViewTables: TSysViewTables;
  public
    destructor Destroy; override;
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.SysQualityFormNumber;

{$R *.dfm}

destructor TfrmSysQualityFormNumber.Destroy;
begin
  if Assigned(vSysViewTables) then
    vSysViewTables.Free;
  inherited;
end;

procedure TfrmSysQualityFormNumber.FormCreate(Sender: TObject);
begin
  TSysQualityFormNumber(Table).TableName1.SetControlProperty(Table.TableName, cbbTableName1);
  TSysQualityFormNumber(Table).FormNo.SetControlProperty(Table.TableName, edtFormNo);
  TSysQualityFormNumber(Table).IsInputForm.SetControlProperty(Table.TableName, chkIsInput);

  inherited;

  cbbTableName1.CharCase := ecNormal;
  edtFormNo.CharCase := ecNormal;

  vSysViewTables := TSysViewTables.Create(Table.Database);
  fillComboBoxData(cbbTableName1, vSysViewTables, vSysViewTables.TableName1.FieldName, '');
end;

procedure TfrmSysQualityFormNumber.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbTableName1.Text := TSysQualityFormNumber(Table).TableName1.Value;
  edtFormNo.Text := TSysQualityFormNumber(Table).FormNo.Value;
  chkIsInput.Checked := TSysQualityFormNumber(Table).IsInputForm.Value;
end;

procedure TfrmSysQualityFormNumber.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysQualityFormNumber(Table).TableName1.Value := cbbTableName1.Text;
      TSysQualityFormNumber(Table).FormNo.Value := edtFormNo.Text;
      TSysQualityFormNumber(Table).IsInputForm.Value := chkIsInput.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
