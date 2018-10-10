unit ufrmSysGridColPercent;

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
  TfrmSysGridColPercent = class(TfrmBaseInputDB)
    lblTableName: TLabel;
    lblColumnName: TLabel;
    cbbTableName: TComboBox;
    cbbColumnName: TComboBox;
    lblMaxValue: TLabel;
    lblColorBarBack: TLabel;
    lblColorBarText: TLabel;
    lblColorBar: TLabel;
    lblColorBarTextActive: TLabel;
    edtMaxValue: TEdit;
    edtColorBar: TEdit;
    edtColorBarBack: TEdit;
    edtColorBarText: TEdit;
    edtColorBarTextActive: TEdit;
    imgExample: TImage;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure cbbTableNameChange(Sender: TObject);
    procedure edtColorBarDblClick(Sender: TObject);
    procedure edtColorBarBackDblClick(Sender: TObject);
    procedure edtColorBarTextDblClick(Sender: TObject);
    procedure edtColorBarTextActiveDblClick(Sender: TObject);
  private
    procedure SetColor(color: TColor; editColor: TEdit);
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

procedure TfrmSysGridColPercent.cbbTableNameChange(Sender: TObject);
begin
  TSingletonDB.GetInstance.FillColName(TComboBox(cbbColumnName), cbbTableName.Text);
end;

procedure TfrmSysGridColPercent.DrawBar;
var
  x1, x2, y1, y2: Integer;
  rect: TRect;
  vTemp: string;
begin
  vTemp := 'Example %40';
  with imgExample do
  begin
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Width := 1;

    Canvas.Pen.Color := StringToColor(edtColorBarBack.Text);
    Canvas.Brush.Color := StringToColor(edtColorBarBack.Text);
    x1 := 0;  x2 := Width;  y1 := 0;  y2 := Height;
    Canvas.Rectangle( x1, y1, x2, y2 );

    Canvas.Pen.Color := StringToColor(edtColorBar.Text);
    Canvas.Brush.Color := StringToColor(edtColorBar.Text);
    x1 := 1;  x2 := trunc(Width*0.40);  y1 := 1;  y2 := Height;
    Canvas.Rectangle( x1, y1, x2, y2 );

    Canvas.Brush.Style := bsClear;
    Canvas.Font.Color := StringToColor( edtColorBarText.Text );
    //Canvas.Brush.Color := StringToColor(edtcolor_bar_text.Text);
    rect.Left := (imgExample.Width - Canvas.TextWidth(vTemp)) div 2;
    rect.Right := rect.Left + Canvas.TextWidth(vTemp);
    rect.Top := (imgExample.Height - Canvas.TextHeight(vTemp)) div 2;
    rect.Bottom := rect.Top + Canvas.TextHeight(vTemp);
    Canvas.TextRect(rect, vTemp);

    Repaint;
  end;
end;

procedure TfrmSysGridColPercent.edtColorBarDblClick(Sender: TObject);
begin
  SetColor(TSpecialFunctions.GetDialogColor(StrToIntDef(edtColorBar.Text, 0)), edtColorBar);
end;

procedure TfrmSysGridColPercent.edtColorBarBackDblClick(Sender: TObject);
begin
  SetColor(TSpecialFunctions.GetDialogColor(StrToIntDef(edtColorBarBack.Text, 0)), edtColorBarBack);
end;

procedure TfrmSysGridColPercent.edtColorBarTextDblClick(Sender: TObject);
begin
  SetColor(TSpecialFunctions.GetDialogColor(StrToIntDef(edtColorBarText.Text, 0)), edtColorBarText);
end;

procedure TfrmSysGridColPercent.edtColorBarTextActiveDblClick(
  Sender: TObject);
begin
  SetColor(TSpecialFunctions.GetDialogColor(StrToIntDef(edtColorBarTextActive.Text, 0)), edtColorBarTextActive);
end;

procedure TfrmSysGridColPercent.FormCreate(Sender: TObject);
begin
  TSysGridColPercent(Table).TableName1.SetControlProperty(Table.TableName, cbbTableName);
  TSysGridColPercent(Table).ColumnName.SetControlProperty(Table.TableName, cbbColumnName);
  TSysGridColPercent(Table).MaxValue.SetControlProperty(Table.TableName, edtMaxValue);
  TSysGridColPercent(Table).ColorBar.SetControlProperty(Table.TableName, edtColorBar);
  TSysGridColPercent(Table).ColorBarBack.SetControlProperty(Table.TableName, edtColorBarBack);
  TSysGridColPercent(Table).ColorBarText.SetControlProperty(Table.TableName, edtColorBarText);
  TSysGridColPercent(Table).ColorBarTextActive.SetControlProperty(Table.TableName, edtColorBarTextActive);

  inherited;

  cbbTableName.CharCase := ecNormal;
  cbbColumnName.CharCase := ecNormal;

  TSingletonDB.GetInstance.FillTableName(TComboBox(cbbTableName));
end;

procedure TfrmSysGridColPercent.FormShow(Sender: TObject);
begin
  inherited;
  edtColorBar.ReadOnly := True;
  edtColorBarBack.ReadOnly := True;
  edtColorBarText.ReadOnly := True;
  edtColorBarTextActive.ReadOnly := True;
end;

procedure TfrmSysGridColPercent.RefreshData();
begin
  cbbTableName.ItemIndex := cbbTableName.Items.IndexOf(TSysGridColPercent(Table).TableName1.Value);
  cbbTableNameChange(cbbTableName);
  cbbColumnName.ItemIndex := cbbColumnName.Items.IndexOf(TSysGridColPercent(Table).ColumnName.Value);
  edtMaxValue.Text := TSysGridColPercent(Table).MaxValue.Value;
  edtColorBar.Text := TSysGridColPercent(Table).ColorBar.Value;
  edtColorBarBack.Text := TSysGridColPercent(Table).ColorBarBack.Value;
  edtColorBarText.Text := TSysGridColPercent(Table).ColorBarText.Value;
  edtColorBarTextActive.Text := TSysGridColPercent(Table).ColorBarTextActive.Value;

  SetColor(StrToIntDef(edtColorBar.Text, 0), edtColorBar);
  SetColor(StrToIntDef(edtColorBarBack.Text, 0), edtColorBarBack);
  SetColor(StrToIntDef(edtColorBarText.Text, 0), edtColorBarText);
  SetColor(StrToIntDef(edtColorBarTextActive.Text, 0), edtColorBarTextActive);

  DrawBar;
end;

procedure TfrmSysGridColPercent.SetColor(color: TColor; editColor: TEdit);
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
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysGridColPercent(Table).TableName1.Value := cbbTableName.Text;
      TSysGridColPercent(Table).ColumnName.Value := cbbColumnName.Text;
      TSysGridColPercent(Table).MaxValue.Value := edtMaxValue.Text;
      TSysGridColPercent(Table).ColorBar.Value := edtColorBar.Text;
      TSysGridColPercent(Table).ColorBarBack.Value := edtColorBarBack.Text;
      TSysGridColPercent(Table).ColorBarText.Value := edtColorBarText.Text;
      TSysGridColPercent(Table).ColorBarTextActive.Value := edtColorBarTextActive.Text;
      inherited;
    end;
  end
  else
  begin
    inherited;
    edtColorBar.ReadOnly := True;
    edtColorBarBack.ReadOnly := True;
    edtColorBarText.ReadOnly := True;
    edtColorBarTextActive.ReadOnly := True;
  end;
end;

end.
