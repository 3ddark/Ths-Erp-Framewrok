unit ufrmSysGridColWidth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Samples.Spin,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList,
  FireDAC.Phys.Intf, FireDAC.Stan.Option, FireDAC.Stan.Intf,
  FireDAC.Comp.Client,
  thsEdit, thsComboBox,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.View.SysViewColumns;

type
  TfrmSysGridColWidth = class(TfrmBaseInputDB)
    lbltable_name: TLabel;
    lblcolumn_name: TLabel;
    lblcolumn_width: TLabel;
    lblsequence_no: TLabel;
    cbbtable_name: TthsCombobox;
    edtColumnName: TthsEdit;
    edtcolumn_width: TthsEdit;
    edtsequence_no: TthsEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
    vpTableColumn: TSysViewColumns;
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

procedure TfrmSysGridColWidth.FormCreate(Sender: TObject);
var
  n1: Integer;
  vSL: TStringList;
begin
  TSysGridColWidth(Table).TableName1.SetControlProperty(Table.TableName, cbbtable_name);
  TSysGridColWidth(Table).ColumnName.SetControlProperty(Table.TableName, edtColumnName);
  TSysGridColWidth(Table).ColumnWidth.SetControlProperty(Table.TableName, edtcolumn_width);
  TSysGridColWidth(Table).SequenceNo.SetControlProperty(Table.TableName, edtsequence_no);

  inherited;

  edtColumnName.CharCase := ecLowerCase;

  cbbtable_name.CharCase := ecLowerCase;

  cbbtable_name.Clear;
  vpTableColumn := TSysViewColumns.Create(TSingletonDB.GetInstance.DataBase);
  vSL := vpTableColumn.GetDistinctTableName;
  try
    for n1 := 0 to vSL.Count-1 do
      cbbtable_name.Items.Add( vSL.Strings[n1] );
  finally
    vpTableColumn.Free;
    vSL.Free;
  end;
end;

procedure TfrmSysGridColWidth.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbtable_name.ItemIndex := cbbtable_name.Items.IndexOf( VarToStr(TSysGridColWidth(Table).TableName1.Value) );
  edtColumnName.Text := TSysGridColWidth(Table).ColumnName.Value;
  edtcolumn_width.Text := TSysGridColWidth(Table).ColumnWidth.Value;
  edtsequence_no.Text := TSysGridColWidth(Table).SequenceNo.Value;
end;

function TfrmSysGridColWidth.ValidateInput(
  panel_groupbox_pagecontrol_tabsheet: TWinControl): Boolean;
begin
  Result := inherited ValidateInput();

  //arada rakam atlyacak þekilde giriþ yapýlmýþsa rakamý otomatik olarak düzelt.
  //maks sequence no dan sonraki rakam gelmek zorunda.
  if (FormMode = ifmNewRecord) then
  begin
    if StrToInt(edtsequence_no.Text) > TSysGridColWidth(Table).GetMaxSequenceNo(TSysGridColWidth(Table).TableName1.Value)+1 then
      edtsequence_no.Text := IntToStr(TSysGridColWidth(Table).GetMaxSequenceNo(TSysGridColWidth(Table).TableName1.Value) + 1)
  end
  else if (FormMode = ifmUpdate) then
  begin
    if StrToInt(edtsequence_no.Text) > TSysGridColWidth(Table).GetMaxSequenceNo(TSysGridColWidth(Table).TableName1.Value) then
      edtsequence_no.Text := IntToStr(TSysGridColWidth(Table).GetMaxSequenceNo(TSysGridColWidth(Table).TableName1.Value));
  end;
end;

procedure TfrmSysGridColWidth.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      if (FormMode = ifmUpdate) then
      begin
        if TSysGridColWidth(Table).SequenceNo.Value = StrToInt(edtsequence_no.Text) then
          TSysGridColWidth(Table).SequenceStatus := ssDegisimYok
        else if TSysGridColWidth(Table).SequenceNo.Value > StrToInt(edtsequence_no.Text) then
          TSysGridColWidth(Table).SequenceStatus := ssAzalma
        else if TSysGridColWidth(Table).SequenceNo.Value < StrToInt(edtsequence_no.Text) then
          TSysGridColWidth(Table).SequenceStatus := ssArtis;

        TSysGridColWidth(Table).OldValue := TSysGridColWidth(Table).SequenceNo.Value;
      end;

      TSysGridColWidth(Table).TableName1.Value := cbbtable_name.Text;
      TSysGridColWidth(Table).ColumnName.Value := edtColumnName.Text;
      TSysGridColWidth(Table).ColumnWidth.Value := edtcolumn_width.Text;
      TSysGridColWidth(Table).SequenceNo.Value := edtsequence_no.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
