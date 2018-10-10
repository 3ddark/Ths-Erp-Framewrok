unit ufrmSysGridColWidth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,
  FireDAC.Stan.Option, FireDAC.Stan.Intf,
  FireDAC.Comp.Client,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmSysGridColWidth = class(TfrmBaseInputDB)
    lblTableName: TLabel;
    lblColumnName: TLabel;
    lblColumnWidth: TLabel;
    lblSequenceNo: TLabel;
    cbbTableName: TComboBox;
    cbbColumnName: TComboBox;
    edtColumnWidth: TEdit;
    edtSequenceNo: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure cbbTableNameChange(Sender: TObject);
  private
  public

  protected
    function ValidateInput(panel_groupbox_pagecontrol_tabsheet: TWinControl = nil): Boolean; override;
  published
  end;

implementation

uses
  Ths.Erp.Database.Table.SysGridColWidth,
  Ths.Erp.Database.Singleton, Ths.Erp.Database.Table;

{$R *.dfm}

procedure TfrmSysGridColWidth.cbbTableNameChange(Sender: TObject);
begin
  TSingletonDB.GetInstance.FillColNameForColWidth(TComboBox(cbbColumnName), ReplaceRealColOrTableNameTo(cbbTableName.Text));
end;

procedure TfrmSysGridColWidth.FormCreate(Sender: TObject);
begin
  TSysGridColWidth(Table).TableName1.SetControlProperty(Table.TableName, cbbTableName);
  TSysGridColWidth(Table).ColumnName.SetControlProperty(Table.TableName, cbbColumnName);
  TSysGridColWidth(Table).ColumnWidth.SetControlProperty(Table.TableName, edtColumnWidth);
  TSysGridColWidth(Table).SequenceNo.SetControlProperty(Table.TableName, edtSequenceNo);

  inherited;

  cbbTableName.CharCase := ecNormal;
  cbbColumnName.CharCase := ecNormal;

  TSingletonDB.GetInstance.FillTableName(TComboBox(cbbTableName));
end;

procedure TfrmSysGridColWidth.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbTableName.ItemIndex := cbbTableName.Items.IndexOf(TSysGridColWidth(Table).TableName1.Value);

  if cbbColumnName.Items.IndexOf(TSysGridColWidth(Table).ColumnName.Value) = -1 then
    cbbColumnName.Items.Add(TSysGridColWidth(Table).ColumnName.Value);
  cbbColumnName.ItemIndex := cbbColumnName.Items.IndexOf(TSysGridColWidth(Table).ColumnName.Value);
  edtColumnWidth.Text := TSysGridColWidth(Table).ColumnWidth.Value;
  edtSequenceNo.Text := TSysGridColWidth(Table).SequenceNo.Value;
end;

function TfrmSysGridColWidth.ValidateInput(
  panel_groupbox_pagecontrol_tabsheet: TWinControl): Boolean;
begin
  Result := inherited ValidateInput();

  //arada rakam atlyacak þekilde giriþ yapýlmýþsa rakamý otomatik olarak düzelt.
  //maks sequence no dan sonraki rakam gelmek zorunda.
  if (FormMode = ifmNewRecord)
  or (FormMode = ifmCopyNewRecord)
  then
  begin
    if StrToInt(edtSequenceNo.Text) > TSysGridColWidth(Table).GetMaxSequenceNo(cbbTableName.Text)+1 then
      edtSequenceNo.Text := IntToStr(TSysGridColWidth(Table).GetMaxSequenceNo(cbbTableName.Text) + 1)
  end
  else if (FormMode = ifmUpdate) then
  begin
    if StrToInt(edtSequenceNo.Text) > TSysGridColWidth(Table).GetMaxSequenceNo(TSysGridColWidth(Table).TableName1.Value) then
      edtSequenceNo.Text := IntToStr(TSysGridColWidth(Table).GetMaxSequenceNo(TSysGridColWidth(Table).TableName1.Value));
  end;
end;

procedure TfrmSysGridColWidth.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      if (FormMode = ifmUpdate) then
      begin
        if TSysGridColWidth(Table).SequenceNo.Value = StrToInt(edtSequenceNo.Text) then
          TSysGridColWidth(Table).SequenceStatus := ssDegisimYok
        else if TSysGridColWidth(Table).SequenceNo.Value > StrToInt(edtSequenceNo.Text) then
          TSysGridColWidth(Table).SequenceStatus := ssAzalma
        else if TSysGridColWidth(Table).SequenceNo.Value < StrToInt(edtSequenceNo.Text) then
          TSysGridColWidth(Table).SequenceStatus := ssArtis;

        TSysGridColWidth(Table).OldValue := TSysGridColWidth(Table).SequenceNo.Value;
      end;

      TSysGridColWidth(Table).TableName1.Value := cbbTableName.Text;
      TSysGridColWidth(Table).ColumnName.Value := cbbColumnName.Text;
      TSysGridColWidth(Table).ColumnWidth.Value := edtColumnWidth.Text;
      TSysGridColWidth(Table).SequenceNo.Value := edtSequenceNo.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
