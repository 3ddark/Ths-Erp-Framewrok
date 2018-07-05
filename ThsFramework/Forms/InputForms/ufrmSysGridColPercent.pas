unit ufrmSysGridColPercent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  thsEdit, thsComboBox,
  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.View.SysViewColumns;

type
  TfrmSysGridColPercent = class(TfrmBaseInputDB)
    lbltable_name: TLabel;
    lblcolumn_name: TLabel;
    cbbtable_name: TthsCombobox;
    cbbcolumn_name: TthsCombobox;
    lblmax_value: TLabel;
    lblcolor_bar_back: TLabel;
    lblcolor_bar_text: TLabel;
    lblcolor_bar: TLabel;
    lblcolor_bar_text_active: TLabel;
    edtmax_value: TthsEdit;
    edtcolor_bar: TthsEdit;
    edtcolor_bar_back: TthsEdit;
    edtcolor_bar_text: TthsEdit;
    edtcolor_bar_text_active: TthsEdit;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure cbbtable_nameChange(Sender: TObject);
    procedure edtcolor_barDblClick(Sender: TObject);
    procedure edtcolor_bar_backDblClick(Sender: TObject);
    procedure edtcolor_bar_textDblClick(Sender: TObject);
    procedure edtcolor_bar_text_activeDblClick(Sender: TObject);
  private
    vpTableColumn: TSysViewColumns;

    procedure SetColor(color: TColor; editColor: TthsEdit);
    procedure DrawBar;
  public
  protected
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Table.SysGridColPercent,
  Ths.Erp.Database.Singleton,
  Ths.Erp.SpecialFunctions;

{$R *.dfm}

procedure TfrmSysGridColPercent.cbbtable_nameChange(Sender: TObject);
var
  n1: Integer;
  vSL: TStringList;
begin
  cbbcolumn_name.Clear;
  vpTableColumn := TSysViewColumns.Create(TSingletonDB.GetInstance.DataBase);
  vSL := vpTableColumn.GetDistinctColumnName(cbbtable_name.Text);
  try
    for n1 := 0 to vSL.Count-1 do
      cbbcolumn_name.Items.Add( vSL.Strings[n1] );

    if (FormMode <> ifmNewRecord) then
      cbbcolumn_name.Items.Add( VarToStr(TSysGridColPercent(Table).ColumnName.Value) );
  finally
    vpTableColumn.Free;
    vSL.Free;
  end;
end;

procedure TfrmSysGridColPercent.DrawBar;
var
  x1, x2, y1, y2: Integer;
  rect: TRect;
  vTemp: string;
begin
  vTemp := 'Example %40';
  with Image1 do
  begin
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Width := 1;

    Canvas.Pen.Color := StringToColor(edtcolor_bar_back.Text);
    Canvas.Brush.Color := StringToColor(edtcolor_bar_back.Text);
    x1 := 0;  x2 := Width;  y1 := 0;  y2 := Height;
    Canvas.Rectangle( x1, y1, x2, y2 );

    Canvas.Pen.Color := StringToColor(edtcolor_bar.Text);
    Canvas.Brush.Color := StringToColor(edtcolor_bar.Text);
    x1 := 1;  x2 := trunc(Width*0.40);  y1 := 1;  y2 := Height;
    Canvas.Rectangle( x1, y1, x2, y2 );

    Canvas.Brush.Style := bsClear;
    Canvas.Font.Color := StringToColor( edtcolor_bar_text.Text );
    //Canvas.Brush.Color := StringToColor(edtcolor_bar_text.Text);
    rect.Left := (Image1.Width - Canvas.TextWidth(vTemp)) div 2;
    rect.Right := rect.Left + Canvas.TextWidth(vTemp);
    rect.Top := (Image1.Height - Canvas.TextHeight(vTemp)) div 2;
    rect.Bottom := rect.Top + Canvas.TextHeight(vTemp);
    Canvas.TextRect(rect, vTemp);

    Repaint;
  end;
end;

procedure TfrmSysGridColPercent.edtcolor_barDblClick(Sender: TObject);
begin
  SetColor(TSpecialFunctions.GetColorFromColorDiaglog, edtcolor_bar);
end;

procedure TfrmSysGridColPercent.edtcolor_bar_backDblClick(Sender: TObject);
begin
  SetColor(TSpecialFunctions.GetColorFromColorDiaglog, edtcolor_bar_back);
end;

procedure TfrmSysGridColPercent.edtcolor_bar_textDblClick(Sender: TObject);
begin
  SetColor(TSpecialFunctions.GetColorFromColorDiaglog, edtcolor_bar_text);
end;

procedure TfrmSysGridColPercent.edtcolor_bar_text_activeDblClick(
  Sender: TObject);
begin
  SetColor(TSpecialFunctions.GetColorFromColorDiaglog, edtcolor_bar_text_active);
end;

procedure TfrmSysGridColPercent.FormCreate(Sender: TObject);
var
  n1: Integer;
  vSL: TStringList;
begin
  TSysGridColPercent(Table).TableName1.SetControlProperty(Table.TableName, cbbtable_name);
  TSysGridColPercent(Table).ColumnName.SetControlProperty(Table.TableName, cbbcolumn_name);
  TSysGridColPercent(Table).MaxValue.SetControlProperty(Table.TableName, edtmax_value);
  TSysGridColPercent(Table).ColorBar.SetControlProperty(Table.TableName, edtcolor_bar);
  TSysGridColPercent(Table).ColorBarBack.SetControlProperty(Table.TableName, edtcolor_bar_back);
  TSysGridColPercent(Table).ColorBarText.SetControlProperty(Table.TableName, edtcolor_bar_text);
  TSysGridColPercent(Table).ColorBarTextActive.SetControlProperty(Table.TableName, edtcolor_bar_text_active);

  inherited;

  cbbtable_name.CharCase := ecLowerCase;
  cbbcolumn_name.CharCase := ecLowerCase;

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

procedure TfrmSysGridColPercent.FormShow(Sender: TObject);
begin
  inherited;
  edtcolor_bar.ReadOnly := True;
  edtcolor_bar_back.ReadOnly := True;
  edtcolor_bar_text.ReadOnly := True;
  edtcolor_bar_text_active.ReadOnly := True;
end;

procedure TfrmSysGridColPercent.RefreshData();
begin
  cbbtable_name.ItemIndex := cbbtable_name.Items.IndexOf( VarToStr(TSysGridColPercent(Table).TableName1.Value) );
  cbbtable_nameChange(cbbtable_name);
  cbbcolumn_name.ItemIndex := cbbcolumn_name.Items.IndexOf( VarToStr(TSysGridColPercent(Table).ColumnName.Value) );
  edtmax_value.Text := TSysGridColPercent(Table).MaxValue.Value;
  edtcolor_bar.Text := TSysGridColPercent(Table).ColorBar.Value;
  edtcolor_bar_back.Text := TSysGridColPercent(Table).ColorBarBack.Value;
  edtcolor_bar_text.Text := TSysGridColPercent(Table).ColorBarText.Value;
  edtcolor_bar_text_active.Text := TSysGridColPercent(Table).ColorBarTextActive.Value;

  SetColor(StrToIntDef(edtcolor_bar_text.Text, 0), edtcolor_bar_text);
  SetColor(StrToIntDef(edtcolor_bar.Text, 0), edtcolor_bar);
  SetColor(StrToIntDef(edtcolor_bar_back.Text, 0), edtcolor_bar_back);
  SetColor(StrToIntDef(edtcolor_bar_text_active.Text, 0), edtcolor_bar_text_active);

  DrawBar;
end;

procedure TfrmSysGridColPercent.SetColor(color: TColor; editColor: TthsEdit);
begin
  editColor.Text := IntToStr(color);
  editColor.Color := color;
  editColor.thsColorActive := color;
  editColor.thsColorRequiredData := color;
  editColor.Repaint;
  DrawBar;
end;

procedure TfrmSysGridColPercent.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysGridColPercent(Table).TableName1.Value := cbbtable_name.Text;
      TSysGridColPercent(Table).ColumnName.Value := cbbcolumn_name.Text;
      TSysGridColPercent(Table).MaxValue.Value := edtmax_value.Text;
      TSysGridColPercent(Table).ColorBar.Value := edtcolor_bar.Text;
      TSysGridColPercent(Table).ColorBarBack.Value := edtcolor_bar_back.Text;
      TSysGridColPercent(Table).ColorBarText.Value := edtcolor_bar_text.Text;
      TSysGridColPercent(Table).ColorBarTextActive.Value := edtcolor_bar_text_active.Text;
      inherited;
    end;
  end
  else
  begin
    inherited;
    edtcolor_bar.ReadOnly := True;
    edtcolor_bar_back.ReadOnly := True;
    edtcolor_bar_text.ReadOnly := True;
    edtcolor_bar_text_active.ReadOnly := True;
  end;
end;

end.
